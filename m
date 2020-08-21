Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354F624CD5F
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 07:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgHUFsF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 01:48:05 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:40695 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgHUFsF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Aug 2020 01:48:05 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BXrCQ4vy9z9vD3p;
        Fri, 21 Aug 2020 07:48:02 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id bl88SjSaFR8m; Fri, 21 Aug 2020 07:48:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BXrCQ3rJ9z9vD3n;
        Fri, 21 Aug 2020 07:48:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6D29B8B87B;
        Fri, 21 Aug 2020 07:48:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ULHxEnLEl1V7; Fri, 21 Aug 2020 07:48:03 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 760908B75F;
        Fri, 21 Aug 2020 07:48:02 +0200 (CEST)
Subject: Re: [PATCH v5 0/8] huge vmalloc mappings
To:     Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linuxppc-dev@lists.ozlabs.org
References: <20200821044427.736424-1-npiggin@gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <bc7537f4-abc6-b7cc-ccd3-420098fec917@csgroup.eu>
Date:   Fri, 21 Aug 2020 07:47:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821044427.736424-1-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 21/08/2020 à 06:44, Nicholas Piggin a écrit :
> I made this powerpc-only for the time being. It shouldn't be too hard to
> add support for other archs that define HUGE_VMAP. I have booted x86
> with it enabled, just may not have audited everything.

I like this series, but if I understand correctly it enables huge 
vmalloc mappings only for hugepages sizes matching a page directory 
levels, ie on a PPC32 it would work only for 4M hugepages.

On the 8xx, we only have 8M and 512k hugepages. Any change that it can 
support these as well one day ?

Christophe

> 
> Hi Andrew, would you care to put this in your tree?
> 
> Thanks,
> Nick
> 
> Since v4:
> - Fixed an off-by-page-order bug in v4
> - Several minor cleanups.
> - Added page order to /proc/vmallocinfo
> - Added hugepage to alloc_large_system_hage output.
> - Made an architecture config option, powerpc only for now.
> 
> Since v3:
> - Fixed an off-by-one bug in a loop
> - Fix !CONFIG_HAVE_ARCH_HUGE_VMAP build fail
> - Hopefully this time fix the arm64 vmap stack bug, thanks Jonathan
>    Cameron for debugging the cause of this (hopefully).
> 
> Since v2:
> - Rebased on vmalloc cleanups, split series into simpler pieces.
> - Fixed several compile errors and warnings
> - Keep the page array and accounting in small page units because
>    struct vm_struct is an interface (this should fix x86 vmap stack debug
>    assert). [Thanks Zefan]
> 
> Nicholas Piggin (8):
>    mm/vmalloc: fix vmalloc_to_page for huge vmap mappings
>    mm: apply_to_pte_range warn and fail if a large pte is encountered
>    mm/vmalloc: rename vmap_*_range vmap_pages_*_range
>    lib/ioremap: rename ioremap_*_range to vmap_*_range
>    mm: HUGE_VMAP arch support cleanup
>    mm: Move vmap_range from lib/ioremap.c to mm/vmalloc.c
>    mm/vmalloc: add vmap_range_noflush variant
>    mm/vmalloc: Hugepage vmalloc mappings
> 
>   .../admin-guide/kernel-parameters.txt         |   2 +
>   arch/Kconfig                                  |   4 +
>   arch/arm64/mm/mmu.c                           |  12 +-
>   arch/powerpc/Kconfig                          |   1 +
>   arch/powerpc/mm/book3s64/radix_pgtable.c      |  10 +-
>   arch/x86/mm/ioremap.c                         |  12 +-
>   include/linux/io.h                            |   9 -
>   include/linux/vmalloc.h                       |  13 +
>   init/main.c                                   |   1 -
>   mm/ioremap.c                                  | 231 +--------
>   mm/memory.c                                   |  60 ++-
>   mm/page_alloc.c                               |   4 +-
>   mm/vmalloc.c                                  | 456 +++++++++++++++---
>   13 files changed, 476 insertions(+), 339 deletions(-)
> 
