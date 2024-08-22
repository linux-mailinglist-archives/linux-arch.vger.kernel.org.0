Return-Path: <linux-arch+bounces-6538-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C566695BBBD
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 18:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4686D1F27541
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 16:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4C71CB301;
	Thu, 22 Aug 2024 16:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHkvnzvX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05348282FC;
	Thu, 22 Aug 2024 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343792; cv=none; b=UMdsxxKIgfEwAR/rY3tTUIAKp6F8WtN5BfkRJJrWx6yxf1XWAHyimQKrCRWAJh0P2cxU7lbzcrPHaqk47NG3RO3WBstDrwJNBVBOyvPS8+pry9ICzTXu4QlzgZ/8dgPoH14S+p1e9b2xVf3TuInoaLcjk1Iw8TOgpao87O0mJQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343792; c=relaxed/simple;
	bh=43L7DnNwf5PKhCn45ifgPN7YWE34/X02RDZibv66tIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5rR223E0ZvdW1Fyvhr18jhEa66QZF/Tpdhl52ga2GaCM96In6gN2J29Q3mG3i0tB/yfklXoIMbdvH2fECyf10jvUHONL6mNhP+YdcNFsoVmZmpZ4PStgKA1kYmHMO/TPi67xEcj4Z6KA0Mk7TC692WE1VjimwGG6jqOII9CtEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHkvnzvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FF9C4AF16;
	Thu, 22 Aug 2024 16:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724343791;
	bh=43L7DnNwf5PKhCn45ifgPN7YWE34/X02RDZibv66tIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NHkvnzvXwnE6uzWrZj3r8QS7huQYHl6lQUYwWj4Ch6u/DQaoBdkprt3nE9whm0XSC
	 JWfdoCkn9uQ738thQ7Mf/GZEsOdygoyA+HjgYQ0h26/08YxBQuRIt1bED2mvFsLWA2
	 scH8G+pyi8FaQ7GdKEkbagnrT6FWj73l8KtMriASbVskJTkAYw1F6FsW/RWTbIHvPe
	 SXq1hj00pqD/luPofnGZmKPkEliydpp3cN1c6VdnGZcx0rKHA4Ur2p/H7lvE0EHVrR
	 fqKFZmx0krWiok3jMAx+j3eBlhzlsKJY8zkTwnfAH5mKumXoQXrX/8svvLsQtysEbO
	 Qckd+tLlb+xUw==
Date: Thu, 22 Aug 2024 17:23:02 +0100
From: Conor Dooley <conor@kernel.org>
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
Subject: Re: [PATCH 01/11] dt-bindings: clock: Add RaspberryPi RP1 clock
 bindings
Message-ID: <20240822-refutable-railroad-a3f111ab1e3f@spud>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <8d7dd7ca5da41f2a96e3ef4e2e3f29fd0d71906a.1724159867.git.andrea.porta@suse.com>
 <20240820-baritone-delegate-5711f7a0bc76@spud>
 <ZsTfoC3aKLdmFPCL@apocalypse>
 <20240821-exception-nearby-5adeaaf0178b@spud>
 <ZscGdxgoNJrifSgk@apocalypse>
 <399ff156-ffc9-4d50-8e5f-a86dc82da2fa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MUECiN+fSdL5Fn4Y"
Content-Disposition: inline
In-Reply-To: <399ff156-ffc9-4d50-8e5f-a86dc82da2fa@kernel.org>


--MUECiN+fSdL5Fn4Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 11:52:27AM +0200, Krzysztof Kozlowski wrote:

