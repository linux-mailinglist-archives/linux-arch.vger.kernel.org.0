Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9531E005A
	for <lists+linux-arch@lfdr.de>; Sun, 24 May 2020 18:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgEXQAx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 May 2020 12:00:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbgEXQAx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 24 May 2020 12:00:53 -0400
Received: from localhost.localdomain (unknown [115.204.118.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D544220878;
        Sun, 24 May 2020 16:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590336052;
        bh=KhUdwmuzSH0N8u0r8mIa4a8FTVYRHuHTLkI28CPI384=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jxZA+Hh5adEkNLzVvHVSDUrAkIDo8YzRZwfJkol8vNe8JJXOZnGU9CzkD2g/Uvtpq
         MtnZi/+vvyfuR7i+2kHhni7Dv3RkOHVJNmeP8v26lzsS2ohrZMLRgo9LGawuN7Wh6r
         W+TB1+nIphqiPSTJLprPUx+iqZ6Xt/cqu17r7gZk=
From:   guoren@kernel.org
To:     linux-csky@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arnd.de, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 3/3] csky: Coding convention in entry.S
Date:   Sun, 24 May 2020 15:59:24 +0000
Message-Id: <1590335964-79023-3-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590335964-79023-1-git-send-email-guoren@kernel.org>
References: <1590335964-79023-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

There is no fixup or feature in the patch, we only cleanup with:

 - Remove unnecessary reg used (r11, r12), just use r9 & r10 &
   syscallid regs as temp useage.
 - Add _TIF_SYSCALL_WORK and _TIF_WORK_MASK to gather macros.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/abiv1/inc/abi/entry.h     |  5 ---
 arch/csky/abiv2/inc/abi/entry.h     |  5 ---
 arch/csky/include/asm/thread_info.h |  6 ++++
 arch/csky/kernel/entry.S            | 66 ++++++++++++++++++++-----------------
 4 files changed, 42 insertions(+), 40 deletions(-)

diff --git a/arch/csky/abiv1/inc/abi/entry.h b/arch/csky/abiv1/inc/abi/entry.h
index b3559db..13c23e2 100644
--- a/arch/csky/abiv1/inc/abi/entry.h
+++ b/arch/csky/abiv1/inc/abi/entry.h
@@ -174,9 +174,4 @@
 	movi	r6, 0
 	cpwcr	r6, cpcr31
 .endm
-
-.macro ANDI_R3 rx, imm
-	lsri	\rx, 3
-	andi	\rx, (\imm >> 3)
-.endm
 #endif /* __ASM_CSKY_ENTRY_H */
diff --git a/arch/csky/abiv2/inc/abi/entry.h b/arch/csky/abiv2/inc/abi/entry.h
index 6ee71bf..4fdd6c1 100644
--- a/arch/csky/abiv2/inc/abi/entry.h
+++ b/arch/csky/abiv2/inc/abi/entry.h
@@ -302,9 +302,4 @@
 	jmpi	3f /* jump to va */
 3:
 .endm
-
-.macro ANDI_R3 rx, imm
-	lsri	\rx, 3
-	andi	\rx, (\imm >> 3)
-.endm
 #endif /* __ASM_CSKY_ENTRY_H */
diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/thread_info.h
index 5c61e84..8980e4e 100644
--- a/arch/csky/include/asm/thread_info.h
+++ b/arch/csky/include/asm/thread_info.h
@@ -81,4 +81,10 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_RESTORE_SIGMASK	(1 << TIF_RESTORE_SIGMASK)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 
+#define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
+				 _TIF_NOTIFY_RESUME | _TIF_UPROBE)
+
+#define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
+				 _TIF_SYSCALL_TRACEPOINT)
+
 #endif	/* _ASM_CSKY_THREAD_INFO_H */
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index 76dc729..9595e86 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -134,31 +134,32 @@ ENTRY(csky_systemcall)
 #endif
 	psrset  ee, ie
 
-	lrw     r11, __NR_syscalls
-	cmphs   syscallid, r11		/* Check nr of syscall */
+	lrw     r9, __NR_syscalls
+	cmphs   syscallid, r9		/* Check nr of syscall */
 	bt      ret_from_exception
 
-	lrw     r13, sys_call_table
-	ixw     r13, syscallid
-	ldw     r11, (r13)
-	cmpnei  r11, 0
+	lrw     r9, sys_call_table
+	ixw     r9, syscallid
+	ldw     syscallid, (r9)
+	cmpnei  syscallid, 0
 	bf      ret_from_exception
 
 	mov     r9, sp
 	bmaski  r10, THREAD_SHIFT
 	andn    r9, r10
