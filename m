Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2C64268A3
	for <lists+linux-arch@lfdr.de>; Fri,  8 Oct 2021 13:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240222AbhJHLYQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Oct 2021 07:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240126AbhJHLYP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Oct 2021 07:24:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61ACC061570
        for <linux-arch@vger.kernel.org>; Fri,  8 Oct 2021 04:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=p3MnJb0p9zTh2pF0k74z5BzLOqVP4rkZtcQsJlUtZOQ=; b=EnPA9VBnM3lkvloqgPA+1PWc7C
        dmVWHpR6AVmTcBnUH0v7L0ujtOlrx+UVObLkZh1bHoF4+emArAIpiPv7VL+L/HljGE71rZkjv2hCG
        bGflkUO+tjjc7RmSQceM56wVMsp6KgA4fbc44APtXcuC4Jj2uMbbJT+XIYLITMFbGJZ/v+vq83/Od
        qduy950KdUIMw/4h+oKGciL5OLOsh2zoOAXI/7cDAuaYVJKCJiSk5KKT+dFn7qDKwX1lgOAA0ofb7
        TyqLC15mrihVL/6/P1xukDeSc2Q8lyMKwE2geWKXLPTJ1c2o4XQIYsppVfOQzIyHLiRCOfyODEesC
        CH7L05Eg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYnsH-0032fs-Jm; Fri, 08 Oct 2021 11:17:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B343B302D3E;
        Fri,  8 Oct 2021 13:17:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EC8112DB84A6B; Fri,  8 Oct 2021 13:17:07 +0200 (CEST)
Message-ID: <20211008111626.392918519@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 08 Oct 2021 13:15:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     keescook@chromium.org, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        vcaputo@pengaru.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, amistry@google.com,
        Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, mhocko@suse.com, deller@gmx.de,
        zhengqi.arch@bytedance.com, me@tobin.cc, tycho@tycho.pizza,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com,
        mark.rutland@arm.com, axboe@kernel.dk, metze@samba.org,
        laijs@linux.alibaba.com, luto@kernel.org,
        dave.hansen@linux.intel.com, ebiederm@xmission.com,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, jpoimboe@redhat.com,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        vgupta@kernel.org, linux@armlinux.org.uk, will@kernel.org,
        guoren@kernel.org, bcain@codeaurora.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        jonas@southpole.se, mpe@ellerman.id.au, paul.walmsley@sifive.com,
        hca@linux.ibm.com, ysato@users.sourceforge.jp, davem@davemloft.net,
        chris@zankel.net
Subject: [PATCH 6/7] arch: __get_wchan || STACKTRACE_SUPPORT
References: <20211008111527.438276127@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It's trivial to implement __get_wchan() with CONFIG_STACKTRACE

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arc/include/asm/processor.h        |    2 -
 arch/arc/kernel/stacktrace.c            |   17 --------------
 arch/arm/include/asm/processor.h        |    2 -
 arch/arm/kernel/process.c               |   22 -------------------
 arch/arm64/include/asm/processor.h      |    2 -
 arch/arm64/kernel/process.c             |   26 ----------------------
 arch/csky/include/asm/processor.h       |    2 -
 arch/csky/kernel/stacktrace.c           |   18 ---------------
 arch/hexagon/include/asm/processor.h    |    3 --
 arch/hexagon/kernel/process.c           |   26 ----------------------
 arch/ia64/include/asm/processor.h       |    3 --
 arch/ia64/kernel/process.c              |   28 ------------------------
 arch/microblaze/include/asm/processor.h |    2 -
 arch/microblaze/kernel/process.c        |    6 -----
 arch/mips/include/asm/processor.h       |    2 -
 arch/mips/kernel/process.c              |   27 -----------------------
 arch/nds32/include/asm/processor.h      |    2 -
 arch/nds32/kernel/process.c             |   23 -------------------
 arch/openrisc/include/asm/processor.h   |    1 
 arch/openrisc/kernel/process.c          |    6 -----
 arch/parisc/include/asm/processor.h     |    2 -
 arch/parisc/kernel/process.c            |   24 --------------------
 arch/powerpc/include/asm/processor.h    |    2 -
 arch/powerpc/kernel/process.c           |   37 --------------------------------
 arch/riscv/include/asm/processor.h      |    3 --
 arch/riscv/kernel/stacktrace.c          |   21 ------------------
 arch/s390/include/asm/processor.h       |    1 
 arch/s390/kernel/process.c              |   29 -------------------------
 arch/sh/include/asm/processor_32.h      |    2 -
 arch/sh/kernel/process_32.c             |   19 ----------------
 arch/sparc/include/asm/processor_64.h   |    2 -
 arch/sparc/kernel/process_64.c          |   28 ------------------------
 arch/um/include/asm/processor-generic.h |    1 
 arch/um/kernel/process.c                |   32 ---------------------------
 arch/x86/include/asm/processor.h        |    2 -
 arch/x86/kernel/process.c               |   14 ------------
 arch/xtensa/include/asm/processor.h     |    2 -
 arch/xtensa/kernel/process.c            |   29 -------------------------
 kernel/sched/core.c                     |   15 ++++++++++++
 lib/Kconfig.debug                       |    7 ------
 40 files changed, 16 insertions(+), 476 deletions(-)

