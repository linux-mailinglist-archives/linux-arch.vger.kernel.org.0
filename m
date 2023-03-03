Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96246A9952
	for <lists+linux-arch@lfdr.de>; Fri,  3 Mar 2023 15:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjCCOUA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Mar 2023 09:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCCOT7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2023 09:19:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E24113F5;
        Fri,  3 Mar 2023 06:19:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C1ABB818E3;
        Fri,  3 Mar 2023 14:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D8FC433D2;
        Fri,  3 Mar 2023 14:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677853193;
        bh=lBpaM/0Pumc/hglX6VD/VFO2r5wVz8rcWE4RZr/Vsk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Upt4fahYn5DUadRsqJm+Kv+aQ+jx4VuxLbyXy7lEM/4TjmHVeqmp9CIDuMBsKuoAu
         CqV7NXDk1b3QbJVzbe7XmfERz/vsgVByhCixkX7iYKHjOIFiK+nuim14ec39HE88JV
         5RoWqQDrojBFySv+CvnU9dQFxw/7CiWTZgFG19bW0h0Cn98jW1cj+Rd1FSOZXmAj2U
         UziigVKs8og/epEDnEvAum0vb6CEnpYvsiVZD76JrKcZoruL390O1slwGvnjdFBSCA
         ElEJqQgKJORiNaZ7TMCoSwXnvWP2s22+TK7FGejBAPYh2XvfVI/bVX6LmkUKc4Octi
         BuoNYBIDNmDtA==
Date:   Fri, 3 Mar 2023 16:19:40 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/34] New page table range API
Message-ID: <ZAIB/A9zENYz/cJq@kernel.org>
References: <20230228213738.272178-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228213738.272178-1-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 28, 2023 at 09:37:03PM +0000, Matthew Wilcox (Oracle) wrote:
> This patchset changes the API used by the MM to set up page table entries.
> The four APIs are:
>     set_ptes(mm, addr, ptep, pte, nr)
>     update_mmu_cache_range(vma, addr, ptep, nr)
>     flush_dcache_folio(folio)
>     flush_icache_pages(vma, page, nr)
> 
> flush_dcache_folio() isn't technically new, but no architecture
> implemented it, so I've done that for you.  The old APIs remain around
> but are mostly implemented by calling the new interfaces.
> 
> The new APIs are based around setting up N page table entries at once.
> The N entries belong to the same PMD, the same folio and the same VMA,
> so ptep++ is a legitimate operation, and locking is taken care of for
> you.  Some architectures can do a better job of it than just a loop,
> but I have hesitated to make too deep a change to architectures I don't
> understand well.

The new set_ptes() looks unnecessarily duplicated all over arch/
What do you say about adding the patch below on top of the series?
Ideally it should be split into per-arch bits, but I can send it separately
as a cleanup on top.

diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 1e3354e9731b..65fb9e66675d 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -37,6 +37,7 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		pte_val(pte) += 1UL << 32;
 	}
 }
+#define set_ptes set_ptes
 #define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
 
 /* PMD_SHIFT determines the size of the area a second-level page table can map */
diff --git a/arch/arc/include/asm/pgtable-bits-arcv2.h b/arch/arc/include/asm/pgtable-bits-arcv2.h
index 4a1b2ce204c6..06d8039180c0 100644
--- a/arch/arc/include/asm/pgtable-bits-arcv2.h
+++ b/arch/arc/include/asm/pgtable-bits-arcv2.h
@@ -100,19 +100,6 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
 }
 
-static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
-		pte_t *ptep, pte_t pte, unsigned int nr)
-{
-	for (;;) {
-		set_pte(ptep, pte);
-		if (--nr == 0)
-			break;
-		ptep++;
-		pte_val(pte) += PAGE_SIZE;
-	}
-}
-#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
-
 void update_mmu_cache_range(struct vm_area_struct *vma, unsigned long address,
 		      pte_t *ptep, unsigned int nr);
 
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 6525ac82bd50..0d326b201797 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -209,6 +209,7 @@ extern void __sync_icache_dcache(pte_t pteval);
 
 void set_ptes(struct mm_struct *mm, unsigned long addr,
 		      pte_t *ptep, pte_t pteval, unsigned int nr);
+#define set_ptes set_ptes
 #define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
 
 static inline pte_t clear_pte_bit(pte_t pte, pgprot_t prot)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 4d1b79dbff16..a8d6460c5c9f 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -369,6 +369,7 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		pte_val(pte) += PAGE_SIZE;
 	}
 }
