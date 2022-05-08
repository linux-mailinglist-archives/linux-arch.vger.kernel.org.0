Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019E051ED9F
	for <lists+linux-arch@lfdr.de>; Sun,  8 May 2022 15:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbiEHNNT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 8 May 2022 09:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbiEHNNP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 8 May 2022 09:13:15 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CA338F;
        Sun,  8 May 2022 06:09:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=31;SR=0;TI=SMTPD_---0VCaceu-_1652015354;
Received: from 30.15.195.77(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VCaceu-_1652015354)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 08 May 2022 21:09:16 +0800
Message-ID: <bf627d1a-42f8-77f3-6ac2-67edde2feb8a@linux.alibaba.com>
Date:   Sun, 8 May 2022 21:09:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/3] mm: change huge_ptep_clear_flush() to return the
 original pte
To:     Muchun Song <songmuchun@bytedance.com>
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
References: <cover.1652002221.git.baolin.wang@linux.alibaba.com>
 <012a484019e7ad77c39deab0af52a6755d8438c8.1652002221.git.baolin.wang@linux.alibaba.com>
 <Ynek+b3k6PVN3x7J@FVFYT0MHHV2J.usts.net>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <Ynek+b3k6PVN3x7J@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 5/8/2022 7:09 PM, Muchun Song wrote:
> On Sun, May 08, 2022 at 05:36:39PM +0800, Baolin Wang wrote:
>> It is incorrect to use ptep_clear_flush() to nuke a hugetlb page
>> table when unmapping or migrating a hugetlb page, and will change
>> to use huge_ptep_clear_flush() instead in the following patches.
>>
>> So this is a preparation patch, which changes the huge_ptep_clear_flush()
>> to return the original pte to help to nuke a hugetlb page table.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks for reviewing.

> 
> But one nit below:
> 
> [...]
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 8605d7e..61a21af 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -5342,7 +5342,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>>   		ClearHPageRestoreReserve(new_page);
>>   
>>   		/* Break COW or unshare */
>> -		huge_ptep_clear_flush(vma, haddr, ptep);
>> +		(void)huge_ptep_clear_flush(vma, haddr, ptep);
> 
> Why add a "(void)" here? Is there any warning if no "(void)"?
> IIUC, I think we can remove this, right?

I did not meet any warning without the casting, but this is per Mike's 
comment[1] to make the code consistent with other functions casting to 
void type explicitly in hugetlb.c file.

[1] 
https://lore.kernel.org/all/495c4ebe-a5b4-afb6-4cb0-956c1b18d0cc@oracle.com/
