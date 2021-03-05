Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5266232F0A0
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 18:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhCEREj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 12:04:39 -0500
Received: from marcansoft.com ([212.63.210.85]:57614 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231426AbhCERE3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Mar 2021 12:04:29 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 583A83FA1B;
        Fri,  5 Mar 2021 17:04:20 +0000 (UTC)
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-25-marcan@marcan.st>
 <CAHp75VdFTHPfvdNUZEsn-qUCozASEGXeTDkTTUfOTqZ2TMsfiA@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [RFT PATCH v3 24/27] tty: serial: samsung_tty: Add support for
 Apple UARTs
Message-ID: <2ed7523f-5c11-976f-ac11-f756d7510400@marcan.st>
Date:   Sat, 6 Mar 2021 02:04:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdFTHPfvdNUZEsn-qUCozASEGXeTDkTTUfOTqZ2TMsfiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 06/03/2021 00.28, Andy Shevchenko wrote:
>> +       case TYPE_APPLE_S5L:
>> +               WARN_ON(1); // No DMA
> 
> Oh, no, please use the ONCE variant.

Thanks, changing this for v4.

> 
> ...
> 
>> +       /* Apple types use these bits for IRQ masks */
>> +       if (ourport->info->type != TYPE_APPLE_S5L) {
>> +               ucon &= ~(S3C64XX_UCON_TIMEOUT_MASK |
>> +                               S3C64XX_UCON_EMPTYINT_EN |
>> +                               S3C64XX_UCON_DMASUS_EN |
>> +                               S3C64XX_UCON_TIMEOUT_EN);
>> +               ucon |= 0xf << S3C64XX_UCON_TIMEOUT_SHIFT |
> 
> Can you spell 0xf with named constant(s), please?
> 
> In case they are repetitive via the code, introduce either a temporary
> variable (in case it scoped to one function only), or define it as a
> constant.

I'm just moving this code; as far as I can tell this is a timeout value 
(so just an integer), but I don't know if there is any special meaning 
to 0xf here. Note that this codepath is for *non-Apple* chips, as the 
Apple ones don't even have this field (at least not here).

>> +       irqreturn_t ret = IRQ_NONE;
> 
> Redundant. You may return directly.

What if both interrupts are pending?

> No IO serialization?

There is no DMA on the Apple variants (as far as I know; it's not 
implemented anyway), so there is no need for serializing IO with DMA. In 
any case, dealing with that is the DMA code's job, the interrupt handler 
shouldn't need to care.

If you mean serializing IO with the IRQ: CPU-wise, I would hope that's 
the irqchip's job (AIC does this with a readl on the event). If you mean 
ensuring all writes are complete (i.e. posted write issue), on the Apple 
chips everything is non-posted as explained in the previous patches.

> Extra blank line (check your entire series for a such)

Thanks, noted. I'll check the declaration blocks in other patches.

>> +       ourport->rx_enabled = 1;
>> +       ourport->tx_enabled = 0;
> 
> How are these protected against race?

The serial core should be holding the port mutex for pretty much every 
call into the driver, as far as I can tell.

> 
> ...
> 
>> +               case TYPE_APPLE_S5L: {
>> +                       unsigned int ucon;
>> +                       int ret;
>> +
>> +                       ret = clk_prepare_enable(ourport->clk);
>> +                       if (ret) {
>> +                               dev_err(dev, "clk_enable clk failed: %d\n", ret);
>> +                               return ret;
>> +                       }
>> +                       if (!IS_ERR(ourport->baudclk)) {
>> +                               ret = clk_prepare_enable(ourport->baudclk);
>> +                               if (ret) {
>> +                                       dev_err(dev, "clk_enable baudclk failed: %d\n", ret);
>> +                                       clk_disable_unprepare(ourport->clk);
>> +                                       return ret;
>> +                               }
>> +                       }
> 
> Wouldn't it be better to use CLK bulk API?

Ah, I guess that could save a line or two of code here, even though it 
requires setting up the array. I'll give it a shot.

>> +#ifdef CONFIG_ARCH_APPLE
> 
> Why? Wouldn't you like the one kernel to work on many SoCs?

This *adds* Apple support, it is not mutually exclusive with all the 
other SoCs. You can enable all of those options and get a driver that 
works on all of them. This is the same pattern used throughout the 
driver for all the other Samsung variants. There is no reason to have 
Apple SoC support in the samsung driver if the rest of the kernel 
doesn't have Apple SoC support either, of course.

>> +#define APPLE_S5L_UCON_RXTO_ENA_MSK    (1 << APPLE_S5L_UCON_RXTO_ENA)
>> +#define APPLE_S5L_UCON_RXTHRESH_ENA_MSK        (1 << APPLE_S5L_UCON_RXTHRESH_ENA)
>> +#define APPLE_S5L_UCON_TXTHRESH_ENA_MSK        (1 << APPLE_S5L_UCON_TXTHRESH_ENA)
> 
> BIT() ?

I'm trying to keep the style of the rest of the file here, which doesn't 
use BIT() anywhere. I agree this header could use some work though... I 
wonder if I've met my required quota of cleanups to this driver for this 
patchset ;-)

>> +#define APPLE_S5L_UCON_DEFAULT         (S3C2410_UCON_TXIRQMODE | \
>> +                                        S3C2410_UCON_RXIRQMODE | \
>> +                                        S3C2410_UCON_RXFIFO_TOI)
> 
> Indentation level is too high. Hint: start a value of the definition
> on the new line.

Is it that bad? It's within 80 cols, putting one bit per line is more 
readable than several on one line, and this is how the rest of the 
header is written. Is it really better to do

#define APPLE_S5L_UCON_DEFAULT \
	(S3C2410_UCON_TXIRQMODE | S3C2410_UCON_RXIRQMODE | \
	 S3C2410_UCON_RXFIFO_TOI)

or

#define APPLE_S5L_UCON_DEFAULT \
		(S3C2410_UCON_TXIRQMODE | \
		 S3C2410_UCON_RXIRQMODE | \
		 S3C2410_UCON_RXFIFO_TOI)

here? Those don't look like an obvious improvement to me, I'd even say 
overlapping the bits and the macro name in the same columns makes it 
less readable to my eyes.

>> +#define APPLE_S5L_UTRSTAT_RXTHRESH     (1<<4)
>> +#define APPLE_S5L_UTRSTAT_TXTHRESH     (1<<5)
>> +#define APPLE_S5L_UTRSTAT_RXTO         (1<<9)
>> +#define APPLE_S5L_UTRSTAT_ALL_FLAGS    (0x3f0)
> 
> BIT() ?

See above.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
