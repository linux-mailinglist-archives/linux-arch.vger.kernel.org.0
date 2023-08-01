Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F8F76AB7E
	for <lists+linux-arch@lfdr.de>; Tue,  1 Aug 2023 10:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjHAI52 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Aug 2023 04:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjHAI51 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Aug 2023 04:57:27 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9AD1734
        for <linux-arch@vger.kernel.org>; Tue,  1 Aug 2023 01:57:11 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b74fa5e7d7so80587451fa.2
        for <linux-arch@vger.kernel.org>; Tue, 01 Aug 2023 01:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690880229; x=1691485029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8YprRlaP4W+8yj964kuFlSBdOjyOpODn6Kzt6jcAnQ=;
        b=qdlxfR2ULJ112i9MarbF8BcXMSwKtF7ipH3Z9ZNh4A1UrVCNFEubO08E+XypP1km40
         BIOw6IYnj6AuKJ5Ew5K2k8wdyrUOkb71v8AegiQ+nuqs2nVtNOMNaQypq6vvnPowPpkZ
         7Qg3miGQ6+x4e6LXFDodFyE5gWLzjaQHx8E1Z1Yv5J1iMlnH4lG2/0XWFrSIHswKYzyt
         efFuQOiJLROe9KB2N3hD8VR/lvvtDaF5plKwpbZAgbSmjQSTOUgsKYuP07QH5gjYtlT7
         vTiVHiET4IzE53WDZJ0ZMMONmiUAraIM9BVFchpD8Pilr9UwNzxd6uikBobHNhH/wO8t
         h/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690880229; x=1691485029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8YprRlaP4W+8yj964kuFlSBdOjyOpODn6Kzt6jcAnQ=;
        b=N9/mIu6mhZG3yoj0XCGT6Y8kZlM/Nl89y2c5Cj11ZO5hkXRMdkmC/sxemW9JDRmoYq
         b/cAsZZEyNWJuNuFAUR5jG8p+dXPn/NCBMiClxbt7CoZm7O645hxUk6qI2XN6ABQEaOG
         mpED2UE5VVM/ZJ4IkPVU11ayBElF27LwcONhB0iFqrih0dZdT/Hd4SR8IqLrt63o8Jbl
         0bA51sk+JJ6vnmggr4X3ArzkFFg7IfKpEEITocJlGgCu8pdKIPxrUlZrfq9TzLbcqxV2
         iWVbx9PMfRA9UGY7MV2h4HtQ/MX+0Zy7BXkLSGLHTz4LIHAxU5zoP+7cQW2JZdC4pmcH
         /Pug==
X-Gm-Message-State: ABy/qLaCD6Oj2fXfjVOSPWpBfuOQtv4/3GQUPVpfOLxEjprQGVjuwVui
        d2gt8UEcgmtuc9sd+lfM4KsC6Q==
X-Google-Smtp-Source: APBJJlGXXGbZRFGts7ZT7QQ6Cb6DdfW/OsBud3Kp4VAMMf97raeOffyeVJ99hrx1DJ2As1NVk0KZbQ==
X-Received: by 2002:a2e:9054:0:b0:2b6:e625:ba55 with SMTP id n20-20020a2e9054000000b002b6e625ba55mr2048866ljg.41.1690880229621;
        Tue, 01 Aug 2023 01:57:09 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c1d1b00b003fe1b3e0852sm2908793wms.0.2023.08.01.01.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 01:57:09 -0700 (PDT)
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
Subject: [PATCH v3 3/4] riscv: Make __flush_tlb_range() loop over pte instead of flushing the whole tlb
Date:   Tue,  1 Aug 2023 10:54:01 +0200
Message-Id: <20230801085402.1168351-4-alexghiti@rivosinc.com>
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
---
 arch/riscv/mm/tlbflush.c | 48 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index d883df0dee4a..0c955c474f3a 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -7,6 +7,9 @@
 #include <asm/sbi.h>
 #include <asm/mmu_context.h>
 
+#define FLUSH_TLB_MAX_SIZE	((unsigned long)-1)
+#define FLUSH_TLB_NO_ASID	((unsigned long)-1)
+
 static inline void local_flush_tlb_all_asid(unsigned long asid)
 {
 	__asm__ __volatile__ ("sfence.vma x0, %0"
@@ -24,13 +27,48 @@ static inline void local_flush_tlb_page_asid(unsigned long addr,
 			: "memory");
 }
 
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
+{
+	u16 nr_ptes_in_range = DIV_ROUND_UP(size, stride);
+	int i;
+
+	if (nr_ptes_in_range > tlb_flush_all_threshold) {
+		if (asid != FLUSH_TLB_NO_ASID)
+			local_flush_tlb_all_asid(asid);
+		else
+			local_flush_tlb_all();
+		return;
+	}
+
+	for (i = 0; i < nr_ptes_in_range; ++i) {
+		if (asid != FLUSH_TLB_NO_ASID)
+			local_flush_tlb_page_asid(start, asid);
+		else
+			local_flush_tlb_page(start);
+		start += stride;
+	}
+}
+
 static inline void local_flush_tlb_range(unsigned long start,
 		unsigned long size, unsigned long stride)
 {
 	if (size <= stride)
 		local_flush_tlb_page(start);
-	else
+	else if (size == FLUSH_TLB_MAX_SIZE)
 		local_flush_tlb_all();
+	else
+		local_flush_tlb_range_threshold_asid(start, size, stride,
+						     FLUSH_TLB_NO_ASID);
+
 }
 
 static inline void local_flush_tlb_range_asid(unsigned long start,
@@ -38,8 +76,10 @@ static inline void local_flush_tlb_range_asid(unsigned long start,
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
@@ -52,7 +92,7 @@ void flush_tlb_all(void)
 	if (riscv_use_ipi_for_rfence())
 		on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
 	else
-		sbi_remote_sfence_vma(NULL, 0, -1);
+		sbi_remote_sfence_vma(NULL, 0, FLUSH_TLB_MAX_SIZE);
 }
 
 struct flush_tlb_range_data {
@@ -130,7 +170,7 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	__flush_tlb_range(mm, 0, -1, PAGE_SIZE);
+	__flush_tlb_range(mm, 0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
 }
 
 void flush_tlb_mm_range(struct mm_struct *mm,
-- 
2.39.2

