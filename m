Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24337338A3E
	for <lists+linux-arch@lfdr.de>; Fri, 12 Mar 2021 11:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbhCLKeq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Mar 2021 05:34:46 -0500
Received: from elvis.franken.de ([193.175.24.41]:52591 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233398AbhCLKem (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Mar 2021 05:34:42 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1lKf7u-0007WV-00; Fri, 12 Mar 2021 11:34:38 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 406CCC1D54; Fri, 12 Mar 2021 11:24:10 +0100 (CET)
Date:   Fri, 12 Mar 2021 11:24:10 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Huang Pei <huangpei@loongson.cn>
Cc:     ambrosehua@gmail.com, Bibo Mao <maobibo@loongson.cn>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Subject: Re: [PATCH 1/2] MIPS: clean up CONFIG_MIPS_PGD_C0_CONTEXT handling
Message-ID: <20210312102410.GA7027@alpha.franken.de>
References: <20210309080210.25561-1-huangpei@loongson.cn>
 <20210309080210.25561-2-huangpei@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309080210.25561-2-huangpei@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 09, 2021 at 04:02:09PM +0800, Huang Pei wrote:
> +. LOONGSON64 use 0x98xx_xxxx_xxxx_xxxx as xphys cached
> 
> +. let CONFIG_MIPS_PGD_C0_CONTEXT depend on 64bit
> 
> +. cast CAC_BASE into u64 to silence warning on MIPS32
> 
> CP0 Context has enough room for wraping pgd into its 41-bit PTEBase field.
> 
> +. For XPHYS, the trick is that pgd is 4kB aligned, and the PABITS <= 48,
> only save 48 - 12 + 5(for bit[63:59]) = 41 bits, aka. :
> 
>    bit[63:59] | 0000 0000 000 |  bit[47:12] | 0000 0000 0000
> 
> +. for CKSEG0, only save 29 - 12 = 17 bits

you are explaining what you are doing, but not why you are doing this.
So why are you doing this ?

>  #
>  # Set to y for ptrace access to watch registers.
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index a7521b8f7658..591cfa0fca02 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -848,8 +848,8 @@ void build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
>  		/* Clear lower 23 bits of context. */
>  		uasm_i_dins(p, ptr, 0, 0, 23);
>  
> -		/* 1 0	1 0 1  << 6  xkphys cached */
> -		uasm_i_ori(p, ptr, ptr, 0x540);
> +		/* insert bit[63:59] of CAC_BASE into bit[11:6] of ptr */
> +		uasm_i_ori(p, ptr, ptr, ((u64)(CAC_BASE) >> 53));

you want to use bits 63..59 but picking bits 63..53 with this.  While
bits 58..53 are probably 0, wouldn't it make also sense to mask them out ?

>  		uasm_i_drotr(p, ptr, ptr, 11);
>  #elif defined(CONFIG_SMP)
>  		UASM_i_CPUID_MFC0(p, ptr, SMP_CPUID_REG);
> @@ -1164,8 +1164,9 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
>  
>  	if (pgd_reg == -1) {
>  		vmalloc_branch_delay_filled = 1;
> -		/* 1 0	1 0 1  << 6  xkphys cached */
> -		uasm_i_ori(p, ptr, ptr, 0x540);
> +		/* insert bit[63:59] of CAC_BASE into bit[11:6] of ptr */
> +		uasm_i_ori(p, ptr, ptr, ((u64)(CAC_BASE) >> 53));
> +
>  		uasm_i_drotr(p, ptr, ptr, 11);
>  	}
>  
> @@ -1292,7 +1293,6 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
>  
>  	return rv;
>  }
> -
>  /*

why are you removing this empty line ? I'd prefer that it stays there...

>   * For a 64-bit kernel, we are using the 64-bit XTLB refill exception
>   * because EXL == 0.  If we wrap, we can also use the 32 instruction
> -- 
> 2.17.1

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
