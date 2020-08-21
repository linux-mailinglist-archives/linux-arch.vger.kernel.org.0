Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD16D24D8D9
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 17:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgHUPis (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 11:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgHUPif (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 11:38:35 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD96C061573;
        Fri, 21 Aug 2020 08:38:34 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y6so1042874plt.3;
        Fri, 21 Aug 2020 08:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kco/6vI1blM/NwfzBHIDs3oyI1qAQDpBfmbjozxRSNk=;
        b=Mqf3QLSjkioKMk0zBDuIglw6zdeZUKHZ1HQUwduW7GDONUqZycokbVPPLpKEOpQl4b
         PDAb2rY3stSYZvKhK1ciDdXI9QFuSd5868ZADYj2vkdJQuduZNKyrfw/bl/VOhAJoTHE
         5SQ3KeiX1D57s96SJHQo5n9Kx3TDPfJxYN6T73LU2hqZcH37Y2pQK8ncVnOIHTCw+dH9
         JH5LBDlhrptca3/0S5Ff7Fwp+Av93sdvs2f7yyKFqjraHST6wJ+2aZBaDb4HvmRbJ8cZ
         Ev10EsauM4bU6+fZB47gY9myTYHuYjfP5cXd8jqrKQ0astUglqR98D7equtA387ONVto
         1OLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kco/6vI1blM/NwfzBHIDs3oyI1qAQDpBfmbjozxRSNk=;
        b=bSSeUfLwWjDSN2g/2HCvNOeIkT0JO3x3ZwmKsv9qy3v61B3U0ef8QmkScyE3RAIuf8
         3GrzDl7vypiMDg1u/sZJjo0eVG5Ax/o8Zrog4sRF1fz48yjGoN3Ugn/kWr8fS7/l+FFW
         3kybaQFHoi6cX71V6gH39PYFhE0hO7O49PYhRoaGQ8iI6nrqk80wXGjtZQTpgO5naPcZ
         9r7WSk5KL+bYW/lHls3ZTSACpuRKwU4WnPUO30UPM03i9yjU+FHQzvg5qhvqqyTJcCnC
         9luI06+rHSl/AOlQWEhx01oQ7Ced1CnKJieDL1XC1EloO3rC4YWRPtBtlct1MYR2IRsu
         7b/Q==
X-Gm-Message-State: AOAM531Y6dw3haM9DIny4DOjrTl3IQOWmnuYyPhwJhGPBTR3vbQ3EPXP
        TvA8DaeKDOpIMERY0yU0jpo=
X-Google-Smtp-Source: ABdhPJwru3LiGVN0/RGun5gHVd79iZu23NuOL+aXtjWUQONE0O/idm7t/GaI88fUhyFkLtAmK/d3Rw==
X-Received: by 2002:a17:90a:ba05:: with SMTP id s5mr1612246pjr.114.1598024313966;
        Fri, 21 Aug 2020 08:38:33 -0700 (PDT)
Received: from [10.1.10.11] (c-73-241-150-58.hsd1.ca.comcast.net. [73.241.150.58])
        by smtp.gmail.com with ESMTPSA id q207sm2581667pgq.71.2020.08.21.08.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 08:38:33 -0700 (PDT)
Subject: Re: [PATCH v6 11/12] mm/vmalloc: Hugepage vmalloc mappings
To:     Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20200821151216.1005117-1-npiggin@gmail.com>
 <20200821151216.1005117-12-npiggin@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <1e001c2c-6c47-21a9-e920-caf78933b713@gmail.com>
Date:   Fri, 21 Aug 2020 08:38:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821151216.1005117-12-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 8/21/20 8:12 AM, Nicholas Piggin wrote:
> Support huge page vmalloc mappings. Config option HAVE_ARCH_HUGE_VMALLOC
> enables support on architectures that define HAVE_ARCH_HUGE_VMAP and
> supports PMD sized vmap mappings.
> 
> vmalloc will attempt to allocate PMD-sized pages if allocating PMD size or
> larger, and fall back to small pages if that was unsuccessful.
> 
> Allocations that do not use PAGE_KERNEL prot are not permitted to use huge
> pages, because not all callers expect this (e.g., module allocations vs
> strict module rwx).
> 
> This reduces TLB misses by nearly 30x on a `git diff` workload on a 2-node
> POWER9 (59,800 -> 2,100) and reduces CPU cycles by 0.54%.
> 
> This can result in more internal fragmentation and memory overhead for a
> given allocation, an option nohugevmalloc is added to disable at boot.
> 
>

Thanks for working on this stuff, I tried something similar in the past,
but could not really do more than a hack.
( https://lkml.org/lkml/2016/12/21/285 )

Note that __init alloc_large_system_hash() is used at boot time,
when NUMA policy is spreading allocations over all NUMA nodes.

This means that on a dual node system, a hash table should be 50/50 spread.

With your patch, if a hashtable is exactly the size of one huge page,
the location of this hashtable will be not balanced, this might have some
unwanted impact.

Thanks !

