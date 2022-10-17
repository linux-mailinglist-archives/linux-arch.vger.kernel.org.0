Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5266009EB
	for <lists+linux-arch@lfdr.de>; Mon, 17 Oct 2022 11:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiJQJIt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Oct 2022 05:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiJQJIj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2022 05:08:39 -0400
Received: from out199-10.us.a.mail.aliyun.com (out199-10.us.a.mail.aliyun.com [47.90.199.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AD5CC8;
        Mon, 17 Oct 2022 02:08:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VSLPJYu_1665997713;
Received: from 30.97.48.54(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VSLPJYu_1665997713)
          by smtp.aliyun-inc.com;
          Mon, 17 Oct 2022 17:08:34 +0800
Message-ID: <8007f4fc-d2e6-7aae-7297-805326adce2a@linux.alibaba.com>
Date:   Mon, 17 Oct 2022 17:09:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH] mm: Introduce new MADV_NOMOVABLE behavior
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc:     arnd@arndb.de, jingshan@linux.alibaba.com, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <bc27af32b0418ed1138a1c3a41e46f54559025a5.1665991453.git.baolin.wang@linux.alibaba.com>
 <6227ba4c-9455-9652-7434-7842b2b3edcb@redhat.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <6227ba4c-9455-9652-7434-7842b2b3edcb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 10/17/2022 4:41 PM, David Hildenbrand wrote:
> On 17.10.22 09:32, Baolin Wang wrote:
>> When creating a virtual machine, we will use memfd_create() to get
>> a file descriptor which can be used to create share memory mappings
>> using the mmap function, meanwhile the mmap() will set the MAP_POPULATE
>> flag to allocate physical pages for the virtual machine.
>>
>> When allocating physical pages for the guest, the host can fallback to
>> allocate some CMA pages for the guest when over half of the zone's free
>> memory is in the CMA area.
>>
>> In guest os, when the application wants to do some data transaction with
>> DMA, our QEMU will call VFIO_IOMMU_MAP_DMA ioctl to do longterm-pin and
>> create IOMMU mappings for the DMA pages. However, when calling
>> VFIO_IOMMU_MAP_DMA ioctl to pin the physical pages, we found it will be
>> failed to longterm-pin sometimes.
>>
>> After some invetigation, we found the pages used to do DMA mapping can
>> contain some CMA pages, and these CMA pages will cause a possible
>> failure of the longterm-pin, due to failed to migrate the CMA pages.
>> The reason of migration failure may be temporary reference count or
>> memory allocation failure. So that will cause the VFIO_IOMMU_MAP_DMA
>> ioctl returns error, which makes the application failed to start.
>>
>> To fix this issue, this patch introduces a new madvise behavior, named
>> as MADV_NOMOVABLE, to avoid allocating CMA pages and movable pages if
>> the users want to do longterm-pin, which can remove the possible failure
>> of movable or CMA pages migration.
> 
> Sorry to say, but that sounds like a hack to work around a kernel 
> implementation detail (how often we retry to migrate pages).

IMO, in our case one migration failure will make our application failed 
to start, which is not a trival problem. So mitigate the failure of 
migration can be important in this case.

> If there are CMA/ZONE_MOVABLE issue, please fix them instead, and avoid 
> leaking these details to user space.

Now we can not forbid the fallback to CMA allocation if there are enough 
free CMA in the zone, right? So adding a hint to help to diable 
ALLOC_CMA flag seems reasonable?

For CMA/ZONE_MOVABLE details, yes, not suitable to leak to user space. 
so how about rename the madvise as MADV_PINNABLE, which means we will do 
longterm-pin after allocation, and no CMA/ZONE_MOVABLE pages will be 
allocated.

Or do you have any good idea? Thanks.


> ALSO, with MAP_POPULATE as described by you this madvise flag doesn't 
> make too much sense, because it will gets et after all memory already 
> was allocated ...

This is not a problem I think, we can change to use MADV_POPULATE_XXX to 
preallocate the physical pages after MADV_NOMOVABLE madvise.
