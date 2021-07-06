Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39EF3BCB5B
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 13:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhGFLHA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 07:07:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231466AbhGFLHA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jul 2021 07:07:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1C6F61C1A
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 11:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625569461;
        bh=f95OfC1ziq8MM7lCWe7kgmzfzaJuh3xR68OUxoLfki0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NJiuhewEknfrSoDY93RzeDlWukm76sN8cA4dEuAihqhGqAkniJO5Wm8PBgfQge1w1
         EuNOgrf6uXNDQZB1kny8f3+LyXwPottzzYWyLFjR/QlzXBaJKXZh0XBX0neW7M9L3v
         /Fowba1YGXI6HNIn2WDZi9Ba4s5VWXu3A3CpbDMuMNCzgZZ2Ew9ohWtdFAt1y8T0Au
         jfimcRaw48NWlp3yKm1PqZ+DV4wNsGQpC6xMLRBiZ7J2IAzUVSXOcwOsigxaFKu6Kr
         bRG69UcQg9CR/+xY7WT+d4pr6ujQ0rz7lJgcY5p0FMSqfSXH3wxYa+ZbVC1coAqM+z
         A2zf4ZesTUcjA==
Received: by mail-wr1-f51.google.com with SMTP id l5so8832478wrv.7
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 04:04:21 -0700 (PDT)
X-Gm-Message-State: AOAM530x+glVouZASo0ndScgbyjnd5CdaFt8p9f2Ia8XB6yOjJCkmnvN
        niduvndJ0dKwdCFlSP6aD6NuEiGjYwvscA3AC6I=
X-Google-Smtp-Source: ABdhPJwL8D9VstjRGwhhu8O2hQ+IkgrhoToTlWnfFR5vI/ShJnO25mExHqFVEoujAUD+JTb1H5hj8t/NfQTEGm6UbMI=
X-Received: by 2002:a5d:448c:: with SMTP id j12mr22001768wrq.105.1625569460324;
 Tue, 06 Jul 2021 04:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-20-chenhuacai@loongson.cn> <CAK8P3a2J+axpXoP_P+PApo90upUqn57=6_wY5RPZv6oNVV7oUA@mail.gmail.com>
In-Reply-To: <CAK8P3a2J+axpXoP_P+PApo90upUqn57=6_wY5RPZv6oNVV7oUA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 6 Jul 2021 13:04:04 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2BF0Vr+kvS4n2_8OMfAdrxT3jpUf3uNxF8sJYhimkF3g@mail.gmail.com>
Message-ID: <CAK8P3a2BF0Vr+kvS4n2_8OMfAdrxT3jpUf3uNxF8sJYhimkF3g@mail.gmail.com>
Subject: Re: [PATCH 19/19] LoongArch: Add Loongson-3 default config file
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:

> +CONFIG_EMBEDDED=y

You probably should not set this one.

> +CONFIG_CAIF=y

And almost certainly not this one.

> +CONFIG_PCCARD=m
> +CONFIG_YENTA=m
> +CONFIG_RAPIDIO=y
> +CONFIG_RAPIDIO_TSI721=y

These seem unlikely as well. Can you confirm that you have both old-style
PC-Card support and RAPIDIO support on your most common hardware?

> +CONFIG_PARPORT=y
> +CONFIG_PARPORT_PC=y
> +CONFIG_PARPORT_SERIAL=y
> +CONFIG_PARPORT_PC_FIFO=y
> +CONFIG_PRINTER=m

Is this an on-board PCI device you actually have?
What do you connect to the PC parport? Most printers
in the past 15 years only have USB or network connections.

> +CONFIG_8139CP=m
> +CONFIG_8139TOO=m

Do you actually support legacy PCI slots?

> +CONFIG_SERIAL_8250=y
> +CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_SERIAL_8250_NR_UARTS=16
> +CONFIG_SERIAL_8250_RUNTIME_UARTS=16
> +CONFIG_SERIAL_8250_EXTENDED=y
> +CONFIG_SERIAL_8250_MANY_PORTS=y
> +CONFIG_SERIAL_8250_SHARE_IRQ=y
> +CONFIG_SERIAL_8250_RSA=y
> +CONFIG_SERIAL_OF_PLATFORM=y

I don't see any device tree support in your patches, so I think the
SERIAL_OF_PLATFORM is not needed.

> +CONFIG_RAW_DRIVER=m

This is gone now.

> +CONFIG_INFINIBAND=m

You don't seem to enable any infiniband host drivers, so the core
layer can probably remain turned off

> +CONFIG_RTC_CLASS=y
> +CONFIG_RTC_DRV_EFI=y
> +CONFIG_UIO=m

same for UIO.

> +CONFIG_EXT2_FS=y
> +CONFIG_EXT2_FS_XATTR=y
> +CONFIG_EXT2_FS_POSIX_ACL=y
> +CONFIG_EXT2_FS_SECURITY=y
> +CONFIG_EXT3_FS=y
> +CONFIG_EXT3_FS_POSIX_ACL=y
> +CONFIG_EXT3_FS_SECURITY=y

I would generally recommend using EXT4 over EXT2 or EXT3

> +CONFIG_FRAME_WARN=1024

On 64-bit platforms, you probably want to increase this a bit,
otherwise you get extra warnings about code that works as
intended. The default is 2048, but you should be able to get by
with 1280, if that lets you build a defconfig kernel without warnings.


      Arnd
