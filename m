Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF3C76AB83
	for <lists+linux-arch@lfdr.de>; Tue,  1 Aug 2023 10:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjHAI6S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Aug 2023 04:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjHAI6O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Aug 2023 04:58:14 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE16E7
        for <linux-arch@vger.kernel.org>; Tue,  1 Aug 2023 01:58:12 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so59883505e9.2
        for <linux-arch@vger.kernel.org>; Tue, 01 Aug 2023 01:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690880291; x=1691485091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMcN1+GqTG/8Na8yFouBO/VVBZef6ZJ3qQN1SPpRTO4=;
        b=L6MD/IpkJ8ijD8AQNDxVBvTARXP1lNuZC1nsssVE1h3LiyUW7vd/sEKLX+4vvj3bC3
         GAbuOy4LDXQWnyB80R1g/cm5UVJhCHHyfh/rUGwrJGyuUad+i3gBhRlknE+R4jdD/+UG
         gJbmECUiJGhTG0NacduUsWtak+tjx/jnkdY9FXJnlH4HxB82s4ORT/QIdYV9z/xkF4/K
         faM3GF13ygpkXHTDnFrYgoD4HcG2BZgiqUceZvmSv87fyDS6JjKD1dRjiDQCznsNu2lQ
         vwHMBsfaVvBqKLKQp+D/dRJqukzaNyIX1DRhPPpk8LawOxtRUH/BOPeGyUTtn+4Myb5q
         oRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690880291; x=1691485091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMcN1+GqTG/8Na8yFouBO/VVBZef6ZJ3qQN1SPpRTO4=;
        b=K3c81fs7pjQ1nCJPs3OrxzD2zuAsJEUwZNxtmwkJ23MnjGvL57LV77o8ObzCJ79jaJ
         T2nCdq455ZgvrldohQ80qzz1bRUqUa9ELF2GlWIQIwEOj+V+oKiT0KkvyHjAt30X7Xk/
         xMs13MzPrRZH4Q3XXgIZi3+5wZ4TFBnCQCs1WWs1ShU7Qvx+QcCyjoBfoo02Ob3oIV/N
         PsrKVBt21VpoLb8eWdyS4vu+/PLoNLqRcnQqv9FBJ3EFAmebo/XCkTYA+RRSyaw7eSW3
         me7qV/2TVzFn6qSQX42LoBFYmXNG2OZXMtkDVcKv8X9IoSfnhYFErhuRzHcTzAkaQUe+
         qiYQ==
X-Gm-Message-State: ABy/qLa22vywflFJvKSiZ3sQzaqj2VFp+jNDXjoNyJhW57e1lBc1iEUl
        LbwoTahBSR/411vU03f4WpAdUQ==
X-Google-Smtp-Source: APBJJlEF2Zvw+ZslWuFsVPPOKTzS3UA31UlJYffINUkSj0yPwhIPAXHFC54ECs88TtNi5FfcGYso9w==
X-Received: by 2002:a05:600c:285:b0:3fe:1d13:4664 with SMTP id 5-20020a05600c028500b003fe1d134664mr1898359wmk.6.1690880290827;
        Tue, 01 Aug 2023 01:58:10 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id c6-20020a05600c0ac600b003fe20db88e2sm5255370wmr.18.2023.08.01.01.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 01:58:10 -0700 (PDT)
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
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v3 4/4] riscv: Improve flush_tlb_kernel_range()
Date:   Tue,  1 Aug 2023 10:54:02 +0200
Message-Id: <20230801085402.1168351-5-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230801085402.1168351-1-alexghiti@rivosinc.com>
References: <20230801085402.1168351-1-alexghiti@rivosinc.com>
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
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/tlbflush.h | 11 +++++-----
 arch/riscv/mm/tlbflush.c          | 34 +++++++++++++++++++++++--------
 2 files changed, 31 insertions(+), 14 deletions(-)

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
index 0c955c474f3a..687808013758 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -120,18 +120,27 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
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
@@ -165,7 +174,8 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 		}
 	}
 
-	put_cpu();
+	if (mm)
+		put_cpu();
 }
 
 void flush_tlb_mm(struct mm_struct *mm)
@@ -196,6 +206,12 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 
 	__flush_tlb_range(vma->vm_mm, start, end - start, stride_size);
 }
+
+void flush_tlb_kernel_range(unsigned long start, unsigned long end)
+{
+	__flush_tlb_range(NULL, start, end, PAGE_SIZE);
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end)
-- 
2.39.2

