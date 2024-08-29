Return-Path: <linux-arch+bounces-6806-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A57249645EE
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 15:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 029D3B2745E
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 13:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFAD1A704D;
	Thu, 29 Aug 2024 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eiJDuvEY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679901A01BF
	for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2024 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937096; cv=none; b=nji02bjIIrFT+qffV2QCWYM7/yt+70m0q8/s7GlqarTiof57LN8iRUwqRMKZZzmzlmIkY7sGLYd1sVYe2welJGncaq4UQobJLxiDc2Vg3fZXI76OsVTZKVGuDLnDIAfM35wNpOTvYdEIa2bnmZgHajHPExUyDEBHM4sVEgplVew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937096; c=relaxed/simple;
	bh=fakhpIJR2ZfTamWLWAqABaX77u05L93KwsKGKWJugw4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSK5xjOpWEeZ7/65VDvzaP9zsNPFq4oGtGU2fo8mDsqXAfVZbUZM/UmPD+mvWQ886dFU6/AyFMlbEJ9D6WSKXe9TP2aIzQnt+plxDNZBV3eUAGtYq4K3rbhGg654zGXvL44xjFTPn0RsOC4D0m8F8baBIjYreCvvlvmAPrLvjnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eiJDuvEY; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5c210e23573so634492a12.0
        for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2024 06:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724937093; x=1725541893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HSLQ8KvULAlJol+4PZpsMQiwSkPlENMupYF/HR2lik=;
        b=eiJDuvEYAoOlohJFbU5fyl8pTquuP5f/Qvo0RcWNOl/z9fauJCIGdi3FMiVDfAPwel
         /jd8Np0eLvOucrO53/kcTB6QUsb13fusFXlWKHCt4uWJnLTiZp3t653yuOFe/FHw64vs
         X2gmkZ7DyV1JOzz4x6C3xvzrs8ey8gumRz4AOs0XF97hvfPKhJBwUMyeaLDbFfBrZ0Ho
         o5wlDZfu3R8R/d+ogDTf6a+hEDDNf480T3U511yZiPF6ICgj0IWEMENfKoCmyNhrgX4e
         9X+sJNWFtTvW5xeDqDoVTqUt+Ijvi/kmH3unEH7KCoFGfwACEH39o4u3TnB3wUjFvOyg
         vRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724937093; x=1725541893;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6HSLQ8KvULAlJol+4PZpsMQiwSkPlENMupYF/HR2lik=;
        b=MKFkNqeV2q0U56P9hOjhxJaMu4dNxcI+2+wEbsP546ZISzcVDN0Cpj6NHs5KC1zDxH
         Q/+1A8nTtzZX0HFjf9C0fTVs3+klRQxQAWWcsNIpQfLPgC1ycmNEAP9+8JE242SGotg4
         hdb5F9pw867M10C8lpufqXKjXZI5d6MWWBKZKImkjvzYOTIMbpbqBr4x4DMEqfFgtMx4
         rL6kIcJXXZE0N5O/4kgSTYWelTNkYbEfznJwzoJi9xvYl/AgMIsnIAwVtSWNzH28gebt
         yst1BU3pN+SyhnabxxoiNwOncq7BsAiigNsiBk9Wg7tmDUwYPphiuXqENdEqnKcdpE1s
         vPlA==
X-Forwarded-Encrypted: i=1; AJvYcCUmcEHcnuJCoCz40KwodH1zOevcHc38xCCZBY4J/2RO1/EbCA4LB8VGSzKprfTuUeH3fynTekbHIPmp@vger.kernel.org
X-Gm-Message-State: AOJu0YxnY3zCOdBDboAYeEeLKgyv/hy3f9db2LMgeXgG/gQRjAAhWFj7
	o/OV76q38pEOjXYujhjUfCjeg3GJaio9nH3x/DgtdsSNcVBeXPX6LX3sH5J6Uxs=
X-Google-Smtp-Source: AGHT+IEH/zJZio4NTe6eEsV2DoExlez2oCgJWKVnp5yu1Qv76cYjCAYlwUS9Kb57z8iTsLMFbn1guw==
X-Received: by 2002:a05:6402:268e:b0:5bf:dd0:93ad with SMTP id 4fb4d7f45d1cf-5c21ed8e66bmr2407157a12.27.1724937091825;
        Thu, 29 Aug 2024 06:11:31 -0700 (PDT)
