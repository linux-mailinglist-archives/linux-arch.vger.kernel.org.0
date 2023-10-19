Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A197CFBFA
	for <lists+linux-arch@lfdr.de>; Thu, 19 Oct 2023 16:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345912AbjJSOFU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Oct 2023 10:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345991AbjJSOFS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Oct 2023 10:05:18 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32A2138
        for <linux-arch@vger.kernel.org>; Thu, 19 Oct 2023 07:05:14 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3296b3f03e5so6453714f8f.2
        for <linux-arch@vger.kernel.org>; Thu, 19 Oct 2023 07:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697724313; x=1698329113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcqaVPeAGwTbj9zEMGR6ijY363bXbBd6qhh4XcO8DLA=;
        b=1ePv1mzK1T5rXtjQJ5VH5NyKScSakG8pRiRnRyNtDtANvSr4Uk9Qae8oC6P3xDbQbT
         0n8NxdXm5+inefMaNYlZWsW4XpcKKQAKhgRECqF5srFqAB+DkU6krL+GPPJQ0nkT7Jlf
         5t+wHKBMJQwuLcmID0eIYSsrTzISALaa6e636U7gvxpdf2OV8UcZHTpNLy3FgGKPjPu2
         DbtXhpDxKA8V5nuRCW+wEjR9AUXQ3SKDid7eitoP41ghxFi5mvgbjmSCj0qBszK10RYV
         Vwc5pXvL8XE8A2o2rmHkbxzdvv35sIM+XKcehumCjYnBRviFNWiF7pf6Qwh3GdU2uMI4
         XFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697724313; x=1698329113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcqaVPeAGwTbj9zEMGR6ijY363bXbBd6qhh4XcO8DLA=;
        b=a39fzyfPi+7uT4Re2zVsvgOhsKAUTL+y7ybXdLcoUtm+Cw/Srn2BCC96DkqEJquMLS
         WS3lIS4/++8grB5fAkbw61pp9cy+YzXzD5J2dGbSyWenTGPtD135C7Gk2dZ4lga+6Oty
         C3qp4YBcTSoEpqBQnWnl9IQil/zaMxfCfCX5KHffzKKXjoYDq+awEX5Nhq4s88vjzSVR
         J+74UrtibYrAifdOlDktKRMqGpecvUGG1TtGULXJhih3dXdTouMsoec86lI6AC7I34mT
         wgbr8Jj2OEAC2recga8267nc248dCega21A0MlnRcmyrv1DU0yCZtWbJHCAzMwTt1pEd
         XHGA==
X-Gm-Message-State: AOJu0YwxeOimWVV7mWaKDS2JQKk5aTMgdeTsjq1D3iv9wxrcxvCpbfhx
        FIeSxEX7nnl4ZjzLQZUpLC316w==
X-Google-Smtp-Source: AGHT+IHnKiCvjHaBH1kde0mGFwQY25hXd0xzfatBl3O3oogknqg699PegckRO25Yp/WvPwgt7YDLxw==
X-Received: by 2002:a5d:5908:0:b0:32d:bafd:809f with SMTP id v8-20020a5d5908000000b0032dbafd809fmr1389930wrd.70.1697724313195;
        Thu, 19 Oct 2023 07:05:13 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id q9-20020a05600000c900b0032d8eecf901sm4571012wrx.3.2023.10.19.07.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 07:05:12 -0700 (PDT)
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
        Andrew Jones <ajones@ventanamicro.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 3/4] riscv: Make __flush_tlb_range() loop over pte instead of flushing the whole tlb
Date:   Thu, 19 Oct 2023 16:01:50 +0200
Message-Id: <20231019140151.21629-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019140151.21629-1-alexghiti@rivosinc.com>
References: <20231019140151.21629-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently, when the range to flush covers more than one page (a 4K page or
a hugepage), __flush_tlb_range() flushes the whole tlb. Flushing the whole
tlb comes with a greater cost than flushing a single entry so we should
flush single entries up to a certain threshold so that:
threshold * cost of flushing a single entry < cost of flushing the whole
tlb.

Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # On RZ/Five SMARC
---
 arch/riscv/include/asm/sbi.h      |   3 -
 arch/riscv/include/asm/tlbflush.h |   3 +
 arch/riscv/kernel/sbi.c           |  32 +++------
 arch/riscv/mm/tlbflush.c          | 115 +++++++++++++++---------------
 4 files changed, 72 insertions(+), 81 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 12dfda6bb924..0892f4421bc4 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -280,9 +280,6 @@ void sbi_set_timer(uint64_t stime_value);
 void sbi_shutdown(void);
 void sbi_send_ipi(unsigned int cpu);
 int sbi_remote_fence_i(const struct cpumask *cpu_mask);
