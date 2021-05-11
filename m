Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBEE37A82F
	for <lists+linux-arch@lfdr.de>; Tue, 11 May 2021 15:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhEKNyl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 May 2021 09:54:41 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:25711 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhEKNyi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 May 2021 09:54:38 -0400
Date:   Tue, 11 May 2021 13:53:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1620741209; bh=jI9W9Blj/Z2qjs3mmYq2tUWMQe2pKTQ81XNwCTvedF4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=bmoJ+2g9V7Dr5u4+mbx7+VWWI+VbNHXRu4+Pl5zJLxdO8By602YaZnUhpNrhCPfuf
         sbGhHBahrMkDSDYReFAPMkFqjPE4x8cpaOrhYQFoA7Pi1+JJpqo2n3DHog4Fh835IC
         SwuVMUMGEUTEyCy9h6K2k7Z4cDonsp1kjOs5B/RUpmFc3r7Ss/JE9LUqblCbvvDEXx
         X5UcOUlKsJbrg/1ok2jCKdAkre6tcBWjrhWXBXIkhyoJ08J+Lla6ZGEPrALMFwxfe2
         LE2Q2pde3JcBQWvSUEPsRbmeMTCpqwnoDjzV6LAHmwvfrzXiUkzv2GjOwBGQhfzl1p
         apSpWWjgxYVgA==
To:     Yury Norov <yury.norov@gmail.com>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexander Lobakin <alobakin@pm.me>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>,
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
        Will Deacon <will@kernel.org>, Yogesh Lal <ylal@codeaurora.org>
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [PATCH] all: remove GENERIC_FIND_FIRST_BIT
Message-ID: <20210511134551.18721-1-alobakin@pm.me>
In-Reply-To: <20210510233421.18684-1-yury.norov@gmail.com>
References: <20210510233421.18684-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yury Norov <yury.norov@gmail.com>
Date: Mon, 10 May 2021 16:34:21 -0700

> In the 5.12 cycle we enabled the GENERIC_FIND_FIRST_BIT config option
> for ARM64 and MIPS. It increased performance and shrunk .text size; and
> so far I didn't receive any negative feedback on the change.
>
> https://lore.kernel.org/linux-arch/20210225135700.1381396-1-yury.norov@gm=
ail.com/
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

MIPS bit:

Reviewed-by: Alexander Lobakin <alobakin@pm.me>
Tested-by: Alexander Lobakin <alobakin@pm.me>

>  arch/s390/Kconfig                 |  1 -
>  arch/x86/Kconfig                  |  1 -
>  arch/x86/um/Kconfig               |  1 -
>  include/asm-generic/bitops/find.h | 12 ------------
>  lib/Kconfig                       |  3 ---
>  8 files changed, 21 deletions(-)

Thanks,
Al

