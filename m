Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7BA32F8E0
	for <lists+linux-arch@lfdr.de>; Sat,  6 Mar 2021 09:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhCFIG7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 6 Mar 2021 03:06:59 -0500
Received: from elvis.franken.de ([193.175.24.41]:48065 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229982AbhCFIGV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 6 Mar 2021 03:06:21 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1lIRx3-0004K9-00; Sat, 06 Mar 2021 09:06:17 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id D25A9C0F9F; Sat,  6 Mar 2021 08:47:11 +0100 (CET)
Date:   Sat, 6 Mar 2021 08:47:11 +0100
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
        Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Subject: Re: [PATCH 1/3] MIPS: sync arrangement of pt_regs with user_pt_regs
 and regoffset_table
Message-ID: <20210306074711.GA4744@alpha.franken.de>
References: <20210305100310.26627-1-huangpei@loongson.cn>
 <20210305100310.26627-2-huangpei@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305100310.26627-2-huangpei@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 05, 2021 at 06:03:08PM +0800, Huang Pei wrote:
> Signed-off-by: Huang Pei <huangpei@loongson.cn>
> ---
>  arch/mips/include/asm/ptrace.h | 10 +++++-----
>  arch/mips/kernel/asm-offsets.c |  6 +++---
>  arch/mips/kernel/ptrace.c      | 10 +++++-----
>  3 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
> index 1e76774b36dd..e51691f2b7af 100644
> --- a/arch/mips/include/asm/ptrace.h
> +++ b/arch/mips/include/asm/ptrace.h
> @@ -34,16 +34,16 @@ struct pt_regs {
>  	/* Saved main processor registers. */
>  	unsigned long regs[32];
>  
> +	unsigned long lo;
> +	unsigned long hi;
>  	/* Saved special registers. */
> +	unsigned long cp0_epc;
> +	unsigned long cp0_badvaddr;
>  	unsigned long cp0_status;
> -	unsigned long hi;
> -	unsigned long lo;
> +	unsigned long cp0_cause;
>  #ifdef CONFIG_CPU_HAS_SMARTMIPS
>  	unsigned long acx;
>  #endif
> -	unsigned long cp0_badvaddr;
> -	unsigned long cp0_cause;
> -	unsigned long cp0_epc;
>  #ifdef CONFIG_CPU_CAVIUM_OCTEON
>  	unsigned long long mpl[6];        /* MTM{0-5} */
>  	unsigned long long mtp[6];        /* MTP{0-5} */

sorry this is pointless, I'm not taking this.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
