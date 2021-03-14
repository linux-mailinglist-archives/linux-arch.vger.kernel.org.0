Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9BC33A4F1
	for <lists+linux-arch@lfdr.de>; Sun, 14 Mar 2021 14:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbhCNNMT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 14 Mar 2021 09:12:19 -0400
Received: from elvis.franken.de ([193.175.24.41]:57617 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235327AbhCNNMS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 14 Mar 2021 09:12:18 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1lLQXO-0007q5-01; Sun, 14 Mar 2021 14:12:06 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id B65E6C246C; Sun, 14 Mar 2021 14:09:00 +0100 (CET)
Date:   Sun, 14 Mar 2021 14:09:00 +0100
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
Subject: Re: [PATCH] MIPS: clean up CONFIG_MIPS_PGD_C0_CONTEXT handling
Message-ID: <20210314130900.GB5165@alpha.franken.de>
References: <20210313013927.26733-1-huangpei@loongson.cn>
 <20210313013927.26733-2-huangpei@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313013927.26733-2-huangpei@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 13, 2021 at 09:39:27AM +0800, Huang Pei wrote:
> +. LOONGSON64 use 0x98xx_xxxx_xxxx_xxxx as xphys cached, instread of
> 0xa8xx_xxxx_xxxx_xxxx
> 
> +. let CONFIG_MIPS_PGD_C0_CONTEXT depend on 64bit
> 
> +. cast CAC_BASE into u64 to silence warning on MIPS32
> 
> CP0 Context has enough room for wraping pgd into its 41-bit PTEBase field.
> 
> +. For XPHYS, the trick is that pgd is 4kB aligned, and the PABITS <= 53,
> only save 53 - 12 = 41 bits, aka :
> 
>    bit[63:59] | 0000 00 |  bit[53:12] | 0000 0000 0000
> 
> +. for CKSEG0, only save 29 - 12 = 17 bits
> 
> when switching pgd, only need to save bit[53:12] or bit[28:12] into
> CP0 Context's bit[63:23], see folling asm generated at run time
> 
> tlbmiss_handler_setup_pgd:
> 	.set	push
> 	.set	noreorder
> 
> 	dsra	a2, a0, 29
> 	move	a3, a0
> 	dins	a0, zero, 29, 35
> 	daddiu	a2, a2, 4	//for CKSEG0, a2 from 0xfffffffffffffffc
> 				//into 0
> 
> 	movn	a0, a3, a2
> 	dsll	a0, a0, 11
> 	jr	ra
> 	dmtc0	a0, CP0_CONTEXT
> 
> 	.set	pop
> 
> when using it on page walking
> 
> 	dmfc0	k0, CP0_CONTEXT
> 	dins	k0, zero, 0, 23	         // zero badv2
> 	ori	k0, k0, (CAC_BASE >> 53) // *prefix* with bit[63:59]
> 	drotr	k0, k0, 11		 // kick it in the right place
> 
> Signed-off-by: Huang Pei <huangpei@loongson.cn>
> ---
>  arch/mips/Kconfig    | 3 ++-
>  arch/mips/mm/tlbex.c | 9 +++++----
>  2 files changed, 7 insertions(+), 5 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
