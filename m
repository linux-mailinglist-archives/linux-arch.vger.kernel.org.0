Return-Path: <linux-arch+bounces-6416-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0B6959F9A
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 16:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5405A1C21B7F
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 14:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8221B250D;
	Wed, 21 Aug 2024 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prMfycAE"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCF21B1D74;
	Wed, 21 Aug 2024 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250037; cv=none; b=MQVOyQyrXLUhu2axnPfqyK2aC7OT3XkCRU05wgP55H1PqOtma78/0fpvojw0V2ckNI/+RPbq08yHk2oLn8ftgkRaQhWPUZdl/8JNGEVBuLbMbpvsZO1td3ufHORsZVQIwMMJEI7qDF9XEj+/Utg+LgTK5zyQgQcO/U1jVmPEBZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250037; c=relaxed/simple;
	bh=z8k7swx1sZ/TSYEtz4/ugUGeVq6w/e+UPk/Tst1C1Tk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DbYLfuNG4p2rpj07Okih5vilXwpYDFVBJRtMndakL6pyEtqsf1aLP2VwEZuEhmR0NyF3NrKPPSNMA652hytfl0jPurQZLYGCvrTAvfTx/YuMcVv8orYrsLJKSfevJzmNRTNWm9yvqmpTjr92IJjwaE8jNXHdYrSj5Xb2ki/X3dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prMfycAE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19203C32781;
	Wed, 21 Aug 2024 14:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724250037;
	bh=z8k7swx1sZ/TSYEtz4/ugUGeVq6w/e+UPk/Tst1C1Tk=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=prMfycAEZkBaodFZQaIdGBd3Oe0umJ1nmxxczXEL7cG6R4UQcbOa3l0y0BJo6ySwC
	 1mzVIdPTCW7KgMW7fG5ByLsl4ltSXxgAdrHO0RdVyMa+ziiG103OFKyvpK5l0K8S1v
	 Q5ocnvxu3r+154PZCffp/SDsTl2+pX3ImyBii3vhgNjU8OCO+XR/VuKaDmRLFbhoys
	 SvZ5thyX8Nb97eXmD+E/Nq8tth5II3S9fN0ULIr4cnabZ1oxic0b63r2uROJQoyphz
	 8vhkNZc/6zVA8AnGCLLzro/mcGTUDJjQWxteUNYLakIj4YFH3X0jINVHeSgSBMSu7X
	 ZIdpKVmu2RvqA==
Message-ID: <400486cd-e23c-4501-98c0-aa999aa45f75@kernel.org>
Date: Wed, 21 Aug 2024 16:20:23 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] misc: rp1: RaspberryPi RP1 misc driver
From: Krzysztof Kozlowski <krzk@kernel.org>
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
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <lrv7cpbt2n7eidog5ydhrbyo5se5l2j23n7ljxvojclnhykqs2@nfeu4wpi2d76>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/08/2024 10:38, Krzysztof Kozlowski wrote:
> On Tue, Aug 20, 2024 at 04:36:10PM +0200, Andrea della Porta wrote:

...

>>  drivers/misc/Kconfig                  |   1 +
>>  drivers/misc/Makefile                 |   1 +
>>  drivers/misc/rp1/Kconfig              |  20 ++
>>  drivers/misc/rp1/Makefile             |   3 +
>>  drivers/misc/rp1/rp1-pci.c            | 333 ++++++++++++++++++++++++++
>>  drivers/misc/rp1/rp1-pci.dtso         |   8 +
>>  drivers/pci/quirks.c                  |   1 +
>>  include/linux/pci_ids.h               |   3 +
>>  10 files changed, 524 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/broadcom/rp1.dtso
>>  create mode 100644 drivers/misc/rp1/Kconfig
>>  create mode 100644 drivers/misc/rp1/Makefile
>>  create mode 100644 drivers/misc/rp1/rp1-pci.c
>>  create mode 100644 drivers/misc/rp1/rp1-pci.dtso
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 67f460c36ea1..1359538b76e8 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19119,9 +19119,11 @@ F:	include/uapi/linux/media/raspberrypi/
>>  RASPBERRY PI RP1 PCI DRIVER
>>  M:	Andrea della Porta <andrea.porta@suse.com>
>>  S:	Maintained
>> +F:	arch/arm64/boot/dts/broadcom/rp1.dtso
>>  F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
>>  F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
>>  F:	drivers/clk/clk-rp1.c
>> +F:	drivers/misc/rp1/
>>  F:	drivers/pinctrl/pinctrl-rp1.c
>>  F:	include/dt-bindings/clock/rp1.h
>>  F:	include/dt-bindings/misc/rp1.h
>> diff --git a/arch/arm64/boot/dts/broadcom/rp1.dtso b/arch/arm64/boot/dts/broadcom/rp1.dtso
>> new file mode 100644
>> index 000000000000..d80178a278ee
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/broadcom/rp1.dtso
>> @@ -0,0 +1,152 @@
>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/clock/rp1.h>
>> +#include <dt-bindings/misc/rp1.h>
>> +
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +/ {
>> +	fragment@0 {
>> +		target-path="";
>> +		__overlay__ {
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +
>> +			rp1: rp1@0 {
>> +				compatible = "simple-bus";
>> +				#address-cells = <2>;
>> +				#size-cells = <2>;
>> +				interrupt-controller;
>> +				interrupt-parent = <&rp1>;
>> +				#interrupt-cells = <2>;
>> +
>> +				// ranges and dma-ranges must be provided by the includer
>> +				ranges = <0xc0 0x40000000
>> +					  0x01/*0x02000000*/ 0x00 0x00000000
>> +					  0x00 0x00400000>;
> 
> Are you 100% sure you do not have here dtc W=1 warnings?

One more thing, I do not see this overlay applied to any target, which
means it cannot be tested. You miss entry in Makefile.

Best regards,
Krzysztof


