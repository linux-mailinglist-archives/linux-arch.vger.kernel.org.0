Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C380518588
	for <lists+linux-arch@lfdr.de>; Tue,  3 May 2022 15:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbiECNgl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 May 2022 09:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbiECNgj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 May 2022 09:36:39 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1183136B47;
        Tue,  3 May 2022 06:33:02 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=31;SR=0;TI=SMTPD_---0VC793pK_1651584773;
Received: from 30.39.210.51(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VC793pK_1651584773)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 May 2022 21:32:55 +0800
Message-ID: <8cd231f3-9c8f-ca70-75e7-3dd1ed47258d@linux.alibaba.com>
Date:   Tue, 3 May 2022 21:33:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/3] mm: rmap: Fix CONT-PTE/PMD size hugetlb issue when
 unmapping
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        catalin.marinas@arm.com, will@kernel.org,
        tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
References: <cover.1651216964.git.baolin.wang@linux.alibaba.com>
 <c91e04ebb792ef7b72966edea8bd6fa2dfa5bfa7.1651216964.git.baolin.wang@linux.alibaba.com>
 <20220429220214.4cfc5539@thinkpad>
 <bcb4a3b0-4fcd-af3a-2a2c-fd662d9eaba9@linux.alibaba.com>
 <20220502160232.589a6111@thinkpad>
 <48a05075-a323-e7f1-9e99-6c0d106eb2cb@linux.alibaba.com>
 <20220503120343.6264e126@thinkpad>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220503120343.6264e126@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 5/3/2022 6:03 PM, Gerald Schaefer wrote:
> On Tue, 3 May 2022 10:19:46 +0800
> Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>>
>>
>> On 5/2/2022 10:02 PM, Gerald Schaefer wrote:
>>> On Sat, 30 Apr 2022 11:22:33 +0800
>>> Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>>
>>>>
>>>>
>>>> On 4/30/2022 4:02 AM, Gerald Schaefer wrote:
>>>>> On Fri, 29 Apr 2022 16:14:43 +0800
>>>>> Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>>>>
>>>>>> On some architectures (like ARM64), it can support CONT-PTE/PMD size
>>>>>> hugetlb, which means it can support not only PMD/PUD size hugetlb:
>>>>>> 2M and 1G, but also CONT-PTE/PMD size: 64K and 32M if a 4K page
>>>>>> size specified.
>>>>>>
>>>>>> When unmapping a hugetlb page, we will get the relevant page table
>>>>>> entry by huge_pte_offset() only once to nuke it. This is correct
>>>>>> for PMD or PUD size hugetlb, since they always contain only one
>>>>>> pmd entry or pud entry in the page table.
>>>>>>
>>>>>> However this is incorrect for CONT-PTE and CONT-PMD size hugetlb,
>>>>>> since they can contain several continuous pte or pmd entry with
>>>>>> same page table attributes, so we will nuke only one pte or pmd
>>>>>> entry for this CONT-PTE/PMD size hugetlb page.
>>>>>>
>>>>>> And now we only use try_to_unmap() to unmap a poisoned hugetlb page,
>>>>>> which means now we will unmap only one pte entry for a CONT-PTE or
>>>>>> CONT-PMD size poisoned hugetlb page, and we can still access other
>>>>>> subpages of a CONT-PTE or CONT-PMD size poisoned hugetlb page,
>>>>>> which will cause serious issues possibly.
>>>>>>
>>>>>> So we should change to use huge_ptep_clear_flush() to nuke the
>>>>>> hugetlb page table to fix this issue, which already considered
>>>>>> CONT-PTE and CONT-PMD size hugetlb.
>>>>>>
>>>>>> Note we've already used set_huge_swap_pte_at() to set a poisoned
>>>>>> swap entry for a poisoned hugetlb page.
>>>>>>
>>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>>> ---
>>>>>>     mm/rmap.c | 34 +++++++++++++++++-----------------
>>>>>>     1 file changed, 17 insertions(+), 17 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>>> index 7cf2408..1e168d7 100644
>>>>>> --- a/mm/rmap.c
>>>>>> +++ b/mm/rmap.c
>>>>>> @@ -1564,28 +1564,28 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>>>>>     					break;
>>>>>>     				}
>>>>>>     			}
>>>>>> +			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
>>>>>
>>>>> Unlike in your patch 2/3, I do not see that this (huge) pteval would later
>>>>> be used again with set_huge_pte_at() instead of set_pte_at(). Not sure if
>>>>> this (huge) pteval could end up at a set_pte_at() later, but if yes, then
>>>>> this would be broken on s390, and you'd need to use set_huge_pte_at()
>>>>> instead of set_pte_at() like in your patch 2/3.
>>>>
>>>> IIUC, As I said in the commit message, we will only unmap a poisoned
>>>> hugetlb page by try_to_unmap(), and the poisoned hugetlb page will be
>>>> remapped with a poisoned entry by set_huge_swap_pte_at() in
>>>> try_to_unmap_one(). So I think no need change to use set_huge_pte_at()
>>>> instead of set_pte_at() for other cases, since the hugetlb page will not
>>>> hit other cases.
>>>>
>>>> if (PageHWPoison(subpage) && !(flags & TTU_IGNORE_HWPOISON)) {
>>>> 	pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
>>>> 	if (folio_test_hugetlb(folio)) {
>>>> 		hugetlb_count_sub(folio_nr_pages(folio), mm);
>>>> 		set_huge_swap_pte_at(mm, address, pvmw.pte, pteval,
>>>> 				     vma_mmu_pagesize(vma));
>>>> 	} else {
>>>> 		dec_mm_counter(mm, mm_counter(&folio->page));
>>>> 		set_pte_at(mm, address, pvmw.pte, pteval);
>>>> 	}
>>>>
>>>> }
>>>
>>> OK, but wouldn't the pteval be overwritten here with
>>> pteval = swp_entry_to_pte(make_hwpoison_entry(subpage))?
>>> IOW, what sense does it make to save the returned pteval from
>>> huge_ptep_clear_flush(), when it is never being used anywhere?
>>
>> Please see previous code, we'll use the original pte value to check if
>> it is uffd-wp armed, and if need to mark it dirty though the hugetlbfs
>> is set noop_dirty_folio().
>>
>> pte_install_uffd_wp_if_needed(vma, address, pvmw.pte, pteval);
> 
> Uh, ok, that wouldn't work on s390, but we also don't have
> CONFIG_PTE_MARKER_UFFD_WP / HAVE_ARCH_USERFAULTFD_WP set, so
> I guess we will be fine (for now).

OK.

> 
> Still, I find it a bit unsettling that pte_install_uffd_wp_if_needed()
> would work on a potential hugetlb *pte, directly de-referencing it
> instead of using huge_ptep_get().
> 
> The !pte_none(*pte) check at the beginning would be broken in the
> hugetlb case for s390 (not sure about other archs, but I think s390
> might be the only exception strictly requiring huge_ptep_get()
> for de-referencing hugetlb *pte pointers).

Right, I think so too. I'll look at the uffd code in detail, seems need 
another patch to fix the hugetlb for uffd. Thanks for your comments.
