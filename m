Return-Path: <linux-arch+bounces-15680-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F4BCFC423
	for <lists+linux-arch@lfdr.de>; Wed, 07 Jan 2026 07:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D60B430380D4
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jan 2026 06:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44C72356BE;
	Wed,  7 Jan 2026 06:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blb2kn1M"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3231FBEA8;
	Wed,  7 Jan 2026 06:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767768449; cv=none; b=axAzIwJaXkPTixWYGuHnzTdbtRJPrtkvkeK/xW+7DexrMQcqnUBB36w61w6FXaSIrQMW6xj2R0uW2QE9XRFuhV38uRDjkfLZEhcYXZSobSSKbm+PgXKJg9PE6Pee01w2TBAEvbofC1xKdueibZmLPneljljaCwfkl2iUplEt6HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767768449; c=relaxed/simple;
	bh=jSEOSuLKKjoqNykLsZDfxfJKeaPN38jpwwfYiidq2oM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eo61HVYVm0oJVZfUderSJZ/jjpvEZ+ptVMFpzo3VIcpmaH8smOZX/Y5S1zNKZEYg5UCprL0IzofDnj9kz533dHqe49EeQF1Bhbzlvws51c77eEVabBoeFTOjolFUgwPZ1T2iDadWQaKvlvflIcdY7a56qn8sSN/0gf6Yg0hOatA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blb2kn1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3C1C19421;
	Wed,  7 Jan 2026 06:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767768449;
	bh=jSEOSuLKKjoqNykLsZDfxfJKeaPN38jpwwfYiidq2oM=;
	h=From:To:Cc:Subject:Date:From;
	b=blb2kn1MYXUzKZZtujTYFlvCRJvxWiIx52V+b9W2UxnS3pipeRIdCXsYaI8Q0Txs2
	 y+CzSp4+UMQbNuYXcrD6BhQmS7jov2F5D8KRBveveqfLDvDadwaeW+iq/styMql7Ym
	 +A/2TvTzRUKZbKw7bp1rFLaq27hrZAdVLEK8B3VjixIM/BuyCccL3keulSxdPqFPHg
	 d3LMXSP+GR9By197xH1PdPxUIa4Egvrcvn8fgyEU8TDrhAHEqOPfefESS0OuX9Lghz
	 howsU2m2ZRFulfwU8gsJT6scEvW4YEwID48/AzSDM3hRrRjBs1wdGL0ev3z6GMIi84
	 IQrI5PPLNpskw==
From: alexs@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-alpha@vger.kernel.org (open list:ALPHA PORT),
	linux-kernel@vger.kernel.org (open list),
	linux-snps-arc@lists.infradead.org (open list:SYNOPSYS ARC ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
	linux-arch@vger.kernel.org (open list:MMU GATHER AND TLB INVALIDATION),
	linux-mm@kvack.org (open list:MMU GATHER AND TLB INVALIDATION),
	linux-csky@vger.kernel.org (open list:C-SKY ARCHITECTURE),
	linux-hexagon@vger.kernel.org (open list:QUALCOMM HEXAGON ARCHITECTURE),
	loongarch@lists.linux.dev (open list:LOONGARCH),
	linux-m68k@lists.linux-m68k.org (open list:M68K ARCHITECTURE),
	linux-mips@vger.kernel.org (open list:MIPS),
	linux-openrisc@vger.kernel.org (open list:OPENRISC ARCHITECTURE),
	linux-parisc@vger.kernel.org (open list:PARISC ARCHITECTURE),
	linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
	linux-sh@vger.kernel.org (open list:SUPERH),
	linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML))
Cc: linux-kernel@vger.kernel.org,
	Alex Shi <alexs@kernel.org>
Subject: [PATCH] mm/pgtable: convert pgtable_t to ptdesc pointer
Date: Wed,  7 Jan 2026 14:46:35 +0800
Message-ID: <20260107064642.15771-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

