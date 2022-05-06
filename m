Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8761C51DA59
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 16:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390697AbiEFOTf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 10:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442201AbiEFOT2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 10:19:28 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AC5689BE;
        Fri,  6 May 2022 07:15:43 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:56086)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmykA-007CCn-7V; Fri, 06 May 2022 08:15:42 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37210 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmyk7-007Cxx-0l; Fri, 06 May 2022 08:15:41 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-arch@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  6 May 2022 09:15:09 -0500
Message-Id: <20220506141512.516114-4-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87mtfu4up3.fsf@email.froward.int.ebiederm.org>
References: <87mtfu4up3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nmyk7-007Cxx-0l;;;mid=<20220506141512.516114-4-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+yxzSsqYESjuBvR1QAuIiTLD1G9JGUvi0=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-arch@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 2160 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (0.5%), b_tie_ro: 10 (0.5%), parse: 2.8 (0.1%),
         extract_message_metadata: 32 (1.5%), get_uri_detail_list: 17 (0.8%),
        tests_pri_-1000: 10 (0.5%), tests_pri_-950: 1.29 (0.1%),
        tests_pri_-900: 1.10 (0.1%), tests_pri_-90: 247 (11.4%), check_bayes:
        238 (11.0%), b_tokenize: 68 (3.2%), b_tok_get_all: 78 (3.6%),
        b_comp_prob: 6 (0.3%), b_tok_touch_all: 80 (3.7%), b_finish: 1.34
        (0.1%), tests_pri_0: 1832 (84.8%), check_dkim_signature: 1.37 (0.1%),
        check_dkim_adsp: 3.0 (0.1%), poll_dns_idle: 0.67 (0.0%), tests_pri_10:
        2.4 (0.1%), tests_pri_500: 14 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 4/7] fork: Generalize PF_IO_WORKER handling
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add fn and fn_arg members into struct kernel_clone_args and test for
them in copy_thread (instead of testing for PF_KTHREAD | PF_IO_WORKER).
This allows any task that wants to be a user space task that only runs
in kernel mode to use this functionality.

The code on x86 is an exception and still retains a PF_KTHREAD test
because x86 unlikely everything else handles kthreads slightly
differently than user space tasks that start with a function.

The functions that created tasks that start with a function
have been updated to set ".fn" and ".fn_arg" instead of
".stack" and ".stack_size".  These functions are fork_idle(),
create_io_thread(), kernel_thread(), and user_mode_thread().

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/alpha/kernel/process.c      |  7 +++----
 arch/arc/kernel/process.c        |  7 +++----
 arch/arm/kernel/process.c        |  7 +++----
 arch/arm64/kernel/process.c      |  7 +++----
 arch/csky/kernel/process.c       |  7 +++----
 arch/h8300/kernel/process.c      |  7 +++----
 arch/hexagon/kernel/process.c    |  7 +++----
 arch/ia64/kernel/process.c       |  6 +++---
 arch/m68k/kernel/process.c       |  7 +++----
 arch/microblaze/kernel/process.c |  7 +++----
 arch/mips/kernel/process.c       |  7 +++----
 arch/nios2/kernel/process.c      |  7 +++----
 arch/openrisc/kernel/process.c   |  7 +++----
 arch/parisc/kernel/process.c     | 11 +++++------
 arch/powerpc/kernel/process.c    |  9 ++++-----
 arch/riscv/kernel/process.c      |  7 +++----
 arch/s390/kernel/process.c       |  7 +++----
 arch/sh/kernel/process_32.c      |  7 +++----
 arch/sparc/kernel/process_32.c   |  7 +++----
 arch/sparc/kernel/process_64.c   |  7 +++----
 arch/um/kernel/process.c         | 10 ++++------
 arch/x86/include/asm/fpu/sched.h |  2 +-
 arch/x86/include/asm/switch_to.h |  8 ++++----
 arch/x86/kernel/fpu/core.c       |  4 ++--
 arch/x86/kernel/process.c        | 13 ++++++-------
 arch/xtensa/kernel/process.c     | 11 +++++------
 include/linux/sched/task.h       |  2 ++
 kernel/fork.c                    | 16 ++++++++--------
 28 files changed, 95 insertions(+), 116 deletions(-)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 732e39217c7f..6cbba7370b4e 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -237,7 +237,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;
 	unsigned long usp = args->stack;
