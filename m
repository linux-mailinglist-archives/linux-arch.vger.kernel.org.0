Return-Path: <linux-arch+bounces-6969-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAFF96A6D0
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 20:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E061F241D4
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 18:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25320190665;
	Tue,  3 Sep 2024 18:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXiyYpVx"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83A518E030;
	Tue,  3 Sep 2024 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725389226; cv=none; b=bK09cLDVI+RGIFB1UyV5slm5s9POsKdUR0cpUHiUtjShOdnkAbm9mGYevEPnpidJ4MgMlMZ6tT8ffKlH9NzOGshKeFboxmeXuowPydDxa7QY9xRP26EENohZNQkhA4jOiprDEw3USQRnzcjwycbGdmbSqFdhr3yad12dgd1h1G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725389226; c=relaxed/simple;
	bh=nd6Wtvx8pQAMupTyQ6h0Xwk0uJUJcdsSVJ5cX/m07m4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UsD/LvMVgM0di7Y9qzU7ZB7pNMCW1dWXa9/bL08dL/ZbJnuwtKNzYL/ULR7cKR2oUVOcuuTNsZ4uA4EiTFuDHxzd8gu8bfmrTMQHL6TyiUQOaAW9QzANn+ySWdzGrYoc/7ecKm2ZinrchrFmocGrTvXOHTFwf4FI0FDTTJtjR78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXiyYpVx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BABC4CECC;
	Tue,  3 Sep 2024 18:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725389225;
	bh=nd6Wtvx8pQAMupTyQ6h0Xwk0uJUJcdsSVJ5cX/m07m4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TXiyYpVxtIwVZw6k1PFiIFhAbnoHBA0CXi7tGuk5BEvj7s8MeJq8orlX4JMPOAoDe
	 FmCmFzUFDcXAhR+Px8WOsWA5nV7DNGfkFo4Gjm9qgIuGVoGS27RIWZOpppOZoJRtzz
	 RuE9zvO2RoSXWQleP6Nw0Yql7B1KNkBrZtCJDuiYEPto/6W7cNzJ3Zy3AYdIuq+E5v
	 eA1h9TR+Sxxl3O8XGo4orHQ9wJpyQlCGC4oWiZLBZG60/3+SiEjTBtASP1ivFdW6Y4
	 q6xtOAXAmiJQYR3cjIreNu/RO0h5SiBEzbU7tpcLe6BTuvZ0Mz91sCvWe4Z7cmCwli
	 YXWJg5pGAkyXw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5334c4cc17fso8044388e87.2;
        Tue, 03 Sep 2024 11:47:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUC5SrydgVHT/ziGCdYg6WIDCVNVvYSHWXYbD6ME+Iy5nDaBRoNESjcgMHCIAU7+DIrYf0eMSXr+RpD@vger.kernel.org, AJvYcCUTRFMN39NpKl8mXZG0qarIHm2yvoM9TT/ybtzObxXugZj7F8PCDaVZRBQ1mJZCGbp/OLZ3g/Bd@vger.kernel.org, AJvYcCVDMpMVUyvAJGxlVi2KwnRSMFQTGPX9Y4EXS7bG39BSdeUmYUcF++M7vN4YlbFjcm4bZBfNfIRamw2s@vger.kernel.org, AJvYcCVX9JosvuU9GstaPjWMYsMEm+YoDUjsZl84zkvTh7tJ8qEzBC3ZOMAg+VEkSHSvhaUxmEVlLqo9Z+iPNMM6@vger.kernel.org, AJvYcCWl9R46DHctWaHJN9N65qRWwDY9/NmdjuiwC2EB9ajjpMS/8LXizjOwU70/kbdKvSLw1CNsjlfGzvTgvg==@vger.kernel.org, AJvYcCWvvmbJZ+GfDpEqqNa+ntfdJT9+VTXP0kQWU8TLvivgDV7zvI8Cxyza8zNynB8+8WyVFMdWxH10miGL@vger.kernel.org, AJvYcCXhqhKF8uKa6lFpgWpGfED2fUHfMfm8p8fW3na8LEh2YHCeo7WHnbix54ovbzJBRamxhjr30pj5qi1zoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrPFZi7uRk6DYed6Qie+YHe9ds2N6iF+AuKgp6MvsT8qt72yrG
	rXAogyeVlcRhIXI3Gldw5fftVExJEPOrQEkCifsAK/ma24i22Frh5MG7daqbzGS8yakkrroKKCB
	66Tup0PqFNpO+Ue0nez5wT5ttSw==