> >>>>> +examples:
> >>>>> +  - |
> >>>>> +    #include <dt-bindings/clock/rp1.h>
> >>>>> +
> >>>>> +    rp1 {
> >>>>> +        #address-cells =3D <2>;
> >>>>> +        #size-cells =3D <2>;
> >>>>> +
> >>>>> +        rp1_clocks: clocks@18000 {
> >>>>
> >>>> The unit address does not match the reg property. I'm surprised that
> >>>> dtc doesn't complain about that.
> >>>
> >>> Agreed. I'll update the address with the reg value in the next release
> >>>
> >>>>
> >>>>> +            compatible =3D "raspberrypi,rp1-clocks";
> >>>>> +            reg =3D <0xc0 0x40018000 0x0 0x10038>;
> >>>>
> >>>> This is a rather oddly specific size. It leads me to wonder if this
> >>>> region is inside some sort of syscon area?
> >>>
> >>> >From downstream source code and RP1 datasheet it seems that the last=
 addressable
> >>> register is at 0xc040028014 while the range exposed through teh devic=
etree ends
> >>> up at 0xc040028038, so it seems more of a little safe margin. I would=
n't say it
> >>> is a syscon area since those register are quite specific for video cl=
ock
> >>> generation and not to be intended to be shared among different periph=
erals.
> >>> Anyway, the next register aperture is at 0xc040030000 so I would say =
we can=20
> >>> extend the clock mapped register like the following:
> >>>
> >>> reg =3D <0xc0 0x40018000 0x0 0x18000>;
> >>>
> >>> if you think it is more readable.
> >>
> >> I don't care
> >=20
> > Ack.
> >=20
> >>>>> +            #clock-cells =3D <1>;
> >>>>> +            clocks =3D <&clk_xosc>;
> >>>>> +
> >>>>> +            assigned-clocks =3D <&rp1_clocks RP1_PLL_SYS_CORE>,
> >>>
> >>>> FWIW, I don't think any of these assigned clocks are helpful for the
> >>>> example. That said, why do you need to configure all of these assign=
ed
> >>>> clocks via devicetree when this node is the provider of them?
> >>>
> >>> Not sure to understand what you mean here, the example is there just =
to
> >>> show how to compile the dt node, maybe you're referring to the fact t=
hat
> >>> the consumer should setup the clock freq?
> >>
> >> I suppose, yeah. I don't think a particular configuration is relevant
> >> for the example binding, but simultaneously don't get why you are
> >> assigning the rate for clocks used by audio devices or ethernet in the
> >> clock provider node.
> >>
> >=20
> > Honestly I don't have a strong preference here, I can manage to do some=
 tests
> > moving the clock rate settings inside the consumer nodes but I kinda li=
ke
> > the curernt idea of a centralized node where clocks are setup beforehan=
d.
> > In RP1 the clock generator and peripherals such as ethernet are all on-=
board
> > and cannot be rewired in any other way so the devices are not standalone
> > consumer in their own right (such it would be an ethernet chip wired to=
 an
> > external CPU). But of course this is debatable, on the other hand the c=
urrent
> > approach of provider/consumer is of course very clean. I'm just wonderi=
ng
> > wthether you think I should take action on this or we can leave it as i=
t is.
> > Please see also below.
> >=20
> >>> Consider that the rp1-clocks
> >>> is coupled to the peripherals contained in the same RP1 chip so there=
 is
> >>> not much point in letting the peripherals set the clock to their leis=
ure.
> >>
> >> How is that any different to the many other SoCs in the kernel?
> >=20
> > In fact, it isn't. Please take a look at:
> > =20
> > arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi
> > arch/arm/boot/dts/ti/omap/omap44xx-clocks.dtsi
> > arch/arm/boot/dts/ti/omap/dra7xx-clocks.dtsi
> > arch/arm/boot/dts/nxp/imx/imx7d-zii-rpu2.dts
> >=20
> > and probably many others... they use the same approach, so I assumed it=
 is at
> > least reasonable to assign the clock rate this way.
>=20
> Please do not bring some ancient DTS, not really worked on, as example.
> stm32 could is moderately recent but dra and omap are not.

Right, there may be some examples like this, but there are many many
other SoCs where clocks are also not re-wireable, that do not. To me
this line of argument is akin to the clock driver calling enable on all
of the clocks because "all of the peripherals are always on the SoC".
The peripheral is the actual consumer of the clock that quote-unquote
wants the particular rate, not the clock provider, so having the rate
assignments in the consumers is the only thing that makes sense to me.



--MUECiN+fSdL5Fn4Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsdl5gAKCRB4tDGHoIJi
0qOXAQD5rgYw5/X4Ja91lG6uIEE1SemLGNR402ItvyyoKoxd1wEAwHPc8uJHiM0U
N6HspNFbOaRmU2j/vypiAMrlT9GH6A0=
=ar8E
-----END PGP SIGNATURE-----

--MUECiN+fSdL5Fn4Y--

