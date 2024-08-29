Return-Path: <linux-arch+bounces-6813-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC03964BA7
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 18:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7E81C22C86
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 16:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45561B5302;
	Thu, 29 Aug 2024 16:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Uzt6An6g"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381011B4C41
	for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2024 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948796; cv=none; b=uTxKnclQ8p6NXn640aOWeX2brAgCQwIwkCkYm1fDMNGXcZyqK3vzFebu0jI0rDWz/WnsCVTcyLlbgm/IjUlMUL9+Tznu880feNwe3RTXemrIqjgiLsUzwTDAZ6hQVKAo6abLdEU1VjEbAvpjLxwPpqufOmv6+IFB/GEldDtahig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948796; c=relaxed/simple;
	bh=wSMdYTDqsWlQtbEdlbCGxNPCwqGfc+W3ysTZG1vl+OQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uk6fsxcJrHqoO0j7scqT6SMNh62/T3CU4vjPCmDuogUnNfiavMRFfohVZHz8BWURaL2B7geHykGyCGgsEZW8qGvJ8NE9iU6/CteV1kToCk6DnwDaAiwZyD7ypZohDdGw6WY6scWW5PQuOvR+C5abwZTQrwKfVxKJaKv3kdOZjj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Uzt6An6g; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5befd2f35bfso915771a12.2
        for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2024 09:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724948792; x=1725553592; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KAvkMSrr0+E1+zBJdqJA8C79vOak/KYTC8lNAgyE4gY=;
        b=Uzt6An6gBIvN5jPZ7Ou5DG93I5TQ6WK/NbjscB4fbSKzW6qYhXxgiVVgogJ/x4oP7p
         6VmahSFm6j9L9ejkaUuGWlTuSdjS2bI5zccDeWpLU0fvNVuKWWSYkP8dLTLcswiaJC4h
         OJ4ywXg75Jkr9IFyb4ZiMrZ/DwJ//NVB/Ib1dtTOrzOKxY9wUpMGHNoZBO7FTssUrZkE
         B4U7ywuU0anUNNdemgt0F75DZyqTHOSmfFIOwTbtf3pPafVVtqnQIlwlA05bvjVAL7w+
         y3KIFZNi4+lbJkmdtzsymNb/ZJZ1Lzp9KgOX0ZR61md4o9hdIJOAdy1q9l6cKzmtXYMd
         njog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724948792; x=1725553592;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KAvkMSrr0+E1+zBJdqJA8C79vOak/KYTC8lNAgyE4gY=;
        b=CVNaHOiks7dHMwKnRXCGDHhHc5hOKELxthB9IFWyvZXeuPmxuiTCWQqvHKFj4er33h
         5XXCCr65j0GJZeex5pIAeCImKMaFAOtBeLxUzGgHGrdSjMM9LJZIIfORgT8aOF5SVxAY
         jZpx7sxpqxah5qtS3ot8+WeqHE8AbClvDqQ5CtYmrSh3CZ+P9lhwjB+5U5D07a9wRhLs
         3upzlhn+OByWhoLLx/lhSxTYvYeN6pQrQHEMww7HR45N4BBbkKZvr2Txx3/aKQ/Byn8r
         se7jkHuh0Mwmx7XQEtPAbSy9klF6vV6xkmKSJVWy94xtpzIfjN2TFiE3c8lALcgAPHp1
         ssrw==
X-Forwarded-Encrypted: i=1; AJvYcCXqZ5dCWKocmeZ07CCvXE5yAHMB5qlZwyk0icFJtt774Ya13fz6VEzoipNaNVVMBOU8E208LVnNOK3w@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo2BF2TYH3DJwrrcQMOrZ+NK7EWO5isK5ALBt3R3OkUYNdq0n3
	Dmg/OltNsXTWsqbRgk7R3BMWlxJ24LlR+LC+UEor7whPuqoTlIjPjN+8B7eTkkk=
X-Google-Smtp-Source: AGHT+IEyrUorcYaQDgmA8P7OeuK7+S76r1iJ4LhiWcyAFpkkq9s+nW06xAxw2EESujKhpFv3Xbz3ZA==
X-Received: by 2002:a17:906:f5a6:b0:a86:9644:2a60 with SMTP id a640c23a62f3a-a897f78928amr287181666b.6.1724948791972;
        Thu, 29 Aug 2024 09:26:31 -0700 (PDT)