X-Google-Smtp-Source: AGHT+IFPPQF+VZ9KwhNwRdiTpvXZs2B9iqZYAcu8DtAQ5kIA/StJNR3uCDFdRTvA7hWnuCKoLYPHIEkeiaJO+kFnqP8=
X-Received: by 2002:a05:6512:1244:b0:530:c212:4a5a with SMTP id
 2adb3069b0e04-53546b25966mr12549174e87.22.1725389223674; Tue, 03 Sep 2024
 11:47:03 -0700 (PDT)
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
 <ZtChPt4cD8PzfEkF@apocalypse> <CAL_JsqJNcZx-HH-TJhsNai2fqwPJ+dtcWTdPagRjgqM31wsJkA@mail.gmail.com>
 <Ztc2DadAnxLIYFj-@apocalypse>
In-Reply-To: <Ztc2DadAnxLIYFj-@apocalypse>
From: Rob Herring <robh@kernel.org>
Date: Tue, 3 Sep 2024 13:46:51 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+mpVEDthuViQZ6T7tDQ_krgxYSQ0Qg1pBMNW8Kpr+Qcw@mail.gmail.com>
Message-ID: <CAL_Jsq+mpVEDthuViQZ6T7tDQ_krgxYSQ0Qg1pBMNW8Kpr+Qcw@mail.gmail.com>
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

On Tue, Sep 3, 2024 at 11:15=E2=80=AFAM Andrea della Porta
<andrea.porta@suse.com> wrote:
>
> Hi Rob,
>
> On 14:37 Fri 30 Aug     , Rob Herring wrote:
> > On Thu, Aug 29, 2024 at 11:26=E2=80=AFAM Andrea della Porta
> > <andrea.porta@suse.com> wrote:
> > >
> > > Hi Rob,
> > >
>
> ...
>
> >
> > I think simple-bus where you have it is fine. It is really 1 level up
> > that needs to be specified. Basically something that's referenced from
> > the specific PCI device's schema (e.g. the RP1 schema (which you are
> > missing)).
> >
> > That schema needs to roughly look like this:
> >
> > properties:
> >   "#address-cells":
> >     const: 3
> >   "#size-cells":
> >     const: 2
> >   ranges:
> >     minItems: 1
> >     maxItems: 6
> >     items:
> >       additionalItems: true
> >       items:
> >         - maximum: 5  # The BAR number
> >         - const: 0
> >         - const: 0
> >         - # TODO: valid PCI memory flags
> >
> > patternProperties:
> >   "^bar-bus@[0-5]$":
> >     type: object
> >     additionalProperties: true
> >     properties:
> >       compatible:
> >         const: simple-bus
> >       ranges: true
> >
>
> Hmmm.. not sure how this is going to work. The PCI device (RP1) will
> havei, at runtime, a compatible like this:
>
> compatible =3D "pci1de4,1\0pciclass,0200000\0pciclass,0200";
>
> that is basically generated automatically by the OF framework. So, in the
> schema you proposed above, I can put something like:
>
> properties:
>   compatible:
>     contains:
>       pattern: '^pci1de4,1'

No, it should be like this:

compatible:
  items:
    - const: pci1de4,1
    - const: pciclass,0200000
    - const: pciclass,0200

or

compatible:
  addtionalItems: true
  maxItems: 3
  items:
    - const: pci1de4,1


Alternatively, we could instead only generate 'pciclass' compatibles
for bridge nodes. The reason being that being an ethernet controller
doesn't really tell us anything. There's no standard interface
associated with that class.

> or maybe I could omit the compatible entirely, like in:

No.

> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pc=
i/pci-iommu.yaml

That's not a device node, but just part of pci-host-bridge.yaml.

> that seems to refer to generic compatible values.
> In both cases though, I don't see how these binding could work with
> make dt_binding_check, since there's no compatible known at compile
> time (for the first approach), or no compatible at all (the second
> approach).
> Is it intended only as a loose documentation?

No, schemas define exactly what a binding can and can't contain. But
they are divided into device schemas and common schemas. The latter
are incomplete and are included by the former. Generally, "compatible"
goes in device schemas.

> Or are you proposing that for a future new bus (hence with a new, specifi=
c,
> compatible) that could be described by the schema above?

The above schema would be the common schema included by a RP1 schema,
LAN966x schema, or any other device doing the same thing.
Rob

