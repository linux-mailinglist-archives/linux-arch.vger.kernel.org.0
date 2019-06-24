Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E34D5015C
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2019 07:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfFXFrm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jun 2019 01:47:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40386 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFXFrm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2019 01:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4Cn/I+p4O/dbVe7rVqc9HfZYCz1ua5PfF/f6FCO/YsM=; b=Geyx+EEj8T8Rvcz2Io7FLL5Jdm
        Ogm9Jhc851oKHZT0kV/vC3eLhZ09tHwq3dWKNbe0D8Sedurnva0SuZEGd0WRmARR+Nz5ScmspEMUM
        l/5opovU3wZ8IF6uIJRY88EYzfwdP41aU8I3PKX/0WQyXV7FP82MN4MGx9m1ox0VUC2ENEwpM7CpJ
        yacLxsXR5hNZkK6+TZdMpUseUCLyLCLw78SG+EHnpY3+FU1PSQO2QdDxeXsd+614Mj6kk70bm+UEh
        atxuArY7t6MJ9EFx21aV7qXqVlhdBelGPqoYJ3aa36BM6+kmColhuNQUyZGxO337kMY690JDvCLKG
        4X+91xqw==;
Received: from 213-225-6-159.nat.highway.a1.net ([213.225.6.159] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfHpJ-0000Qb-9c; Mon, 24 Jun 2019 05:47:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] powerpc: don't use asm-generic/ptrace.h
Date:   Mon, 24 Jun 2019 07:47:25 +0200
Message-Id: <20190624054728.30966-3-hch@lst.de>
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
 arch/powerpc/include/asm/ptrace.h | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index faa5a338ac5a..feee1b21bbd5 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -111,18 +111,33 @@ struct pt_regs
 
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

