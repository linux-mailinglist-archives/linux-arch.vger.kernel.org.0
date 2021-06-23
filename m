Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87363B110C
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jun 2021 02:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFWAYD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Jun 2021 20:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhFWAYC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Jun 2021 20:24:02 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E970C061574
        for <linux-arch@vger.kernel.org>; Tue, 22 Jun 2021 17:21:45 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id y14so185160pgs.12
        for <linux-arch@vger.kernel.org>; Tue, 22 Jun 2021 17:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t3N5v1KQmHBIlVpTGD1bDov8G1sEUsBJQywgcclUWK4=;
        b=nFPOAcPvxofjFHHYYHkwBXe00oam52DF7LTQAk9WGBky7xhdAO89jM/6FZTk5B4jbS
         fewq9lQbZE2jKn8WzBxMrsXfeNp6OgQAjcDwmTcymhU9QA5qgb2z8sXvxMdb4Ls0sahF
         wh8w8LDvHUbmd9auUxDpKrSXUB6MuWaPUHTyvKhGtpHsk6HhpViT4z+9d+ehxEx9pI63
         k+/PDq12N+Oj9Vo4QHpmrjqAHn1zJdjCQiOYm4UbaB0AR5k0FcxL3xhujIuMLMeXKnwP
         um+XdHitBblRNy4LodpQ9JYrMf0u25PRgya+QaB+88SiyseGSLdN866jpOdDIfeedmAq
         2nVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t3N5v1KQmHBIlVpTGD1bDov8G1sEUsBJQywgcclUWK4=;
        b=RoLSFGfQO63oOvMxBADKTJXytgQSNTRTMVO2PiY/D4rjgHqorpluia7SHriVlNm4wq
         MrebMzGL1rZpqhGBAZwCAQ0MW0eZsOIvywCwlWaTWZYPOwEcAIpm7KTmRcZknqWXWJR1
         uoM++uxqL+bguAKctz457YUe9P4tKATgb9EWRw4JXZORsMFKSnEe9MINiRLdDzEOD1l3
         a6z5s+8Tn+v2R9YtIA6lQpR9g9wk/KA0BbPFI+C/PWtw2YmDrdm+EQzsPTS0xsy7Bd7a
         zSBZ9P/g3YktACqcj6lQdVq/XXiVK6Hu1XSsuZFfiHY4moAUbNKauHkiIgUNoyFVFvB+
         qr3w==
X-Gm-Message-State: AOAM5300GSof0Hpo9F+hZbEdWJmHJQCzPK/MYVhnNSZlSzN1i7Ecu+UR
        TUFXhPr8kgJYt7udLkGvVx0=
X-Google-Smtp-Source: ABdhPJyacJ8uAKpusPf2HF4aYUWU0fYVvi3/q5HjMn8abFV0B7Avng5gnzjLsrHp6iLfEueBbZtkPw==
X-Received: by 2002:a05:6a00:9a8:b029:2f1:b41b:21cd with SMTP id u40-20020a056a0009a8b02902f1b41b21cdmr6203811pfg.41.1624407704717;
        Tue, 22 Jun 2021 17:21:44 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id s1sm21193401pgg.49.2021.06.22.17.21.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jun 2021 17:21:44 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 848023603E5; Wed, 23 Jun 2021 12:21:40 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     geert@linux-m68k.org, linux-arch@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org
Cc:     ebiederm@xmission.com, torvalds@linux-foundation.org,
        schwab@linux-m68k.org, Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v4 3/3] m68k: track syscalls being traced with shallow user context stack
Date:   Wed, 23 Jun 2021 12:21:36 +1200
Message-Id: <1624407696-20180-4-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com>
References: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add 'status' field to thread_info struct to hold syscall trace
status info.

Set flag bit in thread_info->status at syscall trace entry, clear
flag bit on trace exit.

Set another flag bit on entering syscall where the full stack
frame has been saved. These flags can be checked whenever a
syscall calls ptrace_stop().

Check flag bits in get_reg()/put_reg() and prevent access to
registers that are saved on the switch stack, in case the
syscall did not actually save these registers on the switch
stack.

Tested on ARAnyM only - boots and survives running strace on a
binary, nothing fancy.

CC: Eric W. Biederman <ebiederm@xmission.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

--

Changes from v3:

- complete flag bit handling for all syscalls that use a m68k
  wrapper
