Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612ED32EE3B
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 16:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhCEPS2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 10:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhCEPSL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Mar 2021 10:18:11 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E258AC061574;
        Fri,  5 Mar 2021 07:18:10 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id t29so2233875pfg.11;
        Fri, 05 Mar 2021 07:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GXgybONIV8Un/qYPL7SKvbrjGoX85mO1+G2xJKWHF3E=;
        b=sD7+gFdq32Xgi82kLRFU8pXvDETXmXWFq5ktrjMXiKtsFmc3tkBTGl9OPNcRVS5S1b
         IQ8Qy9pw5yhF+GRTj/D4QgtyP/q4b3ystH7neC7qz6vtSMyvO6BSxV7KiAUQcNTr4UTi
         5KzToosJ1xdv0MJzEJ4ZWNTmXIdCIvacx//eXGz1ybbrCC2aMRzLyvynSO6siknF4F2D
         NCPyOWqq6NtQjMtp/YeP3aFWj3ZOoB+dz1yNVlYk9dPrEnwszpngqSI+Hp8GP8mYfmOS
         mKVoPJc3PEXRPc3oJnF3AMEg+DsH7/RF4pfDcZAGq/vKTIQf/GubK/io8czwxLxuvav4
         sBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GXgybONIV8Un/qYPL7SKvbrjGoX85mO1+G2xJKWHF3E=;
        b=WvRFsvYVU2u5jPxosEObfUKDPza5H9fyj2Qp4OqJPq8rmd78J0Cq+NaOZYBynZwFli
         QQIPZOPkOMrRLxsvzBz14bwA84RvG+MpagVR8ozFcY20ZWy4D2lwakfQOVwYHRUZMHrt
         54f7Q5O+Z9Bd0/OuARim1Z7VlOIzd4Ef9Pe9XDBjssEfpqmlOusGTHhrR0PEBQcaKCRA
         dbN088QBKxfKljeXUoYgRAQ00gp/hN/ARDM0bqzEWHFwcTMaMwSRDZpdNsBaHmF2gcf4
         o1R0+8DoDhACzweY16hmFI9flmTxX8c/gCmr0DG8KUNjX3MTIkPBjok78/4kIXgFN1jr
         ezgA==
X-Gm-Message-State: AOAM5321AoS/If88BiOw0o0ln9HeyG4mNTR14y7/W3PEJJmBTj7rZoY6
        Gfw9OKuWwS/9YrPUcmoPOJBo+CvurSLVACHHx3Y=
X-Google-Smtp-Source: ABdhPJyUU6I/nYiB5+xIlT+woCy/dtsvBTSu8eJVmQJh5/G5wQS/XU/eYDIMbG6chJU3ZJn8dUFbp5bYBMEgzydMDww=
X-Received: by 2002:a05:6a00:854:b029:1b7:6233:c5f with SMTP id
 q20-20020a056a000854b02901b762330c5fmr9460771pfk.73.1614957490271; Fri, 05
 Mar 2021 07:18:10 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-22-marcan@marcan.st>
