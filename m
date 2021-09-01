Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A6F3FD762
	for <lists+linux-arch@lfdr.de>; Wed,  1 Sep 2021 12:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbhIAKMG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Sep 2021 06:12:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43883 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232258AbhIAKMG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Sep 2021 06:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630491069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Qvu8f0am/SlQm3BBQ8kcFlHtYY52i34qaBeBiT+B1I=;
        b=T8VIOQHUDwIg3VynN9vqrVNDYQqDsRwTTWjKkKZGdTkCusKOZAW+3vEp+EisKyNixhY7ac
        Sh7a0Y9Vn2hBHwYRdguBga+0E/bsYhwUw1NqA8rI1cX1C3d1zMDqB5QFg/xIArENR5xm9k
        uG3OQyaEo/zCiihAKzPMKyyzWWQNOOs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-fx4rBQ2KM-my03n3IPPzxg-1; Wed, 01 Sep 2021 06:11:08 -0400
X-MC-Unique: fx4rBQ2KM-my03n3IPPzxg-1
Received: by mail-wm1-f70.google.com with SMTP id r125-20020a1c2b830000b0290197a4be97b7so827721wmr.9
        for <linux-arch@vger.kernel.org>; Wed, 01 Sep 2021 03:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5Qvu8f0am/SlQm3BBQ8kcFlHtYY52i34qaBeBiT+B1I=;
        b=sBFBwOdWWT8zifpqnQAJGwB2/FnCTYfX7KPgami0HST5Cw5ELrRc3NDFD5cb7xVkaZ
         9+jvJJXSqej93gcKGVa8cvukII71+6TgVlFnEVAnIYlsICLhRlWPDeVJ0jSmQFs9zYP0
         LNAv5BWEe4Ya/5UG1ZlasGUXz/0murkoWqwMKHWhu37H9T1o7dbwTWy9zTHTE/J2gQHR
         XYSqxWMs0+vLKpljU4o1NuMFg9N/lD2/FBrfWqnkoXTcG9n7pWg1snMcE6YmrzJnS+c5
         QLZA0jL+8Fxj7PyYyMc9aTqbe9MpMJ4FIa72sgawOa9Avs8it3XLKx7EXMXBOrLjX4M0
         AukQ==
X-Gm-Message-State: AOAM530QRx+GzTeGcX0UY6akUFsMz+RjicZ9ywQjrODaGPCASLavdMLu
        NJkOzUzj0UpZy+x19j8fqrRc0MkXZ6tCmDR+Hzghr7OHOjYg1Sr8fhKeRxCAIt7Glv+ZwKBDWzP
        e9dNGxEj044FWrIGrg+BWgA==
X-Received: by 2002:adf:dbd0:: with SMTP id e16mr36434446wrj.402.1630491066748;
        Wed, 01 Sep 2021 03:11:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoJvOC5ivwrzHTukER5oblEKCEnKLApZDh0Fa4VvnmniV9qnGBK5T9FaXi46sq4fgGHu226Q==
X-Received: by 2002:adf:dbd0:: with SMTP id e16mr36434410wrj.402.1630491066497;
        Wed, 01 Sep 2021 03:11:06 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23f71.dip0.t-ipconnect.de. [79.242.63.113])
        by smtp.gmail.com with ESMTPSA id u26sm19587498wrd.32.2021.09.01.03.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 03:11:06 -0700 (PDT)
Subject: Re: [PATCH 1/1] mm/early_ioremap.c: remove redundant
 early_ioremap_shutdown()
To:     Weizhao Ouyang <o451686892@gmail.com>, arnd@arndb.de,
        akpm@linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20210901082917.399953-1-o451686892@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <7ca43a9f-b62d-26df-0b9c-1cfa2f7dc611@redhat.com>
Date:   Wed, 1 Sep 2021 12:11:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901082917.399953-1-o451686892@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 01.09.21 10:29, Weizhao Ouyang wrote:
> early_ioremap_reset() reserved a weak function so that architectures can
> provide a specific cleanup. Now no architectures use it, remove this
> redundant function.
> 
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> ---
>   include/asm-generic/early_ioremap.h | 6 ------
>   mm/early_ioremap.c                  | 5 -----
>   2 files changed, 11 deletions(-)
> 
> diff --git a/include/asm-generic/early_ioremap.h b/include/asm-generic/early_ioremap.h
> index 9def22e6e2b3..9d0479f50f97 100644
> --- a/include/asm-generic/early_ioremap.h
> +++ b/include/asm-generic/early_ioremap.h
> @@ -19,12 +19,6 @@ extern void *early_memremap_prot(resource_size_t phys_addr,
>   extern void early_iounmap(void __iomem *addr, unsigned long size);
>   extern void early_memunmap(void *addr, unsigned long size);
>   
> -/*
> - * Weak function called by early_ioremap_reset(). It does nothing, but
> - * architectures may provide their own version to do any needed cleanups.
> - */
> -extern void early_ioremap_shutdown(void);
> -
>   #if defined(CONFIG_GENERIC_EARLY_IOREMAP) && defined(CONFIG_MMU)
>   /* Arch-specific initialization */
>   extern void early_ioremap_init(void);
> diff --git a/mm/early_ioremap.c b/mm/early_ioremap.c
> index 164607c7cdf1..74984c23a87e 100644
> --- a/mm/early_ioremap.c
> +++ b/mm/early_ioremap.c
> @@ -38,13 +38,8 @@ pgprot_t __init __weak early_memremap_pgprot_adjust(resource_size_t phys_addr,
>   	return prot;
>   }
>   
> -void __init __weak early_ioremap_shutdown(void)
> -{
> -}
> -
>   void __init early_ioremap_reset(void)
>   {
> -	early_ioremap_shutdown();
>   	after_paging_init = 1;
>   }
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

