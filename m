Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C8F522AA7
	for <lists+linux-arch@lfdr.de>; Wed, 11 May 2022 05:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiEKD7d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 May 2022 23:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiEKD7c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 May 2022 23:59:32 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A10229FD5;
        Tue, 10 May 2022 20:59:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=31;SR=0;TI=SMTPD_---0VCu38tE_1652241558;
Received: from 30.30.99.144(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VCu38tE_1652241558)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 11 May 2022 11:59:22 +0800
Message-ID: <84209c7b-ac3e-fa3b-75fc-d76ec7c99d68@linux.alibaba.com>
Date:   Wed, 11 May 2022 11:59:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 2/3] mm: rmap: Fix CONT-PTE/PMD size hugetlb issue when
 migration
To:     Andrew Morton <akpm@linux-foundation.org>, mike.kravetz@oracle.com,
        catalin.marinas@arm.com, will@kernel.org, songmuchun@bytedance.com,
        tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.osdn.me, dalias@libc.org,
        davem@davemloft.net, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
References: <cover.1652147571.git.baolin.wang@linux.alibaba.com>
 <ea5abf529f0997b5430961012bfda6166c1efc8c.1652147571.git.baolin.wang@linux.alibaba.com>
 <20220510161739.fdea4d78dde8471033aab22b@linux-foundation.org>
 <20220510162847.d9cf3c767e755a54699fb121@linux-foundation.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220510162847.d9cf3c767e755a54699fb121@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 5/11/2022 7:28 AM, Andrew Morton wrote:
> On Tue, 10 May 2022 16:17:39 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
>>> +
>>> +static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>>> +					  unsigned long addr, pte_t *ptep)
>>> +{
>>> +	return ptep_get(ptep);
>>> +}
>>> +
>>> +static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>>> +				   pte_t *ptep, pte_t pte)
>>> +{
>>> +}
>>>   #endif	/* CONFIG_HUGETLB_PAGE */
>>>   
>>
>> This blows up nommu (arm allnoconfig):
>>
>> In file included from fs/io_uring.c:71:
>> ./include/linux/hugetlb.h: In function 'huge_ptep_clear_flush':
>> ./include/linux/hugetlb.h:1100:16: error: implicit declaration of function 'ptep_get' [-Werror=implicit-function-declaration]
>>   1100 |         return ptep_get(ptep);
>>        |                ^~~~~~~~
>>
>>
>> huge_ptep_clear_flush() is only used in CONFIG_NOMMU=n files, so I simply
>> zapped this change.
>>
> 
> Well that wasn't a great success.  Doing this instead.  It's pretty
> nasty - something nicer would be nicer please.

Thanks for fixing the building issue. I'll look at this to simplify the 
dummy function. Myabe just remove the ptep_get().

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1097,7 +1097,7 @@ static inline void set_huge_swap_pte_at(struct 
mm_struct *mm, unsigned long addr
  static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
                                           unsigned long addr, pte_t *ptep)
  {
-       return ptep_get(ptep);
+       return *ptep;
  }

> 
> --- a/include/linux/hugetlb.h~mm-rmap-fix-cont-pte-pmd-size-hugetlb-issue-when-migration-fix
> +++ a/include/linux/hugetlb.h
> @@ -1094,6 +1094,7 @@ static inline void set_huge_swap_pte_at(
>   {
>   }
>   
> +#ifdef CONFIG_MMU
>   static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>   					  unsigned long addr, pte_t *ptep)
>   {
> @@ -1104,6 +1105,7 @@ static inline void set_huge_pte_at(struc
>   				   pte_t *ptep, pte_t pte)
>   {
>   }
> +#endif
>   #endif	/* CONFIG_HUGETLB_PAGE */
>   
>   static inline spinlock_t *huge_pte_lock(struct hstate *h,
> _
