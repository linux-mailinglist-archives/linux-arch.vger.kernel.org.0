Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E1C4379D3
	for <lists+linux-arch@lfdr.de>; Fri, 22 Oct 2021 17:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbhJVP0v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Oct 2021 11:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbhJVP0s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Oct 2021 11:26:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEB7C061764;
        Fri, 22 Oct 2021 08:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=SOZiH7zEvb/UAGtTABgZgYKuT53K1n/CxOiXrQNfO48=; b=NyBraLUTPb2ilfFHn8w8dMr5Em
        1TsYyhfxsFZ2KIjAVHxG8Su4Fo3MfZBmphLgp0s78zCZnafoKpv1MLXcGIPu4tIWuzlHoFotvNy1s
        Y6//9MPmxsfCs9y8iNR6ll5basA4LVdOvVAYlipOkidnkDTwlwXHQPS5zXSD+5S3DeRiNHosOPpSj
        4fEIijfLeyVdJyrdGJsaafyWfcoV143o8Sl6xbjdtgSVirDNHjLSW6XxLUX5eCx4npn4v1vSXpPm3
        sR/c2rEbuvg7pZLng/qm+wM+0U7qSE6sozgYtd/883BatBUO5LrkQHEr47FcBR0d5jGOViyEh9cvd
        LaoNJIPA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdwOE-00BbM7-Tz; Fri, 22 Oct 2021 15:23:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7765530099C;
        Fri, 22 Oct 2021 17:23:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 792D12C0CA181; Fri, 22 Oct 2021 17:23:23 +0200 (CEST)
Message-ID: <20211022152104.487919043@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 17:09:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     keescook@chromium.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, akpm@linux-foundation.org,
        mark.rutland@arm.com, zhengqi.arch@bytedance.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-arch@vger.kernel.org, ardb@kernel.org
Subject: [PATCH 6/7] arch: __get_wchan() || ARCH_STACKWALK
References: <20211022150933.883959987@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use ARCH_STACKWALK to implement a generic __get_wchan().

STACKTRACE should be possible, but the various implementations of
stack_trace_save_tsk() are not consistent enough for this to work.
ARCH_STACKWALK is a smaller set of architectures with a better defined
interface.

Since get_wchan() pins the task in a blocked state, it is not
necessary to take a reference on the task stack, the task isn't going
anywhere.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm/include/asm/processor.h     |    2 -
 arch/arm/kernel/process.c            |   22 --------------------
 arch/arm64/include/asm/processor.h   |    2 -
 arch/arm64/kernel/process.c          |   26 ------------------------
 arch/powerpc/include/asm/processor.h |    2 -
 arch/powerpc/kernel/process.c        |   37 -----------------------------------
 arch/riscv/include/asm/processor.h   |    3 --
 arch/riscv/kernel/stacktrace.c       |   21 -------------------
 arch/s390/include/asm/processor.h    |    1 
 arch/s390/kernel/process.c           |   29 ---------------------------
 arch/x86/include/asm/processor.h     |    2 -
 arch/x86/kernel/process.c            |   25 -----------------------
 kernel/sched/core.c                  |   24 ++++++++++++++++++++++
 13 files changed, 24 insertions(+), 172 deletions(-)

--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -84,8 +84,6 @@ struct task_struct;
 /* Free all resources held by a thread. */
 extern void release_thread(struct task_struct *);
 
-unsigned long __get_wchan(struct task_struct *p);
-
 #define task_pt_regs(p) \
 	((struct pt_regs *)(THREAD_START_SP + task_stack_page(p)) - 1)
 
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -276,28 +276,6 @@ int copy_thread(unsigned long clone_flag
 	return 0;
 }
 
