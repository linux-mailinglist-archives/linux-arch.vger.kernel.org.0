Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9026706AC6
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 16:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjEQOPs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 10:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjEQOPr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 10:15:47 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13249C0
        for <linux-arch@vger.kernel.org>; Wed, 17 May 2023 07:15:45 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-43627012261so216469137.2
        for <linux-arch@vger.kernel.org>; Wed, 17 May 2023 07:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1684332944; x=1686924944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhkiIjPom+AxXYktEbUGoiA5T8CFiFkldMIkLPxRd/I=;
        b=btMjxiay7nTs9qGr2zF9OAO0jpL42voTb/3qx7U+H6IjvybBo2YPtO8ipdMK5+vh2A
         0oVFC9RDLnqBM7wIkRssr9lRFjlzCpvN0QnAy//EbHeJ1qJYB6qH62/p510KIYQqzd0/
         vaiJ1In/L259P2iCso5nuf+Pmcp+e96jB3D2//famDOz2Ht8iSuuJW9GVT1+DEPnGs2/
         UvLCJuFNXTA7zQ6KIoZ2P8ksaUuxhAMNObn3WTbmXYL+GhbGs850pVFCtZCvBiUi0TRU
         ISPxSRNz/U3C41t/l2Xz7RZv02kXsJJkw/gT+ZEF5gADx9H+/BAG9k7aqA64/KsCz+mF
         zl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684332944; x=1686924944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhkiIjPom+AxXYktEbUGoiA5T8CFiFkldMIkLPxRd/I=;
        b=dwb11zAGXI+L1Wg7tpjev6GFbjmPD6N3cZx/lkLb5VYaRd+NEl0SAi3unaLaNPGNJd
         5qb9Gy7u23CPvCR40xjPafi0Cb6YNG4Z12x40nd0A8MS32q1TCKWGxDMjw2HCFBQsh1i
         jS4N1sNGbgd+mGlrADx5fqHDyhtPHy+8qjaocSa4Olmre1hWtTrmOKY8zlQTFgJ+kQT3
         ZWgD30h7QGhMLY+6oTke9RA4m8kAW241K+5kufOsFsYNY+sjRfVOm/6wVSHC2tl+Poqe
         ePWm/c1/MCM8Hb0D3eRCTmEiqvoSMH/a3PoeRo1UZz/mXWrdNDGJkFXBNS4urvsnTKLU
         /Huw==
X-Gm-Message-State: AC+VfDwg1F8DX9G8nqwPZ2Hx5p+ejFhjUTnmXBIFSjjouVAF92kKtolp
        rkebiV47IeOS6h5JGjfxo9+Q+TD/it3EjRPNNJPhtA==
X-Google-Smtp-Source: ACHHUZ69WfWL4WTiwk755kvqeutjvUUlmYSAmwRFi+TJ9UfsaagdkkjZ1uXo7yV+e1+514xM6y+BFWbESVx/LjXArlM=
X-Received: by 2002:a67:fd98:0:b0:434:7765:3330 with SMTP id
 k24-20020a67fd98000000b0043477653330mr16597840vsq.15.1684332944178; Wed, 17
 May 2023 07:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230516110038.2413224-1-schnelle@linux.ibm.com> <20230516110038.2413224-10-schnelle@linux.ibm.com>
In-Reply-To: <20230516110038.2413224-10-schnelle@linux.ibm.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 17 May 2023 16:15:33 +0200
Message-ID: <CAMRc=Mc+5BSra2oLnNrCqU+ZRfWdUGXAu0P8pay0+UFmBjC6eg@mail.gmail.com>
Subject: Re: [PATCH v4 09/41] gpio: add HAS_IOPORT dependencies
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 16, 2023 at 1:00=E2=80=AFPM Niklas Schnelle <schnelle@linux.ibm=
.com> wrote:
>
> In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> Note: The HAS_IOPORT Kconfig option was added in v6.4-rc1 so
>       per-subsystem patches may be applied independently
>
>  drivers/gpio/Kconfig | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 5521f060d58e..a470ec8d617b 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -704,18 +704,6 @@ config GPIO_VISCONTI
>         help
>           Say yes here to support GPIO on Tohisba Visconti.
>
> -config GPIO_VX855
> -       tristate "VIA VX855/VX875 GPIO"
> -       depends on (X86 || COMPILE_TEST) && PCI
> -       select MFD_CORE
> -       select MFD_VX855
> -       help
> -         Support access to the VX855/VX875 GPIO lines through the GPIO l=
ibrary.
> -
> -         This driver provides common support for accessing the device.
> -         Additional drivers must be enabled in order to use the
> -         functionality of the device.
> -
>  config GPIO_WCD934X
>         tristate "Qualcomm Technologies Inc WCD9340/WCD9341 GPIO controll=
er driver"
>         depends on MFD_WCD934X && OF_GPIO
> @@ -835,7 +823,19 @@ config GPIO_IDT3243X
>  endmenu
>
>  menu "Port-mapped I/O GPIO drivers"
> -       depends on X86 # Unconditional I/O space access
> +       depends on X86 && HAS_IOPORT # I/O space access
> +
> +config GPIO_VX855
> +       tristate "VIA VX855/VX875 GPIO"
> +       depends on PCI
> +       select MFD_CORE
> +       select MFD_VX855
> +       help
> +         Support access to the VX855/VX875 GPIO lines through the GPIO l=
ibrary.
> +
> +         This driver provides common support for accessing the device.
> +         Additional drivers must be enabled in order to use the
> +         functionality of the device.
>
>  config GPIO_I8255
>         tristate
> --
> 2.39.2
>

Applied, thanks!

Bart
