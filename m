Return-Path: <linux-arch+bounces-6635-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 882ED95FBAC
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2024 23:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5961C21C44
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2024 21:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDC519AA4E;
	Mon, 26 Aug 2024 21:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1tKe8/D"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61336190486;
	Mon, 26 Aug 2024 21:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707768; cv=none; b=tWhxci6HMjmSM4far1JRyw92hsemsJSBy0Wl2PArSPQmYJjTSfEwNQDrTmynTdTiE9aW9Gp7WpSfOoCQo0D1hSdNbJUb0bwRf8OiYpN2zUm4z8fAcUckDkl/US73uO8lM97jeRvZMk9rCAHsDEdyUsXkQefWcH63ir2P6wRWf1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707768; c=relaxed/simple;
	bh=sMwLBnAHnDHFUDsE4hXSjXonZ7neyud02000hEpZHok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=BaR/vfbROoMsg6YOsiCaHVMvezC0l2TRjK+M1clDCRNPMSV9HawW1CbvslfOXvwkz6zHm31DG5YNE/8xo6RFoVEo5PPjQRSUxKQdk22/MpxfXldxYZXfIzVClVO4f/IQnnnqwHr5I0BV/h3Tp3YGlFemY+7uVOCQPIkiDvMh8lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1tKe8/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF65C4AF49;
	Mon, 26 Aug 2024 21:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724707768;
	bh=sMwLBnAHnDHFUDsE4hXSjXonZ7neyud02000hEpZHok=;
	h=References:In-Reply-To:From:Date:Subject:To:From;
	b=a1tKe8/DxaBMfpLEoDhX8ydmNs555hd/IiUFN8RLbC8UWtnXfNvRRYFPNHMZ+ADPH
	 xaaSzxvoihOy0Op4wGICHYtjypYxKUOzMmAsS5qU+JewYiNEFi+h2e9sBQL1kJI6rW
	 K3fTX4AFTxe0KnwDeyA1mTIP10gDICfeLMM2vXmIGwh+i0w5t1w0qHqClYpPNzyOuP
	 mqhvxHe7biStMsQ2aIQlJijth2LEEzPlAcbYsFPfrCkUmpzbCTkXPwmSxdRGRZW6R2
	 ymKsP7CSSyA9AmpRJC0XgZimcsc0+JIImAQK29+6Mp6LDG9UvpEhgjZVIrHeLfz6Hc
	 H6w/rRD9sbYLg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-533488ffb03so5877513e87.3;
        Mon, 26 Aug 2024 14:29:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5OmGdWabKWVuDWuauol5Ku9duY+dtx3vhovM+OPYuBWqSrYjZgzoIuMhNUrSWaEbBoJjDk2z0@vger.kernel.org, AJvYcCUTDLbwm0DaLXt3MXQeNEdIXvAQ+Wc5Rnsaya7CNWX0S17wUss7a5GVTBFaXSGqInqdRNYulpky+TUV@vger.kernel.org, AJvYcCV800IMRf+9dEkTqHAlVp9qiIY85sAjskmMlfXvYq9GNGGNsmhDG0R4h7gE4KFZmu4wx61RDg82QGcS@vger.kernel.org, AJvYcCVnt+2gxGZcUvL+COi4TqbxG5FhnNYYRaJRJGD/8OJLPNpm3iknZdKbiwk8YfUle+UPvpqp4xJWg+FonA==@vger.kernel.org, AJvYcCVoQIav99ZqsMrvKKI1fzl7MpYoDvy4ZHxtSXwvHboxJDugUWfSCg53G/A1uAd9/qoe4ipSk4TnHVXVToZd@vger.kernel.org, AJvYcCVx8pi1kaXbcTqb5+jrBPuxIEhQSGOSUfGqUls9ikl1cdgBnG+SIKaPIqaZqFuO1YaUMXgemh6Yu4rb@vger.kernel.org, AJvYcCXSy3hy2qG2SepqPAJb2+7Xm1xQJxrFwmdB4SqUfw8UyOEHZWvrroGCBP4mxT8qw+1MA906IUmPUmFO0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIGexJLUNp1rvAaYLvsd9feTEc9tUzMISghJ6IOUiSYk9UqPxZ
	UNm2cTr1L/TpotAXvUp7z3p71T89qGwKNR2nP1NhxM7QiDhX7VFpr4lF73oPX5rtb6n4dLzNpqI
	0fN8Kxt9D0G1gJ6Uqi+MTrOlMww==
