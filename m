Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C41E34A846
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 14:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhCZNkw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 09:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhCZNko (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Mar 2021 09:40:44 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB44DC0613AA;
        Fri, 26 Mar 2021 06:40:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 481D83FA15;
        Fri, 26 Mar 2021 13:40:29 +0000 (UTC)
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
 <20210304213902.83903-17-marcan@marcan.st>
 <CAHp75Vco_rcjHJ4THLZ8CJP=yX2fesfAo_tOY8zohfSmTLEVgw@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [RFT PATCH v3 16/27] irqchip/apple-aic: Add support for the Apple
 Interrupt Controller
Message-ID: <8d7aced9-4aac-0821-a4b7-d27cb73be301@marcan.st>
Date:   Fri, 26 Mar 2021 22:40:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vco_rcjHJ4THLZ8CJP=yX2fesfAo_tOY8zohfSmTLEVgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 06/03/2021 00.05, Andy Shevchenko wrote:
>> +#define pr_fmt(fmt) "%s: " fmt, __func__
> 
> This is not needed, really, if you have unique / distinguishable
> messages in the first place.
> Rather people include module names, which may be useful.

Makes sense, I'll switch to KBUILD_MODNAME.

>> +#define MASK_BIT(x)            BIT((x) & 0x1f)
> 
> GENMASK(4,0)

It's not really a register bitmask, but rather extracting the low bits 
of an index... but sure, GENMASK also expresses that. Changed.

>> +static atomic_t aic_vipi_flag[AIC_MAX_CPUS];
>> +static atomic_t aic_vipi_enable[AIC_MAX_CPUS];
> 
> Isn't it easier to handle these when they are full width, i.e. 32
> items per the array?

I don't think so, it doesn't really buy us anything. It's just a maximum 
beyond which the driver doesn't work in its current state anyway (if the 
number were much larger it'd make sense to dynamically allocate these, 
but not at this point).

>> +static int aic_irq_set_affinity(struct irq_data *d,
>> +                               const struct cpumask *mask_val, bool force)
>> +{
>> +       irq_hw_number_t hwirq = irqd_to_hwirq(d);
>> +       struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
>> +       int cpu;
>> +
>> +       if (hwirq > ic->nr_hw)
> 
> >= ?

Good catch, but this is actually obsolete. Higher IRQs go into the FIQ 
irqchip, so this should never happen (it's a leftover from when they 
were a single one). I'll remove it.

Ack on the other comments, thanks!

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
