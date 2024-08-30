Return-Path: <linux-arch+bounces-6864-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44829669F2
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 21:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5FF8B23EFB
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 19:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3197D1BD00B;
	Fri, 30 Aug 2024 19:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUf62G7d"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C781BBBED;
	Fri, 30 Aug 2024 19:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725046690; cv=none; b=spmwg4IyksKWdCVeWvKXI4n7yI0NL6ECrJoS7GxJJDxXuq2TrLnUZWUh5cc+SLWBsy598hXpfzI0u+mHhLa+QJYJSNOKWf4i01DuzTIUjwh5SfcSx5k07pWezlG8S2YJvxvUQ4cKe/r6wn0rvHzpsK/Vzd0yvY0BSi3y+CHbYpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725046690; c=relaxed/simple;
	bh=5hAJRTthiQF77Yay/l9F/lcQybtv67Ekj2nTEvkHfLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9pTXAR78wUzM0aHqwHwhpjKfDzzZ7mx7pGbeVvfGwfWr+Y7MDwBwMTmkyKBW2PkY5GcI/Ikuxb9RfS111M7Tub9tlEOTiFrAVky4HUOTA6fvgx3whs5wA6z9bmTa1auww+tGP4K699mmg9NiBQStseCV1poMhMCE88z/n5FbU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUf62G7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DC0C4CECE;
	Fri, 30 Aug 2024 19:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725046689;
	bh=5hAJRTthiQF77Yay/l9F/lcQybtv67Ekj2nTEvkHfLU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aUf62G7dbMOGbCt9O7L/pDXs/q4a6a/N0zy2qMVeEBQGTYmVaQ/d9jnMz7HaVUIOZ
	 /Rutirae0mJrJXRZhMRtAKd7fbvixRdlT51/X6kRg4G7NskXDCwG+lfZ6xEKk8WPLK
	 cJz1/FpD5eixHlBN54zWPpw0IOtksi2F11z1JvNblBfu3pW/6Vb1SX2vt+lhfMryhl
	 +nVl1CRyg+ERGzYLPqvUZXLc6MC9yFkSoLdHPqToKln9OQHmQT+3mvA84oA2RAZ7vn
	 tVn6oSoHvmqlqxmXlBHrex9LGWWwa+zMLUiorg0/GS1JGv3tbZoOzp+nMOnnvOJpo8
	 V+1ImLg77P+5Q==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-533496017f8so2961975e87.0;
        Fri, 30 Aug 2024 12:38:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU427Op03ObETAM0W9HsSuOsYrg6M3R5c29myMJsqiBjpChHuMmm7JbQXFLvwLRjJo2Pp/Gm8g8/HPN@vger.kernel.org, AJvYcCUEZ/XGAZsVtln4bUVhRZqdhfW64hfNBzB0zS0PMwPuDtSMZqOibT8ER6LdceyN1aD9M+jnkaEa@vger.kernel.org, AJvYcCVCzUZURO6hx3+y0faxSFKq8WxTRqHla2Xq1UOfRpjWDKwKBZzYacENG+TYYuZ/ew0GuB3gxfdY+Lj+Mw==@vger.kernel.org, AJvYcCVcqYkvNcLofDJhy893Eylo8Wg2pOW6PU1uCMQLhMPhTWBoSYceNV3vYoyodjZDwdCEOIv9RTik3Ahqpw==@vger.kernel.org, AJvYcCVp6wrw6VSTj2qRB2COLon4qGTFIuMCoWZeeTs2GKREZjFeSzmxORe7LbQyKfWYfMhPHTNpnybQ9g0Y@vger.kernel.org, AJvYcCW4GOWkZPPmSRYaYMAzjPfSSO9uxvaNbnOOVgBJgRackm8qKldGRutMfHYF0W3KwTkobAkPn3LLEtR9@vger.kernel.org, AJvYcCWwKYTn/SeP4y5GmPHoFgmDMf3xVZvf7IweHdu0P23hY6KyYG6RAvxcSd+GGSPXDSP61NUCGLStMOsaR2ax@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ykicUGSHYAWwae6NEYsix48ymwK6xwBv+059Xwbg87GhGqAE
	280gNmnkMvnw8kDL0lTo/TtJ0w5cj1emmHsALMkgMkJ7L6ZiWvcQ4WEsxuDOjHw701C9IZ8Wtb6
	HwrrBKoTEHSV0ouyrAIgbjh8gYg==