-	unsigned long kthread_arg = args->stack_size;
 	unsigned long tls = args->tls;
 	extern void ret_from_fork(void);
 	extern void ret_from_kernel_thread(void);
@@ -251,13 +250,13 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	childti->pcb.ksp = (unsigned long) childstack;
 	childti->pcb.flags = 1;	/* set FEN, clear everything else */
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(args->fn)) {
 		/* kernel thread */
 		memset(childstack, 0,
 			sizeof(struct switch_stack) + sizeof(struct pt_regs));
 		childstack->r26 = (unsigned long) ret_from_kernel_thread;
-		childstack->r9 = usp;	/* function */
-		childstack->r10 = kthread_arg;
+		childstack->r9 = (unsigned long) args->fn;
+		childstack->r10 = (unsigned long) args->fn_arg;
 		childregs->hae = alpha_mv.hae_cache;
 		childti->pcb.usp = 0;
 		return 0;
diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index caf948ba647c..3369f0700702 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -166,7 +166,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;
 	unsigned long usp = args->stack;
-	unsigned long kthread_arg = args->stack_size;
 	unsigned long tls = args->tls;
 	struct pt_regs *c_regs;        /* child's pt_regs */
 	unsigned long *childksp;       /* to unwind out of __switch_to() */
@@ -193,11 +192,11 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	childksp[0] = 0;			/* fp */
 	childksp[1] = (unsigned long)ret_from_fork; /* blink */
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(args->fn)) {
 		memset(c_regs, 0, sizeof(struct pt_regs));
 
-		c_callee->r13 = kthread_arg;
-		c_callee->r14 = usp;  /* function */
+		c_callee->r13 = (unsigned long)args->fn_arg;
+		c_callee->r14 = (unsigned long)args->fn;
 
 		return 0;
 	}
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 8e13b426dd26..3d9cace63884 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -242,7 +242,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;
 	unsigned long stack_start = args->stack;
-	unsigned long stk_sz = args->stack_size;
 	unsigned long tls = args->tls;
 	struct thread_info *thread = task_thread_info(p);
 	struct pt_regs *childregs = task_pt_regs(p);
@@ -259,15 +258,15 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	thread->cpu_domain = get_domain();
 #endif
 
