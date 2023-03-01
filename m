Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF326A70AB
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 17:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCAQRM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Mar 2023 11:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjCAQRL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2023 11:17:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF292CC5B;
        Wed,  1 Mar 2023 08:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r4yRxsyjEc1VgxQqaMv5T8Q6fGJDXSNJgN02dz9+RN8=; b=GHNhxO3vzlp8y2VXNOy0x836JG
        lAg6k6Oj7mWyKYzCebVyBGkYX04FkPUFpo+cl2nn9dSW79eGp0YfxE4EgANWEMzA4HpZwebmfKtkX
        sUwBEJl8RlMrijtGzbxjFFvuZE8SU8AmbOOqAiIvu9RUVIovi3lfPjpH729tDT79KoVFfygWE9Jcl
        Pe52lcIKRTKbzibHDbHPxScrJ8fDWPCbP/ZRVcDib6Sw6nUCWsj1td4rvfsmYDGpmz64u9CvEQp+Y
        cP44Y+8YvfjwPIZKM+0tCqtX5cDiTL52++ELhMAuISaQpviFnjpnoVF6X9Hj8nLH4P08eI/ok2zjn
        fYJqc/pA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXP8b-001jj8-QL; Wed, 01 Mar 2023 16:17:05 +0000
Date:   Wed, 1 Mar 2023 16:17:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org
Subject: Re: [PATCH v3 22/34] superh: Implement the new page table range API
Message-ID: <Y/96gfG1vpfdTzZO@casper.infradead.org>
References: <20230228213738.272178-1-willy@infradead.org>
 <20230228213738.272178-23-willy@infradead.org>
 <CAMuHMdVY9VSZ57g-RXpDVBigfKJZLyF5wuyRsbmOm6d+m08OEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVY9VSZ57g-RXpDVBigfKJZLyF5wuyRsbmOm6d+m08OEA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 01, 2023 at 09:06:16AM +0100, Geert Uytterhoeven wrote:
> > -               } else
> > -                       __flush_purge_region((void *)addr, PAGE_SIZE);
> > +               } else
> 
> Trailing whitespace. Please run scripts/checkpath.pl (on the full series).

Thanks.  It's pretty noisy and I don't intend to clean up many of
those warnings, but it did find some legit problems.

I'll squash these fixes into v4.

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index bf1263ff7e67..45e5282f406c 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -45,7 +45,7 @@ void set_ptes(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 		pte_t pte, unsigned int nr);
 #define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
 #define update_mmu_cache(vma, addr, ptep) \
-	update_mmu_cache_range(vma, addr, ptep, 1);
+	update_mmu_cache_range(vma, addr, ptep, 1)
 
 #ifndef MAX_PTRS_PER_PGD
 #define MAX_PTRS_PER_PGD PTRS_PER_PGD
diff --git a/arch/sh/mm/cache.c b/arch/sh/mm/cache.c
index 93fc5fb8ec1c..9bcaa5619eab 100644
--- a/arch/sh/mm/cache.c
+++ b/arch/sh/mm/cache.c
@@ -169,7 +169,7 @@ void __flush_anon_page(struct page *page, unsigned long vmaddr)
 			/* XXX.. For now kunmap_coherent() does a purge */
 			/* __flush_purge_region((void *)kaddr, PAGE_SIZE); */
 			kunmap_coherent(kaddr);
-		} else 
+		} else
 			__flush_purge_region(folio_address(folio),
 						folio_size(folio));
 	}
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index d5c0088e0c6a..0c30b0eb6c57 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -924,7 +924,7 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 	}
 }
 
-#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1);
+#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
 
 #define pte_clear(mm,addr,ptep)		\
 	set_pte_at((mm), (addr), (ptep), __pte(0UL))
diff --git a/arch/xtensa/mm/cache.c b/arch/xtensa/mm/cache.c
index 65c0d5298041..27bd798e4d89 100644
--- a/arch/xtensa/mm/cache.c
+++ b/arch/xtensa/mm/cache.c
@@ -254,7 +254,7 @@ void update_mmu_cache_range(struct vm_area_struct *vma, unsigned long addr,
 			void *paddr = kmap_local_folio(folio, i * PAGE_SIZE);
 			__flush_dcache_page((unsigned long)paddr);
 			__invalidate_icache_page((unsigned long)paddr);
-			kunmap_atomic(paddr);
+			kunmap_local(paddr);
 		}
 		set_bit(PG_arch_1, &folio->flags);
 	}

> > +                       __flush_purge_region(folio_address(folio),
> > +                                               folio_size(folio));
> >         }
> >  }
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
