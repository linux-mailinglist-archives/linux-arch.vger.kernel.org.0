Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396A124CCEB
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 06:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgHUEpC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 00:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgHUEo6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 00:44:58 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCC6C061385;
        Thu, 20 Aug 2020 21:44:58 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q93so412807pjq.0;
        Thu, 20 Aug 2020 21:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PxO9Fmz2XY4J5PcT3r/B/Ox9Dltz1o7JoYfRKqhdMIY=;
        b=A7BZjrOMLSmZeKG4GJvm0Cu6bu5oAddISr3WPxe68eP2pRXf6EMzyiFrTzC+VHKcm4
         5579w6ZeAUUI4nVVOKjfzH365VJ8q7d1N7A039vKmAcX/VCVujRm/00k6fa6ID6KbZIO
         6Wgmxi84WEo+bbjd7Pisj+obRLcJi9WqTp7pZBV7kXWA6E+CKE/9ySioipU/3AaFzGvk
         dVDEMFQxUIe61JPBaJbu+id3GD7Zpe4JEe7bYnvPIJKLyjpso/yZQI4OptYz7e/oPpBU
         9zvXkb+xIszsp8fAxyzM/DbvHMWW8YdFqwD0rjtxelQN/Ygmi7XRueuHinLqkdwDHeEm
         NIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PxO9Fmz2XY4J5PcT3r/B/Ox9Dltz1o7JoYfRKqhdMIY=;
        b=mG8Ri5aZGvwlqyqLpyxCekprzg73Zm0euEqiwfjN8lyRcsdqyQNig4hEMgfHWcdTco
         jGkU1DGSQENhOPmSoSv9xkEKsHz2c2LzZEcYL3r5XlyVY93p/V3DFwqa2JTKcly9IAEH
         PuXXcnq79pbq9RS4wwITfK9Jg18iU6RDlVhbX5tZCVqnBf+3uA99dCVcjIXvnaGCkXHa
         lRkf49U4E86Ko8b24gVAHHtJhVnZyz1Mit84SSDOxmH2MWkLOpuiA268H9V8AMM5lZiU
         QafPWNi/tmizBImJTxn+3f/9Wu9+IskHEhyVgm3CgeIHkLKOGmNUV531uBPrtZvElUX9
         UoxA==
X-Gm-Message-State: AOAM533GzYk8uOifaXcdHGrFxnkVPhyiY6FOTUkEiVA1F61xVmeFu4Km
        h5+0do4JeL1cG56UYBq/PPw=
X-Google-Smtp-Source: ABdhPJw5xHkx99C353vQuXHQuBqQSsj3L+sMgxre4XYcVI6dzid5vkYDy4vRdO6OxRsZAj8qDuxH0w==
X-Received: by 2002:a17:902:6ac3:: with SMTP id i3mr961255plt.21.1597985097741;
        Thu, 20 Aug 2020 21:44:57 -0700 (PDT)
Received: from bobo.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id l9sm683374pgg.29.2020.08.20.21.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 21:44:57 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v5 5/8] mm: HUGE_VMAP arch support cleanup
Date:   Fri, 21 Aug 2020 14:44:24 +1000
Message-Id: <20200821044427.736424-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200821044427.736424-1-npiggin@gmail.com>
References: <20200821044427.736424-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This changes the awkward approach where architectures provide init
functions to determine which levels they can provide large mappings for,
to one where the arch is queried for each call.

This removes code and indirection, and allows constant-folding of dead
code for unsupported levels.

This also adds a prot argument to the arch query. This is unused
currently but could help with some architectures (e.g., some powerpc
processors can't map uncacheable memory with large pages).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/arm64/mm/mmu.c                      | 12 +--
 arch/powerpc/mm/book3s64/radix_pgtable.c | 10 ++-
 arch/x86/mm/ioremap.c                    | 12 +--
 include/linux/io.h                       |  9 ---
 include/linux/vmalloc.h                  | 10 +++
 init/main.c                              |  1 -
 mm/ioremap.c                             | 96 +++++++++++-------------
 7 files changed, 73 insertions(+), 77 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 75df62fea1b6..bbb3ccf6a7ce 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1304,12 +1304,13 @@ void *__init fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
 	return dt_virt;
 }
 
