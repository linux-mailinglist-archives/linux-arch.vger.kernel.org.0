Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9F010C40
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2019 19:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfEARk0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 May 2019 13:40:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34902 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfEARkZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 May 2019 13:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9uZ/wqe1yQaxeZGmSHgVR7vRObUy2Edj17fvVA3rSkc=; b=ureZ2uwFWAv0boJbaASFTLiLqo
        cwpQuz+6cntZPZhxbNRyJ7Mfey6+lMC0cOQ/CApHG9GmvXqk+WPg6on3YzgVD41ri9YMjVOfm2i03
        +uPrhV1/Q582cgjmdhb4dwul4/3FyEsZSbf1rv3kLEqYl/kN0xxinXjUPv7L51eHVHdIGKpfEyp50
        n1LjByrsWBCg2qUfEp7G3vDJaptHINPYajPTtGrMbdCrvfGw/FQ1XETWoOpltUITAihRHmXqTrfqn
        /4cPC29fHysyTA7VIph6f97d3jXmNj/NTG9MH/uhfkouNYoJX0rvQd54xtIHUOc+quhIrksQZxGWk
        WTNSl4mA==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLtDS-0005tm-QA; Wed, 01 May 2019 17:40:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] arm64: don't use asm-generic/ptrace.h
Date:   Wed,  1 May 2019 13:39:39 -0400
Message-Id: <20190501173943.5688-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190501173943.5688-1-hch@lst.de>
References: <20190501173943.5688-1-hch@lst.de>
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
 arch/arm64/include/asm/ptrace.h | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index ec60174c8c18..55c1fb25cf32 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -228,11 +228,12 @@ static inline void forget_syscall(struct pt_regs *regs)
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
@@ -309,13 +310,20 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
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
 
@@ -325,7 +333,6 @@ static inline void procedure_link_pointer_set(struct pt_regs *regs,
 	procedure_link_pointer(regs) = val;
 }
 
-#undef profile_pc
 extern unsigned long profile_pc(struct pt_regs *regs);
 
 #endif /* __ASSEMBLY__ */
-- 
2.20.1

