Return-Path: <linux-arch+bounces-6802-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0BC964108
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 12:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8B71F241D6
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 10:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB6418E367;
	Thu, 29 Aug 2024 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EFf9BlrQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CEA18E35C
	for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2024 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926417; cv=none; b=bWVx3XXkBshSaPkHK1cPtXQg9GPZ+UGhdwGTtD73EypUiEePYz5c4vrEbqcaP+5i5EEWBKaCemcQIiDqLOOgSO076rlWM8Bj+fujTuTQwqEYX4IsBp1zQoYnSwuRlModZL+5HJrPRbdnJFDVzRqOywM3NNWOmcy5KUe6PCKaHXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926417; c=relaxed/simple;
	bh=E51GhEQQOg1HwuEGkHFf6XEayoGU7GbLDFfQdiuKKcM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7rqZmIxTRDWbouaHgogxi43FKt9tP+4Bo4+6YqrHr4qTV82xb9k0VZvlDkGnXN8tFWdh7ZrWaUdMVBgkUO2l3qwhktXQ+f77ZfrixXzoKLY3WwlS1iZ71SMZmBU+p06XwG5WsAsvLtaR/hxLSTmxb0iO3aXFzWRNwIOslsgwe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EFf9BlrQ; arc=none smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso4683731fa.2
        for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2024 03:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724926413; x=1725531213; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ly3H9TdfQqHUrvW8I+Z7YT7Eu7iCs1+6axXuLh+lXi0=;
        b=EFf9BlrQc1AUZnb2Cbw3FEzBBokazssTC1Ex7yAljpIy3nR7KRJrXL3Su939n+yhNN
         hMsVwIvLX50OAHopRCnCEYkT6pfKo2Hoo+w0mdNVPBPCKp6O/UGJOCjtQOc1Q3NaOtOr
         8KInLhK0uoGK5DHT9ajX1W5lFPyL2BtVzak0+LnCE0f07wejtC0YtFQcW0jnf/xe7YXP
         pHm1EowrsLN0zdIILGpQocez3TwnkJmHzN0rDHZcS97pOWaHfRT+h1qSLLy52ZLye8AY
         ByQc5PE4YyxPoIZjHot81VqvXr5jSPATj7/wMSn6QGelH7bq5QMABSgR58EWpI1y3byU
         fCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926413; x=1725531213;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ly3H9TdfQqHUrvW8I+Z7YT7Eu7iCs1+6axXuLh+lXi0=;
        b=nyOhHqtuy7k2nMGMR8CVLd4pqX85dZAAk1DB2EsL1OfC2J8DqSSOLPCAFYCJkv0CoB
         YujIMz/F5YecCdKTBwwhx6Z558zO2g4vZVpPgu/qi0iDPAewfMiC7M7biZbO3kCGFfEy
         MiLtWzCoRNnctkVJ9liN5X13c+Z3tQRSYflpwA0ORnhccYWhhp/Yr5ctYOloOxQKZOnj
         sb6SEl58W23wHkGwODTXQgr2xZXuTyD5SzyLq6CFNJF5Ec0CP7MKDOgKbmMPtDDEPXcU
         Z0KYDrFoB02SItv9M+bDmP6B9fcE5lmFpunu+m99WxFmqEjzQUxzMZQVfM7v+oVq0p6L
         31aA==
X-Forwarded-Encrypted: i=1; AJvYcCXR+qNojxrJirdfhhNxCXU5qxBjR1quZR0ZEYoPhKs0r/cNdWgO8g3NivnOLQB5RorAQI+ht+GKPIFC@vger.kernel.org
X-Gm-Message-State: AOJu0YwYnvjTR1ZRI0eUjA8GHL7HvWYzIoLhXf52PBiNWn5e6/aT5tdZ
	SOzAQg0Uy0BHb1yaRK6qS+Mm2zCflACK3l9sVBrqaxMNYYJizWrHPD3Q6GjrlaM=
