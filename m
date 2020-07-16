Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDABC222C32
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 21:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbgGPTus (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 15:50:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35246 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbgGPTur (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 15:50:47 -0400
Message-Id: <20200716185424.011950288@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594929043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=IR3XLMzlMIVsyZTFeP3Anvt5KzF7MuEmK/Q7BPDXqmc=;
        b=OnDYOzRmeE7nqK/J2OoONv6Zsdr+FwRdTOZLnGKBgHoGoVE1tKlBmGjRIvUUfYRqzMVHWV
        VCECtSa+Ab91J3CDrU+Idkwki/N+LruCBPiT6qujD5GWVicP6rIgPpU3/QecRhX82l0GdY
        d17gkrFn0L4Qnb7V9guJZvMRXNuYZqMLjXqqQys0y0QQNhNMV1BwjYDOqU5YqNPZA1O6UU
        7tczlkfYItK8kWJS/mXPrD30Bq5NDj2nGWPT1ce7UCQYkHAH39H9spJrNsch3QL2dzYHFc
        agkdmG2zqkP8E8c01rE/uveDKbqEeUzF4zgQQnNQ1hVEtU5z9EIfPBpUWpzh+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594929043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=IR3XLMzlMIVsyZTFeP3Anvt5KzF7MuEmK/Q7BPDXqmc=;
        b=6KRLHLBQ90TMjrFTaI0Ux1Clquu8kJ1lvIiEmlWKLz/rWHXCig8p0+VKnCvm7qHU4aJVpQ
        haTNazrp8vNCwAAA==
Date:   Thu, 16 Jul 2020 20:22:09 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [patch V3 01/13] entry: Provide generic syscall entry functionality
References: <20200716182208.180916541@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

On syscall entry certain work needs to be done:

   - Establish state (lockdep, context tracking, tracing)
   - Conditional work (ptrace, seccomp, audit...)

This code is needlessly duplicated and  different in all
architectures.

Provide a generic version based on the x86 implementation which has all the
RCU and instrumentation bits right.

As interrupt/exception entry from user space needs parts of the same
functionality, provide a function for this as well.

syscall_enter_from_user_mode() and irqentry_enter_from_user_mode() must be
called right after the low level ASM entry. The calling code must be
non-instrumentable. After the functions returns state is correct and the
subsequent functions can be instrumented.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Adapt to noinstr changes. Add interrupt/exception entry function.

V2: Fix function documentation (Mike)
    Add comment about return value (Andy)
---
 arch/Kconfig                 |    3 
 include/linux/entry-common.h |  156 +++++++++++++++++++++++++++++++++++++++++++
 kernel/Makefile              |    1 
 kernel/entry/Makefile        |    3 
 kernel/entry/common.c        |   78 +++++++++++++++++++++
 5 files changed, 241 insertions(+)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -27,6 +27,9 @@ config HAVE_IMA_KEXEC
 config HOTPLUG_SMT
 	bool
 
+config GENERIC_ENTRY
+       bool
+
 config OPROFILE
 	tristate "OProfile system profiling"
 	depends on PROFILING
--- /dev/null
+++ b/include/linux/entry-common.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_ENTRYCOMMON_H
+#define __LINUX_ENTRYCOMMON_H
+
+#include <linux/tracehook.h>
+#include <linux/syscalls.h>
+#include <linux/seccomp.h>
+#include <linux/sched.h>
+
+#include <asm/entry-common.h>
+
+/*
+ * Define dummy _TIF work flags if not defined by the architecture or for
+ * disabled functionality.
+ */
+#ifndef _TIF_SYSCALL_TRACE
+# define _TIF_SYSCALL_TRACE		(0)
+#endif
+
+#ifndef _TIF_SYSCALL_EMU
+# define _TIF_SYSCALL_EMU		(0)
+#endif
+
+#ifndef _TIF_SYSCALL_TRACEPOINT
+# define _TIF_SYSCALL_TRACEPOINT	(0)
+#endif
+
+#ifndef _TIF_SECCOMP
+# define _TIF_SECCOMP			(0)
+#endif
+
+#ifndef _TIF_AUDIT
+# define _TIF_AUDIT			(0)
+#endif
+
+/*
+ * TIF flags handled in syscall_enter_from_usermode()
+ */
+#ifndef ARCH_SYSCALL_ENTER_WORK
+# define ARCH_SYSCALL_ENTER_WORK	(0)
+#endif
+
+#define SYSCALL_ENTER_WORK						\
+	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | TIF_SECCOMP |	\
+	 _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_EMU |			\
+	 ARCH_SYSCALL_ENTER_WORK)
+
+/**
+ * arch_check_user_regs - Architecture specific sanity check for user mode regs
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Defaults to an empty implementation. Can be replaced by architecture
+ * specific code.
+ *
+ * Invoked from syscall_enter_from_user_mode() in the non-instrumentable
+ * section. Use __always_inline so the compiler cannot push it out of line
+ * and make it instrumentable.
+ */
+static __always_inline void arch_check_user_regs(struct pt_regs *regs);
+
+#ifndef arch_check_user_regs
+static __always_inline void arch_check_user_regs(struct pt_regs *regs) {}
+#endif
+
+/**
+ * arch_syscall_enter_tracehook - Wrapper around tracehook_report_syscall_entry()
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Returns: 0 on success or an error code to skip the syscall.
+ *
+ * Defaults to tracehook_report_syscall_entry(). Can be replaced by
+ * architecture specific code.
+ *
+ * Invoked from syscall_enter_from_user_mode()
+ */
+static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs);
+
+#ifndef arch_syscall_enter_tracehook
+static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs)
+{
+	return tracehook_report_syscall_entry(regs);
+}
+#endif
+
+/**
+ * arch_syscall_enter_seccomp - Architecture specific seccomp invocation
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Returns: The original or a modified syscall number
+ *
+ * Invoked from syscall_enter_from_user_mode(). Can be replaced by
+ * architecture specific code.
+ */
+static inline long arch_syscall_enter_seccomp(struct pt_regs *regs);
+
+#ifndef arch_syscall_enter_seccomp
+static inline long arch_syscall_enter_seccomp(struct pt_regs *regs)
+{
+	return secure_computing(NULL);
+}
+#endif
+
+/**
+ * arch_syscall_enter_audit - Architecture specific audit invocation
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Invoked from syscall_enter_from_user_mode(). Must be replaced by
+ * architecture specific code if the architecture supports audit.
+ */
+static inline void arch_syscall_enter_audit(struct pt_regs *regs);
+
+#ifndef arch_syscall_enter_audit
+static inline void arch_syscall_enter_audit(struct pt_regs *regs) { }
+#endif
+
+/**
+ * syscall_enter_from_user_mode - Check and handle work before invoking
+ *				 a syscall
+ * @regs:	Pointer to currents pt_regs
+ * @syscall:	The syscall number
+ *
+ * Invoked from architecture specific syscall entry code with interrupts
+ * disabled. The calling code has to be non-instrumentable. When the
+ * function returns all state is correct and the subsequent functions can be
+ * instrumented.
+ *
+ * Returns: The original or a modified syscall number
+ *
+ * If the returned syscall number is -1 then the syscall should be
+ * skipped. In this case the caller may invoke syscall_set_error() or
+ * syscall_set_return_value() first.  If neither of those are called and -1
+ * is returned, then the syscall will fail with ENOSYS.
+ *
+ * The following functionality is handled here:
+ *
+ *  1) Establish state (lockdep, RCU (context tracking), tracing)
+ *  2) TIF flag dependent invocations of arch_syscall_enter_tracehook(),
+ *     arch_syscall_enter_seccomp(), trace_sys_enter()
+ *  3) Invocation of arch_syscall_enter_audit()
+ */
+long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall);
+
+/**
+ * irqentry_enter_from_user_mode - Establish state before invoking the irq handler
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Invoked from architecture specific entry code with interrupts disabled.
+ * Can only be called when the interrupt entry came from user mode. The
+ * calling code must be non-instrumentable.  When the function returns all
+ * state is correct and the subsequent functions can be instrumented.
+ *
+ * The function establishes state (lockdep, RCU (context tracking), tracing)
+ */
+void irqentry_enter_from_user_mode(struct pt_regs *regs);
+
+#endif
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -48,6 +48,7 @@ obj-y += irq/
 obj-y += rcu/
 obj-y += livepatch/
 obj-y += dma/