+#define set_ptes set_ptes
 #define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
 
 /*
diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index a30ae048233e..e426f1820deb 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -91,20 +91,6 @@ static inline void set_pte(pte_t *p, pte_t pte)
 	smp_mb();
 }
 
-static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
-		pte_t *ptep, pte_t pte, unsigned int nr)
-{
-	for (;;) {
-		set_pte(ptep, pte);
-		if (--nr == 0)
-			break;
-		ptep++;
-		pte_val(pte) += PAGE_SIZE;
-	}
-}
-
-#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
-
 static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 {
 	unsigned long ptr;
diff --git a/arch/hexagon/include/asm/pgtable.h b/arch/hexagon/include/asm/pgtable.h
index f58f1d920769..67ab91662e83 100644
--- a/arch/hexagon/include/asm/pgtable.h
+++ b/arch/hexagon/include/asm/pgtable.h
@@ -345,26 +345,6 @@ static inline int pte_exec(pte_t pte)
 #define pte_pfn(pte) (pte_val(pte) >> PAGE_SHIFT)
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
 
-/*
- * set_ptes - update page table and do whatever magic may be
- * necessary to make the underlying hardware/firmware take note.
- *
- * VM may require a virtual instruction to alert the MMU.
- */
-static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
-		pte_t *ptep, pte_t pte, unsigned int nr)
-{
-	for (;;) {
-		set_pte(ptep, pte);
-		if (--nr == 0)
-			break;
-		ptep++;
-		pte_val(pte) += PAGE_SIZE;
-	}
-}
-
-#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
-
 static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 {
 	return (unsigned long)__va(pmd_val(pmd) & PAGE_MASK);
diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
index 0c2be4ea664b..65a6e3b30721 100644
--- a/arch/ia64/include/asm/pgtable.h
+++ b/arch/ia64/include/asm/pgtable.h
@@ -303,19 +303,6 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 	*ptep = pteval;
 }
 
-static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
-		pte_t *ptep, pte_t pte, unsigned int nr)
-{
-	for (;;) {
-		set_pte(ptep, pte);
-		if (--nr == 0)
-			break;
-		ptep++;
-		pte_val(pte) += PAGE_SIZE;
-	}
-}
-#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, add, ptep, pte, 1)
-
 /*
  * Make page protection values cacheable, uncacheable, or write-
  * combining.  Note that "protection" is really a misnomer here as the
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 9154d317ffb4..d4b0ca7b4bf7 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -346,6 +346,7 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 	}
 }
 
+#define set_ptes set_ptes
 #define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
 
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
diff --git a/arch/m68k/include/asm/pgtable_mm.h b/arch/m68k/include/asm/pgtable_mm.h
index 400206c17c97..8c2db20abdb6 100644
--- a/arch/m68k/include/asm/pgtable_mm.h
+++ b/arch/m68k/include/asm/pgtable_mm.h
@@ -32,20 +32,6 @@
 		*(pteptr) = (pteval);				\
 	} while(0)
 
-static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
-		pte_t *ptep, pte_t pte, unsigned int nr)
-{
-	for (;;) {
-		set_pte(ptep, pte);
-		if (--nr == 0)
-			break;
-		ptep++;
-		pte_val(pte) += PAGE_SIZE;
-	}
-}
-
-#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
-
 /* PMD_SHIFT determines the size of the area a second-level page table can map */
 #if CONFIG_PGTABLE_LEVELS == 3
 #define PMD_SHIFT	18
diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index a01e1369b486..3e7643a986ad 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -335,20 +335,6 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 	*ptep = pte;
 }
 
-static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
-		pte_t *ptep, pte_t pte, unsigned int nr)
-{
-	for (;;) {
-		set_pte(ptep, pte);
-		if (--nr == 0)
-			break;
-		ptep++;
-		pte_val(pte) += 1 << PFN_SHIFT_OFFSET;
-	}
-}
-
-#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
-
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 		unsigned long address, pte_t *ptep)
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 0cf0455e6ae8..18b77567ef72 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -108,6 +108,7 @@ do {									\
 static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		pte_t *ptep, pte_t pte, unsigned int nr);
 
+#define set_ptes set_ptes
 #define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
 
 #if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
index 8a77821a17a5..2a994b225a41 100644
--- a/arch/nios2/include/asm/pgtable.h
+++ b/arch/nios2/include/asm/pgtable.h
@@ -193,6 +193,7 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 	}
 }
 
+#define set_ptes set_ptes
 #define set_pte_at(mm, addr, ptep, pte)	set_ptes(mm, addr, ptep, pte, 1)
 
 static inline int pmd_none(pmd_t pmd)
diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index 1a7077150d7b..8f27730a9ab7 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -47,20 +47,6 @@ extern void paging_init(void);
  */
 #define set_pte(pteptr, pteval) ((*(pteptr)) = (pteval))
 
