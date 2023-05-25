Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6430071059F
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 08:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjEYGUr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 02:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjEYGUq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 02:20:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B71CE7;
        Wed, 24 May 2023 23:20:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1AB61042;
        Wed, 24 May 2023 23:21:29 -0700 (PDT)
Received: from [10.162.43.6] (unknown [10.162.43.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F00A23F762;
        Wed, 24 May 2023 23:20:42 -0700 (PDT)
Message-ID: <735dd721-39fe-8f13-b677-17162fbbdb41@arm.com>
Date:   Thu, 25 May 2023 11:50:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 31/36] mm: Tidy up set_ptes definition
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-32-willy@infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230315051444.3229621-32-willy@infradead.org>
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
> Now that all architectures are converted, we can remove the
> PFN_PTE_SHIFT ifdef and we can define set_pte_at() unconditionally.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  include/linux/pgtable.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index a755fe94b4b4..a54b9197f2f2 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -173,7 +173,6 @@ static inline int pmd_young(pmd_t pmd)
>  #endif
>  
>  #ifndef set_ptes
> -#ifdef PFN_PTE_SHIFT
>  /**
>   * set_ptes - Map consecutive pages to a contiguous range of addresses.
>   * @mm: Address space to map the pages into.
> @@ -201,13 +200,8 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>  		pte = __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
>  	}
>  }
> -#ifndef set_pte_at
> -#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
> -#endif
>  #endif
> -#else
>  #define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
> -#endif
>  
>  #ifndef __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
>  extern int ptep_set_access_flags(struct vm_area_struct *vma,
