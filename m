Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8839D20E4B8
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgF2V2R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbgF2Smn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:43 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B734C033C24;
        Mon, 29 Jun 2020 11:26:34 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyUC-002Dwd-Qa; Mon, 29 Jun 2020 18:26:32 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 32/41] h8300: switch to ->get2()
Date:   Mon, 29 Jun 2020 19:26:19 +0100
Message-Id: <20200629182628.529995-32-viro@ZenIV.linux.org.uk>
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
 arch/h8300/kernel/ptrace.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/h8300/kernel/ptrace.c b/arch/h8300/kernel/ptrace.c
index 0dc1c8f622bc..a99cbe91a6d3 100644
--- a/arch/h8300/kernel/ptrace.c
+++ b/arch/h8300/kernel/ptrace.c
@@ -87,20 +87,15 @@ int h8300_put_reg(struct task_struct *task, int regno, unsigned long data)
 
 static int regs_get(struct task_struct *target,
 		    const struct user_regset *regset,
-		    unsigned int pos, unsigned int count,
-		    void *kbuf, void __user *ubuf)
+		    struct membuf to)
 {
 	int r;
-	struct user_regs_struct regs;
-	long *reg = (long *)&regs;
 
-	/* build user regs in buffer */
-	BUILD_BUG_ON(sizeof(regs) % sizeof(long) != 0);
-	for (r = 0; r < sizeof(regs) / sizeof(long); r++)
-		*reg++ = h8300_get_reg(target, r);
+	BUILD_BUG_ON(sizeof(struct user_regs_struct) % sizeof(long) != 0);
+	for (r = 0; r < ELF_NGREG; r++)
+		membuf_store(&to, h8300_get_reg(target, r));
 
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   &regs, 0, sizeof(regs));
+	return 0;
 }
 
 static int regs_set(struct task_struct *target,
@@ -139,7 +134,7 @@ static const struct user_regset h8300_regsets[] = {
 		.n		= ELF_NGREG,
 		.size		= sizeof(long),
 		.align		= sizeof(long),
-		.get		= regs_get,
+		.get2		= regs_get,
 		.set		= regs_set,
 	},
 };
-- 
2.11.0