- add flag checking code to get_reg()/put_reg() in m68k ptrace.c
---
 arch/m68k/include/asm/entry.h       | 10 +++++++
 arch/m68k/include/asm/thread_info.h |  1 +
 arch/m68k/kernel/asm-offsets.c      |  1 +
 arch/m68k/kernel/entry.S            | 54 +++++++++++++++++++++++++++++++++++++
 arch/m68k/kernel/ptrace.c           | 44 +++++++++++++++++++++++++-----
 5 files changed, 104 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/include/asm/entry.h b/arch/m68k/include/asm/entry.h
index 9b52b06..37ba65b 100644
--- a/arch/m68k/include/asm/entry.h
+++ b/arch/m68k/include/asm/entry.h
@@ -41,6 +41,16 @@
 #define ALLOWINT	(~0x700)
 #endif /* machine compilation types */
 
+#define TIS_TRACING		0
+#define TIS_ALLREGS_SAVED	1
+#define _TIS_TRACING		(1<<TIS_TRACING)
+#define _TIS_ALLREGS_SAVED	(1<<TIS_ALLREGS_SAVED)
+
+#define TIS_TRACE_ON		_TIS_TRACING
+#define TIS_TRACE_OFF		(~(_TIS_TRACING))
+#define TIS_SWITCH_STACK	_TIS_ALLREGS_SAVED
+#define TIS_NO_SWITCH_STACK	(~(_TIS_ALLREGS_SAVED))
+
 #ifdef __ASSEMBLY__
 /*
  * This defines the normal kernel pt-regs layout.
diff --git a/arch/m68k/include/asm/thread_info.h b/arch/m68k/include/asm/thread_info.h
index 15a7570..a88b48b 100644
--- a/arch/m68k/include/asm/thread_info.h
+++ b/arch/m68k/include/asm/thread_info.h
@@ -29,6 +29,7 @@ struct thread_info {
 	unsigned long		flags;
 	mm_segment_t		addr_limit;	/* thread address space */
 	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
+	unsigned int		status;		/* thread-synchronous flags */
 	__u32			cpu;		/* should always be 0 on m68k */
 	unsigned long		tp_value;	/* thread pointer */
 };
diff --git a/arch/m68k/kernel/asm-offsets.c b/arch/m68k/kernel/asm-offsets.c
index ccea355..ac1ec8f 100644
--- a/arch/m68k/kernel/asm-offsets.c
+++ b/arch/m68k/kernel/asm-offsets.c
@@ -41,6 +41,7 @@ int main(void)
 	/* offsets into the thread_info struct */
 	DEFINE(TINFO_PREEMPT, offsetof(struct thread_info, preempt_count));
 	DEFINE(TINFO_FLAGS, offsetof(struct thread_info, flags));
+	DEFINE(TINFO_STATUS, offsetof(struct thread_info, status));
 
 	/* offsets into the pt_regs */
 	DEFINE(PT_OFF_D0, offsetof(struct pt_regs, d0));
diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
index 0c25038..4cc24d5 100644
--- a/arch/m68k/kernel/entry.S
+++ b/arch/m68k/kernel/entry.S
@@ -51,75 +51,115 @@
 
 .text
 ENTRY(__sys_fork)
+	movel	%curptr@(TASK_STACK),%a1
+	orb	#TIS_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	SAVE_SWITCH_STACK
 	jbsr	sys_fork
 	lea     %sp@(24),%sp
+	movel	%curptr@(TASK_STACK),%a1
+	andb	#TIS_NO_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	rts
 
 ENTRY(__sys_clone)
+	movel	%curptr@(TASK_STACK),%a1
+	orb	#TIS_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	SAVE_SWITCH_STACK
 	pea	%sp@(SWITCH_STACK_SIZE)
 	jbsr	m68k_clone
 	lea     %sp@(28),%sp
+	movel	%curptr@(TASK_STACK),%a1
+	andb	#TIS_NO_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	rts
 
 ENTRY(__sys_vfork)
+	movel	%curptr@(TASK_STACK),%a1
+	orb	#TIS_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	SAVE_SWITCH_STACK
 	jbsr	sys_vfork
 	lea     %sp@(24),%sp
+	movel	%curptr@(TASK_STACK),%a1
+	andb	#TIS_NO_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	rts
 
 ENTRY(__sys_clone3)