-int sbi_remote_sfence_vma(const struct cpumask *cpu_mask,
-			   unsigned long start,
-			   unsigned long size);
 
 int sbi_remote_sfence_vma_asid(const struct cpumask *cpu_mask,
 				unsigned long start,
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index f5c4fb0ae642..170a49c531c6 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -11,6 +11,9 @@
 #include <asm/smp.h>
 #include <asm/errata_list.h>
 
+#define FLUSH_TLB_MAX_SIZE      ((unsigned long)-1)
+#define FLUSH_TLB_NO_ASID       ((unsigned long)-1)
+
 #ifdef CONFIG_MMU
 extern unsigned long asid_mask;
 
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index c672c8ba9a2a..5a62ed1da453 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -11,6 +11,7 @@
 #include <linux/reboot.h>
 #include <asm/sbi.h>
 #include <asm/smp.h>
+#include <asm/tlbflush.h>
 
 /* default SBI version is 0.1 */
 unsigned long sbi_spec_version __ro_after_init = SBI_SPEC_VERSION_DEFAULT;
@@ -376,32 +377,15 @@ int sbi_remote_fence_i(const struct cpumask *cpu_mask)
 }
 EXPORT_SYMBOL(sbi_remote_fence_i);
 
-/**
- * sbi_remote_sfence_vma() - Execute SFENCE.VMA instructions on given remote
- *			     harts for the specified virtual address range.
- * @cpu_mask: A cpu mask containing all the target harts.
- * @start: Start of the virtual address
- * @size: Total size of the virtual address range.
- *
- * Return: 0 on success, appropriate linux error code otherwise.
- */
-int sbi_remote_sfence_vma(const struct cpumask *cpu_mask,
-			   unsigned long start,
-			   unsigned long size)
-{
-	return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
-			    cpu_mask, start, size, 0, 0);
-}
-EXPORT_SYMBOL(sbi_remote_sfence_vma);
-
 /**
  * sbi_remote_sfence_vma_asid() - Execute SFENCE.VMA instructions on given
- * remote harts for a virtual address range belonging to a specific ASID.
+ * remote harts for a virtual address range belonging to a specific ASID or not.
  *
  * @cpu_mask: A cpu mask containing all the target harts.
  * @start: Start of the virtual address
  * @size: Total size of the virtual address range.
- * @asid: The value of address space identifier (ASID).
+ * @asid: The value of address space identifier (ASID), or FLUSH_TLB_NO_ASID
+ * for flushing all address spaces.
  *
  * Return: 0 on success, appropriate linux error code otherwise.
  */
@@ -410,8 +394,12 @@ int sbi_remote_sfence_vma_asid(const struct cpumask *cpu_mask,
 				unsigned long size,
 				unsigned long asid)
 {
-	return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
-			    cpu_mask, start, size, asid, 0);
+	if (asid == FLUSH_TLB_NO_ASID)
+		return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
+				    cpu_mask, start, size, 0, 0);
+	else
+		return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
+				    cpu_mask, start, size, asid, 0);
 }
 EXPORT_SYMBOL(sbi_remote_sfence_vma_asid);
 
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 5933744df91a..c27ba720e35f 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -9,28 +9,50 @@
 
 static inline void local_flush_tlb_all_asid(unsigned long asid)
 {
-	__asm__ __volatile__ ("sfence.vma x0, %0"
-			:
-			: "r" (asid)
-			: "memory");
+	if (asid != FLUSH_TLB_NO_ASID)
+		__asm__ __volatile__ ("sfence.vma x0, %0"
+				:
+				: "r" (asid)
+				: "memory");
+	else
+		local_flush_tlb_all();
 }
 
 static inline void local_flush_tlb_page_asid(unsigned long addr,
 		unsigned long asid)
 {
-	__asm__ __volatile__ ("sfence.vma %0, %1"
-			:
-			: "r" (addr), "r" (asid)
-			: "memory");
+	if (asid != FLUSH_TLB_NO_ASID)
+		__asm__ __volatile__ ("sfence.vma %0, %1"
+				:
+				: "r" (addr), "r" (asid)
+				: "memory");
+	else
+		local_flush_tlb_page(addr);
 }
 
