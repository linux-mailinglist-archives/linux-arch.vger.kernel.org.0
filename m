Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D2E2812D6
	for <lists+linux-arch@lfdr.de>; Fri,  2 Oct 2020 14:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgJBMfT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Oct 2020 08:35:19 -0400
Received: from elvis.franken.de ([193.175.24.41]:39975 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgJBMfT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Oct 2020 08:35:19 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1kOKHI-0003Ro-00; Fri, 02 Oct 2020 14:35:12 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 0FFA5C109A; Fri,  2 Oct 2020 14:35:03 +0200 (CEST)
Date:   Fri, 2 Oct 2020 14:35:03 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Huang Pei <huangpei@loongson.cn>
Cc:     ambrosehua@gmail.com, Bibo Mao <maobibo@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: Re: [PATCH V3] MIPS: make userspace mapping young by default
Message-ID: <20201002123502.GA11098@alpha.franken.de>
References: <20200919074731.22372-1-huangpei@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200919074731.22372-1-huangpei@loongson.cn>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 19, 2020 at 03:47:31PM +0800, Huang Pei wrote:
> MIPS page fault path take 3 exceptions (1 TLB Miss + 2 TLB Invalid), but
> the second TLB Invalid exception is just triggered by __update_tlb from
> do_page_fault writing tlb without _PAGE_VALID set. With this patch, it
> only take 1 TLB Miss + 1 TLB Invalid exceptions
> 
> This version removes pte_sw_mkyoung without polluting MM code and makes
> page fault delay of MIPS on par with other architecture and covers both
> no-RIXI and RIXI MIPS CPUS
> 
> [1]: https://lkml.kernel.org/lkml/1591416169-26666-1-git-send-email
> -maobibo@loongson.cn/
> ---
> V3:
> - reformat with whitespace cleaned up following Thomas's advice
> V2:
> - remove unused asm-generic definition of pte_sw_mkyoung following Mao's
> advice
> ---
> Co-developed-by: Huang Pei <huangpei@loongson.cn>
> Signed-off-by: Huang Pei <huangpei@loongson.cn>
> Co-developed-by: Bibo Mao <maobibo@loonson.cn>
> ---
>  arch/mips/include/asm/pgtable.h | 10 ++++------
>  arch/mips/mm/cache.c            | 25 +++++++++++++------------
>  include/linux/pgtable.h         |  8 --------
>  mm/memory.c                     |  3 ---
>  4 files changed, 17 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
> index dd7a0f552cac..931fb35730f0 100644
> --- a/arch/mips/include/asm/pgtable.h
> +++ b/arch/mips/include/asm/pgtable.h
> @@ -27,11 +27,11 @@ struct vm_area_struct;
>  
>  #define PAGE_NONE	__pgprot(_PAGE_PRESENT | _PAGE_NO_READ | \
>  				 _page_cachable_default)
> -#define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | \
> -				 _page_cachable_default)
> +#define PAGE_SHARED    __pgprot(_PAGE_PRESENT | _PAGE_WRITE | \
> +				 __READABLE | _page_cachable_default)

you are still doing a white space changes here. 

>  #define PAGE_COPY	__pgprot(_PAGE_PRESENT | _PAGE_NO_EXEC | \
> -				 _page_cachable_default)
> -#define PAGE_READONLY	__pgprot(_PAGE_PRESENT | \
> +				 __READABLE | _page_cachable_default)
> +#define PAGE_READONLY	__pgprot(_PAGE_PRESENT |  __READABLE | \

I've grepped for usage of PAGE_SHARED and PAGE_READONLY and found
arch/mips/kvm/mmu.c and arch/mips/kernel/vdso.c. I wonder

1. Is this usage correct or should we use protection_map[X] ?
2. Are this still correct after the change in this patch ?

Right now I'm in favour to fist clean up asm/pgtable.h to get rid
of all unneeded PAGE_XXX defines and make mm/cache.c rixi part
more readable before applying this patch.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
