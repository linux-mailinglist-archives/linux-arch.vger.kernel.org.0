Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25A7B10C3D
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2019 19:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfEARka (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 May 2019 13:40:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35202 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfEARk1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 May 2019 13:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Gkftjl1SPlwlgHVgBmP2lO3UX5HsGm179rqO0LQY9FM=; b=NscaRcvvcFam/+9Ik1AIzVKDij
        YWabhL+Jh814K8jMkQoMdj5UgoXHhsEF2KGzC7I0TBtfntOjKYdkFr3wAsayjvBQ8uYa78Rf+SC3p
        mRkT8ibnXaX/VdzziwnP0W/eECj9/wKKL+oIZNfGgfabggKXBZLNbxldRE6HYZ2haQ8pODXKNg+qM
        Zbab2LJDFqkgBhgxFPoppkTOj+vwRCehKfBLueO2MVWQE1Vame9yXRU74zEfBcG3rEzIozxn+q3gJ
        wiX6YrPalHa35TAil4z+/zYPdnoSg/390QsqmuOuXRJFJ2GxJbrtWeLWJojF9SxHQ4MNS3bV8xZMk
        mMcEiWZg==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLtDU-0005uM-Hp; Wed, 01 May 2019 17:40:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] powerpc: don't use asm-generic/ptrace.h
Date:   Wed,  1 May 2019 13:39:40 -0400
Message-Id: <20190501173943.5688-3-hch@lst.de>
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
 arch/powerpc/include/asm/ptrace.h | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 64271e562fed..5d30944f1f6b 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -108,18 +108,33 @@ struct pt_regs
 
 #ifndef __ASSEMBLY__
 
-#define GET_IP(regs)		((regs)->nip)
-#define GET_USP(regs)		((regs)->gpr[1])
-#define GET_FP(regs)		(0)
-#define SET_FP(regs, val)
+static inline unsigned long instruction_pointer(struct pt_regs *regs)
+{
+	return regs->nip;
+}
+
+static inline void instruction_pointer_set(struct pt_regs *regs,
+		unsigned long val)
+{
+	regs->nip = val;
+}
+
+static inline unsigned long user_stack_pointer(struct pt_regs *regs)
+{
+	return regs->gpr[1];
+}
+
+static inline unsigned long frame_pointer(struct pt_regs *regs)
+{
+	return 0;
+}
 
 #ifdef CONFIG_SMP
 extern unsigned long profile_pc(struct pt_regs *regs);
-#define profile_pc profile_pc
+#else
+#define profile_pc(regs) instruction_pointer(regs)
 #endif
 
-#include <asm-generic/ptrace.h>
-
 #define kernel_stack_pointer(regs) ((regs)->gpr[1])
 static inline int is_syscall_success(struct pt_regs *regs)
 {
-- 
2.20.1

