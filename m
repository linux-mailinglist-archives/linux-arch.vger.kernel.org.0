Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57181E0056
	for <lists+linux-arch@lfdr.de>; Sun, 24 May 2020 18:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgEXQAR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 May 2020 12:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbgEXQAQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 24 May 2020 12:00:16 -0400
Received: from localhost.localdomain (unknown [115.204.118.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F3A2207DA;
        Sun, 24 May 2020 16:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590336015;
        bh=BUhsWD4oWpM3tqZNJvJe/0Eco6EoJf1W0s4LSlSBdOc=;
        h=From:To:Cc:Subject:Date:From;
        b=Sy+7F5LYJqaBKl5O5BQ+pVpUsP7uU+n0fERMhGBSgSwoVE4EtrBGvqERRMwX+VSi0
         hrIKwRzQbCUqUs1+ij8Z/RqHfM2I3qQ9lKjkJNbJ9AvR9kVYFAG3PZuagdngjOi1Ei
         5nCQEhbdfDOjcYeWHJQS2QfDtrtR7lUmujDiN520=
From:   guoren@kernel.org
To:     linux-csky@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arnd.de, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 1/3] csky: Fixup CONFIG_PREEMPT panic
Date:   Sun, 24 May 2020 15:59:22 +0000
Message-Id: <1590335964-79023-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

log:
[    0.13373200] Calibrating delay loop...
[    0.14077600] ------------[ cut here ]------------
[    0.14116700] WARNING: CPU: 0 PID: 0 at kernel/sched/core.c:3790 preempt_count_add+0xc8/0x11c
[    0.14348000] DEBUG_LOCKS_WARN_ON((preempt_count() < 0))Modules linked in:
[    0.14395100] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.6.0 #7
[    0.14410800]
[    0.14427400] Call Trace:
[    0.14450700] [<807cd226>] dump_stack+0x8a/0xe4
[    0.14473500] [<80072792>] __warn+0x10e/0x15c
[    0.14495900] [<80072852>] warn_slowpath_fmt+0x72/0xc0
[    0.14518600] [<800a5240>] preempt_count_add+0xc8/0x11c
[    0.14544900] [<807ef918>] _raw_spin_lock+0x28/0x68
[    0.14572600] [<800e0eb8>] vprintk_emit+0x84/0x2d8
[    0.14599000] [<800e113a>] vprintk_default+0x2e/0x44
[    0.14625100] [<800e2042>] vprintk_func+0x12a/0x1d0
[    0.14651300] [<800e1804>] printk+0x30/0x48
[    0.14677600] [<80008052>] lockdep_init+0x12/0xb0
[    0.14703800] [<80002080>] start_kernel+0x558/0x7f8
[    0.14730000] [<800052bc>] csky_start+0x58/0x94
[    0.14756600] irq event stamp: 34
[    0.14775100] hardirqs last  enabled at (33): [<80067370>] ret_from_exception+0x2c/0x72
[    0.14793700] hardirqs last disabled at (34): [<800e0eae>] vprintk_emit+0x7a/0x2d8
[    0.14812300] softirqs last  enabled at (32): [<800655b0>] __do_softirq+0x578/0x6d8
[    0.14830800] softirqs last disabled at (25): [<8007b3b8>] irq_exit+0xec/0x128

The preempt_count of reg could be destroyed after csky_do_IRQ without reload
from memory.

After reference to other architectures (arm64, riscv), we move preempt entry
into ret_from_exception and disable irq at the beginning of
ret_from_exception instead of RESTORE_ALL.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reported-by: Lu Baoquan <lu.baoquan@intellif.com>
---
 arch/csky/abiv1/inc/abi/entry.h |  1 -
 arch/csky/abiv2/inc/abi/entry.h |  1 -
 arch/csky/kernel/entry.S        | 36 +++++++++++-------------------------
 3 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/arch/csky/abiv1/inc/abi/entry.h b/arch/csky/abiv1/inc/abi/entry.h
index 61d94ec..b3559db 100644
--- a/arch/csky/abiv1/inc/abi/entry.h
+++ b/arch/csky/abiv1/inc/abi/entry.h
@@ -80,7 +80,6 @@
 .endm
 
 .macro	RESTORE_ALL
-	psrclr  ie
 	ldw	lr, (sp, 4)
 	ldw     a0, (sp, 8)
 	mtcr    a0, epc
diff --git a/arch/csky/abiv2/inc/abi/entry.h b/arch/csky/abiv2/inc/abi/entry.h
index ab63c41..698df2f 100644
--- a/arch/csky/abiv2/inc/abi/entry.h
+++ b/arch/csky/abiv2/inc/abi/entry.h
@@ -63,7 +63,6 @@
 .endm
 
 .macro	RESTORE_ALL
-	psrclr  ie
 	ldw	tls, (sp, 0)
 	ldw	lr, (sp, 4)
 	ldw	a0, (sp, 8)
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index 3760397..bfbef30 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -208,9 +208,9 @@ ENTRY(ret_from_fork)
 	jbsr	syscall_trace_exit
 
 ret_from_exception:
+	psrclr	ie
 	ld	syscallid, (sp, LSAVE_PSR)
 	btsti	syscallid, 31
-	bt	1f
 
 	/*
 	 * Load address of current->thread_info, Then get address of task_struct
@@ -220,11 +220,20 @@ ret_from_exception:
 	bmaski	r10, THREAD_SHIFT
 	andn	r9, r10
 
+	bt	1f
 	ldw	r12, (r9, TINFO_FLAGS)
 	andi	r12, (_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED | _TIF_UPROBE)
 	cmpnei	r12, 0
 	bt	exit_work
 1:
+#ifdef CONFIG_PREEMPTION
+	ldw	r12, (r9, TINFO_PREEMPT)
+	cmpnei	r12, 0
+	bt	2f
+	jbsr	preempt_schedule_irq	/* irq en/disable is done inside */
+2:
+#endif
+
 #ifdef CONFIG_TRACE_IRQFLAGS
 	ld	r10, (sp, LSAVE_PSR)
 	btsti	r10, 6
@@ -241,6 +250,7 @@ exit_work:
 	btsti	r12, TIF_NEED_RESCHED
 	bt	work_resched
 
+	psrset	ie
 	mov	a0, sp
 	mov	a1, r12
 	jmpi	do_notify_resume
@@ -291,34 +301,10 @@ ENTRY(csky_irq)
 	jbsr	trace_hardirqs_off
 #endif
 
-#ifdef CONFIG_PREEMPTION
-	mov	r9, sp			/* Get current stack  pointer */
-	bmaski	r10, THREAD_SHIFT
-	andn	r9, r10			/* Get thread_info */
-
-	/*
-	 * Get task_struct->stack.preempt_count for current,
-	 * and increase 1.
-	 */
-	ldw	r12, (r9, TINFO_PREEMPT)
-	addi	r12, 1
-	stw	r12, (r9, TINFO_PREEMPT)
-#endif
 
 	mov	a0, sp
 	jbsr	csky_do_IRQ
 
-#ifdef CONFIG_PREEMPTION
-	subi	r12, 1
-	stw	r12, (r9, TINFO_PREEMPT)
-	cmpnei	r12, 0
-	bt	2f
-	ldw	r12, (r9, TINFO_FLAGS)
-	btsti	r12, TIF_NEED_RESCHED
-	bf	2f
-	jbsr	preempt_schedule_irq	/* irq en/disable is done inside */
-#endif
-2:
 	jmpi	ret_from_exception
 
 /*
-- 
2.7.4

