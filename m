Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA8620E486
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391067AbgF2V0O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729087AbgF2Smr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:47 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E04C033C12;
        Mon, 29 Jun 2020 11:26:31 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyU9-002Du1-MY; Mon, 29 Jun 2020 18:26:29 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 12/41] sparc32: get rid of odd callers of copy_regset_from_user()
Date:   Mon, 29 Jun 2020 19:25:59 +0100
Message-Id: <20200629182628.529995-12-viro@ZenIV.linux.org.uk>
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
 arch/sparc/kernel/ptrace_32.c | 109 ++++++++++++++++++++++++++++--------------
 1 file changed, 73 insertions(+), 36 deletions(-)

diff --git a/arch/sparc/kernel/ptrace_32.c b/arch/sparc/kernel/ptrace_32.c
index f72b7d2c4716..0856e0104539 100644
--- a/arch/sparc/kernel/ptrace_32.c
+++ b/arch/sparc/kernel/ptrace_32.c
@@ -137,19 +137,18 @@ static int genregs32_set(struct task_struct *target,
 	if (ret || !count)
 		return ret;
 
-	if (pos < 32 * sizeof(u32)) {
-		if (regwindow32_get(target, regs, uregs))
-			return -EFAULT;
-		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-					 uregs,
-					 16 * sizeof(u32), 32 * sizeof(u32));
-		if (ret)
-			return ret;
-		if (regwindow32_set(target, regs, uregs))
-			return -EFAULT;
-		if (!count)
-			return 0;
-	}
+	if (regwindow32_get(target, regs, uregs))
+		return -EFAULT;
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 uregs,
+				 16 * sizeof(u32), 32 * sizeof(u32));
+	if (ret)
+		return ret;
+	if (regwindow32_set(target, regs, uregs))
+		return -EFAULT;
+	if (!count)
+		return 0;
+
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
 				 &psr,
 				 32 * sizeof(u32), 33 * sizeof(u32));
@@ -241,13 +240,11 @@ static int fpregs32_set(struct task_struct *target,
 		user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
 					  32 * sizeof(u32),
 					  33 * sizeof(u32));
-	if (!ret && count > 0) {
+	if (!ret)
 		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
 					 &target->thread.fsr,
 					 33 * sizeof(u32),
 					 34 * sizeof(u32));
-	}
-
 	if (!ret)
 		ret = user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
 						34 * sizeof(u32), -1);
@@ -313,6 +310,31 @@ static int getregs_get(struct task_struct *target,
 				  4 * sizeof(u32), 19 * sizeof(u32));
 }
 
+static int setregs_set(struct task_struct *target,
+			 const struct user_regset *regset,
+			 unsigned int pos, unsigned int count,
+			 const void *kbuf, const void __user *ubuf)
+{
+	struct pt_regs *regs = target->thread.kregs;
+	u32 v[4];
+	int ret;
+
+	if (target == current)
+		flush_user_windows();
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 v,
+				 0, 4 * sizeof(u32));
+	regs->psr = (regs->psr & ~(PSR_ICC | PSR_SYSCALL)) |
+		    (v[0] & (PSR_ICC | PSR_SYSCALL));
+	regs->pc = v[1];
+	regs->npc = v[2];
+	regs->y = v[3];
+	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 regs->u_regs + 1,
+				 4 * sizeof(u32) , 19 * sizeof(u32));
+}
+
 static int getfpregs_get(struct task_struct *target,
 			const struct user_regset *regset,
 			unsigned int pos, unsigned int count,
@@ -340,12 +362,37 @@ static int getfpregs_get(struct task_struct *target,
 				  33 * sizeof(u32), 68 * sizeof(u32));
 }
 
+static int setfpregs_set(struct task_struct *target,
+			const struct user_regset *regset,
+			unsigned int pos, unsigned int count,
+			const void *kbuf, const void __user *ubuf)
+{
+	unsigned long *fpregs = target->thread.float_regs;
+	int ret;
+
+#if 0
+	if (target == current)
+		save_and_clear_fpu();
+#endif
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 fpregs,
+				 0, 32 * sizeof(u32));
+	if (ret)
+		return ret;
+	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 &target->thread.fsr,
+				 32 * sizeof(u32),
+				 33 * sizeof(u32));
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
 
@@ -400,15 +447,10 @@ long arch_ptrace(struct task_struct *child, long request,
 	}
 
 	case PTRACE_SETREGS: {
-		ret = copy_regset_from_user(child, view, REGSET_GENERAL,
-					    32 * sizeof(u32),
-					    4 * sizeof(u32),
-					    &pregs->psr);
-		if (!ret)
-			copy_regset_from_user(child, view, REGSET_GENERAL,
-					      1 * sizeof(u32),
-					      15 * sizeof(u32),
-					      &pregs->u_regs[0]);
+		ret = copy_regset_from_user(child, &ptrace32_view,
+					    REGSET_GENERAL, 0,
+					    19 * sizeof(u32),
+					    pregs);
 		break;
 	}
 
@@ -421,15 +463,10 @@ long arch_ptrace(struct task_struct *child, long request,
 	}
 
 	case PTRACE_SETFPREGS: {
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
 	}
 
-- 
2.11.0

