Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B6520E4A1
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391108AbgF2V10 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729063AbgF2Smo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:44 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8843C033C0C;
        Mon, 29 Jun 2020 11:26:30 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyU9-002Dtt-I2; Mon, 29 Jun 2020 18:26:29 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 11/41] sparc64: get rid of odd callers of copy_regset_to_user()
Date:   Mon, 29 Jun 2020 19:25:58 +0100
Message-Id: <20200629182628.529995-11-viro@ZenIV.linux.org.uk>
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

same as for sparc32, and that's it - no more caller of ->get() with
non-zero pos.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sparc/kernel/ptrace_64.c | 175 ++++++++++++++++++++++++++++++++----------
 1 file changed, 136 insertions(+), 39 deletions(-)

diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index f7b2ddfc81d6..1b1910b67ca4 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -258,7 +258,7 @@ static int genregs64_get(struct task_struct *target,
 	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
 				  regs->u_regs,
 				  0, 16 * sizeof(u64));
-	if (!ret && count && pos < (32 * sizeof(u64))) {
+	if (!ret && count) {
 		struct reg_window window;
 
 		if (regwindow64_get(target, regs, &window))
@@ -506,6 +506,57 @@ static const struct user_regset sparc64_regsets[] = {
 	},
 };
 
+static int getregs64_get(struct task_struct *target,
+			 const struct user_regset *regset,
+			 unsigned int pos, unsigned int count,
+			 void *kbuf, void __user *ubuf)
+{
+	const struct pt_regs *regs = task_pt_regs(target);
+	int ret;
+
+	if (target == current)
+		flushw_user();
+
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				  regs->u_regs + 1,
+				  0, 15 * sizeof(u64));
+	if (!ret)
+		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
+				  15 * sizeof(u64), 16 * sizeof(u64));
+	if (!ret) {
+		/* TSTATE, TPC, TNPC */
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+					  &regs->tstate,
+					  16 * sizeof(u64),
+					  19 * sizeof(u64));
+	}
+	if (!ret) {
+		unsigned long y = regs->y;
+
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+					  &y,
+					  19 * sizeof(u64),
+					  20 * sizeof(u64));
+	}
+	return ret;
+}
+
+static const struct user_regset ptrace64_regsets[] = {
+	/* Format is:
+	 *      G1 --> G7
+	 *      O0 --> O7
+	 *	0
+	 *      TSTATE, TPC, TNPC, Y
+	 */
+	[REGSET_GENERAL] = {
+		.n = 20, .size = sizeof(u64), .get = getregs64_get,
+	},
+};
+
+static const struct user_regset_view ptrace64_view = {
+	.regsets = ptrace64_regsets, .n = ARRAY_SIZE(ptrace64_regsets)
+};
+
 static const struct user_regset_view user_sparc64_view = {
 	.name = "sparc64", .e_machine = EM_SPARCV9,
 	.regsets = sparc64_regsets, .n = ARRAY_SIZE(sparc64_regsets)
@@ -533,7 +584,7 @@ static int genregs32_get(struct task_struct *target,
 		for (; count > 0 && pos < 16; count--)
 			*k++ = regs->u_regs[pos++];
 
-		if (count && pos < 32) {
+		if (count) {
 			if (get_from_target(target, regs->u_regs[UREG_I6],
 					uregs, sizeof(uregs)))
 				return -EFAULT;
@@ -545,7 +596,7 @@ static int genregs32_get(struct task_struct *target,
 		for (; count > 0 && pos < 16; count--)
 			if (put_user((compat_ulong_t) regs->u_regs[pos++], u++))
 				return -EFAULT;
-		if (count && pos < 32) {
+		if (count) {
 			if (get_from_target(target, regs->u_regs[UREG_I6],
 					uregs, sizeof(uregs)))
 				return -EFAULT;
@@ -840,6 +891,76 @@ static const struct user_regset sparc32_regsets[] = {
 	},
 };
 
+static int getregs_get(struct task_struct *target,
+		       const struct user_regset *regset,
+		       unsigned int pos, unsigned int count,
+		       void *kbuf, void __user *ubuf)
+{
+	const struct pt_regs *regs = task_pt_regs(target);
+	u32 uregs[19];
+	int i;
+
+	if (target == current)
+		flushw_user();
+
+	uregs[0] = tstate_to_psr(regs->tstate);
+	uregs[1] = regs->tpc;
+	uregs[2] = regs->tnpc;
+	uregs[3] = regs->y;
+	for (i = 1; i < 16; i++)
+		uregs[3 + i] = regs->u_regs[i];
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				   uregs,
+				   0, 19 * sizeof(u32));
+}
+
+static int getfpregs_get(struct task_struct *target,
+			const struct user_regset *regset,
+			unsigned int pos, unsigned int count,
+			void *kbuf, void __user *ubuf)
+{
+	const unsigned long *fpregs = task_thread_info(target)->fpregs;
+	unsigned long fprs;
+	compat_ulong_t fsr;
+	int ret = 0;
+
+	if (target == current)
+		save_and_clear_fpu();
+
+	fprs = task_thread_info(target)->fpsaved[0];
+	if (fprs & FPRS_FEF) {
+		fsr = task_thread_info(target)->xfsr[0];
+	} else {
+		fsr = 0;
+	}
+
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				  fpregs,
+				  0, 32 * sizeof(u32));
+	if (!ret)
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+					  &fsr,
+					  32 * sizeof(u32),
+					  33 * sizeof(u32));
+	if (!ret)
+		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
+					  33 * sizeof(u32), 68 * sizeof(u32));
+	return ret;
+}
+
+static const struct user_regset ptrace32_regsets[] = {
+	[REGSET_GENERAL] = {
+		.n = 19, .size = sizeof(u32), .get = getregs_get,
+	},
+	[REGSET_FP] = {
+		.n = 68, .size = sizeof(u32), .get = getfpregs_get,
+	},
+};
+
+static const struct user_regset_view ptrace32_view = {
+	.regsets = ptrace32_regsets, .n = ARRAY_SIZE(ptrace32_regsets)
+};
+
 static const struct user_regset_view user_sparc32_view = {
 	.name = "sparc", .e_machine = EM_SPARC,
 	.regsets = sparc32_regsets, .n = ARRAY_SIZE(sparc32_regsets)
@@ -889,15 +1010,10 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 		break;
 
 	case PTRACE_GETREGS:
-		ret = copy_regset_to_user(child, view, REGSET_GENERAL,
-					  32 * sizeof(u32),
-					  4 * sizeof(u32),
-					  &pregs->psr);
-		if (!ret)
-			ret = copy_regset_to_user(child, view, REGSET_GENERAL,
-						  1 * sizeof(u32),
-						  15 * sizeof(u32),
-						  &pregs->u_regs[0]);
+		ret = copy_regset_to_user(child, &ptrace32_view,
+					  REGSET_GENERAL, 0,
+					  19 * sizeof(u32),
+					  pregs);
 		break;
 
 	case PTRACE_SETREGS:
@@ -913,22 +1029,10 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 		break;
 
 	case PTRACE_GETFPREGS:
-		ret = copy_regset_to_user(child, view, REGSET_FP,
-					  0 * sizeof(u32),
-					  32 * sizeof(u32),
-					  &fps->regs[0]);
-		if (!ret)
-			ret = copy_regset_to_user(child, view, REGSET_FP,
-						  33 * sizeof(u32),
-						  1 * sizeof(u32),
-						  &fps->fsr);
-		if (!ret) {
-			if (__put_user(0, &fps->flags) ||
-			    __put_user(0, &fps->extra) ||
-			    __put_user(0, &fps->fpqd) ||
-			    clear_user(&fps->fpq[0], 32 * sizeof(unsigned int)))
-				ret = -EFAULT;
-		}
+		ret = copy_regset_to_user(child, &ptrace32_view,
+					  REGSET_FP, 0,
+					  68 * sizeof(u32),
+					  fps);
 		break;
 
 	case PTRACE_SETFPREGS:
@@ -999,17 +1103,10 @@ long arch_ptrace(struct task_struct *child, long request,
 		break;
 
 	case PTRACE_GETREGS64:
-		ret = copy_regset_to_user(child, view, REGSET_GENERAL,
-					  1 * sizeof(u64),
-					  15 * sizeof(u64),
-					  &pregs->u_regs[0]);
-		if (!ret) {
-			/* XXX doesn't handle 'y' register correctly XXX */
-			ret = copy_regset_to_user(child, view, REGSET_GENERAL,
-						  32 * sizeof(u64),
-						  4 * sizeof(u64),
-						  &pregs->tstate);
-		}
+		ret = copy_regset_to_user(child, &ptrace64_view,
+					  REGSET_GENERAL, 0,
+					  19 * sizeof(u64),
+					  pregs);
 		break;
 
 	case PTRACE_SETREGS64:
-- 
2.11.0

