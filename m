Return-Path: <linux-arch+bounces-7090-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A90A696E4F3
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 23:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C191F21DCC
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 21:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0391A1A76AF;
	Thu,  5 Sep 2024 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xonpj9Hz"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BE31A4E6F;
	Thu,  5 Sep 2024 21:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725571269; cv=none; b=avCcOIFybHUR6WDFLAcGxbjbi3AzreqUMckBGPHoka/GLH/N8zN/gxemTrWo0E3RyE4O2nWzZ9gmroI5n4b2GN2f4jyGKWHziHBYGWiL9eOfKy7t5wKtejLkMCQhOTQERbHL4t09ZXe/5Rnp4Np0xSqIqA8LySEcppo1auUEPaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725571269; c=relaxed/simple;
	bh=pu745UfD6nFeM4JKfJBuPPz6wiYc0c0r/+Z5uAO5/C4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eVuhV9E3MUZWmZlCZ8BvZ2k8Un401S7s/wfoQaCPmfLX74Y5Jey6N8wTR8lw1mgVNEfwJpzYGLZNgXCaWoqFF9vFsjZf5dEc57b5C8C3kcXQSC5ct8co4MYGogLHov11xko6ORUAti2ORdIGtauslX5O040TCa4khLxbAJjOvT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xonpj9Hz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09384C4CEC3;
	Thu,  5 Sep 2024 21:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725571269;
	bh=pu745UfD6nFeM4JKfJBuPPz6wiYc0c0r/+Z5uAO5/C4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xonpj9Hz1TwRC0/VLPThd2398ncy6DzNG9LWiNdpJJVfcYZLj5M48GBD7vLE12gCI
	 gEexAMyQm2sjRBxDETT83rcY+1iLGIakuC9pECOBsDw3OARuJSjnRUGjE46irwDvYn
	 4jrWOjHPFCxqr3Xl1o3f+n2cPnntzKvIl23qXb/3xpRjcZmcHfYE5JzQnuIVtn9+1o
	 Ei+SGQ6XItUEctLgbQKtcozAh5eSwRlItRWOdjWRF/S/VIze/hT6/VrjUdF95uw129
	 bFiI9BxHu9rHTcfi5/9Uu7eiTupTHNiBi/kr6SAW85Z3xZqJis/OZMxD5spJJLX3zS
	 F/wevBVGGCHUw==
Message-ID: <50546635-1870-499d-8cdc-eb4e9fa1a510@kernel.org>
Date: Thu, 5 Sep 2024 23:20:55 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] misc: rp1: RaspberryPi RP1 misc driver
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
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
 <5954e4dccc0e158cf434d2c281ad57120538409b.1724159867.git.andrea.porta@suse.com>
 <lrv7cpbt2n7eidog5ydhrbyo5se5l2j23n7ljxvojclnhykqs2@nfeu4wpi2d76>
 <ZtHN0B8VEGZFXs95@apocalypse>
 <b74327b8-43f6-47cf-ba9d-cc9a4559767b@kernel.org>
 <ZtcoFmK6NPLcIwVt@apocalypse>
 <39735704-ae94-4ff8-bf4d-d2638b046c8e@kernel.org>
 <ZtndaYh2Faf6t3fC@apocalypse>
 <f39edf3d-aa9e-43a0-8997-762d76c9c248@kernel.org>
 <Ztn-XOvtk_d3U6XJ@apocalypse>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <Ztn-XOvtk_d3U6XJ@apocalypse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/09/2024 20:54, Andrea della Porta wrote:
