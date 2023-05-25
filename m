Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288C2710326
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 05:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbjEYDBX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 23:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjEYDBU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 23:01:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91DD8135;
        Wed, 24 May 2023 20:01:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F9C81042;
        Wed, 24 May 2023 20:02:04 -0700 (PDT)
Received: from [10.162.43.6] (unknown [10.162.43.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E8443F762;
        Wed, 24 May 2023 20:01:17 -0700 (PDT)
Message-ID: <10c85f5c-3332-9130-c6f0-d36b9ea4b549@arm.com>
Date:   Thu, 25 May 2023 08:31:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 05/36] mm: Add default definition of set_ptes()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-6-willy@infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230315051444.3229621-6-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 3/15/23 10:44, Matthew Wilcox (Oracle) wrote:
> Most architectures can just define set_pte() and PFN_PTE_SHIFT to
> use this definition.  It's also a handy spot to document the guarantees
> provided by the MM.
> 
> Suggested-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/pgtable.h | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index c5a51481bbb9..a755fe94b4b4 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -172,6 +172,43 @@ static inline int pmd_young(pmd_t pmd)
>  }
>  #endif
>  
> +#ifndef set_ptes
> +#ifdef PFN_PTE_SHIFT
> +/**
> + * set_ptes - Map consecutive pages to a contiguous range of addresses.
> + * @mm: Address space to map the pages into.
> + * @addr: Address to map the first page at.
> + * @ptep: Page table pointer for the first entry.
> + * @pte: Page table entry for the first page.
> + * @nr: Number of pages to map.
> + *
> + * May be overridden by the architecture, or the architecture can define
> + * set_pte() and PFN_PTE_SHIFT.
> + *
> + * Context: The caller holds the page table lock.  The pages all belong
> + * to the same folio.  The PTEs are all in the same PMD.
> + */
> +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> +		pte_t *ptep, pte_t pte, unsigned int nr)
> +{
> +	page_table_check_ptes_set(mm, addr, ptep, pte, nr);
> +
> +	for (;;) {
> +		set_pte(ptep, pte);
> +		if (--nr == 0)
> +			break;
> +		ptep++;
> +		pte = __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
> +	}
> +}
> +#ifndef set_pte_at
> +#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
> +#endif

Should not there be a build phase call out when both set_ptes() and PFN_PTE_SHIFT
are not defined on a given platform ?

--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -204,6 +204,8 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 #ifndef set_pte_at
 #define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
 #endif
+#else
+#error "You should define PFN_PTE_SHIFT"
 #endif
 #else
 #define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)

> +#endif> +#else
> +#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
> +#endif
> +
>  #ifndef __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
>  extern int ptep_set_access_flags(struct vm_area_struct *vma,
>  				 unsigned long address, pte_t *ptep,
