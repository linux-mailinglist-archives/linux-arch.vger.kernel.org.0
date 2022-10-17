Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96C7600DBB
	for <lists+linux-arch@lfdr.de>; Mon, 17 Oct 2022 13:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJQL1q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Oct 2022 07:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiJQL1a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2022 07:27:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3495F982
        for <linux-arch@vger.kernel.org>; Mon, 17 Oct 2022 04:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666006048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bGH9Zdddmn1G3Br6JkTmmzZUWrMZ3aJCiDnziiYbJRc=;
        b=i1Lhm7CIWPkE0onnSmAc3oSCXZst8Hhqn/VWZ5mV/iEkKtZqAwyIkUsB2ID9mp4xFrEC4z
        7fobY4UF+49HgizzwcXgUIl8o4AdxkX0+V+fzy4tUh4jvZL8IoUKyFoe1mSZLNTzKMJOd3
        8JUE9lhnl19I4TUH//bGZO/g1ulnKog=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-103-pJV4M3h4Pz22owpoMVz1iA-1; Mon, 17 Oct 2022 07:27:27 -0400
X-MC-Unique: pJV4M3h4Pz22owpoMVz1iA-1
Received: by mail-wr1-f70.google.com with SMTP id g4-20020adfbc84000000b0022fc417f87cso3609120wrh.12
        for <linux-arch@vger.kernel.org>; Mon, 17 Oct 2022 04:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bGH9Zdddmn1G3Br6JkTmmzZUWrMZ3aJCiDnziiYbJRc=;
        b=3Wjv+Lq9/oYNtRHFO730hLju655La1cKQ6d5DAjRM6+2UrXHX95bZ7ZFb0eVfvT74d
         l0JHV6uWv0ZnICNjnEPTw0zFOYRznWxmFpQ1KHlrIfdX3K8t32kxlxFIvTUTWjpSI/+Z
         /p/H3v89V6f7cuA2E4BBk6TbIvnQOyEGVp9GTgKvElYYWBBcEQ932YHrUuqxCI4pBF6m
         nBd2AxTcqyWBaZDvuP63u6h/fmCvZEOWXHhFCq0RX5tgUCF+R0wlrI74Ir1o2JTsJpax
         mPXxYK+LY2Q2yIsaqpXjOPKsCCJqAMX1nkAF+j0FNRPh9HzyvNB5rShrYxzNlZ7HChmv
         FoWg==
X-Gm-Message-State: ACrzQf0aMeYfT++HCb0FI86PDx0/DHrV3Ric4A2KguwaFuZFYf5nE/oD
        yenmv2aEi5Vwt2gbH861SuNu8nFWZWL6BkT6EXALGbllCFszD2mWc9nv21oukgy924f9Z3m8yZX
        HT9rRJLGj6V57+hGoJE164Q==
X-Received: by 2002:adf:d842:0:b0:22e:33e2:f379 with SMTP id k2-20020adfd842000000b0022e33e2f379mr5758281wrl.23.1666006046482;
        Mon, 17 Oct 2022 04:27:26 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4Kvz5id6HZOC9QTd4Wc7N8RB+Y9HN7WUbMZCORphKnB3Rk0JATW+xIueW/y00yJUTBR4GOgQ==
X-Received: by 2002:adf:d842:0:b0:22e:33e2:f379 with SMTP id k2-20020adfd842000000b0022e33e2f379mr5758262wrl.23.1666006046160;
        Mon, 17 Oct 2022 04:27:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:a00:37ed:519:6c33:4dc8? (p200300cbc70a0a0037ed05196c334dc8.dip0.t-ipconnect.de. [2003:cb:c70a:a00:37ed:519:6c33:4dc8])
        by smtp.gmail.com with ESMTPSA id s16-20020a5d4250000000b0022e47b57735sm8105509wrr.97.2022.10.17.04.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 04:27:25 -0700 (PDT)
Message-ID: <a83656e2-07b0-8a5f-40ae-077e23c4cd24@redhat.com>
Date:   Mon, 17 Oct 2022 13:27:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     arnd@arndb.de, jingshan@linux.alibaba.com, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <bc27af32b0418ed1138a1c3a41e46f54559025a5.1665991453.git.baolin.wang@linux.alibaba.com>
 <6227ba4c-9455-9652-7434-7842b2b3edcb@redhat.com>
 <8007f4fc-d2e6-7aae-7297-805326adce2a@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH] mm: Introduce new MADV_NOMOVABLE behavior
