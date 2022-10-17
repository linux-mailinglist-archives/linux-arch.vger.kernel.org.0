Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1466C6008E5
	for <lists+linux-arch@lfdr.de>; Mon, 17 Oct 2022 10:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiJQIl6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Oct 2022 04:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiJQIl6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2022 04:41:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63BE2AC45
        for <linux-arch@vger.kernel.org>; Mon, 17 Oct 2022 01:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665996116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AYu+Olly91MbNGXLgDC9bc9k1FpmlocPO3fPhrKXidQ=;
        b=QC/3LJWPgKdK1nUuEI0z2j1jGejRKjMXiVp5pX31dxLOAOoLLTfY9RzAovGX/tSCW9vuEN
        Sf13qaaQScntkQ3pEtJ45FSlSm10J12dSXxYe9DnFLj25Ctp9S1ZevsAKOHAi3hXQLAdw9
        ibQIX2wrWUCte1FkyiEAI5KxcrDyk10=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-418-eAMSp4PVPXC20ZS6s-tXog-1; Mon, 17 Oct 2022 04:41:55 -0400
X-MC-Unique: eAMSp4PVPXC20ZS6s-tXog-1
Received: by mail-wr1-f69.google.com with SMTP id p7-20020adfba87000000b0022cc6f805b1so3480360wrg.21
        for <linux-arch@vger.kernel.org>; Mon, 17 Oct 2022 01:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYu+Olly91MbNGXLgDC9bc9k1FpmlocPO3fPhrKXidQ=;
        b=h1DfJWpCJ808axtCG0OjH8VSDUxAHl1ZQitP1ZhIOlkR7oAguHkKhZGMZvzhzUhvdG
         v2gq5oaVAcfVjtCWwyMquFdybLEAroqquX0AzIwXVgNU2fQ0x7aVGGzYQg9DbCaG97PA
         czXsPxEAXjx4TW2gXixZcKA7662qJJceq++Z2TGv4piAmySu1/Y85AYJNlmkEPcGiAH6
         CXzKqag9YK267E9zzQWB1nYeUU8AMYBnzSqtZbr2qcwrMKfPnSggsgxPywkvyKmc8viD
         oyCrwgvF04L0nnHa5dfMgoRLE3MALCnHk4y4jmY1iM/iCEMU27chiCWgNZPNaGscwTUv
         /DIA==
X-Gm-Message-State: ACrzQf3AGBSAL5FT9WtJbZMGEwPRPZDta+XKo3lx4WkW3lisGF/uI+M6
        sdNvdYqm/4Yke143fOYenVRRlP/zpqRhpjopumzrM8/N6yF1lNJd+11WJwHwk24FJ4GVW0jzzr/
        zZlAYJ+uanJFeKPaSfjiRTQ==
X-Received: by 2002:a7b:c5c2:0:b0:3c4:fd96:fb68 with SMTP id n2-20020a7bc5c2000000b003c4fd96fb68mr6474791wmk.36.1665996114160;
        Mon, 17 Oct 2022 01:41:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM44s/3N3JjFxznWXGrQX+rdkuNXuUerrs1tO5v7ve4FrMytiiusaeyg5H7HECTjpmjok+oUpw==
X-Received: by 2002:a7b:c5c2:0:b0:3c4:fd96:fb68 with SMTP id n2-20020a7bc5c2000000b003c4fd96fb68mr6474777wmk.36.1665996113848;
        Mon, 17 Oct 2022 01:41:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:2300:e5ce:21ba:1d93:4323? (p200300cbc7072300e5ce21ba1d934323.dip0.t-ipconnect.de. [2003:cb:c707:2300:e5ce:21ba:1d93:4323])
        by smtp.gmail.com with ESMTPSA id v1-20020adfedc1000000b00228daaa84aesm7881318wro.25.2022.10.17.01.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 01:41:53 -0700 (PDT)
Message-ID: <6227ba4c-9455-9652-7434-7842b2b3edcb@redhat.com>
Date:   Mon, 17 Oct 2022 10:41:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC PATCH] mm: Introduce new MADV_NOMOVABLE behavior
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     arnd@arndb.de, jingshan@linux.alibaba.com, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <bc27af32b0418ed1138a1c3a41e46f54559025a5.1665991453.git.baolin.wang@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <bc27af32b0418ed1138a1c3a41e46f54559025a5.1665991453.git.baolin.wang@linux.alibaba.com>
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

On 17.10.22 09:32, Baolin Wang wrote:
> When creating a virtual machine, we will use memfd_create() to get
> a file descriptor which can be used to create share memory mappings
> using the mmap function, meanwhile the mmap() will set the MAP_POPULATE
> flag to allocate physical pages for the virtual machine.
> 
> When allocating physical pages for the guest, the host can fallback to
> allocate some CMA pages for the guest when over half of the zone's free
> memory is in the CMA area.
> 
> In guest os, when the application wants to do some data transaction with
> DMA, our QEMU will call VFIO_IOMMU_MAP_DMA ioctl to do longterm-pin and
> create IOMMU mappings for the DMA pages. However, when calling
> VFIO_IOMMU_MAP_DMA ioctl to pin the physical pages, we found it will be
> failed to longterm-pin sometimes.
> 
> After some invetigation, we found the pages used to do DMA mapping can
> contain some CMA pages, and these CMA pages will cause a possible
> failure of the longterm-pin, due to failed to migrate the CMA pages.
> The reason of migration failure may be temporary reference count or
> memory allocation failure. So that will cause the VFIO_IOMMU_MAP_DMA
> ioctl returns error, which makes the application failed to start.
> 
> To fix this issue, this patch introduces a new madvise behavior, named
> as MADV_NOMOVABLE, to avoid allocating CMA pages and movable pages if
> the users want to do longterm-pin, which can remove the possible failure
> of movable or CMA pages migration.

Sorry to say, but that sounds like a hack to work around a kernel 
implementation detail (how often we retry to migrate pages).

If there are CMA/ZONE_MOVABLE issue, please fix them instead, and avoid 
leaking these details to user space.

ALSO, with MAP_POPULATE as described by you this madvise flag doesn't 
make too much sense, because it will gets et after all memory already 
was allocated ...

NAK

-- 
Thanks,

David / dhildenb

