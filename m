Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB563B590B
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jun 2021 08:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhF1GWB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 02:22:01 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:29604 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhF1GWB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 Jun 2021 02:22:01 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4GCyBH0MpczBCKR;
        Mon, 28 Jun 2021 08:19:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZA7aZ6ejMGIW; Mon, 28 Jun 2021 08:19:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4GCyBG6WYfzBCK1;
        Mon, 28 Jun 2021 08:19:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B24088B776;
        Mon, 28 Jun 2021 08:19:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id d1i1Tjk67oaP; Mon, 28 Jun 2021 08:19:34 +0200 (CEST)
Received: from [172.25.230.102] (po15451.idsi0.si.c-s.fr [172.25.230.102])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5F3578B763;
        Mon, 28 Jun 2021 08:19:34 +0200 (CEST)
Subject: Re: [PATCH v3] mm: pagewalk: Fix walk for hugepage tables
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Steven Price <steven.price@arm.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <38d04410700c8d02f28ba37e020b62c55d6f3d2c.1624597695.git.christophe.leroy@csgroup.eu>
 <87bl7qle4o.fsf@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <7bbf9c5e-b81d-d20c-7ba1-d50b10238d32@csgroup.eu>
Date:   Mon, 28 Jun 2021 08:19:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87bl7qle4o.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 28/06/2021 à 08:03, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> 
>> Pagewalk ignores hugepd entries and walk down the tables
>> as if it was traditionnal entries, leading to crazy result.
> 
> But we do handle hugetlb separately
> 
> 	if (vma && is_vm_hugetlb_page(vma)) {
> 		if (ops->hugetlb_entry)
> 			err = walk_hugetlb_range(start, end, walk);
> 	} else
> 		err = walk_pgd_range(start, end, walk);
> 
> Are we using hugepd format for non hugetlb entries?

Yes, on the 8xx we use hugepd for 8M pages for linear mapping and for kasan shadow mapping (See 
commit bb5f33c06940 ("Merge "Use hugepages to map kernel mem on 8xx" into next")

And I'm working on implementing huge VMAP with 8M pages, that will also make use of hugepd.

> 
>>
>> Add walk_hugepd_range() and use it to walk hugepage tables.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Reviewed-by: Steven Price <steven.price@arm.com>
>> ---
>> v3:
>> - Rebased on next-20210624 (no change since v2)
>> - Added Steven's Reviewed-by
>> - Sent as standalone for merge via mm
>>
>> v2:
>> - Add a guard for NULL ops->pte_entry
>> - Take mm->page_table_lock when walking hugepage table, as suggested by follow_huge_pd()
>> ---
>>   mm/pagewalk.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 53 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
>> index e81640d9f177..9b3db11a4d1d 100644
>> --- a/mm/pagewalk.c
>> +++ b/mm/pagewalk.c
>> @@ -58,6 +58,45 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>>   	return err;
>>   }
>>   
>> +#ifdef CONFIG_ARCH_HAS_HUGEPD
>> +static int walk_hugepd_range(hugepd_t *phpd, unsigned long addr,
>> +			     unsigned long end, struct mm_walk *walk, int pdshift)
>> +{
>> +	int err = 0;
>> +	const struct mm_walk_ops *ops = walk->ops;
>> +	int shift = hugepd_shift(*phpd);
>> +	int page_size = 1 << shift;
>> +
>> +	if (!ops->pte_entry)
>> +		return 0;
>> +
>> +	if (addr & (page_size - 1))
>> +		return 0;
>> +
>> +	for (;;) {
>> +		pte_t *pte;
>> +
>> +		spin_lock(&walk->mm->page_table_lock);
>> +		pte = hugepte_offset(*phpd, addr, pdshift);
>> +		err = ops->pte_entry(pte, addr, addr + page_size, walk);
>> +		spin_unlock(&walk->mm->page_table_lock);
>> +
>> +		if (err)
>> +			break;
>> +		if (addr >= end - page_size)
>> +			break;
>> +		addr += page_size;
>> +	}
>> +	return err;
>> +}
>> +#else
>> +static int walk_hugepd_range(hugepd_t *phpd, unsigned long addr,
>> +			     unsigned long end, struct mm_walk *walk, int pdshift)
>> +{
>> +	return 0;
>> +}
>> +#endif
>> +
>>   static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>>   			  struct mm_walk *walk)
>>   {
>> @@ -108,7 +147,10 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>>   				goto again;
>>   		}
>>   
>> -		err = walk_pte_range(pmd, addr, next, walk);
>> +		if (is_hugepd(__hugepd(pmd_val(*pmd))))
>> +			err = walk_hugepd_range((hugepd_t *)pmd, addr, next, walk, PMD_SHIFT);
>> +		else
>> +			err = walk_pte_range(pmd, addr, next, walk);
>>   		if (err)
>>   			break;
>>   	} while (pmd++, addr = next, addr != end);
>> @@ -157,7 +199,10 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
>>   		if (pud_none(*pud))
>>   			goto again;
>>   
>> -		err = walk_pmd_range(pud, addr, next, walk);
>> +		if (is_hugepd(__hugepd(pud_val(*pud))))
>> +			err = walk_hugepd_range((hugepd_t *)pud, addr, next, walk, PUD_SHIFT);
>> +		else
>> +			err = walk_pmd_range(pud, addr, next, walk);
>>   		if (err)
>>   			break;
>>   	} while (pud++, addr = next, addr != end);
>> @@ -189,7 +234,9 @@ static int walk_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
>>   			if (err)
>>   				break;
>>   		}
>> -		if (ops->pud_entry || ops->pmd_entry || ops->pte_entry)
>> +		if (is_hugepd(__hugepd(p4d_val(*p4d))))
>> +			err = walk_hugepd_range((hugepd_t *)p4d, addr, next, walk, P4D_SHIFT);
>> +		else if (ops->pud_entry || ops->pmd_entry || ops->pte_entry)
>>   			err = walk_pud_range(p4d, addr, next, walk);
>>   		if (err)
>>   			break;
>> @@ -224,8 +271,9 @@ static int walk_pgd_range(unsigned long addr, unsigned long end,
>>   			if (err)
>>   				break;
>>   		}
>> -		if (ops->p4d_entry || ops->pud_entry || ops->pmd_entry ||
>> -		    ops->pte_entry)
>> +		if (is_hugepd(__hugepd(pgd_val(*pgd))))
>> +			err = walk_hugepd_range((hugepd_t *)pgd, addr, next, walk, PGDIR_SHIFT);
>> +		else if (ops->p4d_entry || ops->pud_entry || ops->pmd_entry || ops->pte_entry)
>>   			err = walk_p4d_range(pgd, addr, next, walk);
>>   		if (err)
>>   			break;
>> -- 
>> 2.25.0
