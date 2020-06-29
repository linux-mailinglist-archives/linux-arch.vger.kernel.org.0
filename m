Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C13520E497
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390951AbgF2V1C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729076AbgF2Smp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:45 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DED4C033C2A;
        Mon, 29 Jun 2020 11:26:35 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyUE-002Dxw-0M; Mon, 29 Jun 2020 18:26:34 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 38/41] csky: switch to ->get2()
Date:   Mon, 29 Jun 2020 19:26:25 +0100
Message-Id: <20200629182628.529995-38-viro@ZenIV.linux.org.uk>
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

NB: WTF is fpregs_get() playing at???

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/csky/kernel/ptrace.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
index 944ca2fdcdd9..acd36aeb5222 100644
--- a/arch/csky/kernel/ptrace.c
+++ b/arch/csky/kernel/ptrace.c
@@ -76,17 +76,14 @@ enum csky_regset {
 
 static int gpr_get(struct task_struct *target,
 		   const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
+		   struct membuf to)
 {
-	struct pt_regs *regs;
-
-	regs = task_pt_regs(target);
+	struct pt_regs *regs = task_pt_regs(target);
 
 	/* Abiv1 regs->tls is fake and we need sync here. */
 	regs->tls = task_thread_info(target)->tp_value;
 
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, regs, 0, -1);
+	return membuf_write(&to, regs, sizeof(regs));
 }
 
 static int gpr_set(struct task_struct *target,
@@ -114,8 +111,7 @@ static int gpr_set(struct task_struct *target,
 
 static int fpr_get(struct task_struct *target,
 		   const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
+		   struct membuf to)
 {
 	struct user_fp *regs = (struct user_fp *)&target->thread.user_fp;
 
@@ -131,9 +127,9 @@ static int fpr_get(struct task_struct *target,
 	for (i = 0; i < 32; i++)
 		tmp.vr[64 + i] = regs->vr[32 + i];
 
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, &tmp, 0, -1);
+	return membuf_write(&to, &tmp, sizeof(tmp));
 #else
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, regs, 0, -1);
+	return membuf_write(&to, regs, sizeof(*regs));
 #endif
 }
 
@@ -173,16 +169,16 @@ static const struct user_regset csky_regsets[] = {
 		.n = sizeof(struct pt_regs) / sizeof(u32),
 		.size = sizeof(u32),
 		.align = sizeof(u32),
-		.get = &gpr_get,
-		.set = &gpr_set,
+		.get2 = gpr_get,
+		.set = gpr_set,
 	},
 	[REGSET_FPR] = {
 		.core_note_type = NT_PRFPREG,
 		.n = sizeof(struct user_fp) / sizeof(u32),
 		.size = sizeof(u32),
 		.align = sizeof(u32),
-		.get = &fpr_get,
-		.set = &fpr_set,
+		.get2 = fpr_get,
+		.set = fpr_set,
 	},
 };
 
-- 
2.11.0

