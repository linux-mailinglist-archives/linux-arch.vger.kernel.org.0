Return-Path: <linux-arch+bounces-6512-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC28D95B262
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 11:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1EA81C22AAF
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 09:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C286317E004;
	Thu, 22 Aug 2024 09:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh6KNaeU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857E51CF8B;
	Thu, 22 Aug 2024 09:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724320363; cv=none; b=feGPHwNkF/YC9CVGRi/JCrjJhzB+UR0zenCul7612lfw6yVwp4TqJwP9Qc9T6EzHsewZ3Y+BThqIKuhkBsHNH76Ivwqj3Ik/9pPBXSf+UkVrhSzlHu/PSlxMCmorgEPhwK35kIIqGtV2P3lGNUe2oJKQGj4jJUH291HmLGdja98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724320363; c=relaxed/simple;
	bh=c17xwt2hmAnmUIH5Ljz9mvg5PeMzUgVb+UvId+Q5omE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=s4kvtF9RHAkzl7scisDz3fw329/B977jaEpXxDtvbNeisR91gUz602FdojhcaoW1Mdwo3aWvcIj0tPD+NZQJnzm8tI+gqiTUNtlSAWGVrmtGHD1Ah5lpKHScV1F0uFq+hYfe2X/XE11C30hfG4urNewM0KefPmlH2eZKDTfoZoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh6KNaeU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD3FC32782;
	Thu, 22 Aug 2024 09:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724320363;
	bh=c17xwt2hmAnmUIH5Ljz9mvg5PeMzUgVb+UvId+Q5omE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Dh6KNaeUzxmRVg7H844ll/9gV0K5AJ0t5YTRulJK0DHthiuskwp0Xji1RGhzUl9RI
	 Pbl0rvajBzESq3wAweIoplTEB2dDL5l+rMIX58hedNDeXXarVuD0wazrEPaazFGJRZ
	 V2GTTUjHP2iEIQeVhj5+nsr5UQa2XfaUFbIzaBkFO+iGphCcjiGNTAA7WkexFqQiLJ
	 OhsVONI9C6Xn0Zr2juRhiMG5p89NyYLGlvKbrs/yn/4aaZD67RdnKATh+xT60aaY18
	 jtcvohHkhEox+Eoz9RKRz+kqSAKya0TDBVdu/tzDdSsp/1780JAyTGQN0GI9ePVMcH
	 mPf1RkMZxHpeQ==
Message-ID: <399ff156-ffc9-4d50-8e5f-a86dc82da2fa@kernel.org>
Date: Thu, 22 Aug 2024 11:52:27 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] dt-bindings: clock: Add RaspberryPi RP1 clock
 bindings
To: Conor Dooley <conor@kernel.org>,
 Andrea della Porta <andrea.porta@suse.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Saravana Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, Lee Jones <lee@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Stefan Wahren <wahrenst@gmx.net>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <8d7dd7ca5da41f2a96e3ef4e2e3f29fd0d71906a.1724159867.git.andrea.porta@suse.com>
 <20240820-baritone-delegate-5711f7a0bc76@spud> <ZsTfoC3aKLdmFPCL@apocalypse>
 <20240821-exception-nearby-5adeaaf0178b@spud> <ZscGdxgoNJrifSgk@apocalypse>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <ZscGdxgoNJrifSgk@apocalypse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/08/2024 11:35, Andrea della Porta wrote:
> Hi Conor,
> 
> On 12:46 Wed 21 Aug     , Conor Dooley wrote:
>> On Tue, Aug 20, 2024 at 08:25:36PM +0200, Andrea della Porta wrote:
>>> Hi Conor,
>>>
>>> On 17:19 Tue 20 Aug     , Conor Dooley wrote:
>>>> On Tue, Aug 20, 2024 at 04:36:03PM +0200, Andrea della Porta wrote:
>>>>> Add device tree bindings for the clock generator found in RP1 multi
>>>>> function device, and relative entries in MAINTAINERS file.
>>>>>
>>>>> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
>>>>> ---
>>>>>  .../clock/raspberrypi,rp1-clocks.yaml         | 87 +++++++++++++++++++
>>>>>  MAINTAINERS                                   |  6 ++
>>>>>  include/dt-bindings/clock/rp1.h               | 56 ++++++++++++
>>>>>  3 files changed, 149 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
>>>>>  create mode 100644 include/dt-bindings/clock/rp1.h
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml b/Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..b27db86d0572
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
>>>>> @@ -0,0 +1,87 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/clock/raspberrypi,rp1-clocks.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: RaspberryPi RP1 clock generator
>>>>> +
>>>>> +maintainers:
>>>>> +  - Andrea della Porta <andrea.porta@suse.com>
>>>>> +
>>>>> +description: |
>>>>> +  The RP1 contains a clock generator designed as three PLLs (CORE, AUDIO,
>>>>> +  VIDEO), and each PLL output can be programmed though dividers to generate
>>>>> +  the clocks to drive the sub-peripherals embedded inside the chipset.
>>>>> +
>>>>> +  Link to datasheet:
>>>>> +  https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: raspberrypi,rp1-clocks
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  '#clock-cells':
>>>>> +    description:
>>>>> +      The index in the assigned-clocks is mapped to the output clock as per
>>>>> +      definitions in dt-bindings/clock/rp1.h.
>>>>> +    const: 1
>>>>> +
>>>>> +  clocks:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +required:
>>>>> +  - compatible
>>>>> +  - reg
>>>>> +  - '#clock-cells'
>>>>> +  - clocks
>>>>> +
>>>>> +additionalProperties: false
>>>>> +
>>>>> +examples:
>>>>> +  - |
>>>>> +    #include <dt-bindings/clock/rp1.h>
>>>>> +
>>>>> +    rp1 {
>>>>> +        #address-cells = <2>;
>>>>> +        #size-cells = <2>;
>>>>> +
>>>>> +        rp1_clocks: clocks@18000 {
>>>>
>>>> The unit address does not match the reg property. I'm surprised that
>>>> dtc doesn't complain about that.
>>>
>>> Agreed. I'll update the address with the reg value in the next release
>>>
>>>>
>>>>> +            compatible = "raspberrypi,rp1-clocks";
>>>>> +            reg = <0xc0 0x40018000 0x0 0x10038>;
>>>>
>>>> This is a rather oddly specific size. It leads me to wonder if this
>>>> region is inside some sort of syscon area?
>>>
>>> >From downstream source code and RP1 datasheet it seems that the last addressable
>>> register is at 0xc040028014 while the range exposed through teh devicetree ends
>>> up at 0xc040028038, so it seems more of a little safe margin. I wouldn't say it
>>> is a syscon area since those register are quite specific for video clock
>>> generation and not to be intended to be shared among different peripherals.
>>> Anyway, the next register aperture is at 0xc040030000 so I would say we can 
>>> extend the clock mapped register like the following:
>>>
>>> reg = <0xc0 0x40018000 0x0 0x18000>;
>>>
>>> if you think it is more readable.
>>
>> I don't care
> 
> Ack.
> 
>>>>> +            #clock-cells = <1>;
>>>>> +            clocks = <&clk_xosc>;
>>>>> +
>>>>> +            assigned-clocks = <&rp1_clocks RP1_PLL_SYS_CORE>,
>>>
>>>> FWIW, I don't think any of these assigned clocks are helpful for the
>>>> example. That said, why do you need to configure all of these assigned
>>>> clocks via devicetree when this node is the provider of them?
>>>
>>> Not sure to understand what you mean here, the example is there just to
>>> show how to compile the dt node, maybe you're referring to the fact that
>>> the consumer should setup the clock freq?
>>
>> I suppose, yeah. I don't think a particular configuration is relevant
>> for the example binding, but simultaneously don't get why you are
>> assigning the rate for clocks used by audio devices or ethernet in the
>> clock provider node.
>>
> 
> Honestly I don't have a strong preference here, I can manage to do some tests
> moving the clock rate settings inside the consumer nodes but I kinda like
> the curernt idea of a centralized node where clocks are setup beforehand.
> In RP1 the clock generator and peripherals such as ethernet are all on-board
> and cannot be rewired in any other way so the devices are not standalone
> consumer in their own right (such it would be an ethernet chip wired to an
> external CPU). But of course this is debatable, on the other hand the current
> approach of provider/consumer is of course very clean. I'm just wondering
> wthether you think I should take action on this or we can leave it as it is.
> Please see also below.
> 
>>> Consider that the rp1-clocks
>>> is coupled to the peripherals contained in the same RP1 chip so there is
>>> not much point in letting the peripherals set the clock to their leisure.
>>
>> How is that any different to the many other SoCs in the kernel?
> 
> In fact, it isn't. Please take a look at:
>  
> arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi
> arch/arm/boot/dts/ti/omap/omap44xx-clocks.dtsi
> arch/arm/boot/dts/ti/omap/dra7xx-clocks.dtsi
> arch/arm/boot/dts/nxp/imx/imx7d-zii-rpu2.dts
> 
> and probably many others... they use the same approach, so I assumed it is at
> least reasonable to assign the clock rate this way.

Please do not bring some ancient DTS, not really worked on, as example.
stm32 could is moderately recent but dra and omap are not.

Best regards,
Krzysztof


