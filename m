Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566761C2D76
	for <lists+linux-arch@lfdr.de>; Sun,  3 May 2020 17:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgECP3I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 May 2020 11:29:08 -0400
Received: from foss.arm.com ([217.140.110.172]:59894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728207AbgECP3I (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 3 May 2020 11:29:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C526630E;
        Sun,  3 May 2020 08:29:07 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78EC23F68F;
        Sun,  3 May 2020 08:29:06 -0700 (PDT)
Date:   Sun, 3 May 2020 16:29:00 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Hugh Dickins <hughd@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 3/4] arm64: mte: Enable swap of tagged pages
Message-ID: <20200503152858.GA11959@gaia>
References: <20200422142530.32619-1-steven.price@arm.com>
 <20200422142530.32619-4-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422142530.32619-4-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 22, 2020 at 03:25:29PM +0100, Steven Price wrote:
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 39a372bf8afc..a4ad1b75a1a7 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -80,6 +80,8 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
>  #define pte_user_exec(pte)	(!(pte_val(pte) & PTE_UXN))
>  #define pte_cont(pte)		(!!(pte_val(pte) & PTE_CONT))
>  #define pte_devmap(pte)		(!!(pte_val(pte) & PTE_DEVMAP))
> +#define pte_tagged(pte)		(!!((pte_val(pte) & PTE_ATTRINDX_MASK) == \
> +				    PTE_ATTRINDX(MT_NORMAL_TAGGED)))
>  
>  #define pte_cont_addr_end(addr, end)						\
>  ({	unsigned long __boundary = ((addr) + CONT_PTE_SIZE) & CONT_PTE_MASK;	\
> @@ -268,12 +270,17 @@ static inline void __check_racy_pte_update(struct mm_struct *mm, pte_t *ptep,
>  		     __func__, pte_val(old_pte), pte_val(pte));
>  }
>  
> +void mte_sync_tags(pte_t *ptep, pte_t pte);
> +
>  static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>  			      pte_t *ptep, pte_t pte)
>  {
>  	if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
>  		__sync_icache_dcache(pte);
>  
> +	if (system_supports_mte() && pte_tagged(pte))
> +		mte_sync_tags(ptep, pte);

I think this needs a pte_present() check as well, otherwise pte_tagged()
could match some random swap entry.

-- 
Catalin
