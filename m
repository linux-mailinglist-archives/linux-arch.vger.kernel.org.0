Return-Path: <linux-arch+bounces-6406-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FF0959AEA
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 13:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1745B1F21743
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 11:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C25E19ABA9;
	Wed, 21 Aug 2024 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2G/y1bM"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034E9188A3C;
	Wed, 21 Aug 2024 11:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724240788; cv=none; b=islA0Q9oKOsE6H1129XSpOIRAdJpjLYxxcbHxZ6TaA7pDop9HNISQOtMRH6QnTre3kEGyULWP4XTq22e/8yvOFNjGTzmNm+XTfVS9Se5yp6Hxotnr0kSNfA/6EgqKsDaetgtvNbg0DEyoCCYeP0agYXdG/ar/rupkukQj3mPiMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724240788; c=relaxed/simple;
	bh=WMV4dGFtHRsMdGbR2t0cIKkZrN1IsuFG4Za9AEuHTRw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mi8ZrWtkbxyQmyokHMhJksVvq82bXYlkO/NVrmA3+E0//6SOkGmQMJ5aZh8Q9FmKIh+Y3XRFW7MoXYxYmSuBBgBr9Xb1xSAw1HODi+MP35O2vgkfRtg7DnxfL6xaXZwlTvJAAYfezphFnNpVC0+v2lV9p31PgziL3wdyLHS6YfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2G/y1bM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184C6C32782;
	Wed, 21 Aug 2024 11:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724240787;
	bh=WMV4dGFtHRsMdGbR2t0cIKkZrN1IsuFG4Za9AEuHTRw=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=r2G/y1bMyDsrn/29xVktY1F46ZX1ZKor91MvYUGiPhlQ/pwuxV/1c0wTvT/ylUDSl
	 9BBy09XZgbyDNor2+WyK9oOQnPkY1FnNhRDAC6ClFaSePQbYyB0hR1qhuKTYz8qBnq
	 qHmWeJA15MJL4rrye2JVqnFiqwSxoOARKEJguvzTt/4DcztdtbMDtH0iw+64DttJhM
	 foLuSUPDleQWrjJJ2RCjOthIiqGyvwQKmJ9ZIgzJbnyZgyoAIVa0ULthwUi5P1G0Zm
	 9degnT1bf3Ag7E4hmIx8Xod4j73NrXI0hOWM/pG2Rp5IAWDefxO+mmif2NIN0txw7t
	 gRzupXR5uo6LA==
Date: Wed, 21 Aug 2024 12:46:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>,
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
Subject: Re: [PATCH 01/11] dt-bindings: clock: Add RaspberryPi RP1 clock
 bindings
Message-ID: <20240821-exception-nearby-5adeaaf0178b@spud>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <8d7dd7ca5da41f2a96e3ef4e2e3f29fd0d71906a.1724159867.git.andrea.porta@suse.com>
 <20240820-baritone-delegate-5711f7a0bc76@spud>
 <ZsTfoC3aKLdmFPCL@apocalypse>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eD3kkNo53rLLXBRC"
Content-Disposition: inline
In-Reply-To: <ZsTfoC3aKLdmFPCL@apocalypse>


--eD3kkNo53rLLXBRC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 08:25:36PM +0200, Andrea della Porta wrote:
> Hi Conor,
>=20
> On 17:19 Tue 20 Aug     , Conor Dooley wrote:
> > On Tue, Aug 20, 2024 at 04:36:03PM +0200, Andrea della Porta wrote:
> > > Add device tree bindings for the clock generator found in RP1 multi
> > > function device, and relative entries in MAINTAINERS file.
> > >=20
> > > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > > ---
> > >  .../clock/raspberrypi,rp1-clocks.yaml         | 87 +++++++++++++++++=
++
> > >  MAINTAINERS                                   |  6 ++
> > >  include/dt-bindings/clock/rp1.h               | 56 ++++++++++++
> > >  3 files changed, 149 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/clock/raspberry=
pi,rp1-clocks.yaml
> > >  create mode 100644 include/dt-bindings/clock/rp1.h
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/clock/raspberrypi,rp1-=
clocks.yaml b/Documentation/devicetree/bindings/clock/raspberrypi,rp1-clock=
s.yaml
> > > new file mode 100644
> > > index 000000000000..b27db86d0572
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.=
yaml
> > > @@ -0,0 +1,87 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/clock/raspberrypi,rp1-clocks.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: RaspberryPi RP1 clock generator
> > > +
> > > +maintainers:
> > > +  - Andrea della Porta <andrea.porta@suse.com>
> > > +
> > > +description: |
> > > +  The RP1 contains a clock generator designed as three PLLs (CORE, A=
UDIO,
> > > +  VIDEO), and each PLL output can be programmed though dividers to g=
enerate
> > > +  the clocks to drive the sub-peripherals embedded inside the chipse=
t.
> > > +
> > > +  Link to datasheet:
> > > +  https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: raspberrypi,rp1-clocks
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  '#clock-cells':
> > > +    description:
> > > +      The index in the assigned-clocks is mapped to the output clock=
 as per
