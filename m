Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10156C71E2
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 21:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjCWUxJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 16:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWUxH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 16:53:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237B3211D9;
        Thu, 23 Mar 2023 13:53:07 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679604785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/1rYDeXeXdW0cuqWo9UuJC5RYidgtmZSNCr4/RwqvXg=;
        b=kCFatXP07k+7ELzDIE3JTCvp4GpTnFsSYJVF8TY++iD9F33t0ypFsp2djOR123wyiPBUFl
        edUT3UFpBESREWBdgBB0RdGstybe1YRSlALb74nyo36FQPCCvjNaZautJKFq71MAg33Zfu
        7DgkXp/TCDMoObM5KIrAjBONh0jSQSVIzaKBKuqzS21tN+o3pLms6sIH4olxjTQOlUhDcd
        lEU7aGONdS5+0lqIOcIquj2cdG45IcD7/801f6UyE4sl5rTI2KAoHEypMTlEW4Gieq0T3T
        aiT1jG4LhuuBEuFZOHrvl8eqbAAmEXnTYNEnxtuyO6qj6ejw4TUz3UWvsn5Oaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679604785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/1rYDeXeXdW0cuqWo9UuJC5RYidgtmZSNCr4/RwqvXg=;
        b=en2d05+owSRS5DeKKg4zUpsBpaYDlKJlhWl+48pw84bzkbJyCo+8luXKBa/JrihpiQjr1n
        GD174VWof6W8QVBw==
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2] irq domain: drop IRQ_DOMAIN_HIERARCHY option, make
 it always on
In-Reply-To: <20230313023935.31037-1-rdunlap@infradead.org>
References: <20230313023935.31037-1-rdunlap@infradead.org>
Date:   Thu, 23 Mar 2023 21:53:04 +0100
Message-ID: <877cv78a1b.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Mar 12 2023 at 19:39, Randy Dunlap wrote:
> In preparation for dropping the IRQ_DOMAIN Kconfig option (effectively
> making it always set/on), first drop IRQ_DOMAIN_HIERARCHY as an option,
> making its code always set/on.
>
> This has been built successfully on all ARCHes except hexagon,
> both 32-bit and 64-bit where applicable.

I really like where this is going, but reviewing this is a pain. I tried
to split it up into more digestable pieces:

   https://tglx.de/~tglx/patches.tar

That's not completely equivalent to your patch as I did some of the
changes below. It builds on various oddball architectures with
IRQ_DOMAIN=n, but is otherwise completely untested.

It should be actually trivial after that to make IRQ_DOMAIN def_bool y
and then gradually remove the IRQ_DOMAIN selects and ifdeffery.

> v2: add stubs in include/linux/irqdomain.h for the config case of
> IRQ_DOMAIN is not set. If these are not added, there will be plenty
> of build errors (not so much for modern arches as for older ones).

I'm not really convinced that all of these stubs are required. Why would
there suddenly be a requirement to expose stubs for functions which
depend on CONFIG_IRQ_DOMAIN=y already today just by removing the
hierarchy config?

Even exposing stubs for functions which have been only available via
CONFIG_IRQ_DOMAIN_HIERARCHY is questionable simply because there cannot
be any code which invokes them unconditionally if
CONFIG_IRQ_DOMAIN_HIERARCHY=n today.

IOW, the sum of required stubs cannot be larger than number of stubs
required today.

If there is code which has a #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY then
this needs to be changed to CONFIG_IRQ_DOMAIN or the required functions
have to be exposed unconditionally, right?

> diff -- a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -361,7 +361,7 @@ config GPIO_IXP4XX
>  	depends on OF
>  	select GPIO_GENERIC
>  	select GPIOLIB_IRQCHIP
> -	select IRQ_DOMAIN_HIERARCHY
> +	select IRQ_DOMAIN

IRQ_DOMAIN is already selected by GPIOLIB_IRQCHIP, so this select is
redundant for all GPIO configs which select GPIOLIB_IRQCHIP.

Thanks,

        tglx