+	movel	%curptr@(TASK_STACK),%a1
+	orb	#TIS_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	SAVE_SWITCH_STACK
 	pea	%sp@(SWITCH_STACK_SIZE)
 	jbsr	m68k_clone3
 	lea	%sp@(28),%sp
+	movel	%curptr@(TASK_STACK),%a1
+	andb	#TIS_NO_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	rts
 
 ENTRY(__sys_exit)
+	movel	%curptr@(TASK_STACK),%a1
+	orb	#TIS_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	SAVE_SWITCH_STACK
 	pea	%sp@(SWITCH_STACK_SIZE)
 	jbsr	m68k_exit
 	lea	%sp@(28),%sp
+	movel	%curptr@(TASK_STACK),%a1
+	andb	#TIS_NO_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	rts
 
 ENTRY(__sys_exit_group)
+	movel	%curptr@(TASK_STACK),%a1
+	orb	#TIS_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	SAVE_SWITCH_STACK
 	pea	%sp@(SWITCH_STACK_SIZE)
 	jbsr	m68k_exit_group
 	lea	%sp@(28),%sp
+	movel	%curptr@(TASK_STACK),%a1
+	andb	#TIS_NO_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	rts
 
 ENTRY(__sys_execve)
+	movel	%curptr@(TASK_STACK),%a1
+	orb	#TIS_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	SAVE_SWITCH_STACK
 	pea	%sp@(SWITCH_STACK_SIZE)
 	jbsr	m68k_execve
 	lea	%sp@(28),%sp
+	movel	%curptr@(TASK_STACK),%a1
+	andb	#TIS_NO_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	rts
 
 ENTRY(__sys_execveat)
+	movel	%curptr@(TASK_STACK),%a1
+	orb	#TIS_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	SAVE_SWITCH_STACK
 	pea	%sp@(SWITCH_STACK_SIZE)
 	jbsr	m68k_execveat
 	lea	%sp@(28),%sp
+	movel	%curptr@(TASK_STACK),%a1
+	andb	#TIS_NO_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	rts
 
 ENTRY(sys_sigreturn)
+	movel	%curptr@(TASK_STACK),%a1
+	orb	#TIS_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	SAVE_SWITCH_STACK
 	movel	%sp,%sp@-		  | switch_stack pointer
 	pea	%sp@(SWITCH_STACK_SIZE+4) | pt_regs pointer
 	jbsr	do_sigreturn
 	addql	#8,%sp
 	RESTORE_SWITCH_STACK
+	movel	%curptr@(TASK_STACK),%a1
+	andb	#TIS_NO_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	rts
 
 ENTRY(sys_rt_sigreturn)
+	movel	%curptr@(TASK_STACK),%a1
+	orb	#TIS_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	SAVE_SWITCH_STACK
 	movel	%sp,%sp@-		  | switch_stack pointer
 	pea	%sp@(SWITCH_STACK_SIZE+4) | pt_regs pointer
 	jbsr	do_rt_sigreturn
 	addql	#8,%sp
 	RESTORE_SWITCH_STACK
+	movel	%curptr@(TASK_STACK),%a1
+	andb	#TIS_NO_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	rts
 
 ENTRY(buserr)
@@ -200,25 +240,33 @@ ENTRY(ret_from_user_rt_signal)
 #else
 
 do_trace_entry:
+	orb	#TIS_TRACE_ON, %a1@(TINFO_STATUS+3)
 	movel	#-ENOSYS,%sp@(PT_OFF_D0)| needed for strace
 	subql	#4,%sp
+	orb	#TIS_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	SAVE_SWITCH_STACK
 	jbsr	syscall_trace
 	RESTORE_SWITCH_STACK
+	andb	#TIS_NO_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	addql	#4,%sp
 	movel	%sp@(PT_OFF_ORIG_D0),%d0
 	cmpl	#NR_syscalls,%d0
 	jcs	syscall
 badsys:
+	andb	#TIS_TRACE_OFF, %a1@(TINFO_STATUS+3)
 	movel	#-ENOSYS,%sp@(PT_OFF_D0)
 	jra	ret_from_syscall
 
 do_trace_exit:
 	subql	#4,%sp
+	orb	#TIS_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	SAVE_SWITCH_STACK
 	jbsr	syscall_trace
 	RESTORE_SWITCH_STACK
