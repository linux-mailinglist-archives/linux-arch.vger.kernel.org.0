Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707F96BBDFC
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 21:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjCOUd3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 16:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjCOUd2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 16:33:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC32741098;
        Wed, 15 Mar 2023 13:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=5K3MTIiWRAke5f5Y30usc/ns7fPnYLy4udBXjthSldA=; b=WFbMM+6P427s5nnGrau486ysU5
        ZZPHk0mYbRO/vW57prDzEzvDaq2TNPTKxnxKTIniIC9zs/IDY1thLp5tZ5wcykn7EhTwAqV/mm3Sr
        zJnNhILkZnjCOGcdzX8OLHb1i3ftX4UrPvU1h3esz0SZA3+anzwFxsQu4qh5RzdEvQtODAqNVzxOU
        o5PimTbgRXiH8NV273zWWnMX86kUTZSnImz8hUEvHLlQpHdxHzbLDUyapN0+mGTKmncZEdy0yA0u8
        m1TGRY09SRGYl+W6qy5bBIHPWtdlc7XiQeSxq82uvCfdvbx6pfDzSOJPlFJ9sJECo1yidGFrn7xEa
        AjnBKyCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcXoH-00E9oi-Um; Wed, 15 Mar 2023 20:33:22 +0000
Date:   Wed, 15 Mar 2023 20:33:21 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v4 16/36] mips: Implement the new page table range API
Message-ID: <ZBIrkW5EB/uHj4sm@casper.infradead.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-17-willy@infradead.org>
 <20230315105022.GA9850@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230315105022.GA9850@alpha.franken.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 11:50:22AM +0100, Thomas Bogendoerfer wrote:
> On Wed, Mar 15, 2023 at 05:14:24AM +0000, Matthew Wilcox (Oracle) wrote:
> > Rename _PFN_SHIFT to PFN_PTE_SHIFT.  Convert a few places
> > to call set_pte() instead of set_pte_at().  Add set_ptes(),
> > update_mmu_cache_range(), flush_icache_pages() and flush_dcache_folio().
> 
> /local/tbogendoerfer/korg/linux/mm/memory.c: In function ‘set_pte_range’:
> /local/tbogendoerfer/korg/linux/mm/memory.c:4290:2: error: implicit declaration of function ‘update_mmu_cache_range’ [-Werror=implicit-function-declaration]
>   update_mmu_cache_range(vma, addr, vmf->pte, nr);
> 
> update_mmu_cache_range() is missing in this patch.

Oops.  And mips was one of the arches I did a test build for!

Looks like we could try to gain some efficiency by passing 'nr' to
__update_tlb(), but as far as I can tell, that's only called for r3k and
r4k, so maybe it's not worth optimising at this point?  Anyway, this
add-on makes the mips build compile for me and I'll fold it into v5.

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index cfcd6a8ba8ef..9f51b0813dc6 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -578,12 +578,20 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 extern void __update_tlb(struct vm_area_struct *vma, unsigned long address,
 	pte_t pte);
 
-static inline void update_mmu_cache(struct vm_area_struct *vma,
-	unsigned long address, pte_t *ptep)
+static inline void update_mmu_cache_range(struct vm_area_struct *vma,
+		unsigned long address, pte_t *ptep, unsigned int nr)
 {
-	pte_t pte = *ptep;
-	__update_tlb(vma, address, pte);
+	for (;;) {
+		pte_t pte = *ptep;
+		__update_tlb(vma, address, pte);
+		if (--nr == 0)
+			break;
+		ptep++;
+		address += PAGE_SIZE;
+	}
 }
+#define update_mmu_cache(vma, address, ptep) \
+	update_mmu_cache_range(vma, address, ptep, 1)
 
 #define	__HAVE_ARCH_UPDATE_MMU_TLB
 #define update_mmu_tlb	update_mmu_cache
