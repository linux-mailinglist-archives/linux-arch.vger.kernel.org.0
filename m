Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A691933373E
	for <lists+linux-arch@lfdr.de>; Wed, 10 Mar 2021 09:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhCJI1h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Mar 2021 03:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhCJI1F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Mar 2021 03:27:05 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCC2C06174A;
        Wed, 10 Mar 2021 00:27:05 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1091B3FA1B;
        Wed, 10 Mar 2021 08:26:56 +0000 (UTC)
Subject: Re: [RFT PATCH v3 12/27] of/address: Add infrastructure to declare
 MMIO as non-posted
To:     Rob Herring <robh@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Olof Johansson <olof@lixom.net>,
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
        DTML <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-13-marcan@marcan.st>
 <CAL_JsqJF2Hz=4U7FR_GOSjCxqt3dpf-CAWFNfsSrDjDLpHqgCA@mail.gmail.com>
 <6e4880b3-1fb6-0cbf-c1a5-7a46fd9ccf62@marcan.st>
 <CAK8P3a0Hmwt-ywzS-2eEmqyQ0v2SxLsLxFwfTUoWwbzCrBNhsQ@mail.gmail.com>
 <CAL_JsqJHRM59GC3FjvaGLCELemy1uspnGvTEFH6q0OdyBPVSjA@mail.gmail.com>
 <CAK8P3a0_GBB-VYFO5NaySyBJDN2Ra-WMH4WfFrnzgOejmJVG8g@mail.gmail.com>
 <20210308211306.GA2920998@robh.at.kernel.org>
 <CAK8P3a2GfzUevuQNZeQarJ4GNFsuDj0g7oFuN940Hdaw06YJbA@mail.gmail.com>
 <CAL_JsqK8FagJyQVyG5DAocUjLGZT91b6NzDm_DNMW1hdCz51Xg@mail.gmail.com>
 <c5693760-3b18-e8f1-18b6-bae42c05d329@marcan.st>
 <CAL_Jsq+VLLPa98iaTvOkK-tjuBH4qY7FNEGtufYGv7rXAbwegQ@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <332c0b9a-dcfd-4c3b-9038-47cbda90eb3f@marcan.st>
Date:   Wed, 10 Mar 2021 17:26:54 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+VLLPa98iaTvOkK-tjuBH4qY7FNEGtufYGv7rXAbwegQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/03/2021 07.06, Rob Herring wrote:
>> My main concern here is that this creates an inconsistency in the device
>> tree representation that only works because PCI drivers happen not to
>> use these code paths. Logically, having "nonposted-mmio" above the PCI
>> controller would imply that it applies to that bus too. Sure, it doesn't
>> matter for Linux since it is ignored, but this creates an implicit
>> exception that PCI buses always use posted modes.
> 
> We could be stricter that "nonposted-mmio" must be in the immediate
> parent. That's kind of in line with how addressing already works.
> Every level has to have 'ranges' to be an MMIO address, and the
> address cell size is set by the immediate parent.
> 
>> Then if a device comes along that due to some twisted fabric logic needs
>> nonposted nGnRnE mappings for PCIe (even though the actual PCIe ops will
>> end up posted at the bus anyway)... how do we represent that? Declare
>> that another "nonposted-mmio" on the PCIe bus means "no, really, use
>> nonposted mmio for this"?
> 
> If we're strict, yes. The PCI host bridge would have to have "nonposted-mmio".

Works for me; then let's just make it non-recursive.

Do you think we can get rid of the Apple-only optimization if we do 
this? It would mean only looking at the parent during address 
resolution, not recursing all the way to the top, so presumably the 
performance impact would be quite minimal.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
