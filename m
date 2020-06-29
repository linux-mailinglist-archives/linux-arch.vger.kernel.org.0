Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1240B20E4BD
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388448AbgF2V2a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729034AbgF2Smn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:43 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D67C033C20;
        Mon, 29 Jun 2020 11:26:33 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyUB-002Dvq-Ph; Mon, 29 Jun 2020 18:26:31 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 27/41] arc: switch to ->get2()
Date:   Mon, 29 Jun 2020 19:26:14 +0100
Message-Id: <20200629182628.529995-27-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

NB: it used to do short store; fix is needed earlier in the series.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/arc/kernel/ptrace.c | 148 +++++++++++++++++++----------------------------
 1 file changed, 58 insertions(+), 90 deletions(-)

diff --git a/arch/arc/kernel/ptrace.c b/arch/arc/kernel/ptrace.c
index f49a054a1016..350aefbd7fdb 100644
--- a/arch/arc/kernel/ptrace.c
+++ b/arch/arc/kernel/ptrace.c
@@ -18,88 +18,61 @@ static struct callee_regs *task_callee_regs(struct task_struct *tsk)
 
 static int genregs_get(struct task_struct *target,
 		       const struct user_regset *regset,
-		       unsigned int pos, unsigned int count,
-		       void *kbuf, void __user *ubuf)
+		       struct membuf to)
 {
 	const struct pt_regs *ptregs = task_pt_regs(target);
 	const struct callee_regs *cregs = task_callee_regs(target);
-	int ret = 0;
 	unsigned int stop_pc_val;
 
-#define REG_O_CHUNK(START, END, PTR)	\
-	if (!ret)	\
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, PTR, \
-			offsetof(struct user_regs_struct, START), \
-			offsetof(struct user_regs_struct, END));
-
-#define REG_O_ONE(LOC, PTR)	\
-	if (!ret)		\
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, PTR, \
-			offsetof(struct user_regs_struct, LOC), \
-			offsetof(struct user_regs_struct, LOC) + 4);
-
-#define REG_O_ZERO(LOC)		\
-	if (!ret)		\
-		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf, \
-			offsetof(struct user_regs_struct, LOC), \
-			offsetof(struct user_regs_struct, LOC) + 4);
-
-	REG_O_ZERO(pad);
-	REG_O_ONE(scratch.bta, &ptregs->bta);
-	REG_O_ONE(scratch.lp_start, &ptregs->lp_start);
-	REG_O_ONE(scratch.lp_end, &ptregs->lp_end);
-	REG_O_ONE(scratch.lp_count, &ptregs->lp_count);
-	REG_O_ONE(scratch.status32, &ptregs->status32);
-	REG_O_ONE(scratch.ret, &ptregs->ret);
-	REG_O_ONE(scratch.blink, &ptregs->blink);
-	REG_O_ONE(scratch.fp, &ptregs->fp);
-	REG_O_ONE(scratch.gp, &ptregs->r26);
-	REG_O_ONE(scratch.r12, &ptregs->r12);
-	REG_O_ONE(scratch.r11, &ptregs->r11);
-	REG_O_ONE(scratch.r10, &ptregs->r10);
-	REG_O_ONE(scratch.r9, &ptregs->r9);
-	REG_O_ONE(scratch.r8, &ptregs->r8);
-	REG_O_ONE(scratch.r7, &ptregs->r7);
-	REG_O_ONE(scratch.r6, &ptregs->r6);
-	REG_O_ONE(scratch.r5, &ptregs->r5);
-	REG_O_ONE(scratch.r4, &ptregs->r4);
-	REG_O_ONE(scratch.r3, &ptregs->r3);
-	REG_O_ONE(scratch.r2, &ptregs->r2);
-	REG_O_ONE(scratch.r1, &ptregs->r1);
-	REG_O_ONE(scratch.r0, &ptregs->r0);
-	REG_O_ONE(scratch.sp, &ptregs->sp);
-
-	REG_O_ZERO(pad2);
-
-	REG_O_ONE(callee.r25, &cregs->r25);
-	REG_O_ONE(callee.r24, &cregs->r24);
-	REG_O_ONE(callee.r23, &cregs->r23);
-	REG_O_ONE(callee.r22, &cregs->r22);
-	REG_O_ONE(callee.r21, &cregs->r21);
-	REG_O_ONE(callee.r20, &cregs->r20);
-	REG_O_ONE(callee.r19, &cregs->r19);
-	REG_O_ONE(callee.r18, &cregs->r18);
-	REG_O_ONE(callee.r17, &cregs->r17);
-	REG_O_ONE(callee.r16, &cregs->r16);
-	REG_O_ONE(callee.r15, &cregs->r15);
-	REG_O_ONE(callee.r14, &cregs->r14);
-	REG_O_ONE(callee.r13, &cregs->r13);
-
-	REG_O_ONE(efa, &target->thread.fault_address);
-
-	if (!ret) {
-		if (in_brkpt_trap(ptregs)) {
-			stop_pc_val = target->thread.fault_address;
-			pr_debug("\t\tstop_pc (brk-pt)\n");
-		} else {
-			stop_pc_val = ptregs->ret;
-			pr_debug("\t\tstop_pc (others)\n");
-		}
-
-		REG_O_ONE(stop_pc, &stop_pc_val);
+	membuf_zero(&to, 4);	// pad
+	membuf_store(&to, ptregs->bta);
+	membuf_store(&to, ptregs->lp_start);
+	membuf_store(&to, ptregs->lp_end);
+	membuf_store(&to, ptregs->lp_count);
+	membuf_store(&to, ptregs->status32);
+	membuf_store(&to, ptregs->ret);
+	membuf_store(&to, ptregs->blink);
+	membuf_store(&to, ptregs->fp);
+	membuf_store(&to, ptregs->r26);	// gp
+	membuf_store(&to, ptregs->r12);
+	membuf_store(&to, ptregs->r11);
+	membuf_store(&to, ptregs->r10);
+	membuf_store(&to, ptregs->r9);
+	membuf_store(&to, ptregs->r8);
+	membuf_store(&to, ptregs->r7);
+	membuf_store(&to, ptregs->r6);
+	membuf_store(&to, ptregs->r5);
+	membuf_store(&to, ptregs->r4);
+	membuf_store(&to, ptregs->r3);
+	membuf_store(&to, ptregs->r2);
+	membuf_store(&to, ptregs->r1);
+	membuf_store(&to, ptregs->r0);
+	membuf_store(&to, ptregs->sp);
+	membuf_zero(&to, 4);	// pad2
+	membuf_store(&to, cregs->r25);
+	membuf_store(&to, cregs->r24);
+	membuf_store(&to, cregs->r23);
+	membuf_store(&to, cregs->r22);
+	membuf_store(&to, cregs->r21);
+	membuf_store(&to, cregs->r20);
+	membuf_store(&to, cregs->r19);
+	membuf_store(&to, cregs->r18);
+	membuf_store(&to, cregs->r17);
+	membuf_store(&to, cregs->r16);
+	membuf_store(&to, cregs->r15);
+	membuf_store(&to, cregs->r14);
+	membuf_store(&to, cregs->r13);
+	membuf_store(&to, target->thread.fault_address); // efa
+
+	if (in_brkpt_trap(ptregs)) {
+		stop_pc_val = target->thread.fault_address;
+		pr_debug("\t\tstop_pc (brk-pt)\n");
+	} else {
+		stop_pc_val = ptregs->ret;
+		pr_debug("\t\tstop_pc (others)\n");
 	}
 
-	return ret;
+	return membuf_store(&to, stop_pc_val); // stop_pc
 }
 
 static int genregs_set(struct task_struct *target,
@@ -184,25 +157,20 @@ static int genregs_set(struct task_struct *target,
 #ifdef CONFIG_ISA_ARCV2
 static int arcv2regs_get(struct task_struct *target,
 		       const struct user_regset *regset,
-		       unsigned int pos, unsigned int count,
-		       void *kbuf, void __user *ubuf)
+		       struct membuf to)
 {
 	const struct pt_regs *regs = task_pt_regs(target);
-	int ret, copy_sz;
 
 	if (IS_ENABLED(CONFIG_ARC_HAS_ACCL_REGS))
-		copy_sz = sizeof(struct user_regs_arcv2);
-	else
-		copy_sz = 4;	/* r30 only */
+		/*
+		 * itemized copy not needed like above as layout of regs (r30,r58,r59)
+		 * is exactly same in kernel (pt_regs) and userspace (user_regs_arcv2)
+		 */
+		return membuf_write(&to, &regs->r30, sizeof(struct user_regs_arcv2));
 
-	/*
-	 * itemized copy not needed like above as layout of regs (r30,r58,r59)
-	 * is exactly same in kernel (pt_regs) and userspace (user_regs_arcv2)
-	 */
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &regs->r30,
-				  0, copy_sz);
 
-	return ret;
+	membuf_write(&to, &regs->r30, 4); /* r30 only */
+	return membuf_zero(&to, sizeof(struct user_regs_arcv2) - 4);
 }
 
 static int arcv2regs_set(struct task_struct *target,
@@ -237,7 +205,7 @@ static const struct user_regset arc_regsets[] = {
 	       .n = ELF_NGREG,
 	       .size = sizeof(unsigned long),
 	       .align = sizeof(unsigned long),
-	       .get = genregs_get,
+	       .get2 = genregs_get,
 	       .set = genregs_set,
 	},
 #ifdef CONFIG_ISA_ARCV2
@@ -246,7 +214,7 @@ static const struct user_regset arc_regsets[] = {
 	       .n = ELF_ARCV2REG,
 	       .size = sizeof(unsigned long),
 	       .align = sizeof(unsigned long),
-	       .get = arcv2regs_get,
+	       .get2 = arcv2regs_get,
 	       .set = arcv2regs_set,
 	},
 #endif
-- 
2.11.0

