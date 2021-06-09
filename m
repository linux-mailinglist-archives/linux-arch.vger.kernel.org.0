Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DCC3A11DA
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jun 2021 12:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238041AbhFIK6D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Jun 2021 06:58:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45470 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238599AbhFIK57 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jun 2021 06:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623236164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1eqcq/7KVFIFfww4JdqqnK/TUbif/qCxlnaAkIZ26tg=;
        b=XhbkTzLIxP/kCPYbdPkz2lNjcWWrTTwywSkuukPJX/ZGLAYCdC1RPoHuQWS0UbqoDw+MHH
        zHDpk7smthFA9q0TfeDrDNVCaxlhFEUKjKiwLCRw6HYWaBAwW6ECJIbHwP6wu40yxFzrK1
        x3ggkJKDQZ3GflUqR9fny9V7F4193AU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-9gGH4t77McCr2liFkE1Pvg-1; Wed, 09 Jun 2021 06:56:03 -0400
X-MC-Unique: 9gGH4t77McCr2liFkE1Pvg-1
Received: by mail-wr1-f70.google.com with SMTP id k25-20020a5d52590000b0290114dee5b660so10621899wrc.16
        for <linux-arch@vger.kernel.org>; Wed, 09 Jun 2021 03:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1eqcq/7KVFIFfww4JdqqnK/TUbif/qCxlnaAkIZ26tg=;
        b=pnfpYOVWIOaPgMF0LN4GaFyl3FemYeIjfz5TwhVYr7X8/22eToOH5JHk5bXeX7zCnV
         3cjwcFFx+gFq/Y+n4adwHd+oqNFRMlfQA4BERne0ZE9mr/Ll4RlHQrf+acNAy3ebaw6U
         q5TQqd++ljOzJRwZgr9/C/hXHbYAbX9fuYRedP+1DLcwHI9q/tMVB1ye2lm8tSWhN+L4
         kdm7BUbgrlU/XZ6LqPdxi1qQCVXlnnolFOReEOGohiJbaFkmdi0rAydYoWtzKJzRFNlJ
         mNlueZ72ezagostoHKQoh2RrMIs0/jMYZNM1Fs87DacpHnfpOLEjoOgsxNIv6LHvLS+a
         rzNw==
X-Gm-Message-State: AOAM530ux5T27ICH8x0G+qvnAUm/nb6fXtLT+F4zNjjXaJRGRPR1fFkD
        teSKOjjVb/AtZ5rtljftchCY/2ym62aOg4zAJHqfRam51luyhM9XNoDD+VLJpsGNqPZkaNegVPL
        2mMWzMlunUmda3YeR+kcP2g==
X-Received: by 2002:adf:ee46:: with SMTP id w6mr28365898wro.345.1623236162280;
        Wed, 09 Jun 2021 03:56:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQ49r+tRbGd1wOHU0mXbY7urMjvAihHVmP4oVaZtHRm+k2OFRov+Lj+Vo8CLpAoo+a81y7uQ==
X-Received: by 2002:adf:ee46:: with SMTP id w6mr28365871wro.345.1623236162032;
        Wed, 09 Jun 2021 03:56:02 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c611d.dip0.t-ipconnect.de. [91.12.97.29])
        by smtp.gmail.com with ESMTPSA id a4sm21295711wme.45.2021.06.09.03.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 03:56:01 -0700 (PDT)
Subject: Re: [PATCH 7/9] docs: remove description of DISCONTIGMEM
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        Vineet Gupta <vgupta@synopsys.com>, kexec@lists.infradead.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
References: <20210602105348.13387-1-rppt@kernel.org>
 <20210602105348.13387-8-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <6b92d273-dd0b-d67f-c2f6-cce13a33afd1@redhat.com>
