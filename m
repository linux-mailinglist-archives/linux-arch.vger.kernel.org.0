Return-Path: <linux-arch+bounces-6808-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E75196464B
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 15:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94F41B25723
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 13:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE0F1A3BC3;
	Thu, 29 Aug 2024 13:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWsdz9HH"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED3119005B;
	Thu, 29 Aug 2024 13:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937508; cv=none; b=G+dnb1YuUNaHoeGHMWCqmsyDk0tERXMM+iWd+OER+kLdSBUeXDh0P3gra5to5+cndo3h3jMSYiFcIyM75hkTK0IwF+VaRBmjFHjZvBNdRu89ZZSSiVPFWW5Pyh7gbuar676p8sKl5FdPF1qCq3wFc4OCOkUP/onXs3eXXg+V9I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937508; c=relaxed/simple;
	bh=BVRVuYX+Z7tmSeesL23NgAc31YLWeo3n7+at9NzUXJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4WCfDSs/rHWjPgx1fw4yWF0K1Iio/zgDU2+jMrKVEU+4BdSJa/IOcOPfRCfEjys3ROvXI0QbHOl5T/Z98r/TvvKfuaj+IuIydUTbPM+XvvWzvuMhKpfp0EEXO6WJA0jQ5SsEuraOneEgSFk0mTBR9f7INkcfNESzLE2KNJeP9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWsdz9HH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B0EC4CEC9;
	Thu, 29 Aug 2024 13:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724937507;
	bh=BVRVuYX+Z7tmSeesL23NgAc31YLWeo3n7+at9NzUXJQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HWsdz9HHxmxeZdXpHeU8qqIWD5WhMgFg5F10ksh/dVVZbZ6QxmpnDgO1xwgQwNIqO
	 Hq+vE4SEh0CrnhzLn3nVBXdPQ005w9hV9UjGulnBR4TchTRWDxalWRHGkgU1+75ztd
	 g+0UadN1+mkPxX0mrJDg0n4Bpm89muLAsdI4ilPYVGSbA+J2/muxVqjrpEhvTB3Q+A
	 Ewjm7fEN5Oly2BZfTU9FyZfXWLyepmq7CKh4UhH5GzG0Ta3hg6JqRkj1VVBST2Y+d5
	 lGBfnQk6nAft/OLUmrZGfkydWYqAxfbKNdOOSNca2+ohlwxlhC36H42MeVIzowAiuG
	 m6l2D08Jgbi7Q==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5334879ba28so890194e87.3;
        Thu, 29 Aug 2024 06:18:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUM91pfkzB5qXxPmJqBv0iOlo0uhjnDJ0FPLC6IX5l35jct/tV87rJBdiKAFYnmljEjVHQfLoDbjbcS@vger.kernel.org, AJvYcCVK2Q4XeGlEuDmWV/UWrD1devPX/DfC6q3w0+p/9e5lGxDBkdL7tke8KbC25/peb8BynSxqHcD5@vger.kernel.org, AJvYcCVc5mTwr2GPTC4gmZKaAk8ZuHihgQ05fbULdOP0l5SxroALRImsOoGs9TSQZfCzZZY6WyvwNGL34T+O@vger.kernel.org, AJvYcCW+bOycm2hg+hDCJd5E7YcTORwgdaNjh4txxrw24Z5UHVa216PpvXhYL10D6meOUML+K5IGLdww4rkbAcZU@vger.kernel.org, AJvYcCW2Opj9dyGl0AA0gPjlLVN87erqMTjWZHYmjLg9jW0Eou3ZPm6bbIvlJFi+vKIvl+LfmXLJ90t+7Wi2mQ==@vger.kernel.org, AJvYcCXwNFdLbVI06TboGNoIrtmthmVoWCCdI67v0n+agVQonFMXSE1mm0xWUS2EXUYzn79E5JGtZUN/nYvm@vger.kernel.org, AJvYcCXx27I5TufDfe08XeUdKXuoKNEqFq6AlLl8WHUs9l5ad2J+WWTG6nBNA/h4IFEJJydIt1vyl36sj4s7Zg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTzQW/8RwgeVGTO7rkOcJbcCLa342JHlaaYj4mYYSBAV8AUUy7
	ABezfPV5Ke26cndLXZQPEQkldeEoFcNtn214EiAJsqSLDq3t8QDetGF3O3nwhgrCJ6wbT9aI0Zm
	9oDL/nYXp1CytYtwte/6/6FmMGQ==
