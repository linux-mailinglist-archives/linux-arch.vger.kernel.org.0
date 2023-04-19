Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2429D6E7473
	for <lists+linux-arch@lfdr.de>; Wed, 19 Apr 2023 09:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjDSHzK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Apr 2023 03:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjDSHzI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Apr 2023 03:55:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6B85FD1
        for <linux-arch@vger.kernel.org>; Wed, 19 Apr 2023 00:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681890851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ku4/Si8D6xrlYmDkiBxBM7QW/Zhm4h1GUH6h0hqbhBo=;
        b=KEl+iPBF+usjCmxggqrsRVXnav4zRJuun8FrN9XXc+MKcjf0bERK0b1H1FCAyzVksqFg77
        iEcyx6SxHhLMZKFKSu0kA8NOs/iFynlywZEXMJIbk9G4Rtkf34FiYn4HLI+tN9iYrZciI+
        o7nsSzj1VMsuNi31HJqUWJTCDeJhSus=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-wKS9qTt2NwevMF4ufKe4FA-1; Wed, 19 Apr 2023 03:54:09 -0400
X-MC-Unique: wKS9qTt2NwevMF4ufKe4FA-1
Received: by mail-wm1-f69.google.com with SMTP id ay3-20020a05600c1e0300b003f1728ce786so821387wmb.7
        for <linux-arch@vger.kernel.org>; Wed, 19 Apr 2023 00:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681890849; x=1684482849;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ku4/Si8D6xrlYmDkiBxBM7QW/Zhm4h1GUH6h0hqbhBo=;
        b=lQr5OvxYvZ6dNsT5281n2Q2qxzBinEBkSwGHp4oqv+lyJaSQMdoU9tpMHLMiv4JaNS
         GY42oINldmdLFyfc2EUAnOrLSnDrl6EebnH7SwgLU1jhIjzc/8x3Gnvy52/8ADa0MGr8
         b800NN2BukjCx2UlHm5EPpheE+276Fo/oz/srHfMpQqlq9zeHyeslGV8NHxOY+Rjk5rH
         Or1whXkBWip/6JEthoBjmnKJKzyFVdeSAnWFrbvn02J2682CobmCUiy5wBCDoc1Z3CUg
         UYhbizp63ARXY0tW68BOZKyrYR/O5jwzaeEF73K+B5h9TEsTB+gYpcwHPZVf574R+SPZ
         hVlQ==
X-Gm-Message-State: AAQBX9dwYouMiAQ68sWGrvQ0nBMJPxkjbVmq34q+1x6Q7FSsfUTJw9eX
        B/uq91vajqmiQXWutSTPdLcpmDeWBwebfgWam7Y+ldBPDYoB0/yxvxZNA03N2czms4nKKWO6GfK
        i59BMMHQotjhnUZqh/foglw==
X-Received: by 2002:a05:600c:2305:b0:3f1:728a:1881 with SMTP id 5-20020a05600c230500b003f1728a1881mr7565075wmo.31.1681890848810;
        Wed, 19 Apr 2023 00:54:08 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZGeCzv8hHHPCLoBp3+kn6wkQN0cMnv6OhMvvwsxXxMwENw712YUrmrVhvIskYHJBvgTLUksw==
X-Received: by 2002:a05:600c:2305:b0:3f1:728a:1881 with SMTP id 5-20020a05600c230500b003f1728a1881mr7565048wmo.31.1681890848428;
        Wed, 19 Apr 2023 00:54:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:7b00:7c52:a5fa:8004:96fd? (p200300cbc70b7b007c52a5fa800496fd.dip0.t-ipconnect.de. [2003:cb:c70b:7b00:7c52:a5fa:8004:96fd])
        by smtp.gmail.com with ESMTPSA id l26-20020a1ced1a000000b003eeb1d6a470sm1327085wmh.13.2023.04.19.00.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 00:54:08 -0700 (PDT)
