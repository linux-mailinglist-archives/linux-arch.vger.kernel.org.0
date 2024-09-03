Return-Path: <linux-arch+bounces-6970-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3D496A6FB
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 20:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47D70B21FD8
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 18:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A3C1925A5;
	Tue,  3 Sep 2024 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TY1AsEXk"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3187918B46F;
	Tue,  3 Sep 2024 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725389749; cv=none; b=cE3byj2G0GbGGJfCT8k6odpq5asWPgr5+FY+oKBlslfabAizYjnhKd0J/v5+oVH98nZn1ZrUvUKHxTR9n83zrVmfsvtgWHSdqTo7gDRsnTHKeDSTV81S3Taqa3LFUuSV8ah70+mu40WCEhr1DEM2XMByhyR8Jc34rlepKwQ8VUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725389749; c=relaxed/simple;
	bh=u5ffMoMb65XU94NnW5iCe+vfXkLdQgdYSfW1a1U36Bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFLLZHyvnmMYdEJPZ/W7KGqODHqjZyVOqy7j7dyPf/BrdecolONG7E28gezNpx5eYN6+iQL/jsIRnowOMTMsTix0mmzv0R9NCxCt4rR7dMS/rGozYaxuCEWz/76ZgtHcZpKZk6Pc0ZcQslGCPanRYTdM1QEIQwmaFHX3XOKSF60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TY1AsEXk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A626DC4CED3;
	Tue,  3 Sep 2024 18:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725389748;
	bh=u5ffMoMb65XU94NnW5iCe+vfXkLdQgdYSfW1a1U36Bw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TY1AsEXk1uxdb9yoKi2eljrDgWuBTwDOxwLe/TCRGn+Ymru0sG3i3LYoAlUK5UiM1
	 KIaX9Zt+BFfAsPnTPtJN0Apjw/olBjhYi5eNHKdINIQ8FQBPUF7q1VNvxfq4BiCVHW
	 oqsbqDt0Bh0Mc1h9n9e/3enO+vi6+OnpjjEJn/j872nBtPVdyfNapRu5VWRiMuz6rK
	 5m2jct1VoMptM4KpmaJZ89UWCPNM7olBPPfF5LLDPm9J0Y9SvQ1MVIfFQcPoVl+bIx
	 kwgcsayyLDaDL8jM4cZTHpQjYdhJ1Ts9f8en7QzbQSWOuPuhpXqgswU/btJdVbtLqt
	 B6Y8bCcFz7/rA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53349ee42a9so7677408e87.3;
        Tue, 03 Sep 2024 11:55:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDPL98z27Fw48wfmhyUGYoiz9sSsvUSAFz1cgYb+1/vatnZsVxTHy0EU30KPz3mq34uLGDL6oEf8S1Jg==@vger.kernel.org, AJvYcCVEHcqbYrRAH1NezR0mURUxCCsKnUBpyak0cyt0C5IBcu88IJLTf7gfWPAMtmC3MZCrN7kwbx+0RHU8QQ==@vger.kernel.org, AJvYcCVTNALne6w5WfWoPKSMMZFzYTBKF/jETvqbBEWlLT7wDOQxeK/xiZkyxTKvn11MRFbj683Z7RzF3Mx2@vger.kernel.org, AJvYcCVh+rWcQv/OwpTU8hVDx9wI5l4uaRRbDWqeVzmbEMAHG8g3lUNrbdnxTKOiGUd1JqYklafGQHPt@vger.kernel.org, AJvYcCWdmimLNT7kgsvY3ckVH0X2Y2BUdc8x4YCiYDJi/s0wKY2MdJ092FY0PQpR1fndJOrGxciEiZ8CUUEQ@vger.kernel.org, AJvYcCWwz6lqmB7GwyUXj5Q8jgU6HBPMrdvKioefQ8jwlIr6NMHWNZW7Sm8x1tGu7Kl94jmpp+irXj9S2Bm/KPqt@vger.kernel.org, AJvYcCXktSdhxXFcgbj0XzE8ZfzVrsPRG3NL42vLMzR92mX5/R7ZMH1nUa+smGdKpHYJbaxVBZpmKcZVj8Jl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1F+Y/DUh386bZbhR7pO24eg7KM/QMbwwBzd51UvoHfr+UbKtX
	zAY4rFD0ggv362WMnOufRzW0u6Pzi0kdBTXTVCL21FW8KmEFoTGKvHgx4LvE6ywTpnp9xzH8LOr
	MqT2yGbUik7HmaXojG+mCnUDmog==
X-Google-Smtp-Source: AGHT+IEar4VU0gcSpL3FtuHtXxmzsckwEOOVlG+eDDj/A+YNDEfdVlDrb7iAt3vqCbbxLtxFlbs6lAhWhdy2+3BOXvI=
X-Received: by 2002:a05:6512:3350:b0:534:543e:1895 with SMTP id
 2adb3069b0e04-53546bab3damr7247604e87.39.1725389746855; Tue, 03 Sep 2024
 11:55:46 -0700 (PDT)
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
 <20240903110953.2b1f55b6@bootlin.com> <ZtbX2NZ6A6ATqQLh@apocalypse>