-static inline void local_flush_tlb_range(unsigned long start,
-		unsigned long size, unsigned long stride)
+/*
+ * Flush entire TLB if number of entries to be flushed is greater
+ * than the threshold below.
+ */
+static unsigned long tlb_flush_all_threshold __read_mostly = 64;
+
+static void local_flush_tlb_range_threshold_asid(unsigned long start,
+						 unsigned long size,
+						 unsigned long stride,
+						 unsigned long asid)
 {
-	if (size <= stride)
-		local_flush_tlb_page(start);
-	else
-		local_flush_tlb_all();
+	u16 nr_ptes_in_range = DIV_ROUND_UP(size, stride);
+	int i;
+
+	if (nr_ptes_in_range > tlb_flush_all_threshold) {
+		local_flush_tlb_all_asid(asid);
+		return;
+	}
+
+	for (i = 0; i < nr_ptes_in_range; ++i) {
+		local_flush_tlb_page_asid(start, asid);
+		start += stride;
+	}
 }
 
 static inline void local_flush_tlb_range_asid(unsigned long start,
@@ -38,8 +60,10 @@ static inline void local_flush_tlb_range_asid(unsigned long start,
 {
 	if (size <= stride)
 		local_flush_tlb_page_asid(start, asid);
-	else
+	else if (size == FLUSH_TLB_MAX_SIZE)
 		local_flush_tlb_all_asid(asid);
+	else
+		local_flush_tlb_range_threshold_asid(start, size, stride, asid);
 }
 
 static void __ipi_flush_tlb_all(void *info)
@@ -52,7 +76,7 @@ void flush_tlb_all(void)
 	if (riscv_use_ipi_for_rfence())
 		on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
 	else
-		sbi_remote_sfence_vma(NULL, 0, -1);
+		sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, FLUSH_TLB_NO_ASID);
 }
 
 struct flush_tlb_range_data {
@@ -69,18 +93,12 @@ static void __ipi_flush_tlb_range_asid(void *info)
 	local_flush_tlb_range_asid(d->start, d->size, d->stride, d->asid);
 }
 
-static void __ipi_flush_tlb_range(void *info)
-{
-	struct flush_tlb_range_data *d = info;
-
-	local_flush_tlb_range(d->start, d->size, d->stride);
-}
-
 static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 			      unsigned long size, unsigned long stride)
 {
 	struct flush_tlb_range_data ftd;
 	struct cpumask *cmask = mm_cpumask(mm);
+	unsigned long asid = FLUSH_TLB_NO_ASID;
 	unsigned int cpuid;
 	bool broadcast;
 
@@ -90,39 +108,24 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 	cpuid = get_cpu();
 	/* check if the tlbflush needs to be sent to other CPUs */
 	broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
-	if (static_branch_unlikely(&use_asid_allocator)) {
-		unsigned long asid = atomic_long_read(&mm->context.id) & asid_mask;
-
-		if (broadcast) {
-			if (riscv_use_ipi_for_rfence()) {
-				ftd.asid = asid;
-				ftd.start = start;
-				ftd.size = size;
-				ftd.stride = stride;
-				on_each_cpu_mask(cmask,
-						 __ipi_flush_tlb_range_asid,
-						 &ftd, 1);
-			} else
-				sbi_remote_sfence_vma_asid(cmask,
-							   start, size, asid);
-		} else {
-			local_flush_tlb_range_asid(start, size, stride, asid);
-		}
+
+	if (static_branch_unlikely(&use_asid_allocator))
+		asid = atomic_long_read(&mm->context.id) & asid_mask;
+
+	if (broadcast) {
+		if (riscv_use_ipi_for_rfence()) {
+			ftd.asid = asid;
+			ftd.start = start;
+			ftd.size = size;
+			ftd.stride = stride;
+			on_each_cpu_mask(cmask,
+					 __ipi_flush_tlb_range_asid,
+					 &ftd, 1);
+		} else
+			sbi_remote_sfence_vma_asid(cmask,
+						   start, size, asid);
 	} else {
-		if (broadcast) {
-			if (riscv_use_ipi_for_rfence()) {
-				ftd.asid = 0;
-				ftd.start = start;
-				ftd.size = size;
-				ftd.stride = stride;
-				on_each_cpu_mask(cmask,
-						 __ipi_flush_tlb_range,
-						 &ftd, 1);
-			} else
-				sbi_remote_sfence_vma(cmask, start, size);
-		} else {
-			local_flush_tlb_range(start, size, stride);
-		}
+		local_flush_tlb_range_asid(start, size, stride, asid);
 	}
 
 	put_cpu();
@@ -130,7 +133,7 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	__flush_tlb_range(mm, 0, -1, PAGE_SIZE);
+	__flush_tlb_range(mm, 0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
 }
 
 void flush_tlb_mm_range(struct mm_struct *mm,
-- 
2.39.2

