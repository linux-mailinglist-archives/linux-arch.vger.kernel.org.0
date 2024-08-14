Return-Path: <linux-arch+bounces-6199-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0450951EDC
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2024 17:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3551F23E66
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2024 15:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298E11B5830;
	Wed, 14 Aug 2024 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P6zpsJQM"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E775E1B5824;
	Wed, 14 Aug 2024 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650278; cv=none; b=FP/EwRMoCLBSEZS3T3Si49BZ6rcmhScB3hlYQ3HfyarFvLx7XI/O8xiUhi8pLaMzIbckJIo/X6/ZU1+C58xmqOyGH49x7M9JyGl75J7Z68DL+8ZO2RG3cha48BHcgQW1a0Yl1jbwc3iTPugynbnTaLh8WhOQe1ECdtXu6WLGf/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650278; c=relaxed/simple;
	bh=wcS25wpMLVgOIy9E/GPXm3lk7nuNw1krdIPj4tn6nMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIpMtZ3Jmp/mLw+mygy76Kl16o4nw0PQTLzLkorXqXIhi6Mw+aLlD4ficuJoxMcWP80GF64hYN64UuiEbcL8DorRldfQzdpenyZ3Xmqhz8Lx4e/8SWS+XbywzKwiMlpPZQSO2heRjIYjWFWYm16MTcvCJBtzuZj2I+fcLBLdsmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P6zpsJQM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=tfV7WoZ6NIM51vwBk5nQrfZfdmvlMkhuTSlo5MPjTHE=; b=P6zpsJQMoLWMp9gjjpDgfOniJp
	mYh9MDpOZMWOZwFaxo+86FQW0xoL2T4SrNuJOoxl6JBy1bAxTxZisWXj/TmSdkjGiG31E8jgxxK0V
	uCVmixj/y4r3WJjpxoeitbXCaqvI2vPBx0KtBK8oGNCQiaO7B4Fhhh2UQ1zALmZWo/rXhY9444JEE
	bjL6sQzxf52QpSmX16I4AZG81s3Y0SVYggpEXWr/p6wQQ2oDLBtly+wXCj4EBVYxX+eEGuc9wmMRH
	urqGYTLvJetcQJkLDTWc4qV7W5bd5iRWH3CA8yomPQ71vY3YIh3obEEy4rZ0N3yWoJON37Cy1yPG+
	N0o9aWKg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seGAr-00000000gH6-44k9;
	Wed, 14 Aug 2024 15:44:34 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org,
	linux-arch@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH 1/5] mm: Introduce a common definition of mk_pte()
Date: Wed, 14 Aug 2024 16:44:21 +0100
Message-ID: <20240814154427.162475-2-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240814154427.162475-1-willy@infradead.org>
References: <20240814154427.162475-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most architectures simply call pfn_pte().  Centralise that as the normal
definition and remove the definition of mk_pte() from the architectures
which have either that exact definition or something similar.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/alpha/include/asm/pgtable.h         | 7 -------
 arch/arc/include/asm/pgtable-levels.h    | 1 -
 arch/arm/include/asm/pgtable.h           | 1 -
 arch/arm64/include/asm/pgtable.h         | 6 ------
 arch/csky/include/asm/pgtable.h          | 5 -----
 arch/hexagon/include/asm/pgtable.h       | 3 ---
 arch/loongarch/include/asm/pgtable.h     | 6 ------
 arch/m68k/include/asm/mcf_pgtable.h      | 6 ------
 arch/m68k/include/asm/motorola_pgtable.h | 6 ------
 arch/m68k/include/asm/sun3_pgtable.h     | 6 ------
 arch/microblaze/include/asm/pgtable.h    | 8 --------
 arch/mips/include/asm/pgtable.h          | 6 ------
 arch/nios2/include/asm/pgtable.h         | 6 ------
 arch/openrisc/include/asm/pgtable.h      | 2 --
 arch/parisc/include/asm/pgtable.h        | 2 --
 arch/powerpc/include/asm/pgtable.h       | 1 -
 arch/riscv/include/asm/pgtable.h         | 2 --
 arch/s390/include/asm/pgtable.h          | 1 +
 arch/sh/include/asm/pgtable_32.h         | 8 --------
 arch/sparc/include/asm/pgtable_32.h      | 9 ++-------
 arch/sparc/include/asm/pgtable_64.h      | 1 -
 arch/xtensa/include/asm/pgtable.h        | 1 -
 include/linux/pgtable.h                  | 7 +++++++
 23 files changed, 10 insertions(+), 91 deletions(-)

diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 635f0a5f5bbd..63e95f36f8ec 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -192,13 +192,6 @@ extern unsigned long __zero_page(void);
 #define pte_pfn(pte)		(pte_val(pte) >> PFN_PTE_SHIFT)
 
 #define pte_page(pte)	pfn_to_page(pte_pfn(pte))
-#define mk_pte(page, pgprot)						\
-({									\
-	pte_t pte;							\
-									\
-	pte_val(pte) = (page_to_pfn(page) << 32) | pgprot_val(pgprot);	\
-	pte;								\
-})
 
 extern inline pte_t pfn_pte(unsigned long physpfn, pgprot_t pgprot)
 { pte_t pte; pte_val(pte) = (PHYS_TWIDDLE(physpfn) << 32) | pgprot_val(pgprot); return pte; }
diff --git a/arch/arc/include/asm/pgtable-levels.h b/arch/arc/include/asm/pgtable-levels.h
index 86e148226463..55dbd2719e35 100644
--- a/arch/arc/include/asm/pgtable-levels.h
+++ b/arch/arc/include/asm/pgtable-levels.h
@@ -177,7 +177,6 @@
 #define set_pte(ptep, pte)	((*(ptep)) = (pte))
 #define pte_pfn(pte)		(pte_val(pte) >> PAGE_SHIFT)
 #define pfn_pte(pfn, prot)	__pte(__pfn_to_phys(pfn) | pgprot_val(prot))
-#define mk_pte(page, prot)	pfn_pte(page_to_pfn(page), prot)
 
 #ifdef CONFIG_ISA_ARCV2
 #define pmd_leaf(x)		(pmd_val(x) & _PAGE_HW_SZ)
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index be91e376df79..74c3b5a6eab3 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -169,7 +169,6 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 #define pfn_pte(pfn,prot)	__pte(__pfn_to_phys(pfn) | pgprot_val(prot))
 
 #define pte_page(pte)		pfn_to_page(pte_pfn(pte))
-#define mk_pte(page,prot)	pfn_pte(page_to_pfn(page), prot)
 
 #define pte_clear(mm,addr,ptep)	set_pte_ext(ptep, __pte(0), 0)
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7a4f5604be3f..33b6bf2add61 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -741,12 +741,6 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 /* use ONLY for statically allocated translation tables */
 #define pte_offset_kimg(dir,addr)	((pte_t *)__phys_to_kimg(pte_offset_phys((dir), (addr))))
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- */
-#define mk_pte(page,prot)	pfn_pte(page_to_pfn(page),prot)
-
 #if CONFIG_PGTABLE_LEVELS > 2
 
 #define pmd_ERROR(e)	\
diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index a397e1718ab6..b8378431aeff 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -249,11 +249,6 @@ static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
 	return __pgprot(prot);
 }
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- */
-#define mk_pte(page, pgprot)    pfn_pte(page_to_pfn(page), (pgprot))
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	return __pte((pte_val(pte) & _PAGE_CHG_MASK) |
diff --git a/arch/hexagon/include/asm/pgtable.h b/arch/hexagon/include/asm/pgtable.h
index 8c5b7a1c3d90..9fbdfdbc539f 100644
--- a/arch/hexagon/include/asm/pgtable.h
+++ b/arch/hexagon/include/asm/pgtable.h
@@ -238,9 +238,6 @@ static inline int pte_present(pte_t pte)
 	return pte_val(pte) & _PAGE_PRESENT;
 }
 