X-Google-Smtp-Source: AGHT+IFctTEg7Rr6bZidsqCIt8DCoy/MV1ZFUit4qcXz6Zq+RHhM4qKEvQskUwtce+oES60wD9gdCSyG0cqSSkCaZ14=
X-Received: by 2002:a05:6512:401d:b0:533:4722:ebb0 with SMTP id
 2adb3069b0e04-5353e548f6fmr2127035e87.6.1724937505925; Thu, 29 Aug 2024
 06:18:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724159867.git.andrea.porta@suse.com> <5ca13a5b01c6c737f07416be53eb05b32811da21.1724159867.git.andrea.porta@suse.com>
 <20240821001618.GA2309328-robh@kernel.org> <ZsWi86I1KG91fteb@apocalypse>
 <CAL_JsqKN0ZNMtq+_dhurwLR+FL2MBOmWujp7uy+5HzXxUb_qDQ@mail.gmail.com> <ZtBJ0jIq-QrTVs1m@apocalypse>
In-Reply-To: <ZtBJ0jIq-QrTVs1m@apocalypse>
From: Rob Herring <robh@kernel.org>
Date: Thu, 29 Aug 2024 08:18:12 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+_-m3cjTRsFZ0RwVpot3Pdcr1GWt-qiiFC8kQvsmV7VQ@mail.gmail.com>
Message-ID: <CAL_Jsq+_-m3cjTRsFZ0RwVpot3Pdcr1GWt-qiiFC8kQvsmV7VQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] of: address: Preserve the flags portion on 1:1
 dma-ranges mapping
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>, 
	Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Saravana Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arch@vger.kernel.org, Lee Jones <lee@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Stefan Wahren <wahrenst@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 5:13=E2=80=AFAM Andrea della Porta
<andrea.porta@suse.com> wrote:
>
> Hi Rob,

BTW, I noticed your email replies set "reply-to" to everyone in To and
Cc. The result (with Gmail) is my reply lists everyone twice (in both
To and Cc). "reply-to" is just supposed to be the 1 address you want
replies sent to instead of the "from" address.

> On 16:29 Mon 26 Aug     , Rob Herring wrote:
> > On Wed, Aug 21, 2024 at 3:19=E2=80=AFAM Andrea della Porta
> > <andrea.porta@suse.com> wrote:
> > >
> > > Hi Rob,
> > >
> > > On 19:16 Tue 20 Aug     , Rob Herring wrote:
> > > > On Tue, Aug 20, 2024 at 04:36:06PM +0200, Andrea della Porta wrote:
> > > > > A missing or empty dma-ranges in a DT node implies a 1:1 mapping =
for dma
> > > > > translations. In this specific case, rhe current behaviour is to =
zero out
> > > >
> > > > typo
> > >
> > > Fixed, thanks!
> > >
> > > >
> > > > > the entire specifier so that the translation could be carried on =
as an
> > > > > offset from zero.  This includes address specifier that has flags=
 (e.g.
> > > > > PCI ranges).
> > > > > Once the flags portion has been zeroed, the translation chain is =
broken
> > > > > since the mapping functions will check the upcoming address speci=
fier
> > > >
> > > > What does "upcoming address" mean?
> > >
> > > Sorry for the confusion, this means "address specifier (with valid fl=
ags) fed
> > > to the translating functions and for which we are looking for a trans=
lation".
> > > While this address has some valid flags set, it will fail the transla=
tion step
> > > since the ranges it is matched against have flags zeroed out by the 1=
:1 mapping
> > > condition.
> > >
> > > >
> > > > > against mismatching flags, always failing the 1:1 mapping and its=
 entire