> > > +      definitions in dt-bindings/clock/rp1.h.
> > > +    const: 1
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - '#clock-cells'
> > > +  - clocks
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/rp1.h>
> > > +
> > > +    rp1 {
> > > +        #address-cells =3D <2>;
> > > +        #size-cells =3D <2>;
> > > +
> > > +        rp1_clocks: clocks@18000 {
> >=20
> > The unit address does not match the reg property. I'm surprised that
> > dtc doesn't complain about that.
>=20
> Agreed. I'll update the address with the reg value in the next release
>=20
> >=20
> > > +            compatible =3D "raspberrypi,rp1-clocks";
> > > +            reg =3D <0xc0 0x40018000 0x0 0x10038>;
> >=20
> > This is a rather oddly specific size. It leads me to wonder if this
> > region is inside some sort of syscon area?
>=20
> >From downstream source code and RP1 datasheet it seems that the last add=
ressable
> register is at 0xc040028014 while the range exposed through teh devicetre=
e ends
> up at 0xc040028038, so it seems more of a little safe margin. I wouldn't =
say it
> is a syscon area since those register are quite specific for video clock
> generation and not to be intended to be shared among different peripheral=
s.
> Anyway, the next register aperture is at 0xc040030000 so I would say we c=
an=20
> extend the clock mapped register like the following:
>=20
> reg =3D <0xc0 0x40018000 0x0 0x18000>;
>=20
> if you think it is more readable.

I don't care=20
> > > +            #clock-cells =3D <1>;
> > > +            clocks =3D <&clk_xosc>;
> > > +
> > > +            assigned-clocks =3D <&rp1_clocks RP1_PLL_SYS_CORE>,
>=20
> > FWIW, I don't think any of these assigned clocks are helpful for the
> > example. That said, why do you need to configure all of these assigned
> > clocks via devicetree when this node is the provider of them?
>=20
> Not sure to understand what you mean here, the example is there just to
> show how to compile the dt node, maybe you're referring to the fact that
> the consumer should setup the clock freq?

I suppose, yeah. I don't think a particular configuration is relevant
for the example binding, but simultaneously don't get why you are
assigning the rate for clocks used by audio devices or ethernet in the
clock provider node.

> Consider that the rp1-clocks
> is coupled to the peripherals contained in the same RP1 chip so there is
> not much point in letting the peripherals set the clock to their leisure.

How is that any different to the many other SoCs in the kernel?

> > > +                              <&rp1_clocks RP1_PLL_AUDIO_CORE>,
> > > +                              /* RP1_PLL_VIDEO_CORE and dividers are=
 now managed by VEC,DPI drivers */
> >=20
> > Comments like this also do not seem relevant to the binding.
>=20
> Agreed, will drop in the next release.
>=20
> >=20
> >=20
> > Cheers,
> > Conor.
> >
>=20
> Many thanks,
> Andrea
> =20
> >=20
> > > +                              <&rp1_clocks RP1_PLL_SYS>,
> > > +                              <&rp1_clocks RP1_PLL_SYS_SEC>,
> > > +                              <&rp1_clocks RP1_PLL_AUDIO>,
> > > +                              <&rp1_clocks RP1_PLL_AUDIO_SEC>,
> > > +                              <&rp1_clocks RP1_CLK_SYS>,
> > > +                              <&rp1_clocks RP1_PLL_SYS_PRI_PH>,
> > > +                              /* RP1_CLK_SLOW_SYS is used for the fr=
equency counter (FC0) */
> > > +                              <&rp1_clocks RP1_CLK_SLOW_SYS>,
> > > +                              <&rp1_clocks RP1_CLK_SDIO_TIMER>,
> > > +                              <&rp1_clocks RP1_CLK_SDIO_ALT_SRC>,
> > > +                              <&rp1_clocks RP1_CLK_ETH_TSU>;
> > > +
> > > +            assigned-clock-rates =3D <1000000000>, // RP1_PLL_SYS_CO=
RE
> > > +                                   <1536000000>, // RP1_PLL_AUDIO_CO=
RE
> > > +                                   <200000000>,  // RP1_PLL_SYS
> > > +                                   <125000000>,  // RP1_PLL_SYS_SEC
> > > +                                   <61440000>,   // RP1_PLL_AUDIO
> > > +                                   <192000000>,  // RP1_PLL_AUDIO_SEC
> > > +                                   <200000000>,  // RP1_CLK_SYS
> > > +                                   <100000000>,  // RP1_PLL_SYS_PRI_=
PH
> > > +                                   /* Must match the XOSC frequency =
*/
> > > +                                   <50000000>, // RP1_CLK_SLOW_SYS
> > > +                                   <1000000>, // RP1_CLK_SDIO_TIMER
> > > +                                   <200000000>, // RP1_CLK_SDIO_ALT_=
SRC
> > > +                                   <50000000>; // RP1_CLK_ETH_TSU
> > > +        };
> > > +    };
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 42decde38320..6e7db9bce278 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -19116,6 +19116,12 @@ F:	Documentation/devicetree/bindings/media/r=
aspberrypi,pispbe.yaml
> > >  F:	drivers/media/platform/raspberrypi/pisp_be/
> > >  F:	include/uapi/linux/media/raspberrypi/
> > > =20
> > > +RASPBERRY PI RP1 PCI DRIVER
> > > +M:	Andrea della Porta <andrea.porta@suse.com>
> > > +S:	Maintained
> > > +F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.ya=
ml
> > > +F:	include/dt-bindings/clock/rp1.h
> > > +
> > >  RC-CORE / LIRC FRAMEWORK
> > >  M:	Sean Young <sean@mess.org>
> > >  L:	linux-media@vger.kernel.org
> > > diff --git a/include/dt-bindings/clock/rp1.h b/include/dt-bindings/cl=
ock/rp1.h
> > > new file mode 100644
> > > index 000000000000..1ed67b8a5229
> > > --- /dev/null
> > > +++ b/include/dt-bindings/clock/rp1.h
> > > @@ -0,0 +1,56 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> > > +/*
> > > + * Copyright (C) 2021 Raspberry Pi Ltd.
> > > + */
> > > +
> > > +#define RP1_PLL_SYS_CORE		0
> > > +#define RP1_PLL_AUDIO_CORE		1
> > > +#define RP1_PLL_VIDEO_CORE		2
> > > +
> > > +#define RP1_PLL_SYS			3
> > > +#define RP1_PLL_AUDIO			4
> > > +#define RP1_PLL_VIDEO			5
> > > +
> > > +#define RP1_PLL_SYS_PRI_PH		6
> > > +#define RP1_PLL_SYS_SEC_PH		7
> > > +#define RP1_PLL_AUDIO_PRI_PH		8
> > > +
> > > +#define RP1_PLL_SYS_SEC			9
> > > +#define RP1_PLL_AUDIO_SEC		10
> > > +#define RP1_PLL_VIDEO_SEC		11
> > > +
> > > +#define RP1_CLK_SYS			12
> > > +#define RP1_CLK_SLOW_SYS		13
> > > +#define RP1_CLK_DMA			14
> > > +#define RP1_CLK_UART			15
> > > +#define RP1_CLK_ETH			16
> > > +#define RP1_CLK_PWM0			17
> > > +#define RP1_CLK_PWM1			18
> > > +#define RP1_CLK_AUDIO_IN		19
> > > +#define RP1_CLK_AUDIO_OUT		20
> > > +#define RP1_CLK_I2S			21
> > > +#define RP1_CLK_MIPI0_CFG		22
> > > +#define RP1_CLK_MIPI1_CFG		23
> > > +#define RP1_CLK_PCIE_AUX		24
> > > +#define RP1_CLK_USBH0_MICROFRAME	25
> > > +#define RP1_CLK_USBH1_MICROFRAME	26
> > > +#define RP1_CLK_USBH0_SUSPEND		27
> > > +#define RP1_CLK_USBH1_SUSPEND		28
> > > +#define RP1_CLK_ETH_TSU			29
> > > +#define RP1_CLK_ADC			30
> > > +#define RP1_CLK_SDIO_TIMER		31
> > > +#define RP1_CLK_SDIO_ALT_SRC		32
> > > +#define RP1_CLK_GP0			33
> > > +#define RP1_CLK_GP1			34
> > > +#define RP1_CLK_GP2			35
> > > +#define RP1_CLK_GP3			36
> > > +#define RP1_CLK_GP4			37
> > > +#define RP1_CLK_GP5			38
> > > +#define RP1_CLK_VEC			39
> > > +#define RP1_CLK_DPI			40
> > > +#define RP1_CLK_MIPI0_DPI		41
> > > +#define RP1_CLK_MIPI1_DPI		42
> > > +
> > > +/* Extra PLL output channels - RP1B0 only */
> > > +#define RP1_PLL_VIDEO_PRI_PH		43
> > > +#define RP1_PLL_AUDIO_TERN		44
> > > --=20
> > > 2.35.3
> > >=20
>=20
>=20

--eD3kkNo53rLLXBRC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsXTdgAKCRB4tDGHoIJi
0kLKAQC535sjoiTm1nVjrfWgTOd6n9yLyJcuMXMSBYYjbBLvdAD+PDOHUfTtzjNr
QMANmxNh/c4BZ8btKjAD28A7nvtqGAU=
=945/
-----END PGP SIGNATURE-----

--eD3kkNo53rLLXBRC--

