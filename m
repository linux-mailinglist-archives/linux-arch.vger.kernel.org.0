Return-Path: <linux-arch+bounces-14778-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CEBC5E06C
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 16:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 234E33843BC
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 15:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9002532D0FC;
	Fri, 14 Nov 2025 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAnBF/pK"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5781E285A
	for <linux-arch@vger.kernel.org>; Fri, 14 Nov 2025 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763133357; cv=none; b=RGXT8bevnqBCc8dnoBOIrk+HAb3ly8JersUJ+ikWpy48pJ6Vu9dVa1ieOqptC/OKfkSQyMUN4X2FRf9Fo6QHtp+a0ZOsrGcYJtcaNRDd2S5ZBfCqmtZC16584yUZ15HL+EW79mlM4cXANcPH1ggVu9AVcTJIcP+pdAEFo7N3nxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763133357; c=relaxed/simple;
	bh=3vFmGwJ4O5d18d/9pF4r2lPh/GybRx9YL4exPV4e8rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTzrz8m+0SpyjcyTtZCwEzoSaC6vMlQBvEkk0m0Ad63bD1bloJFXf/OFFzJLP2dxAlxiMoa+boFn4OC1zGz9U/esNk5L1nsSC7PMa66w2ijCnh9962l7iRYpg8uMKtYd8C1Rp47PN2KYRQwDLiKIgXnk//OafB7xYNR4GYqKli4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GAnBF/pK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763133354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9qexTOcRzn1ACshFlnrwwbGyyms8r6ia30n/LGo1pE=;
	b=GAnBF/pK/h+9dxQCiTgD/bGtoq5deYu/rIdCBVVxl5f/XslmFjwK3baRbegzbT2+pJlLP4
	LzUgRwE6HUaKhOE7DgJsFbVurGX7b5UJk4mN6VGUSjlvfl2aozh+HhbXYame0PxDwbDBpJ
	ldEnqEeJjwS5NzfjmeiOVxY13aFAxC8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-udY8E4xTMwOi_pI-KC5J3g-1; Fri,
 14 Nov 2025 10:15:51 -0500
X-MC-Unique: udY8E4xTMwOi_pI-KC5J3g-1
X-Mimecast-MFC-AGG-ID: udY8E4xTMwOi_pI-KC5J3g_1763133341
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B966195608D;
	Fri, 14 Nov 2025 15:15:41 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.45.226.10])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C10D1800451;
	Fri, 14 Nov 2025 15:15:25 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rcu@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenzju@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Han Shen <shenhan@google.com>,
	Rik van Riel <riel@surriel.com>,
	Jann Horn <jannh@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Petr Tesarik <ptesarik@suse.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH v7 24/31] context-tracking: Introduce work deferral infrastructure
Date: Fri, 14 Nov 2025 16:14:21 +0100
Message-ID: <20251114151428.1064524-4-vschneid@redhat.com>
In-Reply-To: <20251114150133.1056710-1-vschneid@redhat.com>
References: <20251114150133.1056710-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

smp_call_function() & friends have the unfortunate habit of sending IPIs to
isolated, NOHZ_FULL, in-userspace CPUs, as they blindly target all online
CPUs.

Some callsites can be bent into doing the right, such as done by commit:

  cc9e303c91f5 ("x86/cpu: Disable frequency requests via aperfmperf IPI for nohz_full CPUs")

Unfortunately, not all SMP callbacks can be omitted in this
fashion. However, some of them only affect execution in kernelspace, which
means they don't have to be executed *immediately* if the target CPU is in
userspace: stashing the callback and executing it upon the next kernel entry
would suffice. x86 kernel instruction patching or kernel TLB invalidation
are prime examples of it.

Reduce the RCU dynticks counter width to free up some bits to be used as a
deferred callback bitmask. Add some build-time checks to validate that
setup.

Presence of CT_RCU_WATCHING in the ct_state prevents queuing deferred work.

Later commits introduce the bit:callback mappings.

