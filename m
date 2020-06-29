Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A84920E4C8
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390515AbgF2V25 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgF2Smm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:42 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA7DC033C1A;
        Mon, 29 Jun 2020 11:26:32 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyUB-002DvU-A6; Mon, 29 Jun 2020 18:26:31 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 25/41] sh: convert to ->get2()
Date:   Mon, 29 Jun 2020 19:26:12 +0100
Message-Id: <20200629182628.529995-25-viro@ZenIV.linux.org.uk>
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

NB: there's a direct call of fpregs_get() left in dump_fpu().
To be taken out once we convert ELF_FDPIC to use of regset.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sh/kernel/process_32.c |  5 ++---
 arch/sh/kernel/ptrace_32.c  | 48 ++++++++++-----------------------------------
 2 files changed, 12 insertions(+), 41 deletions(-)

diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index 456cc8d171f7..6ab397bc47ed 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -103,9 +103,8 @@ int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpu)
 
 	fpvalid = !!tsk_used_math(tsk);
 	if (fpvalid)
-		fpvalid = !fpregs_get(tsk, NULL, 0,
-				      sizeof(struct user_fpu_struct),
-				      fpu, NULL);
+		fpvalid = !fpregs_get(tsk, NULL,
+				      (struct membuf){fpu, sizeof(*fpu)});
 #endif
 
 	return fpvalid;
diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
index 64bfb714943e..7aa5e61ccb7b 100644
--- a/arch/sh/kernel/ptrace_32.c
+++ b/arch/sh/kernel/ptrace_32.c
@@ -134,26 +134,11 @@ void ptrace_disable(struct task_struct *child)
 
 static int genregs_get(struct task_struct *target,
 		       const struct user_regset *regset,
-		       unsigned int pos, unsigned int count,
-		       void *kbuf, void __user *ubuf)
+		       struct membuf to)
 {
 	const struct pt_regs *regs = task_pt_regs(target);
-	int ret;
 
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  regs->regs,
-				  0, 16 * sizeof(unsigned long));
-	if (!ret)
-		/* PC, PR, SR, GBR, MACH, MACL, TRA */
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					  &regs->pc,
-					  offsetof(struct pt_regs, pc),
-					  sizeof(struct pt_regs));
-	if (!ret)
-		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-					       sizeof(struct pt_regs), -1);
-
-	return ret;
+	return membuf_write(&to, regs, sizeof(struct pt_regs));
 }
 
 static int genregs_set(struct task_struct *target,
@@ -182,8 +167,7 @@ static int genregs_set(struct task_struct *target,
 #ifdef CONFIG_SH_FPU
 int fpregs_get(struct task_struct *target,
 	       const struct user_regset *regset,
-	       unsigned int pos, unsigned int count,
-	       void *kbuf, void __user *ubuf)
+	       struct membuf to)
 {
 	int ret;
 
@@ -191,12 +175,8 @@ int fpregs_get(struct task_struct *target,
 	if (ret)
 		return ret;
 
-	if ((boot_cpu_data.flags & CPU_HAS_FPU))
-		return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-					   &target->thread.xstate->hardfpu, 0, -1);
-
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   &target->thread.xstate->softfpu, 0, -1);
+	return membuf_write(&to, target->thread.xstate,
+			    sizeof(struct user_fpu_struct));
 }
 
 static int fpregs_set(struct task_struct *target,
@@ -230,20 +210,12 @@ static int fpregs_active(struct task_struct *target,
 #ifdef CONFIG_SH_DSP
 static int dspregs_get(struct task_struct *target,
 		       const struct user_regset *regset,
-		       unsigned int pos, unsigned int count,
-		       void *kbuf, void __user *ubuf)
+		       struct membuf to)
 {
 	const struct pt_dspregs *regs =
 		(struct pt_dspregs *)&target->thread.dsp_status.dsp_regs;
-	int ret;
 
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, regs,
-				  0, sizeof(struct pt_dspregs));
-	if (!ret)
-		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-					       sizeof(struct pt_dspregs), -1);
-
-	return ret;
+	return membuf_write(&to, regs, sizeof(struct pt_dspregs));
 }
 
 static int dspregs_set(struct task_struct *target,
@@ -324,7 +296,7 @@ static const struct user_regset sh_regsets[] = {
 		.n		= ELF_NGREG,
 		.size		= sizeof(long),
 		.align		= sizeof(long),
-		.get		= genregs_get,
+		.get2		= genregs_get,
 		.set		= genregs_set,
 	},
 
@@ -334,7 +306,7 @@ static const struct user_regset sh_regsets[] = {
 		.n		= sizeof(struct user_fpu_struct) / sizeof(long),
 		.size		= sizeof(long),
 		.align		= sizeof(long),
-		.get		= fpregs_get,
+		.get2		= fpregs_get,
 		.set		= fpregs_set,
 		.active		= fpregs_active,
 	},
@@ -345,7 +317,7 @@ static const struct user_regset sh_regsets[] = {
 		.n		= sizeof(struct pt_dspregs) / sizeof(long),
 		.size		= sizeof(long),
 		.align		= sizeof(long),
-		.get		= dspregs_get,
+		.get2		= dspregs_get,
 		.set		= dspregs_set,
 		.active		= dspregs_active,
 	},
-- 
2.11.0

