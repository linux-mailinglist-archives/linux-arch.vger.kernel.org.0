Return-Path: <linux-arch+bounces-6511-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 882A495B24A
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 11:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019431F24472
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 09:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1A6178381;
	Thu, 22 Aug 2024 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5X/GGVf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF12C17C224;
	Thu, 22 Aug 2024 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724320244; cv=none; b=FXpRBk8ocU/XdeFDZepKUZdn4gXuDymYKykrFSvcVPydkR2WRaECAP9RM0jEaqfZFJfx/WP0VVA7zXqwbb1bHzbvCUkhebPXSLofj5tWbS+0+ZXnRFEYH5uyjY2RDTFsPnzPOKYJ6l1HuxnCokbTL2orr+z2w50ZsKOCBhfxdV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724320244; c=relaxed/simple;
	bh=TTvf5bOa7tlLKbNRDJ3OgK41JVPVbPXdEh6l7OW6QG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WkY1I+Qm/Z/FRl7J+OLw4aDQ3Hkfk52PD2XWV+uoa5lRF6UTjOLxqaxOy7vw1prQhgY/acdOU3koOW+uXplzfMlhJNGDmdPSDHwcMlOcqzczGW79zRtFPUc3bEdUg4zsNqZjIGIpz0NisJ+SCITjAwUDW6fSn4FeDjzu6gokX5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5X/GGVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F3AC32782;
	Thu, 22 Aug 2024 09:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724320243;
	bh=TTvf5bOa7tlLKbNRDJ3OgK41JVPVbPXdEh6l7OW6QG8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=T5X/GGVfbNIXMHeBG8cZd3alkWT88netB82MxmN3bFjBVcePJXYO9XxhIZQ6mLfxA
	 bXV1lMoSWGVjomdqxJztWWzF29ljmyYvR+kv6fYha5OEbur0+bLf/5TBA7ApWG7e/b
	 EVSgw17GzyXfqVldrQar9kYer771XQVr3sU/Z3Dnbgbb+TklP7hdXRBcY4d8WJSYP+
	 wYOs2yo7hb6nL2mv+ZSXaEQkIdg16bCCfvRVIFnW+c92BDIuwMZyx4FqTkbuqCSk2J
	 xAaJ+zb61GFnf24jBs+TPIIFniAKaaO0RX8FMJVhzuttfYsfDxyboU1z1C7w4u4SgM
	 CR6KQWUYkEmmQ==
Message-ID: <d97dbb0b-2e9c-4a62-b6c2-c1ec3fa1225b@kernel.org>
Date: Thu, 22 Aug 2024 11:50:28 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Add support for RaspberryPi RP1 PCI device using a
 DT overlay
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
 <14990d25-40a2-46c0-bf94-25800f379a30@kernel.org>
 <Zsb_ZeczWd-gQ5po@apocalypse>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <Zsb_ZeczWd-gQ5po@apocalypse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/08/2024 11:05, Andrea della Porta wrote:
> Hi Krzysztof,
> 
> On 15:42 Wed 21 Aug     , Krzysztof Kozlowski wrote:
>> On 20/08/2024 16:36, Andrea della Porta wrote:
>>> RP1 is an MFD chipset that acts as a south-bridge PCIe endpoint sporting
>>> a pletora of subdevices (i.e.  Ethernet, USB host controller, I2C, PWM, 
>>> etc.) whose registers are all reachable starting from an offset from the
>>> BAR address.  The main point here is that while the RP1 as an endpoint
>>> itself is discoverable via usual PCI enumeraiton, the devices it contains
>>> are not discoverable and must be declared e.g. via the devicetree.
>>>
>>> This patchset is an attempt to provide a minimum infrastructure to allow
>>> the RP1 chipset to be discovered and perpherals it contains to be added
>>> from a devictree overlay loaded during RP1 PCI endpoint enumeration.
>>> Followup patches should add support for the several peripherals contained
>>> in RP1.
>>>
>>> This work is based upon dowstream drivers code and the proposal from RH
>>> et al. (see [1] and [2]). A similar approach is also pursued in [3].
>>
>> Looking briefly at findings it seems this was not really tested by
>> automation and you expect reviewers to find issues which are pointed out
>> by tools. That's not nice approach. Reviewer's time is limited, while
>> tools do it for free. And the tools are free - you can use them without
>> any effort.
> 
> Sorry if I gave you that impression, but this is not obviously the case.

Just look at number of reports... so many sparse reports that I wonder
how it is not the case.

And many kbuild reports.

