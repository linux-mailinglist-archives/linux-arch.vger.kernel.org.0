Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E9830BCA0
	for <lists+linux-arch@lfdr.de>; Tue,  2 Feb 2021 12:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhBBLHb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Feb 2021 06:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhBBLHM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2021 06:07:12 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D633FC0613D6;
        Tue,  2 Feb 2021 03:06:30 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id q20so14087590pfu.8;
        Tue, 02 Feb 2021 03:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uqoFzS1QfUJym8qaL4KmBeJJsskaloylHduiw/HszjE=;
        b=dSdxejWnebhOz8No9Pkh4hHJXMu4oYOsFLCcbdRRYEhk1/zThsll3BJGbuAavquMRr
         5ovo/+/AqqWGleawMCfBqj9DUyqGgar4RU4cAefrQl98dNYTt5HHBCDTYSBx6TlMqt6K
         pCp1ebhpIty098hIH/YOPxrw95KCbF0m2y1HhFTkL5u7RIu/721tPcC6O9A7GNycM8ma
         3RncNXw+L0vAM7kZjFbJa2d0afcPCxON34DQ+u5S6ikbEaVgsEyhU0kANZPEm06Cv/PN
         Rcr0/tPxj1lWg288jhaVVpIcRjPDhjFZHaOB9rcctmcDtqeShd2Kw/NvduP++pS/JbJq
         BZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uqoFzS1QfUJym8qaL4KmBeJJsskaloylHduiw/HszjE=;
        b=WYKmOPgdSJP6pz0gyCcuCayMZ/+A7AuyWB6TaWZNJM1vmjlj4xqc8FrnxoMKlPomRH
         7Yb+NAoW/YazYhqTsEKJs8fsO/ATgVbMakHQ6LCowh3oEuwVvC/l6GzXs62t+5uTdmTl
         hO7nw/qRGjKoz4qA5nuAu0qcwGrf+eQlmdc/16N0m2HfKlO8U2makiUCCCAB96q/+NSH
         FxU9sWbvCDFOtm8ESnPDF6OQ3E4X8tGWR3TVdDVqH25rKSlzVo8vlixWqO/ztjfj20A7
         lohvSQp+SbbbUhw/m1G7hAFUJaCX1qbD8gv+yoI7NFjptnHJtG7yCCrQnVz6mx5kEzo8
         ZLcA==
X-Gm-Message-State: AOAM531puxcxKc8ZtEShPXm3zqXiHHAvXZY64tni4zrgfEC96fb2l8sb
        r1le5k6rmM6YaJtjQRJ+s6U=
X-Google-Smtp-Source: ABdhPJyMt3gawsPdxYB20EBPVKsqnWfh7RKObdhq2d4UzgC+ajaqGjR16yS+j2nx/+yBy7+TokUoKQ==
X-Received: by 2002:aa7:979b:0:b029:1c4:a2ce:94db with SMTP id o27-20020aa7979b0000b02901c4a2ce94dbmr20580142pfp.12.1612263990381;
        Tue, 02 Feb 2021 03:06:30 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (60-242-11-44.static.tpgi.com.au. [60.242.11.44])
        by smtp.gmail.com with ESMTPSA id g19sm3188979pfk.113.2021.02.02.03.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 03:06:29 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v12 11/14] mm: Move vmap_range from mm/ioremap.c to mm/vmalloc.c
Date:   Tue,  2 Feb 2021 21:05:12 +1000
Message-Id: <20210202110515.3575274-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210202110515.3575274-1-npiggin@gmail.com>
References: <20210202110515.3575274-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a generic kernel virtual memory mapper, not specific to ioremap.

Code is unchanged other than making vmap_range non-static.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/linux/vmalloc.h |   3 +
 mm/ioremap.c            | 203 ----------------------------------------
 mm/vmalloc.c            | 202 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 205 insertions(+), 203 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 9f7b8b00101b..99ea72d547dc 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -194,6 +194,9 @@ extern struct vm_struct *remove_vm_area(const void *addr);
 extern struct vm_struct *find_vm_area(const void *addr);
 
 #ifdef CONFIG_MMU