-	if (likely(!(p->flags & (PF_KTHREAD | PF_IO_WORKER)))) {
+	if (likely(!args->fn)) {
 		*childregs = *current_pt_regs();
 		childregs->ARM_r0 = 0;
 		if (stack_start)
 			childregs->ARM_sp = stack_start;
 	} else {
 		memset(childregs, 0, sizeof(struct pt_regs));
-		thread->cpu_context.r4 = stk_sz;
-		thread->cpu_context.r5 = stack_start;
+		thread->cpu_context.r4 = (unsigned long)args->fn_arg;
+		thread->cpu_context.r5 = (unsigned long)args->fn;
 		childregs->ARM_cpsr = SVC_MODE;
 	}
 	thread->cpu_context.pc = (unsigned long)ret_from_fork;
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index e002f6681c8d..d0ef05c661b0 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -320,7 +320,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;
 	unsigned long stack_start = args->stack;
-	unsigned long stk_sz = args->stack_size;
 	unsigned long tls = args->tls;
 	struct pt_regs *childregs = task_pt_regs(p);
 
@@ -337,7 +336,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 
 	ptrauth_thread_init_kernel(p);
 
-	if (likely(!(p->flags & (PF_KTHREAD | PF_IO_WORKER)))) {
+	if (likely(!args->fn)) {
 		*childregs = *current_pt_regs();
 		childregs->regs[0] = 0;
 
@@ -371,8 +370,8 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->pstate = PSR_MODE_EL1h | PSR_IL_BIT;
 
-		p->thread.cpu_context.x19 = stack_start;
-		p->thread.cpu_context.x20 = stk_sz;
+		p->thread.cpu_context.x19 = (unsigned long)args->fn;
+		p->thread.cpu_context.x20 = (unsigned long)args->fn_arg;
 	}
 	p->thread.cpu_context.pc = (unsigned long)ret_from_fork;
 	p->thread.cpu_context.sp = (unsigned long)childregs;
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index 7dba33d37e1a..9af49aea1c3b 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -34,7 +34,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;
 	unsigned long usp = args->stack;
-	unsigned long kthread_arg = args->stack_size;
 	unsigned long tls = args->tls;
 	struct switch_stack *childstack;
 	struct pt_regs *childregs = task_pt_regs(p);
@@ -49,11 +48,11 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	/* setup thread.sp for switch_to !!! */
 	p->thread.sp = (unsigned long)childstack;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(args->fn)) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childstack->r15 = (unsigned long) ret_from_kernel_thread;
-		childstack->r10 = kthread_arg;
-		childstack->r9 = usp;
+		childstack->r10 = (unsigned long) args->fn_arg;
+		childstack->r9 = (unsigned long) args->fn;
 		childregs->sr = mfcr("psr");
 	} else {
 		*childregs = *(current_pt_regs());
diff --git a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
index 296ff831446e..5bfe0f8f54bf 100644
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -108,16 +108,15 @@ void flush_thread(void)
 int copy_thread(struct task_struct *p, const kernel_cloen_args *args)
 {
 	unsigned long usp = args->stack;
-	unsigned long topstk = args->stack_size;
 	struct pt_regs *childregs;
 
 	childregs = (struct pt_regs *) (THREAD_SIZE + task_stack_page(p)) - 1;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(args->fn)) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->retpc = (unsigned long) ret_from_kernel_thread;
-		childregs->er4 = topstk; /* arg */
-		childregs->er5 = usp; /* fn */
+		childregs->er4 = (unsigned long) args->fn_arg;
+		childregs->er5 = (unsigned long) args->fn;
 	}  else {
 		*childregs = *current_pt_regs();
 		childregs->er0 = 0;
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index f1c1f6f21941..f0552f98a7ba 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -54,7 +54,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;
 	unsigned long usp = args->stack;
-	unsigned long arg = args->stack_size;
 	unsigned long tls = args->tls;
 	struct thread_info *ti = task_thread_info(p);
 	struct hexagon_switch_stack *ss;
@@ -76,11 +75,11 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 						    sizeof(*ss));
 	ss->lr = (unsigned long)ret_from_fork;
 	p->thread.switch_sp = ss;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(args->fn)) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		/* r24 <- fn, r25 <- arg */
