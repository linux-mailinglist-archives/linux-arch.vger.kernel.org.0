Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F1A3645A8
	for <lists+linux-arch@lfdr.de>; Mon, 19 Apr 2021 16:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhDSOIU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Apr 2021 10:08:20 -0400
Received: from foss.arm.com ([217.140.110.172]:43716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230021AbhDSOIU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Apr 2021 10:08:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1290C31B;
        Mon, 19 Apr 2021 07:07:50 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CA2C3F7D7;
        Mon, 19 Apr 2021 07:07:48 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] mm: pagewalk: Fix walk for hugepage tables
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        akpm@linux-foundation.org, dja@axtens.net
Cc:     Oliver O'Halloran <oohall@gmail.com>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <cover.1618828806.git.christophe.leroy@csgroup.eu>
 <db6981c69f96a8c9c6dcf688b7f485e15993ddef.1618828806.git.christophe.leroy@csgroup.eu>
From:   Steven Price <steven.price@arm.com>
Message-ID: <1fdb0abe-b4b5-937c-0d9b-859a5cbb5726@arm.com>
Date:   Mon, 19 Apr 2021 15:07:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <db6981c69f96a8c9c6dcf688b7f485e15993ddef.1618828806.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 19/04/2021 11:47, Christophe Leroy wrote:
> Pagewalk ignores hugepd entries and walk down the tables
> as if it was traditionnal entries, leading to crazy result.
> 
> Add walk_hugepd_range() and use it to walk hugepage tables.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Looks correct to me, sadly I don't have a suitable system to test it.

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
> v2:
> - Add a guard for NULL ops->pte_entry
> - Take mm->page_table_lock when walking hugepage table, as suggested by follow_huge_pd()
> ---
>   mm/pagewalk.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 53 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index e81640d9f177..9b3db11a4d1d 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -58,6 +58,45 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>   	return err;
>   }
>   
> +#ifdef CONFIG_ARCH_HAS_HUGEPD
> +static int walk_hugepd_range(hugepd_t *phpd, unsigned long addr,
> +			     unsigned long end, struct mm_walk *walk, int pdshift)
> +{
> +	int err = 0;
> +	const struct mm_walk_ops *ops = walk->ops;
> +	int shift = hugepd_shift(*phpd);
> +	int page_size = 1 << shift;
> +
> +	if (!ops->pte_entry)
> +		return 0;
> +
> +	if (addr & (page_size - 1))
> +		return 0;
> +
> +	for (;;) {
> +		pte_t *pte;
> +
> +		spin_lock(&walk->mm->page_table_lock);
> +		pte = hugepte_offset(*phpd, addr, pdshift);
> +		err = ops->pte_entry(pte, addr, addr + page_size, walk);
> +		spin_unlock(&walk->mm->page_table_lock);
> +
> +		if (err)
> +			break;
> +		if (addr >= end - page_size)
> +			break;
> +		addr += page_size;
> +	}
> +	return err;
> +}
> +#else
> +static int walk_hugepd_range(hugepd_t *phpd, unsigned long addr,
> +			     unsigned long end, struct mm_walk *walk, int pdshift)
> +{
> +	return 0;
> +}
> +#endif
> +
>   static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>   			  struct mm_walk *walk)
>   {
> @@ -108,7 +147,10 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>   				goto again;
>   		}
>   
> -		err = walk_pte_range(pmd, addr, next, walk);
> +		if (is_hugepd(__hugepd(pmd_val(*pmd))))
> +			err = walk_hugepd_range((hugepd_t *)pmd, addr, next, walk, PMD_SHIFT);
> +		else
> +			err = walk_pte_range(pmd, addr, next, walk);
>   		if (err)
>   			break;
>   	} while (pmd++, addr = next, addr != end);
> @@ -157,7 +199,10 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
>   		if (pud_none(*pud))
>   			goto again;
>   
> -		err = walk_pmd_range(pud, addr, next, walk);
> +		if (is_hugepd(__hugepd(pud_val(*pud))))
> +			err = walk_hugepd_range((hugepd_t *)pud, addr, next, walk, PUD_SHIFT);
> +		else
> +			err = walk_pmd_range(pud, addr, next, walk);
>   		if (err)
>   			break;
>   	} while (pud++, addr = next, addr != end);
> @@ -189,7 +234,9 @@ static int walk_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
>   			if (err)
>   				break;
>   		}
> -		if (ops->pud_entry || ops->pmd_entry || ops->pte_entry)
> +		if (is_hugepd(__hugepd(p4d_val(*p4d))))
> +			err = walk_hugepd_range((hugepd_t *)p4d, addr, next, walk, P4D_SHIFT);
> +		else if (ops->pud_entry || ops->pmd_entry || ops->pte_entry)
>   			err = walk_pud_range(p4d, addr, next, walk);
>   		if (err)
>   			break;
> @@ -224,8 +271,9 @@ static int walk_pgd_range(unsigned long addr, unsigned long end,
>   			if (err)
>   				break;
>   		}
> -		if (ops->p4d_entry || ops->pud_entry || ops->pmd_entry ||
> -		    ops->pte_entry)
> +		if (is_hugepd(__hugepd(pgd_val(*pgd))))
> +			err = walk_hugepd_range((hugepd_t *)pgd, addr, next, walk, PGDIR_SHIFT);
> +		else if (ops->p4d_entry || ops->pud_entry || ops->pmd_entry || ops->pte_entry)
>   			err = walk_p4d_range(pgd, addr, next, walk);
>   		if (err)
>   			break;
> 