Received: from localhost (host-80-182-198-72.retail.telecomitalia.it. [80.182.198.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989021f3bsm96587466b.85.2024.08.29.09.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 09:26:31 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 29 Aug 2024 18:26:38 +0200
To: Rob Herring <robh@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
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
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 04/11] of: address: Preserve the flags portion on 1:1
 dma-ranges mapping
Message-ID: <ZtChPt4cD8PzfEkF@apocalypse>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <5ca13a5b01c6c737f07416be53eb05b32811da21.1724159867.git.andrea.porta@suse.com>
 <20240821001618.GA2309328-robh@kernel.org>
 <ZsWi86I1KG91fteb@apocalypse>
 <CAL_JsqKN0ZNMtq+_dhurwLR+FL2MBOmWujp7uy+5HzXxUb_qDQ@mail.gmail.com>
 <ZtBJ0jIq-QrTVs1m@apocalypse>
 <CAL_Jsq+_-m3cjTRsFZ0RwVpot3Pdcr1GWt-qiiFC8kQvsmV7VQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+_-m3cjTRsFZ0RwVpot3Pdcr1GWt-qiiFC8kQvsmV7VQ@mail.gmail.com>

Hi Rob,

On 08:18 Thu 29 Aug     , Rob Herring wrote:
> On Thu, Aug 29, 2024 at 5:13 AM Andrea della Porta
> <andrea.porta@suse.com> wrote:
> >
> > Hi Rob,
> 
> BTW, I noticed your email replies set "reply-to" to everyone in To and
> Cc. The result (with Gmail) is my reply lists everyone twice (in both
> To and Cc). "reply-to" is just supposed to be the 1 address you want
> replies sent to instead of the "from" address.

IIUC you're probably referring to Mail-Reply-To, that address only one recipient
at a time (i.e. you want to reply only to the author). Reply-To is a catch-all
that will work as a fallback when you hit either reply or reply-all in your client.
In fact, neither Reply-To nor Mail-Reply-To are included in my emails, the
interesting one being Mail-Followup-To, that should override any of the above
mentioned headers (including To: and Cc:) for the reply all function. How these
headers are interpreted depends solely on the mail client, I'm afraid.
Is it possible that your client is mistakenly merging both Mail-Followup-To 
plus To and Cc lists?
Anyway, I've disabled Mail-followup-To as it's added by mutt, can you please
confirm that this mail now works for you? Hopefully it will not clobber the
recipent list too much, since AFAIK that header was purposely invented to avoid
such inconsistencies.

> 
> > On 16:29 Mon 26 Aug     , Rob Herring wrote:
> > > On Wed, Aug 21, 2024 at 3:19 AM Andrea della Porta
> > > <andrea.porta@suse.com> wrote:
> > > >
> > > > Hi Rob,
> > > >
> > > > On 19:16 Tue 20 Aug     , Rob Herring wrote:
> > > > > On Tue, Aug 20, 2024 at 04:36:06PM +0200, Andrea della Porta wrote:
> > > > > > A missing or empty dma-ranges in a DT node implies a 1:1 mapping for dma
> > > > > > translations. In this specific case, rhe current behaviour is to zero out
> > > > >
> > > > > typo
> > > >
> > > > Fixed, thanks!
> > > >
> > > > >
> > > > > > the entire specifier so that the translation could be carried on as an
> > > > > > offset from zero.  This includes address specifier that has flags (e.g.
> > > > > > PCI ranges).
> > > > > > Once the flags portion has been zeroed, the translation chain is broken
> > > > > > since the mapping functions will check the upcoming address specifier
> > > > >
> > > > > What does "upcoming address" mean?
> > > >
> > > > Sorry for the confusion, this means "address specifier (with valid flags) fed
> > > > to the translating functions and for which we are looking for a translation".
> > > > While this address has some valid flags set, it will fail the translation step
> > > > since the ranges it is matched against have flags zeroed out by the 1:1 mapping
> > > > condition.
> > > >
> > > > >
> > > > > > against mismatching flags, always failing the 1:1 mapping and its entire
> > > > > > purpose of always succeeding.
> > > > > > Set to zero only the address portion while passing the flags through.
> > > > >
> > > > > Can you point me to what the failing DT looks like. I'm puzzled how
> > > > > things would have worked for anyone.
> > > > >
> > > >
> > > > The following is a simplified and lightly edited) version of the resulting DT
> > > > from RPi5:
> > > >
> > > >  pci@0,0 {
> > > >         #address-cells = <0x03>;
> > > >         #size-cells = <0x02>;
> > > >         ......
> > > >         device_type = "pci";
> > > >         compatible = "pci14e4,2712\0pciclass,060400\0pciclass,0604";
> > > >         ranges = <0x82000000 0x00 0x00   0x82000000 0x00 0x00   0x00 0x600000>;
> > > >         reg = <0x00 0x00 0x00   0x00 0x00>;
> > > >
> > > >         ......
> > > >
> > > >         rp1@0 {
> > >
> > > What does 0 represent here? There's no 0 address in 'ranges' below.
> > > Since you said the parent is a PCI-PCI bridge, then the unit-address
> > > would have to be the PCI devfn and you are missing 'reg' (or omitted
> > > it).
> >
> > There's no reg property because the registers for RP1 are addressed
> > starting at 0x40108000 offset from BAR1. The devicetree specs says
> > that a missing reg node should not have any unit address specified
> > (and AFAIK there's no other special directives for simple-bus specified
> > in dt-bindings).
> > I've added @0 just to get rid of the following warning:
> >
> >  Warning (unit_address_vs_reg): /fragment@0/__overlay__/rp1: node has
> >  a reg or ranges property, but no unit name
> 
> It's still wrong as dtc only checks the unit-address is correct in a
> few cases with known bus types.

Sorry, I don't follow you on this, I'm probably missing something. Could
you please add some details?

> 
> > coming from make W=1 CHECK_DTBS=y broadcom/rp1.dtbo.
> > This is the exact same approach used by Bootlin patchset from:
> >
> > https://lore.kernel.org/all/20240808154658.247873-2-herve.codina@bootlin.com/
> 
> It is not. First, that has a node for the PCI device (i.e. the
> LAN966x). You do not. You only have a PCI-PCI bridge and that is
> wrong.

I'm a little confused now, but I think the confusion is generated by
the label node names I've chosen that are, admittedly, a bit sloppy.
I'll try to make some clarity, please see below.

> 
> BTW, you should Cc Herve and others that are working on this feature.
> It is by no means fully sorted as you have found.

Sure, just added, thanks for the heads up.

> 
> > replied here below for convenience:
> >
> > +       pci-ep-bus@0 {
> > +               compatible = "simple-bus";
> > +               #address-cells = <1>;
> > +               #size-cells = <1>;
> > +
> > +               /*
> > +                * map @0xe2000000 (32MB) to BAR0 (CPU)
> > +                * map @0xe0000000 (16MB) to BAR1 (AMBA)
> > +                */
> > +               ranges = <0xe2000000 0x00 0x00 0x00 0x2000000
> 
> The 0 parent address here matches the unit-address, so all good in this case.

Just to be sure, the parent address being the triple zeros in the ranges property,
right?

> 
> > +                         0xe0000000 0x01 0x00 0x00 0x1000000>;
> >
> > Also, I think it's not possible to know the devfn in advance, since the
> > DT part is pre-compiled as an overlay while the devfn number is coming from
> > bus enumeration.
> 
> No. devfn is fixed unless you are plugging in a card in different
> slots. The bus number is the part that is not known and assigned by
> the OS, but you'll notice that is omitted.
> 
> In any case, the RP1 node should be generated, so its devfn is irrelevant.

Which is a possibility, since the driver should possibly work also with RP1
mounted on a PCI card, one day. But as you pointed out, since this is automatically
generated, should not be a concern.

> 
> > Since the registers for sub-peripherals will start (as stated in ranges
> > property) from 0xc040000000, I'd be inclined to use rp1@c040000000 as the
> > node name and address unit. Is it feasible?
> 
> Yes, but that would be in nodes underneath ranges. Above, it is the
> parent bus we are talking about.

Right.

> 
> > > >                 #address-cells = <0x02>;
> > > >                 #size-cells = <0x02>;
> > > >                 compatible = "simple-bus";
> > >
> > > The parent is a PCI-PCI bridge. Child nodes have to be PCI devices and
> > > "simple-bus" is not a PCI device.
> >
> > The simple-bus is needed to automatically traverse and create platform
> > devices in of_platform_populate(). It's true that RP1 is a PCI device,
> > but sub-peripherals of RP1 are platform devices so I guess this is
> > unavoidable right now.
> 
> You are missing the point. A PCI-PCI bridge does not have a
> simple-bus. However, I think it's just what you pasted here that's
> wrong. From the looks of the RP1 driver and the overlay, it should be
> correct.

Trying to clarify: at first I thought of my rp1 node (in the dtso) as the pci
endpoint device, but I now see that it should be intended as just the bus 
attached to the real endpoint device (which is the dynamically generated dev@0,0).
In this sense, rp1 is probably a really wrong name, let's say we use the same 
name from Bootlin, i.e. pci-ep-bus. The DT tree would then be:

pci@0,0         <- auto generated, this represent the pci bridge
  dev@0,0       <- auto generated, this represent the pci ednpoint device, a.k.a. the RP1
    pci-ep-bus  <- added from dtbo, this is the simple-bus to which peripherals are attached

this view is much like Bootlin's approach, also my pci-ep-bus node now would look
like this:
 ...
 pci-ep-bus@0 {
	ranges = <0xc0 0x40000000
                  0x01 0x00 0x00000000
                  0x00 0x00400000>;
	...
 };

and also the correct unit address here is 0 again, since the parent address in
ranges is 0x01 0x00 0x00000000 (0x01 is the flags and in this case represent
BAR1, I assume that for the unit address I should use only the address part that
is 0, right?).

> 
> It would also help if you dumped out what "lspci -tvnn" prints.
> 

Here it is:

localhost:~ # lspci -tvnn
-[0002:00]---00.0-[01]----00.0  Raspberry Pi Ltd RP1 PCIe 2.0 South Bridge [1de4:0001]

> > > The assumption so far with all of this is that you have some specific
> > > PCI device (and therefore a driver). The simple-buses under it are
> > > defined per BAR. Not really certain if that makes sense in all cases,
> > > but since the address assignment is dynamic, it may have to. I'm also
> > > not completely convinced we should reuse 'simple-bus' here or define
> > > something specific like 'pci-bar-bus' or something.
> >
> > Good point. Labeling a new bus for this kind of 'appliance' could be
> > beneficial to unify the dt overlay approach, and I guess it could be
> > adopted by the aforementioned Bootlin's Microchip patchset too.
> > However, since the difference with simple-bus would be basically non
> > existent, I believe that this could be done in a future patch due to
> > the fact that the dtbo is contained into the driver itself, so we do
> > not suffer from the proliferation that happens when dtb are managed
> > outside.
> 
> It's an ABI, so we really need to decide first.

Okay. How should we proceed?

> 
> > > >                 ranges = <0xc0 0x40000000   0x01 0x00 0x00   0x00 0x400000>;
> > > >                 dma-ranges = <0x10 0x00   0x43000000 0x10 0x00   0x10 0x00>;
> > > >                 ......
> > > >         };
> > > >  };
> > > >
> > > > The pci@0,0 bridge node is automatically created by virtue of
> > > > CONFIG_PCI_DYNAMIC_OF_NODES, and has no dma-ranges, hence it implies 1:1 dma
> > > > mappings (flags for this mapping are set to zero).  The rp1@0 node has
> > > > dma-ranges with flags set (0x43000000). Since 0x43000000 != 0x00 any translation
> > > > will fail.
> > >
> > > It's possible that we should fill in 'dma-ranges' when making these
> > > nodes rather than supporting missing dma-ranges here.
> >
> > I really think that filling dma-ranges for dynamically created pci
> > nodes would be the correct approach.
> > However, IMHO this does not imply that we could let inconsistent
> > address (64 bit addr with 32 flag bit set) laying around the
> > translation chain, and fixing that is currently working fine. I'd
> > be then inclined to say the proposed change is outside the scope
> > of the present patchset and to postpone it to a future patch.
> 
> Okay, but let's fix it with a test case. There's already a test case
> for all this in the DT unittest which can be extended.

I'm taking a look at the unittest framework right now.

Many thanks,
Andrea

> 
> Rob