Link: https://lore.kernel.org/all/20210929151723.162004989@infradead.org/
Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 arch/Kconfig                                 |  9 +++
 arch/x86/Kconfig                             |  1 +
 arch/x86/include/asm/context_tracking_work.h | 16 +++++
 include/linux/context_tracking.h             | 21 ++++++
 include/linux/context_tracking_state.h       | 30 +++++---
 include/linux/context_tracking_work.h        | 24 +++++++
 kernel/context_tracking.c                    | 72 +++++++++++++++++++-
 kernel/time/Kconfig                          |  5 ++
 8 files changed, 166 insertions(+), 12 deletions(-)
 create mode 100644 arch/x86/include/asm/context_tracking_work.h
 create mode 100644 include/linux/context_tracking_work.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 61130b88964b9..6cc3965b8c9eb 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1024,6 +1024,15 @@ config HAVE_CONTEXT_TRACKING_USER_OFFSTACK
 	  - No use of instrumentation, unless instrumentation_begin() got
 	    called.
 
+config HAVE_CONTEXT_TRACKING_WORK
+	bool
+	help
+	  Architecture supports deferring work while not in kernel context.
+	  This is especially useful on setups with isolated CPUs that might
+	  want to avoid being interrupted to perform housekeeping tasks (for
+	  ex. TLB invalidation or icache invalidation). The housekeeping
+	  operations are performed upon re-entering the kernel.
+
 config HAVE_TIF_NOHZ
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fa3b616af03a2..fa9229c0e0939 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -219,6 +219,7 @@ config X86
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_CONTEXT_TRACKING_USER		if X86_64
 	select HAVE_CONTEXT_TRACKING_USER_OFFSTACK	if HAVE_CONTEXT_TRACKING_USER
+	select HAVE_CONTEXT_TRACKING_WORK		if X86_64
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_OBJTOOL_MCOUNT		if HAVE_OBJTOOL
 	select HAVE_OBJTOOL_NOP_MCOUNT		if HAVE_OBJTOOL_MCOUNT
diff --git a/arch/x86/include/asm/context_tracking_work.h b/arch/x86/include/asm/context_tracking_work.h
new file mode 100644
index 0000000000000..5f3b2d0977235
--- /dev/null
+++ b/arch/x86/include/asm/context_tracking_work.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_CONTEXT_TRACKING_WORK_H
+#define _ASM_X86_CONTEXT_TRACKING_WORK_H
+
+static __always_inline void arch_context_tracking_work(enum ct_work work)
+{
+	switch (work) {
+	case CT_WORK_n:
+		// Do work...
+		break;
+	case CT_WORK_MAX:
+		WARN_ON_ONCE(true);
+	}
+}
+
+#endif
diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index af9fe87a09225..0b0faa040e9b5 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -5,6 +5,7 @@
 #include <linux/sched.h>
 #include <linux/vtime.h>
 #include <linux/context_tracking_state.h>
+#include <linux/context_tracking_work.h>
 #include <linux/instrumentation.h>
 
 #include <asm/ptrace.h>
@@ -137,6 +138,26 @@ static __always_inline unsigned long ct_state_inc(int incby)
 	return raw_atomic_add_return(incby, this_cpu_ptr(&context_tracking.state));
 }
 
