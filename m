Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDD332EED3
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 16:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhCEP3H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 10:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhCEP2g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Mar 2021 10:28:36 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D540C061574;
        Fri,  5 Mar 2021 07:28:36 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id e6so1610593pgk.5;
        Fri, 05 Mar 2021 07:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uLYLsu/Tg277ivzbocTilYLO6uuOWC+beELR4myHiWQ=;
        b=PKQndGo6w0Ga2p/+wx7fUyr32VdMqomj8GnE5drMTXxNKulXVHiQgWgQN/5s1N5Ugj
         cg/zNGtkrfTYp5YxtSV9FnoE2ygs6l5OAsiH5DM5PHYha/wQMB4slK1/R0e7H7K3U4xu
         oPMNqnqn5ftxZnsS4rbjRvo/rLhyfgfXglFf0qTilnf0gAhEeeNyKGCnMRTByc6+61sa
         M77lUUQAhjOdlV1FbDtgcIYW7lfMQ3p/tScT13i0sU/nALgX5UR9qP5f9zdmdoikk89f
         DHsVHMIhk84iNaoqgPvW9EXZaoF6XthoOXV6KT9e9xekx/nuGQkBfyLPGkXTeTohXhkJ
         09Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uLYLsu/Tg277ivzbocTilYLO6uuOWC+beELR4myHiWQ=;
        b=dhcpRt7k4LByIjQPqs7kKOhWTaj3fEOIa11PSMxoLKUDp0f1D7kHsyqSAlF77kkCZE
         n1UXbg/dNJKJ9jRaS/NYHqxAJEjxDroIqe9C51qYzJwPHizbOtMbNZnieyyAUVlhoxxc
         gnGCNSfkk6SpfU+5KGloj+6FYgyNqFfYW4fUKrLpFiA37Edvo/m18nf8IYbGdFIN6Z12
         3BvlvW0BiTsa3VQgUcTON9Z0197TE1Uc+rBJj11r47AfqSVKtn3E3kSPw/JYuLKIIEu9
         ZdgBHaaaTrlDfTkpKB/wkm1QmgN1rzxfUIQo84eWOEQaLo8SP9x+aoUrFCoLvzzhN6/Q
         yqWw==
X-Gm-Message-State: AOAM531ESJcIPjyeegmxlpMWicP2C8HC4a/jk2BnVxh9yIzeRpbfNc6x
        ritsKebm7sZ0iUsMeiwGM4QakyivUr3Mc15QLDo=
X-Google-Smtp-Source: ABdhPJz3vL0uJ4Zj/ECoBh9S5qEinAHiBZJDk5ytq25zAnnCL2NyXtBzVn+oUmpLroD9lE3sdevKw1cwYGm8/Kw7Rbc=
X-Received: by 2002:a63:ce15:: with SMTP id y21mr9256094pgf.4.1614958116086;
 Fri, 05 Mar 2021 07:28:36 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-25-marcan@marcan.st>
In-Reply-To: <20210304213902.83903-25-marcan@marcan.st>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Mar 2021 17:28:19 +0200
Message-ID: <CAHp75VdFTHPfvdNUZEsn-qUCozASEGXeTDkTTUfOTqZ2TMsfiA@mail.gmail.com>
Subject: Re: [RFT PATCH v3 24/27] tty: serial: samsung_tty: Add support for
 Apple UARTs
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

On Thu, Mar 4, 2021 at 11:42 PM Hector Martin <marcan@marcan.st> wrote:
>
> Apple SoCs are a distant descendant of Samsung designs and use yet
> another variant of their UART style, with different interrupt handling.
>
> In particular, this variant has the following differences with existing
> ones:
>
> * It includes a built-in interrupt controller with different registers,
>   using only a single platform IRQ
>
> * Internal interrupt sources are treated as edge-triggered, even though
>   the IRQ output is level-triggered. This chiefly affects the TX IRQ
>   path: the driver can no longer rely on the TX buffer empty IRQ
>   immediately firing after TX is enabled, but instead must prime the
>   FIFO with data directly.

...

> +       case TYPE_APPLE_S5L:
> +               WARN_ON(1); // No DMA

Oh, no, please use the ONCE variant.

...

> +       /* Apple types use these bits for IRQ masks */
> +       if (ourport->info->type != TYPE_APPLE_S5L) {
> +               ucon &= ~(S3C64XX_UCON_TIMEOUT_MASK |
> +                               S3C64XX_UCON_EMPTYINT_EN |
> +                               S3C64XX_UCON_DMASUS_EN |
> +                               S3C64XX_UCON_TIMEOUT_EN);
> +               ucon |= 0xf << S3C64XX_UCON_TIMEOUT_SHIFT |

Can you spell 0xf with named constant(s), please?

In case they are repetitive via the code, introduce either a temporary
variable (in case it scoped to one function only), or define it as a
constant.

> +                               S3C64XX_UCON_TIMEOUT_EN;
> +       }

...

> +/* interrupt handler for Apple SoC's.*/
> +static irqreturn_t apple_serial_handle_irq(int irq, void *id)
> +{
> +       struct s3c24xx_uart_port *ourport = id;
> +       struct uart_port *port = &ourport->port;
> +       unsigned int pend = rd_regl(port, S3C2410_UTRSTAT);

> +       irqreturn_t ret = IRQ_NONE;

Redundant. You may return directly.

> +
> +       if (pend & (APPLE_S5L_UTRSTAT_RXTHRESH | APPLE_S5L_UTRSTAT_RXTO)) {
> +               wr_regl(port, S3C2410_UTRSTAT,
> +                       APPLE_S5L_UTRSTAT_RXTHRESH | APPLE_S5L_UTRSTAT_RXTO);
> +               ret = s3c24xx_serial_rx_irq(irq, id);
> +       }
> +       if (pend & APPLE_S5L_UTRSTAT_TXTHRESH) {
> +               wr_regl(port, S3C2410_UTRSTAT, APPLE_S5L_UTRSTAT_TXTHRESH);
> +               ret = s3c24xx_serial_tx_irq(irq, id);
> +       }

No IO serialization?

> +       return ret;
> +}