X-Google-Smtp-Source: AGHT+IGNnJi7/hLtGpaYAre1V5DA1twozkqnstJ7ZOwhKpz0uEZ+/dJohODRseefr7XL8AgQAB7tEIruxKs/grv3GSM=
X-Received: by 2002:a05:6512:124d:b0:530:ae4f:337a with SMTP id
 2adb3069b0e04-5343882e123mr7836615e87.3.1724707766156; Mon, 26 Aug 2024
 14:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724159867.git.andrea.porta@suse.com> <5ca13a5b01c6c737f07416be53eb05b32811da21.1724159867.git.andrea.porta@suse.com>
 <20240821001618.GA2309328-robh@kernel.org> <ZsWi86I1KG91fteb@apocalypse>
In-Reply-To: <ZsWi86I1KG91fteb@apocalypse>
From: Rob Herring <robh@kernel.org>
Date: Mon, 26 Aug 2024 16:29:12 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKN0ZNMtq+_dhurwLR+FL2MBOmWujp7uy+5HzXxUb_qDQ@mail.gmail.com>
Message-ID: <CAL_JsqKN0ZNMtq+_dhurwLR+FL2MBOmWujp7uy+5HzXxUb_qDQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] of: address: Preserve the flags portion on 1:1
 dma-ranges mapping
To: Rob Herring <robh@kernel.org>, Andrea della Porta <andrea.porta@suse.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
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

On Wed, Aug 21, 2024 at 3:19=E2=80=AFAM Andrea della Porta
<andrea.porta@suse.com> wrote:
>
> Hi Rob,
>
> On 19:16 Tue 20 Aug     , Rob Herring wrote:
> > On Tue, Aug 20, 2024 at 04:36:06PM +0200, Andrea della Porta wrote:
> > > A missing or empty dma-ranges in a DT node implies a 1:1 mapping for =
dma
> > > translations. In this specific case, rhe current behaviour is to zero=
 out
> >
> > typo
>
> Fixed, thanks!
>
> >
> > > the entire specifier so that the translation could be carried on as a=
n
> > > offset from zero.  This includes address specifier that has flags (e.=
g.
> > > PCI ranges).
> > > Once the flags portion has been zeroed, the translation chain is brok=
en
> > > since the mapping functions will check the upcoming address specifier
> >
> > What does "upcoming address" mean?
>
> Sorry for the confusion, this means "address specifier (with valid flags)=
 fed
> to the translating functions and for which we are looking for a translati=
on".
> While this address has some valid flags set, it will fail the translation=
 step
> since the ranges it is matched against have flags zeroed out by the 1:1 m=
apping
> condition.
>
> >
> > > against mismatching flags, always failing the 1:1 mapping and its ent=
ire
> > > purpose of always succeeding.
> > > Set to zero only the address portion while passing the flags through.
> >
> > Can you point me to what the failing DT looks like. I'm puzzled how
> > things would have worked for anyone.
> >
>
> The following is a simplified and lightly edited) version of the resultin=
g DT
> from RPi5:
>
>  pci@0,0 {
>         #address-cells =3D <0x03>;
>         #size-cells =3D <0x02>;
>         ......
>         device_type =3D "pci";
>         compatible =3D "pci14e4,2712\0pciclass,060400\0pciclass,0604";
>         ranges =3D <0x82000000 0x00 0x00   0x82000000 0x00 0x00   0x00 0x=
600000>;
>         reg =3D <0x00 0x00 0x00   0x00 0x00>;
>
>         ......
>
>         rp1@0 {

What does 0 represent here? There's no 0 address in 'ranges' below.
Since you said the parent is a PCI-PCI bridge, then the unit-address
would have to be the PCI devfn and you are missing 'reg' (or omitted
it).

>                 #address-cells =3D <0x02>;
>                 #size-cells =3D <0x02>;
>                 compatible =3D "simple-bus";

The parent is a PCI-PCI bridge. Child nodes have to be PCI devices and
"simple-bus" is not a PCI device.

The assumption so far with all of this is that you have some specific
PCI device (and therefore a driver). The simple-buses under it are
defined per BAR. Not really certain if that makes sense in all cases,
but since the address assignment is dynamic, it may have to. I'm also
not completely convinced we should reuse 'simple-bus' here or define
something specific like 'pci-bar-bus' or something.

>                 ranges =3D <0xc0 0x40000000   0x01 0x00 0x00   0x00 0x400=
000>;
>                 dma-ranges =3D <0x10 0x00   0x43000000 0x10 0x00   0x10 0=
x00>;
>                 ......
>         };
>  };
>
> The pci@0,0 bridge node is automatically created by virtue of
> CONFIG_PCI_DYNAMIC_OF_NODES, and has no dma-ranges, hence it implies 1:1 =
dma
> mappings (flags for this mapping are set to zero).  The rp1@0 node has
> dma-ranges with flags set (0x43000000). Since 0x43000000 !=3D 0x00 any tr=
anslation
> will fail.

It's possible that we should fill in 'dma-ranges' when making these
nodes rather than supporting missing dma-ranges here.

Rob