In-Reply-To: <8007f4fc-d2e6-7aae-7297-805326adce2a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 17.10.22 11:09, Baolin Wang wrote:
> 
> 
> On 10/17/2022 4:41 PM, David Hildenbrand wrote:
>> On 17.10.22 09:32, Baolin Wang wrote:
>>> When creating a virtual machine, we will use memfd_create() to get
>>> a file descriptor which can be used to create share memory mappings
>>> using the mmap function, meanwhile the mmap() will set the MAP_POPULATE
>>> flag to allocate physical pages for the virtual machine.
>>>
>>> When allocating physical pages for the guest, the host can fallback to
>>> allocate some CMA pages for the guest when over half of the zone's free
>>> memory is in the CMA area.
>>>
>>> In guest os, when the application wants to do some data transaction with
>>> DMA, our QEMU will call VFIO_IOMMU_MAP_DMA ioctl to do longterm-pin and
>>> create IOMMU mappings for the DMA pages. However, when calling
>>> VFIO_IOMMU_MAP_DMA ioctl to pin the physical pages, we found it will be
>>> failed to longterm-pin sometimes.
>>>
>>> After some invetigation, we found the pages used to do DMA mapping can
>>> contain some CMA pages, and these CMA pages will cause a possible
>>> failure of the longterm-pin, due to failed to migrate the CMA pages.
>>> The reason of migration failure may be temporary reference count or
>>> memory allocation failure. So that will cause the VFIO_IOMMU_MAP_DMA
>>> ioctl returns error, which makes the application failed to start.
>>>
>>> To fix this issue, this patch introduces a new madvise behavior, named
>>> as MADV_NOMOVABLE, to avoid allocating CMA pages and movable pages if
>>> the users want to do longterm-pin, which can remove the possible failure
>>> of movable or CMA pages migration.
>>
>> Sorry to say, but that sounds like a hack to work around a kernel
>> implementation detail (how often we retry to migrate pages).
> 
> IMO, in our case one migration failure will make our application failed
> to start, which is not a trival problem. So mitigate the failure of
> migration can be important in this case.

The right thing to do is to understand why these migrations fail and see 
if we can improve the migration code.

> 
>> If there are CMA/ZONE_MOVABLE issue, please fix them instead, and avoid
>> leaking these details to user space.
> 
> Now we can not forbid the fallback to CMA allocation if there are enough
> free CMA in the zone, right? So adding a hint to help to diable
> ALLOC_CMA flag seems reasonable?
> 
> For CMA/ZONE_MOVABLE details, yes, not suitable to leak to user space.
> so how about rename the madvise as MADV_PINNABLE, which means we will do
> longterm-pin after allocation, and no CMA/ZONE_MOVABLE pages will be
> allocated.
> 

I really don't think any of these new user-visible madv modes with 
questionable semantics to workaround kernel implementation issues are a 
good idea.

Especially MADV_PINNABLE has a *very* misleading name.


I understand that something like "MADV_MIGHT_PIN" *might* be helpful to 
minimize page migration. But IMHO that could only be a pure 
optimization, but wouldn't stop us from allocating (or migrating to) 
CMA/ZONE_MOVABLE in the kernel on all code paths. It would be best 
effort only.

It's not user space decision how/where the kernel allocates memory. No 
hacking around that.

> Or do you have any good idea? Thanks.

Investigate why migration of these pages fails and how we can improve 
the code to make migration of these pages work more reliably.

I am not completely against having a kernel parameter that would disable 
allocating from CMA areas completely, even though it defeats the purpose 
of CMA. But it wouldn't apply to ZONE_MOVABLE, so it would be just 
another hackish approach.

> 
>> ALSO, with MAP_POPULATE as described by you this madvise flag doesn't
>> make too much sense, because it will gets et after all memory already
>> was allocated ...
> 
> This is not a problem I think, we can change to use MADV_POPULATE_XXX to
> preallocate the physical pages after MADV_NOMOVABLE madvise.

Yes, I know; I'm pointing out that your patch description is inconsistent.

-- 
Thanks,

David / dhildenb