+obj-y += entry/
 
 obj-$(CONFIG_CHECKPOINT_RESTORE) += kcmp.o
 obj-$(CONFIG_FREEZER) += freezer.o
--- /dev/null
+++ b/kernel/entry/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_GENERIC_ENTRY) += common.o
--- /dev/null
+++ b/kernel/entry/common.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/context_tracking.h>
+#include <linux/entry-common.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/syscalls.h>
+
+/**
+ * enter_from_user_mode - Establish state when coming from user mode
+ *
+ * Syscall/interrupt entry disables interrupts, but user mode is traced as
+ * interrupts enabled. Also with NO_HZ_FULL RCU might be idle.
+ *
+ * 1) Tell lockdep that interrupts are disabled
+ * 2) Invoke context tracking if enabled to reactivate RCU
+ * 3) Trace interrupts off state
+ */
+static __always_inline void enter_from_user_mode(struct pt_regs *regs)
+{
+	arch_check_user_regs(regs);
+	lockdep_hardirqs_off(CALLER_ADDR0);
+
+	CT_WARN_ON(ct_state() != CONTEXT_USER);
+	user_exit_irqoff();
+
+	instrumentation_begin();
+	trace_hardirqs_off_finish();
+	instrumentation_end();
+}
+
+static long syscall_trace_enter(struct pt_regs *regs, long syscall,
+				unsigned long ti_work)
+{
+	long ret = 0;
+
+	/* Handle ptrace */
+	if (ti_work & (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU)) {
+		ret = arch_syscall_enter_tracehook(regs);
+		if (ret || (ti_work & _TIF_SYSCALL_EMU))
+			return -1L;
+	}
+
+	/* Do seccomp after ptrace, to catch any tracer changes. */
+	if (ti_work & _TIF_SECCOMP) {
+		ret = arch_syscall_enter_seccomp(regs);
+		if (ret == -1L)
+			return ret;
+	}
+
+	if (unlikely(ti_work & _TIF_SYSCALL_TRACEPOINT))
+		trace_sys_enter(regs, syscall);
+
+	arch_syscall_enter_audit(regs);
+
+	return ret ? : syscall;
+}
+
+noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
+{
+	unsigned long ti_work;
+
+	enter_from_user_mode(regs);
+	instrumentation_begin();
+
+	local_irq_enable();
+	ti_work = READ_ONCE(current_thread_info()->flags);
+	if (ti_work & SYSCALL_ENTER_WORK)
+		syscall = syscall_trace_enter(regs, syscall, ti_work);
+	instrumentation_end();
+
+	return syscall;
+}
+
+noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
+{
+	enter_from_user_mode(regs);
+}

