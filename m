Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36CB480872
	for <lists+linux-arch@lfdr.de>; Tue, 28 Dec 2021 11:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbhL1Kcz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Dec 2021 05:32:55 -0500
Received: from mail-ua1-f52.google.com ([209.85.222.52]:34735 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhL1Kcz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Dec 2021 05:32:55 -0500
Received: by mail-ua1-f52.google.com with SMTP id t18so23757107uaj.1;
        Tue, 28 Dec 2021 02:32:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQ0Ut1LNrzqnM5tmiaXKSEzqL3RAAlFvcxdwMLjQ2+M=;
        b=YtwGj6HDczm+318a3fD4djy/5R56T3bRMpgOBElC5z0xhNyjvBHC85chsggVjVjUFm
         dXOVby4aHIajfKF6GJx1L1PjbjjgjPp8lEl3tF1AOieEtKWLqTJI2dtBSQS0qYbFPCkP
         c8E5MJojCLPlgAiQyQLmcGUPgmgLMzyyDQgvvgd6bbyP0LC2jykQAaVGajETWcoBbYsI
         GG7EPkOlflHpUXUTahvqqIn7qeGzNfTvZd7qyfxaONdPQhY2Nf7hrUnCKciQbagUIvyg
         HAdmAi8OyuMWHLzejVXM0JtYgLAyy914ZSmGQSnZeYpTDmw7HxifK2OBXOjQh/Daj7Bm
         cyoQ==
X-Gm-Message-State: AOAM532Br5N2Pkx4pegzT/38+psD5H2VIUrKHOXr6Rl0zjjTY/c25GCu
        2hSFoOTKs5nEecGILvuV1BLoGyyQHgoTUA==
X-Google-Smtp-Source: ABdhPJzZfuu5eF+cN8IGp+ovdIotknnU1YrfXK0z/H51YX9ppsYE1Ak9XfEdN9RaxVD9FtLGZMm6RQ==
X-Received: by 2002:a67:ee1a:: with SMTP id f26mr5176551vsp.51.1640687573896;
        Tue, 28 Dec 2021 02:32:53 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id y17sm3630597uaa.9.2021.12.28.02.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 02:32:53 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id o2so10096350vkn.0;
        Tue, 28 Dec 2021 02:32:53 -0800 (PST)
X-Received: by 2002:ac5:c853:: with SMTP id g19mr6363163vkm.20.1640687573214;
 Tue, 28 Dec 2021 02:32:53 -0800 (PST)
MIME-Version: 1.0
References: <20211227164317.4146918-1-schnelle@linux.ibm.com> <20211227164317.4146918-13-schnelle@linux.ibm.com>
In-Reply-To: <20211227164317.4146918-13-schnelle@linux.ibm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Dec 2021 11:32:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXDL6XXfohzJFTTV6tR=gg=bcCQq935eKUbNaNLHp9xiw@mail.gmail.com>
Message-ID: <CAMuHMdXDL6XXfohzJFTTV6tR=gg=bcCQq935eKUbNaNLHp9xiw@mail.gmail.com>
Subject: Re: [RFC 12/32] iio: adc: Kconfig: add HAS_IOPORT dependencies
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Niklas,

On Mon, Dec 27, 2021 at 5:53 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks for your patch!

> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -119,7 +119,7 @@ config AD7606
>
>  config AD7606_IFACE_PARALLEL
>         tristate "Analog Devices AD7606 ADC driver with parallel interface support"
> -       depends on HAS_IOMEM
> +       depends on HAS_IOPORT

While this driver uses ins[bw](), this seems unrelated to legacy
I/O space, as the driver maps a MMIO region.  Probably different
accessors should be used instead.

Note that this driver has no in-tree users. Same for the SPI variant,
but at least that one has modern json-schema DT bindings ;-)

>         select AD7606
>         help
>           Say yes here to build parallel interface support for Analog Devices:

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
