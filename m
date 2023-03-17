Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB106BDFC8
	for <lists+linux-arch@lfdr.de>; Fri, 17 Mar 2023 04:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjCQDrd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Mar 2023 23:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCQDrb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Mar 2023 23:47:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE5A4D612;
        Thu, 16 Mar 2023 20:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c7wCPnTYsAnlfuIokTLL9knDc3TDHOWbd7SBJp4vaMs=; b=f4qI0D9DNEzkqjlnTioR+D/xhI
        2py+6WNtERCXix1QSkoRJuQCDr//5QCi9K71m5Oy/+1cK2xS78ggJEcDqJ/gonCjWg+4skRGJDJfI
        /hAqjxmdNTeAz/lVMSH8RrAzxj0PLAtp8n5L/zdUuCFVo2DjNamDKYdwG7xJrZxSHajjRv8Os8svG
        J4bk7zrQqv3DQsc5dUUwb1yJIIlKGT/apn4VQ/Znx0Ec5yCTHxUBKPKPMVsRitqrZCS5th2ZO7Bs6
        0qkjmcfpugdNUfSjIIs1/1wgaMeUe3NXr8LxWKdhX3Atk3W217rB8y2E7o5I0Hi69YiYKw/m+u6Xg
        qp5ccBeg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pd13s-00FTEN-5i; Fri, 17 Mar 2023 03:47:24 +0000
Date:   Fri, 17 Mar 2023 03:47:24 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v4 20/36] powerpc: Implement the new page table range API
Message-ID: <ZBPizB6TmDp0psOl@casper.infradead.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-21-willy@infradead.org>
 <1743d96f-8efe-0127-2cae-7368ce0eb2e6@csgroup.eu>
 <c7f08247-8bcd-184c-5e06-91f91257f1f6@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7f08247-8bcd-184c-5e06-91f91257f1f6@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 10:18:22AM +0000, Christophe Leroy wrote:
> I investigated a bit further and can confirm now that the above won't 
> always work, see comment 
> https://elixir.bootlin.com/linux/v6.3-rc2/source/arch/powerpc/include/asm/nohash/32/pgtable.h#L147
> 
> And then you see 
> https://elixir.bootlin.com/linux/v6.3-rc2/source/arch/powerpc/include/asm/nohash/pte-e500.h#L63

Got it.  Here's what I intend to fold in for the next version:

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 7bf1fe7297c6..5f12b9382909 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -462,11 +462,6 @@ static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot)
 		     pgprot_val(pgprot));
 }
 
-static inline unsigned long pte_pfn(pte_t pte)
-{
-	return pte_val(pte) >> PTE_RPN_SHIFT;
-}
-
 /* Generic modifiers for PTE bits */
 static inline pte_t pte_wrprotect(pte_t pte)
 {
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 4acc9690f599..c5baa3082a5a 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -104,6 +104,7 @@
  * and every thing below PAGE_SHIFT;
  */
 #define PTE_RPN_MASK	(((1UL << _PAGE_PA_MAX) - 1) & (PAGE_MASK))
+#define PTE_RPN_SHIFT	PAGE_SHIFT
 /*
  * set of bits not changed in pmd_modify. Even though we have hash specific bits
  * in here, on radix we expect them to be zero.
@@ -569,11 +570,6 @@ static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot)
 	return __pte(((pte_basic_t)pfn << PAGE_SHIFT) | pgprot_val(pgprot) | _PAGE_PTE);
 }
 
-static inline unsigned long pte_pfn(pte_t pte)
-{
-	return (pte_val(pte) & PTE_RPN_MASK) >> PAGE_SHIFT;
-}
-
 /* Generic modifiers for PTE bits */
 static inline pte_t pte_wrprotect(pte_t pte)
 {
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 69a7dd47a9f0..03be8b22aaea 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -101,8 +101,6 @@ static inline bool pte_access_permitted(pte_t pte, bool write)
 static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot) {
 	return __pte(((pte_basic_t)(pfn) << PTE_RPN_SHIFT) |
 		     pgprot_val(pgprot)); }
-static inline unsigned long pte_pfn(pte_t pte)	{
-	return pte_val(pte) >> PTE_RPN_SHIFT; }
 
 /* Generic modifiers for PTE bits */
 static inline pte_t pte_exprotect(pte_t pte)
@@ -279,7 +277,7 @@ static inline int pud_huge(pud_t pud)
 void update_mmu_cache_range(struct vm_area_struct *vma, unsigned long address,
 		pte_t *ptep, unsigned int nr);
 #else
-static inline void update_mmu_cache(struct vm_area_struct *vma,
+static inline void update_mmu_cache_range(struct vm_area_struct *vma,
 		unsigned long address, pte_t *ptep, unsigned int nr) {}
 #endif
 
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 656ecf2b10cd..491a2720f835 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -54,6 +54,12 @@ void set_ptes(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 /* Keep these as a macros to avoid include dependency mess */
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 #define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
+
+static inline unsigned long pte_pfn(pte_t pte)
+{
+	return (pte_val(pte) & PTE_RPN_MASK) >> PTE_RPN_SHIFT;
+}
+
 /*
  * Select all bits except the pfn
  */
diff --git a/arch/powerpc/mm/nohash/e500_hugetlbpage.c b/arch/powerpc/mm/nohash/e500_hugetlbpage.c
index f3cb91107a47..583b3098763f 100644
--- a/arch/powerpc/mm/nohash/e500_hugetlbpage.c
+++ b/arch/powerpc/mm/nohash/e500_hugetlbpage.c
@@ -178,7 +178,7 @@ book3e_hugetlb_preload(struct vm_area_struct *vma, unsigned long ea, pte_t pte)
  *
  * This must always be called with the pte lock held.
  */
-void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
+void update_mmu_cache_range(struct vm_area_struct *vma, unsigned long address,
 		pte_t *ptep, unsigned int nr)
 {
 	if (is_vm_hugetlb_page(vma))
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index b3c7b874a7a2..db236b494845 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -208,7 +208,7 @@ void set_ptes(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 		if (--nr == 0)
 			break;
 		ptep++;
-		pte = __pte(pte_val(pte) + PAGE_SIZE);
+		pte = __pte(pte_val(pte) + (1UL << PTE_RPN_SHIFT));
 		addr += PAGE_SIZE;
 	}
 }
