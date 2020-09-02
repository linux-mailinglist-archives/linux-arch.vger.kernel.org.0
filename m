Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3695E25A426
	for <lists+linux-arch@lfdr.de>; Wed,  2 Sep 2020 05:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgIBDuL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 23:50:11 -0400
Received: from foss.arm.com ([217.140.110.172]:56828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgIBDuL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Sep 2020 23:50:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 033D3D6E;
        Tue,  1 Sep 2020 20:50:10 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 200CE3F66F;
        Tue,  1 Sep 2020 20:50:04 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v3 13/13] mm/debug_vm_pgtable: populate a pte entry before
 fetching it
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, x86@kernel.org,
        linux-arch@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Vineet Gupta <vgupta@synopsys.com>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
 <20200827080438.315345-14-aneesh.kumar@linux.ibm.com>
 <edc68223-7f8a-13df-68eb-9682f585adb8@arm.com>
 <abef1791-8779-6b34-3178-3bf3ab36d42b@linux.ibm.com>
 <e3140b44-993e-aa4b-130d-ee2230eff2b5@arm.com>
 <7ef7c302-e7e6-570e-3100-5dd1bf9551be@linux.ibm.com>
Message-ID: <4ba15b8f-ac90-17ec-9b95-0451e2a38e98@arm.com>
Date:   Wed, 2 Sep 2020 09:19:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7ef7c302-e7e6-570e-3100-5dd1bf9551be@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 09/01/2020 03:28 PM, Aneesh Kumar K.V wrote:
> On 9/1/20 1:08 PM, Anshuman Khandual wrote:
>>
>>
>> On 09/01/2020 12:07 PM, Aneesh Kumar K.V wrote:
>>> On 9/1/20 8:55 AM, Anshuman Khandual wrote:
>>>>
>>>>
>>>> On 08/27/2020 01:34 PM, Aneesh Kumar K.V wrote:
>>>>> pte_clear_tests operate on an existing pte entry. Make sure that is not a none
>>>>> pte entry.
>>>>>
>>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>>> ---
>>>>>    mm/debug_vm_pgtable.c | 6 ++++--
>>>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>>>>> index 21329c7d672f..8527ebb75f2c 100644
>>>>> --- a/mm/debug_vm_pgtable.c
>>>>> +++ b/mm/debug_vm_pgtable.c
>>>>> @@ -546,7 +546,7 @@ static void __init pgd_populate_tests(struct mm_struct *mm, pgd_t *pgdp,
>>>>>    static void __init pte_clear_tests(struct mm_struct *mm, pte_t *ptep,
>>>>>                       unsigned long vaddr)
>>>>>    {
>>>>> -    pte_t pte = ptep_get(ptep);
>>>>> +    pte_t pte =  ptep_get_and_clear(mm, vaddr, ptep);
>>>>
>>>> Seems like ptep_get_and_clear() here just clears the entry in preparation
>>>> for a following set_pte_at() which otherwise would have been a problem on
>>>> ppc64 as you had pointed out earlier i.e set_pte_at() should not update an
>>>> existing valid entry. So the commit message here is bit misleading.
>>>>
>>>
>>> and also fetch the pte value which is used further.
>>>
>>>
>>>>>          pr_debug("Validating PTE clear\n");
>>>>>        pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
>>>>> @@ -944,7 +944,7 @@ static int __init debug_vm_pgtable(void)
>>>>>        p4d_t *p4dp, *saved_p4dp;
>>>>>        pud_t *pudp, *saved_pudp;
>>>>>        pmd_t *pmdp, *saved_pmdp, pmd;
>>>>> -    pte_t *ptep;
>>>>> +    pte_t *ptep, pte;
>>>>>        pgtable_t saved_ptep;
>>>>>        pgprot_t prot, protnone;
>>>>>        phys_addr_t paddr;
>>>>> @@ -1049,6 +1049,8 @@ static int __init debug_vm_pgtable(void)
>>>>>         */
>>>>>          ptep = pte_alloc_map_lock(mm, pmdp, vaddr, &ptl);
>>>>> +    pte = pfn_pte(pte_aligned, prot);
>>>>> +    set_pte_at(mm, vaddr, ptep, pte);
>>>>
>>>> Not here, creating and populating an entry must be done in respective
>>>> test functions itself. Besides, this seems bit redundant as well. The
>>>> test pte_clear_tests() with the above change added, already
>>>>
>>>> - Clears the PTEP entry with ptep_get_and_clear()
>>>
>>> and fetch the old value set previously.
>>
>> In that case, please move above two lines i.e
>>
>> pte = pfn_pte(pte_aligned, prot);
>> set_pte_at(mm, vaddr, ptep, pte);
>>
>> from debug_vm_pgtable() to pte_clear_tests() and update it's arguments
>> as required.
>>
> 
> Frankly, I don't understand what these tests are testing. It all looks like some random clear and set.

The idea here is to have some value with some randomness preferably, in
a given PTEP before attempting to clear the entry, in order to make sure
that pte_clear() is indeed clearing something of non-zero value.

> 
> static void __init pte_clear_tests(struct mm_struct *mm, pte_t *ptep,
>                    unsigned long vaddr, unsigned long pfn,
>                    pgprot_t prot)
> {
> 
>     pte_t pte = pfn_pte(pfn, prot);
>     set_pte_at(mm, vaddr, ptep, pte);
> 
>     pte =  ptep_get_and_clear(mm, vaddr, ptep);

Looking at this again, this preceding pfn_pte() followed by set_pte_at()
is not really required. Its reasonable to start with what ever was there
in the PTEP as a seed value which anyway gets added with RANDOM_ORVALUE.
s/ptep_get/ptep_get_and_clear is sufficient to take care of the powerpc
set_pte_at() constraint.