...

> +static void apple_s5l_serial_shutdown(struct uart_port *port)
> +{
> +       struct s3c24xx_uart_port *ourport = to_ourport(port);

> +

Extra blank line (check your entire series for a such)

> +       unsigned int ucon;

> +       ourport->tx_in_progress = 0;
> +}

...

> +       ourport->rx_enabled = 1;
> +       ourport->tx_enabled = 0;

How are these protected against race?

...

> +               case TYPE_APPLE_S5L: {
> +                       unsigned int ucon;
> +                       int ret;
> +
> +                       ret = clk_prepare_enable(ourport->clk);
> +                       if (ret) {
> +                               dev_err(dev, "clk_enable clk failed: %d\n", ret);
> +                               return ret;
> +                       }
> +                       if (!IS_ERR(ourport->baudclk)) {
> +                               ret = clk_prepare_enable(ourport->baudclk);
> +                               if (ret) {
> +                                       dev_err(dev, "clk_enable baudclk failed: %d\n", ret);
> +                                       clk_disable_unprepare(ourport->clk);
> +                                       return ret;
> +                               }
> +                       }

Wouldn't it be better to use CLK bulk API?

> +                       ucon = rd_regl(port, S3C2410_UCON);
> +
> +                       ucon &= ~(APPLE_S5L_UCON_TXTHRESH_ENA_MSK |
> +                                 APPLE_S5L_UCON_RXTHRESH_ENA_MSK |
> +                                 APPLE_S5L_UCON_RXTO_ENA_MSK);
> +
> +                       if (ourport->tx_enabled)
> +                               ucon |= APPLE_S5L_UCON_TXTHRESH_ENA_MSK;
> +                       if (ourport->rx_enabled)
> +                               ucon |= APPLE_S5L_UCON_RXTHRESH_ENA_MSK |
> +                                       APPLE_S5L_UCON_RXTO_ENA_MSK;
> +
> +                       wr_regl(port, S3C2410_UCON, ucon);
> +
> +                       if (!IS_ERR(ourport->baudclk))
> +                               clk_disable_unprepare(ourport->baudclk);
> +                       clk_disable_unprepare(ourport->clk);
> +                       break;
> +               }

...

> +#ifdef CONFIG_ARCH_APPLE

Why? Wouldn't you like the one kernel to work on many SoCs?

> +static struct s3c24xx_serial_drv_data s5l_serial_drv_data = {
> +       .info = &(struct s3c24xx_uart_info) {
> +               .name           = "Apple S5L UART",
> +               .type           = TYPE_APPLE_S5L,
> +               .port_type      = PORT_8250,
> +               .fifosize       = 16,
> +               .rx_fifomask    = S3C2410_UFSTAT_RXMASK,
> +               .rx_fifoshift   = S3C2410_UFSTAT_RXSHIFT,
> +               .rx_fifofull    = S3C2410_UFSTAT_RXFULL,
> +               .tx_fifofull    = S3C2410_UFSTAT_TXFULL,
> +               .tx_fifomask    = S3C2410_UFSTAT_TXMASK,
> +               .tx_fifoshift   = S3C2410_UFSTAT_TXSHIFT,
> +               .def_clk_sel    = S3C2410_UCON_CLKSEL0,
> +               .num_clks       = 1,
> +               .clksel_mask    = 0,
> +               .clksel_shift   = 0,
> +       },
> +       .def_cfg = &(struct s3c2410_uartcfg) {
> +               .ucon           = APPLE_S5L_UCON_DEFAULT,
> +               .ufcon          = S3C2410_UFCON_DEFAULT,
> +       },
> +};
> +#define S5L_SERIAL_DRV_DATA ((kernel_ulong_t)&s5l_serial_drv_data)
> +#else
> +#define S5L_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
> +#endif

...

> +#define APPLE_S5L_UCON_RXTO_ENA_MSK    (1 << APPLE_S5L_UCON_RXTO_ENA)
> +#define APPLE_S5L_UCON_RXTHRESH_ENA_MSK        (1 << APPLE_S5L_UCON_RXTHRESH_ENA)
> +#define APPLE_S5L_UCON_TXTHRESH_ENA_MSK        (1 << APPLE_S5L_UCON_TXTHRESH_ENA)

BIT() ?

...

> +#define APPLE_S5L_UCON_DEFAULT         (S3C2410_UCON_TXIRQMODE | \
> +                                        S3C2410_UCON_RXIRQMODE | \
> +                                        S3C2410_UCON_RXFIFO_TOI)

Indentation level is too high. Hint: start a value of the definition
on the new line.

...

> +#define APPLE_S5L_UTRSTAT_RXTHRESH     (1<<4)
> +#define APPLE_S5L_UTRSTAT_TXTHRESH     (1<<5)
> +#define APPLE_S5L_UTRSTAT_RXTO         (1<<9)
> +#define APPLE_S5L_UTRSTAT_ALL_FLAGS    (0x3f0)

BIT() ?

-- 
With Best Regards,
Andy Shevchenko
