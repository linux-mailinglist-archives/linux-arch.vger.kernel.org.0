Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 454318FC85
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2019 09:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfHPHjP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Aug 2019 03:39:15 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36561 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfHPHjP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Aug 2019 03:39:15 -0400
Received: by mail-ot1-f67.google.com with SMTP id k18so8886054otr.3;
        Fri, 16 Aug 2019 00:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rNgiwRT8IqruHTtyg4qTM81WOjWWtlc2s7dRDLMNYXA=;
        b=on2SQVhJOHdWQEc2H0aF4Jqh7WDKMaXEPJG0U44YSRI2ocAwWxoXKuH2/IozeNBHrn
         RRsomVVULDyN4ka0XyJ3p0LL06HWLk4zps+lQyUsuN8bGL5vDSfV3ZJtTv8y29oqQ25I
         ayiVC4RDsQiNyNyXqS9ncR36jlfkDPI7eOIRX9RdqNsKEB67cqfpi5SEPEq/PhLVVEHT
         kWo7XRXgls6Ie27GjuPtsA4kr7DqdpQsXZHlNGBbonWzZsluRfad9zMN/tbC2dxLNbOa
         9wjJ4ueGJ6XdT6lo+dZOkjbcsPjeVVSFgZ4k+agXVPLlJMvzL+5vCFslH8BJJOrdnaky
         UPoA==
X-Gm-Message-State: APjAAAUTYusEKAqYIKMSacN1O2sFRtHtSqJVLJnBfLEuwXrRO3Ii+QQW
        9U4jvzNBC757WAlWPqcnfnt7irBVh++8Jx6y98kC7voz
X-Google-Smtp-Source: APXvYqz193ixgGnhQHDM0sA58o87yH16orCv5VbCTsKEDkS808wZnFykFKzgKwDR213pxnj04zPYszKH8AWAfSfEEwQ=
X-Received: by 2002:a9d:68c5:: with SMTP id i5mr6603053oto.250.1565941154237;
 Fri, 16 Aug 2019 00:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190816062435.881-1-hch@lst.de> <20190816062435.881-7-hch@lst.de>
In-Reply-To: <20190816062435.881-7-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 16 Aug 2019 09:39:03 +0200
Message-ID: <CAMuHMdVj+4Kh6pRGrz32w4zgwGHH4-r+-iHX1CSAXU6t4sprJw@mail.gmail.com>
Subject: Re: [PATCH 6/6] driver core: initialize a default DMA mask for
 platform device
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Gavin Li <git@thegavinli.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Geoff Levand <geoff@infradead.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bin Liu <b-liu@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        USB list <linux-usb@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Christoph,

On Fri, Aug 16, 2019 at 8:30 AM Christoph Hellwig <hch@lst.de> wrote:
> We still treat devices without a DMA mask as defaulting to 32-bits for
> both mask, but a few releases ago we've started warning about such
> cases, as they require special cases to work around this sloppyness.
> Add a dma_mask field to struct platform_device so that we can initialize
> the dma_mask pointer in struct device and initialize both masks to
> 32-bits by default, replacing similar functionality in m68k and
> powerpc.  The arch_setup_pdev_archdata hooks is now unused and removed.
>
> Note that the code looks a little odd with the various conditionals
> because we have to support platform_device structures that are
> statically allocated.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/m68k/kernel/dma.c               |  9 -------

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

>  arch/sh/boards/mach-ecovec24/setup.c |  2 --
>  arch/sh/boards/mach-migor/setup.c    |  1 -

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
given "[PATCH 0/2] Remove calls to empty arch_setup_pdev_archdata()"
https://lore.kernel.org/linux-renesas-soc/1526641611-2769-1-git-send-email-geert+renesas@glider.be/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