-	ldw     r12, (r9, TINFO_FLAGS)
-	ANDI_R3	r12, (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_AUDIT)
-	cmpnei	r12, 0
+	ldw     r10, (r9, TINFO_FLAGS)
+	lrw	r9, _TIF_SYSCALL_WORK
+	and	r10, r9
+	cmpnei	r10, 0
 	bt      csky_syscall_trace
 #if defined(__CSKYABIV2__)
 	subi    sp, 8
 	stw  	r5, (sp, 0x4)
 	stw  	r4, (sp, 0x0)
-	jsr     r11                      /* Do system call */
+	jsr     syscallid                      /* Do system call */
 	addi 	sp, 8
 #else
-	jsr     r11
+	jsr     syscallid
 #endif
 	stw     a0, (sp, LSAVE_A0)      /* Save return value */
 	jmpi    ret_from_exception
@@ -177,13 +178,12 @@ csky_syscall_trace:
 	stw	r9, (sp, 0x0)
 	ldw	r9, (sp, LSAVE_A5)
 	stw	r9, (sp, 0x4)
+	jsr	syscallid                     /* Do system call */
+	addi	sp, 8
 #else
 	ldw	r6, (sp, LSAVE_A4)
 	ldw	r7, (sp, LSAVE_A5)
-#endif
-	jsr	r11                     /* Do system call */
-#if defined(__CSKYABIV2__)
-	addi	sp, 8
+	jsr	syscallid                     /* Do system call */
 #endif
 	stw	a0, (sp, LSAVE_A0)	/* Save return value */
 
@@ -202,18 +202,20 @@ ENTRY(ret_from_fork)
 	mov	r9, sp
 	bmaski	r10, THREAD_SHIFT
 	andn	r9, r10
-	ldw	r12, (r9, TINFO_FLAGS)
-	ANDI_R3	r12, (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_AUDIT)
-	cmpnei	r12, 0
+	ldw	r10, (r9, TINFO_FLAGS)
+	lrw	r9, _TIF_SYSCALL_WORK
+	and	r10, r9
+	cmpnei	r10, 0
 	bf	ret_from_exception
 	mov	a0, sp			/* sp = pt_regs pointer */
 	jbsr	syscall_trace_exit
 
 ret_from_exception:
 	psrclr	ie
-	ld	syscallid, (sp, LSAVE_PSR)
-	btsti	syscallid, 31
+	ld	r9, (sp, LSAVE_PSR)
+	btsti	r9, 31
 
+	bt	1f
 	/*
 	 * Load address of current->thread_info, Then get address of task_struct
 	 * Get task_needreshed in task_struct
@@ -222,15 +224,19 @@ ret_from_exception:
 	bmaski	r10, THREAD_SHIFT
 	andn	r9, r10
 
-	bt	1f
-	ldw	r12, (r9, TINFO_FLAGS)
-	andi	r12, (_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED | _TIF_UPROBE)
-	cmpnei	r12, 0
+	ldw	r10, (r9, TINFO_FLAGS)
+	lrw	r9, _TIF_WORK_MASK
+	and	r10, r9
+	cmpnei	r10, 0
 	bt	exit_work
 1:
 #ifdef CONFIG_PREEMPTION
-	ldw	r12, (r9, TINFO_PREEMPT)
-	cmpnei	r12, 0
+	mov	r9, sp
+	bmaski	r10, THREAD_SHIFT
+	andn	r9, r10
+
+	ldw	r10, (r9, TINFO_PREEMPT)
+	cmpnei	r10, 0
 	bt	2f
 	jbsr	preempt_schedule_irq	/* irq en/disable is done inside */
 2:
@@ -246,15 +252,15 @@ ret_from_exception:
 	RESTORE_ALL
 
 exit_work:
-	lrw	syscallid, ret_from_exception
-	mov	lr, syscallid
+	lrw	r9, ret_from_exception
+	mov	lr, r9
 
-	btsti	r12, TIF_NEED_RESCHED
+	btsti	r10, TIF_NEED_RESCHED
 	bt	work_resched
 
 	psrset	ie
 	mov	a0, sp
-	mov	a1, r12
+	mov	a1, r10
 	jmpi	do_notify_resume
 
 work_resched:
-- 
2.7.4

