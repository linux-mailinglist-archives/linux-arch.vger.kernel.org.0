Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467F13AA339
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jun 2021 20:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhFPSeI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Jun 2021 14:34:08 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:34156 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbhFPSeH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jun 2021 14:34:07 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ltaKW-00A8Jk-DK; Wed, 16 Jun 2021 12:32:00 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ltaKV-000zav-33; Wed, 16 Jun 2021 12:32:00 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
References: <87sg1p30a1.fsf@disp2133>
        <CAHk-=wjiBXCZBxLiCG5hxpd0vMkMjiocenponWygG5SCG6DXNw@mail.gmail.com>
        <87pmwsytb3.fsf@disp2133>
        <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
        <87sg1lwhvm.fsf@disp2133>
        <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
        <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com>
        <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
        <87eed4v2dc.fsf@disp2133>
        <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
        <87fsxjorgs.fsf@disp2133> <87zgvqor7d.fsf_-_@disp2133>
        <CAHk-=wir2P6h+HKtswPEGDh+GKLMM6_h8aovpMcUHyQv2zJ5Og@mail.gmail.com>
        <87mtrpg47k.fsf@disp2133> <87pmwlek8d.fsf_-_@disp2133>
Date:   Wed, 16 Jun 2021 13:31:52 -0500
In-Reply-To: <87pmwlek8d.fsf_-_@disp2133> (Eric W. Biederman's message of
        "Wed, 16 Jun 2021 13:29:38 -0500")
Message-ID: <87k0mtek4n.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ltaKV-000zav-33;;;mid=<87k0mtek4n.fsf_-_@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/TgZ0Dim61YIRBkDY9kmQTLP1TNitUw5w=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong,XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 724 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.6 (0.5%), b_tie_ro: 2.5 (0.3%), parse: 0.90
        (0.1%), extract_message_metadata: 10 (1.4%), get_uri_detail_list: 3.0
        (0.4%), tests_pri_-1000: 11 (1.5%), tests_pri_-950: 1.00 (0.1%),
        tests_pri_-900: 0.85 (0.1%), tests_pri_-90: 192 (26.6%), check_bayes:
        191 (26.4%), b_tokenize: 12 (1.7%), b_tok_get_all: 13 (1.8%),
        b_comp_prob: 2.8 (0.4%), b_tok_touch_all: 159 (22.0%), b_finish: 0.77
        (0.1%), tests_pri_0: 494 (68.3%), check_dkim_signature: 0.47 (0.1%),
        check_dkim_adsp: 2.4 (0.3%), poll_dns_idle: 0.93 (0.1%), tests_pri_10:
        1.83 (0.3%), tests_pri_500: 6 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 1/2] alpha/ptrace: Record and handle the absence of switch_stack
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


While thinking about the information leaks fixed in 77f6ab8b7768
("don't dump the threads that had been already exiting when zapped.")
I realized the problem is much more general than just coredumps and
exit_mm.  We have io_uring threads, PTRACE_EVENT_FORK,
PTRACE_EVENT_VFORK, PTRACE_EVENT_CLONE, PTRACE_EVENT_EXEC and
PTRACE_EVENT_EXIT where ptrace is allowed to access userspace
registers, but on some architectures has not saved them so
they can be modified.

The function alpha_switch_to does something reasonable it saves the
floating point registers and the caller saved registers and switches
to a different thread.  Any register the caller is not expected to
save it does not save.

Meanhile the system call entry point on alpha also does something
reasonable.  The system call entry point saves all but the caller
saved integer registers and doesn't touch the floating point registers
as the kernel code does not touch them.

This is a nice happy fast path until the kernel wants to access the
user space's registers through ptrace or similar.  As user spaces's
caller saved registers may be saved at an unpredictable point in the
kernel code's stack, the routine which may stop and make the userspace
registers available must be wrapped by code that will first save a
switch stack frame at the bottom of the call stack, call the code that
may access those registers and then pop the switch stack frame.

The practical problem with this code structure is that this results in
a game of whack-a-mole wrapping different kernel system calls.  Loosing
the game of whack-a-mole results in a security hole where userspace can
write arbitrary data to the kernel stack.

In general it is not possible to prevent generic code introducing a
ptrace_stop or register access not knowing alpha's limitations, that
where alpha does not make all of the registers avaliable.

Prevent security holes by recording when all of the registers are
available so generic code changes do not result in security holes
on alpha.

Cc: stable@vger.kernel.org
Fixes: dbe1bdbb39db ("io_uring: handle signals for IO threads like a normal thread")
Fixes: 45c1a159b85b ("Add PTRACE_O_TRACEVFORKDONE and PTRACE_O_TRACEEXIT facilities.")
Fixes: a0691b116f6a ("Add new ptrace event tracing mechanism")
History-tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/alpha/include/asm/thread_info.h |  2 ++
 arch/alpha/kernel/entry.S            | 38 ++++++++++++++++++++++------
 arch/alpha/kernel/ptrace.c           | 13 ++++++++--
 3 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/arch/alpha/include/asm/thread_info.h b/arch/alpha/include/asm/thread_info.h
index 2592356e3215..41e5986ed9c8 100644
--- a/arch/alpha/include/asm/thread_info.h
+++ b/arch/alpha/include/asm/thread_info.h
@@ -63,6 +63,7 @@ register struct thread_info *__current_thread_info __asm__("$8");
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_SYSCALL_AUDIT	4	/* syscall audit active */
 #define TIF_NOTIFY_SIGNAL	5	/* signal notifications exist */
