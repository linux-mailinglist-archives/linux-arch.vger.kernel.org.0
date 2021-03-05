Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9158D32EF70
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 16:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhCEP4H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 10:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhCEPzu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Mar 2021 10:55:50 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899A5C061574;
        Fri,  5 Mar 2021 07:55:49 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1F24142037;
        Fri,  5 Mar 2021 15:55:40 +0000 (UTC)
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
 <20210304213902.83903-13-marcan@marcan.st>
 <CAHp75VdGYDDCRBRmd3O3Mt1opgDdwuRBoS1E=vaVc45h9eR-0w@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [RFT PATCH v3 12/27] of/address: Add infrastructure to declare
 MMIO as non-posted
Message-ID: <04ea35d6-cd7d-d6de-75ae-59b1e0c77f04@marcan.st>
Date:   Sat, 6 Mar 2021 00:55:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdGYDDCRBRmd3O3Mt1opgDdwuRBoS1E=vaVc45h9eR-0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 06/03/2021 00.13, Andy Shevchenko wrote:
>> @@ -896,7 +899,10 @@ void __iomem *of_iomap(struct device_node *np, int index)
>>          if (of_address_to_resource(np, index, &res))
>>                  return NULL;
>>
>> -       return ioremap(res.start, resource_size(&res));
>> +       if (res.flags & IORESOURCE_MEM_NONPOSTED)
>> +               return ioremap_np(res.start, resource_size(&res));
>> +       else
>> +               return ioremap(res.start, resource_size(&res));
> 
> This doesn't sound right. Why _np is so exceptional? Why don't we have
> other flavours (it also rings a bell to my previous comment that the
> flag in ioresource is not in the right place)?

This is different from other variants, because until now *drivers* have 
made the choice of what ioremap mode to use based on device requirements 
(which means ioremap() 99% of the time, and then framebuffers and other 
memory-ish things such use something else). Now we have a *SoC fabric* 
that is calling the shots on what ioremap mode we have to use - and 
*every* non-PCIe driver needs to use ioremap_np() on these SoCs, or they 
break. So it seems a lot cleaner to make the choice for drivers here to 
upgrade ioremap() to ioremap_np() for SoCs that need it.

If we don't do something like this here or in otherwise common code, 
we'd have to have an open-coded "if apple then ioremap_np, else ioremap" 
in every driver that runs on-die devices on these SoCs, even ones that 
are otherwise standard and need few or no Apple-specific quirks.

We're still going to have to patch some drivers to use managed APIs that 
can properly hit this conditional (like I did for samsung_tty) in cases 
where they currently don't, but that's a lot cleaner than an open-coded 
conditional, I think (and often comes with other benefits anyway).

Note that wholesale making ioremap() behave like ioremap_np() at the 
arch level as as SoC quirk is not an option - for extenal PCIe devices, 
we still need to use ioremap(). We tried this approach initially but it 
doesn't work. Hence we arrived at this solution which describes the 
required mode in the devicetree, at the bus level (which makes sense, 
since that represents the fabric), and then these wrappers can use that 
information, carried over via the bit in struct device, to pick the 
right ioremap mode.

It doesn't really make sense to include the other variants here, because 
_np is strictly stronger than the default. Downgrading ioremap to any 
other variant would break most drivers, badly. However, upgrading to 
ioremap_np() is always correct (if possibly slower), on platforms where 
it is allowed by the bus. In fact, I bet that on many systems nGnRE 
already behaves like nGnRnE anyway. I don't know why Apple didn't just 
allow nGnRE mappings to work (behaving like nGnRnE) instead of making 
them explode, which is the whole reason we have to do this.

>> +       while (node) {
>> +               if (!of_property_read_bool(node, "ranges")) {
>> +                       break;
>> +               } else if (of_property_read_bool(node, "nonposted-mmio")) {
>> +                       of_node_put(node);
>> +                       return true;
>> +               } else if (of_property_read_bool(node, "posted-mmio")) {
>> +                       break;
>> +               }
>> +               parent = of_get_parent(node);
>> +               of_node_put(node);
>> +               node = parent;
>> +       }
> 
> I believe above can be slightly optimized. Don't we have helpers to
> traverse to all parents?

Keep in mind the logic here is that it stops on the first instance of 
either property, and does not traverse non-translatable boundaries. Are 
there helpers that can implement this kind of complex logic? It's not a 
simple recursive property lookup.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
