Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D07951DA51
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 16:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442198AbiEFOT1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 10:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442140AbiEFOTW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 10:19:22 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CEF1DA6B;
        Fri,  6 May 2022 07:15:36 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:55974)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmyk3-007C8x-Do; Fri, 06 May 2022 08:15:35 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37210 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmyk1-007Cxx-3p; Fri, 06 May 2022 08:15:34 -0600
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
Date:   Fri,  6 May 2022 09:15:07 -0500
Message-Id: <20220506141512.516114-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87mtfu4up3.fsf@email.froward.int.ebiederm.org>
References: <87mtfu4up3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nmyk1-007Cxx-3p;;;mid=<20220506141512.516114-2-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18EWowv4UmYU8OgbxfJhOr0MsF/jYW8XGU=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;linux-arch@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1300 ms - load_scoreonly_sql: 0.24 (0.0%),
        signal_user_changed: 14 (1.1%), b_tie_ro: 11 (0.8%), parse: 2.3 (0.2%),
         extract_message_metadata: 24 (1.8%), get_uri_detail_list: 10 (0.7%),
        tests_pri_-1000: 16 (1.3%), tests_pri_-950: 1.81 (0.1%),
        tests_pri_-900: 1.20 (0.1%), tests_pri_-90: 139 (10.7%), check_bayes:
        137 (10.6%), b_tokenize: 33 (2.6%), b_tok_get_all: 12 (1.0%),
        b_comp_prob: 3.1 (0.2%), b_tok_touch_all: 84 (6.5%), b_finish: 1.04
        (0.1%), tests_pri_0: 1077 (82.9%), check_dkim_signature: 1.05 (0.1%),
        check_dkim_adsp: 3.3 (0.3%), poll_dns_idle: 1.11 (0.1%), tests_pri_10:
        2.9 (0.2%), tests_pri_500: 16 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 2/7] fork: Pass struct kernel_clone_args into copy_thread
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With io_uring we have started supporting tasks that are for most
purposes user space tasks that exclusively run code in kernel mode.

The kernel task that exec's init and tasks that exec user mode
helpers are also user mode tasks that just run kernel code
until they call kernel execve.

Pass kernel_clone_args into copy_thread so these oddball
tasks can be supported more cleanly and easily.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/alpha/kernel/process.c      |  8 +++++---
 arch/arc/kernel/process.c        |  8 +++++---
 arch/arm/kernel/process.c        |  7 +++++--
 arch/arm64/kernel/process.c      |  7 +++++--
 arch/csky/kernel/process.c       | 10 +++++-----
 arch/h8300/kernel/process.c      |  5 +++--
 arch/hexagon/kernel/process.c    |  7 +++++--
 arch/ia64/kernel/process.c       |  7 +++++--
 arch/m68k/kernel/process.c       |  7 +++++--
 arch/microblaze/kernel/process.c |  7 +++++--
 arch/mips/kernel/process.c       |  8 +++++---
 arch/nios2/kernel/process.c      |  7 +++++--
 arch/openrisc/kernel/process.c   |  7 +++++--
 arch/parisc/kernel/process.c     |  7 +++++--
 arch/powerpc/kernel/process.c    |  8 +++++---
 arch/riscv/kernel/process.c      |  7 +++++--
 arch/s390/kernel/process.c       |  7 +++++--
 arch/sh/kernel/process_32.c      |  7 +++++--
 arch/sparc/kernel/process_32.c   |  7 +++++--
 arch/sparc/kernel/process_64.c   |  7 +++++--
 arch/um/kernel/process.c         |  7 +++++--
 arch/x86/kernel/process.c        |  7 +++++--
 arch/xtensa/kernel/process.c     |  8 +++++---
 include/linux/sched/task.h       |  3 +--
 kernel/fork.c                    |  4 ++--
 25 files changed, 116 insertions(+), 58 deletions(-)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 5f8527081da9..732e39217c7f 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -233,10 +233,12 @@ release_thread(struct task_struct *dead_task)
 /*
  * Copy architecture-specific thread state
  */
-int copy_thread(unsigned long clone_flags, unsigned long usp,
-		unsigned long kthread_arg, struct task_struct *p,
-		unsigned long tls)
+int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
+	unsigned long clone_flags = args->flags;
+	unsigned long usp = args->stack;
+	unsigned long kthread_arg = args->stack_size;
+	unsigned long tls = args->tls;
 	extern void ret_from_fork(void);
 	extern void ret_from_kernel_thread(void);
 
diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index 5f7f5aab361f..caf948ba647c 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -162,10 +162,12 @@ asmlinkage void ret_from_fork(void);
  * |    user_r25    |
  * ------------------  <===== END of PAGE
  */
