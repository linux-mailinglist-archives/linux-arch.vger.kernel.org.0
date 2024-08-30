Return-Path: <linux-arch+bounces-6859-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB380966767
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 18:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A947B2215D
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 16:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DF31B6544;
	Fri, 30 Aug 2024 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYqfNfmY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F9C192D98;
	Fri, 30 Aug 2024 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036765; cv=none; b=Hsfh408Qw9TahPMkOCwkl3Y3ShX7qNV9fvmNX/L4fKgcTZSjRnFqHMd3V6VY0UMRUoXN66Zflg4Lwi1TlLW22jISdx9Pny7QSmVez32rKvcn9hgaPLWhaVmcu/N70dqGoA+aMo+raV01Ry6oLF2QzBLrp7qhYNe1XA63maWgPcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036765; c=relaxed/simple;
	bh=SMcLNIaJ54MQsZ3nxl5vqmMyfb44UrOy7mGgTTHqYZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cI6DOddpaQBW5ORptdAtPgUp9qcUg9Fjx8G4UxwBqSaxyLvbUYlE1QrpmQhbsk2holWZNV/8WAUOYf6fLfji4tv69R7QU+QX6rIcCoPI16gx1AiklluK0xPmAa1dM3deZNFit9fA/wVPD+mmgw8EjCc6bI4MWUAtgJH0fkglZjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYqfNfmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37851C4CEC2;
	Fri, 30 Aug 2024 16:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725036765;
	bh=SMcLNIaJ54MQsZ3nxl5vqmMyfb44UrOy7mGgTTHqYZo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AYqfNfmYiFPTbXVEG+bz3A0nts8/zcC0XWPxEIPNnauvCUj/p/wFOq4wpkq7Paeik
	 ZVMxhimIvmX8KfmZ1DJIA/Fk93uwd+sRic29TktVLjwj9Fi4eCLgaVQBuh7dLmbeSb
	 a8xUPVaKeYuLJLM02AhRR7E9QtxaTHIAdcAI6NxPhL0Mohfpyd6SRQBcM4AFfpd6eC
	 r9Qbqf5g+0+/AIMoyKhJ809/uOryvKOzQaPzwP+L0LEn0goFcSvXQ4i241s46e2uCq
	 jUXK3stvvzvVQ3LIacmriav8imr2uHfvQ/OO/NLR7b6EzCNXgLJOOXHxFhqKZK5W+U
	 lCbJze5YFS6ZA==
Message-ID: <b74327b8-43f6-47cf-ba9d-cc9a4559767b@kernel.org>
Date: Fri, 30 Aug 2024 18:52:32 +0200
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <ZtHN0B8VEGZFXs95@apocalypse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/08/2024 15:49, Andrea della Porta wrote:
> Hi Krzysztof,
> 
> On 10:38 Wed 21 Aug     , Krzysztof Kozlowski wrote:
>> On Tue, Aug 20, 2024 at 04:36:10PM +0200, Andrea della Porta wrote:
>>> The RaspberryPi RP1 is ia PCI multi function device containing
>>> peripherals ranging from Ethernet to USB controller, I2C, SPI
>>> and others.
>>> Implement a bare minimum driver to operate the RP1, leveraging
>>> actual OF based driver implementations for the on-borad peripherals
>>> by loading a devicetree overlay during driver probe.
>>> The peripherals are accessed by mapping MMIO registers starting
>>> from PCI BAR1 region.
>>> As a minimum driver, the peripherals will not be added to the
>>> dtbo here, but in following patches.
>>>
>>> Link: https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf
>>> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
>>> ---
>>>  MAINTAINERS                           |   2 +
>>>  arch/arm64/boot/dts/broadcom/rp1.dtso | 152 ++++++++++++
>>
>> Do not mix DTS with drivers.
>>
>> These MUST be separate.
> 
> Separating the dtso from the driver in two different patches would mean
> that the dtso patch would be ordered before the driver one. This is because
> the driver embeds the dtbo binary blob inside itself, at build time. So
> in order to build the driver, the dtso needs to be there also. This is not

Sure, in such case DTS will have to go through the same tree as driver
as an exception. Please document it in patch changelog (---).

> the standard approach used with 'normal' dtb/dtbo, where the dtb patch is
> ordered last wrt the driver it refers to.

It's not exactly the "ordered last" that matters, but lack of dependency
and going through separate tree and branch - arm-soc/dts. Here there
will be an exception how we handle patch, but still DTS is hardware
description so should not be combined with driver code.

> Are you sure you want to proceed in this way?