+	andb	#TIS_NO_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	addql	#4,%sp
+	movel	%curptr@(TASK_STACK),%a1
+	andb	#TIS_TRACE_OFF, %a1@(TINFO_STATUS+3)
 	jra	.Lret_from_exception
 
 ENTRY(ret_from_signal)
@@ -227,6 +275,8 @@ ENTRY(ret_from_signal)
 	jge	1f
 	jbsr	syscall_trace
 1:	RESTORE_SWITCH_STACK
+	movel	%curptr@(TASK_STACK),%a1
+	andb	#TIS_TRACE_OFF, %a1@(TINFO_STATUS+3)
 	addql	#4,%sp
 /* on 68040 complete pending writebacks if any */
 #ifdef CONFIG_M68040
@@ -303,11 +353,15 @@ exit_work:
 do_signal_return:
 	|andw	#ALLOWINT,%sr
 	subql	#4,%sp			| dummy return address
+	movel	%curptr@(TASK_STACK),%a1
+	orb	#TIS_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	SAVE_SWITCH_STACK
 	pea	%sp@(SWITCH_STACK_SIZE)
 	bsrl	do_notify_resume
 	addql	#4,%sp
 	RESTORE_SWITCH_STACK
+	movel	%curptr@(TASK_STACK),%a1
+	andb	#TIS_NO_SWITCH_STACK, %a1@(TINFO_STATUS+3)
 	addql	#4,%sp
 	jbra	resume_userspace
 
diff --git a/arch/m68k/kernel/ptrace.c b/arch/m68k/kernel/ptrace.c
index 94b3b27..ae4ef61 100644
--- a/arch/m68k/kernel/ptrace.c
+++ b/arch/m68k/kernel/ptrace.c
@@ -68,6 +68,12 @@ static const int regoff[] = {
 	[18]	= PT_REG(pc),
 };
 
+static inline int test_ti_thread_status(struct thread_info *ti, int flag)
+{
+	return test_bit(flag, (unsigned long *)&ti->status);
+}
+
+
 /*
  * Get contents of register REGNO in task TASK.
  */
@@ -77,9 +83,22 @@ static inline long get_reg(struct task_struct *task, int regno)
 
 	if (regno == PT_USP)
 		addr = &task->thread.usp;
-	else if (regno < ARRAY_SIZE(regoff))
-		addr = (unsigned long *)(task->thread.esp0 + regoff[regno]);
-	else
+	else if (regno < ARRAY_SIZE(regoff)) {
+		int off  =regoff[regno];
+
+		if (WARN_ON_ONCE((off < PT_REG(d1)) &&
+			test_ti_thread_status(task_thread_info(task), TIS_TRACING) &&
+			!test_ti_thread_status(task_thread_info(task),
+					     TIS_ALLREGS_SAVED))) {
+			unsigned long *addr_d0;
+
+			addr_d0 = (unsigned long *)(task->thread.esp0 + regoff[16]);
+			pr_err("register read from incomplete stack, regno %d offs %d orig_d0 %lx\n",
+				regno, off, *addr_d0);
+			return 0;
+		}
+		addr = (unsigned long *)(task->thread.esp0 + off);
+	} else
 		return 0;
 	/* Need to take stkadj into account. */
 	if (regno == PT_SR || regno == PT_PC) {
@@ -102,9 +121,22 @@ static inline int put_reg(struct task_struct *task, int regno,
 
 	if (regno == PT_USP)
 		addr = &task->thread.usp;
-	else if (regno < ARRAY_SIZE(regoff))
-		addr = (unsigned long *)(task->thread.esp0 + regoff[regno]);
-	else
+	else if (regno < ARRAY_SIZE(regoff)) {
+		int off = regoff[regno];
+
+		if (WARN_ON_ONCE((off < PT_REG(d1)) &&
+			test_ti_thread_status(task_thread_info(task), TIS_TRACING) &&
+			!test_ti_thread_status(task_thread_info(task),
+					     TIS_ALLREGS_SAVED))) {
+			unsigned long *addr_d0;
+
+			addr_d0 = (unsigned long *)(task->thread.esp0 + regoff[16]);
+			pr_err("register write to incomplete stack, regno %d offs %d orig_d0 %lx\n",
+				regno, off, *addr_d0);
+			return -1;
+		}
+		addr = (unsigned long *)(task->thread.esp0 + off);
+	} else
 		return -1;
 	/* Need to take stkadj into account. */
 	if (regno == PT_SR || regno == PT_PC) {
-- 
2.7.4

