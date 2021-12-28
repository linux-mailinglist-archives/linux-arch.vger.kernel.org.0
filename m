Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F227480855
	for <lists+linux-arch@lfdr.de>; Tue, 28 Dec 2021 11:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbhL1KWM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Dec 2021 05:22:12 -0500
Received: from mail-ua1-f52.google.com ([209.85.222.52]:36532 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhL1KWM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Dec 2021 05:22:12 -0500
Received: by mail-ua1-f52.google.com with SMTP id r15so31300120uao.3;
        Tue, 28 Dec 2021 02:22:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XlHqM3s89iXtoWPBbjZMgYeJo6DHmFUlBr+aZlxVLoA=;
        b=q1YdajygjkQHu5ABSonWIWLBmV6Kx/qvtXSmNrMoyy7FCc6f8uOMNzF/TD06hW3gVn
         gX2zb/J+TnTD5kzUuSqpBzA4Pop476NaBjmu1UebI3l7NK3OvU7KXKCYfPBA4LHfZCAt
         GHf/42p0AWTkZ6iEgniQkBeZg/n5WCNj7y95pcILOd8bmQAebWQM2UVUrAE755faa12J
         lOCc0K5XjXeQx3ZFP1W70G9947nu6l8e7T1pnpEoBpP1lvAig+5uJQm6hsHhffv+imPW
         9o0G7obDwaF8+/7fsCZOO6jlt9epbKlHCDAXcHVmMMH+n46viS3MQKw8Sis1AY+Gm44r
         7lMQ==
X-Gm-Message-State: AOAM532Hc+ArOpFoQ1Jrd6seU9Gf7I9Idm7XG7N3gRLbOnUwo3Pr3t4S
        1OnU2jthlIoL2HPAAumQH3qZAqBDDerfFQ==
X-Google-Smtp-Source: ABdhPJxGeg4vABh1qSkMFju3Lr7SrVkB7xRQvvi3AUXFhVALjgiZVrIXi4syUQKPtuzRu8GQRxiy+w==
X-Received: by 2002:a05:6102:e8b:: with SMTP id l11mr5977878vst.37.1640686931130;
        Tue, 28 Dec 2021 02:22:11 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id l28sm3947514vkn.45.2021.12.28.02.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 02:22:10 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id c36so5672737uae.13;
        Tue, 28 Dec 2021 02:22:10 -0800 (PST)
X-Received: by 2002:a67:c81c:: with SMTP id u28mr5694404vsk.38.1640686930392;
 Tue, 28 Dec 2021 02:22:10 -0800 (PST)
MIME-Version: 1.0
References: <20211227164317.4146918-1-schnelle@linux.ibm.com> <20211227164317.4146918-11-schnelle@linux.ibm.com>
In-Reply-To: <20211227164317.4146918-11-schnelle@linux.ibm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Dec 2021 11:21:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXcfGhVjB2pNB=ct8dExLeh-cY+Vmb0NWpZ2T0bfa8VdA@mail.gmail.com>
Message-ID: <CAMuHMdXcfGhVjB2pNB=ct8dExLeh-cY+Vmb0NWpZ2T0bfa8VdA@mail.gmail.com>
Subject: Re: [RFC 10/32] i2c: Kconfig: add HAS_IOPORT dependencies
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Linux I2C <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Niklas,

On Mon, Dec 27, 2021 at 5:49 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks for your patch!

> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -828,6 +828,7 @@ config I2C_NPCM7XX
>
>  config I2C_OCORES
>         tristate "OpenCores I2C Controller"
> +       depends on HAS_IOPORT

While drivers/i2c/busses/i2c-ocores.c does use {in,out}(), I doubt this
is used to access legacy I/O space.

>         help
>           If you say yes to this option, support will be included for the
>           OpenCores I2C controller. For details see
> @@ -1227,6 +1228,7 @@ config I2C_CP2615
>  config I2C_PARPORT
>         tristate "Parallel port adapter"
>         depends on PARPORT
> +       depends on HAS_IOPORT

Same as PRINTER: shouldn't this work with all parport drivers?

>         select I2C_ALGOBIT
>         select I2C_SMBUS
>         help

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