After struct ptdesc introduced, pgtable_t should used it instead of old
struct page pointer. The only thing in the way for this change is just
pgtable->lru in pgtable_trans_huge_deposit/withdraw.

Let's convert them into ptdesc and use struct ptdesc* as pgtable_t.
Thanks testing support from kernel test robot <lkp@intel.com>

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 arch/alpha/include/asm/page.h        |  2 +-
 arch/alpha/include/asm/pgalloc.h     |  2 +-
 arch/arc/include/asm/page.h          |  2 +-
 arch/arc/include/asm/pgalloc.h       |  2 +-
 arch/arm/include/asm/page.h          |  2 +-
 arch/arm/include/asm/pgalloc.h       |  6 +++---
 arch/arm/include/asm/tlb.h           |  4 +---
 arch/arm64/include/asm/page.h        |  2 +-
 arch/arm64/include/asm/pgalloc.h     |  2 +-
 arch/csky/include/asm/page.h         |  2 +-
 arch/csky/include/asm/pgalloc.h      |  2 +-
 arch/hexagon/include/asm/page.h      |  2 +-
 arch/hexagon/include/asm/pgalloc.h   |  2 +-
 arch/loongarch/include/asm/page.h    |  2 +-
 arch/loongarch/include/asm/pgalloc.h |  2 +-
 arch/m68k/include/asm/page.h         |  2 +-
 arch/microblaze/include/asm/page.h   |  2 +-
 arch/mips/include/asm/page.h         |  2 +-
 arch/mips/include/asm/pgalloc.h      |  2 +-
 arch/nios2/include/asm/page.h        |  2 +-
 arch/nios2/include/asm/pgalloc.h     |  2 +-
 arch/openrisc/include/asm/page.h     |  2 +-
 arch/parisc/include/asm/page.h       |  2 +-
 arch/riscv/include/asm/page.h        |  2 +-
 arch/riscv/include/asm/pgalloc.h     |  4 ++--
 arch/sh/include/asm/page.h           |  2 +-
 arch/sh/include/asm/pgalloc.h        |  2 +-
 arch/um/include/asm/page.h           |  2 +-
 arch/um/include/asm/pgalloc.h        |  8 ++++----
 arch/x86/include/asm/pgalloc.h       |  8 ++++----
 arch/x86/include/asm/pgtable_types.h |  2 +-
 arch/x86/mm/pgtable.c                |  6 +++---
 arch/xtensa/include/asm/page.h       |  2 +-
 arch/xtensa/include/asm/pgalloc.h    |  6 +++---
 include/asm-generic/pgalloc.h        |  8 +++-----
 include/linux/pgtable.h              |  2 +-
 mm/pgtable-generic.c                 | 15 ++++++---------
 37 files changed, 57 insertions(+), 64 deletions(-)

diff --git a/arch/alpha/include/asm/page.h b/arch/alpha/include/asm/page.h
index d2c6667d73e9..6edd9207f6bb 100644
--- a/arch/alpha/include/asm/page.h
+++ b/arch/alpha/include/asm/page.h
@@ -58,7 +58,7 @@ typedef unsigned long pgprot_t;
 
 #endif /* STRICT_MM_TYPECHECKS */
 
-typedef struct page *pgtable_t;
+typedef struct ptdesc *pgtable_t;
 
 #ifdef USE_48_BIT_KSEG
 #define PAGE_OFFSET		0xffff800000000000UL
diff --git a/arch/alpha/include/asm/pgalloc.h b/arch/alpha/include/asm/pgalloc.h
index 68be7adbfe58..11271b3e8186 100644
--- a/arch/alpha/include/asm/pgalloc.h
+++ b/arch/alpha/include/asm/pgalloc.h
@@ -16,7 +16,7 @@
 static inline void
 pmd_populate(struct mm_struct *mm, pmd_t *pmd, pgtable_t pte)
 {
-	pmd_set(pmd, (pte_t *)(page_to_pa(pte) + PAGE_OFFSET));
+	pmd_set(pmd, (pte_t *)(page_to_pa(ptdesc_page(pte)) + PAGE_OFFSET));
 }
 
 static inline void