> > > > > purpose of always succeeding.
> > > > > Set to zero only the address portion while passing the flags thro=
ugh.
> > > >
> > > > Can you point me to what the failing DT looks like. I'm puzzled how
> > > > things would have worked for anyone.
> > > >
> > >
> > > The following is a simplified and lightly edited) version of the resu=
lting DT
> > > from RPi5:
> > >
> > >  pci@0,0 {
> > >         #address-cells =3D <0x03>;
> > >         #size-cells =3D <0x02>;
> > >         ......
> > >         device_type =3D "pci";
> > >         compatible =3D "pci14e4,2712\0pciclass,060400\0pciclass,0604"=
;
> > >         ranges =3D <0x82000000 0x00 0x00   0x82000000 0x00 0x00   0x0=
0 0x600000>;
> > >         reg =3D <0x00 0x00 0x00   0x00 0x00>;
> > >
> > >         ......
> > >
> > >         rp1@0 {
> >
> > What does 0 represent here? There's no 0 address in 'ranges' below.
> > Since you said the parent is a PCI-PCI bridge, then the unit-address
> > would have to be the PCI devfn and you are missing 'reg' (or omitted
> > it).
>
> There's no reg property because the registers for RP1 are addressed
> starting at 0x40108000 offset from BAR1. The devicetree specs says
> that a missing reg node should not have any unit address specified
> (and AFAIK there's no other special directives for simple-bus specified
> in dt-bindings).
> I've added @0 just to get rid of the following warning:
>
>  Warning (unit_address_vs_reg): /fragment@0/__overlay__/rp1: node has
>  a reg or ranges property, but no unit name

It's still wrong as dtc only checks the unit-address is correct in a
few cases with known bus types.

> coming from make W=3D1 CHECK_DTBS=3Dy broadcom/rp1.dtbo.
> This is the exact same approach used by Bootlin patchset from:
>
> https://lore.kernel.org/all/20240808154658.247873-2-herve.codina@bootlin.=
com/

It is not. First, that has a node for the PCI device (i.e. the
LAN966x). You do not. You only have a PCI-PCI bridge and that is
wrong.

BTW, you should Cc Herve and others that are working on this feature.
It is by no means fully sorted as you have found.

> replied here below for convenience:
>
> +       pci-ep-bus@0 {
> +               compatible =3D "simple-bus";
> +               #address-cells =3D <1>;
> +               #size-cells =3D <1>;
> +
> +               /*
> +                * map @0xe2000000 (32MB) to BAR0 (CPU)
> +                * map @0xe0000000 (16MB) to BAR1 (AMBA)
> +                */
> +               ranges =3D <0xe2000000 0x00 0x00 0x00 0x2000000

The 0 parent address here matches the unit-address, so all good in this cas=
e.

> +                         0xe0000000 0x01 0x00 0x00 0x1000000>;
>
> Also, I think it's not possible to know the devfn in advance, since the
> DT part is pre-compiled as an overlay while the devfn number is coming fr=
om
> bus enumeration.

No. devfn is fixed unless you are plugging in a card in different
slots. The bus number is the part that is not known and assigned by
the OS, but you'll notice that is omitted.

In any case, the RP1 node should be generated, so its devfn is irrelevant.

> Since the registers for sub-peripherals will start (as stated in ranges
> property) from 0xc040000000, I'd be inclined to use rp1@c040000000 as the
> node name and address unit. Is it feasible?

Yes, but that would be in nodes underneath ranges. Above, it is the
parent bus we are talking about.

> > >                 #address-cells =3D <0x02>;
> > >                 #size-cells =3D <0x02>;
> > >                 compatible =3D "simple-bus";
> >
> > The parent is a PCI-PCI bridge. Child nodes have to be PCI devices and
> > "simple-bus" is not a PCI device.
>
> The simple-bus is needed to automatically traverse and create platform
> devices in of_platform_populate(). It's true that RP1 is a PCI device,
> but sub-peripherals of RP1 are platform devices so I guess this is
> unavoidable right now.

You are missing the point. A PCI-PCI bridge does not have a
simple-bus. However, I think it's just what you pasted here that's
wrong. From the looks of the RP1 driver and the overlay, it should be
correct.

It would also help if you dumped out what "lspci -tvnn" prints.

> > The assumption so far with all of this is that you have some specific
> > PCI device (and therefore a driver). The simple-buses under it are
> > defined per BAR. Not really certain if that makes sense in all cases,
> > but since the address assignment is dynamic, it may have to. I'm also
> > not completely convinced we should reuse 'simple-bus' here or define
> > something specific like 'pci-bar-bus' or something.
>
> Good point. Labeling a new bus for this kind of 'appliance' could be
> beneficial to unify the dt overlay approach, and I guess it could be
> adopted by the aforementioned Bootlin's Microchip patchset too.
> However, since the difference with simple-bus would be basically non
> existent, I believe that this could be done in a future patch due to
> the fact that the dtbo is contained into the driver itself, so we do
> not suffer from the proliferation that happens when dtb are managed
> outside.

It's an ABI, so we really need to decide first.

> > >                 ranges =3D <0xc0 0x40000000   0x01 0x00 0x00   0x00 0=
x400000>;
> > >                 dma-ranges =3D <0x10 0x00   0x43000000 0x10 0x00   0x=
10 0x00>;
> > >                 ......
> > >         };
> > >  };
> > >
> > > The pci@0,0 bridge node is automatically created by virtue of
> > > CONFIG_PCI_DYNAMIC_OF_NODES, and has no dma-ranges, hence it implies =
1:1 dma
> > > mappings (flags for this mapping are set to zero).  The rp1@0 node ha=
s
> > > dma-ranges with flags set (0x43000000). Since 0x43000000 !=3D 0x00 an=
y translation
> > > will fail.
> >
> > It's possible that we should fill in 'dma-ranges' when making these
> > nodes rather than supporting missing dma-ranges here.
>
> I really think that filling dma-ranges for dynamically created pci
> nodes would be the correct approach.
> However, IMHO this does not imply that we could let inconsistent
> address (64 bit addr with 32 flag bit set) laying around the
> translation chain, and fixing that is currently working fine. I'd
> be then inclined to say the proposed change is outside the scope
> of the present patchset and to postpone it to a future patch.

Okay, but let's fix it with a test case. There's already a test case
for all this in the DT unittest which can be extended.

Rob

