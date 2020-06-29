Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCD520D1A5
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 20:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgF2Smn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 14:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729006AbgF2Smm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:42 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E04C033C1B;
        Mon, 29 Jun 2020 11:26:32 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyUB-002Dvc-FI; Mon, 29 Jun 2020 18:26:31 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 26/41] arm: switch to ->get2()
Date:   Mon, 29 Jun 2020 19:26:13 +0100
Message-Id: <20200629182628.529995-26-viro@ZenIV.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/arm/kernel/ptrace.c | 52 +++++++++++-------------------------------------
 1 file changed, 12 insertions(+), 40 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index d0f7c8896c96..895388288093 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -569,14 +569,9 @@ static int ptrace_sethbpregs(struct task_struct *tsk, long num,
 
 static int gpr_get(struct task_struct *target,
 		   const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
+		   struct membuf to)
 {
-	struct pt_regs *regs = task_pt_regs(target);
-
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   regs,
-				   0, sizeof(*regs));
+	return membuf_write(&to, task_pt_regs(target), sizeof(struct pt_regs));
 }
 
 static int gpr_set(struct task_struct *target,
@@ -602,12 +597,10 @@ static int gpr_set(struct task_struct *target,
 
 static int fpa_get(struct task_struct *target,
 		   const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
+		   struct membuf to)
 {
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   &task_thread_info(target)->fpstate,
-				   0, sizeof(struct user_fp));
+	return membuf_write(&to, &task_thread_info(target)->fpstate,
+				 sizeof(struct user_fp));
 }
 
 static int fpa_set(struct task_struct *target,
@@ -642,41 +635,20 @@ static int fpa_set(struct task_struct *target,
  *	vfp_set() ignores this chunk
  *
  * 1 word for the FPSCR
- *
- * The bounds-checking logic built into user_regset_copyout and friends
- * means that we can make a simple sequence of calls to map the relevant data
- * to/from the specified slice of the user regset structure.
  */
 static int vfp_get(struct task_struct *target,
 		   const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
+		   struct membuf to)
 {
-	int ret;
 	struct thread_info *thread = task_thread_info(target);
 	struct vfp_hard_struct const *vfp = &thread->vfpstate.hard;
-	const size_t user_fpregs_offset = offsetof(struct user_vfp, fpregs);
 	const size_t user_fpscr_offset = offsetof(struct user_vfp, fpscr);
 
 	vfp_sync_hwstate(thread);
 
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  &vfp->fpregs,
-				  user_fpregs_offset,
-				  user_fpregs_offset + sizeof(vfp->fpregs));
-	if (ret)
-		return ret;
-
-	ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-				       user_fpregs_offset + sizeof(vfp->fpregs),
-				       user_fpscr_offset);
-	if (ret)
-		return ret;
-
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   &vfp->fpscr,
-				   user_fpscr_offset,
-				   user_fpscr_offset + sizeof(vfp->fpscr));
+	membuf_write(&to, vfp->fpregs, sizeof(vfp->fpregs));
+	membuf_zero(&to, user_fpscr_offset - sizeof(vfp->fpregs));
+	return membuf_store(&to, vfp->fpscr);
 }
 
 /*
@@ -739,7 +711,7 @@ static const struct user_regset arm_regsets[] = {
 		.n = ELF_NGREG,
 		.size = sizeof(u32),
 		.align = sizeof(u32),
-		.get = gpr_get,
+		.get2 = gpr_get,
 		.set = gpr_set
 	},
 	[REGSET_FPR] = {
@@ -751,7 +723,7 @@ static const struct user_regset arm_regsets[] = {
 		.n = sizeof(struct user_fp) / sizeof(u32),
 		.size = sizeof(u32),
 		.align = sizeof(u32),
-		.get = fpa_get,
+		.get2 = fpa_get,
 		.set = fpa_set
 	},
 #ifdef CONFIG_VFP
@@ -764,7 +736,7 @@ static const struct user_regset arm_regsets[] = {
 		.n = ARM_VFPREGS_SIZE / sizeof(u32),
 		.size = sizeof(u32),
 		.align = sizeof(u32),
-		.get = vfp_get,
+		.get2 = vfp_get,
 		.set = vfp_set
 	},
 #endif /* CONFIG_VFP */
-- 
2.11.0