-int __init arch_ioremap_p4d_supported(void)
+#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
+bool arch_vmap_p4d_supported(pgprot_t prot)
 {
-	return 0;
+	return false;
 }
 
-int __init arch_ioremap_pud_supported(void)
+bool arch_vmap_pud_supported(pgprot_t prot)
 {
 	/*
 	 * Only 4k granule supports level 1 block mappings.
@@ -1319,11 +1320,12 @@ int __init arch_ioremap_pud_supported(void)
 	       !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
 }
 
-int __init arch_ioremap_pmd_supported(void)
+bool arch_vmap_pmd_supported(pgprot_t prot)
 {
-	/* See arch_ioremap_pud_supported() */
+	/* See arch_vmap_pud_supported() */
 	return !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
 }
+#endif
 
 int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 {
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index ae823bba29f2..7d3a620c5adf 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1182,13 +1182,14 @@ void radix__ptep_modify_prot_commit(struct vm_area_struct *vma,
 	set_pte_at(mm, addr, ptep, pte);
 }
 
-int __init arch_ioremap_pud_supported(void)
+#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
+bool arch_vmap_pud_supported(pgprot_t prot)
 {
 	/* HPT does not cope with large pages in the vmalloc area */
 	return radix_enabled();
 }
 
-int __init arch_ioremap_pmd_supported(void)
+bool arch_vmap_pmd_supported(pgprot_t prot)
 {
 	return radix_enabled();
 }
@@ -1197,6 +1198,7 @@ int p4d_free_pud_page(p4d_t *p4d, unsigned long addr)
 {
 	return 0;
 }
+#endif
 
 int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
 {
@@ -1282,7 +1284,7 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 	return 1;
 }
 
-int __init arch_ioremap_p4d_supported(void)
+bool arch_vmap_p4d_supported(pgprot_t prot)
 {
-	return 0;
+	return false;
 }
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 84d85dbd1dad..5b8b495ab4ed 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -481,24 +481,26 @@ void iounmap(volatile void __iomem *addr)
 }
 EXPORT_SYMBOL(iounmap);
 
-int __init arch_ioremap_p4d_supported(void)
+#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
+bool arch_vmap_p4d_supported(pgprot_t prot)
 {
-	return 0;
+	return false;
 }
 
-int __init arch_ioremap_pud_supported(void)
+bool arch_vmap_pud_supported(pgprot_t prot)
 {
 #ifdef CONFIG_X86_64
 	return boot_cpu_has(X86_FEATURE_GBPAGES);
 #else
-	return 0;
+	return false;
 #endif
 }
 
-int __init arch_ioremap_pmd_supported(void)
+bool arch_vmap_pmd_supported(pgprot_t prot)
 {
 	return boot_cpu_has(X86_FEATURE_PSE);
 }
+#endif
 
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
diff --git a/include/linux/io.h b/include/linux/io.h
index 8394c56babc2..f1effd4d7a3c 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -31,15 +31,6 @@ static inline int ioremap_page_range(unsigned long addr, unsigned long end,
 }
 #endif
 
-#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
-void __init ioremap_huge_init(void);
-int arch_ioremap_p4d_supported(void);
-int arch_ioremap_pud_supported(void);
-int arch_ioremap_pmd_supported(void);
-#else
-static inline void ioremap_huge_init(void) { }
-#endif
-
 /*
  * Managed iomap interface
  */
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 0221f852a7e1..787d77ad7536 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -84,6 +84,16 @@ struct vmap_area {
 	};
 };
 
+#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
+bool arch_vmap_p4d_supported(pgprot_t prot);
+bool arch_vmap_pud_supported(pgprot_t prot);
+bool arch_vmap_pmd_supported(pgprot_t prot);
+#else
+static inline bool arch_vmap_p4d_supported(pgprot_t prot) { return false; }
+static inline bool arch_vmap_pud_supported(pgprot_t prot) { return false; }
+static inline bool arch_vmap_pmd_supported(pgprot_t prot) { return false; }
+#endif
+
 /*
  *	Highlevel APIs for driver use
  */
