Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899CE20D1C8
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 20:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgF2Snv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 14:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729137AbgF2Smw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:52 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1C8C033C26;
        Mon, 29 Jun 2020 11:26:34 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyUC-002Dw9-2R; Mon, 29 Jun 2020 18:26:32 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 29/41] c6x: switch to ->get2()
Date:   Mon, 29 Jun 2020 19:26:16 +0100
Message-Id: <20200629182628.529995-29-viro@ZenIV.linux.org.uk>
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
 arch/c6x/kernel/ptrace.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/c6x/kernel/ptrace.c b/arch/c6x/kernel/ptrace.c
index 67af1562da86..d2402de2bc14 100644
--- a/arch/c6x/kernel/ptrace.c
+++ b/arch/c6x/kernel/ptrace.c
@@ -57,14 +57,9 @@ static inline int put_reg(struct task_struct *task,
 
 static int gpr_get(struct task_struct *target,
 		   const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
+		   struct membuf to)
 {
-	struct pt_regs *regs = task_pt_regs(target);
-
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   regs,
-				   0, sizeof(*regs));
+	return membuf_write(&to, task_pt_regs(target), sizeof(struct pt_regs));
 }
 
 enum c6x_regset {
@@ -77,7 +72,7 @@ static const struct user_regset c6x_regsets[] = {
 		.n = ELF_NGREG,
 		.size = sizeof(u32),
 		.align = sizeof(u32),
-		.get = gpr_get,
+		.get2 = gpr_get,
 	},
 };
 
-- 
2.11.0

