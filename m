Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B17480864
	for <lists+linux-arch@lfdr.de>; Tue, 28 Dec 2021 11:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhL1KZ3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Dec 2021 05:25:29 -0500
Received: from mail-ua1-f44.google.com ([209.85.222.44]:39711 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhL1KZ3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Dec 2021 05:25:29 -0500
Received: by mail-ua1-f44.google.com with SMTP id i6so31019339uae.6;
        Tue, 28 Dec 2021 02:25:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=USyrHlhnUayu2FiWb0UtOnf6CbNGk+7whrqJXcO7yr8=;
        b=Ils9S06OrixKYHfOaHMUXCN8wCwirLVGPw2/V8+G2C3heR21AdyUkQQOwN/92fZaiT
         2KcV4moYMMYWUwGsTwCWOjWtjePgiA/v+DuNFq55qaRgOzCItSLXDNrppzic+rPXd7qb
         36sCsrqjrkSSAPqVmzSw05a0hRB0IBxf6vvQxQH2X5OWruB/aP4Esn+E3cpX4q/I8i7L
         SptrVc24zAqK4Brz0lmQD53UPjst1LG9aznT1VswGzsqI4gObozhu8j34Sd1ll3D/EhB
         EAqZsmbrQPHNZU0Za3KmkDC2m6GBrFuUATn4AOZwUsSQCkKE3F5rxMjFxruTTVA/oEDH
         5AxA==
X-Gm-Message-State: AOAM532RTCqpswLCWwOYb93+eM9hAfwfyPLjGWWmq1ZKk6BTxQJ8uGHc
        pAyp6zfvwlcvbB60xzFmBJ7AIEXUZy98Gg==
X-Google-Smtp-Source: ABdhPJzQu1Z3UjOvm1F6NFqwJ/I7ez0bP7KXkdoWi0G8CnlWSU3cH3Ly4WimzcZxvY489SfFYLyexQ==
X-Received: by 2002:a67:b142:: with SMTP id z2mr5778912vsl.39.1640687128313;
        Tue, 28 Dec 2021 02:25:28 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id r9sm434173vke.20.2021.12.28.02.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 02:25:28 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id o1so31276234uap.4;
        Tue, 28 Dec 2021 02:25:28 -0800 (PST)
X-Received: by 2002:a1f:9f04:: with SMTP id i4mr6011121vke.33.1640686631832;
 Tue, 28 Dec 2021 02:17:11 -0800 (PST)
MIME-Version: 1.0
References: <20211227164317.4146918-1-schnelle@linux.ibm.com> <20211227164317.4146918-6-schnelle@linux.ibm.com>
In-Reply-To: <20211227164317.4146918-6-schnelle@linux.ibm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Dec 2021 11:17:00 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW2qsZZqE_hAchoD7_41ak8btTZb0UZE6DsXDehhT63fg@mail.gmail.com>
Message-ID: <CAMuHMdW2qsZZqE_hAchoD7_41ak8btTZb0UZE6DsXDehhT63fg@mail.gmail.com>
Subject: Re: [RFC 05/32] char: impi, tpm: depend on HAS_IOPORT
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
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Corey Minyard <minyard@acm.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Niklas,

Thanks for your patch!

On Mon, Dec 27, 2021 at 5:51 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add this dependency and ifdef
> sections of code using inb()/outb() as alternative access methods.
>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/char/Kconfig             |  3 ++-

Your oneline-summary doesn't cover this file.

>  drivers/char/ipmi/Makefile       | 11 ++++-------
>  drivers/char/ipmi/ipmi_si_intf.c |  3 ++-
>  drivers/char/ipmi/ipmi_si_pci.c  |  3 +++
>  drivers/char/tpm/Kconfig         |  1 +
>  drivers/char/tpm/tpm_infineon.c  | 14 ++++++++++----
>  drivers/char/tpm/tpm_tis_core.c  | 19 ++++++++-----------
>  7 files changed, 30 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 740811893c57..3d046e364e53 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -33,6 +33,7 @@ config TTY_PRINTK_LEVEL
>  config PRINTER
>         tristate "Parallel printer support"
>         depends on PARPORT
> +       depends on HAS_IOPORT

Why? drivers/char/lp.c doesn't use I/O accessors, and should work with
all parport drivers.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