> 
>>
>>>  drivers/misc/Kconfig                  |   1 +
>>>  drivers/misc/Makefile                 |   1 +
>>>  drivers/misc/rp1/Kconfig              |  20 ++
>>>  drivers/misc/rp1/Makefile             |   3 +
>>>  drivers/misc/rp1/rp1-pci.c            | 333 ++++++++++++++++++++++++++
>>>  drivers/misc/rp1/rp1-pci.dtso         |   8 +
>>>  drivers/pci/quirks.c                  |   1 +
>>>  include/linux/pci_ids.h               |   3 +
>>>  10 files changed, 524 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/broadcom/rp1.dtso
>>>  create mode 100644 drivers/misc/rp1/Kconfig
>>>  create mode 100644 drivers/misc/rp1/Makefile
>>>  create mode 100644 drivers/misc/rp1/rp1-pci.c
>>>  create mode 100644 drivers/misc/rp1/rp1-pci.dtso
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 67f460c36ea1..1359538b76e8 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -19119,9 +19119,11 @@ F:	include/uapi/linux/media/raspberrypi/
>>>  RASPBERRY PI RP1 PCI DRIVER
>>>  M:	Andrea della Porta <andrea.porta@suse.com>
>>>  S:	Maintained
>>> +F:	arch/arm64/boot/dts/broadcom/rp1.dtso
>>>  F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
>>>  F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
>>>  F:	drivers/clk/clk-rp1.c
>>> +F:	drivers/misc/rp1/
>>>  F:	drivers/pinctrl/pinctrl-rp1.c
>>>  F:	include/dt-bindings/clock/rp1.h
>>>  F:	include/dt-bindings/misc/rp1.h
>>> diff --git a/arch/arm64/boot/dts/broadcom/rp1.dtso b/arch/arm64/boot/dts/broadcom/rp1.dtso
>>> new file mode 100644
>>> index 000000000000..d80178a278ee
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/broadcom/rp1.dtso
>>> @@ -0,0 +1,152 @@
>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>> +
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>> +#include <dt-bindings/clock/rp1.h>
>>> +#include <dt-bindings/misc/rp1.h>
>>> +
>>> +/dts-v1/;
>>> +/plugin/;
>>> +
>>> +/ {
>>> +	fragment@0 {
>>> +		target-path="";
>>> +		__overlay__ {
>>> +			#address-cells = <3>;
>>> +			#size-cells = <2>;
>>> +
>>> +			rp1: rp1@0 {
>>> +				compatible = "simple-bus";
>>> +				#address-cells = <2>;
>>> +				#size-cells = <2>;
>>> +				interrupt-controller;
>>> +				interrupt-parent = <&rp1>;
>>> +				#interrupt-cells = <2>;
>>> +
>>> +				// ranges and dma-ranges must be provided by the includer
>>> +				ranges = <0xc0 0x40000000
>>> +					  0x01/*0x02000000*/ 0x00 0x00000000
>>> +					  0x00 0x00400000>;
>>
>> Are you 100% sure you do not have here dtc W=1 warnings?
> 
> the W=1 warnings are:
> 
> arch/arm64/boot/dts/broadcom/rp1.dtso:37.24-42.7: Warning (simple_bus_reg): /fragment@0/__overlay__/rp1@0/clk_xosc: missing or empty reg/ranges property
> arch/arm64/boot/dts/broadcom/rp1.dtso:44.26-49.7: Warning (simple_bus_reg): /fragment@0/__overlay__/rp1@0/macb_pclk: missing or empty reg/ranges property
> arch/arm64/boot/dts/broadcom/rp1.dtso:51.26-56.7: Warning (simple_bus_reg): /fragment@0/__overlay__/rp1@0/macb_hclk: missing or empty reg/ranges property
> arch/arm64/boot/dts/broadcom/rp1.dtso:14.15-173.5: Warning (avoid_unnecessary_addr_size): /fragment@0/__overlay__: unnecessary #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" property
> 
> I don't see anything related to the ranges line you mentioned.

Hm, indeed, but I would expect warning about unit address not matching
ranges/reg.

> 
>>
>>> +
>>> +				dma-ranges =
>>> +				// inbound RP1 1x_xxxxxxxx -> PCIe 1x_xxxxxxxx
>>> +					     <0x10 0x00000000
>>> +					      0x43000000 0x10 0x00000000
>>> +					      0x10 0x00000000>;
>>> +
>>> +				clk_xosc: clk_xosc {
>>
>> Nope, switch to DTS coding style.
> 
> Ack.
> 
>>
>>> +					compatible = "fixed-clock";
>>> +					#clock-cells = <0>;
>>> +					clock-output-names = "xosc";
>>> +					clock-frequency = <50000000>;
>>> +				};
>>> +
>>> +				macb_pclk: macb_pclk {
>>> +					compatible = "fixed-clock";
>>> +					#clock-cells = <0>;
>>> +					clock-output-names = "pclk";
>>> +					clock-frequency = <200000000>;
>>> +				};
>>> +
>>> +				macb_hclk: macb_hclk {
>>> +					compatible = "fixed-clock";
>>> +					#clock-cells = <0>;
>>> +					clock-output-names = "hclk";
>>> +					clock-frequency = <200000000>;
>>> +				};
>>> +
>>> +				rp1_clocks: clocks@c040018000 {
>>
>> Why do you mix MMIO with non-MMIO nodes? This really does not look
>> correct.
>>
> 
> Right. This is already under discussion here:
> https://lore.kernel.org/all/ZtBzis5CzQMm8loh@apocalypse/
> 
> IIUC you proposed to instantiate the non-MMIO nodes (the three clocks) by
> using CLK_OF_DECLARE.

Depends. Where are these clocks? Naming suggests they might not be even
part of this device. But if these are part of the device, then why this
is not a clock controller (if they are controllable) or even removed
(because we do not represent internal clock tree in DTS).

Best regards,
Krzysztof