In-Reply-To: <20210304213902.83903-22-marcan@marcan.st>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Mar 2021 17:17:54 +0200
Message-ID: <CAHp75Vc+t9_FNHZ0xYNaJ1+Ny+FFeZKA79abxV2NAsZvpBh3Bg@mail.gmail.com>
Subject: Re: [RFT PATCH v3 21/27] tty: serial: samsung_tty: IRQ rework
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 4, 2021 at 11:41 PM Hector Martin <marcan@marcan.st> wrote:
>
> * Split out s3c24xx_serial_tx_chars from s3c24xx_serial_tx_irq,
>   where only the latter acquires the port lock. This will be necessary
>   on platforms which have edge-triggered IRQs, as we need to call
>   s3c24xx_serial_tx_chars to kick off transmission from outside IRQ
>   context, with the port lock held.
>
> * Rename s3c24xx_serial_rx_chars to s3c24xx_serial_rx_irq for
>   consistency with the above. All it does now is call two other
>   functions anyway.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/tty/serial/samsung_tty.c | 34 +++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 39b2eb165bdc..7106eb238d8c 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -827,7 +827,7 @@ static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
>         return IRQ_HANDLED;
>  }
>
> -static irqreturn_t s3c24xx_serial_rx_chars(int irq, void *dev_id)
> +static irqreturn_t s3c24xx_serial_rx_irq(int irq, void *dev_id)
>  {
>         struct s3c24xx_uart_port *ourport = dev_id;
>
> @@ -836,16 +836,12 @@ static irqreturn_t s3c24xx_serial_rx_chars(int irq, void *dev_id)
>         return s3c24xx_serial_rx_chars_pio(dev_id);
>  }
>
> -static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
> +static void s3c24xx_serial_tx_chars(struct s3c24xx_uart_port *ourport)
>  {
> -       struct s3c24xx_uart_port *ourport = id;
>         struct uart_port *port = &ourport->port;
>         struct circ_buf *xmit = &port->state->xmit;
> -       unsigned long flags;
>         int count, dma_count = 0;
>
> -       spin_lock_irqsave(&port->lock, flags);
> -
>         count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
>
>         if (ourport->dma && ourport->dma->tx_chan &&
> @@ -862,7 +858,7 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
>                 wr_reg(port, S3C2410_UTXH, port->x_char);
>                 port->icount.tx++;
>                 port->x_char = 0;
> -               goto out;
> +               return;
>         }
>
>         /* if there isn't anything more to transmit, or the uart is now
> @@ -871,7 +867,7 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
>
>         if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
>                 s3c24xx_serial_stop_tx(port);
> -               goto out;
> +               return;
>         }
>
>         /* try and drain the buffer... */
> @@ -893,7 +889,7 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
>
>         if (!count && dma_count) {
>                 s3c24xx_serial_start_tx_dma(ourport, dma_count);
> -               goto out;
> +               return;
>         }
>
>         if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS) {
> @@ -904,8 +900,18 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
>
>         if (uart_circ_empty(xmit))
>                 s3c24xx_serial_stop_tx(port);
> +}
> +
> +static irqreturn_t s3c24xx_serial_tx_irq(int irq, void *id)
> +{
> +       struct s3c24xx_uart_port *ourport = id;
> +       struct uart_port *port = &ourport->port;
> +       unsigned long flags;
> +


> +       spin_lock_irqsave(&port->lock, flags);
> +
> +       s3c24xx_serial_tx_chars(ourport);
>
> -out:
>         spin_unlock_irqrestore(&port->lock, flags);

Add a separate change that removes flags from the spin lock in the IRQ handler.

>         return IRQ_HANDLED;
>  }
> @@ -919,11 +925,11 @@ static irqreturn_t s3c64xx_serial_handle_irq(int irq, void *id)
>         irqreturn_t ret = IRQ_HANDLED;
>
>         if (pend & S3C64XX_UINTM_RXD_MSK) {
> -               ret = s3c24xx_serial_rx_chars(irq, id);
> +               ret = s3c24xx_serial_rx_irq(irq, id);
>                 wr_regl(port, S3C64XX_UINTP, S3C64XX_UINTM_RXD_MSK);
>         }
>         if (pend & S3C64XX_UINTM_TXD_MSK) {
> -               ret = s3c24xx_serial_tx_chars(irq, id);
> +               ret = s3c24xx_serial_tx_irq(irq, id);
>                 wr_regl(port, S3C64XX_UINTP, S3C64XX_UINTM_TXD_MSK);
>         }
>         return ret;
> @@ -1155,7 +1161,7 @@ static int s3c24xx_serial_startup(struct uart_port *port)
>
>         ourport->rx_enabled = 1;
>
> -       ret = request_irq(ourport->rx_irq, s3c24xx_serial_rx_chars, 0,
> +       ret = request_irq(ourport->rx_irq, s3c24xx_serial_rx_irq, 0,
>                           s3c24xx_serial_portname(port), ourport);
>
>         if (ret != 0) {
> @@ -1169,7 +1175,7 @@ static int s3c24xx_serial_startup(struct uart_port *port)
>
>         ourport->tx_enabled = 1;
>
> -       ret = request_irq(ourport->tx_irq, s3c24xx_serial_tx_chars, 0,
> +       ret = request_irq(ourport->tx_irq, s3c24xx_serial_tx_irq, 0,
>                           s3c24xx_serial_portname(port), ourport);
>
>         if (ret) {
> --
> 2.30.0
>


-- 
With Best Regards,
Andy Shevchenko
