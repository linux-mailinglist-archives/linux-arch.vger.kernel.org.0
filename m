Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C752590D5
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 16:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgIAOjg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 10:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbgIAOQu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 10:16:50 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C97C061262;
        Tue,  1 Sep 2020 07:16:50 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id l9so599010plt.8;
        Tue, 01 Sep 2020 07:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=czZmpjb3vWAAbgZB/UHnONa23SwklaXJVc63sdY/64U=;
        b=BxF08WZg7f9I9Et2+jcWpVaEzPjARaog5uM5wGwG4A58L3P0zaVBFSmpRtrYT6Hy0W
         bKOQSv85r2Fkq2HviYC2riKtzPV6ReyulkO7gR214ovKByXCloxpk+/fHJjwRWkryA1X
         TTgsWzcq8LK326EbUzegAFcO2haF3IQLJEcS7BDHgFvEUC48w+8ePTaVSr8G/d2S/G1L
         bZGFFm/WYLmc1vGGVcq/8nbBrjCVXfJwI9PW44HCjeKraYST3Cd0XckNAD5no3j4Wt5H
         uP3ZVzkLnLNLQ4U60lo2QOjU4i1QXJ+ooiqDUUe9iUn0vKTL4JrCKKLafGzybt/7LLfq
         g+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=czZmpjb3vWAAbgZB/UHnONa23SwklaXJVc63sdY/64U=;
        b=mwdea85F/lyTNtX4zglUi1xtEmdtIeIf5c9yZ1cLJVsuB0RPav0+YxPc06/C5Ac/m/
         s1sXxJKvYE0/raEJA96AKQjJMHBdLrI4/Lx6YnAAXWmC1TPO21ITQDjUIeyOb6Accmer
         XZdfrSZpUS01pCgWHjulgLDmeypSmDRGhHAaMg+Jq92YJrLWpWSi9kPyrLGGPkuzzeSc
         9W/BZ/onas5pfMfmb8pgxlRU0Q5xmiWE2Lq1xftl38F57R76LsXcu2povJ7k6iXqrrwL
         crozy2/m/PN4Gu/RWvBhx9hsEJG57SRWAA+l4POoj6fxk99DIOxvRuO73WIhVF4h1L4X
         ngfg==
X-Gm-Message-State: AOAM532Qcu0whaMx2eOA5Cp3gpsegkkTq0Np0yN4KMFED+w/xVEi1uYp
        +7rJUK4e4f2+oqEqbhPZFzr09b1oaAE=
X-Google-Smtp-Source: ABdhPJxhNbtvq/3SFlenMBvIZJCfMciJFkJ0i1FlBjYooCyqjinZrlhhJXw4FKe0Q5JjFy8BKa4yrw==
X-Received: by 2002:a17:90a:de87:: with SMTP id n7mr1784368pjv.208.1598969809728;
        Tue, 01 Sep 2020 07:16:49 -0700 (PDT)
Received: from bobo.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id w9sm2212816pgg.76.2020.09.01.07.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:16:49 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3 16/23] powerpc: use asm-generic/mmu_context.h for no-op implementations
Date:   Wed,  2 Sep 2020 00:15:32 +1000
Message-Id: <20200901141539.1757549-17-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200901141539.1757549-1-npiggin@gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: linuxppc-dev@lists.ozlabs.org
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/mmu_context.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 7f3658a97384..a3a12a8341b2 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -14,7 +14,9 @@
 /*
  * Most if the context management is out of line
  */
+#define init_new_context init_new_context
 extern int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
+#define destroy_context destroy_context
 extern void destroy_context(struct mm_struct *mm);
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 struct mm_iommu_table_group_mem_t;
@@ -235,27 +237,26 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 }
 #define switch_mm_irqs_off switch_mm_irqs_off
 
-
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
 /*
  * After we have set current->mm to a new value, this activates
  * the context for the new mm so we see the new mappings.
  */
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
 {
 	switch_mm(prev, next, current);
 }
 
 /* We don't currently use enter_lazy_tlb() for anything */
+#ifdef CONFIG_PPC_BOOK3E_64
+#define enter_lazy_tlb enter_lazy_tlb
 static inline void enter_lazy_tlb(struct mm_struct *mm,
 				  struct task_struct *tsk)
 {
 	/* 64-bit Book3E keeps track of current PGD in the PACA */
-#ifdef CONFIG_PPC_BOOK3E_64
 	get_paca()->pgd = NULL;
-#endif
 }
+#endif
 
 extern void arch_exit_mmap(struct mm_struct *mm);
 
@@ -298,5 +299,7 @@ static inline int arch_dup_mmap(struct mm_struct *oldmm,
 	return 0;
 }
 
+#include <asm-generic/mmu_context.h>
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_POWERPC_MMU_CONTEXT_H */
-- 
2.23.0

