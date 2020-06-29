Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474CA20E4B1
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgF2V2A (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbgF2Smo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:44 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EFEC033C10;
        Mon, 29 Jun 2020 11:26:31 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyU9-002Dtn-Fq; Mon, 29 Jun 2020 18:26:29 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 10/41] sparc32: get rid of odd callers of copy_regset_to_user()
Date:   Mon, 29 Jun 2020 19:25:57 +0100
Message-Id: <20200629182628.529995-10-viro@ZenIV.linux.org.uk>
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

the life is much simpler if copy_regset_to_user() (and ->get())
gets called only with pos == 0; sparc32 PTRACE_GETREGS and
PTRACE_GETFPREGS are among the few things that use it to fetch
pieces of regset _not_ starting at the beginning.  It's actually
easier to define a separate regset that would provide what
we need, rather than trying to cobble that from the one
PTRACE_GETREGSET uses.

Extra ->get() instances do not amount to much code and once
we get the conversion of ->get() to new API (dependent upon the
lack of weird callers of ->get()) they'll shrink a lot, along
with the rest of ->get() instances...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sparc/kernel/ptrace_32.c | 117 +++++++++++++++++++++++++++++-------------
 1 file changed, 82 insertions(+), 35 deletions(-)

diff --git a/arch/sparc/kernel/ptrace_32.c b/arch/sparc/kernel/ptrace_32.c
index 47eb315d411c..f72b7d2c4716 100644
--- a/arch/sparc/kernel/ptrace_32.c
+++ b/arch/sparc/kernel/ptrace_32.c
@@ -99,15 +99,13 @@ static int genregs32_get(struct task_struct *target,
 	if (ret || !count)
 		return ret;
 
-	if (pos < 32 * sizeof(u32)) {
-		if (regwindow32_get(target, regs, uregs))
-			return -EFAULT;
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  uregs,
-					  16 * sizeof(u32), 32 * sizeof(u32));
-		if (ret || !count)
-			return ret;
-	}
+	if (regwindow32_get(target, regs, uregs))
+		return -EFAULT;
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				  uregs,
+				  16 * sizeof(u32), 32 * sizeof(u32));
+	if (ret)
+		return ret;
 
 	uregs[0] = regs->psr;
 	uregs[1] = regs->pc;
@@ -288,6 +286,73 @@ static const struct user_regset sparc32_regsets[] = {
 	},
 };
 
+static int getregs_get(struct task_struct *target,
+			 const struct user_regset *regset,
+			 unsigned int pos, unsigned int count,
+			 void *kbuf, void __user *ubuf)
+{
+	const struct pt_regs *regs = target->thread.kregs;
+	u32 v[4];
+	int ret;
+
+	if (target == current)
+		flush_user_windows();
+
+	v[0] = regs->psr;
+	v[1] = regs->pc;
+	v[2] = regs->npc;
+	v[3] = regs->y;
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				  v,
+				  0 * sizeof(u32), 4 * sizeof(u32));
+	if (ret)
+		return ret;
+
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				  regs->u_regs + 1,
+				  4 * sizeof(u32), 19 * sizeof(u32));
+}
+
+static int getfpregs_get(struct task_struct *target,
+			const struct user_regset *regset,
+			unsigned int pos, unsigned int count,
+			void *kbuf, void __user *ubuf)
+{
+	const unsigned long *fpregs = target->thread.float_regs;
+	int ret = 0;
+
+#if 0
+	if (target == current)
+		save_and_clear_fpu();
+#endif
+
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				  fpregs,
+				  0, 32 * sizeof(u32));
+	if (ret)
+		return ret;
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				  &target->thread.fsr,
+				  32 * sizeof(u32), 33 * sizeof(u32));
+	if (ret)
+		return ret;
+	return user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
+				  33 * sizeof(u32), 68 * sizeof(u32));
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
@@ -327,15 +392,10 @@ long arch_ptrace(struct task_struct *child, long request,
 
 	switch(request) {
 	case PTRACE_GETREGS: {
-		ret = copy_regset_to_user(child, view, REGSET_GENERAL,
-					  32 * sizeof(u32),
-					  4 * sizeof(u32),
-					  &pregs->psr);
-		if (!ret)
-			copy_regset_to_user(child, view, REGSET_GENERAL,
-					    1 * sizeof(u32),
-					    15 * sizeof(u32),
-					    &pregs->u_regs[0]);
+		ret = copy_regset_to_user(child, &ptrace32_view,
+					  REGSET_GENERAL, 0,
+					  19 * sizeof(u32),
+					  pregs);
 		break;
 	}
 
@@ -353,23 +413,10 @@ long arch_ptrace(struct task_struct *child, long request,
 	}
 
 	case PTRACE_GETFPREGS: {
-		ret = copy_regset_to_user(child, view, REGSET_FP,
-					  0 * sizeof(u32),
-					  32 * sizeof(u32),
-					  &fps->regs[0]);
-		if (!ret)
-			ret = copy_regset_to_user(child, view, REGSET_FP,
-						  33 * sizeof(u32),
-						  1 * sizeof(u32),
-						  &fps->fsr);
-
-		if (!ret) {
-			if (__put_user(0, &fps->fpqd) ||
-			    __put_user(0, &fps->flags) ||
-			    __put_user(0, &fps->extra) ||
-			    clear_user(fps->fpq, sizeof(fps->fpq)))
-				ret = -EFAULT;
-		}
+		ret = copy_regset_to_user(child, &ptrace32_view,
+					  REGSET_FP, 0,
+					  68 * sizeof(u32),
+					  fps);
 		break;
 	}
 
-- 
2.11.0

