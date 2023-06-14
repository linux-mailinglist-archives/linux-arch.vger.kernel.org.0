Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450277303BF
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jun 2023 17:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244599AbjFNPYS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jun 2023 11:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbjFNPYO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 11:24:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228781FDD;
        Wed, 14 Jun 2023 08:24:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 707EB643AA;
        Wed, 14 Jun 2023 15:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFE1C433C0;
        Wed, 14 Jun 2023 15:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686756250;
        bh=DYUjdElx66wwW56gbS6Oam3+Ri1YVeFJgUO5WJxkfRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F2VfAIa6x+BTq6Vf7GKpNIQ4VRxhW1RinP9K8UayobTe9Tk8E5+Sq7cmwZZRn0d1y
         26CB8picqZJFxo5+mLk+dJnultBctEPc1n6TEIPPARJJzXHv+f/Pgy45b2HV/isl3Y
         gb/2jcktaHSMftse5jDK8hl+l0HD7oQErPJyL7pw0t1TXRYQmrQl+fKIONYs1PTSvS
         z8NvkUUtJo2edNsOz3fzHHy16sEmRifJKVrKC5RW3D9o58C7GKLfTiOHZj9zfeqH0l
         Z6HqMiy17H4r/WPjR88En22k7c9F1SxwlZ7LkQb5J7xPFN1zqBm3yUfunH4M/rparU
         rulVeBuEQZAuA==
Date:   Wed, 14 Jun 2023 18:23:33 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v4 34/34] mm: Remove pgtable_{pmd, pte}_page_{ctor,
 dtor}() wrappers
Message-ID: <20230614152333.GG52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-35-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230612210423.18611-35-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 12, 2023 at 02:04:23PM -0700, Vishal Moola (Oracle) wrote:
> These functions are no longer necessary. Remove them and cleanup
> Documentation referencing them.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

I've found one stale reference in riscv:

$ git grep -n pgtable_pmd_page_ctor
arch/riscv/mm/init.c:440:       BUG_ON(!vaddr || !pgtable_pmd_page_ctor(virt_to_page(vaddr)));

Otherwise

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>


