Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E0B20E46F
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgF2VZW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbgF2Smu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:50 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D37C033C18;
        Mon, 29 Jun 2020 11:26:32 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyU9-002Du8-S6; Mon, 29 Jun 2020 18:26:29 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 13/41] sparc64: get rid of odd callers of copy_regset_from_user()
Date:   Mon, 29 Jun 2020 19:26:00 +0100
Message-Id: <20200629182628.529995-13-viro@ZenIV.linux.org.uk>
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
 arch/sparc/kernel/ptrace_64.c | 177 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 144 insertions(+), 33 deletions(-)

diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index 1b1910b67ca4..3c9eee12102a 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -541,6 +541,60 @@ static int getregs64_get(struct task_struct *target,
 	return ret;
 }
 
+static int setregs64_set(struct task_struct *target,
+			 const struct user_regset *regset,
+			 unsigned int pos, unsigned int count,
+			 const void *kbuf, const void __user *ubuf)
+{
+	struct pt_regs *regs = task_pt_regs(target);
+	unsigned long y = regs->y;
+	unsigned long tstate;
+	int ret;
+
+	if (target == current)
+		flushw_user();
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 regs->u_regs + 1,
+				 0 * sizeof(u64),
+				 15 * sizeof(u64));
+	if (ret)
+		return ret;
+	ret =user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
+				 15 * sizeof(u64), 16 * sizeof(u64));
+	if (ret)
+		return ret;
+	/* TSTATE */
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 &tstate,
+				 16 * sizeof(u64),
+				 17 * sizeof(u64));
+	if (ret)
+		return ret;
+	/* Only the condition codes and the "in syscall"
+	 * state can be modified in the %tstate register.
+	 */
+	tstate &= (TSTATE_ICC | TSTATE_XCC | TSTATE_SYSCALL);
+	regs->tstate &= ~(TSTATE_ICC | TSTATE_XCC | TSTATE_SYSCALL);
+	regs->tstate |= tstate;
+
+	/* TPC, TNPC */
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 &regs->tpc,
+				 17 * sizeof(u64),
+				 19 * sizeof(u64));
+	if (ret)
+		return ret;
+	/* Y */
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 &y,
+				 19 * sizeof(u64),
+				 20 * sizeof(u64));
+	if (!ret)
+		regs->y = y;
+	return ret;
+}
+
 static const struct user_regset ptrace64_regsets[] = {
 	/* Format is:
 	 *      G1 --> G7
@@ -549,7 +603,8 @@ static const struct user_regset ptrace64_regsets[] = {
 	 *      TSTATE, TPC, TNPC, Y
 	 */
 	[REGSET_GENERAL] = {
-		.n = 20, .size = sizeof(u64), .get = getregs64_get,
+		.n = 20, .size = sizeof(u64),
+		.get = getregs64_get, .set = setregs64_set,
 	},
 };
 
@@ -914,6 +969,40 @@ static int getregs_get(struct task_struct *target,
 				   0, 19 * sizeof(u32));
 }
 
