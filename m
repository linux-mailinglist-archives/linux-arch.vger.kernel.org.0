Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103B720D1C7
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 20:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgF2Snv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 14:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbgF2Smw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:52 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59136C033C30;
        Mon, 29 Jun 2020 11:26:38 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyUD-002Dwm-0p; Mon, 29 Jun 2020 18:26:33 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 33/41] hexagon: switch to ->get2()
Date:   Mon, 29 Jun 2020 19:26:20 +0100
Message-Id: <20200629182628.529995-33-viro@ZenIV.linux.org.uk>
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
 arch/hexagon/kernel/ptrace.c | 62 +++++++++++++++-----------------------------
 1 file changed, 21 insertions(+), 41 deletions(-)

diff --git a/arch/hexagon/kernel/ptrace.c b/arch/hexagon/kernel/ptrace.c
index dcbf7ea960cc..fa6287d1a061 100644
--- a/arch/hexagon/kernel/ptrace.c
+++ b/arch/hexagon/kernel/ptrace.c
@@ -35,58 +35,38 @@ void user_disable_single_step(struct task_struct *child)
 
 static int genregs_get(struct task_struct *target,
 		   const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
+		   srtuct membuf to)
 {
-	int ret;
-	unsigned int dummy;
 	struct pt_regs *regs = task_pt_regs(target);
 
-
-	if (!regs)
-		return -EIO;
-
 	/* The general idea here is that the copyout must happen in
 	 * exactly the same order in which the userspace expects these
 	 * regs. Now, the sequence in userspace does not match the
 	 * sequence in the kernel, so everything past the 32 gprs
 	 * happens one at a time.
 	 */
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  &regs->r00, 0, 32*sizeof(unsigned long));
-
-#define ONEXT(KPT_REG, USR_REG) \
-	if (!ret) \
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, \
-			KPT_REG, offsetof(struct user_regs_struct, USR_REG), \
-			offsetof(struct user_regs_struct, USR_REG) + \
-				 sizeof(unsigned long));
-
+	membuf_write(&to, &regs->r00, 32*sizeof(unsigned long));
 	/* Must be exactly same sequence as struct user_regs_struct */
-	ONEXT(&regs->sa0, sa0);
-	ONEXT(&regs->lc0, lc0);
-	ONEXT(&regs->sa1, sa1);
-	ONEXT(&regs->lc1, lc1);
-	ONEXT(&regs->m0, m0);
-	ONEXT(&regs->m1, m1);
-	ONEXT(&regs->usr, usr);
-	ONEXT(&regs->preds, p3_0);
-	ONEXT(&regs->gp, gp);
-	ONEXT(&regs->ugp, ugp);
-	ONEXT(&pt_elr(regs), pc);
-	dummy = pt_cause(regs);
-	ONEXT(&dummy, cause);
-	ONEXT(&pt_badva(regs), badva);
+	membuf_store(&to, regs->sa0);
+	membuf_store(&to, regs->lc0);
+	membuf_store(&to, regs->sa1);
+	membuf_store(&to, regs->lc1);
+	membuf_store(&to, regs->m0);
+	membuf_store(&to, regs->m1);
+	membuf_store(&to, regs->usr);
+	membuf_store(&to, regs->p3_0);
+	membuf_store(&to, regs->gp);
+	membuf_store(&to, regs->ugp);
+	membuf_store(&to, pt_elr(regs)); // pc
+	membuf_store(&to, (unsigned long)pt_cause(regs)); // cause
+	membuf_store(&to, pt_badva(regs)); // badva
 #if CONFIG_HEXAGON_ARCH_VERSION >=4
-	ONEXT(&regs->cs0, cs0);
-	ONEXT(&regs->cs1, cs1);
+	membuf_store(&to, regs->cs0);
+	membuf_store(&to, regs->cs1);
+	return membuf_zero(&to, sizeof(unsigned long));
+#else
+	return membuf_zero(&to, 3 * sizeof(unsigned long));
 #endif
-
-	/* Pad the rest with zeros, if needed */
-	if (!ret)
-		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-					offsetof(struct user_regs_struct, pad1), -1);
-	return ret;
 }
 
 static int genregs_set(struct task_struct *target,
@@ -159,7 +139,7 @@ static const struct user_regset hexagon_regsets[] = {
 		.n = ELF_NGREG,
 		.size = sizeof(unsigned long),
 		.align = sizeof(unsigned long),
-		.get = genregs_get,
+		.get2 = genregs_get,
 		.set = genregs_set,
 	},
 };
-- 
2.11.0