X-Google-Smtp-Source: AGHT+IHdj0Gax8cLl5ferCv8ike/PKOlbdGFRkbWcfI4fVRlQt52wlkGm5gMUFs+5U5W7ciTlZ/YtA==
X-Received: by 2002:a05:651c:2207:b0:2f0:1f06:2b43 with SMTP id 38308e7fff4ca-2f6108a7771mr19344571fa.41.1724926412637;
        Thu, 29 Aug 2024 03:13:32 -0700 (PDT)
Received: from localhost (host-80-182-198-72.pool80182.interbusiness.it. [80.182.198.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c7c2d0sm524452a12.45.2024.08.29.03.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:13:32 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 29 Aug 2024 12:13:38 +0200
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
	Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 04/11] of: address: Preserve the flags portion on 1:1
 dma-ranges mapping
Message-ID: <ZtBJ0jIq-QrTVs1m@apocalypse>
Mail-Followup-To: Rob Herring <robh@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
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
	Stefan Wahren <wahrenst@gmx.net>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <5ca13a5b01c6c737f07416be53eb05b32811da21.1724159867.git.andrea.porta@suse.com>
 <20240821001618.GA2309328-robh@kernel.org>
 <ZsWi86I1KG91fteb@apocalypse>
 <CAL_JsqKN0ZNMtq+_dhurwLR+FL2MBOmWujp7uy+5HzXxUb_qDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKN0ZNMtq+_dhurwLR+FL2MBOmWujp7uy+5HzXxUb_qDQ@mail.gmail.com>

Hi Rob,

On 16:29 Mon 26 Aug     , Rob Herring wrote:
> On Wed, Aug 21, 2024 at 3:19 AM Andrea della Porta
> <andrea.porta@suse.com> wrote:
> >
> > Hi Rob,
> >
> > On 19:16 Tue 20 Aug     , Rob Herring wrote:
> > > On Tue, Aug 20, 2024 at 04:36:06PM +0200, Andrea della Porta wrote:
> > > > A missing or empty dma-ranges in a DT node implies a 1:1 mapping for dma
> > > > translations. In this specific case, rhe current behaviour is to zero out
> > >
> > > typo
> >
> > Fixed, thanks!
> >
> > >
> > > > the entire specifier so that the translation could be carried on as an
> > > > offset from zero.  This includes address specifier that has flags (e.g.
> > > > PCI ranges).
> > > > Once the flags portion has been zeroed, the translation chain is broken
> > > > since the mapping functions will check the upcoming address specifier
> > >
> > > What does "upcoming address" mean?
> >
> > Sorry for the confusion, this means "address specifier (with valid flags) fed
> > to the translating functions and for which we are looking for a translation".
> > While this address has some valid flags set, it will fail the translation step
> > since the ranges it is matched against have flags zeroed out by the 1:1 mapping
> > condition.
> >
> > >
> > > > against mismatching flags, always failing the 1:1 mapping and its entire
> > > > purpose of always succeeding.
> > > > Set to zero only the address portion while passing the flags through.
> > >
> > > Can you point me to what the failing DT looks like. I'm puzzled how
> > > things would have worked for anyone.
> > >
> >
> > The following is a simplified and lightly edited) version of the resulting DT
> > from RPi5:
> >
> >  pci@0,0 {
> >         #address-cells = <0x03>;
> >         #size-cells = <0x02>;
> >         ......
> >         device_type = "pci";
> >         compatible = "pci14e4,2712\0pciclass,060400\0pciclass,0604";
> >         ranges = <0x82000000 0x00 0x00   0x82000000 0x00 0x00   0x00 0x600000>;
> >         reg = <0x00 0x00 0x00   0x00 0x00>;
> >
> >         ......
> >
> >         rp1@0 {
> 
> What does 0 represent here? There's no 0 address in 'ranges' below.
> Since you said the parent is a PCI-PCI bridge, then the unit-address
> would have to be the PCI devfn and you are missing 'reg' (or omitted
> it).

There's no reg property because the registers for RP1 are addressed
starting at 0x40108000 offset from BAR1. The devicetree specs says
that a missing reg node should not have any unit address specified
(and AFAIK there's no other special directives for simple-bus specified
in dt-bindings). 
I've added @0 just to get rid of the following warning:

 Warning (unit_address_vs_reg): /fragment@0/__overlay__/rp1: node has
 a reg or ranges property, but no unit name 

coming from make W=1 CHECK_DTBS=y broadcom/rp1.dtbo.
This is the exact same approach used by Bootlin patchset from:

https://lore.kernel.org/all/20240808154658.247873-2-herve.codina@bootlin.com/

replied here below for convenience:

+	pci-ep-bus@0 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		/*
+		 * map @0xe2000000 (32MB) to BAR0 (CPU)
+		 * map @0xe0000000 (16MB) to BAR1 (AMBA)
+		 */
+		ranges = <0xe2000000 0x00 0x00 0x00 0x2000000
+		          0xe0000000 0x01 0x00 0x00 0x1000000>;

Also, I think it's not possible to know the devfn in advance, since the
DT part is pre-compiled as an overlay while the devfn number is coming from
bus enumeration.
Since the registers for sub-peripherals will start (as stated in ranges
property) from 0xc040000000, I'd be inclined to use rp1@c040000000 as the
node name and address unit. Is it feasible?

> 
> >                 #address-cells = <0x02>;
> >                 #size-cells = <0x02>;
> >                 compatible = "simple-bus";
> 
> The parent is a PCI-PCI bridge. Child nodes have to be PCI devices and
> "simple-bus" is not a PCI device.

The simple-bus is needed to automatically traverse and create platform
devices in of_platform_populate(). It's true that RP1 is a PCI device,
but sub-peripherals of RP1 are platform devices so I guess this is
unavoidable right now.

> 
> The assumption so far with all of this is that you have some specific
> PCI device (and therefore a driver). The simple-buses under it are
> defined per BAR. Not really certain if that makes sense in all cases,
> but since the address assignment is dynamic, it may have to. I'm also
> not completely convinced we should reuse 'simple-bus' here or define
> something specific like 'pci-bar-bus' or something.

Good point. Labeling a new bus for this kind of 'appliance' could be
beneficial to unify the dt overlay approach, and I guess it could be
adopted by the aforementioned Bootlin's Microchip patchset too.
However, since the difference with simple-bus would be basically non
existent, I believe that this could be done in a future patch due to
the fact that the dtbo is contained into the driver itself, so we do
not suffer from the proliferation that happens when dtb are managed
outside.

> 
> >                 ranges = <0xc0 0x40000000   0x01 0x00 0x00   0x00 0x400000>;
> >                 dma-ranges = <0x10 0x00   0x43000000 0x10 0x00   0x10 0x00>;
> >                 ......
> >         };
> >  };
> >
> > The pci@0,0 bridge node is automatically created by virtue of
> > CONFIG_PCI_DYNAMIC_OF_NODES, and has no dma-ranges, hence it implies 1:1 dma
> > mappings (flags for this mapping are set to zero).  The rp1@0 node has
> > dma-ranges with flags set (0x43000000). Since 0x43000000 != 0x00 any translation
> > will fail.
> 
> It's possible that we should fill in 'dma-ranges' when making these
> nodes rather than supporting missing dma-ranges here.

I really think that filling dma-ranges for dynamically created pci
nodes would be the correct approach.
However, IMHO this does not imply that we could let inconsistent
address (64 bit addr with 32 flag bit set) laying around the 
translation chain, and fixing that is currently working fine. I'd
be then inclined to say the proposed change is outside the scope
of the present patchset and to postpone it to a future patch.

Many thanks,
Andrea

> 
> Rob

