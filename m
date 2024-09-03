Return-Path: <linux-arch+bounces-6941-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00262969858
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 11:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251DD1C2355C
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 09:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA3B19F421;
	Tue,  3 Sep 2024 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YLjxJgQe"
X-Original-To: linux-arch@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B901C7669;
	Tue,  3 Sep 2024 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354602; cv=none; b=rgJMiBdxklZWQncA9XlKadGNfXzMHKYpMF1fZG4QPlDC36v3HxJ/osgkH2D8ElO03zMse9REjYFm3eWVCHBIUQjOcPvNBu84J5sNHwrQj306Z1gkfYQR/JYWpLF3NVq4YCdVbmsZPzldOJnewT2T5FuC9Dcg9RMSiluZY1cgAaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354602; c=relaxed/simple;
	bh=/tKo89+mcPizvF1Zm1NC+9oGmbQZWFYGqvMBFGbBTr0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IqZ+FedI0Gzha7IgierK3iz7wWs5n+d1wGtQ3PmnTvwF2vGna11SmxmOYKfG7O1m4k2tjCYjdfF11dE0nR4cs13frJl9DlBogO7Q6PMy1bMxYOma60+vyXaFSyDe10VPKhaYTBxEZQ6fX9Ob30oQgqaSuZv5TDdrVipXtWWrdds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YLjxJgQe; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C13424000B;
	Tue,  3 Sep 2024 09:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725354597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7LttFW8rTrdCnShZkP1nFG0SbHb65v/96Px6RosbpqQ=;
	b=YLjxJgQeUItsVJ9gFA+6szbHMMcy/jFztLjUTtOdnTE1kJJ1YNpr5SWSmSzrQ0Fcor3gGz
	8UO1UWSm2NNGYm+PEtn65EfyIIl8iL8anFMsQ9vGc8MRsVuZ4Cyak/fSmlA/R2uLfCjrlM
	XV9M2ZBOonlf+tO2sq2fJH7BtgFCKOgfePeGYqVoKJWChjb6MCbFLuJYCgbfq5/VL32JIG
	9co31FIV9mpNOR7bRqHir+gL6DLowcQyXHkn1phPVoBTQVnidadKcHuyPSdJ4LM/gO013j
	1E2uC57WvRuf0xJig2u1sfnT4uLMBRKvZZ9Ujr+I2eqYvrf50qlmXpWBKmodyw==
Date: Tue, 3 Sep 2024 11:09:53 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Linus Walleij
 <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>, Dragan
 Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Saravana Kannan <saravanak@google.com>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Lee Jones
 <lee@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Stefan Wahren
 <wahrenst@gmx.net>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 04/11] of: address: Preserve the flags portion on 1:1
 dma-ranges mapping
Message-ID: <20240903110953.2b1f55b6@bootlin.com>
In-Reply-To: <CAL_JsqJNcZx-HH-TJhsNai2fqwPJ+dtcWTdPagRjgqM31wsJkA@mail.gmail.com>
References: <cover.1724159867.git.andrea.porta@suse.com>
	<5ca13a5b01c6c737f07416be53eb05b32811da21.1724159867.git.andrea.porta@suse.com>
	<20240821001618.GA2309328-robh@kernel.org>
	<ZsWi86I1KG91fteb@apocalypse>
	<CAL_JsqKN0ZNMtq+_dhurwLR+FL2MBOmWujp7uy+5HzXxUb_qDQ@mail.gmail.com>
	<ZtBJ0jIq-QrTVs1m@apocalypse>
	<CAL_Jsq+_-m3cjTRsFZ0RwVpot3Pdcr1GWt-qiiFC8kQvsmV7VQ@mail.gmail.com>
	<ZtChPt4cD8PzfEkF@apocalypse>
	<CAL_JsqJNcZx-HH-TJhsNai2fqwPJ+dtcWTdPagRjgqM31wsJkA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi,

On Fri, 30 Aug 2024 14:37:54 -0500
Rob Herring <robh@kernel.org> wrote:

...

> > this view is much like Bootlin's approach, also my pci-ep-bus node now would look
> > like this:
> >  ...
> >  pci-ep-bus@0 {
> >         ranges = <0xc0 0x40000000
> >                   0x01 0x00 0x00000000
> >                   0x00 0x00400000>;
> >         ...
> >  };
> >
> > and also the correct unit address here is 0 again, since the parent address in
> > ranges is 0x01 0x00 0x00000000 (0x01 is the flags and in this case represent
> > BAR1, I assume that for the unit address I should use only the address part that
> > is 0, right?).  
> 
> No, it should be 1 for BAR1. It's 1 node per BAR.

It should be 1 node per BAR but in some cases it is not.

Indeed, in the LAN966x case, the pci-ep-bus need to have access to several
BARs and we have:
	...
	pci-ep-bus@0 {
		compatible = "simple-bus";
		#address-cells = <1>;
		#size-cells = <1>;

		/*
		 * map @0xe2000000 (32MB) to BAR0 (CPU)
		 * map @0xe0000000 (16MB) to BAR1 (AMBA)
		 */
		ranges = <0xe2000000 0x00 0x00 0x00 0x2000000
		          0xe0000000 0x01 0x00 0x00 0x1000000>;
	...

Some devices under this bus need to use both BARs and use two regs values
in their reg properties to access BAR0 and BAR1.


> > > > > The assumption so far with all of this is that you have some specific
> > > > > PCI device (and therefore a driver). The simple-buses under it are
> > > > > defined per BAR. Not really certain if that makes sense in all cases,
> > > > > but since the address assignment is dynamic, it may have to. I'm also
> > > > > not completely convinced we should reuse 'simple-bus' here or define
> > > > > something specific like 'pci-bar-bus' or something.  
> > > >
> > > > Good point. Labeling a new bus for this kind of 'appliance' could be
> > > > beneficial to unify the dt overlay approach, and I guess it could be
> > > > adopted by the aforementioned Bootlin's Microchip patchset too.
> > > > However, since the difference with simple-bus would be basically non
> > > > existent, I believe that this could be done in a future patch due to
> > > > the fact that the dtbo is contained into the driver itself, so we do
> > > > not suffer from the proliferation that happens when dtb are managed
> > > > outside.  
> > >
> > > It's an ABI, so we really need to decide first.  
> >
> > Okay. How should we proceed?  
> 
> I think simple-bus where you have it is fine. It is really 1 level up
> that needs to be specified. Basically something that's referenced from
> the specific PCI device's schema (e.g. the RP1 schema (which you are
> missing)).
> 
> That schema needs to roughly look like this:
> 
> properties:
>   "#address-cells":
>     const: 3
>   "#size-cells":
>     const: 2
>   ranges:
>     minItems: 1
>     maxItems: 6
>     items:
>       additionalItems: true
>       items:
>         - maximum: 5  # The BAR number
>         - const: 0
>         - const: 0
>         - # TODO: valid PCI memory flags
> 
> patternProperties:
>   "^bar-bus@[0-5]$":
>     type: object
>     additionalProperties: true
>     properties:
>       compatible:
>         const: simple-bus
>       ranges: true
> 

IMHO, the node should not have 'bar' in the name.
In the LAN966x PCI use case, multiple BARs have to be accessed by devices
under this simple-bus. That's why I choose pci-ep-bus for this node name.

Best regards,
Hervé