+#define TIF_ALLREGS_SAVED	6	/* both pt_regs and switch_stack saved */
 #define TIF_DIE_IF_KERNEL	9	/* dik recursion lock */
 #define TIF_MEMDIE		13	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	14	/* idle is polling for TIF_NEED_RESCHED */
@@ -73,6 +74,7 @@ register struct thread_info *__current_thread_info __asm__("$8");
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
+#define _TIF_ALLREGS_SAVED	(1<<TIF_ALLREGS_SAVED)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 
 /* Work to do on interrupt/exception return.  */
diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
index e227f3a29a43..c1edf54dc035 100644
--- a/arch/alpha/kernel/entry.S
+++ b/arch/alpha/kernel/entry.S
@@ -174,6 +174,28 @@
 	.cfi_adjust_cfa_offset	-SWITCH_STACK_SIZE
 .endm
 
+.macro	SAVE_SWITCH_STACK
+	DO_SWITCH_STACK
+1:	ldl_l	$1, TI_FLAGS($8)
+	bis	$1, _TIF_ALLREGS_SAVED, $1
+	stl_c	$1, TI_FLAGS($8)
+	beq	$1, 2f
+.subsection 2
+2:	br	1b
+.previous
+.endm
+
+.macro	RESTORE_SWITCH_STACK
+1:	ldl_l	$1, TI_FLAGS($8)
+	bic	$1, _TIF_ALLREGS_SAVED, $1
+	stl_c	$1, TI_FLAGS($8)
+	beq	$1, 2f
+.subsection 2
+2:	br	1b
+.previous
+	UNDO_SWITCH_STACK
+.endm
+
 /*
  * Non-syscall kernel entry points.
  */
@@ -559,9 +581,9 @@ $work_resched:
 
 $work_notifysig:
 	mov	$sp, $16
-	DO_SWITCH_STACK
+	SAVE_SWITCH_STACK
 	jsr	$26, do_work_pending
-	UNDO_SWITCH_STACK
+	RESTORE_SWITCH_STACK
 	br	restore_all
 
 /*
@@ -572,9 +594,9 @@ $work_notifysig:
 	.type	strace, @function
 strace:
 	/* set up signal stack, call syscall_trace */
-	DO_SWITCH_STACK
+	SAVE_SWITCH_STACK
 	jsr	$26, syscall_trace_enter /* returns the syscall number */
-	UNDO_SWITCH_STACK
+	RESTORE_SWITCH_STACK
 
 	/* get the arguments back.. */
 	ldq	$16, SP_OFF+24($sp)
@@ -602,9 +624,9 @@ ret_from_straced:
 $strace_success:
 	stq	$0, 0($sp)		/* save return value */
 
-	DO_SWITCH_STACK
+	SAVE_SWITCH_STACK
 	jsr	$26, syscall_trace_leave
-	UNDO_SWITCH_STACK
+	RESTORE_SWITCH_STACK
 	br	$31, ret_from_sys_call
 
 	.align	3
@@ -618,13 +640,13 @@ $strace_error:
 	stq	$0, 0($sp)
 	stq	$1, 72($sp)	/* a3 for return */
 
-	DO_SWITCH_STACK
+	SAVE_SWITCH_STACK
 	mov	$18, $9		/* save old syscall number */
 	mov	$19, $10	/* save old a3 */
 	jsr	$26, syscall_trace_leave
 	mov	$9, $18
 	mov	$10, $19
-	UNDO_SWITCH_STACK
+	RESTORE_SWITCH_STACK
 
 	mov	$31, $26	/* tell "ret_from_sys_call" we can restart */
 	br	ret_from_sys_call
diff --git a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
index 8c43212ae38e..41fb994f36dc 100644
--- a/arch/alpha/kernel/ptrace.c
+++ b/arch/alpha/kernel/ptrace.c
@@ -117,7 +117,13 @@ get_reg_addr(struct task_struct * task, unsigned long regno)
 		zero = 0;
 		addr = &zero;
 	} else {
-		addr = task_stack_page(task) + regoff[regno];
+		int off = regoff[regno];
+		if (WARN_ON_ONCE((off < PT_REG(r0)) &&
+				!test_ti_thread_flag(task_thread_info(task),
+						     TIF_ALLREGS_SAVED)))
+			addr = &zero;
+		else
+			addr = task_stack_page(task) + off;
 	}
 	return addr;
 }
@@ -145,13 +151,16 @@ get_reg(struct task_struct * task, unsigned long regno)
 static int
 put_reg(struct task_struct *task, unsigned long regno, unsigned long data)
 {
+	unsigned long *addr;
 	if (regno == 63) {
 		task_thread_info(task)->ieee_state
 		  = ((task_thread_info(task)->ieee_state & ~IEEE_SW_MASK)
 		     | (data & IEEE_SW_MASK));
 		data = (data & FPCR_DYN_MASK) | ieee_swcr_to_fpcr(data);
 	}
-	*get_reg_addr(task, regno) = data;
+	addr = get_reg_addr(task, regno);
+	if (addr != &zero)
+		*addr = data;
 	return 0;
 }
 
-- 
2.20.1