--- a/arch/arc/include/asm/processor.h
+++ b/arch/arc/include/asm/processor.h
@@ -70,8 +70,6 @@ struct task_struct;
 extern void start_thread(struct pt_regs * regs, unsigned long pc,
 			 unsigned long usp);
 
-extern unsigned int __get_wchan(struct task_struct *p);
-
 #endif /* !__ASSEMBLY__ */
 
 /*
--- a/arch/arc/kernel/stacktrace.c
+++ b/arch/arc/kernel/stacktrace.c
@@ -217,14 +217,6 @@ static int __collect_all_but_sched(unsig
 
 #endif
 
-static int __get_first_nonsched(unsigned int address, void *unused)
-{
-	if (in_sched_functions(address))
-		return 0;
-
-	return -1;
-}
-
 /*-------------------------------------------------------------------------
  *              APIs expected by various kernel sub-systems
  *-------------------------------------------------------------------------
@@ -244,15 +236,6 @@ void show_stack(struct task_struct *tsk,
 	show_stacktrace(tsk, NULL, loglvl);
 }
 
-/* Another API expected by schedular, shows up in "ps" as Wait Channel
- * Of course just returning schedule( ) would be pointless so unwind until
- * the function is not in schedular code
- */
-unsigned int __get_wchan(struct task_struct *tsk)
-{
-	return arc_unwind_core(tsk, NULL, __get_first_nonsched, NULL);
-}
-
 #ifdef CONFIG_STACKTRACE
 
 /*
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
@@ -528,32 +528,6 @@ __notrace_funcgraph struct task_struct *
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
--- a/arch/csky/include/asm/processor.h
+++ b/arch/csky/include/asm/processor.h
@@ -81,8 +81,6 @@ static inline void release_thread(struct
 
 extern int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
 
-unsigned long __get_wchan(struct task_struct *p);
-
 #define KSTK_EIP(tsk)		(task_pt_regs(tsk)->pc)
 #define KSTK_ESP(tsk)		(task_pt_regs(tsk)->usp)
 
--- a/arch/csky/kernel/stacktrace.c
+++ b/arch/csky/kernel/stacktrace.c
@@ -101,24 +101,6 @@ void show_stack(struct task_struct *task
 	walk_stackframe(task, NULL, print_trace_address, (void *)loglvl);
 }
 
-static bool save_wchan(unsigned long pc, void *arg)
-{
-	if (!in_sched_functions(pc)) {
-		unsigned long *p = arg;
-		*p = pc;
-		return true;
-	}
-	return false;
-}
-
-unsigned long __get_wchan(struct task_struct *task)
-{
-	unsigned long pc = 0;
-
-	walk_stackframe(task, NULL, save_wchan, &pc);
-	return pc;
-}
-
 #ifdef CONFIG_STACKTRACE
 static bool __save_trace(unsigned long pc, void *arg, bool nosched)
 {
--- a/arch/hexagon/include/asm/processor.h
+++ b/arch/hexagon/include/asm/processor.h
@@ -63,9 +63,6 @@ struct thread_struct {
 /*  Free all resources held by a thread; defined in process.c  */
 extern void release_thread(struct task_struct *dead_task);
 
