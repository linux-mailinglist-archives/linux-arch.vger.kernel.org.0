Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49158304DFD
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jan 2021 01:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730964AbhAZXaV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jan 2021 18:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbhAZErB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jan 2021 23:47:01 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2125C061788;
        Mon, 25 Jan 2021 20:46:04 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id a20so1322091pjs.1;
        Mon, 25 Jan 2021 20:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0fqvAYwIAe6qA/JSpZVbQ06eMe+7hHIC7Sc9a7+Vq/o=;
        b=D/0cuUms54veLQjAd1d9Hms4mts+lxzMvE2kXzGZEeIC6xz6SppZbx/rBu2+p845yY
         9FLqDySl+pjX5oKzGKJGDjrv2uBx5KdPcaCn3CpHJggkGOa1ygNRlvzlxYp1NDqqcF3t
         8Vg500s8AYGewz4J7z34Kzbhun7Lxk7a9vqpI2XgSk5GEvU28RY/Cu0DHq5XCiLFFE75
         p1bAbTuHmjgTISiDFgzdZgFFnVG1s2NGcLkwYLfX6YP+P5akxvuOPNN/3MQrg3F57nwh
         hmvDscoK7jL/bcNdCsQ7eHn+oS41TnZbK2PkYDUsx9C3xXtnIrrmZSNAwrzEt4gEJ4Gg
         0OcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0fqvAYwIAe6qA/JSpZVbQ06eMe+7hHIC7Sc9a7+Vq/o=;
        b=s2ekZgpUbA5HMqMj0QYmQnFY/9yFI3ZSwKpOpS5O5lKiHciTARTl4kWZOPol2M/KNH
         uO9IPioorw/Wgc0yl+e7kvMdahMleUEcT3DQlOb0kuZM2Dz59z4fseWBUZugot4ltDm5
         LZnsJCVyDtAh/Cjb309EyeoPOY3aqHrLHX7PPhcUEHAi+V/RJSXmnOSUbhU6dj2zqsXD
         voqCLmjt3CbJC1dgru2GXFN7/Y9Gme1DPvGAarnQvrorDEhdt/Tq9N6VFvqjp/PtnBrs
         dCfMnZsuvwhArENaDgMVNkenmPDpMp8Wq4aspW5O4p6yDNLNuAe+a10SdFUqManWssuR
         j9ig==
X-Gm-Message-State: AOAM531acOLa3aMduJKwU6S0gPyU4iu3XftLM6Y6Wlz5WiqzJK+maf7B
        2TCyqTvZFnV1YImBOaiUaTY=
X-Google-Smtp-Source: ABdhPJwg8Xi8G/OTFk2zVMLMCDy4bSObItXkLBAX9N36BVkCzQob7CnN0W1NVUckPWV6/HJRJrxV5A==
X-Received: by 2002:a17:902:26a:b029:da:af47:77c7 with SMTP id 97-20020a170902026ab02900daaf4777c7mr4079082plc.10.1611636363126;
        Mon, 25 Jan 2021 20:46:03 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (192.156.221.203.dial.dynamic.acc50-nort-cbr.comindico.com.au. [203.221.156.192])
        by smtp.gmail.com with ESMTPSA id 68sm19272293pfg.90.2021.01.25.20.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 20:46:02 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v11 07/13] arm64: inline huge vmap supported functions
Date:   Tue, 26 Jan 2021 14:45:04 +1000
Message-Id: <20210126044510.2491820-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210126044510.2491820-1-npiggin@gmail.com>
References: <20210126044510.2491820-1-npiggin@gmail.com>
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
index 1613d290cbd1..ab9ba7c36dae 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1313,27 +1313,6 @@ void *__init fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
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
@@ -1425,11 +1404,6 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
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

