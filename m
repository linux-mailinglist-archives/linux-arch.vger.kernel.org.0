Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B12220D27B
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 20:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgF2Sti (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 14:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbgF2Smw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:52 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C6EC033C27;
        Mon, 29 Jun 2020 11:26:34 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyUC-002DwI-63; Mon, 29 Jun 2020 18:26:32 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 30/41] riscv: switch to ->get2()
Date:   Mon, 29 Jun 2020 19:26:17 +0100
Message-Id: <20200629182628.529995-30-viro@ZenIV.linux.org.uk>
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

Note: riscv_fpr_get() used to forget to zero-pad at the end.
Not worth -stable...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/riscv/kernel/ptrace.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 444dc7b0fd78..a6896449eff8 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -30,13 +30,10 @@ enum riscv_regset {
 
 static int riscv_gpr_get(struct task_struct *target,
 			 const struct user_regset *regset,
-			 unsigned int pos, unsigned int count,
-			 void *kbuf, void __user *ubuf)
+			 struct membuf to)
 {
-	struct pt_regs *regs;
-
-	regs = task_pt_regs(target);
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, regs, 0, -1);
+	return membuf_write(&to, task_pt_regs(target),
+			    sizeof(struct user_regs_struct));
 }
 
 static int riscv_gpr_set(struct task_struct *target,
@@ -55,21 +52,13 @@ static int riscv_gpr_set(struct task_struct *target,
 #ifdef CONFIG_FPU
 static int riscv_fpr_get(struct task_struct *target,
 			 const struct user_regset *regset,
-			 unsigned int pos, unsigned int count,
-			 void *kbuf, void __user *ubuf)
+			 struct membuf to)
 {
-	int ret;
 	struct __riscv_d_ext_state *fstate = &target->thread.fstate;
 
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, fstate, 0,
-				  offsetof(struct __riscv_d_ext_state, fcsr));
-	if (!ret) {
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, fstate, 0,
-					  offsetof(struct __riscv_d_ext_state, fcsr) +
-					  sizeof(fstate->fcsr));
-	}
-
-	return ret;
+	membuf_write(&to, fstate, offsetof(struct __riscv_d_ext_state, fcsr));
+	membuf_store(&to, fstate->fcsr);
+	return membuf_zero(&to, 4);	// explicitly pad
 }
 
 static int riscv_fpr_set(struct task_struct *target,
@@ -98,8 +87,8 @@ static const struct user_regset riscv_user_regset[] = {
 		.n = ELF_NGREG,
 		.size = sizeof(elf_greg_t),
 		.align = sizeof(elf_greg_t),
-		.get = &riscv_gpr_get,
-		.set = &riscv_gpr_set,
+		.get2 = riscv_gpr_get,
+		.set = riscv_gpr_set,
 	},
 #ifdef CONFIG_FPU
 	[REGSET_F] = {
@@ -107,8 +96,8 @@ static const struct user_regset riscv_user_regset[] = {
 		.n = ELF_NFPREG,
 		.size = sizeof(elf_fpreg_t),
 		.align = sizeof(elf_fpreg_t),
-		.get = &riscv_fpr_get,
-		.set = &riscv_fpr_set,
+		.get2 = riscv_fpr_get,
+		.set = riscv_fpr_set,
 	},
 #endif
 };
-- 
2.11.0