In-Reply-To: <ZtbX2NZ6A6ATqQLh@apocalypse>
From: Rob Herring <robh@kernel.org>
Date: Tue, 3 Sep 2024 13:55:34 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLfJAaHtccBGAzhQZVNLVdU0HLdLQA=poSaV4H3JVQWCA@mail.gmail.com>
Message-ID: <CAL_JsqLfJAaHtccBGAzhQZVNLVdU0HLdLQA=poSaV4H3JVQWCA@mail.gmail.com>
Subject: Re: [PATCH 04/11] of: address: Preserve the flags portion on 1:1
 dma-ranges mapping
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Herve Codina <herve.codina@bootlin.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
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
	Stefan Wahren <wahrenst@gmx.net>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 4:33=E2=80=AFAM Andrea della Porta <andrea.porta@sus=
e.com> wrote:
>
> Hi Herve,
>
> On 11:09 Tue 03 Sep     , Herve Codina wrote:
> > Hi,
> >
> > On Fri, 30 Aug 2024 14:37:54 -0500
> > Rob Herring <robh@kernel.org> wrote:
> >
> > ...
> >
> > > > this view is much like Bootlin's approach, also my pci-ep-bus node =
now would look
> > > > like this:
> > > >  ...
> > > >  pci-ep-bus@0 {
> > > >         ranges =3D <0xc0 0x40000000
> > > >                   0x01 0x00 0x00000000
> > > >                   0x00 0x00400000>;
> > > >         ...
> > > >  };
> > > >
> > > > and also the correct unit address here is 0 again, since the parent=
 address in
> > > > ranges is 0x01 0x00 0x00000000 (0x01 is the flags and in this case =
represent
> > > > BAR1, I assume that for the unit address I should use only the addr=
ess part that
> > > > is 0, right?).
> > >
> > > No, it should be 1 for BAR1. It's 1 node per BAR.
> >
> > It should be 1 node per BAR but in some cases it is not.
> >
> > Indeed, in the LAN966x case, the pci-ep-bus need to have access to seve=
ral
> > BARs and we have:

Might not be the last time I forget this...

> I second this, on RP1 there are multiple BARs too, but for this minimal
> implementation we need only one. Splitting them in one bus per BAR or
> merging them with multiple ranges entries depend on whether the periphera=
ls
> can access different BARs simultaneously. Besides this contraint, I would
> say both approach are viable.

Okay. You all define what you need as you understand the devices better tha=
n me.


> >       ...
> >       pci-ep-bus@0 {
> >               compatible =3D "simple-bus";
> >               #address-cells =3D <1>;
> >               #size-cells =3D <1>;
> >
> >               /*
> >                * map @0xe2000000 (32MB) to BAR0 (CPU)
> >                * map @0xe0000000 (16MB) to BAR1 (AMBA)
> >                */
> >               ranges =3D <0xe2000000 0x00 0x00 0x00 0x2000000
> >                         0xe0000000 0x01 0x00 0x00 0x1000000>;
> >       ...
> >
> > Some devices under this bus need to use both BARs and use two regs valu=
es
> > in their reg properties to access BAR0 and BAR1.
> >
> >
> > > > > > > The assumption so far with all of this is that you have some =
specific
> > > > > > > PCI device (and therefore a driver). The simple-buses under i=
t are
> > > > > > > defined per BAR. Not really certain if that makes sense in al=
l cases,
> > > > > > > but since the address assignment is dynamic, it may have to. =
I'm also
> > > > > > > not completely convinced we should reuse 'simple-bus' here or=
 define
> > > > > > > something specific like 'pci-bar-bus' or something.
> > > > > >
> > > > > > Good point. Labeling a new bus for this kind of 'appliance' cou=
ld be
> > > > > > beneficial to unify the dt overlay approach, and I guess it cou=
ld be
> > > > > > adopted by the aforementioned Bootlin's Microchip patchset too.
> > > > > > However, since the difference with simple-bus would be basicall=
y non
> > > > > > existent, I believe that this could be done in a future patch d=
ue to
> > > > > > the fact that the dtbo is contained into the driver itself, so =
we do
> > > > > > not suffer from the proliferation that happens when dtb are man=
aged
> > > > > > outside.
> > > > >
> > > > > It's an ABI, so we really need to decide first.
> > > >
> > > > Okay. How should we proceed?
> > >
> > > I think simple-bus where you have it is fine. It is really 1 level up
> > > that needs to be specified. Basically something that's referenced fro=
m
> > > the specific PCI device's schema (e.g. the RP1 schema (which you are
> > > missing)).
> > >
> > > That schema needs to roughly look like this:
> > >
> > > properties:
> > >   "#address-cells":
> > >     const: 3
> > >   "#size-cells":
> > >     const: 2
> > >   ranges:
> > >     minItems: 1
> > >     maxItems: 6
> > >     items:
> > >       additionalItems: true
> > >       items:
> > >         - maximum: 5  # The BAR number
> > >         - const: 0
> > >         - const: 0
> > >         - # TODO: valid PCI memory flags
> > >
> > > patternProperties:
> > >   "^bar-bus@[0-5]$":
> > >     type: object
> > >     additionalProperties: true
> > >     properties:
> > >       compatible:
> > >         const: simple-bus
> > >       ranges: true
> > >
> >
> > IMHO, the node should not have 'bar' in the name.
> > In the LAN966x PCI use case, multiple BARs have to be accessed by devic=
es
> > under this simple-bus. That's why I choose pci-ep-bus for this node nam=
e.
> >
>
> Agreed for your scenario. Anyway, since the dtbo and driver are shipped t=
ogether,
> we are free to change the name anytime without impacting anything.

Indeed, no one should care what the nodename is. However, that doesn't
mean you don't have to define something. Really, just 'bus' should be
enough as node names should only be what class a node is. If it is not
enough, then really you need some sort of compatible to identify the
kind of 'bus'. If you want 'pci-ep-bus', then that's fine.


Rob

