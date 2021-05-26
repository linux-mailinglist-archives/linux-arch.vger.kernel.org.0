Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA74D391F30
	for <lists+linux-arch@lfdr.de>; Wed, 26 May 2021 20:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhEZSfE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 May 2021 14:35:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231189AbhEZSfC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 May 2021 14:35:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BBB3613BA;
        Wed, 26 May 2021 18:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622054011;
        bh=UK6wHJT4nW2m0M9S/InYlvnZnFEuXBK89A6fNGZIpBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CCJ1YLsPawytssAl3Q5VhnAbUbV9uJbXaOEroICNKtpEqilp2LOzT8jY560tju94R
         DQU45Dah+XuW+9EZFeurk4JodvknKjTf6qW2qUC2bVjcbqs8cQxJD1XeHPmnEgcEm+
         bSjM9DvjlTOafCHnThTpl/qWxsYSsZrcJGppItleu76zMj83WA6t/xpQqcG8cmSJP/
         29ikFBkdGV5zyzLHlXwe43xnkpO5Pyz1UMAXSH8K5grA+10HE7AHuVNaIyPnBFBJpb
         xUUk7iq4Df8ZMQmvvYz5u0IYxZM7Ur6N00fNjpnXL8/DpfXG+ZtjrYnJqE58+8ndem
         XGDWL7CFiLTkg==
Date:   Wed, 26 May 2021 19:33:23 +0100
From:   Will Deacon <will@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alexander Lobakin <alobakin@pm.me>,
        Alexey Klimov <aklimov@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Nick Terrell <terrelln@fb.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Richard Weinberger <richard@nod.at>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yogesh Lal <ylal@codeaurora.org>
Subject: Re: [PATCH] all: remove GENERIC_FIND_FIRST_BIT
Message-ID: <20210526183322.GB20055@willie-the-truck>
References: <20210510233421.18684-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510233421.18684-1-yury.norov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 10, 2021 at 04:34:21PM -0700, Yury Norov wrote:
> In the 5.12 cycle we enabled the GENERIC_FIND_FIRST_BIT config option
> for ARM64 and MIPS. It increased performance and shrunk .text size; and
> so far I didn't receive any negative feedback on the change.
> 
> https://lore.kernel.org/linux-arch/20210225135700.1381396-1-yury.norov@gmail.com/
> 
> I think it's time to make all architectures use find_{first,last}_bit()
> unconditionally and remove the corresponding config option.
> 
> This patch doesn't introduce functional changes for arc, arm64, mips,
> s390 and x86 because they already enable GENERIC_FIND_FIRST_BIT. There
> will be no changes for arm because it implements find_{first,last}_bit
> in arch code. For other architectures I expect improvement both in
> performance and .text size.
> 
> It would be great if people with an access to real hardware would share
> the output of bloat-o-meter and lib/find_bit_benchmark.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/arc/Kconfig                  |  1 -
>  arch/arm64/Kconfig                |  1 -
>  arch/mips/Kconfig                 |  1 -
>  arch/s390/Kconfig                 |  1 -
>  arch/x86/Kconfig                  |  1 -
>  arch/x86/um/Kconfig               |  1 -
>  include/asm-generic/bitops/find.h | 12 ------------
>  lib/Kconfig                       |  3 ---
>  8 files changed, 21 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