-int copy_thread(unsigned long clone_flags, unsigned long usp,
-		unsigned long kthread_arg, struct task_struct *p,
-		unsigned long tls)
+int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
+	unsigned long clone_flags = args->flags;
+	unsigned long usp = args->stack;
+	unsigned long kthread_arg = args->stack_size;
+	unsigned long tls = args->tls;
 	struct pt_regs *c_regs;        /* child's pt_regs */
 	unsigned long *childksp;       /* to unwind out of __switch_to() */
 	struct callee_regs *c_callee;  /* child's callee regs */
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 0617af11377f..8e13b426dd26 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -238,9 +238,12 @@ void release_thread(struct task_struct *dead_task)
 
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
 
-int copy_thread(unsigned long clone_flags, unsigned long stack_start,
-		unsigned long stk_sz, struct task_struct *p, unsigned long tls)
+int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
+	unsigned long clone_flags = args->flags;
+	unsigned long stack_start = args->stack;
+	unsigned long stk_sz = args->stack_size;
+	unsigned long tls = args->tls;
 	struct thread_info *thread = task_thread_info(p);
 	struct pt_regs *childregs = task_pt_regs(p);
 
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 7fa97df55e3a..e002f6681c8d 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -316,9 +316,12 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 
 asmlinkage void ret_from_fork(void) asm("ret_from_fork");
 
-int copy_thread(unsigned long clone_flags, unsigned long stack_start,
-		unsigned long stk_sz, struct task_struct *p, unsigned long tls)
+int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
+	unsigned long clone_flags = args->flags;
+	unsigned long stack_start = args->stack;
+	unsigned long stk_sz = args->stack_size;
+	unsigned long tls = args->tls;
 	struct pt_regs *childregs = task_pt_regs(p);
 
 	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index 3d0ca22cd0e2..7dba33d37e1a 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -30,12 +30,12 @@ asmlinkage void ret_from_kernel_thread(void);
  */
 void flush_thread(void){}
 
-int copy_thread(unsigned long clone_flags,
-		unsigned long usp,
-		unsigned long kthread_arg,
-		struct task_struct *p,
-		unsigned long tls)
+int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
+	unsigned long clone_flags = args->flags;
+	unsigned long usp = args->stack;
+	unsigned long kthread_arg = args->stack_size;
+	unsigned long tls = args->tls;
 	struct switch_stack *childstack;
 	struct pt_regs *childregs = task_pt_regs(p);
 
diff --git a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
index 8833fa4f5d51..296ff831446e 100644
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -105,9 +105,10 @@ void flush_thread(void)
 {
 }
 
-int copy_thread(unsigned long clone_flags, unsigned long usp,
-		unsigned long topstk, struct task_struct *p, unsigned long tls)
+int copy_thread(struct task_struct *p, const kernel_cloen_args *args)
 {
+	unsigned long usp = args->stack;
+	unsigned long topstk = args->stack_size;
 	struct pt_regs *childregs;
 
 	childregs = (struct pt_regs *) (THREAD_SIZE + task_stack_page(p)) - 1;
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index eab03c691f53..f1c1f6f21941 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -50,9 +50,12 @@ void arch_cpu_idle(void)
 /*
  * Copy architecture-specific thread state
  */
-int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
+	unsigned long clone_flags = args->flags;
+	unsigned long usp = args->stack;
+	unsigned long arg = args->stack_size;
+	unsigned long tls = args->tls;
 	struct thread_info *ti = task_thread_info(p);
 	struct hexagon_switch_stack *ss;
 	struct pt_regs *childregs;
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index d7a256bd9d6b..10d41ded05a5 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -295,9 +295,12 @@ ia64_load_extra (struct task_struct *task)
  * so there is nothing to worry about.
  */
 int
-copy_thread(unsigned long clone_flags, unsigned long user_stack_base,
-	    unsigned long user_stack_size, struct task_struct *p, unsigned long tls)
+copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
+	unsigned long clone_flags = args->flags;
+	unsigned long user_stack_base = args->stack;
+	unsigned long user_stack_size = args->stack_size;
+	unsigned long tls = args->tls;
 	extern char ia64_ret_from_clone;
 	struct switch_stack *child_stack, *stack;
 	unsigned long rbs, child_rbs, rbs_size;
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index a6030dbaa089..8ac575656fc4 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -138,9 +138,12 @@ asmlinkage int m68k_clone3(struct pt_regs *regs)
 	return sys_clone3((struct clone_args __user *)regs->d1, regs->d2);
 }
 
