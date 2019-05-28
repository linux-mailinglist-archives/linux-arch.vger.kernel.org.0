Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDD22C62B
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2019 14:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfE1MJF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 May 2019 08:09:05 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46435 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfE1MJE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 May 2019 08:09:04 -0400
Received: by mail-pl1-f193.google.com with SMTP id bb3so649055plb.13
        for <linux-arch@vger.kernel.org>; Tue, 28 May 2019 05:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rpHM44yAAw//wR+baLC6z16WVts2B8ElzhqciMxNN6c=;
        b=GkKo1YDRNKtYKY53hbho1Vvc/EOX7aIrv3cliFCXDZmVXXH0Frwwq8zxOX6r6LWoVx
         MRM8548vQWdBvehje9/JJ4HtPp6R8ym6TBk3C9aM5QVa9va1a3uugRIQ1zhIYPdWGAGe
         GfQSEGhjJL2R501pdsUdNTw2ylfPoMsXTkvmG64g1tnUxSuZZgQbkt/Efxk1ImbChaiO
         9lZTr9JxRH9MKsUrk3kuN0uHarpSopL5g3l7mxMup67O3kQiylhmw6V50bFMy2783Yu8
         G4EHS2Zp+rGQWDLvkYkCb2dGHhA4ReWBd/T+2ObQtE/ll7gBW5/DRnVUetUZWUIzMQ+s
         Ddjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rpHM44yAAw//wR+baLC6z16WVts2B8ElzhqciMxNN6c=;
        b=gk+ZMqGmLxVgjzMkgukU0sl01zGKnFP76/PA1vYOHCwMA8cb9fnfWA642nRFvPt1Fr
         QYLBbxa1drxvVIC6iYfqylk2OnFJVmgArjr0gbJpHkBDnxr5uWF1qck0kDMJUlHNr0/K
         UiibCulAbGIeKArk92k/rN4FWllIRqGj7kNumIEkpYV780+IXXyROEpA6vjT3tVn9UlO
         dDPNGjV53D8ZlLi59wwmZDYwMXvrUncDvgPW/rHsQiibyXkgm/mZPooBBjnNRoG9duiP
         4c/GllKCgbalpvA+yiuDFT2zAUm9VNSjnmQb9phJCivblr8B1ao6Rx9EcmZQ9gJ9Fcmb
         nFVA==
X-Gm-Message-State: APjAAAXcMDQ4zz71AISByXmpzFMeu+P01LYgg9QmTeUMWlPkaul8/MAm
        kf313QgnJVYf1fj/4q3q5Fo=
X-Google-Smtp-Source: APXvYqwovI6TUCqZvBm95UUExXviSf2mOJ5mk3uaFqn6Critn1yRGeSUyaPe4p3MPksHxo9arWX+Uw==
X-Received: by 2002:a17:902:404:: with SMTP id 4mr42254710ple.204.1559045343753;
        Tue, 28 May 2019 05:09:03 -0700 (PDT)
Received: from bobo.local0.net (193-116-79-40.tpgi.com.au. [193.116.79.40])
        by smtp.gmail.com with ESMTPSA id d15sm37463327pfm.186.2019.05.28.05.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 05:09:03 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        Toshi Kani <toshi.kani@hp.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH 3/4] mm: Move ioremap page table mapping function to mm/
Date:   Tue, 28 May 2019 22:04:52 +1000
Message-Id: <20190528120453.27374-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528120453.27374-1-npiggin@gmail.com>
References: <20190528120453.27374-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ioremap_page_range is a useful generic function to create a kernel
virtual mapping, move it to mm/vmalloc.c and rename it vmap_range to
be used by a subsequent change.

