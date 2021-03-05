Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F84932EE5A
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 16:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhCEPUE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 10:20:04 -0500
Received: from marcansoft.com ([212.63.210.85]:58814 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229650AbhCEPTp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Mar 2021 10:19:45 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C160E3FA28;
        Fri,  5 Mar 2021 15:19:36 +0000 (UTC)
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
 <20210304213902.83903-9-marcan@marcan.st>
 <CAHp75Ven4piceFaBhn1kc=vtwM4o-GXmz3eAZoNhU8w+iP5qxQ@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [RFT PATCH v3 08/27] asm-generic/io.h: Add a non-posted variant
 of ioremap()
Message-ID: <03f75e1f-3b3a-95a7-0298-c616dfed54ec@marcan.st>
Date:   Sat, 6 Mar 2021 00:19:34 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Ven4piceFaBhn1kc=vtwM4o-GXmz3eAZoNhU8w+iP5qxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05/03/2021 23.45, Andy Shevchenko wrote:
> On Thu, Mar 4, 2021 at 11:40 PM Hector Martin <marcan@marcan.st> wrote:
>>
>> ARM64 currently defaults to posted MMIO (nGnRnE), but some devices
>> require the use of non-posted MMIO (nGnRE). Introduce a new ioremap()
>> variant to handle this case. ioremap_np() is aliased to ioremap() by
>> default on arches that do not implement this variant.
> 
> Hmm... But isn't it basically a requirement to those device drivers to
> use readX()/writeX() instead of readX_relaxed() / writeX_relaxed()?

No, the write ops used do not matter. It's just that on these Apple SoCs 
the fabric requires the mappings to be nGnRnE, else it just throws 
SErrors on all writes and ignores them.

The difference between _relaxed and not is barrier behavior with regards 
to DMA/memory accesses; this applies regardless of whether the writes 
are E or nE. You can have relaxed accesses with nGnRnE and then you 
would still have race conditions if you do not have a barrier between 
the MMIO and accessing DMA memory. What nGnRnE buys you (on 
platforms/buses where it works properly) is that you do need a dummy 
read after a write to ensure completion.

All of this is to some extent moot on these SoCs; it's not that we need 
the drivers to use nGnRnE for some correctness reason, it's that the 
SoCs force us to use it or else everything breaks, which was the 
motivation for this change. But since on most other SoCs both are valid 
options, this does allow some other drivers/platforms to opt into nGnRnE 
if they have a good reason to do so.

Though you just made me notice two mistakes in the commit description: 
first, it describes the old v2 version, for v3 I made ioremap_np() just 
return NULL on arches that don't implement it. Second, nGnRnE and nGnRE 
are backwards. Oops. I'll fix it for the next version.

>>   #define IORESOURCE_MEM_32BIT           (3<<3)
>>   #define IORESOURCE_MEM_SHADOWABLE      (1<<5)  /* dup: IORESOURCE_SHADOWABLE */
>>   #define IORESOURCE_MEM_EXPANSIONROM    (1<<6)
>> +#define IORESOURCE_MEM_NONPOSTED       (1<<7)
> 
> Not sure it's the right location (in a bit field) for this flag.

Do you have a better suggestion? It seemed logical to put it here, as a 
flag on memory-type I/O resources.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