X-Google-Smtp-Source: AGHT+IFQQ12zDTWeSsHTIZYvWM42AtEjZumuGayoJvrMyHXgqJPJ28JaAcf1mNQk78g1hcRRVazssGdbikLwaSZN1no=
X-Received: by 2002:a05:6512:3d8e:b0:52e:9cc7:4461 with SMTP id
 2adb3069b0e04-53546af504bmr1997692e87.5.1725046687593; Fri, 30 Aug 2024
 12:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724159867.git.andrea.porta@suse.com> <5ca13a5b01c6c737f07416be53eb05b32811da21.1724159867.git.andrea.porta@suse.com>
 <20240821001618.GA2309328-robh@kernel.org> <ZsWi86I1KG91fteb@apocalypse>
 <CAL_JsqKN0ZNMtq+_dhurwLR+FL2MBOmWujp7uy+5HzXxUb_qDQ@mail.gmail.com>
 <ZtBJ0jIq-QrTVs1m@apocalypse> <CAL_Jsq+_-m3cjTRsFZ0RwVpot3Pdcr1GWt-qiiFC8kQvsmV7VQ@mail.gmail.com>
 <ZtChPt4cD8PzfEkF@apocalypse>
In-Reply-To: <ZtChPt4cD8PzfEkF@apocalypse>
From: Rob Herring <robh@kernel.org>
Date: Fri, 30 Aug 2024 14:37:54 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJNcZx-HH-TJhsNai2fqwPJ+dtcWTdPagRjgqM31wsJkA@mail.gmail.com>
Message-ID: <CAL_JsqJNcZx-HH-TJhsNai2fqwPJ+dtcWTdPagRjgqM31wsJkA@mail.gmail.com>
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
	Stefan Wahren <wahrenst@gmx.net>, Herve Codina <herve.codina@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 11:26=E2=80=AFAM Andrea della Porta
<andrea.porta@suse.com> wrote:
>
> Hi Rob,
>
> On 08:18 Thu 29 Aug     , Rob Herring wrote:
> > On Thu, Aug 29, 2024 at 5:13=E2=80=AFAM Andrea della Porta
> > <andrea.porta@suse.com> wrote:
> > >
> > > Hi Rob,
> >
> > BTW, I noticed your email replies set "reply-to" to everyone in To and
> > Cc. The result (with Gmail) is my reply lists everyone twice (in both
> > To and Cc). "reply-to" is just supposed to be the 1 address you want
> > replies sent to instead of the "from" address.
>
> IIUC you're probably referring to Mail-Reply-To, that address only one re=
cipient
> at a time (i.e. you want to reply only to the author). Reply-To is a catc=
h-all
> that will work as a fallback when you hit either reply or reply-all in yo=
ur client.
> In fact, neither Reply-To nor Mail-Reply-To are included in my emails, th=
e
> interesting one being Mail-Followup-To, that should override any of the a=
bove
> mentioned headers (including To: and Cc:) for the reply all function. How=
 these
> headers are interpreted depends solely on the mail client, I'm afraid.
> Is it possible that your client is mistakenly merging both Mail-Followup-=
To
> plus To and Cc lists?

Indeed, the UI displays 'reply-to' but the source shows
Mail-Followup-To which I'd never heard of. From reading up on it, I
agree the client, Gmail web interface, handles it incorrectly. Not
really anything I can do to fix Gmail though...

> Anyway, I've disabled Mail-followup-To as it's added by mutt, can you ple=
ase
> confirm that this mail now works for you? Hopefully it will not clobber t=
he
> recipent list too much, since AFAIK that header was purposely invented to=
 avoid
> such inconsistencies.

Seems fine now.

My brief read of the header is it is to avoid receiving multiple
copies depending if you are subscribed to a list or not. But listing
out every other address except your own seems like an odd way to
implement "omit From" in replies. You're still going to get N copies
from N lists as well. I guess it made some sense to some people...

> > > On 16:29 Mon 26 Aug     , Rob Herring wrote:
> > > > On Wed, Aug 21, 2024 at 3:19=E2=80=AFAM Andrea della Porta
> > > > <andrea.porta@suse.com> wrote:
> > > > >
> > > > > Hi Rob,
> > > > >
> > > > > On 19:16 Tue 20 Aug     , Rob Herring wrote:
> > > > > > On Tue, Aug 20, 2024 at 04:36:06PM +0200, Andrea della Porta wr=
ote:
> > > > > > > A missing or empty dma-ranges in a DT node implies a 1:1 mapp=
ing for dma
> > > > > > > translations. In this specific case, rhe current behaviour is=
 to zero out
> > > > > >
> > > > > > typo
> > > > >
> > > > > Fixed, thanks!
> > > > >
> > > > > >
> > > > > > > the entire specifier so that the translation could be carried=
 on as an
> > > > > > > offset from zero.  This includes address specifier that has f=
lags (e.g.
> > > > > > > PCI ranges).
> > > > > > > Once the flags portion has been zeroed, the translation chain=
 is broken