-/* Get wait channel for task P.  */
-extern unsigned long __get_wchan(struct task_struct *p);
-
 /*  The following stuff is pretty HEXAGON specific.  */
 
 /*  This is really just here for __switch_to.
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -126,32 +126,6 @@ void flush_thread(void)
 }
 
 /*
- * The "wait channel" terminology is archaic, but what we want
- * is an identification of the point at which the scheduler
- * was invoked by a blocked thread.
- */
-unsigned long __get_wchan(struct task_struct *p)
-{
-	unsigned long fp, pc;
-	unsigned long stack_page;
-	int count = 0;
-
-	stack_page = (unsigned long)task_stack_page(p);
-	fp = ((struct hexagon_switch_stack *)p->thread.switch_sp)->fp;
-	do {
-		if (fp < (stack_page + sizeof(struct thread_info)) ||
-			fp >= (THREAD_SIZE - 8 + stack_page))
-			return 0;
-		pc = ((unsigned long *)fp)[1];
-		if (!in_sched_functions(pc))
-			return pc;
-		fp = *(unsigned long *) fp;
-	} while (count++ < 16);
-
-	return 0;
-}
-
-/*
  * Called on the exit path of event entry; see vm_entry.S
  *
  * Interrupts will already be disabled.
--- a/arch/ia64/include/asm/processor.h
+++ b/arch/ia64/include/asm/processor.h
@@ -329,9 +329,6 @@ struct task_struct;
  */
 #define release_thread(dead_task)
 
