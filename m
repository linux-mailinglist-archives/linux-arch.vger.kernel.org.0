Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6036C3349
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 14:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjCUNuM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 09:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjCUNuL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 09:50:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CE742BD0
        for <linux-arch@vger.kernel.org>; Tue, 21 Mar 2023 06:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679406543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yI/bZ8IYt/rjw4KBzfWVe1iqPY2paEeLBiaCSNShT/4=;
        b=M8gO2I7esSRQV9kq6iltwZvSsokM9mVhZjTUc1F6jDe8WyKdBynpx/SBEZJq9qXbMekz9O
        FHZFkFmg0Q8mSzqsmoQCQY065XC8rIYu7xsyhIGnVLJeDdW6RhqNbvAw7w35T6XQECnL8+
        Iz0+AWps+ky6Q3qwdTHLOP8PrbNZWWQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-zEVL3jGmP3WEW3Y-dPRONA-1; Tue, 21 Mar 2023 09:49:01 -0400
X-MC-Unique: zEVL3jGmP3WEW3Y-dPRONA-1
Received: by mail-wm1-f69.google.com with SMTP id iv18-20020a05600c549200b003ee21220fccso1463537wmb.1
        for <linux-arch@vger.kernel.org>; Tue, 21 Mar 2023 06:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679406540;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yI/bZ8IYt/rjw4KBzfWVe1iqPY2paEeLBiaCSNShT/4=;
        b=QydsTG5/nkFbPUc6wY7DqCG4EFKIY7fvTVLDJbo5yG1l4otHfGklo0hYIQ5mwlFQzD
         cKRvXYn3/nD5NHgZB6f+zmAzRuvd1IwVeAI0vcIEExb3AqbCDTDRt+pLI1gnOZWa+1B6
         ttC7j5JuUPy3choJX5BMaHAOiOray1YdAwjIQUcCQX7y0hY6Y4jN4s39k8okXjFN7qOo
         xPWvBWdvHK9Parl+/GIAFVDxXuSWI8cQ2Z0BbHeqYBopwnaOIWC5lZYQmBsxdVu5k8ta
         yqKTsv1HC+qqhgbNVK1h09evuMCJJC3G4rXFEmO+xuVS3ARyPsdOv2ONXSRxVH2cCOnA
         UK2w==
X-Gm-Message-State: AO0yUKWPuB4f3nrqWnqAJtOwpYaYjnxqqUtdM949tvutEoAbOl1++hQz
        zhSby1yyl4Qk2QjU32vHKQtve4YSjaSkREARz4q0e234CEPVk/MwqaoHaPkWLeQc2g3AsvI5Kzo
        z++v++GD0kr7Jg50nkLQW+Q==
X-Received: by 2002:adf:f58d:0:b0:2ce:9e0a:10ae with SMTP id f13-20020adff58d000000b002ce9e0a10aemr2179544wro.53.1679406539838;
        Tue, 21 Mar 2023 06:48:59 -0700 (PDT)
X-Google-Smtp-Source: AK7set9EKsVvw5U/yPPbi9tGukgfJCx6ovbrD4timB/FgzFRRnJM6NTECZsQavMRWFZ67rCTApC7lA==
X-Received: by 2002:adf:f58d:0:b0:2ce:9e0a:10ae with SMTP id f13-20020adff58d000000b002ce9e0a10aemr2179532wro.53.1679406539539;
        Tue, 21 Mar 2023 06:48:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7f00:8245:d031:7f8b:e004? (p200300cbc7057f008245d0317f8be004.dip0.t-ipconnect.de. [2003:cb:c705:7f00:8245:d031:7f8b:e004])
        by smtp.gmail.com with ESMTPSA id c10-20020adffb0a000000b002c70c99db74sm11353849wrr.86.2023.03.21.06.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 06:48:59 -0700 (PDT)
Message-ID: <d9ca4727-76c0-8b1f-ca57-effca446fbb6@redhat.com>
Date:   Tue, 21 Mar 2023 14:48:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCHv2] mm/page_alloc: Make deferred page init free pages in
 MAX_ORDER blocks
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230321002415.20843-1-kirill.shutemov@linux.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230321002415.20843-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 21.03.23 01:24, Kirill A. Shutemov wrote:
> Normal page init path frees pages during the boot in MAX_ORDER chunks,
> but deferred page init path does it in pageblock blocks.
> 
> Change deferred page init path to work in MAX_ORDER blocks.
> 
> For cases when MAX_ORDER is larger than pageblock, set migrate type to
> MIGRATE_MOVABLE for all pageblocks covered by the page.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
> 
> Note: the patch depends on the new definiton of MAX_ORDER.
> 
> v2:
> 
>   - Fix commit message;
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

