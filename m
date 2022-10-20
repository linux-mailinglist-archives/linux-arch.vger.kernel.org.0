Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604C0605837
	for <lists+linux-arch@lfdr.de>; Thu, 20 Oct 2022 09:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiJTHRS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Oct 2022 03:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiJTHRC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Oct 2022 03:17:02 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110FE148F7F;
        Thu, 20 Oct 2022 00:16:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VSe4JAy_1666250126;
Received: from 30.97.48.62(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VSe4JAy_1666250126)
          by smtp.aliyun-inc.com;
          Thu, 20 Oct 2022 15:15:28 +0800
Message-ID: <70610ea1-5932-a19f-5eba-c4fba06335da@linux.alibaba.com>
Date:   Thu, 20 Oct 2022 15:15:26 +0800
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
 <c163ba0e-80d9-6362-b4f0-c5a2a12deec5@linux.alibaba.com>
 <470dc638-a300-f261-94b4-e27250e42f96@redhat.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <470dc638-a300-f261-94b4-e27250e42f96@redhat.com>
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



On 10/19/2022 11:17 PM, David Hildenbrand wrote:
>> I observed one migration failure case (which is not easy to reproduce)
>> is that, the 'thp_migration_fail' count is 1 and the
>> 'thp_split_page_failed' count is also 1.
>>
>> That means when migrating a THP which is in CMA area, but can not
>> allocate a new THP due to memory fragmentation, so it will split the
>> THP. However THP split is also failed, probably the reason is temporary
>> reference count of this THP. And the temporary reference count can be
>> caused by dropping page caches (I observed the drop caches operation in
>> the system), but we can not drop the shmem page caches due to they are
>> already dirty at that time.
>>
>> So we can try again in migrate_pages() if THP split is failed to
>> mitigate the failure of migration, especially for the failure reason is
>> temporary reference count? Does this sound reasonable for you?
> 
> It sound reasonable, and I understand that debugging these issues is 
> tricky. But we really have to figure out the root cause to make these 
> pages that are indeed movable (but only temporarily not movable for 
> reason XYZ) movable.
> 
> We'd need some indication to retry migration longer / again.

OK. Let me try this and see if there are other possible failure cases in 
the products.

>>
>> However I still worried there are other possible cases to cause
>> migration failure, so no CMA allocation for our case seems more stable 
>> IMO.
> 
> Yes, I can understand that. But as one example, you're approach doesn't 
> handle the case that a page that was allocated on !CMA/!ZONE_MOVABLE 
> would get migrated to CMA/ZONE_MOVABLE just before you would try pinning 
> the page (to migrate it again off CMA/ZONE_MOVABLE).

Indeed, like you said before, just helpful to minimize page migration 
now. Maybe I can take MADV_PINNABLE into considering when allocating new 
pages, such as alloc_migration_target().

Anyway let me try to fix the root cause first to see if it can solve our 
problem.

> We really have to fix the root cause.

OK. Thanks for your input.
