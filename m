Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6F925911A
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 16:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgIAOpD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 10:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbgIAOQJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 10:16:09 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CF9C061261;
        Tue,  1 Sep 2020 07:16:08 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id z15so597681plo.7;
        Tue, 01 Sep 2020 07:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u6Dup+ArfJ1cGNtaPdNiGwIK5zxtRVAfzzcCu/uBGUo=;
        b=VtIsRogdzz/B4ItJXOYG0iCNVWxRGKUQreNEa3CcflLUskSxARaPoPP2PSbjw18Tkb
         9uMw5aOoeqEMnAN3muUKRO6Ufe6NtCgF9KWdYlfKVTAaJYX3WG0tVcL8VEXZBJP7e8Wx
         Ijz5TwF8bXrHhFkR5Qm2WLFbiR7Z85F7SZhZsztZ+UQlr0YgXcPMxAvDolgs8Q/kUiqq
         V9Z4zuaJ/2rRZ5wE1tRYEHRvc2Xb+4vU2izP65TQEQK56/rBGIFIIM1YVFkCiKR88pGM
         T2ZAp2ajUmITAdEl2d+dZGes0KnwDskLcy5mLbYLM6tuSjEg52KFVvelL7TzEFUOvkrM
         5ryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u6Dup+ArfJ1cGNtaPdNiGwIK5zxtRVAfzzcCu/uBGUo=;
        b=dwNvJa6XKyOQQc93+aI75VlUBN1tc9X9qvuywaBqd47r+XADyz7iN9iehMLMeqh2BV
         l/ZNabHA/Y8MkbjUMAftm6Zg2ZZnDlEiSR46Qe7OxyuHmXQVNTl2eZ3PL38YEacrUlZZ
         +P10R5p7J5VstgNGn04BZKN64dIEoDbhmQoldqDnV8NeqdjCuDtypVvnX7DsjWXultGN
         hrrg/H+IejWhL21dzUTXa9ENoQzr0yEA2lJc6c0TRJDiaoRo/fOEPKSDbX1GDls+OyO3
         yDhUG3H9QQF71GM67n1s6q72T3d9l8TEl2//bD+d2wwNo48+QN4p/iRwbBYU4XGphWDL
         9pWg==
X-Gm-Message-State: AOAM5320yj4dRyzqpQRWHafjiVbHfzAaFRMwT0l/idws+CY7Jx1oZIhE
        G6PddHdNV94dZXGTxUHg6EWcPjhHNnM=
X-Google-Smtp-Source: ABdhPJyAinElz1sorI3kdkH6fqTFkR16OPVqZrPUyKnI8QoHoDqnjFXfTtMHJRA7puFOHsWIzJotcg==
X-Received: by 2002:a17:90a:c255:: with SMTP id d21mr1859599pjx.212.1598969768315;
        Tue, 01 Sep 2020 07:16:08 -0700 (PDT)
Received: from bobo.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id w9sm2212816pgg.76.2020.09.01.07.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:16:07 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3 05/23] arm64: use asm-generic/mmu_context.h for no-op implementations
Date:   Wed,  2 Sep 2020 00:15:21 +1000
Message-Id: <20200901141539.1757549-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200901141539.1757549-1-npiggin@gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/arm64/include/asm/mmu_context.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index f2d7537d6f83..fe2862aa1dad 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -174,7 +174,6 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp)
  * Setting a reserved TTBR0 or EPD0 would work, but it all gets ugly when you
  * take CPU migration into account.
  */
-#define destroy_context(mm)		do { } while(0)
 void check_and_switch_context(struct mm_struct *mm);
 
 #define init_new_context(tsk,mm)	({ atomic64_set(&(mm)->context.id, 0); 0; })
@@ -202,6 +201,7 @@ static inline void update_saved_ttbr0(struct task_struct *tsk,
 }
 #endif
 
+#define enter_lazy_tlb enter_lazy_tlb
 static inline void
 enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
@@ -242,12 +242,11 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	update_saved_ttbr0(tsk, next);
 }
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
-#define activate_mm(prev,next)	switch_mm(prev, next, current)
-
 void verify_cpu_asid_bits(void);
 void post_ttbr_update_workaround(void);
 
+#include <asm-generic/mmu_context.h>
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* !__ASM_MMU_CONTEXT_H */
-- 
2.23.0

