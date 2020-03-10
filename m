Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 180E817FD98
	for <lists+linux-arch@lfdr.de>; Tue, 10 Mar 2020 14:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgCJN2d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Mar 2020 09:28:33 -0400
Received: from elvis.franken.de ([193.175.24.41]:60394 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728887AbgCJN2d (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Mar 2020 09:28:33 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jBevd-0006Jg-00; Tue, 10 Mar 2020 14:28:13 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id D9C6FC0FAF; Tue, 10 Mar 2020 14:27:47 +0100 (CET)
Date:   Tue, 10 Mar 2020 14:27:47 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Guo Ren <guoren@kernel.org>, Brian Cain <bcain@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Creasey <sammy@sammy.net>, Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Guan Xuetao <gxt@pku.edu.cn>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm/special: Create generic fallbacks for
 pte_special() and pte_mkspecial()
Message-ID: <20200310132747.GA12601@alpha.franken.de>
References: <1583802551-15406-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583802551-15406-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 10, 2020 at 06:39:11AM +0530, Anshuman Khandual wrote:
> diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
> index aef5378f909c..8e4e4be1ca00 100644
> --- a/arch/mips/include/asm/pgtable.h
> +++ b/arch/mips/include/asm/pgtable.h
> @@ -269,6 +269,36 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>   */
>  extern pgd_t swapper_pg_dir[];
>  
> +/*
> + * Platform specific pte_special() and pte_mkspecial() definitions
> + * are required only when ARCH_HAS_PTE_SPECIAL is enabled.
> + */
> +#if !defined(CONFIG_32BIT) && !defined(CONFIG_CPU_HAS_RIXI)

this looks wrong.

current Kconfig statement is

select ARCH_HAS_PTE_SPECIAL if !(32BIT && CPU_HAS_RIXI)

so we can't use PTE_SPECIAL on 32bit _and_ CPUs with RIXI support.

Why can't we use

#if defined(CONFIG_ARCH_HAS_PTE_SPECIAL)

here as the comment already suggests ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