> > > > > > > since the mapping functions will check the upcoming address s=
pecifier
> > > > > >
> > > > > > What does "upcoming address" mean?
> > > > >
> > > > > Sorry for the confusion, this means "address specifier (with vali=
d flags) fed
> > > > > to the translating functions and for which we are looking for a t=
ranslation".
> > > > > While this address has some valid flags set, it will fail the tra=
nslation step
> > > > > since the ranges it is matched against have flags zeroed out by t=
he 1:1 mapping
> > > > > condition.
> > > > >
> > > > > >
> > > > > > > against mismatching flags, always failing the 1:1 mapping and=
 its entire
> > > > > > > purpose of always succeeding.
> > > > > > > Set to zero only the address portion while passing the flags =
through.
> > > > > >
> > > > > > Can you point me to what the failing DT looks like. I'm puzzled=
 how
> > > > > > things would have worked for anyone.
> > > > > >
> > > > >
> > > > > The following is a simplified and lightly edited) version of the =
resulting DT
> > > > > from RPi5:
> > > > >
> > > > >  pci@0,0 {
> > > > >         #address-cells =3D <0x03>;
> > > > >         #size-cells =3D <0x02>;
> > > > >         ......
> > > > >         device_type =3D "pci";
> > > > >         compatible =3D "pci14e4,2712\0pciclass,060400\0pciclass,0=
604";
> > > > >         ranges =3D <0x82000000 0x00 0x00   0x82000000 0x00 0x00  =
 0x00 0x600000>;
> > > > >         reg =3D <0x00 0x00 0x00   0x00 0x00>;
> > > > >
> > > > >         ......
> > > > >
> > > > >         rp1@0 {
> > > >
> > > > What does 0 represent here? There's no 0 address in 'ranges' below.
> > > > Since you said the parent is a PCI-PCI bridge, then the unit-addres=
s
> > > > would have to be the PCI devfn and you are missing 'reg' (or omitte=
d
> > > > it).
> > >
> > > There's no reg property because the registers for RP1 are addressed
> > > starting at 0x40108000 offset from BAR1. The devicetree specs says
> > > that a missing reg node should not have any unit address specified
> > > (and AFAIK there's no other special directives for simple-bus specifi=
ed
> > > in dt-bindings).
> > > I've added @0 just to get rid of the following warning:
> > >
> > >  Warning (unit_address_vs_reg): /fragment@0/__overlay__/rp1: node has
> > >  a reg or ranges property, but no unit name
> >
> > It's still wrong as dtc only checks the unit-address is correct in a
> > few cases with known bus types.
>
> Sorry, I don't follow you on this, I'm probably missing something. Could
> you please add some details?

dtc only checks unit-address matches reg/ranges for simple-bus, pci,
i2c, and spi. Since this case is none of them, there is no warning and
it is left to reviewers to check. The warnings are often a clue
something is wrong and the easy fix is often not the right one. This
is still an area the tooling needs improvements on.

> >
> > > coming from make W=3D1 CHECK_DTBS=3Dy broadcom/rp1.dtbo.
> > > This is the exact same approach used by Bootlin patchset from:
> > >
> > > https://lore.kernel.org/all/20240808154658.247873-2-herve.codina@boot=
lin.com/
> >
> > It is not. First, that has a node for the PCI device (i.e. the
> > LAN966x). You do not. You only have a PCI-PCI bridge and that is
> > wrong.
>
> I'm a little confused now, but I think the confusion is generated by
> the label node names I've chosen that are, admittedly, a bit sloppy.
> I'll try to make some clarity, please see below.
>
> >
> > BTW, you should Cc Herve and others that are working on this feature.
> > It is by no means fully sorted as you have found.
>
> Sure, just added, thanks for the heads up.
>
> >
> > > replied here below for convenience:
> > >
> > > +       pci-ep-bus@0 {
> > > +               compatible =3D "simple-bus";
> > > +               #address-cells =3D <1>;
> > > +               #size-cells =3D <1>;
> > > +
> > > +               /*
> > > +                * map @0xe2000000 (32MB) to BAR0 (CPU)
> > > +                * map @0xe0000000 (16MB) to BAR1 (AMBA)
> > > +                */
> > > +               ranges =3D <0xe2000000 0x00 0x00 0x00 0x2000000
> >
> > The 0 parent address here matches the unit-address, so all good in this=
 case.
>
> Just to be sure, the parent address being the triple zeros in the ranges =
property,
> right?

Yes.

>
> >
> > > +                         0xe0000000 0x01 0x00 0x00 0x1000000>;
> > >
> > > Also, I think it's not possible to know the devfn in advance, since t=
he
> > > DT part is pre-compiled as an overlay while the devfn number is comin=
g from
> > > bus enumeration.
> >
> > No. devfn is fixed unless you are plugging in a card in different
> > slots. The bus number is the part that is not known and assigned by
> > the OS, but you'll notice that is omitted.
> >
> > In any case, the RP1 node should be generated, so its devfn is irreleva=
nt.
>
> Which is a possibility, since the driver should possibly work also with R=
P1
> mounted on a PCI card, one day. But as you pointed out, since this is aut=
omatically
> generated, should not be a concern.
>
> >
> > > Since the registers for sub-peripherals will start (as stated in rang=
es
> > > property) from 0xc040000000, I'd be inclined to use rp1@c040000000 as=
 the
> > > node name and address unit. Is it feasible?
> >
> > Yes, but that would be in nodes underneath ranges. Above, it is the
> > parent bus we are talking about.
>
> Right.
>
> >
> > > > >                 #address-cells =3D <0x02>;
> > > > >                 #size-cells =3D <0x02>;
> > > > >                 compatible =3D "simple-bus";
> > > >
> > > > The parent is a PCI-PCI bridge. Child nodes have to be PCI devices =
and
> > > > "simple-bus" is not a PCI device.
> > >
> > > The simple-bus is needed to automatically traverse and create platfor=
m
> > > devices in of_platform_populate(). It's true that RP1 is a PCI device=
,
> > > but sub-peripherals of RP1 are platform devices so I guess this is
> > > unavoidable right now.
> >
> > You are missing the point. A PCI-PCI bridge does not have a
> > simple-bus. However, I think it's just what you pasted here that's
> > wrong. From the looks of the RP1 driver and the overlay, it should be
> > correct.
>
> Trying to clarify: at first I thought of my rp1 node (in the dtso) as the=
 pci
> endpoint device, but I now see that it should be intended as just the bus
> attached to the real endpoint device (which is the dynamically generated =
dev@0,0).
> In this sense, rp1 is probably a really wrong name, let's say we use the =
same
> name from Bootlin, i.e. pci-ep-bus. The DT tree would then be:
>
> pci@0,0         <- auto generated, this represent the pci bridge

Or root port specifically.

>   dev@0,0       <- auto generated, this represent the pci ednpoint device=
, a.k.a. the RP1
>     pci-ep-bus  <- added from dtbo, this is the simple-bus to which perip=
herals are attached
>
> this view is much like Bootlin's approach, also my pci-ep-bus node now wo=
uld look
> like this:
>  ...
>  pci-ep-bus@0 {
>         ranges =3D <0xc0 0x40000000
>                   0x01 0x00 0x00000000
>                   0x00 0x00400000>;
>         ...
>  };
>
> and also the correct unit address here is 0 again, since the parent addre=
ss in
> ranges is 0x01 0x00 0x00000000 (0x01 is the flags and in this case repres=
ent
> BAR1, I assume that for the unit address I should use only the address pa=
rt that
> is 0, right?).

No, it should be 1 for BAR1. It's 1 node per BAR.

>
> >
> > It would also help if you dumped out what "lspci -tvnn" prints.
> >
>
> Here it is:
>
> localhost:~ # lspci -tvnn
> -[0002:00]---00.0-[01]----00.0  Raspberry Pi Ltd RP1 PCIe 2.0 South Bridg=
e [1de4:0001]

Right, so that matches what you now have above.

> > > > The assumption so far with all of this is that you have some specif=
ic
> > > > PCI device (and therefore a driver). The simple-buses under it are
> > > > defined per BAR. Not really certain if that makes sense in all case=
s,
> > > > but since the address assignment is dynamic, it may have to. I'm al=
so
> > > > not completely convinced we should reuse 'simple-bus' here or defin=
e
> > > > something specific like 'pci-bar-bus' or something.
> > >
> > > Good point. Labeling a new bus for this kind of 'appliance' could be
> > > beneficial to unify the dt overlay approach, and I guess it could be
> > > adopted by the aforementioned Bootlin's Microchip patchset too.
> > > However, since the difference with simple-bus would be basically non
> > > existent, I believe that this could be done in a future patch due to
> > > the fact that the dtbo is contained into the driver itself, so we do
> > > not suffer from the proliferation that happens when dtb are managed
> > > outside.
> >
> > It's an ABI, so we really need to decide first.
>
> Okay. How should we proceed?

I think simple-bus where you have it is fine. It is really 1 level up
that needs to be specified. Basically something that's referenced from
the specific PCI device's schema (e.g. the RP1 schema (which you are
missing)).

That schema needs to roughly look like this:

properties:
  "#address-cells":
    const: 3
  "#size-cells":
    const: 2
  ranges:
    minItems: 1
    maxItems: 6
    items:
      additionalItems: true
      items:
        - maximum: 5  # The BAR number
        - const: 0
        - const: 0
        - # TODO: valid PCI memory flags

patternProperties:
  "^bar-bus@[0-5]$":
    type: object
    additionalProperties: true
    properties:
      compatible:
        const: simple-bus
      ranges: true

There were some discussions around interrupt handling that might also
factor into this.

Rob

