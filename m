Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D1E60214D
	for <lists+linux-arch@lfdr.de>; Tue, 18 Oct 2022 04:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJRCmk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Oct 2022 22:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJRCmk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2022 22:42:40 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35CE89839;
        Mon, 17 Oct 2022 19:42:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VSSSWKB_1666060954;
Received: from 30.97.48.52(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VSSSWKB_1666060954)
          by smtp.aliyun-inc.com;
          Tue, 18 Oct 2022 10:42:35 +0800
Message-ID: <c163ba0e-80d9-6362-b4f0-c5a2a12deec5@linux.alibaba.com>
Date:   Tue, 18 Oct 2022 10:43:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH] mm: Introduce new MADV_NOMOVABLE behavior
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc:     arnd@arndb.de, jingshan@linux.alibaba.com, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <bc27af32b0418ed1138a1c3a41e46f54559025a5.1665991453.git.baolin.wang@linux.alibaba.com>
 <6227ba4c-9455-9652-7434-7842b2b3edcb@redhat.com>
 <8007f4fc-d2e6-7aae-7297-805326adce2a@linux.alibaba.com>
 <a83656e2-07b0-8a5f-40ae-077e23c4cd24@redhat.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <a83656e2-07b0-8a5f-40ae-077e23c4cd24@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 10/17/2022 7:27 PM, David Hildenbrand wrote:
> On 17.10.22 11:09, Baolin Wang wrote:
>>
>>
>> On 10/17/2022 4:41 PM, David Hildenbrand wrote:
>>> On 17.10.22 09:32, Baolin Wang wrote:
>>>> When creating a virtual machine, we will use memfd_create() to get
>>>> a file descriptor which can be used to create share memory mappings
>>>> using the mmap function, meanwhile the mmap() will set the MAP_POPULATE
>>>> flag to allocate physical pages for the virtual machine.
>>>>
>>>> When allocating physical pages for the guest, the host can fallback to
>>>> allocate some CMA pages for the guest when over half of the zone's free
>>>> memory is in the CMA area.
>>>>
>>>> In guest os, when the application wants to do some data transaction 
>>>> with
>>>> DMA, our QEMU will call VFIO_IOMMU_MAP_DMA ioctl to do longterm-pin and
>>>> create IOMMU mappings for the DMA pages. However, when calling
>>>> VFIO_IOMMU_MAP_DMA ioctl to pin the physical pages, we found it will be
>>>> failed to longterm-pin sometimes.
>>>>
>>>> After some invetigation, we found the pages used to do DMA mapping can
>>>> contain some CMA pages, and these CMA pages will cause a possible
>>>> failure of the longterm-pin, due to failed to migrate the CMA pages.
>>>> The reason of migration failure may be temporary reference count or
>>>> memory allocation failure. So that will cause the VFIO_IOMMU_MAP_DMA
>>>> ioctl returns error, which makes the application failed to start.
>>>>
>>>> To fix this issue, this patch introduces a new madvise behavior, named
>>>> as MADV_NOMOVABLE, to avoid allocating CMA pages and movable pages if
>>>> the users want to do longterm-pin, which can remove the possible 
>>>> failure
>>>> of movable or CMA pages migration.
>>>
>>> Sorry to say, but that sounds like a hack to work around a kernel
>>> implementation detail (how often we retry to migrate pages).
>>
>> IMO, in our case one migration failure will make our application failed
>> to start, which is not a trival problem. So mitigate the failure of
>> migration can be important in this case.
> 
> The right thing to do is to understand why these migrations fail and see 
> if we can improve the migration code.

OK. See below.

> 
>>
>>> If there are CMA/ZONE_MOVABLE issue, please fix them instead, and avoid
>>> leaking these details to user space.
>>
>> Now we can not forbid the fallback to CMA allocation if there are enough
>> free CMA in the zone, right? So adding a hint to help to diable
>> ALLOC_CMA flag seems reasonable?
>>
>> For CMA/ZONE_MOVABLE details, yes, not suitable to leak to user space.
>> so how about rename the madvise as MADV_PINNABLE, which means we will do
>> longterm-pin after allocation, and no CMA/ZONE_MOVABLE pages will be
>> allocated.
>>
> 
> I really don't think any of these new user-visible madv modes with 
> questionable semantics to workaround kernel implementation issues are a 
> good idea.
> 
> Especially MADV_PINNABLE has a *very* misleading name.
> 
> 
> I understand that something like "MADV_MIGHT_PIN" *might* be helpful to 
> minimize page migration. But IMHO that could only be a pure 
> optimization, but wouldn't stop us from allocating (or migrating to) 
> CMA/ZONE_MOVABLE in the kernel on all code paths. It would be best 
> effort only.
> 
> It's not user space decision how/where the kernel allocates memory. No 
> hacking around that.
> 
>> Or do you have any good idea? Thanks.
> 
> Investigate why migration of these pages fails and how we can improve 
> the code to make migration of these pages work more reliably.

I observed one migration failure case (which is not easy to reproduce) 
is that, the 'thp_migration_fail' count is 1 and the 
'thp_split_page_failed' count is also 1.

That means when migrating a THP which is in CMA area, but can not 
allocate a new THP due to memory fragmentation, so it will split the 
THP. However THP split is also failed, probably the reason is temporary 
reference count of this THP. And the temporary reference count can be 
caused by dropping page caches (I observed the drop caches operation in 
the system), but we can not drop the shmem page caches due to they are 
already dirty at that time.

So we can try again in migrate_pages() if THP split is failed to 
mitigate the failure of migration, especially for the failure reason is 
temporary reference count? Does this sound reasonable for you?

However I still worried there are other possible cases to cause 
migration failure, so no CMA allocation for our case seems more stable IMO.

> I am not completely against having a kernel parameter that would disable 
> allocating from CMA areas completely, even though it defeats the purpose 
> of CMA. But it wouldn't apply to ZONE_MOVABLE, so it would be just 
> another hackish approach.
> 
>>
>>> ALSO, with MAP_POPULATE as described by you this madvise flag doesn't
>>> make too much sense, because it will gets et after all memory already
>>> was allocated ...
>>
>> This is not a problem I think, we can change to use MADV_POPULATE_XXX to
>> preallocate the physical pages after MADV_NOMOVABLE madvise.
> 
> Yes, I know; I'm pointing out that your patch description is inconsistent.

OK. Thanks.