-/* mk_pte - make a PTE out of a page pointer and protection bits */
-#define mk_pte(page, pgprot) pfn_pte(page_to_pfn(page), (pgprot))
-
 /* pte_page - returns a page (frame pointer/descriptor?) based on a PTE */
 #define pte_page(x) pfn_to_page(pte_pfn(x))
 
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 85431f20a14d..f2bbe3f74440 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -450,12 +450,6 @@ static inline unsigned long pte_accessible(struct mm_struct *mm, pte_t a)
 	return false;
 }
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- */
-#define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
-
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	return __pte((pte_val(pte) & _PAGE_CHG_MASK) |
diff --git a/arch/m68k/include/asm/mcf_pgtable.h b/arch/m68k/include/asm/mcf_pgtable.h
index 48f87a8a8832..f5c596b211d4 100644
--- a/arch/m68k/include/asm/mcf_pgtable.h
+++ b/arch/m68k/include/asm/mcf_pgtable.h
@@ -96,12 +96,6 @@
 
 #define pmd_pgtable(pmd) pfn_to_virt(pmd_val(pmd) >> PAGE_SHIFT)
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- */
-#define mk_pte(page, pgprot) pfn_pte(page_to_pfn(page), (pgprot))
-
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	pte_val(pte) = (pte_val(pte) & CF_PAGE_CHG_MASK) | pgprot_val(newprot);
diff --git a/arch/m68k/include/asm/motorola_pgtable.h b/arch/m68k/include/asm/motorola_pgtable.h
index 9866c7acdabe..040ac3bad713 100644
--- a/arch/m68k/include/asm/motorola_pgtable.h
+++ b/arch/m68k/include/asm/motorola_pgtable.h
@@ -81,12 +81,6 @@ extern unsigned long mm_cachebits;
 
 #define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- */
-#define mk_pte(page, pgprot) pfn_pte(page_to_pfn(page), (pgprot))
-
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	pte_val(pte) = (pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot);
diff --git a/arch/m68k/include/asm/sun3_pgtable.h b/arch/m68k/include/asm/sun3_pgtable.h
index 30081aee8164..73745dc0ec0e 100644
--- a/arch/m68k/include/asm/sun3_pgtable.h
+++ b/arch/m68k/include/asm/sun3_pgtable.h
@@ -76,12 +76,6 @@
 
 #ifndef __ASSEMBLY__
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- */
-#define mk_pte(page, pgprot) pfn_pte(page_to_pfn(page), (pgprot))
-
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	pte_val(pte) = (pte_val(pte) & SUN3_PAGE_CHG_MASK) | pgprot_val(newprot);
diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index e4ea2ec3642f..b1bb2c65dd04 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -285,14 +285,6 @@ static inline pte_t mk_pte_phys(phys_addr_t physpage, pgprot_t pgprot)
 	return pte;
 }
 
-#define mk_pte(page, pgprot) \
-({									   \
-	pte_t pte;							   \
-	pte_val(pte) = (((page - mem_map) << PAGE_SHIFT) + memory_start) |  \
-			pgprot_val(pgprot);				   \
-	pte;								   \
-})
-
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	pte_val(pte) = (pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot);
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index c29a551eb0ca..d69cfa5a8ac6 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -504,12 +504,6 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 	return true;
 }
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- */
-#define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
-
 #if defined(CONFIG_XPA)
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
index eab87c6beacb..f490f2fa0dca 100644
--- a/arch/nios2/include/asm/pgtable.h
+++ b/arch/nios2/include/asm/pgtable.h
@@ -217,12 +217,6 @@ static inline void pte_clear(struct mm_struct *mm,
 	set_pte(ptep, null);
 }
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- */
-#define mk_pte(page, prot)	(pfn_pte(page_to_pfn(page), prot))
-
 /*
  * Conversion functions: convert a page and protection to a page entry,
  * and a page entry and page directory to the page they refer to.
diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index 60c6ce7ff2dc..71bfb8c8c482 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -299,8 +299,6 @@ static inline pte_t __mk_pte(void *page, pgprot_t pgprot)
 	return pte;
 }
 
-#define mk_pte(page, pgprot) __mk_pte(page_address(page), (pgprot))
-
 #define mk_pte_phys(physpage, pgprot) \
 ({                                                                      \
 	pte_t __pte;                                                    \
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index babf65751e81..4e87ebf08297 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -351,8 +351,6 @@ static inline pte_t pte_mkspecial(pte_t pte)	{ pte_val(pte) |= _PAGE_SPECIAL; re
 	__pte;								\
 })
 
-#define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
-
 static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot)
 {
 	pte_t pte;
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 264a6c09517a..f99cb39653f2 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -55,7 +55,6 @@ void set_ptes(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 
 /* Keep these as a macros to avoid include dependency mess */
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
-#define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
 
 static inline unsigned long pte_pfn(pte_t pte)
 {
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 089f3c9f56a3..b63196bfe61c 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -343,8 +343,6 @@ static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
 	return __pte((pfn << _PAGE_PFN_SHIFT) | prot_val);
 }
 
