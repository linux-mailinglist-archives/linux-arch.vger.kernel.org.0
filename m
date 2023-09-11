Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D5779AEC0
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 01:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbjIKVGJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Sep 2023 17:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237821AbjIKNOg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Sep 2023 09:14:36 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D171E9
        for <linux-arch@vger.kernel.org>; Mon, 11 Sep 2023 06:14:31 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31dcf18f9e2so4448282f8f.0
        for <linux-arch@vger.kernel.org>; Mon, 11 Sep 2023 06:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694438070; x=1695042870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTDHLs2EOQtTQ3uvgmHng/nVHNHrVDMEJR/1UpGvkHQ=;
        b=ih6fPiRWhM99VrBO0xtdVabZtcF3TW2H5hp05fL/b+8o7zmdj83CqaYN2x10JxMXGQ
         7qIufL1278dXyWIQSCiNclIAWyM7CMI+iwzTWyMK/0GoB09o48J1og4BNFBoEJV/A448
         PkJUR4EnjhKvJewbs6znbbNEA4xXzf2bgInHzCxXydQXHghG7GphlssY0V4aYLMqdPiA
         tstIjQqVGnOJ2OT6SDXnWvdZmG715KT2fN5tUVUOxVqXaSlqmK3lfoFUzll/lnnaMMBS
         K+fPXmwlJzxH57ElatLF6llJ55HbJJowhI2kQqyyF2Tbb0t+j6rghUXlDvscOrKHdCUZ
         eBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694438070; x=1695042870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTDHLs2EOQtTQ3uvgmHng/nVHNHrVDMEJR/1UpGvkHQ=;
        b=WwlehlQPUMhoZl9/HNf1afHsYXGnfaKfJTb/J55k/klZUVcvSZqURoLjDZQt43KATF
         X0d/geVNQasw6eVY/5BboR7Xteik7SDzjBbEKgJYq3mJLFZL+RSQjEmL5RkYf/GTVndg
         8JzHGRFLgObPn2yQGR3Nx1vCsQC4FNu4aSjasBIWtST8wt5tfElBPOepjkPfRVH9Zo23
         F3yQ9OnBJBAcqg3x071mpOopcwB2ptbYauOa7nQkL0oxOeS1jT8PvPRW79tYegrPNWqh
         +OqUXehG55UjGGaZ1GzxMV55s6/+kZCjNIiGiCj9tKLWDrxxBleRcBlXo71qlxwwDGSD
         HvNg==
X-Gm-Message-State: AOJu0YwntvXDKdOPJV6TMOn9+ogCS5NnRJwrxt7KGT+5P8irll6/yQ7x
        ojdlvzChN7I1RCjnqmr9ZL6hVw==
X-Google-Smtp-Source: AGHT+IGYcFnpNiP+FLLZHYSCC5nHXUyn1lvxXozVLynaGkKKRW3cVE8D6L3lkbbcr2jik100ZVPpZw==
X-Received: by 2002:a5d:6510:0:b0:317:ec04:ee0c with SMTP id x16-20020a5d6510000000b00317ec04ee0cmr8022431wru.47.1694438069661;
        Mon, 11 Sep 2023 06:14:29 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id v11-20020a1cf70b000000b00401d8810c8bsm13230128wmh.15.2023.09.11.06.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 06:14:29 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v4 2/4] riscv: Improve flush_tlb_range() for hugetlb pages
Date:   Mon, 11 Sep 2023 15:12:22 +0200
Message-Id: <20230911131224.61924-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230911131224.61924-1-alexghiti@rivosinc.com>
References: <20230911131224.61924-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

flush_tlb_range() uses a fixed stride of PAGE_SIZE and in its current form,
when a hugetlb mapping needs to be flushed, flush_tlb_range() flushes the
whole tlb: so set a stride of the size of the hugetlb mapping in order to
only flush the hugetlb mapping. However, if the hugepage is a NAPOT region,
all PTEs that constitute this mapping must be invalidated, so the stride
size must actually be the size of the PTE.

Note that THPs are directly handled by flush_pmd_tlb_range().

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/mm/tlbflush.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index fa03289853d8..5bda6d4fed90 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -3,6 +3,7 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/sched.h>
+#include <linux/hugetlb.h>
 #include <asm/sbi.h>
 #include <asm/mmu_context.h>
 
@@ -147,7 +148,43 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end)
 {
-	__flush_tlb_range(vma->vm_mm, start, end - start, PAGE_SIZE);
+	unsigned long stride_size;
+
+	stride_size = is_vm_hugetlb_page(vma) ?
+				huge_page_size(hstate_vma(vma)) :
+				PAGE_SIZE;
+
+#ifdef CONFIG_RISCV_ISA_SVNAPOT
+	/*
+	 * As stated in the privileged specification, every PTE in a NAPOT
+	 * region must be invalidated, so reset the stride in that case.
+	 */
+	if (has_svnapot()) {
+		unsigned long order, napot_size;
+
+		for_each_napot_order(order) {
+			napot_size = napot_cont_size(order);
+
+			if (stride_size != napot_size)
+				continue;
+
+			if (napot_size >= PGDIR_SIZE)
+				stride_size = PGDIR_SIZE;
+			else if (napot_size >= P4D_SIZE)
+				stride_size = P4D_SIZE;
+			else if (napot_size >= PUD_SIZE)
+				stride_size = PUD_SIZE;
+			else if (napot_size >= PMD_SIZE)
+				stride_size = PMD_SIZE;
+			else
+				stride_size = PAGE_SIZE;
+
+			break;
+		}
+	}
+#endif
+
+	__flush_tlb_range(vma->vm_mm, start, end - start, stride_size);
 }
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
-- 
2.39.2