diff --git a/arch/arc/include/asm/page.h b/arch/arc/include/asm/page.h
index 9720fe6b2c24..26bfc16e95ce 100644
--- a/arch/arc/include/asm/page.h
+++ b/arch/arc/include/asm/page.h
@@ -82,7 +82,7 @@ typedef struct {
 #define __pgprot(x)	((pgprot_t) { (x) })
 #define pte_pgprot(x)	__pgprot(pte_val(x))
 
-typedef struct page *pgtable_t;
+typedef struct ptdesc *pgtable_t;
 
 /*
  * When HIGHMEM is enabled we have holes in the memory map so we need
diff --git a/arch/arc/include/asm/pgalloc.h b/arch/arc/include/asm/pgalloc.h
index dfae070fe8d5..ff36debca073 100644
--- a/arch/arc/include/asm/pgalloc.h
+++ b/arch/arc/include/asm/pgalloc.h
@@ -48,7 +48,7 @@ pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
 
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, pgtable_t pte_page)
 {
-	set_pmd(pmd, __pmd((unsigned long)page_address(pte_page)));
+	set_pmd(pmd, __pmd((unsigned long)ptdesc_address(pte_page)));
 }
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index ef11b721230e..861804e56be7 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -173,7 +173,7 @@ extern void copy_page(void *to, const void *from);
 
 #endif /* CONFIG_MMU */
 
-typedef struct page *pgtable_t;
+typedef struct ptdesc *pgtable_t;
 
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
 extern int pfn_valid(unsigned long);
diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index a17f01235c29..1a3484c2df4c 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -96,12 +96,12 @@ pte_alloc_one(struct mm_struct *mm)
 {
 	struct page *pte;
 
-	pte = __pte_alloc_one(mm, GFP_PGTABLE_USER | PGTABLE_HIGHMEM);
+	pte = ptdesc_page(__pte_alloc_one(mm, GFP_PGTABLE_USER | PGTABLE_HIGHMEM));
 	if (!pte)
 		return NULL;
 	if (!PageHighMem(pte))
 		clean_pte_table(page_address(pte));
-	return pte;
+	return page_ptdesc(pte);
 }
 
 static inline void __pmd_populate(pmd_t *pmdp, phys_addr_t pte,
@@ -141,7 +141,7 @@ pmd_populate(struct mm_struct *mm, pmd_t *pmdp, pgtable_t ptep)
 	else
 		prot = _PAGE_USER_TABLE;
 
-	__pmd_populate(pmdp, page_to_phys(ptep), prot);
+	__pmd_populate(pmdp, page_to_phys(ptdesc_page(ptep)), prot);
 }
 
 #endif /* CONFIG_MMU */
diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index ea4fbe7b17f6..69e4c2728c58 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -32,8 +32,6 @@
 static inline void
 __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 {
-	struct ptdesc *ptdesc = page_ptdesc(pte);
-
 #ifndef CONFIG_ARM_LPAE
 	/*
 	 * With the classic ARM MMU, a pte page has two corresponding pmd
@@ -43,7 +41,7 @@ __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 	__tlb_adjust_range(tlb, addr - PAGE_SIZE, 2 * PAGE_SIZE);
 #endif
 
-	tlb_remove_ptdesc(tlb, ptdesc);
+	tlb_remove_ptdesc(tlb, pte);
 }
 
 static inline void
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 00f117ff4f7a..682323c095fb 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -39,7 +39,7 @@ bool tag_clear_highpages(struct page *to, int numpages);
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-typedef struct page *pgtable_t;
+typedef struct ptdesc *pgtable_t;
 
 int pfn_is_map_memory(unsigned long pfn);
 
diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 1b4509d3382c..ffaec59a5aca 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -117,7 +117,7 @@ static inline void
 pmd_populate(struct mm_struct *mm, pmd_t *pmdp, pgtable_t ptep)
 {
 	VM_BUG_ON(mm == &init_mm);
-	__pmd_populate(pmdp, page_to_phys(ptep),
+	__pmd_populate(pmdp, page_to_phys(ptdesc_page(ptep)),
 		       PMD_TYPE_TABLE | PMD_TABLE_AF | PMD_TABLE_PXN);
 }
 
diff --git a/arch/csky/include/asm/page.h b/arch/csky/include/asm/page.h
index 76774dbce869..fd2a3fe3a2cc 100644
--- a/arch/csky/include/asm/page.h
+++ b/arch/csky/include/asm/page.h
@@ -50,7 +50,7 @@ typedef struct { unsigned long pte_low; } pte_t;
 
 typedef struct { unsigned long pgd; } pgd_t;
 typedef struct { unsigned long pgprot; } pgprot_t;
-typedef struct page *pgtable_t;
+typedef struct ptdesc *pgtable_t;
 
 #define pgd_val(x)	((x).pgd)
 #define pgprot_val(x)	((x).pgprot)
diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index 9ed2b15ffd94..70c63b01f704 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -19,7 +19,7 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 					pgtable_t pte)
 {
-	set_pmd(pmd, __pmd(__pa(page_address(pte))));
+	set_pmd(pmd, __pmd(__pa(ptdesc_address(pte))));
 }
 
 extern void pgd_init(unsigned long *p);
diff --git a/arch/hexagon/include/asm/page.h b/arch/hexagon/include/asm/page.h
index 137ba7c5de48..0329b75b9f43 100644
--- a/arch/hexagon/include/asm/page.h
+++ b/arch/hexagon/include/asm/page.h
@@ -63,7 +63,7 @@
 typedef struct { unsigned long pte; } pte_t;
 typedef struct { unsigned long pgd; } pgd_t;
 typedef struct { unsigned long pgprot; } pgprot_t;
-typedef struct page *pgtable_t;
+typedef struct ptdesc *pgtable_t;
 
 #define pte_val(x)     ((x).pte)
 #define pgd_val(x)     ((x).pgd)
diff --git a/arch/hexagon/include/asm/pgalloc.h b/arch/hexagon/include/asm/pgalloc.h
index 937a11ef4c33..2b60882a5aac 100644
--- a/arch/hexagon/include/asm/pgalloc.h
+++ b/arch/hexagon/include/asm/pgalloc.h
@@ -48,7 +48,7 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 	 * Conveniently, zero in 3 LSB means indirect 4K page table.
 	 * Not so convenient when you're trying to vary the page size.
 	 */
-	set_pmd(pmd, __pmd(((unsigned long)page_to_pfn(pte) << PAGE_SHIFT) |
+	set_pmd(pmd, __pmd(((unsigned long)page_to_pfn(ptdesc_page(pte)) << PAGE_SHIFT) |
 		HEXAGON_L1_PTE_SIZE));
 }
 
diff --git a/arch/loongarch/include/asm/page.h b/arch/loongarch/include/asm/page.h
index 256d1ff7a1e3..479e01ddab9e 100644
--- a/arch/loongarch/include/asm/page.h
+++ b/arch/loongarch/include/asm/page.h
@@ -45,7 +45,7 @@ void copy_user_highpage(struct page *to, struct page *from,
 typedef struct { unsigned long pte; } pte_t;
 #define pte_val(x)	((x).pte)
 #define __pte(x)	((pte_t) { (x) })
-typedef struct page *pgtable_t;
+typedef struct ptdesc *pgtable_t;
 
 typedef struct { unsigned long pgd; } pgd_t;
 #define pgd_val(x)	((x).pgd)
diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
index 08dcc698ec18..d18f473b85d7 100644
--- a/arch/loongarch/include/asm/pgalloc.h
+++ b/arch/loongarch/include/asm/pgalloc.h
@@ -21,7 +21,7 @@ static inline void pmd_populate_kernel(struct mm_struct *mm,
 
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, pgtable_t pte)
 {
-	set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
+	set_pmd(pmd, __pmd((unsigned long)ptdesc_address(pte)));
 }
 
 #ifndef __PAGETABLE_PMD_FOLDED
diff --git a/arch/m68k/include/asm/page.h b/arch/m68k/include/asm/page.h
index d30f8b2f1592..ed0a7440f144 100644
--- a/arch/m68k/include/asm/page.h
+++ b/arch/m68k/include/asm/page.h
@@ -31,7 +31,7 @@ typedef struct { unsigned long pgprot; } pgprot_t;
  * definition. It would be possible to unify Sun3 and ColdFire pgalloc and have
  * all of m68k use the same type.
  */
-typedef struct page *pgtable_t;
+typedef struct ptdesc *pgtable_t;
 #else
 typedef pte_t *pgtable_t;
 #endif
diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm/page.h
index 90ac9f34b4b4..9e26f81304b4 100644
--- a/arch/microblaze/include/asm/page.h
+++ b/arch/microblaze/include/asm/page.h
@@ -52,7 +52,7 @@ typedef unsigned long pte_basic_t;
 /*
  * These are used to make use of C type-checking..
  */
-typedef struct page *pgtable_t;
+typedef struct ptdesc *pgtable_t;
 typedef struct { unsigned long	pte; }		pte_t;
 typedef struct { unsigned long	pgprot; }	pgprot_t;
 /* FIXME this can depend on linux kernel version */
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index bc3e3484c1bf..1844cc67a120 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -115,7 +115,7 @@ typedef struct { unsigned long pte; } pte_t;
 #define pte_val(x)	((x).pte)
 #define __pte(x)	((pte_t) { (x) } )
 #endif
-typedef struct page *pgtable_t;
+typedef struct ptdesc *pgtable_t;
 
 /*
  * Right now we don't support 4-level pagetables, so all pud-related
diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index 7a04381efa0b..c216d83307fe 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -26,7 +26,7 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 	pgtable_t pte)
 {
-	set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
+	set_pmd(pmd, __pmd((unsigned long)ptdesc_address(pte)));
 }
 
 /*
diff --git a/arch/nios2/include/asm/page.h b/arch/nios2/include/asm/page.h
index 00a51623d38a..37b6a5dfe417 100644
--- a/arch/nios2/include/asm/page.h
+++ b/arch/nios2/include/asm/page.h
@@ -52,7 +52,7 @@ extern void copy_user_page(void *vto, void *vfrom, unsigned long vaddr,
 /*
  * These are used to make use of C type-checking.
  */
-typedef struct page *pgtable_t;
+typedef struct ptdesc *pgtable_t;
 typedef struct { unsigned long pte; } pte_t;
 typedef struct { unsigned long pgd; } pgd_t;
 typedef struct { unsigned long pgprot; } pgprot_t;
diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
index db122b093a8b..b8253f280bdc 100644
--- a/arch/nios2/include/asm/pgalloc.h
+++ b/arch/nios2/include/asm/pgalloc.h
@@ -23,7 +23,7 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 	pgtable_t pte)
 {
-	set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
+	set_pmd(pmd, __pmd((unsigned long)ptdesc_address(pte)));
 }
 
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
diff --git a/arch/openrisc/include/asm/page.h b/arch/openrisc/include/asm/page.h
index 85797f94d1d7..2dcbfb1e88ae 100644
--- a/arch/openrisc/include/asm/page.h
+++ b/arch/openrisc/include/asm/page.h
@@ -45,7 +45,7 @@ typedef struct {
 typedef struct {
 	unsigned long pgprot;
 } pgprot_t;
-typedef struct page *pgtable_t;
+typedef struct ptdesc *pgtable_t;
 
 #define pte_val(x)	((x).pte)
 #define pgd_val(x)	((x).pgd)
diff --git a/arch/parisc/include/asm/page.h b/arch/parisc/include/asm/page.h
index 8f4e51071ea1..0df888a912df 100644
--- a/arch/parisc/include/asm/page.h
+++ b/arch/parisc/include/asm/page.h
@@ -83,7 +83,7 @@ typedef unsigned long pgprot_t;
 #define set_pud(pudptr, pudval) (*(pudptr) = (pudval))
 #endif
 
-typedef struct page *pgtable_t;
+typedef struct ptdesc *pgtable_t;
 
 typedef struct __physmem_range {
 	unsigned long start_pfn;
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index ffe213ad65a4..773118a79bd0 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -72,7 +72,7 @@ typedef struct {
 	unsigned long pgprot;
 } pgprot_t;
 
-typedef struct page *pgtable_t;
+typedef struct ptdesc *pgtable_t;
 
 #define pte_val(x)	((x).pte)
 #define pgd_val(x)	((x).pgd)
diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index 770ce18a7328..e75160571889 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -26,7 +26,7 @@ static inline void pmd_populate_kernel(struct mm_struct *mm,
 static inline void pmd_populate(struct mm_struct *mm,
 	pmd_t *pmd, pgtable_t pte)
 {
-	unsigned long pfn = virt_to_pfn(page_address(pte));
+	unsigned long pfn = virt_to_pfn(ptdesc_address(pte));
 
 	set_pmd(pmd, __pmd((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
 }
@@ -133,7 +133,7 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 				  unsigned long addr)
 {
-	tlb_remove_ptdesc(tlb, page_ptdesc(pte));
+	tlb_remove_ptdesc(tlb, pte);
 }
 #endif /* CONFIG_MMU */
 
diff --git a/arch/sh/include/asm/page.h b/arch/sh/include/asm/page.h
index def4205491ec..733a99a1d617 100644
--- a/arch/sh/include/asm/page.h
+++ b/arch/sh/include/asm/page.h
@@ -81,7 +81,7 @@ typedef struct { unsigned long pgd; } pgd_t;
 #define __pgd(x) ((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
-typedef struct page *pgtable_t;
+typedef struct ptdesc *pgtable_t;
 
 #define pte_pgprot(x) __pgprot(pte_val(x) & PTE_FLAGS_MASK)
 
diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index 6fe7123d38fa..0d465fbcb152 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -29,7 +29,7 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 				pgtable_t pte)
 {
-	set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
+	set_pmd(pmd, __pmd((unsigned long)ptdesc_address(pte)));
 }
 
 #define __pte_free_tlb(tlb, pte, addr)	\
diff --git a/arch/um/include/asm/page.h b/arch/um/include/asm/page.h
index 2d363460d896..7950e2d4185a 100644
--- a/arch/um/include/asm/page.h
+++ b/arch/um/include/asm/page.h
@@ -60,7 +60,7 @@ typedef unsigned long phys_t;
 
 typedef struct { unsigned long pgprot; } pgprot_t;
 
-typedef struct page *pgtable_t;
+typedef struct ptdesc *pgtable_t;
 
 #define pgd_val(x)	((x).pgd)
 #define pgprot_val(x)	((x).pgprot)
diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index 826ec44b58cd..59e96df72aa0 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -15,9 +15,9 @@
 #define pmd_populate_kernel(mm, pmd, pte) \
 	set_pmd(pmd, __pmd(_PAGE_TABLE + (unsigned long) __pa(pte)))
 
-#define pmd_populate(mm, pmd, pte) 				\
-	set_pmd(pmd, __pmd(_PAGE_TABLE +			\
-		((unsigned long long)page_to_pfn(pte) <<	\
+#define pmd_populate(mm, pmd, pte) 					\
+	set_pmd(pmd, __pmd(_PAGE_TABLE +				\
+		((unsigned long long)page_to_pfn(ptdesc_page(pte)) <<	\
 			(unsigned long long) PAGE_SHIFT)))
 
 /*
@@ -26,7 +26,7 @@
 extern pgd_t *pgd_alloc(struct mm_struct *);
 
 #define __pte_free_tlb(tlb, pte, address)	\
-	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
+	tlb_remove_ptdesc((tlb), pte)
 
 #if CONFIG_PGTABLE_LEVELS > 2
 
diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index c88691b15f3c..39ed61e6eccd 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -51,9 +51,9 @@ extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
 
 extern pgtable_t pte_alloc_one(struct mm_struct *);
 
-extern void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte);
+extern void ___pte_free_tlb(struct mmu_gather *tlb, struct ptdesc *pte);
 
-static inline void __pte_free_tlb(struct mmu_gather *tlb, struct page *pte,
+static inline void __pte_free_tlb(struct mmu_gather *tlb, struct ptdesc *pte,
 				  unsigned long address)
 {
 	___pte_free_tlb(tlb, pte);
@@ -74,9 +74,9 @@ static inline void pmd_populate_kernel_safe(struct mm_struct *mm,
 }
 
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
-				struct page *pte)
+				struct ptdesc *pte)
 {
-	unsigned long pfn = page_to_pfn(pte);
+	unsigned long pfn = page_to_pfn(ptdesc_page(pte));
 
 	paravirt_alloc_pte(mm, pfn);
 	set_pmd(pmd, __pmd(((pteval_t)pfn << PAGE_SHIFT) | _PAGE_TABLE));
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 2ec250ba467e..1252ec016f17 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -513,7 +513,7 @@ static inline pgprot_t pgprot_large_2_4k(pgprot_t pgprot)
 }
 
 
-typedef struct page *pgtable_t;
+typedef struct ptdesc *pgtable_t;
 
 extern pteval_t __supported_pte_mask;
 extern pteval_t __default_kernel_pte_mask;
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 2e5ecfdce73c..04ff98e3e8e8 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -18,10 +18,10 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
 	return __pte_alloc_one(mm, GFP_PGTABLE_USER);
 }
 
-void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
+void ___pte_free_tlb(struct mmu_gather *tlb, struct ptdesc *pte)
 {
-	paravirt_release_pte(page_to_pfn(pte));
-	tlb_remove_ptdesc(tlb, page_ptdesc(pte));
+	paravirt_release_pte(page_to_pfn(ptdesc_page(pte)));
+	tlb_remove_ptdesc(tlb, pte);
 }
 
 #if CONFIG_PGTABLE_LEVELS > 2
diff --git a/arch/xtensa/include/asm/page.h b/arch/xtensa/include/asm/page.h
index 20655174b111..720917fa216b 100644
--- a/arch/xtensa/include/asm/page.h
+++ b/arch/xtensa/include/asm/page.h
@@ -93,7 +93,7 @@
 typedef struct { unsigned long pte; } pte_t;		/* page table entry */
 typedef struct { unsigned long pgd; } pgd_t;		/* PGD table entry */
 typedef struct { unsigned long pgprot; } pgprot_t;
-typedef struct page *pgtable_t;
+typedef struct ptdesc *pgtable_t;
 
 #define pte_val(x)	((x).pte)
 #define pgd_val(x)	((x).pgd)
diff --git a/arch/xtensa/include/asm/pgalloc.h b/arch/xtensa/include/asm/pgalloc.h
index 1919ee9c3dd6..1b7111a29e1f 100644
--- a/arch/xtensa/include/asm/pgalloc.h
+++ b/arch/xtensa/include/asm/pgalloc.h
@@ -24,7 +24,7 @@
 #define pmd_populate_kernel(mm, pmdp, ptep)				     \
 	(pmd_val(*(pmdp)) = ((unsigned long)ptep))
 #define pmd_populate(mm, pmdp, page)					     \
-	(pmd_val(*(pmdp)) = ((unsigned long)page_to_virt(page)))
+	(pmd_val(*(pmdp)) = ((unsigned long)page_to_virt(ptdesc_page(page))))
 
 static inline pgd_t*
 pgd_alloc(struct mm_struct *mm)
@@ -53,12 +53,12 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 
 static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	struct page *page;
+	struct ptdesc *page;
 
 	page = __pte_alloc_one(mm, GFP_PGTABLE_USER);
 	if (!page)
 		return NULL;
-	ptes_clear(page_address(page));
+	ptes_clear(ptdesc_address(page));
 	return page;
 }
 
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 57137d3ac159..5fb31e0fe15f 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -81,7 +81,7 @@ static inline pgtable_t __pte_alloc_one_noprof(struct mm_struct *mm, gfp_t gfp)
 		return NULL;
 	}
 
-	return ptdesc_page(ptdesc);
+	return ptdesc;
 }
 #define __pte_alloc_one(...)	alloc_hooks(__pte_alloc_one_noprof(__VA_ARGS__))
 
@@ -111,11 +111,9 @@ static inline pgtable_t pte_alloc_one_noprof(struct mm_struct *mm)
  * @mm: the mm_struct of the current context
  * @pte_page: the `struct page` referencing the ptdesc
  */
-static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
+static inline void pte_free(struct mm_struct *mm, struct ptdesc *pte_page)
 {
-	struct ptdesc *ptdesc = page_ptdesc(pte_page);
-
-	pagetable_dtor_free(ptdesc);
+	pagetable_dtor_free(pte_page);
 }
 
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 652f287c1ef6..6f2c93d8e912 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -47,7 +47,7 @@
  * via their respective <asm/pgtable.h>.
  */
 #ifndef pmd_pgtable
-#define pmd_pgtable(pmd) pmd_page(pmd)
+#define pmd_pgtable(pmd) page_ptdesc(pmd_page(pmd))
 #endif
 
 #define pmd_folio(pmd) page_folio(pmd_page(pmd))
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index d3aec7a9926a..8a39be86764a 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -170,9 +170,9 @@ void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 
 	/* FIFO */
 	if (!pmd_huge_pte(mm, pmdp))
-		INIT_LIST_HEAD(&pgtable->lru);
+		INIT_LIST_HEAD(&pgtable->pt_list);
 	else
-		list_add(&pgtable->lru, &pmd_huge_pte(mm, pmdp)->lru);
+		list_add(&pgtable->pt_list, &pmd_huge_pte(mm, pmdp)->pt_list);
 	pmd_huge_pte(mm, pmdp) = pgtable;
 }
 #endif
@@ -187,10 +187,10 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 
 	/* FIFO */
 	pgtable = pmd_huge_pte(mm, pmdp);
-	pmd_huge_pte(mm, pmdp) = list_first_entry_or_null(&pgtable->lru,
-							  struct page, lru);
+	pmd_huge_pte(mm, pmdp) = list_first_entry_or_null(&pgtable->pt_list,
+							  struct ptdesc, pt_list);
 	if (pmd_huge_pte(mm, pmdp))
-		list_del(&pgtable->lru);
+		list_del(&pgtable->pt_list);
 	return pgtable;
 }
 #endif
@@ -247,10 +247,7 @@ static void pte_free_now(struct rcu_head *head)
 
 void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
 {
-	struct page *page;
-
-	page = pgtable;
-	call_rcu(&page->rcu_head, pte_free_now);
+	call_rcu(&pgtable->pt_rcu_head, pte_free_now);
 }
 #endif /* pte_free_defer */
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-- 
2.43.0