-#define mk_pte(page, prot)       pfn_pte(page_to_pfn(page), prot)
-
 static inline int pte_present(pte_t pte)
 {
 	return (pte_val(pte) & (_PAGE_PRESENT | _PAGE_PROT_NONE));
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 3fa280d0672a..6a21d947a687 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1422,6 +1422,7 @@ static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
 		__pte = pte_mkdirty(__pte);
 	return __pte;
 }
+#define mk_pte mk_pte
 
 #define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
 #define p4d_index(address) (((address) >> P4D_SHIFT) & (PTRS_PER_P4D-1))
diff --git a/arch/sh/include/asm/pgtable_32.h b/arch/sh/include/asm/pgtable_32.h
index f939f1215232..db2e48366e0d 100644
--- a/arch/sh/include/asm/pgtable_32.h
+++ b/arch/sh/include/asm/pgtable_32.h
@@ -380,14 +380,6 @@ PTE_BIT_FUNC(low, mkspecial, |= _PAGE_SPECIAL);
 
 #define pgprot_noncached	 pgprot_writecombine
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- *
- * extern pte_t mk_pte(struct page *page, pgprot_t pgprot)
- */
-#define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
-
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	pte.pte_low &= _PAGE_CHG_MASK;
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 62bcafe38b1f..531059cc2abb 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -255,7 +255,6 @@ static inline pte_t pte_mkyoung(pte_t pte)
 }
 
 #define PFN_PTE_SHIFT			(PAGE_SHIFT - 4)
-#define pfn_pte(pfn, prot)		mk_pte(pfn_to_page(pfn), prot)
 
 static inline unsigned long pte_pfn(pte_t pte)
 {
@@ -272,13 +271,9 @@ static inline unsigned long pte_pfn(pte_t pte)
 
 #define pte_page(pte)	pfn_to_page(pte_pfn(pte))
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- */
-static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
+static inline pte_t pfn_pte(struct page *page, pgprot_t pgprot)
 {
-	return __pte((page_to_pfn(page) << (PAGE_SHIFT-4)) | pgprot_val(pgprot));
+	return __pte((pfn << PFN_PTE_SHIFT) | pgprot_val(pgprot));
 }
 
 static inline pte_t mk_pte_phys(unsigned long page, pgprot_t pgprot)
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 3fe429d73a65..c7a4d0034b60 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -225,7 +225,6 @@ static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
 	BUILD_BUG_ON(_PAGE_SZBITS_4U != 0UL || _PAGE_SZBITS_4V != 0UL);
 	return __pte(paddr | pgprot_val(prot));
 }
-#define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline pmd_t pfn_pmd(unsigned long page_nr, pgprot_t pgprot)
diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
index 1647a7cc3fbf..c550ed288273 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -279,7 +279,6 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 #define pte_same(a,b)		(pte_val(a) == pte_val(b))
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 #define pfn_pte(pfn, prot)	__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
-#define mk_pte(page, prot)	pfn_pte(page_to_pfn(page), prot)
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 2289e9f7aa1b..8204ffd87d74 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -41,6 +41,13 @@
 #define FIRST_USER_ADDRESS	0UL
 #endif
 
+#ifndef mk_pte
+static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
+{
+	return pfn_pte(page_to_pfn(page), pgprot);
+}
+#endif
+
 /*
  * This defines the generic helper for accessing PMD page
  * table page. Although platforms can still override this
-- 
2.43.0