diff --git a/init/main.c b/init/main.c
index ae78fb68d231..1c89aa127b8f 100644
--- a/init/main.c
+++ b/init/main.c
@@ -820,7 +820,6 @@ static void __init mm_init(void)
 	pgtable_init();
 	debug_objects_mem_init();
 	vmalloc_init();
-	ioremap_huge_init();
 	/* Should be run before the first non-init thread is created */
 	init_espfix_bsp();
 	/* Should be run after espfix64 is set up. */
diff --git a/mm/ioremap.c b/mm/ioremap.c
index 6016ae3227ad..b0032dbadaf7 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -16,49 +16,16 @@
 #include "pgalloc-track.h"
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
-static int __read_mostly ioremap_p4d_capable;
-static int __read_mostly ioremap_pud_capable;
-static int __read_mostly ioremap_pmd_capable;
-static int __read_mostly ioremap_huge_disabled;
+static bool __ro_after_init iomap_allow_huge = true;
 
 static int __init set_nohugeiomap(char *str)
 {
-	ioremap_huge_disabled = 1;
+	iomap_allow_huge = false;
 	return 0;
 }
 early_param("nohugeiomap", set_nohugeiomap);
-
-void __init ioremap_huge_init(void)
-{
-	if (!ioremap_huge_disabled) {
-		if (arch_ioremap_p4d_supported())
-			ioremap_p4d_capable = 1;
-		if (arch_ioremap_pud_supported())
-			ioremap_pud_capable = 1;
-		if (arch_ioremap_pmd_supported())
-			ioremap_pmd_capable = 1;
-	}
-}
-
-static inline int ioremap_p4d_enabled(void)
-{
-	return ioremap_p4d_capable;
-}
-
-static inline int ioremap_pud_enabled(void)
-{
-	return ioremap_pud_capable;
-}
-
-static inline int ioremap_pmd_enabled(void)
-{
-	return ioremap_pmd_capable;
-}
-
-#else	/* !CONFIG_HAVE_ARCH_HUGE_VMAP */
-static inline int ioremap_p4d_enabled(void) { return 0; }
-static inline int ioremap_pud_enabled(void) { return 0; }
-static inline int ioremap_pmd_enabled(void) { return 0; }
+#else /* CONFIG_HAVE_ARCH_HUGE_VMAP */
+static const bool iomap_allow_huge = false;
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
 
 static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
