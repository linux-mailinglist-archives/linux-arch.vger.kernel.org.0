Return-Path: <linux-arch+bounces-6532-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D179B95B8E2
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 16:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94E6AB25ABC
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 14:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7359D1CC167;
	Thu, 22 Aug 2024 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNFLc+oB"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5D21CC165;
	Thu, 22 Aug 2024 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337977; cv=none; b=YoLGr5MXW7GqwsponRQj72s9ZFq+u/TeN/Fadqhd71ysol7KNXLUS1ieEaveU/dd1PP8QNBeter4Qa9GpGClqOajwdhrlqvYB7lwlRlFlcjneVPTqz1QIV5S3zGaGTCiCk5luvufc/2YSUe8syqszXpjdoChyXj4Lw6kFrBBB+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337977; c=relaxed/simple;
	bh=5v3tCV9kMZOqOSCUGiBY/lU7WWrnzRK+cImVi7EnQ2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=liOE4arVZsu6cySv5L6dU5pCZaaxB+Kqbtz9uKSgr7RV/uvnFzPHGaCW71HQtTdCpyra4zamr7m6F+1MH/Ue5jjp4T9nrBRjnK/p4KD2aJuD4Fvclcfp9e8AR9AQpKZBAH3f6QGv6a3IjGhDhkkIHQVcII6UFErMbbWx/63krlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNFLc+oB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037FAC32782;
	Thu, 22 Aug 2024 14:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724337976;
	bh=5v3tCV9kMZOqOSCUGiBY/lU7WWrnzRK+cImVi7EnQ2g=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=MNFLc+oBwZiyAhoYsiKONffoxs2QdCPy30fTTuweAnZ8dprMTHoUoBmLrBBidba2R
	 wooagB8un4vGmgm3KJHOW3WlTydxZ/U/k2tjiQOTBl3wiuDmF8Cw9yH0tF+2PjUESw
	 L2xnDiQjpXFlcZ9nRc2n0vyXxdbTAg5a9U63LkEkun85eZz2P933i7QvOjlr9yuY9g
	 rdGG+I2gIDze3tAY2/Gsztj82ylykPrRTRWzsLsBDLbWKAaFWV0OcBU9oGD0Df69t2
	 7Rt197l5qz85/AfgNh53SPg+mu/EgnL+3u7mMCiUpRq+5oTa003Vk600tUHL1pEk21
	 E0Bo8KEtzQgAg==
Message-ID: <98ec373b-7c7d-4775-b166-9be1e1b3eda1@kernel.org>
Date: Thu, 22 Aug 2024 16:46:07 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] misc: rp1: RaspberryPi RP1 misc driver
To: Andrea della Porta <andrea.porta@suse.com>,
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
 <5954e4dccc0e158cf434d2c281ad57120538409b.1724159867.git.andrea.porta@suse.com>
 <lrv7cpbt2n7eidog5ydhrbyo5se5l2j23n7ljxvojclnhykqs2@nfeu4wpi2d76>
 <400486cd-e23c-4501-98c0-aa999aa45f75@kernel.org>
 <ZsdMLgf2U-CRpnH4@apocalypse>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <ZsdMLgf2U-CRpnH4@apocalypse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/08/2024 16:33, Andrea della Porta wrote:
> Hi Krzysztof,
> 
> On 16:20 Wed 21 Aug     , Krzysztof Kozlowski wrote:
>> On 21/08/2024 10:38, Krzysztof Kozlowski wrote:
>>> On Tue, Aug 20, 2024 at 04:36:10PM +0200, Andrea della Porta wrote:
>>
>> ...
>>
>>>>  drivers/misc/Kconfig                  |   1 +
>>>>  drivers/misc/Makefile                 |   1 +
>>>>  drivers/misc/rp1/Kconfig              |  20 ++
>>>>  drivers/misc/rp1/Makefile             |   3 +
>>>>  drivers/misc/rp1/rp1-pci.c            | 333 ++++++++++++++++++++++++++
>>>>  drivers/misc/rp1/rp1-pci.dtso         |   8 +
>>>>  drivers/pci/quirks.c                  |   1 +
>>>>  include/linux/pci_ids.h               |   3 +
>>>>  10 files changed, 524 insertions(+)
>>>>  create mode 100644 arch/arm64/boot/dts/broadcom/rp1.dtso
>>>>  create mode 100644 drivers/misc/rp1/Kconfig
>>>>  create mode 100644 drivers/misc/rp1/Makefile
>>>>  create mode 100644 drivers/misc/rp1/rp1-pci.c
>>>>  create mode 100644 drivers/misc/rp1/rp1-pci.dtso
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 67f460c36ea1..1359538b76e8 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -19119,9 +19119,11 @@ F:	include/uapi/linux/media/raspberrypi/
>>>>  RASPBERRY PI RP1 PCI DRIVER
>>>>  M:	Andrea della Porta <andrea.porta@suse.com>
>>>>  S:	Maintained
>>>> +F:	arch/arm64/boot/dts/broadcom/rp1.dtso
>>>>  F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
>>>>  F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
>>>>  F:	drivers/clk/clk-rp1.c
>>>> +F:	drivers/misc/rp1/
>>>>  F:	drivers/pinctrl/pinctrl-rp1.c
>>>>  F:	include/dt-bindings/clock/rp1.h
>>>>  F:	include/dt-bindings/misc/rp1.h
>>>> diff --git a/arch/arm64/boot/dts/broadcom/rp1.dtso b/arch/arm64/boot/dts/broadcom/rp1.dtso
>>>> new file mode 100644
>>>> index 000000000000..d80178a278ee
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/broadcom/rp1.dtso
>>>> @@ -0,0 +1,152 @@
>>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>>> +
>>>> +#include <dt-bindings/gpio/gpio.h>
>>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>>> +#include <dt-bindings/clock/rp1.h>
>>>> +#include <dt-bindings/misc/rp1.h>
>>>> +
>>>> +/dts-v1/;
>>>> +/plugin/;
>>>> +
>>>> +/ {
>>>> +	fragment@0 {
>>>> +		target-path="";
>>>> +		__overlay__ {
>>>> +			#address-cells = <3>;
>>>> +			#size-cells = <2>;
>>>> +
>>>> +			rp1: rp1@0 {
>>>> +				compatible = "simple-bus";
>>>> +				#address-cells = <2>;
>>>> +				#size-cells = <2>;
>>>> +				interrupt-controller;
>>>> +				interrupt-parent = <&rp1>;
>>>> +				#interrupt-cells = <2>;
>>>> +
>>>> +				// ranges and dma-ranges must be provided by the includer
>>>> +				ranges = <0xc0 0x40000000
>>>> +					  0x01/*0x02000000*/ 0x00 0x00000000
>>>> +					  0x00 0x00400000>;
>>>
>>> Are you 100% sure you do not have here dtc W=1 warnings?
>>
>> One more thing, I do not see this overlay applied to any target, which
>> means it cannot be tested. You miss entry in Makefile.
>>
> 
> The dtso is intended to be built from driver/misc/rp1/Makefile as it will
> be included in the driver obj:
> 
> --- /dev/null
> +++ b/drivers/misc/rp1/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +rp1-pci-objs                   := rp1-pci.o rp1-pci.dtbo.o
> +obj-$(CONFIG_MISC_RP1)         += rp1-pci.o
> 
> and not as part of the dtb system, hence it's m issing in
> arch/arm64/boot/dts/broadcom/Makefile.
> 
> On the other hand:
> 
> #> make W=1 CHECK_DTBS=y broadcom/rp1.dtbo
>   DTC     arch/arm64/boot/dts/broadcom/rp1.dtbo
> arch/arm64/boot/dts/broadcom/rp1.dtso:37.24-42.7: Warning (simple_bus_reg): /fragment@0/__overlay__/rp1@0/clk_xosc: missing or empty reg/ranges property
> arch/arm64/boot/dts/broadcom/rp1.dtso:44.26-49.7: Warning (simple_bus_reg): /fragment@0/__overlay__/rp1@0/macb_pclk: missing or empty reg/ranges property
> arch/arm64/boot/dts/broadcom/rp1.dtso:51.26-56.7: Warning (simple_bus_reg): /fragment@0/__overlay__/rp1@0/macb_hclk: missing or empty reg/ranges property
> arch/arm64/boot/dts/broadcom/rp1.dtso:14.15-173.5: Warning (avoid_unnecessary_addr_size): /fragment@0/__overlay__: unnecessary #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" property
> 
> seems to do the checks, unless I'm missing something.

Yeah, there is still no target which applies the overlay, so no one can
tell whether it applies cleanly or not. You can only test single
overlay, but it is expected to test each overlay being applied to chosen
DTB.

Best regards,
Krzysztof