> I've spent quite a bit of time in trying to deliver a patchset that ease
> your and others work, at least to the best I can. In fact, I've used many
> of the checking facilities you mentioned before sending it, solving all
> of the reported issues, except the ones for which there are strong reasons
> to leave untouched, as explained below.
> 
>>
>> It does not look like you tested the DTS against bindings. Please run
>> `make dtbs_check W=1` (see
>> Documentation/devicetree/bindings/writing-schema.rst or
>> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
>> for instructions).
> 
> #> make W=1 dt_binding_check DT_SCHEMA_FILES=raspberrypi,rp1-gpio.yaml
>    CHKDT   Documentation/devicetree/bindings
>    LINT    Documentation/devicetree/bindings
>    DTEX    Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.example.dts
>    DTC_CHK Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.example.dtb
> 
> #> make W=1 dt_binding_check DT_SCHEMA_FILES=raspberrypi,rp1-clocks.yaml
>    CHKDT   Documentation/devicetree/bindings
>    LINT    Documentation/devicetree/bindings
>    DTEX    Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.example.dts
>    DTC_CHK Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.example.dtb
> 
> I see no issues here, in case you've found something different, I kindly ask you to post
> the results.
> 
> #> make W=1 CHECK_DTBS=y broadcom/rp1.dtbo
>    DTC     arch/arm64/boot/dts/broadcom/rp1.dtbo
>    arch/arm64/boot/dts/broadcom/rp1.dtso:37.24-42.7: Warning (simple_bus_reg): /fragment@0/__overlay__/rp1@0/clk_xosc: missing or empty reg/ranges property
>    arch/arm64/boot/dts/broadcom/rp1.dtso:44.26-49.7: Warning (simple_bus_reg): /fragment@0/__overlay__/rp1@0/macb_pclk: missing or empty reg/ranges property
>    arch/arm64/boot/dts/broadcom/rp1.dtso:51.26-56.7: Warning (simple_bus_reg): /fragment@0/__overlay__/rp1@0/macb_hclk: missing or empty reg/ranges property
>    arch/arm64/boot/dts/broadcom/rp1.dtso:14.15-173.5: Warning (avoid_unnecessary_addr_size): /fragment@0/__overlay__: unnecessary #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" property 
> 
> I believe that These warnings are unavoidable, and stem from the fact that this
> is quite a peculiar setup (PCI endpoint which dynamically loads platform driver
> addressable via BAR).
> The missing reg/ranges in the threee clocks are due to the simple-bus of the
> containing node to which I believe they should belong: I did a test to place

This is not the place where they belong. non-MMIO nodes should not be
under simple-bus.

> those clocks in the same dtso under root or /clocks node but AFAIK it doesn't
> seems to work. I could move them in a separate dtso to be loaded before the main

Well... who instantiates them? If they are in top-level, then
CLK_OF_DECLARE which is not called at your point?

You must instantiate clocks different way, since they are not part of
"rp1". That's another bogus DT description... external oscilator is not
part of RP1.


> one but this is IMHO even more cumbersome than having a couple of warnings in
> CHECK_DTBS.
> Of course, if you have any suggestion on how to improve it I would be glad to
> discuss.
> About the last warning about the address/size-cells, if I drop those two lines
> in the _overlay_ node it generates even more warning, so again it's a "don't fix"
> one.
> 
>>
>> Please run standard kernel tools for static analysis, like coccinelle,
>> smatch and sparse, and fix reported warnings. Also please check for
>> warnings when building with W=1. Most of these commands (checks or W=1
>> build) can build specific targets, like some directory, to narrow the
>> scope to only your code. The code here looks like it needs a fix. Feel
>> free to get in touch if the warning is not clear.
> 
> I didn't run those static analyzers since I've preferred a more "manual" aproach
> by carfeully checking the code, but I agree that something can escape even the
> more carefully executed code inspection so I will add them to my arsenal from
> now on. Thanks for the heads up.

I don't care if you do not run static analyzers if you produce good
code. But if you produce bugs which could have been easily spotted with
sparser, than it is different thing.

Start running static checkers instead of asking reviewers to do that.

> 
>>
>> Please run scripts/checkpatch.pl and fix reported warnings. Then please
>> run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
>> Some warnings can be ignored, especially from --strict run, but the code
>> here looks like it needs a fix. Feel free to get in touch if the warning
>> is not clear.
>>
> 
> Again, most of checkpatch's complaints have been addressed, the remaining
> ones I deemed as not worth fixing, for example:>
> #> scripts/checkpatch.pl --strict --codespell tmp/*.patch
> 
> WARNING: please write a help paragraph that fully describes the config symbol
> #42: FILE: drivers/clk/Kconfig:91:
> +config COMMON_CLK_RP1
> +       tristate "Raspberry Pi RP1-based clock support"
> +       depends on PCI || COMPILE_TEST
> +       depends on COMMON_CLK
> +       help
> +         Enable common clock framework support for Raspberry Pi RP1.
> +         This mutli-function device has 3 main PLLs and several clock
> +         generators to drive the internal sub-peripherals.
> +
> 
> I don't understand this warning, the paragraph is there and is more or less similar
> to many in the same file that are already upstream. Checkpatch bug?
> 
> 
> CHECK: Alignment should match open parenthesis
> #1541: FILE: drivers/clk/clk-rp1.c:1470:
> +       if (WARN_ON_ONCE(clock_data->num_std_parents > AUX_SEL &&
> +           strcmp("-", clock_data->parents[AUX_SEL])))
> 
> This would have worsen the code readability.
> 
> 
> WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
> #673: FILE: drivers/pinctrl/pinctrl-rp1.c:600:
> +                               return -ENOTSUPP;
> 
> This I must investigate: I've already tried to fix it before sending the patchset
> but for some reason it wouldn't work, so I planned to fix it in the upcoming 
> releases.
> 
> 
> WARNING: externs should be avoided in .c files
> #331: FILE: drivers/misc/rp1/rp1-pci.c:58:
> +extern char __dtbo_rp1_pci_begin[];
> 
> True, but in this case we don't have a symbol that should be exported to other
> translation units, it just needs to be referenced inside the driver and
> consumed locally. Hence it would be better to place the extern in .c file.
> 
> 
> Apologies for a couple of other warnings that I could have seen in the first
> place, but honestly they don't seems to be a big deal (one typo and on over
> 100 chars comment, that will be fixed in next patch version). 

Again, judging by number of reports from checkers that is a big deal,
because it is your task to run the tools.

Best regards,
Krzysztof


