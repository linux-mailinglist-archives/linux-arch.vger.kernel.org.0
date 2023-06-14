Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1537C72FFDF
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jun 2023 15:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244810AbjFNNWS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jun 2023 09:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbjFNNWR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 09:22:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3F7B8;
        Wed, 14 Jun 2023 06:22:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6BFD64232;
        Wed, 14 Jun 2023 13:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D64C433C0;
        Wed, 14 Jun 2023 13:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686748935;
        bh=0vqssVcI3AzSm6ZYzSMTFzLW0LK2ArpvNNFnyd0jDMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PwXP+1XbNJMc5dDtJjP8fRUbMVOfgYZkiV/CSEiQO+53OUw1mxkM7TNacSN2UVnvq
         Mwxs/DwA39lzTfMai8ygKMhnw/8A5txEm5g+274q1AspzudJm5ujeZxuL5SlxzV7kr
         XEeamoxRIjx3hqKKprCq30b101V9LmtVD7C/YrzqjcfWDUt0IERYcZ+YUZAUB1qm6M
         qU2wy/k+HKKhrQ/qrF2cNssBn4aoQYbJEpcB5m9Vm0+PGaXZfYQhkb0YSbhsS/HNdF
         f2cI0J/nTygASR5eUp+uYZzIW/J3GUH1QtysQDebu/WsZ8JxpIwHAuYB2k8FX53JGd
         49yjsQPz5+zOQ==
Date:   Wed, 14 Jun 2023 16:21:37 +0300
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
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v4 03/34] s390: Use pt_frag_refcount for pagetables
Message-ID: <20230614132137.GB52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-4-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-4-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 12, 2023 at 02:03:52PM -0700, Vishal Moola (Oracle) wrote:
> s390 currently uses _refcount to identify fragmented page tables.
> The page table struct already has a member pt_frag_refcount used by
> powerpc, so have s390 use that instead of the _refcount field as well.
> This improves the safety for _refcount and the page table tracking.
> 
> This also allows us to simplify the tracking since we can once again use
> the lower byte of pt_frag_refcount instead of the upper byte of _refcount.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

One nit below, otherwise

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/s390/mm/pgalloc.c | 38 +++++++++++++++-----------------------
>  1 file changed, 15 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
> index 66ab68db9842..6b99932abc66 100644
> --- a/arch/s390/mm/pgalloc.c
> +++ b/arch/s390/mm/pgalloc.c
> @@ -182,20 +182,17 @@ void page_table_free_pgste(struct page *page)
>   * As follows from the above, no unallocated or fully allocated parent
>   * pages are contained in mm_context_t::pgtable_list.
>   *
> - * The upper byte (bits 24-31) of the parent page _refcount is used
> + * The lower byte (bits 0-7) of the parent page pt_frag_refcount is used
>   * for tracking contained 2KB-pgtables and has the following format:
>   *
>   *   PP  AA
> - * 01234567    upper byte (bits 24-31) of struct page::_refcount
> + * 01234567    upper byte (bits 0-7) of struct page::pt_frag_refcount

Nit:              lower