+static int setregs_set(struct task_struct *target,
+			 const struct user_regset *regset,
+			 unsigned int pos, unsigned int count,
+			 const void *kbuf, const void __user *ubuf)
+{
+	struct pt_regs *regs = task_pt_regs(target);
+	unsigned long tstate;
+	u32 uregs[19];
+	int i, ret;
+
+	if (target == current)
+		flushw_user();
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 uregs,
+				 0, 19 * sizeof(u32));
+	if (ret)
+		return ret;
+
+	tstate = regs->tstate;
+	tstate &= ~(TSTATE_ICC | TSTATE_XCC | TSTATE_SYSCALL);
+	tstate |= psr_to_tstate_icc(uregs[0]);
+	if (uregs[0] & PSR_SYSCALL)
+		tstate |= TSTATE_SYSCALL;
+	regs->tstate = tstate;
+	regs->tpc = uregs[1];
+	regs->tnpc = uregs[2];
+	regs->y = uregs[3];
+
+	for (i = 1; i < 15; i++)
+		regs->u_regs[i] = uregs[3 + i];
+	return 0;
+}
+
 static int getfpregs_get(struct task_struct *target,
 			const struct user_regset *regset,
 			unsigned int pos, unsigned int count,
@@ -948,12 +1037,52 @@ static int getfpregs_get(struct task_struct *target,
 	return ret;
 }
 
+static int setfpregs_set(struct task_struct *target,
+			const struct user_regset *regset,
+			unsigned int pos, unsigned int count,
+			const void *kbuf, const void __user *ubuf)
+{
+	unsigned long *fpregs = task_thread_info(target)->fpregs;
+	unsigned long fprs;
+	int ret;
+
+	if (target == current)
+		save_and_clear_fpu();
+
+	fprs = task_thread_info(target)->fpsaved[0];
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 fpregs,
+				 0, 32 * sizeof(u32));
+	if (!ret) {
+		compat_ulong_t fsr;
+		unsigned long val;
+
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+					 &fsr,
+					 32 * sizeof(u32),
+					 33 * sizeof(u32));
+		if (!ret) {
+			val = task_thread_info(target)->xfsr[0];
+			val &= 0xffffffff00000000UL;
+			val |= fsr;
+			task_thread_info(target)->xfsr[0] = val;
+		}
+	}
+
+	fprs |= (FPRS_FEF | FPRS_DL);
+	task_thread_info(target)->fpsaved[0] = fprs;
+	return ret;
+}
+
 static const struct user_regset ptrace32_regsets[] = {
 	[REGSET_GENERAL] = {
-		.n = 19, .size = sizeof(u32), .get = getregs_get,
+		.n = 19, .size = sizeof(u32),
+		.get = getregs_get, .set = setregs_set,
 	},
 	[REGSET_FP] = {
-		.n = 68, .size = sizeof(u32), .get = getfpregs_get,
+		.n = 68, .size = sizeof(u32),
+		.get = getfpregs_get, .set = setfpregs_set,
 	},
 };
 
@@ -992,7 +1121,6 @@ struct compat_fps {
 long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			compat_ulong_t caddr, compat_ulong_t cdata)
 {
-	const struct user_regset_view *view = task_user_regset_view(current);
 	compat_ulong_t caddr2 = task_pt_regs(current)->u_regs[UREG_I4];
 	struct pt_regs32 __user *pregs;
 	struct compat_fps __user *fps;
@@ -1017,15 +1145,10 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 		break;
 
 	case PTRACE_SETREGS:
-		ret = copy_regset_from_user(child, view, REGSET_GENERAL,
-					    32 * sizeof(u32),
-					    4 * sizeof(u32),
-					    &pregs->psr);
-		if (!ret)
-			ret = copy_regset_from_user(child, view, REGSET_GENERAL,
-						    1 * sizeof(u32),
-						    15 * sizeof(u32),
-						    &pregs->u_regs[0]);
+		ret = copy_regset_from_user(child, &ptrace32_view,
+					  REGSET_GENERAL, 0,
+					  19 * sizeof(u32),
+					  pregs);
 		break;
 
 	case PTRACE_GETFPREGS:
@@ -1036,15 +1159,10 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 		break;
 
 	case PTRACE_SETFPREGS:
-		ret = copy_regset_from_user(child, view, REGSET_FP,
-					    0 * sizeof(u32),
-					    32 * sizeof(u32),
-					    &fps->regs[0]);
-		if (!ret)
-			ret = copy_regset_from_user(child, view, REGSET_FP,
-						    33 * sizeof(u32),
-						    1 * sizeof(u32),
-						    &fps->fsr);
+		ret = copy_regset_from_user(child, &ptrace32_view,
+					  REGSET_FP, 0,
+					  33 * sizeof(u32),
+					  fps);
 		break;
 
 	case PTRACE_READTEXT:
@@ -1110,17 +1228,10 @@ long arch_ptrace(struct task_struct *child, long request,
 		break;
 
 	case PTRACE_SETREGS64:
-		ret = copy_regset_from_user(child, view, REGSET_GENERAL,
-					    1 * sizeof(u64),
-					    15 * sizeof(u64),
-					    &pregs->u_regs[0]);
-		if (!ret) {
-			/* XXX doesn't handle 'y' register correctly XXX */
-			ret = copy_regset_from_user(child, view, REGSET_GENERAL,
-						    32 * sizeof(u64),
-						    4 * sizeof(u64),
-						    &pregs->tstate);
-		}
+		ret = copy_regset_from_user(child, &ptrace64_view,
+					  REGSET_GENERAL, 0,
+					  19 * sizeof(u64),
+					  pregs);
 		break;
 
 	case PTRACE_GETFPREGS64:
-- 
2.11.0