-unsigned long __get_wchan(struct task_struct *p)
-{
-	struct stackframe frame;
-	unsigned long stack_page;
-	int count = 0;
-
-	frame.fp = thread_saved_fp(p);
-	frame.sp = thread_saved_sp(p);
-	frame.lr = 0;			/* recovered from the stack */
-	frame.pc = thread_saved_pc(p);
-	stack_page = (unsigned long)task_stack_page(p);
-	do {
-		if (frame.sp < stack_page ||
-		    frame.sp >= stack_page + THREAD_SIZE ||
-		    unwind_frame(&frame) < 0)
-			return 0;
-		if (!in_sched_functions(frame.pc))
-			return frame.pc;
-	} while (count ++ < 16);
-	return 0;
-}
-
 #ifdef CONFIG_MMU
 #ifdef CONFIG_KUSER_HELPERS
 /*
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -257,8 +257,6 @@ struct task_struct;
 /* Free all resources held by a thread. */
 extern void release_thread(struct task_struct *);
 
-unsigned long __get_wchan(struct task_struct *p);
-
 void update_sctlr_el1(u64 sctlr);
 
 /* Thread switching */
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -528,32 +528,6 @@ struct task_struct *__switch_to(struct t
 	return last;
 }
 
-unsigned long __get_wchan(struct task_struct *p)
-{
-	struct stackframe frame;
-	unsigned long stack_page, ret = 0;
-	int count = 0;
-
-	stack_page = (unsigned long)try_get_task_stack(p);
-	if (!stack_page)
-		return 0;
-
-	start_backtrace(&frame, thread_saved_fp(p), thread_saved_pc(p));
-
-	do {
-		if (unwind_frame(p, &frame))
-			goto out;
-		if (!in_sched_functions(frame.pc)) {
-			ret = frame.pc;
-			goto out;
-		}
-	} while (count++ < 16);
-
-out:
-	put_task_stack(p);
-	return ret;
-}
-
 unsigned long arch_align_stack(unsigned long sp)
 {
 	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -300,8 +300,6 @@ struct thread_struct {
 
 #define task_pt_regs(tsk)	((tsk)->thread.regs)
 
-unsigned long __get_wchan(struct task_struct *p);
-
 #define KSTK_EIP(tsk)  ((tsk)->thread.regs? (tsk)->thread.regs->nip: 0)
 #define KSTK_ESP(tsk)  ((tsk)->thread.regs? (tsk)->thread.regs->gpr[1]: 0)
 
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -2111,43 +2111,6 @@ int validate_sp(unsigned long sp, struct
 
 EXPORT_SYMBOL(validate_sp);
 
-static unsigned long ___get_wchan(struct task_struct *p)
-{
-	unsigned long ip, sp;
-	int count = 0;
-
-	sp = p->thread.ksp;
-	if (!validate_sp(sp, p, STACK_FRAME_OVERHEAD))
-		return 0;
-
-	do {
-		sp = *(unsigned long *)sp;
-		if (!validate_sp(sp, p, STACK_FRAME_OVERHEAD) ||
-		    task_is_running(p))
-			return 0;
-		if (count > 0) {
-			ip = ((unsigned long *)sp)[STACK_FRAME_LR_SAVE];
-			if (!in_sched_functions(ip))
-				return ip;
-		}
-	} while (count++ < 16);
-	return 0;
-}
-
-unsigned long __get_wchan(struct task_struct *p)
-{
-	unsigned long ret;
-
-	if (!try_get_task_stack(p))
-		return 0;
-
-	ret = ___get_wchan(p);
-
-	put_task_stack(p);
-
-	return ret;
-}
-
 static int kstack_depth_to_print = CONFIG_PRINT_STACK_DEPTH;
 
 void __no_sanitize_address show_stack(struct task_struct *tsk,
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -66,9 +66,6 @@ static inline void release_thread(struct
 {
 }
 
-extern unsigned long __get_wchan(struct task_struct *p);
-
-
 static inline void wait_for_interrupt(void)
 {
 	__asm__ __volatile__ ("wfi");
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -118,27 +118,6 @@ void show_stack(struct task_struct *task
 	dump_backtrace(NULL, task, loglvl);
 }
 
-static bool save_wchan(void *arg, unsigned long pc)
-{
-	if (!in_sched_functions(pc)) {
-		unsigned long *p = arg;
-		*p = pc;
-		return false;
-	}
-	return true;
-}
-
-unsigned long __get_wchan(struct task_struct *task)
-{
-	unsigned long pc = 0;
-
-	if (!try_get_task_stack(task))
-		return 0;
-	walk_stackframe(task, NULL, save_wchan, &pc);
-	put_task_stack(task);
-	return pc;
-}
-
 noinline void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 		     struct task_struct *task, struct pt_regs *regs)
 {
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -192,7 +192,6 @@ static inline void release_thread(struct
 void guarded_storage_release(struct task_struct *tsk);
 void gs_load_bc_cb(struct pt_regs *regs);
 
-unsigned long __get_wchan(struct task_struct *p);
 #define task_pt_regs(tsk) ((struct pt_regs *) \
         (task_stack_page(tsk) + THREAD_SIZE) - 1)
 #define KSTK_EIP(tsk)	(task_pt_regs(tsk)->psw.addr)
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -181,35 +181,6 @@ void execve_tail(void)
 	asm volatile("sfpc %0" : : "d" (0));
 }
 
-unsigned long __get_wchan(struct task_struct *p)
-{
-	struct unwind_state state;
-	unsigned long ip = 0;
-
-	if (!task_stack_page(p))
-		return 0;
-
-	if (!try_get_task_stack(p))
-		return 0;
-
-	unwind_for_each_frame(&state, p, NULL, 0) {
-		if (state.stack_info.type != STACK_TYPE_TASK) {
-			ip = 0;
-			break;
-		}
-
-		ip = unwind_get_return_address(&state);
-		if (!ip)
-			break;
-
-		if (!in_sched_functions(ip))
-			break;
-	}
-
-	put_task_stack(p);
-	return ip;
-}
-
 unsigned long arch_align_stack(unsigned long sp)
 {
 	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -588,8 +588,6 @@ static inline void load_sp0(unsigned lon
 /* Free all resources held by a thread. */
 extern void release_thread(struct task_struct *);
 
-unsigned long __get_wchan(struct task_struct *p);
-
 /*
  * Generic CPUID function
  * clear %ecx since some cpus (Cyrix MII) do not set or clear %ecx
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -43,7 +43,6 @@
 #include <asm/io_bitmap.h>
 #include <asm/proto.h>
 #include <asm/frame.h>
-#include <asm/unwind.h>
 
 #include "process.h"
 
@@ -942,30 +941,6 @@ unsigned long arch_randomize_brk(struct
 	return randomize_page(mm->brk, 0x02000000);
 }
 
-/*
- * Called from fs/proc with a reference on @p to find the function
- * which called into schedule(). This needs to be done carefully
- * because the task might wake up and we might look at a stack
- * changing under us.
- */
-unsigned long __get_wchan(struct task_struct *p)
-{
-	struct unwind_state state;
-	unsigned long addr = 0;
-
-	for (unwind_start(&state, p, NULL, NULL); !unwind_done(&state);
-	     unwind_next_frame(&state)) {
-		addr = unwind_get_return_address(&state);
-		if (!addr)
-			break;
-		if (in_sched_functions(addr))
-			continue;
-		break;
-	}
-
-	return addr;
-}
-
 long do_arch_prctl_common(struct task_struct *task, int option,
 			  unsigned long cpuid_enabled)
 {
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1966,6 +1966,30 @@ bool sched_task_on_rq(struct task_struct
 	return task_on_rq_queued(p);
 }
 
+#ifdef CONFIG_ARCH_STACKWALK
+
+static bool consume_wchan(void *cookie, unsigned long addr)
+{
+	unsigned long *wchan = cookie;
+
+	if (in_sched_functions(addr))
+		return true;
+
+	*wchan = addr;
+	return false;
+}
+
+static unsigned long __get_wchan(struct task_struct *p)
+{
+	unsigned long wchan = 0;
+
+	arch_stack_walk(consume_wchan, &wchan, p, NULL);
+
+	return wchan;
+}
+
+#endif /* CONFIG_ARCH_STACKWALK */
+
 static int try_get_wchan(struct task_struct *p, void *arg)
 {
 	unsigned long *wchan = arg;


