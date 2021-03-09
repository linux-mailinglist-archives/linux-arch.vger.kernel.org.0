Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBE9332FD5
	for <lists+linux-arch@lfdr.de>; Tue,  9 Mar 2021 21:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhCIUYW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Mar 2021 15:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhCIUX7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Mar 2021 15:23:59 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4F5C06175F;
        Tue,  9 Mar 2021 12:23:59 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id E5D233FA6A;
        Tue,  9 Mar 2021 20:23:49 +0000 (UTC)
To:     Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
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
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [RFT PATCH v3 12/27] of/address: Add infrastructure to declare
 MMIO as non-posted
Message-ID: <c5693760-3b18-e8f1-18b6-bae42c05d329@marcan.st>
Date:   Wed, 10 Mar 2021 05:23:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqK8FagJyQVyG5DAocUjLGZT91b6NzDm_DNMW1hdCz51Xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/03/2021 00.48, Rob Herring wrote:
> On Mon, Mar 8, 2021 at 2:56 PM Arnd Bergmann <arnd@kernel.org> wrote:
>>
>> On Mon, Mar 8, 2021 at 10:14 PM Rob Herring <robh@kernel.org> wrote:
>>> On Mon, Mar 08, 2021 at 09:29:54PM +0100, Arnd Bergmann wrote:
>>>> On Mon, Mar 8, 2021 at 4:56 PM Rob Herring <robh@kernel.org> wrote:
>>>
>>> Let's just stick with 'nonposted-mmio', but drop 'posted-mmio'. I'd
>>> rather know if and when we need 'posted-mmio'. It does need to be added
>>> to the DT spec[1] and schema[2] though (GH PRs are fine for both).
>>
>> I think the reason for having "posted-mmio" is that you cannot properly
>> define the PCI host controller nodes on the M1 without that: Since
>> nonposted-mmio applies to all child nodes, this would mean the PCI
>> memory space gets declared as nonposted by the DT, but the hardware
>> requires it to be mapped as posted.
> 
> I don't think so. PCI devices wouldn't use any of the code paths in
> this patch. They would map their memory space with plain ioremap()
> which is posted.

My main concern here is that this creates an inconsistency in the device 
tree representation that only works because PCI drivers happen not to 
use these code paths. Logically, having "nonposted-mmio" above the PCI 
controller would imply that it applies to that bus too. Sure, it doesn't 
matter for Linux since it is ignored, but this creates an implicit 
exception that PCI buses always use posted modes.

Then if a device comes along that due to some twisted fabric logic needs 
nonposted nGnRnE mappings for PCIe (even though the actual PCIe ops will 
end up posted at the bus anyway)... how do we represent that? Declare 
that another "nonposted-mmio" on the PCIe bus means "no, really, use 
nonposted mmio for this"?

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