Message-ID: <e0c0ad67-f23f-ff35-80bf-841dcfd43d99@redhat.com>
Date:   Wed, 19 Apr 2023 09:54:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Vishal Moola <vishal.moola@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org
References: <20230417205048.15870-1-vishal.moola@gmail.com>
 <20230417205048.15870-2-vishal.moola@gmail.com>
 <da600570-51c7-8088-b46b-7524c9e66e5d@redhat.com>
 <CAOzc2pwpRhNoFbdzdzuvrqbZdf2OsrTvBGs40QCZJjA5fS_q1A@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 01/33] s390: Use _pt_s390_gaddr for gmap address tracking
In-Reply-To: <CAOzc2pwpRhNoFbdzdzuvrqbZdf2OsrTvBGs40QCZJjA5fS_q1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 18.04.23 23:33, Vishal Moola wrote:
> On Tue, Apr 18, 2023 at 8:45 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 17.04.23 22:50, Vishal Moola (Oracle) wrote:
>>> s390 uses page->index to keep track of page tables for the guest address
>>> space. In an attempt to consolidate the usage of page fields in s390,
>>> replace _pt_pad_2 with _pt_s390_gaddr to replace page->index in gmap.
>>>
>>> This will help with the splitting of struct ptdesc from struct page, as
>>> well as allow s390 to use _pt_frag_refcount for fragmented page table
>>> tracking.
>>>
>>> Since page->_pt_s390_gaddr aliases with mapping, ensure its set to NULL
>>> before freeing the pages as well.
>>>
>>> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>>> ---
>>
>> [...]
>>
>>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>>> index 3fc9e680f174..2616d64c0e8c 100644
>>> --- a/include/linux/mm_types.h
>>> +++ b/include/linux/mm_types.h
>>> @@ -144,7 +144,7 @@ struct page {
>>>                struct {        /* Page table pages */
>>>                        unsigned long _pt_pad_1;        /* compound_head */
>>>                        pgtable_t pmd_huge_pte; /* protected by page->ptl */
>>> -                     unsigned long _pt_pad_2;        /* mapping */
>>> +                     unsigned long _pt_s390_gaddr;   /* mapping */
>>>                        union {
>>>                                struct mm_struct *pt_mm; /* x86 pgds only */
>>>                                atomic_t pt_frag_refcount; /* powerpc */
>>
>> The confusing part is, that these gmap page tables are not ordinary
>> process page tables that we would ordinarily place into this section
>> here. That's why they are also not allocated/freed using the typical
>> page table constructor/destructor ...
> 
> I initially thought the same, so I was quite confused when I saw
> __gmap_segment_gaddr was using pmd_pgtable_page().
> 
> Although they are not ordinary process page tables, since we
> eventually want to move them out of struct page, I think shifting them
> to be in ptdescs, being a memory descriptor for page tables, makes
> the most sense.

Seeing utilities like tlb_remove_page_ptdesc() that don't really apply 
to such page tables, I wonder if we should much rather treat such 
shadow/auxiliary/... page tables (just like other architectures like 
x86, arm, ... employ as well) as a distinct type.

And have ptdesc be the common type for all process page tables.

> 
> Another option is to leave pmd_pgtable_page() as is just for this case.
> Or we can revert commit 7e25de77bc5ea which uses the function here
> then figure out where these gmap pages table pages will go later.

I'm always confused when reading gmap code, so let me have another look :)

The confusing part is that s390x shares the lowest level page tables 
(PTE tables) between the process and gmap ("guest mapping", similar to 
EPT on x86-64). It maps these process PTE tables (covering 1 MiB) into 
gmap-specific PMD tables.

pmd_pgtable_page() should indeed always give us a gmap-specific 
PMD-table. In fact, something allocated via gmap_alloc_table().

Decoupling both concepts sounds like a good idea.

-- 
Thanks,

David / dhildenb

