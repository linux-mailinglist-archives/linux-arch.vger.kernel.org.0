Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27956C77A4
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 07:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCXGLI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Mar 2023 02:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjCXGLH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2023 02:11:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35D81554F;
        Thu, 23 Mar 2023 23:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=o8GyCLdqZI9t+Daq6eq68G2ZZ4b2XpF2IvGRiP6/CDU=; b=tu0UUQHu2yZU5mA/5Vw6tv7GYW
        TBBSOVpTIR+dhrDRoQU8qF+0JzyO59axpNdqbH9x/X0rFD8mL085g7m1a1Rv7p1BEzmZ8xRza4360
        QPflV6WYoB7Ybjy1q5kBZFOaZs/nZxaNnHFT1ZqZxi2mF6DIi5HIwQ4m6EbBONcGnfpEKik5oOOAx
        7AQBrCLwOfaS1oPe0hO+CLk+sJZGzdmYxrAdA+pVx9ob1dq3sdkmwzmfWKyMaMzshxEr/gD81B3+e
        TmEsb5m5u4bKNmbE2prromJC8XaAxQuU8OaA3RbEqFJMpuuBacYRPJN7TOEgzltyOMjYWT1o4ues4
        bPphdAUg==;
Received: from [2601:1c2:980:9ec0::21b4]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pfadi-003eY8-2N;
        Fri, 24 Mar 2023 06:11:02 +0000
Message-ID: <24da75fa-b0f9-b9ff-5b34-42ae6fc2ba24@infradead.org>
Date:   Thu, 23 Mar 2023 23:11:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] irq domain: drop IRQ_DOMAIN_HIERARCHY option, make it
 always on
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20230313023935.31037-1-rdunlap@infradead.org>
 <877cv78a1b.ffs@tglx>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <877cv78a1b.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Thomas,

On 3/23/23 13:53, Thomas Gleixner wrote:
> On Sun, Mar 12 2023 at 19:39, Randy Dunlap wrote:
>> In preparation for dropping the IRQ_DOMAIN Kconfig option (effectively
>> making it always set/on), first drop IRQ_DOMAIN_HIERARCHY as an option,
>> making its code always set/on.
>>
>> This has been built successfully on all ARCHes except hexagon,
>> both 32-bit and 64-bit where applicable.
> 
> I really like where this is going, but reviewing this is a pain. I tried
> to split it up into more digestable pieces:
> 
>    https://tglx.de/~tglx/patches.tar
> 
> That's not completely equivalent to your patch as I did some of the
> changes below. It builds on various oddball architectures with
> IRQ_DOMAIN=n, but is otherwise completely untested.
> 
> It should be actually trivial after that to make IRQ_DOMAIN def_bool y
> and then gradually remove the IRQ_DOMAIN selects and ifdeffery.

Yeah, that may be the best & simplest approach.

Or just use your patches.tar.

>> v2: add stubs in include/linux/irqdomain.h for the config case of
>> IRQ_DOMAIN is not set. If these are not added, there will be plenty
>> of build errors (not so much for modern arches as for older ones).
> 
> I'm not really convinced that all of these stubs are required. Why would
> there suddenly be a requirement to expose stubs for functions which
> depend on CONFIG_IRQ_DOMAIN=y already today just by removing the
> hierarchy config?

All of those stubs were added because I had configs/builds that were
failing due to them. I didn't just add them for fun or "completeness."

I just checked and I didn't save all of those failing configs or
output files that contain the errors.


> Even exposing stubs for functions which have been only available via
> CONFIG_IRQ_DOMAIN_HIERARCHY is questionable simply because there cannot
> be any code which invokes them unconditionally if
> CONFIG_IRQ_DOMAIN_HIERARCHY=n today.
> 
> IOW, the sum of required stubs cannot be larger than number of stubs
> required today.
> 
> If there is code which has a #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY then
> this needs to be changed to CONFIG_IRQ_DOMAIN or the required functions
> have to be exposed unconditionally, right?

Yes, s/CONFIG_IRQ_DOMAIN_HIERARCHY/CONFIG_IRQ_DOMAIN/ in code.


>> diff -- a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
>> --- a/drivers/gpio/Kconfig
>> +++ b/drivers/gpio/Kconfig
>> @@ -361,7 +361,7 @@ config GPIO_IXP4XX
>>  	depends on OF
>>  	select GPIO_GENERIC
>>  	select GPIOLIB_IRQCHIP
>> -	select IRQ_DOMAIN_HIERARCHY
>> +	select IRQ_DOMAIN
> 
> IRQ_DOMAIN is already selected by GPIOLIB_IRQCHIP, so this select is
> redundant for all GPIO configs which select GPIOLIB_IRQCHIP.

Ack.

I'm perfectly happy to use either Marc's patch that he posted on
2023-FEB-14 (https://lore.kernel.org/all/86y1p0xbqd.wl-maz@kernel.org/)
or your patches. Both of you know your way around this better than I do.

Thanks for your review and feedback.

-- 
~Randy
