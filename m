Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9A7BEE3C
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2019 11:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfIZJQs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Sep 2019 05:16:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfIZJQr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Sep 2019 05:16:47 -0400
Received: from localhost.localdomain (unknown [115.205.68.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2173207FF;
        Thu, 26 Sep 2019 09:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569489406;
        bh=ilA+y4O1M/gMXREu86nRwRqJO5tcBAaEoE6amVY68e0=;
        h=From:To:Cc:Subject:Date:From;
        b=lskIgPGL21kyfsq0qY+dWq1rcIGHT4tm8IAu60K+kEN79HUZoTrWPeC/9tng9++7S
         iSbMZTouFEypmzLk/VnibTNHGDfprwbw62mjcHL0kImXX1+QQmfY6/r4h77WAZ83sr
         ygeWp0Zjxi0mPaf6/l1K5622nlAve3SkRWMz3lKk=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH] csky: Bugfix add zero_fp fixup perf backtrace panic
Date:   Thu, 26 Sep 2019 17:16:39 +0800
Message-Id: <1569489399-7026-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

We need set fp zero to let backtrace know the end. The patch fixup perf
callchain panic problem, because backtrace didn't know what is the end
of fp.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Reported-by: Mao Han <han_mao@c-sky.com>
---
 arch/csky/kernel/entry.S   | 50 +++++++++++++++++++++++++++-------------------
 arch/csky/kernel/process.c |  2 +-
 2 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index a7e84cc..564dab2 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -17,6 +17,12 @@
 #define PTE_INDX_SHIFT  10
 #define _PGDIR_SHIFT    22
 
+.macro	zero_fp
+#ifdef CONFIG_STACKTRACE
+	movi	r8, 0
+#endif
+.endm
+
 .macro tlbop_begin name, val0, val1, val2
 ENTRY(csky_\name)
 	mtcr    a3, ss2
@@ -96,6 +102,7 @@ ENTRY(csky_\name)
 	SAVE_ALL 0
 .endm
 .macro tlbop_end is_write
+	zero_fp
 	RD_MEH	a2
 	psrset  ee, ie
 	mov     a0, sp
@@ -120,6 +127,7 @@ tlbop_end 1
 
 ENTRY(csky_systemcall)
 	SAVE_ALL TRAP0_SIZE
+	zero_fp
 
 	psrset  ee, ie
 
@@ -136,9 +144,9 @@ ENTRY(csky_systemcall)
 	mov     r9, sp
 	bmaski  r10, THREAD_SHIFT
 	andn    r9, r10
-	ldw     r8, (r9, TINFO_FLAGS)
-	ANDI_R3	r8, (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_AUDIT)
-	cmpnei	r8, 0
+	ldw     r12, (r9, TINFO_FLAGS)
+	ANDI_R3	r12, (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_AUDIT)
+	cmpnei	r12, 0
 	bt      csky_syscall_trace
 #if defined(__CSKYABIV2__)
 	subi    sp, 8
@@ -180,7 +188,7 @@ csky_syscall_trace:
 
 ENTRY(ret_from_kernel_thread)
 	jbsr	schedule_tail
-	mov	a0, r8
+	mov	a0, r10
 	jsr	r9
 	jbsr	ret_from_exception
 
@@ -189,9 +197,9 @@ ENTRY(ret_from_fork)
 	mov	r9, sp
 	bmaski	r10, THREAD_SHIFT
 	andn	r9, r10
-	ldw	r8, (r9, TINFO_FLAGS)
-	ANDI_R3	r8, (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_AUDIT)
-	cmpnei	r8, 0
+	ldw	r12, (r9, TINFO_FLAGS)
+	ANDI_R3	r12, (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_AUDIT)
+	cmpnei	r12, 0
 	bf	ret_from_exception
 	mov	a0, sp			/* sp = pt_regs pointer */
 	jbsr	syscall_trace_exit
@@ -209,9 +217,9 @@ ret_from_exception:
 	bmaski	r10, THREAD_SHIFT
 	andn	r9, r10
 
-	ldw	r8, (r9, TINFO_FLAGS)
-	andi	r8, (_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED)
-	cmpnei	r8, 0
+	ldw	r12, (r9, TINFO_FLAGS)
+	andi	r12, (_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED)
+	cmpnei	r12, 0
 	bt	exit_work
 1:
 	RESTORE_ALL
@@ -220,11 +228,11 @@ exit_work:
 	lrw	syscallid, ret_from_exception
 	mov	lr, syscallid
 
-	btsti	r8, TIF_NEED_RESCHED
+	btsti	r12, TIF_NEED_RESCHED
 	bt	work_resched
 
 	mov	a0, sp
-	mov	a1, r8
+	mov	a1, r12
 	jmpi	do_notify_resume
 
 work_resched:
@@ -232,6 +240,7 @@ work_resched:
 
 ENTRY(csky_trap)
 	SAVE_ALL 0
+	zero_fp
 	psrset	ee
 	mov	a0, sp                 /* Push Stack pointer arg */
 	jbsr	trap_c                 /* Call C-level trap handler */
@@ -265,6 +274,7 @@ ENTRY(csky_get_tls)
 
 ENTRY(csky_irq)
 	SAVE_ALL 0
+	zero_fp
 	psrset	ee
 
 #ifdef CONFIG_PREEMPT
@@ -276,21 +286,21 @@ ENTRY(csky_irq)
 	 * Get task_struct->stack.preempt_count for current,
 	 * and increase 1.
 	 */
-	ldw	r8, (r9, TINFO_PREEMPT)
-	addi	r8, 1
-	stw	r8, (r9, TINFO_PREEMPT)
+	ldw	r12, (r9, TINFO_PREEMPT)
+	addi	r12, 1
+	stw	r12, (r9, TINFO_PREEMPT)
 #endif
 
 	mov	a0, sp
 	jbsr	csky_do_IRQ
 
 #ifdef CONFIG_PREEMPT
-	subi	r8, 1
-	stw	r8, (r9, TINFO_PREEMPT)
-	cmpnei	r8, 0
+	subi	r12, 1
+	stw	r12, (r9, TINFO_PREEMPT)
+	cmpnei	r12, 0
 	bt	2f
-	ldw	r8, (r9, TINFO_FLAGS)
-	btsti	r8, TIF_NEED_RESCHED
+	ldw	r12, (r9, TINFO_FLAGS)
+	btsti	r12, TIF_NEED_RESCHED
 	bf	2f
 1:
 	jbsr	preempt_schedule_irq	/* irq en/disable is done inside */
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index e555740..f320d92 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -55,7 +55,7 @@ int copy_thread(unsigned long clone_flags,
 	if (unlikely(p->flags & PF_KTHREAD)) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childstack->r15 = (unsigned long) ret_from_kernel_thread;
-		childstack->r8 = kthread_arg;
+		childstack->r10 = kthread_arg;
 		childstack->r9 = usp;
 		childregs->sr = mfcr("psr");
 	} else {
-- 
2.7.4