> Hi Krzysztof,
> 
> On 18:52 Thu 05 Sep     , Krzysztof Kozlowski wrote:
>> On 05/09/2024 18:33, Andrea della Porta wrote:
>>> Hi Krzysztof,
>>>
>>> On 20:27 Tue 03 Sep     , Krzysztof Kozlowski wrote:
>>>> On 03/09/2024 17:15, Andrea della Porta wrote:
>>>>>>>>> +
>>>>>>>>> +				rp1_clocks: clocks@c040018000 {
>>>>>>>>
>>>>>>>> Why do you mix MMIO with non-MMIO nodes? This really does not look
>>>>>>>> correct.
>>>>>>>>
>>>>>>>
>>>>>>> Right. This is already under discussion here:
>>>>>>> https://lore.kernel.org/all/ZtBzis5CzQMm8loh@apocalypse/
>>>>>>>
>>>>>>> IIUC you proposed to instantiate the non-MMIO nodes (the three clocks) by
>>>>>>> using CLK_OF_DECLARE.
>>>>>>
>>>>>> Depends. Where are these clocks? Naming suggests they might not be even
>>>>>> part of this device. But if these are part of the device, then why this
>>>>>> is not a clock controller (if they are controllable) or even removed
>>>>>> (because we do not represent internal clock tree in DTS).
>>>>>
>>>>> xosc is a crystal connected to the oscillator input of the RP1, so I would
>>>>> consider it an external fixed-clock. If we were in the entire dts, I would have
>>>>> put it in root under /clocks node, but here we're in the dtbo so I'm not sure
>>>>> where else should I put it.
>>>>
>>>> But physically, on which PCB, where is this clock located?
>>>
>>> xosc is a crystal, feeding the reference clock oscillator input pins of the RP1,
>>> please see page 12 of the following document:
>>> https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf
>>
>> That's not the answer. Where is it physically located?
> 
> Please see below.
> 
>>
>>> On Rpi5, the PCB is the very same as the one on which the BCM2712 (SoC) and RP1
>>> are soldered. Would you consider it external (since the crystal is outside the RP1)
>>> or internal (since the oscillator feeded by the crystal is inside the RP1)?
>>
>> So it is on RPi 5 board? Just like every other SoC and every other
>> vendor? Then just like every other SoC and every other vendor it is in
>> board DTS file.
> 
> Yes it's on the Rpi5 board. These are two separate thing, though: one is where

Finally.

> to put it (DTS, DTSO) and another is in what target path relative to root. I
> was trying to understand the latter.

It is already or should be part of DTS, not DTSO. You are duplicating
device nodes.

> The clock node should be put in the DTBO since we are loading this driver at
> runtime and we probably don't want to depend on some specific node name to be
> present in the DTS. This is also true because this driver should possibly work
> also on ACPI system and on hypothetical PCI card on which the RP1 could be mounted

Not really. ACPI and thus DT in such case will take it as clock input.
Basically what you need here is to provide clock inputs to this device.
It's then firmware independent.

> in the future, and in that case a DTS could be not even there. 

No problem. Whatever firmware mechanism you have, it will provide you clock.

> After all, those clocks must be in the immediate proximity to the RP1, and on the
> same board, which may or may not be the main board as the Rpi5 case.
> I think that, since this application is a little bit peculiar, maybe some
> compromises could be legit.

Application is not peculiar but completely standard. You have standard
PCI device which has some inputs. One of these inputs, maybe on some
reserved M.2 pins or whatver connector you have there, is the clock.

...

>>>
>>> If externals, I would place them in the same position as xosc, so root node
>>> or some other node under root (eg.: /rp1-clocks)
>>
>> Just like /clocks, /rp1-clocks is not better. Neither /rp1-foo-clocks.
> 
> Right. So in this case, since xosc seems to be on the same level and on the same
> board of the RP1 and the SoC, and it's also external to the RP1, can I assume that
> placing xosc node in root is ok?

root node of the DTS yes. Root node of DTSO of course not, because it is
not part of DTSO and you are duplicating DTS. It would not even work.

That's why you need to apply the overlay to proper target as I asked
long time ago.

> 
>>
>> I think there is some sort of big misunderstanding here. Is this RP1
>> co-processor on the RP board, connected over PCI to Broadcom SoC?
> 
> Yes. 
> 
>  ---------------Rpi5 board---------------------
>  |                                            |
>  |    SoC ==pci bus==> RP1 <== xosc crystal   |
>  |                                            |
>  ----------------------------------------------
> 
>>
>>>
>>> If internals, I would leave them just where they are, i.e. inside the rp1 node
>>>
>>> Does it make sense?
>>
>> No, because you do not have xosc there, according to my knowledge.
> 
> Hmmm sorry, not sure what this negation was referring to... I was talking about
> hclk and pclk, not xosc here. Could you please add some details?

If considering hclk and pclk, then depends where are they. If they come
as inputs, then same as xosc. If they are not, then it is also obvious -
we do not represent internal device clocks as fixed clocks in DTS,
because it makes absolutely no sense at all. No benefits, no help,
nothing at all.

It's just device's internal clock.

This is again nothing peculiar. Many other devices have some internal
stuff. Do we add fixed clocks for these? Fixed regulators? No, of course
not.

Best regards,
Krzysztof


