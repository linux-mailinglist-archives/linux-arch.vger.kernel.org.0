Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFAE32F24B
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 19:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhCESSs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 13:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhCESS2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Mar 2021 13:18:28 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF153C061574;
        Fri,  5 Mar 2021 10:18:27 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 44CF842037;
        Fri,  5 Mar 2021 18:18:18 +0000 (UTC)
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
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
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-13-marcan@marcan.st>
 <CAL_JsqJF2Hz=4U7FR_GOSjCxqt3dpf-CAWFNfsSrDjDLpHqgCA@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [RFT PATCH v3 12/27] of/address: Add infrastructure to declare
 MMIO as non-posted
Message-ID: <6e4880b3-1fb6-0cbf-c1a5-7a46fd9ccf62@marcan.st>
Date:   Sat, 6 Mar 2021 03:18:16 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJF2Hz=4U7FR_GOSjCxqt3dpf-CAWFNfsSrDjDLpHqgCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 06/03/2021 02.39, Rob Herring wrote:
> I'm still a little hesitant to add these properties and having some
> default. I worry about a similar situation as 'dma-coherent' where the
> assumed default on non-coherent on Arm doesn't work for PowerPC which
> defaults coherent. More below on this.

The intent of the default here is that it matches what ioremap() does on 
other platforms already (where it does not make any claims of being 
posted, though it could be on some platforms). It could be per-platform 
what that means... but either way it should be what drivers get today 
without asking for anything special.

>> -       return ioremap(res.start, resource_size(&res));
>> +       if (res.flags & IORESOURCE_MEM_NONPOSTED)
>> +               return ioremap_np(res.start, resource_size(&res));
>> +       else
>> +               return ioremap(res.start, resource_size(&res));
> 
> This and the devm variants all scream for a ioremap_extended()
> function. IOW, it would be better if the ioremap flavor was a
> parameter. Unless we could implement that just for arm64 first, that's
> a lot of refactoring...

I agree, but yeah... that's one big refactor to try to do now...

> What's the code path using these functions on the M1 where we need to
> return 'posted'? It's just downstream PCI mappings (PCI memory space),
> right? Those would never hit these paths because they don't have a DT
> node or if they do the memory space is not part of it. So can't the
> check just be:
> 
> bool of_mmio_is_nonposted(struct device_node *np)
> {
>      return np && of_machine_is_compatible("apple,arm-platform");
> }

Yes; the implementation was trying to be generic, but AIUI we don't need 
this on M1 because the PCI mappings don't go through this codepath, and 
nothing else needs posted mode. My first hack was something not too 
unlike this, then I was going to get rid of apple,arm-platform and just 
have this be a generic mechanism with the properties, but then we added 
the optimization to not do the lookups on other platforms, and now we're 
coming full circle... :-)

If you prefer to handle it this way for now I can do it like this. I 
think we should still have the DT bindings and properties though (even 
if not used), as they do describe the hardware properly, and in the 
future we might want to use them instead of having a quirk.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