For clarity with this move, also:
- Rename vunmap_page_range (vmap_range's inverse) to vunmap_range.
- Rename vmap_page_range (which takes a page array) to vmap_pages.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/linux/vmalloc.h |   3 +
 lib/ioremap.c           | 173 +++---------------------------
 mm/vmalloc.c            | 227 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 228 insertions(+), 175 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 51e131245379..812bea5866d6 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -147,6 +147,9 @@ extern struct vm_struct *find_vm_area(const void *addr);
 extern int map_vm_area(struct vm_struct *area, pgprot_t prot,
 			struct page **pages);
 #ifdef CONFIG_MMU
+extern int vmap_range(unsigned long addr,
+		       unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
+		       unsigned int max_page_shift);
 extern int map_kernel_range_noflush(unsigned long start, unsigned long size,
 				    pgprot_t prot, struct page **pages);
 extern void unmap_kernel_range_noflush(unsigned long addr, unsigned long size);
diff --git a/lib/ioremap.c b/lib/ioremap.c
index 063213685563..e13946da8ec3 100644
--- a/lib/ioremap.c
+++ b/lib/ioremap.c
@@ -58,165 +58,24 @@ static inline int ioremap_pud_enabled(void) { return 0; }
 static inline int ioremap_pmd_enabled(void) { return 0; }
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
 
-static int ioremap_pte_range(pmd_t *pmd, unsigned long addr,
-		unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
-{
-	pte_t *pte;
-	u64 pfn;
-
-	pfn = phys_addr >> PAGE_SHIFT;
-	pte = pte_alloc_kernel(pmd, addr);
-	if (!pte)
-		return -ENOMEM;
-	do {
-		BUG_ON(!pte_none(*pte));
-		set_pte_at(&init_mm, addr, pte, pfn_pte(pfn, prot));
-		pfn++;
-	} while (pte++, addr += PAGE_SIZE, addr != end);
-	return 0;
-}
-
-static int ioremap_try_huge_pmd(pmd_t *pmd, unsigned long addr,
-				unsigned long end, phys_addr_t phys_addr,
-				pgprot_t prot)
-{
-	if (!ioremap_pmd_enabled())
-		return 0;
-
-	if ((end - addr) != PMD_SIZE)
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
-static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
-		unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
-{
-	pmd_t *pmd;
-	unsigned long next;
-
-	pmd = pmd_alloc(&init_mm, pud, addr);
-	if (!pmd)
-		return -ENOMEM;
-	do {
-		next = pmd_addr_end(addr, end);
-
-		if (ioremap_try_huge_pmd(pmd, addr, next, phys_addr, prot))
-			continue;
-
-		if (ioremap_pte_range(pmd, addr, next, phys_addr, prot))
-			return -ENOMEM;
-	} while (pmd++, phys_addr += (next - addr), addr = next, addr != end);
-	return 0;
-}
-
-static int ioremap_try_huge_pud(pud_t *pud, unsigned long addr,
-				unsigned long end, phys_addr_t phys_addr,
-				pgprot_t prot)
-{
-	if (!ioremap_pud_enabled())
-		return 0;
-
-	if ((end - addr) != PUD_SIZE)
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
-static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
-		unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
-{
-	pud_t *pud;
-	unsigned long next;
-
-	pud = pud_alloc(&init_mm, p4d, addr);
-	if (!pud)
-		return -ENOMEM;
-	do {
-		next = pud_addr_end(addr, end);
-
-		if (ioremap_try_huge_pud(pud, addr, next, phys_addr, prot))
-			continue;
-
-		if (ioremap_pmd_range(pud, addr, next, phys_addr, prot))
-			return -ENOMEM;
-	} while (pud++, phys_addr += (next - addr), addr = next, addr != end);
-	return 0;
-}
-
-static int ioremap_try_huge_p4d(p4d_t *p4d, unsigned long addr,
-				unsigned long end, phys_addr_t phys_addr,
-				pgprot_t prot)
-{
-	if (!ioremap_p4d_enabled())
-		return 0;
-
-	if ((end - addr) != P4D_SIZE)
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
-static inline int ioremap_p4d_range(pgd_t *pgd, unsigned long addr,
-		unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
-{
-	p4d_t *p4d;
-	unsigned long next;
-
-	p4d = p4d_alloc(&init_mm, pgd, addr);
-	if (!p4d)
-		return -ENOMEM;
-	do {
-		next = p4d_addr_end(addr, end);
-
-		if (ioremap_try_huge_p4d(p4d, addr, next, phys_addr, prot))
-			continue;
-
-		if (ioremap_pud_range(p4d, addr, next, phys_addr, prot))
-			return -ENOMEM;
-	} while (p4d++, phys_addr += (next - addr), addr = next, addr != end);
-	return 0;
-}
-
 int ioremap_page_range(unsigned long addr,
 		       unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
 {
-	pgd_t *pgd;
-	unsigned long start;
-	unsigned long next;
-	int err;
-
-	might_sleep();
-	BUG_ON(addr >= end);
-
-	start = addr;
-	pgd = pgd_offset_k(addr);
-	do {
-		next = pgd_addr_end(addr, end);
-		err = ioremap_p4d_range(pgd, addr, next, phys_addr, prot);
-		if (err)
-			break;
-	} while (pgd++, phys_addr += (next - addr), addr = next, addr != end);
-
-	flush_cache_vmap(start, end);
+	unsigned int max_page_shift = PAGE_SHIFT;
+
+	/*
+	 * Due to the max_page_shift parameter to vmap_range, platforms must
+	 * enable all smaller sizes to take advantage of a given size,
+	 * otherwise fall back to small pages.
+	 */
+	if (ioremap_pmd_enabled()) {
+		max_page_shift = PMD_SHIFT;
+		if (ioremap_pud_enabled()) {
+			max_page_shift = PUD_SHIFT;
+			if (ioremap_p4d_enabled())
+				max_page_shift = P4D_SHIFT;
+		}
+	}
 
-	return err;
+	return vmap_range(addr, end, phys_addr, prot, max_page_shift);
 }
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 233af6936c93..6a0c97f89091 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -119,7 +119,7 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end)
 	} while (p4d++, addr = next, addr != end);
 }
 
-static void vunmap_page_range(unsigned long addr, unsigned long end)
+static void vunmap_range(unsigned long addr, unsigned long end)
 {
 	pgd_t *pgd;
 	unsigned long next;
@@ -135,6 +135,197 @@ static void vunmap_page_range(unsigned long addr, unsigned long end)
 }
 
 static int vmap_pte_range(pmd_t *pmd, unsigned long addr,
+			unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
+{
+	pte_t *pte;
+	u64 pfn;
+
+	pfn = phys_addr >> PAGE_SHIFT;
+	pte = pte_alloc_kernel(pmd, addr);
+	if (!pte)
+		return -ENOMEM;
+	do {
+		BUG_ON(!pte_none(*pte));
+		set_pte_at(&init_mm, addr, pte, pfn_pte(pfn, prot));
+		pfn++;
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+	return 0;
+}
+
+static int vmap_try_huge_pmd(pmd_t *pmd, unsigned long addr,
+			unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
+			unsigned int max_page_shift)
+{
+	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP))
+		return 0;
+
+	if (max_page_shift < PMD_SIZE)
+		return 0;
+
+	if ((end - addr) != PMD_SIZE)
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
+static inline int vmap_pmd_range(pud_t *pud, unsigned long addr,
+			unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
+			unsigned int max_page_shift)
+{
+	pmd_t *pmd;
+	unsigned long next;
+
+	pmd = pmd_alloc(&init_mm, pud, addr);
+	if (!pmd)
+		return -ENOMEM;
+	do {
+		next = pmd_addr_end(addr, end);
+
+		if (vmap_try_huge_pmd(pmd, addr, next, phys_addr, prot,
+					max_page_shift))
+			continue;
+
+		if (vmap_pte_range(pmd, addr, next, phys_addr, prot))
+			return -ENOMEM;
+	} while (pmd++, phys_addr += (next - addr), addr = next, addr != end);
+	return 0;
+}
+
+static int vmap_try_huge_pud(pud_t *pud, unsigned long addr,
+			unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
+			unsigned int max_page_shift)
+{
+	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP))
+		return 0;
+
+	if (max_page_shift < PUD_SIZE)
+		return 0;
+
+	if ((end - addr) != PUD_SIZE)
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
+static inline int vmap_pud_range(p4d_t *p4d, unsigned long addr,
+			unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
+			unsigned int max_page_shift)
+{
+	pud_t *pud;
+	unsigned long next;
+
+	pud = pud_alloc(&init_mm, p4d, addr);
+	if (!pud)
+		return -ENOMEM;
+	do {
+		next = pud_addr_end(addr, end);
+
+		if (vmap_try_huge_pud(pud, addr, next, phys_addr, prot,
+					max_page_shift))
+			continue;
+
+		if (vmap_pmd_range(pud, addr, next, phys_addr, prot,
+					max_page_shift))
+			return -ENOMEM;
+	} while (pud++, phys_addr += (next - addr), addr = next, addr != end);
+	return 0;
+}
+
+static int vmap_try_huge_p4d(p4d_t *p4d, unsigned long addr,
+			unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
+			unsigned int max_page_shift)
+{
+	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP))
+		return 0;
+
+	if (max_page_shift < P4D_SIZE)
+		return 0;
+
+	if ((end - addr) != P4D_SIZE)
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
+static inline int vmap_p4d_range(pgd_t *pgd, unsigned long addr,
+			unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
+			unsigned int max_page_shift)
+{
+	p4d_t *p4d;
+	unsigned long next;
+
+	p4d = p4d_alloc(&init_mm, pgd, addr);
+	if (!p4d)
+		return -ENOMEM;
+	do {
+		next = p4d_addr_end(addr, end);
+
+		if (vmap_try_huge_p4d(p4d, addr, next, phys_addr, prot,
+					max_page_shift))
+			continue;
+
+		if (vmap_pud_range(p4d, addr, next, phys_addr, prot,
+					max_page_shift))
+			return -ENOMEM;
+	} while (p4d++, phys_addr += (next - addr), addr = next, addr != end);
+	return 0;
+}
+
+static int vmap_range_noflush(unsigned long addr,
+			unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
+			unsigned int max_page_shift)
+{
+	pgd_t *pgd;
+	unsigned long start;
+	unsigned long next;
+	int err;
+
+	might_sleep();
+	BUG_ON(addr >= end);
+
+	start = addr;
+	pgd = pgd_offset_k(addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		err = vmap_p4d_range(pgd, addr, next, phys_addr, prot,
+					max_page_shift);
+		if (err)
+			break;
+	} while (pgd++, phys_addr += (next - addr), addr = next, addr != end);
+
+	return err;
+}
+
+int vmap_range(unsigned long addr,
+		       unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
+		       unsigned int max_page_shift)
+{
+	int ret;
+
+	ret = vmap_range_noflush(addr, end, phys_addr, prot, max_page_shift);
+	flush_cache_vmap(start, end);
+	return ret;
+}
+
+static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr)
 {
 	pte_t *pte;
@@ -160,7 +351,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 
-static int vmap_pmd_range(pud_t *pud, unsigned long addr,
+static int vmap_pages_pmd_range(pud_t *pud, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr)
 {
 	pmd_t *pmd;
@@ -171,13 +362,13 @@ static int vmap_pmd_range(pud_t *pud, unsigned long addr,
 		return -ENOMEM;
 	do {
 		next = pmd_addr_end(addr, end);
-		if (vmap_pte_range(pmd, addr, next, prot, pages, nr))
+		if (vmap_pages_pte_range(pmd, addr, next, prot, pages, nr))
 			return -ENOMEM;
 	} while (pmd++, addr = next, addr != end);
 	return 0;
 }
 
-static int vmap_pud_range(p4d_t *p4d, unsigned long addr,
+static int vmap_pages_pud_range(p4d_t *p4d, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr)
 {
 	pud_t *pud;
@@ -188,13 +379,13 @@ static int vmap_pud_range(p4d_t *p4d, unsigned long addr,
 		return -ENOMEM;
 	do {
 		next = pud_addr_end(addr, end);
-		if (vmap_pmd_range(pud, addr, next, prot, pages, nr))
+		if (vmap_pages_pmd_range(pud, addr, next, prot, pages, nr))
 			return -ENOMEM;
 	} while (pud++, addr = next, addr != end);
 	return 0;
 }
 
-static int vmap_p4d_range(pgd_t *pgd, unsigned long addr,
+static int vmap_pages_p4d_range(pgd_t *pgd, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr)
 {
 	p4d_t *p4d;
@@ -205,7 +396,7 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr,
 		return -ENOMEM;
 	do {
 		next = p4d_addr_end(addr, end);
-		if (vmap_pud_range(p4d, addr, next, prot, pages, nr))
+		if (vmap_pages_pud_range(p4d, addr, next, prot, pages, nr))
 			return -ENOMEM;
 	} while (p4d++, addr = next, addr != end);
 	return 0;
@@ -217,7 +408,7 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr,
  *
  * Ie. pte at addr+N*PAGE_SIZE shall point to pfn corresponding to pages[N]
  */
-static int vmap_page_range_noflush(unsigned long start, unsigned long end,
+static int vmap_pages_range_noflush(unsigned long start, unsigned long end,
 				   pgprot_t prot, struct page **pages)
 {
 	pgd_t *pgd;
@@ -230,7 +421,7 @@ static int vmap_page_range_noflush(unsigned long start, unsigned long end,
 	pgd = pgd_offset_k(addr);
 	do {
 		next = pgd_addr_end(addr, end);
-		err = vmap_p4d_range(pgd, addr, next, prot, pages, &nr);
+		err = vmap_pages_p4d_range(pgd, addr, next, prot, pages, &nr);
 		if (err)
 			return err;
 	} while (pgd++, addr = next, addr != end);
@@ -238,12 +429,12 @@ static int vmap_page_range_noflush(unsigned long start, unsigned long end,
 	return nr;
 }
 
-static int vmap_page_range(unsigned long start, unsigned long end,
+static int vmap_pages_range(unsigned long start, unsigned long end,
 			   pgprot_t prot, struct page **pages)
 {
 	int ret;
 
-	ret = vmap_page_range_noflush(start, end, prot, pages);
+	ret = vmap_pages_range_noflush(start, end, prot, pages);
 	flush_cache_vmap(start, end);
 	return ret;
 }
@@ -1148,7 +1339,7 @@ static void free_vmap_area(struct vmap_area *va)
  */
 static void unmap_vmap_area(struct vmap_area *va)
 {
-	vunmap_page_range(va->va_start, va->va_end);
+	vunmap_range(va->va_start, va->va_end);
 }
 
 /*
@@ -1586,7 +1777,7 @@ static void vb_free(const void *addr, unsigned long size)
 	rcu_read_unlock();
 	BUG_ON(!vb);
 
-	vunmap_page_range((unsigned long)addr, (unsigned long)addr + size);
+	vunmap_range((unsigned long)addr, (unsigned long)addr + size);
 
 	if (debug_pagealloc_enabled())
 		flush_tlb_kernel_range((unsigned long)addr,
@@ -1736,7 +1927,7 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node, pgprot_t pro
 		addr = va->va_start;
 		mem = (void *)addr;
 	}
-	if (vmap_page_range(addr, addr + size, prot, pages) < 0) {
+	if (vmap_pages_range(addr, addr + size, prot, pages) < 0) {
 		vm_unmap_ram(mem, count);
 		return NULL;
 	}
@@ -1903,7 +2094,7 @@ void __init vmalloc_init(void)
 int map_kernel_range_noflush(unsigned long addr, unsigned long size,
 			     pgprot_t prot, struct page **pages)
 {
-	return vmap_page_range_noflush(addr, addr + size, prot, pages);
+	return vmap_pages_range_noflush(addr, addr + size, prot, pages);
 }
 
 /**
@@ -1922,7 +2113,7 @@ int map_kernel_range_noflush(unsigned long addr, unsigned long size,
  */
 void unmap_kernel_range_noflush(unsigned long addr, unsigned long size)
 {
-	vunmap_page_range(addr, addr + size);
+	vunmap_range(addr, addr + size);
 }
 EXPORT_SYMBOL_GPL(unmap_kernel_range_noflush);
 
@@ -1939,7 +2130,7 @@ void unmap_kernel_range(unsigned long addr, unsigned long size)
 	unsigned long end = addr + size;
 
 	flush_cache_vunmap(addr, end);
-	vunmap_page_range(addr, end);
+	vunmap_range(addr, end);
 	flush_tlb_kernel_range(addr, end);
 }
 EXPORT_SYMBOL_GPL(unmap_kernel_range);
@@ -1950,7 +2141,7 @@ int map_vm_area(struct vm_struct *area, pgprot_t prot, struct page **pages)
 	unsigned long end = addr + get_vm_area_size(area);
 	int err;
 
-	err = vmap_page_range(addr, end, prot, pages);
+	err = vmap_pages_range(addr, end, prot, pages);
 
 	return err > 0 ? 0 : err;
 }
-- 
2.20.1

