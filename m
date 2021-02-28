Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D543C327512
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 00:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhB1XHx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Feb 2021 18:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhB1XHx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 Feb 2021 18:07:53 -0500
X-Greylist: delayed 402 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 28 Feb 2021 15:07:13 PST
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4162DC061756
        for <linux-arch@vger.kernel.org>; Sun, 28 Feb 2021 15:07:13 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 7BF6892009C; Mon,  1 Mar 2021 00:00:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 6D2F992009B;
        Mon,  1 Mar 2021 00:00:28 +0100 (CET)
Date:   Mon, 1 Mar 2021 00:00:28 +0100 (CET)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Huang Pei <huangpei@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     ambrosehua@gmail.com, Bibo Mao <maobibo@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: Re: [PATCH] MIPS: clean up CONFIG_MIPS_PGD_C0_CONTEXT handling
In-Reply-To: <20210227061944.266415-2-huangpei@loongson.cn>
Message-ID: <alpine.DEB.2.21.2102282346400.44210@angie.orcam.me.uk>
References: <20210227061944.266415-1-huangpei@loongson.cn> <20210227061944.266415-2-huangpei@loongson.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 27 Feb 2021, Huang Pei wrote:

> index 2000bb2b0220..517509ad8596 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2142,6 +2142,7 @@ config CPU_SUPPORTS_HUGEPAGES
>  	depends on !(32BIT && (ARCH_PHYS_ADDR_T_64BIT || EVA))
>  config MIPS_PGD_C0_CONTEXT
>  	bool
> +	depends on 64BIT
>  	default y if 64BIT && (CPU_MIPSR2 || CPU_MIPSR6) && !CPU_XLP

 I guess you want:

	default y if (CPU_MIPSR2 || CPU_MIPSR6) && !CPU_XLP

at the same time too.  Otherwise you have cruft left behind.

> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index a7521b8f7658..5bb9724578f7 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -1106,6 +1106,7 @@ struct mips_huge_tlb_info {
>  	bool need_reload_pte;
>  };
>  
> +#ifdef CONFIG_64BIT
>  static struct mips_huge_tlb_info
>  build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
>  			       struct uasm_reloc **r, unsigned int tmp,

 Does it actually build without a warning for !CONFIG_64BIT given the 
reference below?

> @@ -1164,8 +1165,8 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
>  
>  	if (pgd_reg == -1) {
>  		vmalloc_branch_delay_filled = 1;
> -		/* 1 0	1 0 1  << 6  xkphys cached */
> -		uasm_i_ori(p, ptr, ptr, 0x540);
> +		/* insert bit[63:59] of CAC_BASE into bit[11:6] of ptr */
> +		uasm_i_ori(p, ptr, ptr, (CAC_BASE >> 53));

 Instead I'd paper the issue over by casting the constant to `s64'.

 Or better yet fixed it properly by defining CAC_BASE, etc. as `unsigned
long long' long rather than `unsigned long' to stop all this nonsense 
(e.g. PHYS_TO_XKPHYS already casts the result to `s64').  Thomas, WDYT?

  Maciej