>   *   ||  ||
>   *   ||  |+--- upper 2KB-pgtable is allocated
>   *   ||  +---- lower 2KB-pgtable is allocated
>   *   |+------- upper 2KB-pgtable is pending for removal
>   *   +-------- lower 2KB-pgtable is pending for removal
>   *
> - * (See commit 620b4e903179 ("s390: use _refcount for pgtables") on why
> - * using _refcount is possible).
> - *
>   * When 2KB-pgtable is allocated the corresponding AA bit is set to 1.
>   * The parent page is either:
>   *   - added to mm_context_t::pgtable_list in case the second half of the
> @@ -243,11 +240,12 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
>  		if (!list_empty(&mm->context.pgtable_list)) {
>  			page = list_first_entry(&mm->context.pgtable_list,
>  						struct page, lru);
> -			mask = atomic_read(&page->_refcount) >> 24;
> +			mask = atomic_read(&page->pt_frag_refcount);
>  			/*
>  			 * The pending removal bits must also be checked.
>  			 * Failure to do so might lead to an impossible
> -			 * value of (i.e 0x13 or 0x23) written to _refcount.
> +			 * value of (i.e 0x13 or 0x23) written to
> +			 * pt_frag_refcount.
>  			 * Such values violate the assumption that pending and
>  			 * allocation bits are mutually exclusive, and the rest
>  			 * of the code unrails as result. That could lead to
> @@ -259,8 +257,8 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
>  				bit = mask & 1;		/* =1 -> second 2K */
>  				if (bit)
>  					table += PTRS_PER_PTE;
> -				atomic_xor_bits(&page->_refcount,
> -							0x01U << (bit + 24));
> +				atomic_xor_bits(&page->pt_frag_refcount,
> +							0x01U << bit);
>  				list_del(&page->lru);
>  			}
>  		}
> @@ -281,12 +279,12 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
>  	table = (unsigned long *) page_to_virt(page);
>  	if (mm_alloc_pgste(mm)) {
>  		/* Return 4K page table with PGSTEs */
> -		atomic_xor_bits(&page->_refcount, 0x03U << 24);
> +		atomic_xor_bits(&page->pt_frag_refcount, 0x03U);
>  		memset64((u64 *)table, _PAGE_INVALID, PTRS_PER_PTE);
>  		memset64((u64 *)table + PTRS_PER_PTE, 0, PTRS_PER_PTE);
>  	} else {
>  		/* Return the first 2K fragment of the page */
> -		atomic_xor_bits(&page->_refcount, 0x01U << 24);
> +		atomic_xor_bits(&page->pt_frag_refcount, 0x01U);
>  		memset64((u64 *)table, _PAGE_INVALID, 2 * PTRS_PER_PTE);
>  		spin_lock_bh(&mm->context.lock);
>  		list_add(&page->lru, &mm->context.pgtable_list);
> @@ -323,22 +321,19 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
>  		 * will happen outside of the critical section from this
>  		 * function or from __tlb_remove_table()
>  		 */
> -		mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
> -		mask >>= 24;
> +		mask = atomic_xor_bits(&page->pt_frag_refcount, 0x11U << bit);
>  		if (mask & 0x03U)
>  			list_add(&page->lru, &mm->context.pgtable_list);
>  		else
>  			list_del(&page->lru);
>  		spin_unlock_bh(&mm->context.lock);
> -		mask = atomic_xor_bits(&page->_refcount, 0x10U << (bit + 24));
> -		mask >>= 24;
> +		mask = atomic_xor_bits(&page->pt_frag_refcount, 0x10U << bit);
>  		if (mask != 0x00U)
>  			return;
>  		half = 0x01U << bit;
>  	} else {
>  		half = 0x03U;
> -		mask = atomic_xor_bits(&page->_refcount, 0x03U << 24);
> -		mask >>= 24;
> +		mask = atomic_xor_bits(&page->pt_frag_refcount, 0x03U);
>  	}
>  
>  	page_table_release_check(page, table, half, mask);
> @@ -368,8 +363,7 @@ void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
>  	 * outside of the critical section from __tlb_remove_table() or from
>  	 * page_table_free()
>  	 */
> -	mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
> -	mask >>= 24;
> +	mask = atomic_xor_bits(&page->pt_frag_refcount, 0x11U << bit);
>  	if (mask & 0x03U)
>  		list_add_tail(&page->lru, &mm->context.pgtable_list);
>  	else
> @@ -391,14 +385,12 @@ void __tlb_remove_table(void *_table)
>  		return;
>  	case 0x01U:	/* lower 2K of a 4K page table */
>  	case 0x02U:	/* higher 2K of a 4K page table */
> -		mask = atomic_xor_bits(&page->_refcount, mask << (4 + 24));
> -		mask >>= 24;
> +		mask = atomic_xor_bits(&page->pt_frag_refcount, mask << 4);
>  		if (mask != 0x00U)
>  			return;
>  		break;
>  	case 0x03U:	/* 4K page table with pgstes */
> -		mask = atomic_xor_bits(&page->_refcount, 0x03U << 24);
> -		mask >>= 24;
> +		mask = atomic_xor_bits(&page->pt_frag_refcount, 0x03U);
>  		break;
>  	}
>  
> -- 
> 2.40.1
> 
> 

-- 
Sincerely yours,
Mike.