-/* Get wait channel for task P.  */
-extern unsigned long __get_wchan (struct task_struct *p);
-
 /* Return instruction pointer of blocked task TSK.  */
 #define KSTK_EIP(tsk)					\
   ({							\
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -522,34 +522,6 @@ exit_thread (struct task_struct *tsk)
 	ia64_drop_fpu(tsk);
 }
 
-unsigned long
-__get_wchan (struct task_struct *p)
-{
-	struct unw_frame_info info;
-	unsigned long ip;
-	int count = 0;
-
-	/*
-	 * Note: p may not be a blocked task (it could be current or
-	 * another process running on some other CPU.  Rather than
-	 * trying to determine if p is really blocked, we just assume
-	 * it's blocked and rely on the unwind routines to fail
-	 * gracefully if the process wasn't really blocked after all.
-	 * --davidm 99/12/15
-	 */
-	unw_init_from_blocked_task(&info, p);
-	do {
-		if (task_is_running(p))
-			return 0;
-		if (unw_unwind(&info) < 0)
-			return 0;
-		unw_get_ip(&info, &ip);
-		if (!in_sched_functions(ip))
-			return ip;
-	} while (count++ < 16);
-	return 0;
-}
-
 void
 cpu_halt (void)
 {
--- a/arch/microblaze/include/asm/processor.h
+++ b/arch/microblaze/include/asm/processor.h
@@ -68,8 +68,6 @@ static inline void release_thread(struct
 {
 }
 
-unsigned long __get_wchan(struct task_struct *p);
-
 /* The size allocated for kernel stacks. This _must_ be a power of two! */
 # define KERNEL_STACK_SIZE	0x2000
 
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -112,12 +112,6 @@ int copy_thread(unsigned long clone_flag
 	return 0;
 }
 
-unsigned long __get_wchan(struct task_struct *p)
-{
-/* TBD (used by procfs) */
-	return 0;
-}
-
 /* Set up a thread for executing a new program */
 void start_thread(struct pt_regs *regs, unsigned long pc, unsigned long usp)
 {
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -369,8 +369,6 @@ static inline void flush_thread(void)
 {
 }
 
-unsigned long __get_wchan(struct task_struct *p);
-
 #define __KSTK_TOS(tsk) ((unsigned long)task_stack_page(tsk) + \
 			 THREAD_SIZE - 32 - sizeof(struct pt_regs))
 #define task_pt_regs(tsk) ((struct pt_regs *)__KSTK_TOS(tsk))
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -651,33 +651,6 @@ unsigned long unwind_stack(struct task_s
 }
 #endif
 
-/*
- * __get_wchan - a maintenance nightmare^W^Wpain in the ass ...
- */
-unsigned long __get_wchan(struct task_struct *task)
-{
-	unsigned long pc = 0;
-#ifdef CONFIG_KALLSYMS
-	unsigned long sp;
-	unsigned long ra = 0;
-#endif
-
-	if (!task_stack_page(task))
-		goto out;
-
-	pc = thread_saved_pc(task);
-
-#ifdef CONFIG_KALLSYMS
-	sp = task->thread.reg29 + schedule_mfi.frame_size;
-
-	while (in_sched_functions(pc))
-		pc = unwind_stack(task, &sp, pc, &ra);
-#endif
-
-out:
-	return pc;
-}
-
 unsigned long mips_stack_top(void)
 {
 	unsigned long top = TASK_SIZE & PAGE_MASK;
--- a/arch/nds32/include/asm/processor.h
+++ b/arch/nds32/include/asm/processor.h
@@ -83,8 +83,6 @@ extern struct task_struct *last_task_use
 /* Prepare to copy thread state - unlazy all lazy status */
 #define prepare_to_copy(tsk)	do { } while (0)
 
-unsigned long __get_wchan(struct task_struct *p);
-
 #define cpu_relax()			barrier()
 
 #define task_pt_regs(task) \
--- a/arch/nds32/kernel/process.c
+++ b/arch/nds32/kernel/process.c
@@ -232,26 +232,3 @@ int dump_fpu(struct pt_regs *regs, elf_f
 }
 
 EXPORT_SYMBOL(dump_fpu);
-
-unsigned long __get_wchan(struct task_struct *p)
-{
-	unsigned long fp, lr;
-	unsigned long stack_start, stack_end;
-	int count = 0;
-
-	if (IS_ENABLED(CONFIG_FRAME_POINTER)) {
-		stack_start = (unsigned long)end_of_stack(p);
-		stack_end = (unsigned long)task_stack_page(p) + THREAD_SIZE;
-
-		fp = thread_saved_fp(p);
-		do {
-			if (fp < stack_start || fp > stack_end)
-				return 0;
-			lr = ((unsigned long *)fp)[0];
-			if (!in_sched_functions(lr))
-				return lr;
-			fp = *(unsigned long *)(fp + 4);
-		} while (count++ < 16);
-	}
-	return 0;
-}
--- a/arch/openrisc/include/asm/processor.h
+++ b/arch/openrisc/include/asm/processor.h
@@ -73,7 +73,6 @@ struct thread_struct {
 
 void start_thread(struct pt_regs *regs, unsigned long nip, unsigned long sp);
 void release_thread(struct task_struct *);
-unsigned long __get_wchan(struct task_struct *p);
 
 #define cpu_relax()     barrier()
 
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -263,9 +263,3 @@ void dump_elf_thread(elf_greg_t *dest, s
 	dest[35] = 0;
 }
 
-unsigned long __get_wchan(struct task_struct *p)
-{
-	/* TODO */
-
-	return 0;
-}
--- a/arch/parisc/include/asm/processor.h
+++ b/arch/parisc/include/asm/processor.h
@@ -273,8 +273,6 @@ struct mm_struct;
 /* Free all resources held by a thread. */
 extern void release_thread(struct task_struct *);
 
-extern unsigned long __get_wchan(struct task_struct *p);
-
 #define KSTK_EIP(tsk)	((tsk)->thread.regs.iaoq[0])
 #define KSTK_ESP(tsk)	((tsk)->thread.regs.gr[30])
 
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -239,30 +239,6 @@ copy_thread(unsigned long clone_flags, u
 	return 0;
 }
 
-unsigned long
-__get_wchan(struct task_struct *p)
-{
-	struct unwind_frame_info info;
-	unsigned long ip;
-	int count = 0;
-
-	/*
-	 * These bracket the sleeping functions..
-	 */
-
-	unwind_frame_init_from_blocked_task(&info, p);
-	do {
-		if (unwind_once(&info) < 0)
-			return 0;
-		if (task_is_running(p))
-                        return 0;
-		ip = info.ip;
-		if (!in_sched_functions(ip))
-			return ip;
-	} while (count++ < MAX_UNWIND_ENTRIES);
-	return 0;
-}
-
 #ifdef CONFIG_64BIT
 void *dereference_function_descriptor(void *ptr)
 {
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
 #ifdef CONFIG_STACKTRACE
 
 noinline void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
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
--- a/arch/sh/include/asm/processor_32.h
+++ b/arch/sh/include/asm/processor_32.h
@@ -180,8 +180,6 @@ static inline void show_code(struct pt_r
 }
 #endif
 
-extern unsigned long __get_wchan(struct task_struct *p);
-
 #define KSTK_EIP(tsk)  (task_pt_regs(tsk)->pc)
 #define KSTK_ESP(tsk)  (task_pt_regs(tsk)->regs[15])
 
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -181,22 +181,3 @@ __switch_to(struct task_struct *prev, st
 
 	return prev;
 }
-
-unsigned long __get_wchan(struct task_struct *p)
-{
-	unsigned long pc;
-
-	/*
-	 * The same comment as on the Alpha applies here, too ...
-	 */
-	pc = thread_saved_pc(p);
-
-#ifdef CONFIG_FRAME_POINTER
-	if (in_sched_functions(pc)) {
-		unsigned long schedule_frame = (unsigned long)p->thread.sp;
-		return ((unsigned long *)schedule_frame)[21];
-	}
-#endif
-
-	return pc;
-}
--- a/arch/sparc/include/asm/processor_64.h
+++ b/arch/sparc/include/asm/processor_64.h
@@ -183,8 +183,6 @@ do { \
 /* Free all resources held by a thread. */
 #define release_thread(tsk)		do { } while (0)
 
-unsigned long __get_wchan(struct task_struct *task);
-
 #define task_pt_regs(tsk) (task_thread_info(tsk)->kregs)
 #define KSTK_EIP(tsk)  (task_pt_regs(tsk)->tpc)
 #define KSTK_ESP(tsk)  (task_pt_regs(tsk)->u_regs[UREG_FP])
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -662,31 +662,3 @@ int arch_dup_task_struct(struct task_str
 	*dst = *src;
 	return 0;
 }
-
-unsigned long __get_wchan(struct task_struct *task)
-{
-	unsigned long pc, fp, bias = 0;
-	struct thread_info *tp;
-	struct reg_window *rw;
-        unsigned long ret = 0;
-	int count = 0; 
-
-	tp = task_thread_info(task);
-	bias = STACK_BIAS;
-	fp = task_thread_info(task)->ksp + bias;
-
-	do {
-		if (!kstack_valid(tp, fp))
-			break;
-		rw = (struct reg_window *) fp;
-		pc = rw->ins[7];
-		if (!in_sched_functions(pc)) {
-			ret = pc;
-			goto out;
-		}
-		fp = rw->ins[6] + bias;
-	} while (++count < 16);
-
-out:
-	return ret;
-}
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -106,6 +106,5 @@ extern struct cpuinfo_um boot_cpu_data;
 #define cache_line_size()	(boot_cpu_data.cache_alignment)
 
 #define KSTK_REG(tsk, reg) get_thread_reg(reg, &tsk->thread.switch_buf)
-extern unsigned long __get_wchan(struct task_struct *p);
 
 #endif
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -364,38 +364,6 @@ unsigned long arch_align_stack(unsigned
 }
 #endif
 
-unsigned long __get_wchan(struct task_struct *p)
-{
-	unsigned long stack_page, sp, ip;
-	bool seen_sched = 0;
-
-	stack_page = (unsigned long) task_stack_page(p);
-	/* Bail if the process has no kernel stack for some reason */
-	if (stack_page == 0)
-		return 0;
-
-	sp = p->thread.switch_buf->JB_SP;
-	/*
-	 * Bail if the stack pointer is below the bottom of the kernel
-	 * stack for some reason
-	 */
-	if (sp < stack_page)
-		return 0;
-
-	while (sp < stack_page + THREAD_SIZE) {
-		ip = *((unsigned long *) sp);
-		if (in_sched_functions(ip))
-			/* Ignore everything until we're above the scheduler */
-			seen_sched = 1;
-		else if (kernel_text_address(ip) && seen_sched)
-			return ip;
-
-		sp += sizeof(unsigned long);
-	}
-
-	return 0;
-}
-
 int elf_core_copy_fpregs(struct task_struct *t, elf_fpregset_t *fpu)
 {
 	int cpu = current_thread_info()->cpu;
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -590,8 +590,6 @@ static inline void load_sp0(unsigned lon
 /* Free all resources held by a thread. */
 extern void release_thread(struct task_struct *);
 
-unsigned long __get_wchan(struct task_struct *p);
-
 /*
  * Generic CPUID function
  * clear %ecx since some cpus (Cyrix MII) do not set or clear %ecx
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -937,20 +937,6 @@ unsigned long arch_randomize_brk(struct
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
-	unsigned long entry = 0;
-
-	stack_trace_save_tsk(p, &entry, 1, 0);
-	return entry;
-}
-
 long do_arch_prctl_common(struct task_struct *task, int option,
 			  unsigned long cpuid_enabled)
 {
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -215,8 +215,6 @@ struct mm_struct;
 /* Free all resources held by a thread. */
 #define release_thread(thread) do { } while(0)
 
-extern unsigned long __get_wchan(struct task_struct *p);
-
 #define KSTK_EIP(tsk)		(task_pt_regs(tsk)->pc)
 #define KSTK_ESP(tsk)		(task_pt_regs(tsk)->areg[1])
 
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -293,32 +293,3 @@ int copy_thread(unsigned long clone_flag
 	return 0;
 }
 
-
-/*
- * These bracket the sleeping functions..
- */
-
-unsigned long __get_wchan(struct task_struct *p)
-{
-	unsigned long sp, pc;
-	unsigned long stack_page = (unsigned long) task_stack_page(p);
-	int count = 0;
-
-	sp = p->thread.sp;
-	pc = MAKE_PC_FROM_RA(p->thread.ra, p->thread.sp);
-
-	do {
-		if (sp < stack_page + sizeof(struct task_struct) ||
-		    sp >= (stack_page + THREAD_SIZE) ||
-		    pc == 0)
-			return 0;
-		if (!in_sched_functions(pc))
-			return pc;
-
-		/* Stack layout: sp-4: ra, sp-3: sp' */
-
-		pc = MAKE_PC_FROM_RA(SPILL_SLOT(sp, 0), sp);
-		sp = SPILL_SLOT(sp, 1);
-	} while (count++ < 16);
-	return 0;
-}
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1966,6 +1966,21 @@ bool sched_task_on_rq(struct task_struct
 	return task_on_rq_queued(p);
 }
 
+#ifdef CONFIG_STACKTRACE
+static unsigned long __get_wchan(struct task_struct *p)
+{
+	unsigned long entry = 0;
+
+	stack_trace_save_tsk(p, &entry, 1, 0);
+
+	return entry;
+}
+#endif
+
+/*
+ * Called from fs/proc with a reference on @p to find the function
+ * which called into schedule().
+ */
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long ip = 0;
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1531,13 +1531,8 @@ config DEBUG_IRQFLAGS
 	  are enabled.
 
 config STACKTRACE
-	bool "Stack backtrace support"
+	def_bool y
 	depends on STACKTRACE_SUPPORT
-	help
-	  This option causes the kernel to create a /proc/pid/stack for
-	  every process, showing its current stack trace.
-	  It is also used by various kernel debugging features that require
-	  stack trace generation.
 
 config WARN_ALL_UNSEEDED_RANDOM
 	bool "Warn for all uses of unseeded randomness"