> ---
>  Documentation/mm/split_page_table_lock.rst    | 12 +++++------
>  .../zh_CN/mm/split_page_table_lock.rst        | 14 ++++++-------
>  include/linux/mm.h                            | 20 -------------------
>  3 files changed, 13 insertions(+), 33 deletions(-)
> 
> diff --git a/Documentation/mm/split_page_table_lock.rst b/Documentation/mm/split_page_table_lock.rst
> index 50ee0dfc95be..4bffec728340 100644
> --- a/Documentation/mm/split_page_table_lock.rst
> +++ b/Documentation/mm/split_page_table_lock.rst
> @@ -53,7 +53,7 @@ Support of split page table lock by an architecture
>  ===================================================
>  
>  There's no need in special enabling of PTE split page table lock: everything
> -required is done by pgtable_pte_page_ctor() and pgtable_pte_page_dtor(), which
> +required is done by pagetable_pte_ctor() and pagetable_pte_dtor(), which
>  must be called on PTE table allocation / freeing.
>  
>  Make sure the architecture doesn't use slab allocator for page table
> @@ -63,8 +63,8 @@ This field shares storage with page->ptl.
>  PMD split lock only makes sense if you have more than two page table
>  levels.
>  
> -PMD split lock enabling requires pgtable_pmd_page_ctor() call on PMD table
> -allocation and pgtable_pmd_page_dtor() on freeing.
> +PMD split lock enabling requires pagetable_pmd_ctor() call on PMD table
> +allocation and pagetable_pmd_dtor() on freeing.
>  
>  Allocation usually happens in pmd_alloc_one(), freeing in pmd_free() and
>  pmd_free_tlb(), but make sure you cover all PMD table allocation / freeing
> @@ -72,7 +72,7 @@ paths: i.e X86_PAE preallocate few PMDs on pgd_alloc().
>  
>  With everything in place you can set CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK.
>  
> -NOTE: pgtable_pte_page_ctor() and pgtable_pmd_page_ctor() can fail -- it must
> +NOTE: pagetable_pte_ctor() and pagetable_pmd_ctor() can fail -- it must
>  be handled properly.
>  
>  page->ptl
> @@ -92,7 +92,7 @@ trick:
>     split lock with enabled DEBUG_SPINLOCK or DEBUG_LOCK_ALLOC, but costs
>     one more cache line for indirect access;
>  
> -The spinlock_t allocated in pgtable_pte_page_ctor() for PTE table and in
> -pgtable_pmd_page_ctor() for PMD table.
> +The spinlock_t allocated in pagetable_pte_ctor() for PTE table and in
> +pagetable_pmd_ctor() for PMD table.
>  
>  Please, never access page->ptl directly -- use appropriate helper.
> diff --git a/Documentation/translations/zh_CN/mm/split_page_table_lock.rst b/Documentation/translations/zh_CN/mm/split_page_table_lock.rst
> index 4fb7aa666037..a2c288670a24 100644
> --- a/Documentation/translations/zh_CN/mm/split_page_table_lock.rst
> +++ b/Documentation/translations/zh_CN/mm/split_page_table_lock.rst
> @@ -56,16 +56,16 @@ Hugetlb特定的辅助函数:
>  架构对分页表锁的支持
>  ====================
>  
> -没有必要特别启用PTE分页表锁：所有需要的东西都由pgtable_pte_page_ctor()
> -和pgtable_pte_page_dtor()完成，它们必须在PTE表分配/释放时被调用。
> +没有必要特别启用PTE分页表锁：所有需要的东西都由pagetable_pte_ctor()
> +和pagetable_pte_dtor()完成，它们必须在PTE表分配/释放时被调用。
>  
>  确保架构不使用slab分配器来分配页表：slab使用page->slab_cache来分配其页
>  面。这个区域与page->ptl共享存储。
>  
>  PMD分页锁只有在你有两个以上的页表级别时才有意义。
>  
> -启用PMD分页锁需要在PMD表分配时调用pgtable_pmd_page_ctor()，在释放时调
> -用pgtable_pmd_page_dtor()。
> +启用PMD分页锁需要在PMD表分配时调用pagetable_pmd_ctor()，在释放时调
> +用pagetable_pmd_dtor()。
>  
>  分配通常发生在pmd_alloc_one()中，释放发生在pmd_free()和pmd_free_tlb()
>  中，但要确保覆盖所有的PMD表分配/释放路径：即X86_PAE在pgd_alloc()中预先
> @@ -73,7 +73,7 @@ PMD分页锁只有在你有两个以上的页表级别时才有意义。
>  
>  一切就绪后，你可以设置CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK。
>  
> -注意：pgtable_pte_page_ctor()和pgtable_pmd_page_ctor()可能失败--必
> +注意：pagetable_pte_ctor()和pagetable_pmd_ctor()可能失败--必
>  须正确处理。
>  
>  page->ptl
> @@ -90,7 +90,7 @@ page->ptl用于访问分割页表锁，其中'page'是包含该表的页面struc
>     的指针并动态分配它。这允许在启用DEBUG_SPINLOCK或DEBUG_LOCK_ALLOC的
>     情况下使用分页锁，但由于间接访问而多花了一个缓存行。
>  
> -PTE表的spinlock_t分配在pgtable_pte_page_ctor()中，PMD表的spinlock_t
> -分配在pgtable_pmd_page_ctor()中。
> +PTE表的spinlock_t分配在pagetable_pte_ctor()中，PMD表的spinlock_t
> +分配在pagetable_pmd_ctor()中。
>  
>  请不要直接访问page->ptl - -使用适当的辅助函数。
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index dc211c43610b..6d83483cf186 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2897,11 +2897,6 @@ static inline bool pagetable_pte_ctor(struct ptdesc *ptdesc)
>  	return true;
>  }
>  
> -static inline bool pgtable_pte_page_ctor(struct page *page)
> -{
> -	return pagetable_pte_ctor(page_ptdesc(page));
> -}
> -
>  static inline void pagetable_pte_dtor(struct ptdesc *ptdesc)
>  {
>  	struct folio *folio = ptdesc_folio(ptdesc);
> @@ -2911,11 +2906,6 @@ static inline void pagetable_pte_dtor(struct ptdesc *ptdesc)
>  	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
>  }
>  
> -static inline void pgtable_pte_page_dtor(struct page *page)
> -{
> -	pagetable_pte_dtor(page_ptdesc(page));
> -}
> -
>  #define pte_offset_map_lock(mm, pmd, address, ptlp)	\
>  ({							\
>  	spinlock_t *__ptl = pte_lockptr(mm, pmd);	\
> @@ -3006,11 +2996,6 @@ static inline bool pagetable_pmd_ctor(struct ptdesc *ptdesc)
>  	return true;
>  }
>  
> -static inline bool pgtable_pmd_page_ctor(struct page *page)
> -{
> -	return pagetable_pmd_ctor(page_ptdesc(page));
> -}
> -
>  static inline void pagetable_pmd_dtor(struct ptdesc *ptdesc)
>  {
>  	struct folio *folio = ptdesc_folio(ptdesc);
> @@ -3020,11 +3005,6 @@ static inline void pagetable_pmd_dtor(struct ptdesc *ptdesc)
>  	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
>  }
>  
> -static inline void pgtable_pmd_page_dtor(struct page *page)
> -{
> -	pagetable_pmd_dtor(page_ptdesc(page));
> -}
> -
>  /*
>   * No scalability reason to split PUD locks yet, but follow the same pattern
>   * as the PMD locks to make it easier if we decide to.  The VM should not be
> -- 
> 2.40.1
> 
> 

-- 
Sincerely yours,
Mike.
