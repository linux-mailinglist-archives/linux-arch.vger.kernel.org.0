Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D52604B44
	for <lists+linux-arch@lfdr.de>; Wed, 19 Oct 2022 17:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiJSP0W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 11:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbiJSP0G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 11:26:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3AB1D3A5C
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 08:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666192678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9yc2N/pKdu2A8Cjmwe1zmfRI9agpBmWdUITq821bvYM=;
        b=hNqMHUQQWC6gUs/z9NVISMJyqpdonachbArvMc9ZyaHUO/7CZmmqkhrEwcKXR93qEUvKMk
        I1olCzenFULpvMAiLVBerE9hbysBZYdtM/oaZ0SSV1FLLFTX+iqH7Eq5uPy7A3pbojRKK2
        YikZG/blN7kcDlbc3rGwBpUvebLc/pY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-271-dLaTaJ6POE-29fEqtl8xUA-1; Wed, 19 Oct 2022 11:17:49 -0400
X-MC-Unique: dLaTaJ6POE-29fEqtl8xUA-1
Received: by mail-wr1-f70.google.com with SMTP id h4-20020adfa4c4000000b0022ec3966c3aso5669139wrb.6
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 08:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9yc2N/pKdu2A8Cjmwe1zmfRI9agpBmWdUITq821bvYM=;
        b=PlJaMud4dF42E1Dh5iH/WvNxTv13c7Vh54ksma7sO+cqPqwSTWVYSpYOK/Rucswnc5
         Ynms02MbvF7pgE5eB4ZvDHfuxjgOI9kvZW7jfx5wpFtlXAzg/aV/RGg5k2xKGBm/CSNK
         oXiI1EJhhORK85I1H7sYnXitOS5DtKh10/MHj6QmN4nnXphaj/5Q/04lk2FHgC6FxVPC
         7ZuqEdb6LgioNNEL0z+rEHIOfri88lZOLhQojL0M+Ga5Ay59s1KZV+OBOrS6PZ9nh5+S
         fwxDo/5kZwz8pOdusefgV187p7pGplZ+7LpEGUuKVuSWIA77w4GqG+nfjproNwMP8jGF
         QNfA==
X-Gm-Message-State: ACrzQf1QksPKA4rAelC3Oz0ThK3JNbAGnGwuuz78COUF0CXKpr2T2QPu
        vv3nbhr58nHaAtgXNDSg87krCtD5bl+8Ke2K2pa7y+kWsVb7uqScex5DcVLza6YSYLw8qb+zGeq
        VyzfPDDMvHh3XGiNjZfdOpw==
X-Received: by 2002:adf:f5c2:0:b0:22f:992b:7d9f with SMTP id k2-20020adff5c2000000b0022f992b7d9fmr5245149wrp.601.1666192667158;
        Wed, 19 Oct 2022 08:17:47 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4u6AxE2UG0l1+i2fyQVLfnJM83y875n5T+/WAUTaKuw2NImPDVmh46xtd1Mw0W6NLqRZzaew==
X-Received: by 2002:adf:f5c2:0:b0:22f:992b:7d9f with SMTP id k2-20020adff5c2000000b0022f992b7d9fmr5245131wrp.601.1666192666896;
        Wed, 19 Oct 2022 08:17:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:2c00:d4ac:d2c:4aee:dac1? (p200300cbc7072c00d4ac0d2c4aeedac1.dip0.t-ipconnect.de. [2003:cb:c707:2c00:d4ac:d2c:4aee:dac1])
        by smtp.gmail.com with ESMTPSA id 62-20020a1c0241000000b003c6c76b43a1sm224080wmc.13.2022.10.19.08.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 08:17:46 -0700 (PDT)
Message-ID: <470dc638-a300-f261-94b4-e27250e42f96@redhat.com>
Date:   Wed, 19 Oct 2022 17:17:45 +0200
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
 <a83656e2-07b0-8a5f-40ae-077e23c4cd24@redhat.com>
 <c163ba0e-80d9-6362-b4f0-c5a2a12deec5@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH] mm: Introduce new MADV_NOMOVABLE behavior
In-Reply-To: <c163ba0e-80d9-6362-b4f0-c5a2a12deec5@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> I observed one migration failure case (which is not easy to reproduce)
> is that, the 'thp_migration_fail' count is 1 and the
> 'thp_split_page_failed' count is also 1.
> 
> That means when migrating a THP which is in CMA area, but can not
> allocate a new THP due to memory fragmentation, so it will split the
> THP. However THP split is also failed, probably the reason is temporary
> reference count of this THP. And the temporary reference count can be
> caused by dropping page caches (I observed the drop caches operation in
> the system), but we can not drop the shmem page caches due to they are
> already dirty at that time.
> 
> So we can try again in migrate_pages() if THP split is failed to
> mitigate the failure of migration, especially for the failure reason is
> temporary reference count? Does this sound reasonable for you?

It sound reasonable, and I understand that debugging these issues is 
tricky. But we really have to figure out the root cause to make these 
pages that are indeed movable (but only temporarily not movable for 
reason XYZ) movable.

We'd need some indication to retry migration longer / again.

> 
> However I still worried there are other possible cases to cause
> migration failure, so no CMA allocation for our case seems more stable IMO.

Yes, I can understand that. But as one example, you're approach doesn't 
handle the case that a page that was allocated on !CMA/!ZONE_MOVABLE 
would get migrated to CMA/ZONE_MOVABLE just before you would try pinning 
the page (to migrate it again off CMA/ZONE_MOVABLE).

We really have to fix the root cause.

-- 
Thanks,

David / dhildenb

