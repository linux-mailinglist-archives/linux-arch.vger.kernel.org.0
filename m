Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1DC650160
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2019 07:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfFXFrq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jun 2019 01:47:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40674 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFXFrp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2019 01:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ngUiwEDQptjC481jfdI3glduioMsRJldRZETJeFfRw8=; b=L/ebEIO6xHYky7VBCsfRUVQNg0
        D++f+IEhdjHE9AwB9Nhb8AXNoTtlbdsLJkZFuvqod0MK45BYptEU0DT2vWq+8ek2/UliERR2rlz7A
        E2wDG1s4vKNEpqy4abZU51yhpOm0H7oPAdEsmZAVY27g7APHm3y2+I9UYwV5ttjDq2D0INSoyOrsb
        ARo4j7oUUxU3ODnVnsV5sXrB8AySkDyl6qUZVD5107Yiyznjvjpv/zXowmYAKyWYy2kZQfJ1wFPYJ
        IaIlfa13QjFXlG8vsOjeRYA/IxxTXqVVsacNgf91PHBgWmIGF5fNJTxcK/VuhwBOsN5Ntbnih/TVQ
        jL0nq6CA==;
Received: from 213-225-6-159.nat.highway.a1.net ([213.225.6.159] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfHpM-0000Ti-N8; Mon, 24 Jun 2019 05:47:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] sh: don't use asm-generic/ptrace.h
Date:   Mon, 24 Jun 2019 07:47:26 +0200
Message-Id: <20190624054728.30966-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624054728.30966-1-hch@lst.de>
References: <20190624054728.30966-1-hch@lst.de>
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