-		ss->r24 = usp;
-		ss->r25 = arg;
+		ss->r24 = (unsigned long)args->fn;
+		ss->r25 = (unsigned long)args->fn_arg;
 		pt_set_kmode(childregs);
 		return 0;
 	}
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 8f010ae818bc..167b1765bea1 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -341,14 +341,14 @@ copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 
 	ia64_drop_fpu(p);	/* don't pick up stale state from a CPU's fph */
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(args->fn)) {
 		if (unlikely(args->idle)) {
 			/* fork_idle() called us */
 			return 0;
 		}
 		memset(child_stack, 0, sizeof(*child_ptregs) + sizeof(*child_stack));
-		child_stack->r4 = user_stack_base;	/* payload */
-		child_stack->r5 = user_stack_size;	/* argument */
+		child_stack->r4 = (unsigned long) args->fn;
+		child_stack->r5 = (unsigned long) args->fn_arg;
 		/*
 		 * Preserve PSR bits, except for bits 32-34 and 37-45,
 		 * which we can't read.
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index 8ac575656fc4..221feb0269f1 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -142,7 +142,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;
 	unsigned long usp = args->stack;
-	unsigned long arg = args->stack_size;
 	unsigned long tls = args->tls;
 	struct fork_frame {
 		struct switch_stack sw;
@@ -160,12 +159,12 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	 */
 	p->thread.fc = USER_DATA;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(args->fn)) {
 		/* kernel thread */
 		memset(frame, 0, sizeof(struct fork_frame));
 		frame->regs.sr = PS_S;
-		frame->sw.a3 = usp; /* function */
-		frame->sw.d7 = arg;
+		frame->sw.a3 = (unsigned long)args->fn;
+		frame->sw.d7 = (unsigned long)args->fn_arg;
 		frame->sw.retpc = (unsigned long)ret_from_kernel_thread;
 		p->thread.usp = 0;
 		return 0;
diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/process.c
index b5f549125c6a..3c6241bcaea8 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -56,19 +56,18 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;
 	unsigned long usp = args->stack;
-	unsigned long arg = args->stack_size;
 	unsigned long tls = args->tls;
 	struct pt_regs *childregs = task_pt_regs(p);
 	struct thread_info *ti = task_thread_info(p);
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(args->fn)) {
 		/* if we're creating a new kernel thread then just zeroing all
 		 * the registers. That's OK for a brand new thread.*/
 		memset(childregs, 0, sizeof(struct pt_regs));
 		memset(&ti->cpu_context, 0, sizeof(struct cpu_context));
 		ti->cpu_context.r1  = (unsigned long)childregs;
-		ti->cpu_context.r20 = (unsigned long)usp; /* fn */
-		ti->cpu_context.r19 = (unsigned long)arg;
+		ti->cpu_context.r20 = (unsigned long)args->fn;
+		ti->cpu_context.r19 = (unsigned long)args->fn_arg;
 		childregs->pt_mode = 1;
 		local_save_flags(childregs->msr);
 		ti->cpu_context.msr = childregs->msr & ~MSR_IE;
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index a572d097b16b..35b912bce429 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -109,7 +109,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;
 	unsigned long usp = args->stack;
-	unsigned long kthread_arg = args->stack_size;
 	unsigned long tls = args->tls;
 	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs, *regs = current_pt_regs();
@@ -122,12 +121,12 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	/*  Put the stack after the struct pt_regs.  */
 	childksp = (unsigned long) childregs;
 	p->thread.cp0_status = (read_c0_status() & ~(ST0_CU2|ST0_CU1)) | ST0_KERNEL_CUMASK;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(args->fn)) {
 		/* kernel thread */
 		unsigned long status = p->thread.cp0_status;
 		memset(childregs, 0, sizeof(struct pt_regs));
-		p->thread.reg16 = usp; /* fn */
-		p->thread.reg17 = kthread_arg;
+		p->thread.reg16 = (unsigned long)args->fn;
+		p->thread.reg17 = (unsigned long)args->fn_arg;
 		p->thread.reg29 = childksp;
 		p->thread.reg31 = (unsigned long) ret_from_kernel_thread;
 #if defined(CONFIG_CPU_R3000)
diff --git a/arch/nios2/kernel/process.c b/arch/nios2/kernel/process.c
index 98c4bfe972e0..29593b98567d 100644
--- a/arch/nios2/kernel/process.c
+++ b/arch/nios2/kernel/process.c
@@ -104,7 +104,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;
 	unsigned long usp = args->stack;
-	unsigned long arg = args->stack_size;
 	unsigned long tls = args->tls;
 	struct pt_regs *childregs = task_pt_regs(p);
 	struct pt_regs *regs;
@@ -112,12 +111,12 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	struct switch_stack *childstack =
 		((struct switch_stack *)childregs) - 1;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(args->fn)) {
 		memset(childstack, 0,
 			sizeof(struct switch_stack) + sizeof(struct pt_regs));
 
-		childstack->r16 = usp;		/* fn */
-		childstack->r17 = arg;
+		childstack->r16 = (unsigned long) args->fn;
+		childstack->r17 = (unsigned long) args->fn_arg;
 		childstack->ra = (unsigned long) ret_from_kernel_thread;
 		childregs->estatus = STATUS_PIE;
 		childregs->sp = (unsigned long) childstack;
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 486e46dd5883..d9697cc9bc4d 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -156,7 +156,6 @@ copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;
 	unsigned long usp = args->stack;
-	unsigned long arg = args->stack_size;
 	unsigned long tls = args->tls;
 	struct pt_regs *userregs;
 	struct pt_regs *kregs;
@@ -175,10 +174,10 @@ copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	sp -= sizeof(struct pt_regs);
 	kregs = (struct pt_regs *)sp;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(args->fn)) {
 		memset(kregs, 0, sizeof(struct pt_regs));
-		kregs->gpr[20] = usp; /* fn, kernel thread */
-		kregs->gpr[22] = arg;
+		kregs->gpr[20] = (unsigned long)args->fn;
+		kregs->gpr[22] = (unsigned long)args->fn_arg;
 	} else {
 		*userregs = *current_pt_regs();
 
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index 30a5874ca845..a6a2a558fc5b 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -210,7 +210,6 @@ copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;
 	unsigned long usp = args->stack;
-	unsigned long kthread_arg = args->stack_size;
 	unsigned long tls = args->tls;
 	struct pt_regs *cregs = &(p->thread.regs);
 	void *stack = task_stack_page(p);
@@ -221,7 +220,7 @@ copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	extern void * const ret_from_kernel_thread;
 	extern void * const child_return;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(args->fn)) {
 		/* kernel thread */
 		memset(cregs, 0, sizeof(struct pt_regs));
 		if (args->idle) /* idle thread */
@@ -236,12 +235,12 @@ copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		 * ret_from_kernel_thread.
 		 */
 #ifdef CONFIG_64BIT
-		cregs->gr[27] = ((unsigned long *)usp)[3];
-		cregs->gr[26] = ((unsigned long *)usp)[2];
+		cregs->gr[27] = ((unsigned long *)args->fn)[3];
+		cregs->gr[26] = ((unsigned long *)args->fn)[2];
 #else
-		cregs->gr[26] = usp;
+		cregs->gr[26] = (unsigned long) args->fn;
 #endif
-		cregs->gr[25] = kthread_arg;
+		cregs->gr[25] = (unsigned long) args->fn_arg;
 	} else {
 		/* user thread */
 		/* usp must be word aligned.  This also prevents users from
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 3fd67c861d54..4f367bb68906 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1720,7 +1720,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;
 	unsigned long usp = args->stack;
-	unsigned long kthread_arg = args->stack_size;
 	unsigned long tls = args->tls;
 	struct pt_regs *childregs, *kregs;
 	extern void ret_from_fork(void);
@@ -1738,18 +1737,18 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	/* Copy registers */
 	sp -= sizeof(struct pt_regs);
 	childregs = (struct pt_regs *) sp;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(args->fn)) {
 		/* kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->gpr[1] = sp + sizeof(struct pt_regs);
 		/* function */
-		if (usp)
-			childregs->gpr[14] = ppc_function_entry((void *)usp);
+		if (args->fn)
+			childregs->gpr[14] = ppc_function_entry((void *)args->fn);
 #ifdef CONFIG_PPC64
 		clear_tsk_thread_flag(p, TIF_32BIT);
 		childregs->softe = IRQS_ENABLED;
 #endif
-		childregs->gpr[15] = kthread_arg;
+		childregs->gpr[15] = (unsigned long)args->fn_arg;
 		p->thread.regs = NULL;	/* no user register state */
 		ti->flags |= _TIF_RESTOREALL;
 		f = ret_from_kernel_thread;
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 334382731725..24efabdbc551 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -124,12 +124,11 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;
 	unsigned long usp = args->stack;
-	unsigned long arg = args->stack_size;
 	unsigned long tls = args->tls;
 	struct pt_regs *childregs = task_pt_regs(p);
 
 	/* p->thread holds context to be restored by __switch_to() */
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(args->fn)) {
 		/* Kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->gp = gp_in_global;
@@ -137,8 +136,8 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		childregs->status = SR_PP | SR_PIE;
 
 		p->thread.ra = (unsigned long)ret_from_kernel_thread;
-		p->thread.s[0] = usp; /* fn */
-		p->thread.s[1] = arg;
+		p->thread.s[0] = (unsigned long)args->fn;
+		p->thread.s[1] = (unsigned long)args->fn_arg;
 	} else {
 		*childregs = *(current_pt_regs());
 		if (usp) /* User fork */
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index bb5daec39516..89949b9f3cf8 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -98,7 +98,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;
 	unsigned long new_stackp = args->stack;
-	unsigned long arg = args->stack_size;
 	unsigned long tls = args->tls;
 	struct fake_frame
 	{
@@ -133,15 +132,15 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	frame->sf.gprs[9] = (unsigned long)frame;
 
 	/* Store access registers to kernel stack of new process. */
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(args->fn)) {
 		/* kernel thread */
 		memset(&frame->childregs, 0, sizeof(struct pt_regs));
 		frame->childregs.psw.mask = PSW_KERNEL_BITS | PSW_MASK_DAT |
 				PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK;
 		frame->childregs.psw.addr =
 				(unsigned long)__ret_from_fork;
-		frame->childregs.gprs[9] = new_stackp; /* function */
-		frame->childregs.gprs[10] = arg;
+		frame->childregs.gprs[9] = (unsigned long)args->fn;
+		frame->childregs.gprs[10] = (unsigned long)args->fn_arg;
 		frame->childregs.orig_gpr2 = -1;
 		frame->childregs.last_break = 1;
 		return 0;
diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index 6023399b1892..a808843375e7 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -96,7 +96,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;
 	unsigned long usp = args->stack;
-	unsigned long arg = args->stack_size;
 	unsigned long tls = args->tls;
 	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs;
@@ -117,11 +116,11 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 
 	childregs = task_pt_regs(p);
 	p->thread.sp = (unsigned long) childregs;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(args->fn)) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		p->thread.pc = (unsigned long) ret_from_kernel_thread;
-		childregs->regs[4] = arg;
-		childregs->regs[5] = usp;
+		childregs->regs[4] = (unsigned long) args->fn_arg;
+		childregs->regs[5] = (unsigned long) args->fn;
 		childregs->sr = SR_MD;
 #if defined(CONFIG_SH_FPU)
 		childregs->sr |= SR_FD;
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 80e6775e18c0..33b0215a4182 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -263,7 +263,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;
 	unsigned long sp = args->stack;
-	unsigned long arg = args->stack_size;
 	unsigned long tls = args->tls;
 	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs, *regs = current_pt_regs();
@@ -299,13 +298,13 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	ti->ksp = (unsigned long) new_stack;
 	p->thread.kregs = childregs;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(args->fn)) {
 		extern int nwindows;
 		unsigned long psr;
 		memset(new_stack, 0, STACKFRAME_SZ + TRACEREG_SZ);
 		ti->kpc = (((unsigned long) ret_from_kernel_thread) - 0x8);
-		childregs->u_regs[UREG_G1] = sp; /* function */
-		childregs->u_regs[UREG_G2] = arg;
+		childregs->u_regs[UREG_G1] = (unsigned long) args->fn;
+		childregs->u_regs[UREG_G2] = (unsigned long) args->fn_arg;
 		psr = childregs->psr = get_psr();
 		ti->kpsr = psr | PSR_PIL;
 		ti->kwim = 1 << (((psr & PSR_CWP) + 1) % nwindows);
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 38c46ca826d9..6335b698a4b4 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -568,7 +568,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;
 	unsigned long sp = args->stack;
-	unsigned long arg = args->stack_size;
 	unsigned long tls = args->tls;
 	struct thread_info *t = task_thread_info(p);
 	struct pt_regs *regs = current_pt_regs();
@@ -587,12 +586,12 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 				       sizeof(struct sparc_stackf));
 	t->fpsaved[0] = 0;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(args->fn)) {
 		memset(child_trap_frame, 0, child_stack_sz);
 		__thread_flag_byte_ptr(t)[TI_FLAG_BYTE_CWP] = 
 			(current_pt_regs()->tstate + 1) & TSTATE_CWP;
-		t->kregs->u_regs[UREG_G1] = sp; /* function */
-		t->kregs->u_regs[UREG_G2] = arg;
+		t->kregs->u_regs[UREG_G1] = (unsigned long) args->fn;
+		t->kregs->u_regs[UREG_G2] = (unsigned long) args->fn_arg;
 		return 0;
 	}
 
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index fd2d2361484d..181cc9aafb25 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -158,15 +158,13 @@ int copy_thread(struct task_struct * p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;
 	unsigned long sp = args->stack;
-	unsigned long arg = args->stack_size;
 	unsigned long tls = args->tls;
 	void (*handler)(void);
-	int kthread = current->flags & (PF_KTHREAD | PF_IO_WORKER);
 	int ret = 0;
 
 	p->thread = (struct thread_struct) INIT_THREAD;
 
-	if (!kthread) {
+	if (!args->fn) {
 	  	memcpy(&p->thread.regs.regs, current_pt_regs(),
 		       sizeof(p->thread.regs.regs));
 		PT_REGS_SET_SYSCALL_RETURN(&p->thread.regs, 0);
@@ -178,14 +176,14 @@ int copy_thread(struct task_struct * p, const struct kernel_clone_args *args)
 		arch_copy_thread(&current->thread.arch, &p->thread.arch);
 	} else {
 		get_safe_registers(p->thread.regs.regs.gp, p->thread.regs.regs.fp);
-		p->thread.request.u.thread.proc = (int (*)(void *))sp;
-		p->thread.request.u.thread.arg = (void *)arg;
+		p->thread.request.u.thread.proc = args->fn;
+		p->thread.request.u.thread.arg = args->fn_arg;
 		handler = new_thread_handler;
 	}
 
 	new_thread(task_stack_page(p), &p->thread.switch_buf, handler);
 
-	if (!kthread) {
+	if (!args->fn) {
 		clear_flushed_tls(p);
 
 		/*
diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fpu/sched.h
index 99a8820e8cc4..b2486b2cbc6e 100644
--- a/arch/x86/include/asm/fpu/sched.h
+++ b/arch/x86/include/asm/fpu/sched.h
@@ -11,7 +11,7 @@
 
 extern void save_fpregs_to_fpstate(struct fpu *fpu);
 extern void fpu__drop(struct fpu *fpu);
-extern int  fpu_clone(struct task_struct *dst, unsigned long clone_flags);
+extern int  fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal);
 extern void fpu_flush_thread(void);
 
 /*
diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index b5f0d2ff47e4..c08eb0fdd11f 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -78,13 +78,13 @@ static inline void update_task_stack(struct task_struct *task)
 }
 
 static inline void kthread_frame_init(struct inactive_task_frame *frame,
-				      unsigned long fun, unsigned long arg)
+				      int (*fun)(void *), void *arg)
 {
-	frame->bx = fun;
+	frame->bx = (unsigned long)fun;
 #ifdef CONFIG_X86_32
-	frame->di = arg;
+	frame->di = (unsigned long)arg;
 #else
-	frame->r12 = arg;
+	frame->r12 = (unsigned long)arg;
 #endif
 }
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index c049561f373a..fbade5a3975b 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -556,7 +556,7 @@ static inline void fpu_inherit_perms(struct fpu *dst_fpu)
 }
 
 /* Clone current's FPU state on fork */
-int fpu_clone(struct task_struct *dst, unsigned long clone_flags)
+int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal)
 {
 	struct fpu *src_fpu = &current->thread.fpu;
 	struct fpu *dst_fpu = &dst->thread.fpu;
@@ -579,7 +579,7 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags)
 	 * No FPU state inheritance for kernel threads and IO
 	 * worker threads.
 	 */
-	if (dst->flags & (PF_KTHREAD | PF_IO_WORKER)) {
+	if (minimal) {
 		/* Clear out the minimal state */
 		memcpy(&dst_fpu->fpstate->regs, &init_fpstate.regs,
 		       init_fpstate_copy_size());
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 0fce52b10dc4..d20eaad52a85 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -134,7 +134,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;
 	unsigned long sp = args->stack;
-	unsigned long arg = args->stack_size;
 	unsigned long tls = args->tls;
 	struct inactive_task_frame *frame;
 	struct fork_frame *fork_frame;
@@ -172,13 +171,13 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	frame->flags = X86_EFLAGS_FIXED;
 #endif
 
-	fpu_clone(p, clone_flags);
+	fpu_clone(p, clone_flags, args->fn);
 
 	/* Kernel thread ? */
 	if (unlikely(p->flags & PF_KTHREAD)) {
 		p->thread.pkru = pkru_get_init_value();
 		memset(childregs, 0, sizeof(struct pt_regs));
-		kthread_frame_init(frame, sp, arg);
+		kthread_frame_init(frame, args->fn, args->fn_arg);
 		return 0;
 	}
 
@@ -198,10 +197,10 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	task_user_gs(p) = get_user_gs(current_pt_regs());
 #endif
 
-	if (unlikely(p->flags & PF_IO_WORKER)) {
+	if (unlikely(args->fn)) {
 		/*
-		 * An IO thread is a user space thread, but it doesn't
-		 * return to ret_after_fork().
+		 * A user space thread, but it doesn't return to
+		 * ret_after_fork().
 		 *
 		 * In order to indicate that to tools like gdb,
 		 * we reset the stack and instruction pointers.
@@ -211,7 +210,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		 */
 		childregs->sp = 0;
 		childregs->ip = 0;
-		kthread_frame_init(frame, sp, arg);
+		kthread_frame_init(frame, args->fn, args->fn_arg);
 		return 0;
 	}
 
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index 15ce25073142..c3751cc88e5d 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -205,7 +205,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;
 	unsigned long usp_thread_fn = args->stack;
-	unsigned long thread_fn_arg = args->stack_size;
 	unsigned long tls = args->tls;
 	struct pt_regs *childregs = task_pt_regs(p);
 
@@ -226,7 +225,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 #error Unsupported Xtensa ABI
 #endif
 
-	if (!(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (!args->fn) {
 		struct pt_regs *regs = current_pt_regs();
 		unsigned long usp = usp_thread_fn ?
 			usp_thread_fn : regs->areg[1];
@@ -278,15 +277,15 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		 * Window underflow will load registers from the
 		 * spill slots on the stack on return from _switch_to.
 		 */
-		SPILL_SLOT(childregs, 2) = usp_thread_fn;
-		SPILL_SLOT(childregs, 3) = thread_fn_arg;
+		SPILL_SLOT(childregs, 2) = (unsigned long)args->fn;
+		SPILL_SLOT(childregs, 3) = (unsigned long)args->fn_arg;
 #elif defined(__XTENSA_CALL0_ABI__)
 		/*
 		 * a12 = thread_fn, a13 = thread_fn arg.
 		 * _switch_to epilogue will load registers from the stack.
 		 */
-		((unsigned long *)p->thread.sp)[0] = usp_thread_fn;
-		((unsigned long *)p->thread.sp)[1] = thread_fn_arg;
+		((unsigned long *)p->thread.sp)[0] = (unsigned long)args->fn;
+		((unsigned long *)p->thread.sp)[1] = (unsigned long)args->fn_arg;
 #else
 #error Unsupported Xtensa ABI
 #endif
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 3d6b99ce5408..505aaf9fe477 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -34,6 +34,8 @@ struct kernel_clone_args {
 	int io_thread;
 	int kthread;
 	int idle;
+	int (*fn)(void *);
+	void *fn_arg;
 	struct cgroup *cgrp;
 	struct css_set *cset;
 };
diff --git a/kernel/fork.c b/kernel/fork.c
index 93d77ee921ff..8e17c3fbce42 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2555,8 +2555,8 @@ struct task_struct * __init fork_idle(int cpu)
 	struct task_struct *task;
 	struct kernel_clone_args args = {
 		.flags		= CLONE_VM,
-		.stack		= (unsigned long)&idle_dummy,
-		.stack_size	= (unsigned long)NULL,
+		.fn		= &idle_dummy,
+		.fn_arg		= NULL,
 		.kthread	= 1,
 		.idle		= 1,
 	};
@@ -2589,8 +2589,8 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.flags		= ((lower_32_bits(flags) | CLONE_VM |
 				    CLONE_UNTRACED) & ~CSIGNAL),
 		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
-		.stack		= (unsigned long)fn,
-		.stack_size	= (unsigned long)arg,
+		.fn		= fn,
+		.fn_arg		= arg,
 		.io_thread	= 1,
 	};
 
@@ -2694,8 +2694,8 @@ pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
 		.flags		= ((lower_32_bits(flags) | CLONE_VM |
 				    CLONE_UNTRACED) & ~CSIGNAL),
 		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
-		.stack		= (unsigned long)fn,
-		.stack_size	= (unsigned long)arg,
+		.fn		= fn,
+		.fn_arg		= arg,
 		.kthread	= 1,
 	};
 
@@ -2711,8 +2711,8 @@ pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned long flags)
 		.flags		= ((lower_32_bits(flags) | CLONE_VM |
 				    CLONE_UNTRACED) & ~CSIGNAL),
 		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
-		.stack		= (unsigned long)fn,
-		.stack_size	= (unsigned long)arg,
+		.fn		= fn,
+		.fn_arg		= arg,
 	};
 
 	return kernel_clone(&args);
-- 
2.35.3