-int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
+	unsigned long clone_flags = args->flags;
+	unsigned long usp = args->stack;
+	unsigned long arg = args->stack_size;
+	unsigned long tls = args->tls;
 	struct fork_frame {
 		struct switch_stack sw;
 		struct pt_regs regs;
diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/process.c
index 1b944d319d73..b5f549125c6a 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -52,9 +52,12 @@ void flush_thread(void)
 {
 }
 
-int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
+	unsigned long clone_flags = args->flags;
+	unsigned long usp = args->stack;
+	unsigned long arg = args->stack_size;
+	unsigned long tls = args->tls;
 	struct pt_regs *childregs = task_pt_regs(p);
 	struct thread_info *ti = task_thread_info(p);
 
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index c2d5f4bfe1f3..a572d097b16b 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -105,10 +105,12 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 /*
  * Copy architecture-specific thread state
  */
-int copy_thread(unsigned long clone_flags, unsigned long usp,
-		unsigned long kthread_arg, struct task_struct *p,
-		unsigned long tls)
+int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
+	unsigned long clone_flags = args->flags;
+	unsigned long usp = args->stack;
+	unsigned long kthread_arg = args->stack_size;
+	unsigned long tls = args->tls;
 	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs, *regs = current_pt_regs();
 	unsigned long childksp;
diff --git a/arch/nios2/kernel/process.c b/arch/nios2/kernel/process.c
index f8ea522a1588..98c4bfe972e0 100644
--- a/arch/nios2/kernel/process.c
+++ b/arch/nios2/kernel/process.c
@@ -100,9 +100,12 @@ void flush_thread(void)
 {
 }
 
-int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
+	unsigned long clone_flags = args->flags;
+	unsigned long usp = args->stack;
+	unsigned long arg = args->stack_size;
+	unsigned long tls = args->tls;
 	struct pt_regs *childregs = task_pt_regs(p);
 	struct pt_regs *regs;
 	struct switch_stack *stack;
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 3c0c91bcdcba..486e46dd5883 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -152,9 +152,12 @@ extern asmlinkage void ret_from_fork(void);
  */
 
 int
-copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
-	    struct task_struct *p, unsigned long tls)
+copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
+	unsigned long clone_flags = args->flags;
+	unsigned long usp = args->stack;
+	unsigned long arg = args->stack_size;
+	unsigned long tls = args->tls;
 	struct pt_regs *userregs;
 	struct pt_regs *kregs;
 	unsigned long sp = (unsigned long)task_stack_page(p) + THREAD_SIZE;
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index 28b6a2a5574c..129c17de45ba 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -206,9 +206,12 @@ arch_initcall(parisc_idle_init);
  * Copy architecture-specific thread state
  */
 int
-copy_thread(unsigned long clone_flags, unsigned long usp,
-	    unsigned long kthread_arg, struct task_struct *p, unsigned long tls)
+copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
+	unsigned long clone_flags = args->flags;
+	unsigned long usp = args->stack;
+	unsigned long kthread_arg = args->stack_size;
+	unsigned long tls = args->tls;
 	struct pt_regs *cregs = &(p->thread.regs);
 	void *stack = task_stack_page(p);
 	
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 984813a4d5dc..3fd67c861d54 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1716,10 +1716,12 @@ static void setup_ksp_vsid(struct task_struct *p, unsigned long sp)
 /*
  * Copy architecture-specific thread state
  */
-int copy_thread(unsigned long clone_flags, unsigned long usp,
-		unsigned long kthread_arg, struct task_struct *p,
-		unsigned long tls)
+int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
+	unsigned long clone_flags = args->flags;
+	unsigned long usp = args->stack;
+	unsigned long kthread_arg = args->stack_size;
+	unsigned long tls = args->tls;
 	struct pt_regs *childregs, *kregs;
 	extern void ret_from_fork(void);
 	extern void ret_from_fork_scv(void);
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 504b496787aa..334382731725 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -120,9 +120,12 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	return 0;
 }
 
-int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
+	unsigned long clone_flags = args->flags;
+	unsigned long usp = args->stack;
+	unsigned long arg = args->stack_size;
+	unsigned long tls = args->tls;
 	struct pt_regs *childregs = task_pt_regs(p);
 
 	/* p->thread holds context to be restored by __switch_to() */
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 71d86f73b02c..bb5daec39516 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -94,9 +94,12 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	return 0;
 }
 
