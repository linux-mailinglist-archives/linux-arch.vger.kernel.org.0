Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4113022E3
	for <lists+linux-arch@lfdr.de>; Mon, 25 Jan 2021 09:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbhAYIml (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Jan 2021 03:42:41 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:48546 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbhAYImH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Jan 2021 03:42:07 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DPNcN2zctz9tyL3;
        Mon, 25 Jan 2021 09:40:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id c_WxoVUwXTso; Mon, 25 Jan 2021 09:40:52 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DPNcM6yPKz9ty97;
        Mon, 25 Jan 2021 09:40:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 043018B783;
        Mon, 25 Jan 2021 09:40:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0Jtu_Uu76NxD; Mon, 25 Jan 2021 09:40:56 +0100 (CET)
Received: from [172.25.230.103] (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B21838B75F;
        Mon, 25 Jan 2021 09:40:56 +0100 (CET)
Subject: Re: [PATCH v10 05/12] mm: HUGE_VMAP arch support cleanup
To:     Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20210124082230.2118861-1-npiggin@gmail.com>
 <20210124082230.2118861-6-npiggin@gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <21a16acc-7182-90bb-8c5e-2fd176a5cd12@csgroup.eu>
Date:   Mon, 25 Jan 2021 09:40:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210124082230.2118861-6-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 24/01/2021 à 09:22, Nicholas Piggin a écrit :
> This changes the awkward approach where architectures provide init
> functions to determine which levels they can provide large mappings for,
> to one where the arch is queried for each call.
> 
> This removes code and indirection, and allows constant-folding of dead
> code for unsupported levels.

It looks like this is only the case when CONFIG_HAVE_ARCH_HUGE_VMAP is not defined.

When it is defined, for exemple on powerpc you defined arch_vmap_p4d_supported() as a regular 
function in arch/powerpc/mm/book3s64/radix_pgtable.c, so allthough it returns always false, it won't 
constant fold dead code.

> 
> This also adds a prot argument to the arch query. This is unused
> currently but could help with some architectures (e.g., some powerpc
> processors can't map uncacheable memory with large pages).
> 
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com> [arm64]
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   arch/arm64/include/asm/vmalloc.h         |  8 +++
>   arch/arm64/mm/mmu.c                      | 10 +--
>   arch/powerpc/include/asm/vmalloc.h       |  8 +++
>   arch/powerpc/mm/book3s64/radix_pgtable.c |  8 +--
>   arch/x86/include/asm/vmalloc.h           |  7 ++
>   arch/x86/mm/ioremap.c                    | 12 ++--
>   include/linux/io.h                       |  9 ---
>   include/linux/vmalloc.h                  |  6 ++
>   init/main.c                              |  1 -
>   mm/ioremap.c                             | 88 +++++++++---------------
>   10 files changed, 79 insertions(+), 78 deletions(-)
> 

Christophe
