Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CB03D55B6
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jul 2021 10:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhGZH4R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 03:56:17 -0400
Received: from mail-vk1-f171.google.com ([209.85.221.171]:35517 "EHLO
        mail-vk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbhGZH4Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jul 2021 03:56:16 -0400
Received: by mail-vk1-f171.google.com with SMTP id i26so1856562vkk.2
        for <linux-arch@vger.kernel.org>; Mon, 26 Jul 2021 01:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Si0q2cEMofhG+5+AR1EVH34qN12MJPSB9GsMqVI/GHg=;
        b=T0R7Rh0qJsHN8DjChdRIpukp/Rdq/Z6OdOYJ0ti5sRaMVb0D6Cx2fnnBc6cLU/nGEc
         QcWV206M0VhYLWfO6uehUONWGv8J9i2a0BXSPSsS06KuDtNhRgiJHvL6/UcrnQeZgR5G
         fq4HNzPxMPfgh4oo2BIv2Y+cno0WWLb/q2rA52fe4dBWx2JtDwzsutM/Aa7jWD6BvuHx
         0MeVDy8mQnagXWruyJJjbET8yGm9d1e9fY3V0dFF77y0qNNuO1PUgZFAwKQBLV5udHr1
         xjRArzFfKtQQ5Z5F0DkxuPIzuBTPAIPQ03uaIB9uU8kLN307BQyhgdxasUb6fxvRsOUf
         ae0g==
X-Gm-Message-State: AOAM533YXhmgS/1EiklwUVPMtcm8xa0koL0a7n8n6/XrL1xLp2CN+2VG
        VSMsrCvCqm5BQNQRMK1SuyLVzJH1xk9nVdg6T/Wac73sodC1Rw==
X-Google-Smtp-Source: ABdhPJwPumaf/FCKrk/8abUgB91oxRTICcNshWiijhhhyWgP+MeB1c4u5B72Ls5tw2iLwrYkx39bWklZne1siaJoha4=
X-Received: by 2002:a05:6122:a12:: with SMTP id 18mr9517891vkn.1.1627288604446;
 Mon, 26 Jul 2021 01:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210724123617.3525377-1-chenhuacai@loongson.cn>
In-Reply-To: <20210724123617.3525377-1-chenhuacai@loongson.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 26 Jul 2021 10:36:33 +0200
Message-ID: <CAMuHMdU8o2r0Tybz_z3hKLoMyNqL5A_RZ9DnCYR0pHeRMpgvWA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] arch: Introduce ARCH_HAS_HW_XCHG_SMALL
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Rui Wang <wangrui@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Huacai,

On Sat, Jul 24, 2021 at 2:36 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> Introduce a new Kconfig option ARCH_HAS_HW_XCHG_SMALL, which means arch
> has hardware sub-word xchg/cmpxchg support. This option will be used as
> an indicator to select the bit-field definition in the qspinlock data
> structure.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Thanks for your patch!

> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -228,6 +228,10 @@ config ARCH_HAS_FORTIFY_SOURCE
>           An architecture should select this when it can successfully
>           build and run with CONFIG_FORTIFY_SOURCE.
>
> +# Select if arch has hardware sub-word xchg/cmpxchg support
> +config ARCH_HAS_HW_XCHG_SMALL

What do you mean by "hardware"?
Does a software fallback count?

> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -5,6 +5,7 @@ config M68K
>         select ARCH_32BIT_OFF_T
>         select ARCH_HAS_BINFMT_FLAT
>         select ARCH_HAS_DMA_PREP_COHERENT if HAS_DMA && MMU && !COLDFIRE
> +       select ARCH_HAS_HW_XCHG_SMALL

M68k CPUs which support the CAS (Compare And Set) instruction do
support this on 8-bit, 16-bit, and 32-bit quantities.
M68k CPUs which lack CAS use a software implementation, which
supports the same quantities.

As CAS is used only if CONFIG_RMW_INSNS=y, perhaps this needs
a dependency?

   select ARCH_HAS_HW_XCHG_SMALL if RMW_INSNS

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
