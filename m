Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FAB33E9A7
	for <lists+linux-arch@lfdr.de>; Wed, 17 Mar 2021 07:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhCQGZc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Mar 2021 02:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhCQGZT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Mar 2021 02:25:19 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DB8C06174A;
        Tue, 16 Mar 2021 23:25:19 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id s7so275967plg.5;
        Tue, 16 Mar 2021 23:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dj69ry3EYtQyAiX5oUHvY3dqq56j/eubUdI+6FA7GRk=;
        b=QXilW1y5Pw7owXm0BE0y5uqNYBU68jc9dy9LWT4Q4tnq+6acQ1CvSma676a1voPjVH
         /sChBOfCbIiES09oErIAYuIT1mjp1kTIdxSBNw+b4hbER9qN1QM3x3Dzuv4QutDlsxce
         zQmzk0jarXecDdnLDWz2Vpjng98h36IzQGxfzucAjGa5gpaRpWVQ6cKp+LBSwtVgMpN8
         O9MSzlDfpIO4cGhMJQh0KgaT4bhTIpckhgdzgEh8eLjcmuzcSke0yvSo3Mscfpmm+dJ6
         Sc34jJ+r9GUXSsCPtG6KuV7CoSuL2LOyFVnmqE4DgNTdNJ0QgVg3sv15OxNUPwyMqrRW
         rPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dj69ry3EYtQyAiX5oUHvY3dqq56j/eubUdI+6FA7GRk=;
        b=Dcatgh5NpQhoYWz7c65Qtid9d+BMRVaICmMDqJIwWAXriXoTk/oTXRPSyzSj/UfyL7
         kbG9Z/1k21o32lNkGny58RMEGPMZRWT2qq+v1tfuW15MEKO6pBvdqPeYpsGd8V9ZjUlD
         CaheYQys37q6rMqiFoE3566Af+811djLVFPGuaAn/T8RVzqxEH9wd1kwYMhEdNzWzWVP
         NC1oAF8wibXfDsvmXFrFXD7G8pun1Tn6hcqHBz2Xm011O2tXm0MgIU/uerjKUi+rBGRW
         hoyN12yvT+lCvVZitkwgijlHS2M5jGafmL7TSZ2YfLSQcqMaKPFZy8x9TJ+xV6BbdOph
         mWfQ==
X-Gm-Message-State: AOAM531sZeDURDVFwHurvaYplaB2m51yQ4N4dlKFHLcdeecqQ/z/TW/G
        UVnDFuDY2C1ub+Xiq68j4xc=
X-Google-Smtp-Source: ABdhPJzKKmiML9ahyhDjVcYprqOolbC+HJd06JEicV3PL6AmH054w47Hun27ybXyvgmde5bmGpvF4g==
X-Received: by 2002:a17:90a:1b08:: with SMTP id q8mr2789442pjq.203.1615962318728;
        Tue, 16 Mar 2021 23:25:18 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (58-6-239-121.tpgi.com.au. [58.6.239.121])
        by smtp.gmail.com with ESMTPSA id s19sm17959620pfh.168.2021.03.16.23.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 23:25:18 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v13 08/14] arm64: inline huge vmap supported functions
Date:   Wed, 17 Mar 2021 16:23:56 +1000
Message-Id: <20210317062402.533919-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210317062402.533919-1-npiggin@gmail.com>
References: <20210317062402.533919-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This allows unsupported levels to be constant folded away, and so
p4d_free_pud_page can be removed because it's no longer linked to.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/arm64/include/asm/vmalloc.h | 23 ++++++++++++++++++++---
 arch/arm64/mm/mmu.c              | 26 --------------------------
 2 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
index 597b40405319..fc9a12d6cc1a 100644
--- a/arch/arm64/include/asm/vmalloc.h
+++ b/arch/arm64/include/asm/vmalloc.h
@@ -4,9 +4,26 @@
 #include <asm/page.h>
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
-bool arch_vmap_p4d_supported(pgprot_t prot);
-bool arch_vmap_pud_supported(pgprot_t prot);
-bool arch_vmap_pmd_supported(pgprot_t prot);
+static inline bool arch_vmap_p4d_supported(pgprot_t prot)
+{
+	return false;
+}
+
+static inline bool arch_vmap_pud_supported(pgprot_t prot)
+{
+	/*
+	 * Only 4k granule supports level 1 block mappings.
+	 * SW table walks can't handle removal of intermediate entries.
+	 */
+	return IS_ENABLED(CONFIG_ARM64_4K_PAGES) &&
+	       !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
+}
+
+static inline bool arch_vmap_pmd_supported(pgprot_t prot)
+{
+	/* See arch_vmap_pud_supported() */
+	return !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
+}
 #endif
 
 #endif /* _ASM_ARM64_VMALLOC_H */
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 639b9de61b1d..1fb0035b0777 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1316,27 +1316,6 @@ void *__init fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
 	return dt_virt;
 }
 
-bool arch_vmap_p4d_supported(pgprot_t prot)
-{
-	return false;
-}
-
-bool arch_vmap_pud_supported(pgprot_t prot)
-{
-	/*
-	 * Only 4k granule supports level 1 block mappings.
-	 * SW table walks can't handle removal of intermediate entries.
-	 */
-	return IS_ENABLED(CONFIG_ARM64_4K_PAGES) &&
-	       !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
-}
-
-bool arch_vmap_pmd_supported(pgprot_t prot)
-{
-	/* See arch_vmap_pud_supported() */
-	return !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
-}
-
 int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 {
 	pud_t new_pud = pfn_pud(__phys_to_pfn(phys), mk_pud_sect_prot(prot));
@@ -1428,11 +1407,6 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
 	return 1;
 }
 
-int p4d_free_pud_page(p4d_t *p4d, unsigned long addr)
-{
-	return 0;	/* Don't attempt a block mapping */
-}
-
 #ifdef CONFIG_MEMORY_HOTPLUG
 static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
 {
-- 
2.23.0

