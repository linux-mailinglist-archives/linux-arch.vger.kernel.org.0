Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7582920D1CA
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 20:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgF2Snw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 14:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbgF2Smw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:52 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAFDC033C28;
        Mon, 29 Jun 2020 11:26:34 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyUD-002Dwx-7N; Mon, 29 Jun 2020 18:26:33 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 34/41] nios2: switch to ->get2()
Date:   Mon, 29 Jun 2020 19:26:21 +0100
Message-Id: <20200629182628.529995-34-viro@ZenIV.linux.org.uk>
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
 arch/nios2/kernel/ptrace.c | 51 ++++++++++++++--------------------------------
 1 file changed, 15 insertions(+), 36 deletions(-)

diff --git a/arch/nios2/kernel/ptrace.c b/arch/nios2/kernel/ptrace.c
index de97bcb7dd44..2214f95847cd 100644
--- a/arch/nios2/kernel/ptrace.c
+++ b/arch/nios2/kernel/ptrace.c
@@ -21,45 +21,24 @@
 
 static int genregs_get(struct task_struct *target,
 		       const struct user_regset *regset,
-		       unsigned int pos, unsigned int count,
-		       void *kbuf, void __user *ubuf)
+		       struct membuf to)
 {
 	const struct pt_regs *regs = task_pt_regs(target);
 	const struct switch_stack *sw = (struct switch_stack *)regs - 1;
-	int ret = 0;
-
-#define REG_O_ZERO_RANGE(START, END)		\
-	if (!ret)					\
-		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf, \
-			START * 4, (END * 4) + 4);
-
-#define REG_O_ONE(PTR, LOC)	\
-	if (!ret)			\
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, PTR, \
-			LOC * 4, (LOC * 4) + 4);
 
-#define REG_O_RANGE(PTR, START, END)	\
-	if (!ret)				\
-		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, PTR, \
-			START * 4, (END * 4) + 4);
-
-	REG_O_ZERO_RANGE(PTR_R0, PTR_R0);
-	REG_O_RANGE(&regs->r1, PTR_R1, PTR_R7);
-	REG_O_RANGE(&regs->r8, PTR_R8, PTR_R15);
-	REG_O_RANGE(sw, PTR_R16, PTR_R23);
-	REG_O_ZERO_RANGE(PTR_R24, PTR_R25); /* et and bt */
-	REG_O_ONE(&regs->gp, PTR_GP);
-	REG_O_ONE(&regs->sp, PTR_SP);
-	REG_O_ONE(&regs->fp, PTR_FP);
-	REG_O_ONE(&regs->ea, PTR_EA);
-	REG_O_ZERO_RANGE(PTR_BA, PTR_BA);
-	REG_O_ONE(&regs->ra, PTR_RA);
-	REG_O_ONE(&regs->ea, PTR_PC); /* use ea for PC */
-	if (!ret)
-		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-					 PTR_STATUS * 4, -1);
-
-	return ret;
+	membuf_zero(&to, 4); // R0
+	membuf_write(&to, &regs->r1, 7 * 4); // R1..R7
+	membuf_write(&to, &regs->r8, 8 * 4); // R8..R15
+	membuf_write(&to, sw, 8 * 4); // R16..R23
+	membuf_zero(&to, 2 * 4); /* et and bt */
+	membuf_store(&to, regs->gp);
+	membuf_store(&to, regs->sp);
+	membuf_store(&to, regs->fp);
+	membuf_store(&to, regs->ea);
+	membuf_zero(&to, 4); // PTR_BA
+	membuf_store(&to, regs->ra);
+	membuf_store(&to, regs->ea); /* use ea for PC */
+	return membuf_zero(&to, (NUM_PTRACE_REG - PTR_PC) * 4);
 }
 
 /*
@@ -121,7 +100,7 @@ static const struct user_regset nios2_regsets[] = {
 		.n = NUM_PTRACE_REG,
 		.size = sizeof(unsigned long),
 		.align = sizeof(unsigned long),
-		.get = genregs_get,
+		.get2 = genregs_get,
 		.set = genregs_set,
 	}
 };
-- 
2.11.0

