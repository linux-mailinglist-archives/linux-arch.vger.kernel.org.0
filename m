Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C937D74E87C
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 09:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjGKH6s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jul 2023 03:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjGKH6r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jul 2023 03:58:47 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B598F7
        for <linux-arch@vger.kernel.org>; Tue, 11 Jul 2023 00:58:42 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbef8ad9bbso59800445e9.0
        for <linux-arch@vger.kernel.org>; Tue, 11 Jul 2023 00:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689062321; x=1691654321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDYIXf8sIKLPYejGQ8O6uVDYRyye9psJA+Q5PmU0G6c=;
        b=w92bWwP4/B9Yg8nTudHNREZgu5pw/Y+pQ/5HeoGML42uuWQbv8zilzfmgXbkrCeUXJ
         BigOw37ZeE+XRBcUme8MnQpOGaTDa7wH4BCEBKoFhYCZ+hVEXq0Q3Mv/yS9fBPm22IAZ
         5H2e5BzVRS345P78IGjkr7Sg6L606PPnBu/yLKT3L5E04/awzbxsIVShbm8PjQD8fNKG
         cq982sPP3LSK8cemVb1+wFEr0xgVkryUn7u3N0cBuFOQEhKyoy/uauDpQuDZhIntYloR
         KCSkuNsDO2zpLsRgyBdBNuZUfDREeDfyFDyDnHp6qvfQoWIgJOr3FntAg4EIsSB3wIGx
         QgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689062321; x=1691654321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDYIXf8sIKLPYejGQ8O6uVDYRyye9psJA+Q5PmU0G6c=;
        b=KgGYoqCpMhz9vpt2Vs/r5YhaqrjX6w8/3b8AXYNS4DUd7u9omCB95p3h9Jze7a+ZpR
         Kmp9h6v5Wy87f1w+xa+pCIg4H0pUO6jgrF9S0CqVZ+7jVeX54dx+Xuxr11Se+2DliTTz
         qfQWJ3xSUV79V1xWToi8qe0l8oQ9r0qJflrRx1Cr8IODAls6fgJMQjG0l4SshNBi/MSb
         meYUKC43kYS+NeFGpKYJAFS5FYCzVwDJyiqjomi/5cZQBdbN3gU0PF1QtV+xGI5QWXOq
         7a51yLPAz63bk9jjFJ0qrGPD7ZvhpWTmQWrDYl7uTtoIsbUi0SDqcBaJYPlLmiJlWxrc
         An1Q==
X-Gm-Message-State: ABy/qLZKhF/fa+7bgCPpexipn1uKTw6bvRFIPAaYk9ozpNSe4pX1QY3i
        ltPZcmmHhrzrOgM3W9WT6oUeMQ==
X-Google-Smtp-Source: APBJJlFsBtStWYZgknujylpz0AhL0BNK0IKMFzV1Mxb+JDn6KB3EiMXLptQkKqpS3M+govHnZDRwFw==
X-Received: by 2002:a7b:c38b:0:b0:3fc:524:e80a with SMTP id s11-20020a7bc38b000000b003fc0524e80amr10779950wmj.18.1689062321091;
        Tue, 11 Jul 2023 00:58:41 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c020c00b003fbfa6066acsm1750168wmi.40.2023.07.11.00.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 00:58:40 -0700 (PDT)
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
Subject: [PATCH 4/4] riscv: Improve flush_tlb_kernel_range()
Date:   Tue, 11 Jul 2023 09:54:34 +0200
Message-Id: <20230711075434.10936-5-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230711075434.10936-1-alexghiti@rivosinc.com>
References: <20230711075434.10936-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index de61ecaa218a..07cfed83bec8 100644
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