-int copy_thread(unsigned long clone_flags, unsigned long new_stackp,
-		unsigned long arg, struct task_struct *p, unsigned long tls)
+int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
+	unsigned long clone_flags = args->flags;
+	unsigned long new_stackp = args->stack;
+	unsigned long arg = args->stack_size;
+	unsigned long tls = args->tls;
 	struct fake_frame
 	{
 		struct stack_frame sf;
diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index ca01286a0610..6023399b1892 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -92,9 +92,12 @@ void release_thread(struct task_struct *dead_task)
 asmlinkage void ret_from_fork(void);
 asmlinkage void ret_from_kernel_thread(void);
 
-int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
+	unsigned long clone_flags = args->flags;
+	unsigned long usp = args->stack;
+	unsigned long arg = args->stack_size;
+	unsigned long tls = args->tls;
 	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs;
 
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 88c0c14aaff0..80e6775e18c0 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -259,9 +259,12 @@ clone_stackframe(struct sparc_stackf __user *dst,
 extern void ret_from_fork(void);
 extern void ret_from_kernel_thread(void);
 
-int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
+	unsigned long clone_flags = args->flags;
+	unsigned long sp = args->stack;
+	unsigned long arg = args->stack_size;
+	unsigned long tls = args->tls;
 	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs, *regs = current_pt_regs();
 	char *new_stack;
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 9a2ceb080ac9..38c46ca826d9 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -564,9 +564,12 @@ void fault_in_user_windows(struct pt_regs *regs)
  * Parent -->  %o0 == childs  pid, %o1 == 0
  * Child  -->  %o0 == parents pid, %o1 == 1
  */
-int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
+	unsigned long clone_flags = args->flags;
+	unsigned long sp = args->stack;
+	unsigned long arg = args->stack_size;
+	unsigned long tls = args->tls;
 	struct thread_info *t = task_thread_info(p);
 	struct pt_regs *regs = current_pt_regs();
 	struct sparc_stackf *parent_sf;
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 80504680be08..fd2d2361484d 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -154,9 +154,12 @@ void fork_handler(void)
 	userspace(&current->thread.regs.regs, current_thread_info()->aux_fp_regs);
 }
 
-int copy_thread(unsigned long clone_flags, unsigned long sp,
-		unsigned long arg, struct task_struct * p, unsigned long tls)
+int copy_thread(struct task_struct * p, const struct kernel_clone_args *args)
 {
+	unsigned long clone_flags = args->flags;
+	unsigned long sp = args->stack;
+	unsigned long arg = args->stack_size;
+	unsigned long tls = args->tls;
 	void (*handler)(void);
 	int kthread = current->flags & (PF_KTHREAD | PF_IO_WORKER);
 	int ret = 0;
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b370767f5b19..0fce52b10dc4 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -130,9 +130,12 @@ static int set_new_tls(struct task_struct *p, unsigned long tls)
 		return do_set_thread_area_64(p, ARCH_SET_FS, tls);
 }
 
-int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
+	unsigned long clone_flags = args->flags;
+	unsigned long sp = args->stack;
+	unsigned long arg = args->stack_size;
+	unsigned long tls = args->tls;
 	struct inactive_task_frame *frame;
 	struct fork_frame *fork_frame;
 	struct pt_regs *childregs;
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index e8bfbca5f001..15ce25073142 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -201,10 +201,12 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
  * involved.  Much simpler to just not copy those live frames across.
  */
 
-int copy_thread(unsigned long clone_flags, unsigned long usp_thread_fn,
-		unsigned long thread_fn_arg, struct task_struct *p,
-		unsigned long tls)
+int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
+	unsigned long clone_flags = args->flags;
+	unsigned long usp_thread_fn = args->stack;
+	unsigned long thread_fn_arg = args->stack_size;
+	unsigned long tls = args->tls;
 	struct pt_regs *childregs = task_pt_regs(p);
 
 #if (XTENSA_HAVE_COPROCESSORS || XTENSA_HAVE_IO_PORTS)
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 4492266935dd..fcdcba231aac 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -68,8 +68,7 @@ extern void fork_init(void);
 
 extern void release_task(struct task_struct * p);
 
-extern int copy_thread(unsigned long, unsigned long, unsigned long,
-		       struct task_struct *, unsigned long);
+extern int copy_thread(struct task_struct *, const struct kernel_clone_args *);
 
 extern void flush_thread(void);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 27c5203750b4..d39a248a8d8d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1979,7 +1979,7 @@ static __latent_entropy struct task_struct *copy_process(
 	struct task_struct *p;
 	struct multiprocess_signals delayed;
 	struct file *pidfile = NULL;
-	u64 clone_flags = args->flags;
+	const u64 clone_flags = args->flags;
 	struct nsproxy *nsp = current->nsproxy;
 
 	/*
@@ -2240,7 +2240,7 @@ static __latent_entropy struct task_struct *copy_process(
 	retval = copy_io(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_namespaces;
-	retval = copy_thread(clone_flags, args->stack, args->stack_size, p, args->tls);
+	retval = copy_thread(p, args);
 	if (retval)
 		goto bad_fork_cleanup_io;
 
-- 
2.35.3

