Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4982CFA21
	for <lists+linux-arch@lfdr.de>; Sat,  5 Dec 2020 08:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgLEG7I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Dec 2020 01:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbgLEG7H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Dec 2020 01:59:07 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2CDC0613D1;
        Fri,  4 Dec 2020 22:58:20 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id b5so597036pjl.0;
        Fri, 04 Dec 2020 22:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2t14GdngmnBtNB8+/S//c7VFoU994BC7ZHYuUgeTwNA=;
        b=B70xeuCROEkE5Bz+UvG5+1R2Qm6aDLtzEm3lfkQy0Ufelnzzqf/8ZM5wJ6xnDM0WJo
         9UnCgwfAAHI48ejrT5soi8lIxQWo7VXP/Anbt3Uw23eUNjYvmHWe1QIKB/qjkG+V/RWS
         c78bN3WNmdPnWnjYBGmV28AkFodlhbx6DCmHNnVWFUH78RC3GaFpsi+YSah9h9E/HK61
         8DrI//repVXciq7MZNVD5QjtIbqaaJZ+gQhmradSme8NLwF/oS5Gw1E6SEduhxyVsZDc
         p6AyOMK9sQpFp3XbNZ/a9PRyjwmwAB3WkkB/tQqjb/35Uj8KovA0XcKeDdMVSokHb/L0
         aBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2t14GdngmnBtNB8+/S//c7VFoU994BC7ZHYuUgeTwNA=;
        b=VeU2HDocjgIj1OPtlXZar9Sf8JvwxWFq4fLGV8WZx8023tBeHthMqDsyuhe6qKTWmZ
         MHw6FLaC9p2V9xKl5rZZA+GEjswFkx3NAXhTXkoG+/NMoE+BaXD/mZJCVGpSbhFnkBaZ
         VrVVV352RRv+UaF0Y7wJoBVAjo/DUhGF5fBgE/+kwgp7l98Cg4TQwxTxYtSnbKfOZP1u
         UC/evZRig+7vpc3e976EybODote+Hvw68Tp88n1KXgYsqRCGHs9IuqzHqB1ob3cmaUPn
         y6jV7ciPw3o/O8Bsai0BDdtyQ2maxe1KOCh32vA3jN6oryzVJPlL1RHwVz0Ng2rEjyiW
         48rQ==
X-Gm-Message-State: AOAM532DSPeOu8CdUY7Or7pnwvmr333WkN7k0cH14FZVe0cC0wJkuGS/
        PNmZg/xiWK9eN1AI0WzKbg4=
X-Google-Smtp-Source: ABdhPJwjoSqyZStQFiANkD2aPMGXhbg/gkVP0cgFx8+7JFPhX8iwAUC3btu67DZQhOlu1F5LtmkdnA==
X-Received: by 2002:a17:90b:68b:: with SMTP id m11mr111694pjz.208.1607151499847;
        Fri, 04 Dec 2020 22:58:19 -0800 (PST)
Received: from bobo.ozlabs.ibm.com ([1.129.145.238])
        by smtp.gmail.com with ESMTPSA id a14sm1110848pfl.141.2020.12.04.22.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 22:58:19 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 07/12] arm64: inline huge vmap supported functions
Date:   Sat,  5 Dec 2020 16:57:20 +1000
Message-Id: <20201205065725.1286370-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201205065725.1286370-1-npiggin@gmail.com>
References: <20201205065725.1286370-1-npiggin@gmail.com>
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
index 1b60079c1cef..0af5b5cfb9c6 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1315,27 +1315,6 @@ void *__init fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
 	return dt_virt;
 }
 
-bool arch_vmap_p4d_supported(pgprot_t prot)
-{
-	return false;
-}
-
-bool arch_vmap_pud_supported(pgprot_t prot);
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
@@ -1427,11 +1406,6 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
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