+int vmap_range(unsigned long addr, unsigned long end,
+			phys_addr_t phys_addr, pgprot_t prot,
+			unsigned int max_page_shift);
 extern int map_kernel_range_noflush(unsigned long start, unsigned long size,
 				    pgprot_t prot, struct page **pages);
 int map_kernel_range(unsigned long start, unsigned long size, pgprot_t prot,
diff --git a/mm/ioremap.c b/mm/ioremap.c
index 3264d0203785..d1dcc7e744ac 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -28,209 +28,6 @@ early_param("nohugeiomap", set_nohugeiomap);
 static const bool iomap_max_page_shift = PAGE_SHIFT;
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
 
-static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
-			phys_addr_t phys_addr, pgprot_t prot,
-			pgtbl_mod_mask *mask)
-{
-	pte_t *pte;
-	u64 pfn;
-
-	pfn = phys_addr >> PAGE_SHIFT;
-	pte = pte_alloc_kernel_track(pmd, addr, mask);
-	if (!pte)
-		return -ENOMEM;
-	do {
-		BUG_ON(!pte_none(*pte));
-		set_pte_at(&init_mm, addr, pte, pfn_pte(pfn, prot));
-		pfn++;
-	} while (pte++, addr += PAGE_SIZE, addr != end);
-	*mask |= PGTBL_PTE_MODIFIED;
-	return 0;
-}
-
-static int vmap_try_huge_pmd(pmd_t *pmd, unsigned long addr, unsigned long end,
-			phys_addr_t phys_addr, pgprot_t prot,
-			unsigned int max_page_shift)
-{
-	if (max_page_shift < PMD_SHIFT)
-		return 0;
-
-	if (!arch_vmap_pmd_supported(prot))
-		return 0;
-
-	if ((end - addr) != PMD_SIZE)
-		return 0;
-
-	if (!IS_ALIGNED(addr, PMD_SIZE))
-		return 0;
-
-	if (!IS_ALIGNED(phys_addr, PMD_SIZE))
-		return 0;
-
-	if (pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr))
-		return 0;
-
-	return pmd_set_huge(pmd, phys_addr, prot);
-}
-
-static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
-			phys_addr_t phys_addr, pgprot_t prot,
-			unsigned int max_page_shift, pgtbl_mod_mask *mask)
-{
-	pmd_t *pmd;
-	unsigned long next;
-
-	pmd = pmd_alloc_track(&init_mm, pud, addr, mask);
-	if (!pmd)
-		return -ENOMEM;
-	do {
-		next = pmd_addr_end(addr, end);
-
-		if (vmap_try_huge_pmd(pmd, addr, next, phys_addr, prot,
-					max_page_shift)) {
-			*mask |= PGTBL_PMD_MODIFIED;
-			continue;
-		}
-
-		if (vmap_pte_range(pmd, addr, next, phys_addr, prot, mask))
-			return -ENOMEM;
-	} while (pmd++, phys_addr += (next - addr), addr = next, addr != end);
-	return 0;
-}
-
-static int vmap_try_huge_pud(pud_t *pud, unsigned long addr, unsigned long end,
-			phys_addr_t phys_addr, pgprot_t prot,
-			unsigned int max_page_shift)
-{
-	if (max_page_shift < PUD_SHIFT)
-		return 0;
-
-	if (!arch_vmap_pud_supported(prot))
-		return 0;
-
-	if ((end - addr) != PUD_SIZE)
-		return 0;
-
-	if (!IS_ALIGNED(addr, PUD_SIZE))
-		return 0;
-
-	if (!IS_ALIGNED(phys_addr, PUD_SIZE))
-		return 0;
-
-	if (pud_present(*pud) && !pud_free_pmd_page(pud, addr))
-		return 0;
-
-	return pud_set_huge(pud, phys_addr, prot);
-}
-
-static int vmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
-			phys_addr_t phys_addr, pgprot_t prot,
-			unsigned int max_page_shift, pgtbl_mod_mask *mask)
-{
-	pud_t *pud;
-	unsigned long next;
-
-	pud = pud_alloc_track(&init_mm, p4d, addr, mask);
-	if (!pud)
-		return -ENOMEM;
-	do {
-		next = pud_addr_end(addr, end);
-
-		if (vmap_try_huge_pud(pud, addr, next, phys_addr, prot,
-					max_page_shift)) {
-			*mask |= PGTBL_PUD_MODIFIED;
-			continue;
-		}
-
-		if (vmap_pmd_range(pud, addr, next, phys_addr, prot,
-					max_page_shift, mask))
-			return -ENOMEM;
-	} while (pud++, phys_addr += (next - addr), addr = next, addr != end);
-	return 0;
-}
-
-static int vmap_try_huge_p4d(p4d_t *p4d, unsigned long addr, unsigned long end,
-			phys_addr_t phys_addr, pgprot_t prot,
-			unsigned int max_page_shift)
-{
-	if (max_page_shift < P4D_SHIFT)
-		return 0;
-
-	if (!arch_vmap_p4d_supported(prot))
-		return 0;
-
-	if ((end - addr) != P4D_SIZE)
-		return 0;
-
-	if (!IS_ALIGNED(addr, P4D_SIZE))
-		return 0;
-
-	if (!IS_ALIGNED(phys_addr, P4D_SIZE))
-		return 0;
-
-	if (p4d_present(*p4d) && !p4d_free_pud_page(p4d, addr))
-		return 0;
-
-	return p4d_set_huge(p4d, phys_addr, prot);
-}
-
-static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
-			phys_addr_t phys_addr, pgprot_t prot,
-			unsigned int max_page_shift, pgtbl_mod_mask *mask)
-{
-	p4d_t *p4d;
-	unsigned long next;
-
-	p4d = p4d_alloc_track(&init_mm, pgd, addr, mask);
-	if (!p4d)
-		return -ENOMEM;
-	do {
-		next = p4d_addr_end(addr, end);
-
-		if (vmap_try_huge_p4d(p4d, addr, next, phys_addr, prot,
-					max_page_shift)) {
-			*mask |= PGTBL_P4D_MODIFIED;
-			continue;
-		}
-
-		if (vmap_pud_range(p4d, addr, next, phys_addr, prot,
-					max_page_shift, mask))
-			return -ENOMEM;
-	} while (p4d++, phys_addr += (next - addr), addr = next, addr != end);
-	return 0;
-}
-
-static int vmap_range(unsigned long addr, unsigned long end,
-			phys_addr_t phys_addr, pgprot_t prot,
-			unsigned int max_page_shift)
-{
-	pgd_t *pgd;
-	unsigned long start;
-	unsigned long next;
-	int err;
-	pgtbl_mod_mask mask = 0;
-
-	might_sleep();
-	BUG_ON(addr >= end);
-
-	start = addr;
-	pgd = pgd_offset_k(addr);
-	do {
-		next = pgd_addr_end(addr, end);
-		err = vmap_p4d_range(pgd, addr, next, phys_addr, prot,
-					max_page_shift, &mask);
-		if (err)
-			break;
-	} while (pgd++, phys_addr += (next - addr), addr = next, addr != end);
-
-	flush_cache_vmap(start, end);
-
-	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
-		arch_sync_kernel_mappings(start, end);
-
-	return err;
-}
-
 int ioremap_page_range(unsigned long addr,
 		       unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
 {
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 7f2f36116980..f043386bb51d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -68,6 +68,208 @@ static void free_work(struct work_struct *w)
 }
 
 /*** Page table manipulation functions ***/
+static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
+			phys_addr_t phys_addr, pgprot_t prot,
+			pgtbl_mod_mask *mask)
+{
+	pte_t *pte;
+	u64 pfn;
+
+	pfn = phys_addr >> PAGE_SHIFT;
+	pte = pte_alloc_kernel_track(pmd, addr, mask);
+	if (!pte)
+		return -ENOMEM;
+	do {
+		BUG_ON(!pte_none(*pte));
+		set_pte_at(&init_mm, addr, pte, pfn_pte(pfn, prot));
+		pfn++;
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+	*mask |= PGTBL_PTE_MODIFIED;
+	return 0;
+}
+
+static int vmap_try_huge_pmd(pmd_t *pmd, unsigned long addr, unsigned long end,
+			phys_addr_t phys_addr, pgprot_t prot,
+			unsigned int max_page_shift)
+{
+	if (max_page_shift < PMD_SHIFT)
+		return 0;
+
+	if (!arch_vmap_pmd_supported(prot))
+		return 0;
+
+	if ((end - addr) != PMD_SIZE)
+		return 0;
+
+	if (!IS_ALIGNED(addr, PMD_SIZE))
+		return 0;
+
+	if (!IS_ALIGNED(phys_addr, PMD_SIZE))
+		return 0;
+
+	if (pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr))
+		return 0;
+
+	return pmd_set_huge(pmd, phys_addr, prot);
+}
+
+static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
+			phys_addr_t phys_addr, pgprot_t prot,
+			unsigned int max_page_shift, pgtbl_mod_mask *mask)
+{
+	pmd_t *pmd;
+	unsigned long next;
+
+	pmd = pmd_alloc_track(&init_mm, pud, addr, mask);
+	if (!pmd)
+		return -ENOMEM;
+	do {
+		next = pmd_addr_end(addr, end);
+
+		if (vmap_try_huge_pmd(pmd, addr, next, phys_addr, prot,
+					max_page_shift)) {
+			*mask |= PGTBL_PMD_MODIFIED;
+			continue;
+		}
+
+		if (vmap_pte_range(pmd, addr, next, phys_addr, prot, mask))
+			return -ENOMEM;
+	} while (pmd++, phys_addr += (next - addr), addr = next, addr != end);
+	return 0;
+}
+
+static int vmap_try_huge_pud(pud_t *pud, unsigned long addr, unsigned long end,
+			phys_addr_t phys_addr, pgprot_t prot,
+			unsigned int max_page_shift)
+{
+	if (max_page_shift < PUD_SHIFT)
+		return 0;
+
+	if (!arch_vmap_pud_supported(prot))
+		return 0;
+
+	if ((end - addr) != PUD_SIZE)
+		return 0;
+
+	if (!IS_ALIGNED(addr, PUD_SIZE))
+		return 0;
+
+	if (!IS_ALIGNED(phys_addr, PUD_SIZE))
+		return 0;
+
+	if (pud_present(*pud) && !pud_free_pmd_page(pud, addr))
+		return 0;
+
+	return pud_set_huge(pud, phys_addr, prot);
+}
+
+static int vmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
+			phys_addr_t phys_addr, pgprot_t prot,
+			unsigned int max_page_shift, pgtbl_mod_mask *mask)
+{
+	pud_t *pud;
+	unsigned long next;
+
+	pud = pud_alloc_track(&init_mm, p4d, addr, mask);
+	if (!pud)
+		return -ENOMEM;
+	do {
+		next = pud_addr_end(addr, end);
+
+		if (vmap_try_huge_pud(pud, addr, next, phys_addr, prot,
+					max_page_shift)) {
+			*mask |= PGTBL_PUD_MODIFIED;
+			continue;
+		}
+
+		if (vmap_pmd_range(pud, addr, next, phys_addr, prot,
+					max_page_shift, mask))
+			return -ENOMEM;
+	} while (pud++, phys_addr += (next - addr), addr = next, addr != end);
+	return 0;
+}
+
+static int vmap_try_huge_p4d(p4d_t *p4d, unsigned long addr, unsigned long end,
+			phys_addr_t phys_addr, pgprot_t prot,
+			unsigned int max_page_shift)
+{
+	if (max_page_shift < P4D_SHIFT)
+		return 0;
+
+	if (!arch_vmap_p4d_supported(prot))
+		return 0;
+
+	if ((end - addr) != P4D_SIZE)
+		return 0;
+
+	if (!IS_ALIGNED(addr, P4D_SIZE))
+		return 0;
+
+	if (!IS_ALIGNED(phys_addr, P4D_SIZE))
+		return 0;
+
+	if (p4d_present(*p4d) && !p4d_free_pud_page(p4d, addr))
+		return 0;
+
+	return p4d_set_huge(p4d, phys_addr, prot);
+}
+
+static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
+			phys_addr_t phys_addr, pgprot_t prot,
+			unsigned int max_page_shift, pgtbl_mod_mask *mask)
+{
+	p4d_t *p4d;
+	unsigned long next;
+
+	p4d = p4d_alloc_track(&init_mm, pgd, addr, mask);
+	if (!p4d)
+		return -ENOMEM;
+	do {
+		next = p4d_addr_end(addr, end);
+
+		if (vmap_try_huge_p4d(p4d, addr, next, phys_addr, prot,
+					max_page_shift)) {
+			*mask |= PGTBL_P4D_MODIFIED;
+			continue;
+		}
+
+		if (vmap_pud_range(p4d, addr, next, phys_addr, prot,
+					max_page_shift, mask))
+			return -ENOMEM;
+	} while (p4d++, phys_addr += (next - addr), addr = next, addr != end);
+	return 0;
+}
+
+int vmap_range(unsigned long addr, unsigned long end,
+			phys_addr_t phys_addr, pgprot_t prot,
+			unsigned int max_page_shift)
+{
+	pgd_t *pgd;
+	unsigned long start;
+	unsigned long next;
+	int err;
+	pgtbl_mod_mask mask = 0;
+
+	might_sleep();
+	BUG_ON(addr >= end);
+
+	start = addr;
+	pgd = pgd_offset_k(addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		err = vmap_p4d_range(pgd, addr, next, phys_addr, prot,
+					max_page_shift, &mask);
+		if (err)
+			break;
+	} while (pgd++, phys_addr += (next - addr), addr = next, addr != end);
+
+	flush_cache_vmap(start, end);
+
+	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
+		arch_sync_kernel_mappings(start, end);
+
+	return err;
+}
 
 static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			     pgtbl_mod_mask *mask)
-- 
2.23.0

