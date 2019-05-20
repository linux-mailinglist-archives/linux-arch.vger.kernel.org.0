Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F34EC22BB2
	for <lists+linux-arch@lfdr.de>; Mon, 20 May 2019 08:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbfETGBn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 May 2019 02:01:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47300 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730586AbfETGBW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 May 2019 02:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ngUiwEDQptjC481jfdI3glduioMsRJldRZETJeFfRw8=; b=tWllbJkM0+gq/92RkxJXus5kXz
        QBnmf6zrANZ+wzjcxXpRuU6gO6nZk+96nOSFMFSwetj5SRvYCtkf0u5vjaKfuGCI4jqiyJePzpzic
        tdJuke4XxfyG+HKakDB+7bCKV0dqLZOONFeOUNGnudYJmjR6xGaXiQt7jwZd/a/ROkVaeXMrFtKMx
        HWP5BgtEyfy8J9kdrL1QB6L0QKQW0NS4z3KVckU5YR/6fFufanf1B0cc3AkDPWhWD16xBEco6syGX
        3//SUCrGccT/oqtjkGINSg+o9fx8tXw3PkWZALAdes/Ikb3QvA8WmHmk4G5SU7IDAvq5pvdc7eHgu
        0ouF+ouA==;
Received: from 089144206147.atnat0015.highway.bob.at ([89.144.206.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSbMM-0001Z4-Fi; Mon, 20 May 2019 06:01:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] sh: don't use asm-generic/ptrace.h
Date:   Mon, 20 May 2019 08:00:16 +0200
Message-Id: <20190520060018.25569-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520060018.25569-1-hch@lst.de>
References: <20190520060018.25569-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Doing the indirection through macros for the regs accessors just
makes them harder to read, so implement the helpers directly.

Note that only the helpers actually used are implemented now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/include/asm/ptrace.h | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/sh/include/asm/ptrace.h b/arch/sh/include/asm/ptrace.h
index 9143c7babcbe..6c89e3e04cee 100644
--- a/arch/sh/include/asm/ptrace.h
+++ b/arch/sh/include/asm/ptrace.h
@@ -16,8 +16,31 @@
 #define user_mode(regs)			(((regs)->sr & 0x40000000)==0)
 #define kernel_stack_pointer(_regs)	((unsigned long)(_regs)->regs[15])
 
-#define GET_FP(regs)	((regs)->regs[14])
-#define GET_USP(regs)	((regs)->regs[15])
+static inline unsigned long instruction_pointer(struct pt_regs *regs)
+{
+	return regs->pc;
+}
+static inline void instruction_pointer_set(struct pt_regs *regs,
+		unsigned long val)
+{
+	regs->pc = val;
+}
+
+static inline unsigned long frame_pointer(struct pt_regs *regs)
+{
+	return regs->regs[14];
+}
+
+static inline unsigned long user_stack_pointer(struct pt_regs *regs)
+{
+	return regs->regs[15];
+}
+
+static inline void user_stack_pointer_set(struct pt_regs *regs,
+		unsigned long val)
+{
+	regs->regs[15] = val;
+}
 
 #define arch_has_single_step()	(1)
 
@@ -112,7 +135,5 @@ static inline unsigned long profile_pc(struct pt_regs *regs)
 
 	return pc;
 }
-#define profile_pc profile_pc
 
-#include <asm-generic/ptrace.h>
 #endif /* __ASM_SH_PTRACE_H */
-- 
2.20.1