@@ -81,9 +48,12 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 }
 
 static int vmap_try_huge_pmd(pmd_t *pmd, unsigned long addr, unsigned long end,
-			phys_addr_t phys_addr, pgprot_t prot)
+			phys_addr_t phys_addr, pgprot_t prot, unsigned int max_page_shift)
 {
-	if (!ioremap_pmd_enabled())
+	if (max_page_shift < PMD_SHIFT)
+		return 0;
+
+	if (!arch_vmap_pmd_supported(prot))
 		return 0;
 
 	if ((end - addr) != PMD_SIZE)
@@ -102,7 +72,8 @@ static int vmap_try_huge_pmd(pmd_t *pmd, unsigned long addr, unsigned long end,
 }
 
 static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
-			phys_addr_t phys_addr, pgprot_t prot, pgtbl_mod_mask *mask)
+			phys_addr_t phys_addr, pgprot_t prot, unsigned int max_page_shift,
+			pgtbl_mod_mask *mask)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -113,7 +84,7 @@ static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 	do {
 		next = pmd_addr_end(addr, end);
 
-		if (vmap_try_huge_pmd(pmd, addr, next, phys_addr, prot)) {
+		if (vmap_try_huge_pmd(pmd, addr, next, phys_addr, prot, max_page_shift)) {
 			*mask |= PGTBL_PMD_MODIFIED;
 			continue;
 		}
@@ -125,9 +96,12 @@ static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 }
 
 static int vmap_try_huge_pud(pud_t *pud, unsigned long addr, unsigned long end,
-			phys_addr_t phys_addr, pgprot_t prot)
+			phys_addr_t phys_addr, pgprot_t prot, unsigned int max_page_shift)
 {
-	if (!ioremap_pud_enabled())
+	if (max_page_shift < PUD_SHIFT)
+		return 0;
+
+	if (!arch_vmap_pud_supported(prot))
 		return 0;
 
 	if ((end - addr) != PUD_SIZE)
@@ -146,7 +120,8 @@ static int vmap_try_huge_pud(pud_t *pud, unsigned long addr, unsigned long end,
 }
 
 static int vmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
-			phys_addr_t phys_addr, pgprot_t prot, pgtbl_mod_mask *mask)
+			phys_addr_t phys_addr, pgprot_t prot, unsigned int max_page_shift,
+			pgtbl_mod_mask *mask)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -157,21 +132,24 @@ static int vmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 	do {
 		next = pud_addr_end(addr, end);
 
-		if (vmap_try_huge_pud(pud, addr, next, phys_addr, prot)) {
+		if (vmap_try_huge_pud(pud, addr, next, phys_addr, prot, max_page_shift)) {
 			*mask |= PGTBL_PUD_MODIFIED;
 			continue;
 		}
 
-		if (vmap_pmd_range(pud, addr, next, phys_addr, prot, mask))
+		if (vmap_pmd_range(pud, addr, next, phys_addr, prot, max_page_shift, mask))
 			return -ENOMEM;
 	} while (pud++, phys_addr += (next - addr), addr = next, addr != end);
 	return 0;
 }
 
 static int vmap_try_huge_p4d(p4d_t *p4d, unsigned long addr, unsigned long end,
-			phys_addr_t phys_addr, pgprot_t prot)
+			phys_addr_t phys_addr, pgprot_t prot, unsigned int max_page_shift)
 {
-	if (!ioremap_p4d_enabled())
+	if (max_page_shift < P4D_SHIFT)
+		return 0;
+
+	if (!arch_vmap_p4d_supported(prot))
 		return 0;
 
 	if ((end - addr) != P4D_SIZE)
@@ -190,7 +168,8 @@ static int vmap_try_huge_p4d(p4d_t *p4d, unsigned long addr, unsigned long end,
 }
 
 static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
-			phys_addr_t phys_addr, pgprot_t prot, pgtbl_mod_mask *mask)
+			phys_addr_t phys_addr, pgprot_t prot, unsigned int max_page_shift,
+			pgtbl_mod_mask *mask)
 {
 	p4d_t *p4d;
 	unsigned long next;
@@ -201,18 +180,19 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 	do {
 		next = p4d_addr_end(addr, end);
 
-		if (vmap_try_huge_p4d(p4d, addr, next, phys_addr, prot)) {
+		if (vmap_try_huge_p4d(p4d, addr, next, phys_addr, prot, max_page_shift)) {
 			*mask |= PGTBL_P4D_MODIFIED;
 			continue;
 		}
 
-		if (vmap_pud_range(p4d, addr, next, phys_addr, prot, mask))
+		if (vmap_pud_range(p4d, addr, next, phys_addr, prot, max_page_shift, mask))
 			return -ENOMEM;
 	} while (p4d++, phys_addr += (next - addr), addr = next, addr != end);
 	return 0;
 }
 
-int ioremap_page_range(unsigned long addr, unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
+static int vmap_range(unsigned long addr, unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
+			unsigned int max_page_shift)
 {
 	pgd_t *pgd;
 	unsigned long start;
@@ -227,7 +207,7 @@ int ioremap_page_range(unsigned long addr, unsigned long end, phys_addr_t phys_a
 	pgd = pgd_offset_k(addr);
 	do {
 		next = pgd_addr_end(addr, end);
-		err = vmap_p4d_range(pgd, addr, next, phys_addr, prot, &mask);
+		err = vmap_p4d_range(pgd, addr, next, phys_addr, prot, max_page_shift, &mask);
 		if (err)
 			break;
 	} while (pgd++, phys_addr += (next - addr), addr = next, addr != end);
@@ -240,6 +220,16 @@ int ioremap_page_range(unsigned long addr, unsigned long end, phys_addr_t phys_a
 	return err;
 }
 
+int ioremap_page_range(unsigned long addr, unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
+{
+	unsigned int max_page_shift = PAGE_SHIFT;
+
+	if (iomap_allow_huge)
+		max_page_shift = P4D_SHIFT;
+
+	return vmap_range(addr, end, phys_addr, prot, max_page_shift);
+}
+
 #ifdef CONFIG_GENERIC_IOREMAP
 void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
 {
-- 
2.23.0

