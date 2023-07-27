Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427A9765BC6
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jul 2023 21:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjG0TAJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jul 2023 15:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjG0TAI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jul 2023 15:00:08 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28618212A
        for <linux-arch@vger.kernel.org>; Thu, 27 Jul 2023 12:00:07 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b701e1ca63so20482831fa.1
        for <linux-arch@vger.kernel.org>; Thu, 27 Jul 2023 12:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690484405; x=1691089205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNz5ULfyNJeCjPsvwCv5L4clxVFquhVEWOvSxelKP+w=;
        b=GSLEhl1R8oaK89GQOF+Pv24vQFwey5dkoAOjZEenIXfi01TU4C1AFY7vwTgG+IbUlF
         Bt6mSf5r0S5qnDSbj7fbdtGv7jJ9iOIgyrK6WLr9GeK+jc2ceGyLFhK5wvI+lwtOGyns
         czustvBmWlA/JC7ECm2Z0wVylVcw7vbMO0XeSmF1L7ausPlrs8/XAS6Xs65/CWeQ8Wfp
         tsRKYYdO/ryRUCT9y2Jg2iATmCj4AqgpipC57hi+IHiQ5cyV+qpL+Zjknvlp0yeTBYnd
         SQsKP9CGJ03Unrmv/tUdQbc4zK6ruo/AZl67eW8Md9grR2PmdteBl/N9wtoGp55xr42V
         jXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690484405; x=1691089205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNz5ULfyNJeCjPsvwCv5L4clxVFquhVEWOvSxelKP+w=;
        b=kfBst+vdq/OM2hbvBhGMuogR5rnCeA/zYBBqlujmEJmZGSUDr++04WA5sk0J/OjD37
         IejIoCR7yG4AYszQq4RSq67R6U0x11XQYv+PvVcKZZiGT4p+beyHYUTyVUey6LyzXveM
         BC1fD8SOexMoJ/+ArdX7t4zjGoesk3p1EAsq078AIRzJ7L306w65SYhuLG2FR3eKp3j+
         IFM808jmQcutzVdKw9FctUZ7pGLMvZJIlFnF2bQNwQOX4s1gqOzCxV38dABZniXZfwZ4
         P9P0qXk56c0UcjHZaSZ1XCShvDaA0eOo/XH/2QTod7TDzV+llwnJyp2kygKs3uQ16Rfe
         F7CQ==
X-Gm-Message-State: ABy/qLZLoGhPsJ6QXslQvKktBXqbtSKVtvJxXPmLIdBh3I4AXYz4Mcoz
        jT8oeJIKxtPtGpGeTg5hMycOxw==
X-Google-Smtp-Source: APBJJlHJDmgCrOPWkDvISdqVBAhll7aGnu9u1uL1uj24Zj+LruMascb6qDrvCi38iKxywHDYgHx7iw==
X-Received: by 2002:a2e:9444:0:b0:2b6:da64:321 with SMTP id o4-20020a2e9444000000b002b6da640321mr2299474ljh.45.1690484405350;
        Thu, 27 Jul 2023 12:00:05 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id p1-20020a7bcc81000000b003fa96fe2bebsm2470792wma.41.2023.07.27.12.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 12:00:05 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 4/4] riscv: Improve flush_tlb_kernel_range()
Date:   Thu, 27 Jul 2023 20:55:53 +0200
Message-Id: <20230727185553.980262-5-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727185553.980262-1-alexghiti@rivosinc.com>
References: <20230727185553.980262-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This function used to simply flush the whole tlb of all harts, be more
subtile and try to only flush the range.

The problem is that we can only use PAGE_SIZE as stride since we don't know
the size of the underlying mapping and then this function will be improved
only if the size of the region to flush is < threshold * PAGE_SIZE.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/tlbflush.h | 11 +++++-----
 arch/riscv/mm/tlbflush.c          | 35 +++++++++++++++++++++++--------
 2 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index f5c4fb0ae642..7426fdcd8ec5 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -37,6 +37,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end);
+void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
@@ -53,15 +54,15 @@ static inline void flush_tlb_range(struct vm_area_struct *vma,
 	local_flush_tlb_all();
 }
 
-#define flush_tlb_mm(mm) flush_tlb_all()
-#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all()
-#endif /* !CONFIG_SMP || !CONFIG_MMU */
-
 /* Flush a range of kernel pages */
 static inline void flush_tlb_kernel_range(unsigned long start,
 	unsigned long end)
 {
-	flush_tlb_all();
+	local_flush_tlb_all();
 }
 
+#define flush_tlb_mm(mm) flush_tlb_all()
+#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all()
+#endif /* !CONFIG_SMP || !CONFIG_MMU */
+
 #endif /* _ASM_RISCV_TLBFLUSH_H */
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 8017d2130e27..96aeacb269d5 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -117,18 +117,27 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 			      unsigned long size, unsigned long stride)
 {
 	struct flush_tlb_range_data ftd;
-	struct cpumask *cmask = mm_cpumask(mm);
-	unsigned int cpuid;
+	struct cpumask *cmask, full_cmask;
 	bool broadcast;
 
-	if (cpumask_empty(cmask))
-		return;
+	if (mm) {
+		unsigned int cpuid;
+
+		cmask = mm_cpumask(mm);
+		if (cpumask_empty(cmask))
+			return;
+
+		cpuid = get_cpu();
+		/* check if the tlbflush needs to be sent to other CPUs */
+		broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
+	} else {
+		cpumask_setall(&full_cmask);
+		cmask = &full_cmask;
+		broadcast = true;
+	}
 
-	cpuid = get_cpu();
-	/* check if the tlbflush needs to be sent to other CPUs */
-	broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
 	if (static_branch_unlikely(&use_asid_allocator)) {
-		unsigned long asid = atomic_long_read(&mm->context.id) & asid_mask;
+		unsigned long asid = mm ? atomic_long_read(&mm->context.id) & asid_mask : 0;
 
 		if (broadcast) {
 			if (riscv_use_ipi_for_rfence()) {
@@ -162,7 +171,8 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 		}
 	}
 
-	put_cpu();
+	if (mm)
+		put_cpu();
 }
 
 void flush_tlb_mm(struct mm_struct *mm)
@@ -194,6 +204,13 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 	__flush_tlb_range(vma->vm_mm,
 			  start, end - start, 1 << stride_shift);
 }
+
+void flush_tlb_kernel_range(unsigned long start,
+			    unsigned long end)
+{
+	__flush_tlb_range(NULL, start, end, PAGE_SIZE);
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end)
-- 
2.39.2