-static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
-		pte_t *ptep, pte_t pte, unsigned int nr)
-{
-	for (;;) {
-		set_pte(ptep, pte);
-		if (--nr == 0)
-			break;
-		ptep++;
-		pte_val(pte) += PAGE_SIZE;
-	}
-}
-
-#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
-
 /*
  * (pmds are folded into pgds so this doesn't get actually called,
  * but the define is needed for a generic inline function.)
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index 78ee9816f423..cd04e85cb012 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -73,6 +73,7 @@ extern void __update_cache(pte_t pte);
 		mb();				\
 	} while(0)
 
+#define set_ptes set_ptes
 #define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index bf1263ff7e67..f10b6c2f8ade 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -43,6 +43,7 @@ struct mm_struct;
 
 void set_ptes(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 		pte_t pte, unsigned int nr);
+#define set_ptes set_ptes
 #define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
 #define update_mmu_cache(vma, addr, ptep) \
 	update_mmu_cache_range(vma, addr, ptep, 1);
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 3a3a776fc047..8bc49496f8a6 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -473,6 +473,7 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		pte_val(pteval) += 1 << _PAGE_PFN_SHIFT;
 	}
 }
+#define set_ptes set_ptes
 #define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
 
 static inline void pte_clear(struct mm_struct *mm,
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 46bf475116f1..2fc20558af6b 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1346,6 +1346,7 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 	}
 }
 
+#define set_ptes set_ptes
 #define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
 
 /*
diff --git a/arch/sh/include/asm/pgtable_32.h b/arch/sh/include/asm/pgtable_32.h
index 03ba1834e126..d2f17e944bea 100644
--- a/arch/sh/include/asm/pgtable_32.h
+++ b/arch/sh/include/asm/pgtable_32.h
@@ -319,6 +319,7 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 	}
 }
 
+#define set_ptes set_ptes
 #define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
 
 /*
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 47ae55ea1837..7fbc7772a9b7 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -101,20 +101,6 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 	srmmu_swap((unsigned long *)ptep, pte_val(pteval));
 }
 
-static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
-		pte_t *ptep, pte_t pte, unsigned int nr)
-{
-	for (;;) {
-		set_pte(ptep, pte);
-		if (--nr == 0)
-			break;
-		ptep++;
-		pte_val(pte) += PAGE_SIZE;
-	}
-}
-
-#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
-
 static inline int srmmu_device_memory(unsigned long x)
 {
 	return ((x & 0xF0000000) != 0);
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index d5c0088e0c6a..fddca662ba1b 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -924,6 +924,7 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 	}
 }
 
+#define set_ptes set_ptes
 #define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1);
 
 #define pte_clear(mm,addr,ptep)		\
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index ca78c90ae74f..60d2b20ff218 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -242,20 +242,6 @@ static inline void set_pte(pte_t *pteptr, pte_t pteval)
 	if(pte_present(*pteptr)) *pteptr = pte_mknewprot(*pteptr);
 }
 
-static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
-		pte_t *ptep, pte_t pte, unsigned int nr)
-{
-	for (;;) {
-		set_pte(ptep, pte);
-		if (--nr == 0)
-			break;
-		ptep++;
-		pte_val(pte) += PAGE_SIZE;
-	}
-}
-
-#define set_pte_at(mm, addr, ptep, pte)	set_ptes(mm, addr, ptep, pte, 1)
-
 #define __HAVE_ARCH_PTE_SAME
 static inline int pte_same(pte_t pte_a, pte_t pte_b)
 {
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index f424371ea143..1e5fd352880d 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1019,22 +1019,6 @@ static inline pud_t native_local_pudp_get_and_clear(pud_t *pudp)
 	return res;
 }
 
-static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep, pte_t pte, unsigned int nr)
-{
-	page_table_check_ptes_set(mm, addr, ptep, pte, nr);
-
-	for (;;) {
-		set_pte(ptep, pte);
-		if (--nr == 0)
-			break;
-		ptep++;
-		pte = __pte(pte_val(pte) + PAGE_SIZE);
-	}
-}
-
-#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
-
 static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 			      pmd_t *pmdp, pmd_t pmd)
 {
diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
index 293101530541..adeee96518b9 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -306,20 +306,6 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 	update_pte(ptep, pte);
 }
 
-static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
-		pte_t *ptep, pte_t pte, unsigned int nr)
-{
-	for (;;) {
-		set_pte(ptep, pte);
-		if (--nr == 0)
-			break;
-		ptep++;
-		pte_val(pte) += PAGE_SIZE;
-	}
-}
-
-#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
-
 static inline void
 set_pmd(pmd_t *pmdp, pmd_t pmdval)
 {
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index c63cd44777ec..ef204712eda3 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -172,6 +172,24 @@ static inline int pmd_young(pmd_t pmd)
 }
 #endif
 
+#ifndef set_ptes
+static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+			    pte_t *ptep, pte_t pte, unsigned int nr)
+{
+	page_table_check_ptes_set(mm, addr, ptep, pte, nr);
+
+	for (;;) {
+		set_pte(ptep, pte);
+		if (--nr == 0)
+			break;
+		ptep++;
+		pte = __pte(pte_val(pte) + PAGE_SIZE);
+	}
+}
+#define set_ptes set_ptes
+#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 extern int ptep_set_access_flags(struct vm_area_struct *vma,
 				 unsigned long address, pte_t *ptep,

-- 
Sincerely yours,
Mike.
