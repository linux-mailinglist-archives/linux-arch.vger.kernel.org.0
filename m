Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC3020D1B6
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 20:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgF2SnQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 14:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbgF2Smx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:53 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E63C033C1E;
        Mon, 29 Jun 2020 11:26:33 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyUA-002Dv4-Sd; Mon, 29 Jun 2020 18:26:30 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 22/41] sparc: switch to ->get2()
Date:   Mon, 29 Jun 2020 19:26:09 +0100
Message-Id: <20200629182628.529995-22-viro@ZenIV.linux.org.uk>
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
 arch/sparc/kernel/ptrace_32.c | 127 ++++-----------
 arch/sparc/kernel/ptrace_64.c | 352 ++++++++++--------------------------------
 2 files changed, 110 insertions(+), 369 deletions(-)

diff --git a/arch/sparc/kernel/ptrace_32.c b/arch/sparc/kernel/ptrace_32.c
index 0856e0104539..948a1dcd8e98 100644
--- a/arch/sparc/kernel/ptrace_32.c
+++ b/arch/sparc/kernel/ptrace_32.c
@@ -83,39 +83,25 @@ static int regwindow32_set(struct task_struct *target,
 
 static int genregs32_get(struct task_struct *target,
 			 const struct user_regset *regset,
-			 unsigned int pos, unsigned int count,
-			 void *kbuf, void __user *ubuf)
+			 struct membuf to)
 {
 	const struct pt_regs *regs = target->thread.kregs;
 	u32 uregs[16];
-	int ret;
 
 	if (target == current)
 		flush_user_windows();
 
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  regs->u_regs,
-				  0, 16 * sizeof(u32));
-	if (ret || !count)
-		return ret;
-
+	membuf_write(&to, regs->u_regs, 16 * sizeof(u32));
+	if (!to.left)
+		return 0;
 	if (regwindow32_get(target, regs, uregs))
 		return -EFAULT;
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  uregs,
-				  16 * sizeof(u32), 32 * sizeof(u32));
-	if (ret)
-		return ret;
-
-	uregs[0] = regs->psr;
-	uregs[1] = regs->pc;
-	uregs[2] = regs->npc;
-	uregs[3] = regs->y;
-	uregs[4] = 0;	/* WIM */
-	uregs[5] = 0;	/* TBR */
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  uregs,
-				  32 * sizeof(u32), 38 * sizeof(u32));
+	membuf_write(&to, uregs, 16 * sizeof(u32));
+	membuf_store(&to, regs->psr);
+	membuf_store(&to, regs->pc);
+	membuf_store(&to, regs->npc);
+	membuf_store(&to, regs->y);
+	return membuf_zero(&to, 2 * sizeof(u32));
 }
 
 static int genregs32_set(struct task_struct *target,
@@ -179,46 +165,18 @@ static int genregs32_set(struct task_struct *target,
 
 static int fpregs32_get(struct task_struct *target,
 			const struct user_regset *regset,
-			unsigned int pos, unsigned int count,
-			void *kbuf, void __user *ubuf)
+			struct membuf to)
 {
-	const unsigned long *fpregs = target->thread.float_regs;
-	int ret = 0;
-
 #if 0
 	if (target == current)
 		save_and_clear_fpu();
 #endif
 
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  fpregs,
-				  0, 32 * sizeof(u32));
-
-	if (!ret)
-		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-					       32 * sizeof(u32),
-					       33 * sizeof(u32));
-	if (!ret)
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  &target->thread.fsr,
-					  33 * sizeof(u32),
-					  34 * sizeof(u32));
-
-	if (!ret) {
-		unsigned long val;
-
-		val = (1 << 8) | (8 << 16);
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  &val,
-					  34 * sizeof(u32),
-					  35 * sizeof(u32));
-	}
-
-	if (!ret)
-		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-					       35 * sizeof(u32), -1);
-
-	return ret;
+	membuf_write(&to, target->thread.float_regs, 32 * sizeof(u32));
+	membuf_zero(&to, sizeof(u32));
+	membuf_write(&to, &target->thread.fsr, sizeof(u32));
+	membuf_store(&to, (u32)((1 << 8) | (8 << 16)));
+	return membuf_zero(&to, 64 * sizeof(u32));
 }
 
 static int fpregs32_set(struct task_struct *target,
@@ -263,7 +221,7 @@ static const struct user_regset sparc32_regsets[] = {
 		.core_note_type = NT_PRSTATUS,
 		.n = 38,
 		.size = sizeof(u32), .align = sizeof(u32),
-		.get = genregs32_get, .set = genregs32_set
+		.get2 = genregs32_get, .set = genregs32_set
 	},
 	/* Format is:
 	 *	F0 --> F31
@@ -279,35 +237,24 @@ static const struct user_regset sparc32_regsets[] = {
 		.core_note_type = NT_PRFPREG,
 		.n = 99,
 		.size = sizeof(u32), .align = sizeof(u32),
-		.get = fpregs32_get, .set = fpregs32_set
+		.get2 = fpregs32_get, .set = fpregs32_set
 	},
 };
 
 static int getregs_get(struct task_struct *target,
 			 const struct user_regset *regset,
-			 unsigned int pos, unsigned int count,
-			 void *kbuf, void __user *ubuf)
+			 struct membuf to)
 {
 	const struct pt_regs *regs = target->thread.kregs;
-	u32 v[4];
-	int ret;
 
 	if (target == current)
 		flush_user_windows();
 
-	v[0] = regs->psr;
-	v[1] = regs->pc;
-	v[2] = regs->npc;
-	v[3] = regs->y;
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  v,
-				  0 * sizeof(u32), 4 * sizeof(u32));
-	if (ret)
-		return ret;
-
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  regs->u_regs + 1,
-				  4 * sizeof(u32), 19 * sizeof(u32));
+	membuf_store(&to, regs->psr);
+	membuf_store(&to, regs->pc);
+	membuf_store(&to, regs->npc);
+	membuf_store(&to, regs->y);
+	return membuf_write(&to, regs->u_regs + 1, 15 * sizeof(u32));
 }
 
 static int setregs_set(struct task_struct *target,
@@ -337,29 +284,15 @@ static int setregs_set(struct task_struct *target,
 
 static int getfpregs_get(struct task_struct *target,
 			const struct user_regset *regset,
-			unsigned int pos, unsigned int count,
-			void *kbuf, void __user *ubuf)
+			struct membuf to)
 {
-	const unsigned long *fpregs = target->thread.float_regs;
-	int ret = 0;
-
 #if 0
 	if (target == current)
 		save_and_clear_fpu();
 #endif
-
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  fpregs,
-				  0, 32 * sizeof(u32));
-	if (ret)
-		return ret;
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  &target->thread.fsr,
-				  32 * sizeof(u32), 33 * sizeof(u32));
-	if (ret)
-		return ret;
-	return user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-				  33 * sizeof(u32), 68 * sizeof(u32));
+	membuf_write(&to, &target->thread.float_regs, 32 * sizeof(u32));
+	membuf_write(&to, &target->thread.fsr, sizeof(u32));
+	return membuf_zero(&to, 35 * sizeof(u32));
 }
 
 static int setfpregs_set(struct task_struct *target,
@@ -388,11 +321,11 @@ static int setfpregs_set(struct task_struct *target,
 static const struct user_regset ptrace32_regsets[] = {
 	[REGSET_GENERAL] = {
 		.n = 19, .size = sizeof(u32),
-		.get = getregs_get, .set = setregs_set,
+		.get2 = getregs_get, .set = setregs_set,
 	},
 	[REGSET_FP] = {
 		.n = 68, .size = sizeof(u32),
-		.get = getfpregs_get, .set = setfpregs_set,
+		.get2 = getfpregs_get, .set = setfpregs_set,
 	},
 };
 
diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index 3c9eee12102a..8ac5a3e5b46c 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -246,52 +246,23 @@ enum sparc_regset {
 
 static int genregs64_get(struct task_struct *target,
 			 const struct user_regset *regset,
-			 unsigned int pos, unsigned int count,
-			 void *kbuf, void __user *ubuf)
+			 struct membuf to)
 {
 	const struct pt_regs *regs = task_pt_regs(target);
-	int ret;
+	struct reg_window window;
 
 	if (target == current)
 		flushw_user();
 
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  regs->u_regs,
-				  0, 16 * sizeof(u64));
-	if (!ret && count) {
-		struct reg_window window;
-
-		if (regwindow64_get(target, regs, &window))
-			return -EFAULT;
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  &window,
-					  16 * sizeof(u64),
-					  32 * sizeof(u64));
-	}
-
-	if (!ret) {
-		/* TSTATE, TPC, TNPC */
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  &regs->tstate,
-					  32 * sizeof(u64),
-					  35 * sizeof(u64));
-	}
-
-	if (!ret) {
-		unsigned long y = regs->y;
-
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  &y,
-					  35 * sizeof(u64),
-					  36 * sizeof(u64));
-	}
-
-	if (!ret) {
-		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-					       36 * sizeof(u64), -1);
-
-	}
-	return ret;
+	membuf_write(&to, regs->u_regs, 16 * sizeof(u64));
+	if (!to.left)
+		return 0;
+	if (regwindow64_get(target, regs, &window))
+		return -EFAULT;
+	membuf_write(&to, &window, 16 * sizeof(u64));
+	/* TSTATE, TPC, TNPC */
+	membuf_write(&to, &regs->tstate, 3 * sizeof(u64));
+	return membuf_store(&to, (u64)regs->y);
 }
 
 static int genregs64_set(struct task_struct *target,
@@ -370,69 +341,32 @@ static int genregs64_set(struct task_struct *target,
 
 static int fpregs64_get(struct task_struct *target,
 			const struct user_regset *regset,
-			unsigned int pos, unsigned int count,
-			void *kbuf, void __user *ubuf)
+			struct membuf to)
 {
-	const unsigned long *fpregs = task_thread_info(target)->fpregs;
-	unsigned long fprs, fsr, gsr;
-	int ret;
+	struct thread_info *t = task_thread_info(target);
+	unsigned long fprs;
 
 	if (target == current)
 		save_and_clear_fpu();
 
-	fprs = task_thread_info(target)->fpsaved[0];
+	fprs = t->fpsaved[0];
 
 	if (fprs & FPRS_DL)
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  fpregs,
-					  0, 16 * sizeof(u64));
+		membuf_write(&to, t->fpregs, 16 * sizeof(u64));
 	else
-		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-					       0,
-					       16 * sizeof(u64));
-
-	if (!ret) {
-		if (fprs & FPRS_DU)
-			ret = user_regset_copyout(&pos, &count,
-						  &kbuf, &ubuf,
-						  fpregs + 16,
-						  16 * sizeof(u64),
-						  32 * sizeof(u64));
-		else
-			ret = user_regset_copyout_zero(&pos, &count,
-						       &kbuf, &ubuf,
-						       16 * sizeof(u64),
-						       32 * sizeof(u64));
-	}
+		membuf_zero(&to, 16 * sizeof(u64));
 
