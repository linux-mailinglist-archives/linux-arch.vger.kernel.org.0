Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F100C7C884
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2019 18:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfGaQXQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Jul 2019 12:23:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725209AbfGaQXQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 Jul 2019 12:23:16 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B1F3206B8;
        Wed, 31 Jul 2019 16:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564590195;
        bh=fONs4BmZttEHPUKNIEeG8afpWoHG1Ramxy67XPpPajA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D44JUbuyGA42vB4ZF39we2YnbDD4WU6p1kIXD+46Hx0pzXbYxSOckTA97vCFO1ipg
         wH1v9tT8ZPQLGiCC7rdTep1hDWwnO6XsJHzqY0qm1rnxrL61jnMF/LD9s5t+iOS6Bs
         ArsM59Htt9AJU3/IxBzAsab4hjUew2T1H5FCi+Mk=
Date:   Wed, 31 Jul 2019 17:23:10 +0100
From:   Will Deacon <will@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        arnd@arndb.de, tglx@linutronix.de, salyzyn@android.com,
        pcc@google.com, 0x7f454c46@gmail.com, linux@rasmusvillemoes.dk,
        sthotton@marvell.com, andre.przywara@arm.com, luto@kernel.org,
        Matteo Croce <mcroce@redhat.com>
Subject: Re: [PATCH] arm64: vdso: Fix Makefile regression
Message-ID: <20190731162309.6sqeylyoauv7seeb@willie-the-truck>
References: <CAGnkfhyT=2kPsiUy-V=aCA_s-C4BXgD++hAZ9ii1h0p94mMVQA@mail.gmail.com>
 <20190729125421.32482-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729125421.32482-1-vincenzo.frascino@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 29, 2019 at 01:54:21PM +0100, Vincenzo Frascino wrote:
> Using an old .config in combination with "make oldconfig" can cause
> an incorrect detection of the compat compiler:
> 
> $ grep CROSS_COMPILE_COMPAT .config
> CONFIG_CROSS_COMPILE_COMPAT_VDSO=""
> 
> $ make oldconfig && make
> arch/arm64/Makefile:58: gcc not found, check CROSS_COMPILE_COMPAT.
> Stop.
> 
> Accordingly to the section 7.2 of the GNU Make manual "Syntax of
> Conditionals", "When the value results from complex expansions of
> variables and functions, expansions you would consider empty may
> actually contain whitespace characters and thus are not seen as
> empty. However, you can use the strip function to avoid interpreting
> whitespace as a non-empty value."
> 
> Fix the issue adding strip to the CROSS_COMPILE_COMPAT string
> evaluation.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Reported-by: Matteo Croce <mcroce@redhat.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index bb1f1dbb34e8..61de992bbea3 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -52,7 +52,7 @@ ifeq ($(CONFIG_GENERIC_COMPAT_VDSO), y)
>  
>    ifeq ($(CONFIG_CC_IS_CLANG), y)
>      $(warning CROSS_COMPILE_COMPAT is clang, the compat vDSO will not be built)
> -  else ifeq ($(CROSS_COMPILE_COMPAT),)
> +  else ifeq ($(strip $(CROSS_COMPILE_COMPAT)),)
>      $(warning CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will not be built)
>    else ifeq ($(shell which $(CROSS_COMPILE_COMPAT)gcc 2> /dev/null),)
>      $(error $(CROSS_COMPILE_COMPAT)gcc not found, check CROSS_COMPILE_COMPAT)
> -- 
> 2.22.0

Acked-by: Will Deacon <will@kernel.org>

Will