+#ifdef CONFIG_CONTEXT_TRACKING_WORK
+static __always_inline unsigned long ct_state_inc_clear_work(int incby)
+{
+	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
+	unsigned long new, old, state;
+
+	state = arch_atomic_read(&ct->state);
+	do {
+		old = state;
+		new = old & ~CT_WORK_MASK;
+		new += incby;
+		state = arch_atomic_cmpxchg(&ct->state, old, new);
+	} while (old != state);
+
+	return new;
+}
+#else
+#define ct_state_inc_clear_work(x) ct_state_inc(x)
+#endif
+
 static __always_inline bool warn_rcu_enter(void)
 {
 	bool ret = false;
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 0b81248aa03e2..d2c302133672f 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -5,6 +5,7 @@
 #include <linux/percpu.h>
 #include <linux/static_key.h>
 #include <linux/context_tracking_irq.h>
+#include <linux/context_tracking_work.h>
 
 /* Offset to allow distinguishing irq vs. task-based idle entry/exit. */
 #define CT_NESTING_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
@@ -39,16 +40,19 @@ struct context_tracking {
 };
 
 /*
- * We cram two different things within the same atomic variable:
+ * We cram up to three different things within the same atomic variable:
  *
- *                     CT_RCU_WATCHING_START  CT_STATE_START
- *                                |                |
- *                                v                v
- *     MSB [ RCU watching counter ][ context_state ] LSB
- *         ^                       ^
- *         |                       |
- * CT_RCU_WATCHING_END        CT_STATE_END
+ *                     CT_RCU_WATCHING_START                  CT_STATE_START
+ *                                |         CT_WORK_START          |
+ *                                |               |                |
+ *                                v               v                v
+ *     MSB [ RCU watching counter ][ context work ][ context_state ] LSB
+ *         ^                       ^               ^
+ *         |                       |               |
+ *         |                  CT_WORK_END          |
+ * CT_RCU_WATCHING_END                        CT_STATE_END
  *
+ * The [ context work ] region spans 0 bits if CONFIG_CONTEXT_WORK=n
  * Bits are used from the LSB upwards, so unused bits (if any) will always be in
  * upper bits of the variable.
  */
@@ -59,18 +63,24 @@ struct context_tracking {
 #define CT_STATE_START 0
 #define CT_STATE_END   (CT_STATE_START + CT_STATE_WIDTH - 1)
 
-#define CT_RCU_WATCHING_MAX_WIDTH (CT_SIZE - CT_STATE_WIDTH)
+#define CT_WORK_WIDTH (IS_ENABLED(CONFIG_CONTEXT_TRACKING_WORK) ? CT_WORK_MAX_OFFSET : 0)
+#define	CT_WORK_START (CT_STATE_END + 1)
+#define CT_WORK_END   (CT_WORK_START + CT_WORK_WIDTH - 1)
+
+#define CT_RCU_WATCHING_MAX_WIDTH (CT_SIZE - CT_WORK_WIDTH - CT_STATE_WIDTH)
 #define CT_RCU_WATCHING_WIDTH     (IS_ENABLED(CONFIG_RCU_DYNTICKS_TORTURE) ? 2 : CT_RCU_WATCHING_MAX_WIDTH)
-#define CT_RCU_WATCHING_START     (CT_STATE_END + 1)
+#define CT_RCU_WATCHING_START     (CT_WORK_END + 1)
 #define CT_RCU_WATCHING_END       (CT_RCU_WATCHING_START + CT_RCU_WATCHING_WIDTH - 1)
 #define CT_RCU_WATCHING           BIT(CT_RCU_WATCHING_START)
 
 #define CT_STATE_MASK        GENMASK(CT_STATE_END,        CT_STATE_START)
+#define CT_WORK_MASK         GENMASK(CT_WORK_END,         CT_WORK_START)
 #define CT_RCU_WATCHING_MASK GENMASK(CT_RCU_WATCHING_END, CT_RCU_WATCHING_START)
 
 #define CT_UNUSED_WIDTH (CT_RCU_WATCHING_MAX_WIDTH - CT_RCU_WATCHING_WIDTH)
 
 static_assert(CT_STATE_WIDTH        +
+	      CT_WORK_WIDTH         +
 	      CT_RCU_WATCHING_WIDTH +
 	      CT_UNUSED_WIDTH       ==
 	      CT_SIZE);
diff --git a/include/linux/context_tracking_work.h b/include/linux/context_tracking_work.h
new file mode 100644
index 0000000000000..3742f461183ac
--- /dev/null
+++ b/include/linux/context_tracking_work.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CONTEXT_TRACKING_WORK_H
+#define _LINUX_CONTEXT_TRACKING_WORK_H
+
+#include <linux/bitops.h>
+
+enum {
+	CT_WORK_n_OFFSET,
+	CT_WORK_MAX_OFFSET
+};
+
+enum ct_work {
+	CT_WORK_n        = BIT(CT_WORK_n_OFFSET),
+	CT_WORK_MAX      = BIT(CT_WORK_MAX_OFFSET)
+};
+
+#ifdef CONFIG_CONTEXT_TRACKING_WORK
+extern bool ct_set_cpu_work(unsigned int cpu, enum ct_work work);
+#else
+static inline bool
+ct_set_cpu_work(unsigned int cpu, unsigned int work) { return false; }
+#endif
+
+#endif
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index fb5be6e9b423f..5a3cc4ce4d8a6 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -25,6 +25,9 @@
 #include <linux/kprobes.h>
 #include <trace/events/rcu.h>
 
+#ifdef CONFIG_CONTEXT_TRACKING_WORK
+#include <asm/context_tracking_work.h>
+#endif
 
 DEFINE_PER_CPU(struct context_tracking, context_tracking) = {
 #ifdef CONFIG_CONTEXT_TRACKING_IDLE
@@ -72,6 +75,70 @@ static __always_inline void rcu_task_trace_heavyweight_exit(void)
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 }
 
+#ifdef CONFIG_CONTEXT_TRACKING_WORK
+static noinstr void ct_work_flush(unsigned long seq)
+{
+	int bit;
+
+	seq = (seq & CT_WORK_MASK) >> CT_WORK_START;
+
+	/*
+	 * arch_context_tracking_work() must be noinstr, non-blocking,
+	 * and NMI safe.
+	 */
+	for_each_set_bit(bit, &seq, CT_WORK_MAX)
+		arch_context_tracking_work(BIT(bit));
+}
+
+/**
+ * ct_set_cpu_work - set work to be run at next kernel context entry
+ *
+ * If @cpu is not currently executing in kernelspace, it will execute the
+ * callback mapped to @work (see arch_context_tracking_work()) at its next
+ * entry into ct_kernel_enter_state().
+ *
+ * If it is already executing in kernelspace, this will be a no-op.
+ */
+bool ct_set_cpu_work(unsigned int cpu, enum ct_work work)
+{
+	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
+	unsigned int old;
+	bool ret = false;
+
+	if (!ct->active)
+		return false;
+
+	preempt_disable();
+
+	old = atomic_read(&ct->state);
+
+	/*
+	 * The work bit must only be set if the target CPU is not executing
+	 * in kernelspace.
+	 * CT_RCU_WATCHING is used as a proxy for that - if the bit is set, we
+	 * know for sure the CPU is executing in the kernel whether that be in
+	 * NMI, IRQ or process context.
+	 * Clear CT_RCU_WATCHING here and let the cmpxchg do the check for us;
+	 * the state could change between the atomic_read() and the cmpxchg().
+	 */
+	old &= ~CT_RCU_WATCHING;
+	/*
+	 * Try setting the work until either
+	 * - the target CPU has entered kernelspace
+	 * - the work has been set
+	 */
+	do {
+		ret = atomic_try_cmpxchg(&ct->state, &old, old | (work << CT_WORK_START));
+	} while (!ret && !(old & CT_RCU_WATCHING));
+
+	preempt_enable();
+	return ret;
+}
+#else
+static __always_inline void ct_work_flush(unsigned long work) { }
+static __always_inline void ct_work_clear(struct context_tracking *ct) { }
+#endif
+
 /*
  * Record entry into an extended quiescent state.  This is only to be
  * called when not already in an extended quiescent state, that is,
@@ -88,7 +155,7 @@ static noinstr void ct_kernel_exit_state(int offset)
 	rcu_task_trace_heavyweight_enter();  // Before CT state update!
 	// RCU is still watching.  Better not be in extended quiescent state!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !rcu_is_watching_curr_cpu());
-	(void)ct_state_inc(offset);
+	(void)ct_state_inc_clear_work(offset);
 	// RCU is no longer watching.
 }
 
@@ -99,7 +166,7 @@ static noinstr void ct_kernel_exit_state(int offset)
  */
 static noinstr void ct_kernel_enter_state(int offset)
 {
-	int seq;
+	unsigned long seq;
 
 	/*
 	 * CPUs seeing atomic_add_return() must see prior idle sojourns,
@@ -107,6 +174,7 @@ static noinstr void ct_kernel_enter_state(int offset)
 	 * critical section.
 	 */
 	seq = ct_state_inc(offset);
+	ct_work_flush(seq);
 	// RCU is now watching.  Better not be in an extended quiescent state!
 	rcu_task_trace_heavyweight_exit();  // After CT state update!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !(seq & CT_RCU_WATCHING));
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 7c6a52f7836ce..1a0c027aad141 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -181,6 +181,11 @@ config CONTEXT_TRACKING_USER_FORCE
 	  Say N otherwise, this option brings an overhead that you
 	  don't want in production.
 
+config CONTEXT_TRACKING_WORK
+	bool
+	depends on HAVE_CONTEXT_TRACKING_WORK && CONTEXT_TRACKING_USER
+	default y
+
 config NO_HZ
 	bool "Old Idle dynticks config"
 	help
-- 
2.51.0