+	if (fprs & FPRS_DU)
+		membuf_write(&to, t->fpregs + 16, 16 * sizeof(u64));
+	else
+		membuf_zero(&to, 16 * sizeof(u64));
 	if (fprs & FPRS_FEF) {
-		fsr = task_thread_info(target)->xfsr[0];
-		gsr = task_thread_info(target)->gsr[0];
+		membuf_store(&to, t->xfsr[0]);
+		membuf_store(&to, t->gsr[0]);
 	} else {
-		fsr = gsr = 0;
+		membuf_zero(&to, 2 * sizeof(u64));
 	}
-
-	if (!ret)
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  &fsr,
-					  32 * sizeof(u64),
-					  33 * sizeof(u64));
-	if (!ret)
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  &gsr,
-					  33 * sizeof(u64),
-					  34 * sizeof(u64));
-	if (!ret)
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  &fprs,
-					  34 * sizeof(u64),
-					  35 * sizeof(u64));
-
-	if (!ret)
-		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-					       35 * sizeof(u64), -1);
-
-	return ret;
+	return membuf_store(&to, fprs);
 }
 
 static int fpregs64_set(struct task_struct *target,
@@ -490,7 +424,7 @@ static const struct user_regset sparc64_regsets[] = {
 		.core_note_type = NT_PRSTATUS,
 		.n = 36,
 		.size = sizeof(u64), .align = sizeof(u64),
-		.get = genregs64_get, .set = genregs64_set
+		.get2 = genregs64_get, .set = genregs64_set
 	},
 	/* Format is:
 	 *	F0 --> F63
@@ -502,43 +436,23 @@ static const struct user_regset sparc64_regsets[] = {
 		.core_note_type = NT_PRFPREG,
 		.n = 35,
 		.size = sizeof(u64), .align = sizeof(u64),
-		.get = fpregs64_get, .set = fpregs64_set
+		.get2 = fpregs64_get, .set = fpregs64_set
 	},
 };
 
 static int getregs64_get(struct task_struct *target,
 			 const struct user_regset *regset,
-			 unsigned int pos, unsigned int count,
-			 void *kbuf, void __user *ubuf)
+			 struct membuf to)
 {
 	const struct pt_regs *regs = task_pt_regs(target);
-	int ret;
 
 	if (target == current)
 		flushw_user();
 
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  regs->u_regs + 1,
-				  0, 15 * sizeof(u64));
-	if (!ret)
-		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-				  15 * sizeof(u64), 16 * sizeof(u64));
-	if (!ret) {
-		/* TSTATE, TPC, TNPC */
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  &regs->tstate,
-					  16 * sizeof(u64),
-					  19 * sizeof(u64));
-	}
-	if (!ret) {
-		unsigned long y = regs->y;
-
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  &y,
-					  19 * sizeof(u64),
-					  20 * sizeof(u64));
-	}
-	return ret;
+	membuf_write(&to, regs->u_regs + 1, 15 * sizeof(u64));
+	return membuf_store(&to, (u64)0);
+	membuf_write(&to, &regs->tstate, 3 * sizeof(u64));
+	return membuf_store(&to, (u64)regs->y);
 }
 
 static int setregs64_set(struct task_struct *target,
@@ -604,7 +518,7 @@ static const struct user_regset ptrace64_regsets[] = {
 	 */
 	[REGSET_GENERAL] = {
 		.n = 20, .size = sizeof(u64),
-		.get = getregs64_get, .set = setregs64_set,
+		.get2 = getregs64_get, .set = setregs64_set,
 	},
 };
 
@@ -620,81 +534,28 @@ static const struct user_regset_view user_sparc64_view = {
 #ifdef CONFIG_COMPAT
 static int genregs32_get(struct task_struct *target,
 			 const struct user_regset *regset,
-			 unsigned int pos, unsigned int count,
-			 void *kbuf, void __user *ubuf)
+			 struct membuf to)
 {
 	const struct pt_regs *regs = task_pt_regs(target);
-	compat_ulong_t *k = kbuf;
-	compat_ulong_t __user *u = ubuf;
 	u32 uregs[16];
-	u32 reg;
+	int i;
 
 	if (target == current)
 		flushw_user();
 
-	pos /= sizeof(reg);
-	count /= sizeof(reg);
-
-	if (kbuf) {
-		for (; count > 0 && pos < 16; count--)
-			*k++ = regs->u_regs[pos++];
-
-		if (count) {
-			if (get_from_target(target, regs->u_regs[UREG_I6],
-					uregs, sizeof(uregs)))
-				return -EFAULT;
-			for (; count > 0 && pos < 32; count--)
-				*k++ = uregs[pos++ - 16];
-
-		}
-	} else {
-		for (; count > 0 && pos < 16; count--)
-			if (put_user((compat_ulong_t) regs->u_regs[pos++], u++))
-				return -EFAULT;
-		if (count) {
-			if (get_from_target(target, regs->u_regs[UREG_I6],
-					uregs, sizeof(uregs)))
-				return -EFAULT;
-			for (; count > 0 && pos < 32; count--)
-				if (put_user(uregs[pos++ - 16], u++))
-					return -EFAULT;
-		}
-	}
-	while (count > 0) {
-		switch (pos) {
-		case 32: /* PSR */
-			reg = tstate_to_psr(regs->tstate);
-			break;
-		case 33: /* PC */
-			reg = regs->tpc;
-			break;
-		case 34: /* NPC */
-			reg = regs->tnpc;
-			break;
-		case 35: /* Y */
-			reg = regs->y;
-			break;
-		case 36: /* WIM */
-		case 37: /* TBR */
-			reg = 0;
-			break;
-		default:
-			goto finish;
-		}
-
-		if (kbuf)
-			*k++ = reg;
-		else if (put_user(reg, u++))
-			return -EFAULT;
-		pos++;
-		count--;
-	}
-finish:
-	pos *= sizeof(reg);
-	count *= sizeof(reg);
-
-	return user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-					38 * sizeof(reg), -1);
+	for (i = 0; i < 16; i++)
+		membuf_store(&to, (u32)regs->u_regs[i]);
+	if (!to.left)
+		return 0;
+	if (get_from_target(target, regs->u_regs[UREG_I6],
+			    uregs, sizeof(uregs)))
+		return -EFAULT;
+	membuf_write(&to, uregs, 16 * sizeof(u32));
+	membuf_store(&to, (u32)tstate_to_psr(regs->tstate));
+	membuf_store(&to, (u32)(regs->tpc));
+	membuf_store(&to, (u32)(regs->tnpc));
+	membuf_store(&to, (u32)(regs->y));
+	return membuf_zero(&to, 2 * sizeof(u32));
 }
 
 static int genregs32_set(struct task_struct *target,
@@ -816,56 +677,24 @@ static int genregs32_set(struct task_struct *target,
 
 static int fpregs32_get(struct task_struct *target,
 			const struct user_regset *regset,
-			unsigned int pos, unsigned int count,
-			void *kbuf, void __user *ubuf)
+			struct membuf to)
 {
-	const unsigned long *fpregs = task_thread_info(target)->fpregs;
-	compat_ulong_t enabled;
-	unsigned long fprs;
-	compat_ulong_t fsr;
-	int ret = 0;
+	struct thread_info *t = task_thread_info(target);
+	bool enabled;
 
 	if (target == current)
 		save_and_clear_fpu();
 
-	fprs = task_thread_info(target)->fpsaved[0];
-	if (fprs & FPRS_FEF) {
-		fsr = task_thread_info(target)->xfsr[0];
-		enabled = 1;
-	} else {
-		fsr = 0;
-		enabled = 0;
-	}
-
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  fpregs,
-				  0, 32 * sizeof(u32));
-
-	if (!ret)
-		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-					       32 * sizeof(u32),
-					       33 * sizeof(u32));
-	if (!ret)
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  &fsr,
-					  33 * sizeof(u32),
-					  34 * sizeof(u32));
+	enabled = t->fpsaved[0] & FPRS_FEF;
 
