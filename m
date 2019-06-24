Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 524155016A
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2019 07:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfFXFri (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jun 2019 01:47:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40122 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFXFri (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2019 01:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ndfa+JKWTk3kzzF004ASgmL4z41nQdlLlRUSyqusF/U=; b=D9gsBXZ2YcAPTTbBmQS/vLmDfY
        s9bF06g6zsYg1LipefmOqHzSZNCIb7D+W7rYfxuWPiBuRzs5aUYxVY30pRZGpgMh6+r2J2EVpi8sA
        all3gvLNDH1nfd2YLU6628d5FVBaIiplH6OTA6TXFfU1pd1BdGA0iF/Y0BsqtD89FJ1hpPMie3DDi
        nYzKJVXblcXA2+H3U8WjbiT6ornBfNhRo86ga8RV1uXp92mv/qjDT+nYrLyU2lVQu6dFqz/R/WpT5
        XAlEQ0JxpQ9wb1w1kC3vmNie0oa/YIlld5OBLaid+3hu+FDEEw3aDL/7rdSpaTcWThHooNI+whX3M
        KKRFPZ8Q==;
Received: from 213-225-6-159.nat.highway.a1.net ([213.225.6.159] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfHpF-0000OF-Th; Mon, 24 Jun 2019 05:47:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 1/5] arm64: don't use asm-generic/ptrace.h
Date:   Mon, 24 Jun 2019 07:47:24 +0200
Message-Id: <20190624054728.30966-2-hch@lst.de>
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
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/ptrace.h | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index dad858b6adc6..5a1e5025db96 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -217,11 +217,12 @@ static inline void forget_syscall(struct pt_regs *regs)
 #define fast_interrupts_enabled(regs) \
 	(!((regs)->pstate & PSR_F_BIT))
 
-#define GET_USP(regs) \
-	(!compat_user_mode(regs) ? (regs)->sp : (regs)->compat_sp)
-
-#define SET_USP(ptregs, value) \
-	(!compat_user_mode(regs) ? ((regs)->sp = value) : ((regs)->compat_sp = value))
+static inline unsigned long user_stack_pointer(struct pt_regs *regs)
+{
+	if (compat_user_mode(regs))
+		return regs->compat_sp;
+	return regs->sp;
+}
 
 extern int regs_query_register_offset(const char *name);
 extern unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
@@ -320,13 +321,20 @@ static inline unsigned long regs_get_kernel_argument(struct pt_regs *regs,
 struct task_struct;
 int valid_user_regs(struct user_pt_regs *regs, struct task_struct *task);
 
-#define GET_IP(regs)		((unsigned long)(regs)->pc)
-#define SET_IP(regs, value)	((regs)->pc = ((u64) (value)))
-
-#define GET_FP(ptregs)		((unsigned long)(ptregs)->regs[29])
-#define SET_FP(ptregs, value)	((ptregs)->regs[29] = ((u64) (value)))
+static inline unsigned long instruction_pointer(struct pt_regs *regs)
+{
+	return regs->pc;
+}
+static inline void instruction_pointer_set(struct pt_regs *regs,
+		unsigned long val)
+{
+	regs->pc = val;
+}
 
-#include <asm-generic/ptrace.h>
+static inline unsigned long frame_pointer(struct pt_regs *regs)
+{
+	return regs->regs[29];
+}
 
 #define procedure_link_pointer(regs)	((regs)->regs[30])
 
@@ -336,7 +344,6 @@ static inline void procedure_link_pointer_set(struct pt_regs *regs,
 	procedure_link_pointer(regs) = val;
 }
 
-#undef profile_pc
 extern unsigned long profile_pc(struct pt_regs *regs);
 
 #endif /* __ASSEMBLY__ */
-- 
2.20.1