Received: from localhost (host-80-182-198-72.retail.telecomitalia.it. [80.182.198.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988fea68dsm77550266b.26.2024.08.29.06.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 06:11:31 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 29 Aug 2024 15:11:38 +0200
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 00/11] Add support for RaspberryPi RP1 PCI device using a
 DT overlay
Message-ID: <ZtBzis5CzQMm8loh@apocalypse>
Mail-Followup-To: Krzysztof Kozlowski <krzk@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <14990d25-40a2-46c0-bf94-25800f379a30@kernel.org>
 <Zsb_ZeczWd-gQ5po@apocalypse>
 <d97dbb0b-2e9c-4a62-b6c2-c1ec3fa1225b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d97dbb0b-2e9c-4a62-b6c2-c1ec3fa1225b@kernel.org>

Hi Krzysztof,

On 11:50 Thu 22 Aug     , Krzysztof Kozlowski wrote:
> On 22/08/2024 11:05, Andrea della Porta wrote:
> > Hi Krzysztof,
> > 
> > On 15:42 Wed 21 Aug     , Krzysztof Kozlowski wrote:
> >> On 20/08/2024 16:36, Andrea della Porta wrote:
> >>> RP1 is an MFD chipset that acts as a south-bridge PCIe endpoint sporting
> >>> a pletora of subdevices (i.e.  Ethernet, USB host controller, I2C, PWM, 
> >>> etc.) whose registers are all reachable starting from an offset from the
> >>> BAR address.  The main point here is that while the RP1 as an endpoint
> >>> itself is discoverable via usual PCI enumeraiton, the devices it contains
> >>> are not discoverable and must be declared e.g. via the devicetree.
> >>>
> >>> This patchset is an attempt to provide a minimum infrastructure to allow
> >>> the RP1 chipset to be discovered and perpherals it contains to be added
> >>> from a devictree overlay loaded during RP1 PCI endpoint enumeration.
> >>> Followup patches should add support for the several peripherals contained
> >>> in RP1.
> >>>
> >>> This work is based upon dowstream drivers code and the proposal from RH
> >>> et al. (see [1] and [2]). A similar approach is also pursued in [3].
> >>
> >> Looking briefly at findings it seems this was not really tested by
> >> automation and you expect reviewers to find issues which are pointed out
> >> by tools. That's not nice approach. Reviewer's time is limited, while
> >> tools do it for free. And the tools are free - you can use them without
> >> any effort.
> > 
> > Sorry if I gave you that impression, but this is not obviously the case.
> 
> Just look at number of reports... so many sparse reports that I wonder
> how it is not the case.
> 
> And many kbuild reports.

Ack.

> 
> > I've spent quite a bit of time in trying to deliver a patchset that ease
> > your and others work, at least to the best I can. In fact, I've used many
> > of the checking facilities you mentioned before sending it, solving all
> > of the reported issues, except the ones for which there are strong reasons
> > to leave untouched, as explained below.
> > 
> >>
> >> It does not look like you tested the DTS against bindings. Please run
> >> `make dtbs_check W=1` (see
> >> Documentation/devicetree/bindings/writing-schema.rst or
> >> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> >> for instructions).
> > 
> > #> make W=1 dt_binding_check DT_SCHEMA_FILES=raspberrypi,rp1-gpio.yaml
> >    CHKDT   Documentation/devicetree/bindings
> >    LINT    Documentation/devicetree/bindings
> >    DTEX    Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.example.dts
> >    DTC_CHK Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.example.dtb
> > 
> > #> make W=1 dt_binding_check DT_SCHEMA_FILES=raspberrypi,rp1-clocks.yaml
> >    CHKDT   Documentation/devicetree/bindings
> >    LINT    Documentation/devicetree/bindings
> >    DTEX    Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.example.dts
> >    DTC_CHK Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.example.dtb
> > 
> > I see no issues here, in case you've found something different, I kindly ask you to post
> > the results.
> > 
> > #> make W=1 CHECK_DTBS=y broadcom/rp1.dtbo
> >    DTC     arch/arm64/boot/dts/broadcom/rp1.dtbo
> >    arch/arm64/boot/dts/broadcom/rp1.dtso:37.24-42.7: Warning (simple_bus_reg): /fragment@0/__overlay__/rp1@0/clk_xosc: missing or empty reg/ranges property
> >    arch/arm64/boot/dts/broadcom/rp1.dtso:44.26-49.7: Warning (simple_bus_reg): /fragment@0/__overlay__/rp1@0/macb_pclk: missing or empty reg/ranges property
> >    arch/arm64/boot/dts/broadcom/rp1.dtso:51.26-56.7: Warning (simple_bus_reg): /fragment@0/__overlay__/rp1@0/macb_hclk: missing or empty reg/ranges property
> >    arch/arm64/boot/dts/broadcom/rp1.dtso:14.15-173.5: Warning (avoid_unnecessary_addr_size): /fragment@0/__overlay__: unnecessary #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" property 
> > 
> > I believe that These warnings are unavoidable, and stem from the fact that this
> > is quite a peculiar setup (PCI endpoint which dynamically loads platform driver
> > addressable via BAR).
> > The missing reg/ranges in the threee clocks are due to the simple-bus of the
> > containing node to which I believe they should belong: I did a test to place
> 
> This is not the place where they belong. non-MMIO nodes should not be
> under simple-bus.

Ack.

> 
> > those clocks in the same dtso under root or /clocks node but AFAIK it doesn't
> > seems to work. I could move them in a separate dtso to be loaded before the main
> 
> Well... who instantiates them? If they are in top-level, then
> CLK_OF_DECLARE which is not called at your point?
> 
> You must instantiate clocks different way, since they are not part of
> "rp1". That's another bogus DT description... external oscilator is not
> part of RP1.
>

Ok, I'll dive into that and see what I can come up with. Many thanks for
this feedback.
 
> 
> > one but this is IMHO even more cumbersome than having a couple of warnings in
> > CHECK_DTBS.
> > Of course, if you have any suggestion on how to improve it I would be glad to
> > discuss.
> > About the last warning about the address/size-cells, if I drop those two lines
> > in the _overlay_ node it generates even more warning, so again it's a "don't fix"
> > one.
> > 
> >>
> >> Please run standard kernel tools for static analysis, like coccinelle,
> >> smatch and sparse, and fix reported warnings. Also please check for
> >> warnings when building with W=1. Most of these commands (checks or W=1
> >> build) can build specific targets, like some directory, to narrow the
> >> scope to only your code. The code here looks like it needs a fix. Feel
> >> free to get in touch if the warning is not clear.
> > 
> > I didn't run those static analyzers since I've preferred a more "manual" aproach
> > by carfeully checking the code, but I agree that something can escape even the
> > more carefully executed code inspection so I will add them to my arsenal from
> > now on. Thanks for the heads up.
> 
> I don't care if you do not run static analyzers if you produce good
> code. But if you produce bugs which could have been easily spotted with
> sparser, than it is different thing.
> 
> Start running static checkers instead of asking reviewers to do that.

Ack.

> 
> > 
> >>
> >> Please run scripts/checkpatch.pl and fix reported warnings. Then please
> >> run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
> >> Some warnings can be ignored, especially from --strict run, but the code
> >> here looks like it needs a fix. Feel free to get in touch if the warning
> >> is not clear.
> >>
> > 
> > Again, most of checkpatch's complaints have been addressed, the remaining
> > ones I deemed as not worth fixing, for example:>
> > #> scripts/checkpatch.pl --strict --codespell tmp/*.patch
> > 
> > WARNING: please write a help paragraph that fully describes the config symbol
> > #42: FILE: drivers/clk/Kconfig:91:
> > +config COMMON_CLK_RP1
> > +       tristate "Raspberry Pi RP1-based clock support"
> > +       depends on PCI || COMPILE_TEST
> > +       depends on COMMON_CLK
> > +       help
> > +         Enable common clock framework support for Raspberry Pi RP1.
> > +         This mutli-function device has 3 main PLLs and several clock
> > +         generators to drive the internal sub-peripherals.
> > +
> > 
> > I don't understand this warning, the paragraph is there and is more or less similar
> > to many in the same file that are already upstream. Checkpatch bug?
> > 
> > 
> > CHECK: Alignment should match open parenthesis
> > #1541: FILE: drivers/clk/clk-rp1.c:1470:
> > +       if (WARN_ON_ONCE(clock_data->num_std_parents > AUX_SEL &&
> > +           strcmp("-", clock_data->parents[AUX_SEL])))
> > 
> > This would have worsen the code readability.
> > 
> > 
> > WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
> > #673: FILE: drivers/pinctrl/pinctrl-rp1.c:600:
> > +                               return -ENOTSUPP;
> > 
> > This I must investigate: I've already tried to fix it before sending the patchset
> > but for some reason it wouldn't work, so I planned to fix it in the upcoming 
> > releases.
> > 
> > 
> > WARNING: externs should be avoided in .c files
> > #331: FILE: drivers/misc/rp1/rp1-pci.c:58:
> > +extern char __dtbo_rp1_pci_begin[];
> > 
> > True, but in this case we don't have a symbol that should be exported to other
> > translation units, it just needs to be referenced inside the driver and
> > consumed locally. Hence it would be better to place the extern in .c file.
> > 
> > 
> > Apologies for a couple of other warnings that I could have seen in the first
> > place, but honestly they don't seems to be a big deal (one typo and on over
> > 100 chars comment, that will be fixed in next patch version). 
> 
> Again, judging by number of reports from checkers that is a big deal,
> because it is your task to run the tools.

Ack.

Many thanks,
Andrea

> 
> Best regards,
> Krzysztof
> 