-	if (!ret) {
-		compat_ulong_t val;
-
-		val = (enabled << 8) | (8 << 16);
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  &val,
-					  34 * sizeof(u32),
-					  35 * sizeof(u32));
-	}
-
-	if (!ret)
-		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-					       35 * sizeof(u32), -1);
-
-	return ret;
+	membuf_write(&to, t->fpregs, 32 * sizeof(u32));
+	membuf_zero(&to, sizeof(u32));
+	if (enabled)
+		membuf_store(&to, (u32)t->xfsr[0]);
+	else
+		membuf_zero(&to, sizeof(u32));
+	membuf_store(&to, (u32)((enabled << 8) | (8 << 16)));
+	return membuf_zero(&to, 64 * sizeof(u32));
 }
 
 static int fpregs32_set(struct task_struct *target,
@@ -926,7 +755,7 @@ static const struct user_regset sparc32_regsets[] = {
 		.core_note_type = NT_PRSTATUS,
 		.n = 38,
 		.size = sizeof(u32), .align = sizeof(u32),
-		.get = genregs32_get, .set = genregs32_set
+		.get2 = genregs32_get, .set = genregs32_set
 	},
 	/* Format is:
 	 *	F0 --> F31
@@ -942,31 +771,27 @@ static const struct user_regset sparc32_regsets[] = {
 		.core_note_type = NT_PRFPREG,
 		.n = 99,
 		.size = sizeof(u32), .align = sizeof(u32),
-		.get = fpregs32_get, .set = fpregs32_set
+		.get2 = fpregs32_get, .set = fpregs32_set
 	},
 };
 
 static int getregs_get(struct task_struct *target,
-		       const struct user_regset *regset,
-		       unsigned int pos, unsigned int count,
-		       void *kbuf, void __user *ubuf)
+			 const struct user_regset *regset,
+			 struct membuf to)
 {
 	const struct pt_regs *regs = task_pt_regs(target);
-	u32 uregs[19];
 	int i;
 
 	if (target == current)
 		flushw_user();
 
-	uregs[0] = tstate_to_psr(regs->tstate);
-	uregs[1] = regs->tpc;
-	uregs[2] = regs->tnpc;
-	uregs[3] = regs->y;
+	membuf_store(&to, (u32)tstate_to_psr(regs->tstate));
+	membuf_store(&to, (u32)(regs->tpc));
+	membuf_store(&to, (u32)(regs->tnpc));
+	membuf_store(&to, (u32)(regs->y));
 	for (i = 1; i < 16; i++)
-		uregs[3 + i] = regs->u_regs[i];
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   uregs,
-				   0, 19 * sizeof(u32));
+		membuf_store(&to, (u32)regs->u_regs[i]);
+	return to.left;
 }
 
 static int setregs_set(struct task_struct *target,
@@ -1005,36 +830,19 @@ static int setregs_set(struct task_struct *target,
 
 static int getfpregs_get(struct task_struct *target,
 			const struct user_regset *regset,
-			unsigned int pos, unsigned int count,
-			void *kbuf, void __user *ubuf)
+			struct membuf to)
 {
-	const unsigned long *fpregs = task_thread_info(target)->fpregs;
-	unsigned long fprs;
-	compat_ulong_t fsr;
-	int ret = 0;
+	struct thread_info *t = task_thread_info(target);
 
 	if (target == current)
 		save_and_clear_fpu();
 
-	fprs = task_thread_info(target)->fpsaved[0];
-	if (fprs & FPRS_FEF) {
-		fsr = task_thread_info(target)->xfsr[0];
-	} else {
-		fsr = 0;
-	}
-
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  fpregs,
-				  0, 32 * sizeof(u32));
-	if (!ret)
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  &fsr,
-					  32 * sizeof(u32),
-					  33 * sizeof(u32));
-	if (!ret)
-		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-					  33 * sizeof(u32), 68 * sizeof(u32));
-	return ret;
+	membuf_write(&to, t->fpregs, 32 * sizeof(u32));
+	if (t->fpsaved[0] & FPRS_FEF)
+		membuf_store(&to, (u32)t->xfsr[0]);
+	else
+		membuf_zero(&to, sizeof(u32));
+	return membuf_zero(&to, 35 * sizeof(u32));
 }
 
 static int setfpregs_set(struct task_struct *target,
@@ -1078,11 +886,11 @@ static int setfpregs_set(struct task_struct *target,
 static const struct user_regset ptrace32_regsets[] = {
 	[REGSET_GENERAL] = {
 		.n = 19, .size = sizeof(u32),
-		.get = getregs_get, .set = setregs_set,
+		.get2 = getregs_get, .set = setregs_set,
 	},
 	[REGSET_FP] = {
 		.n = 68, .size = sizeof(u32),
-		.get = getfpregs_get, .set = setfpregs_set,
+		.get2 = getfpregs_get, .set = setfpregs_set,
 	},
 };
 
-- 
2.11.0