Date:   Wed, 9 Jun 2021 12:56:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210602105348.13387-8-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 02.06.21 12:53, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Remove description of DISCONTIGMEM from the "Memory Models" document and
> update VM sysctl description so that it won't mention DISCONIGMEM.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>   Documentation/admin-guide/sysctl/vm.rst | 12 +++----
>   Documentation/vm/memory-model.rst       | 45 ++-----------------------
>   2 files changed, 8 insertions(+), 49 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index 586cd4b86428..ddbd71d592e0 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -936,12 +936,12 @@ allocations, THP and hugetlbfs pages.
>   
>   To make it sensible with respect to the watermark_scale_factor
>   parameter, the unit is in fractions of 10,000. The default value of
> -15,000 on !DISCONTIGMEM configurations means that up to 150% of the high
> -watermark will be reclaimed in the event of a pageblock being mixed due
> -to fragmentation. The level of reclaim is determined by the number of
> -fragmentation events that occurred in the recent past. If this value is
> -smaller than a pageblock then a pageblocks worth of pages will be reclaimed
> -(e.g.  2MB on 64-bit x86). A boost factor of 0 will disable the feature.
> +15,000 means that up to 150% of the high watermark will be reclaimed in the
> +event of a pageblock being mixed due to fragmentation. The level of reclaim
> +is determined by the number of fragmentation events that occurred in the
> +recent past. If this value is smaller than a pageblock then a pageblocks
> +worth of pages will be reclaimed (e.g.  2MB on 64-bit x86). A boost factor
> +of 0 will disable the feature.
>   
>   
>   watermark_scale_factor
> diff --git a/Documentation/vm/memory-model.rst b/Documentation/vm/memory-model.rst
> index ce398a7dc6cd..30e8fbed6914 100644
> --- a/Documentation/vm/memory-model.rst
> +++ b/Documentation/vm/memory-model.rst
> @@ -14,15 +14,11 @@ for the CPU. Then there could be several contiguous ranges at
>   completely distinct addresses. And, don't forget about NUMA, where
>   different memory banks are attached to different CPUs.
>   
> -Linux abstracts this diversity using one of the three memory models:
> -FLATMEM, DISCONTIGMEM and SPARSEMEM. Each architecture defines what
> +Linux abstracts this diversity using one of the two memory models:
> +FLATMEM and SPARSEMEM. Each architecture defines what
>   memory models it supports, what the default memory model is and
>   whether it is possible to manually override that default.
>   
> -.. note::
> -   At time of this writing, DISCONTIGMEM is considered deprecated,
> -   although it is still in use by several architectures.
> -
>   All the memory models track the status of physical page frames using
>   struct page arranged in one or more arrays.
>   
> @@ -63,43 +59,6 @@ straightforward: `PFN - ARCH_PFN_OFFSET` is an index to the
>   The `ARCH_PFN_OFFSET` defines the first page frame number for
>   systems with physical memory starting at address different from 0.
>   
> -DISCONTIGMEM
> -============
> -
> -The DISCONTIGMEM model treats the physical memory as a collection of
> -`nodes` similarly to how Linux NUMA support does. For each node Linux
> -constructs an independent memory management subsystem represented by
> -`struct pglist_data` (or `pg_data_t` for short). Among other
> -things, `pg_data_t` holds the `node_mem_map` array that maps
> -physical pages belonging to that node. The `node_start_pfn` field of
> -`pg_data_t` is the number of the first page frame belonging to that
> -node.
> -
> -The architecture setup code should call :c:func:`free_area_init_node` for
> -each node in the system to initialize the `pg_data_t` object and its
> -`node_mem_map`.
> -
> -Every `node_mem_map` behaves exactly as FLATMEM's `mem_map` -
> -every physical page frame in a node has a `struct page` entry in the
> -`node_mem_map` array. When DISCONTIGMEM is enabled, a portion of the
> -`flags` field of the `struct page` encodes the node number of the
> -node hosting that page.
> -
> -The conversion between a PFN and the `struct page` in the
> -DISCONTIGMEM model became slightly more complex as it has to determine
> -which node hosts the physical page and which `pg_data_t` object
> -holds the `struct page`.
> -
> -Architectures that support DISCONTIGMEM provide :c:func:`pfn_to_nid`
> -to convert PFN to the node number. The opposite conversion helper
> -:c:func:`page_to_nid` is generic as it uses the node number encoded in
> -page->flags.
> -
> -Once the node number is known, the PFN can be used to index
> -appropriate `node_mem_map` array to access the `struct page` and
> -the offset of the `struct page` from the `node_mem_map` plus
> -`node_start_pfn` is the PFN of that page.
> -
>   SPARSEMEM
>   =========
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

