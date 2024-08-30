Return-Path: <linux-arch+bounces-6863-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4AC9668E5
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 20:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB67E2856F8
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 18:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394481BC063;
	Fri, 30 Aug 2024 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZw9zYlB"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01E614C585;
	Fri, 30 Aug 2024 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725042482; cv=none; b=bifIiTyzvQ81x5HsL6Q0pp258ubAlscxi0CBLU1UNxkHSNpOmyB/mhJC3cJg0EGGCbZp+U0G4j99atk376PmqbGVDQUmwi4DQYjql8OYdODF/pryyYymz8NJ4y98MQXtVp+ju6OFqXI3aiT9b9HpRhHG8mqmVuqSljKj7IdYrWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725042482; c=relaxed/simple;
	bh=f5Uc5k5MsEWXT0HDmaPjKPSyz/7E7DKh4+BY1PUsbVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWBioSQNWb6FWj6Xv5X1sAdbTbyjMD/qHT9AjA+jXqVxf18G+YHvQp0k0Tsaz9Rm9IZi+R6OWw9UnmjlBlSOI+/8sXXGDBevXiUc8lkjK5X6jzWl7CIs/BgHYUnE0UehRJ7o/A2OAN6vkf2xrcih7Da1tPUMgzPQ1dWzEzX7Jh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZw9zYlB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77642C4CEC4;
	Fri, 30 Aug 2024 18:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725042481;
	bh=f5Uc5k5MsEWXT0HDmaPjKPSyz/7E7DKh4+BY1PUsbVo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tZw9zYlBB3g5eplwmqwDuXZj66pLzG7m+54tkBkcDUj1oZ68+xI6EdlFYTOrcHQzc
	 5X8AXWsHcPvAr2C5XAbm56EwdXy57n3WnPP5I3SFK4pPrFcY2GlBof6kBPHR19rK2t
	 UHSGAPt1+B/ZYSUOnTnAlgjPWh+VHTVOjtGrZy1Mhpea1jqm+qnuNsb76/G4ACeBdt
	 PDVROZTa5ctZ30DiryM3zkZeZG9FeGri895jfshIvfAEPtxkTCCKE2VcMabMeHKqpO
	 NGMIwjO2SHaFrqc5pzuDyNaD/ORFAMGoBgCRaQaK0OteHQm+krqqpV1+3/ba+RXpc/
	 nHg5W/6dMTgnA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5334c4d6829so2855708e87.2;
        Fri, 30 Aug 2024 11:28:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKM00D8wAxF98/OLZM1pMgT3jUJbid4mC87dmL4ZMIW6TaO28FMV+LwYxvgDxJx6BmPnBQGtWPBdPL@vger.kernel.org, AJvYcCUbclfWQJ1jDVhtC+CtouBNY+rrdb5JCAeiv4t16ZUp5EBNCdqp+vLgKnMLIkmFTv8+eRduXDe7N6ha3d0D@vger.kernel.org, AJvYcCVTwhY5+WgmAbWOSRQdDYEgdChsnHh5vo59HAp9ZJdfV/it6GZpgZu8NzlRXMyevICVUv0M0OlurAUJ@vger.kernel.org, AJvYcCWQrdUp/m+ntbNJFxhXix0POwyFHF55fnYwNBFTFj/XRDEanUkObyshx0GOlt6gFSyUs7H5gZs6KnZL0Q==@vger.kernel.org, AJvYcCWUj3YOEqr+KLSGTm+J3iJG9l15c1hhW/nFj79lXSyzXZ6lp3M5ilktW01F0kiMmi/g90QmqZZcKxT+@vger.kernel.org, AJvYcCX0Wvh5bPaFkcMM3VCrT8LgzNm3Bd1JDau2ie2xDNW00osddV3Bi7a3Ar906ZsDSJlW8prr43ERbEYzSw==@vger.kernel.org, AJvYcCX9cvq+VctDLzp/0rILSKogQy7yqM61yyYEkriJBIjVfbVI7f4kx6Zs13Vq2GLchPtiLn25EQKj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5OVsLE+q1tQET83J3sx03PV/6dDvL27gOJDoCaplDyg1rPA4u
	kcdJO5XLptJnO7hkCmpvSHhiltAw8U/dv2wRMJ+fUplddi5kqV6tFmDOPMHUDPOSMniKjGgR1Q9
	pdQrE7/DQnB3+rT8wHzJ7pBssBw==
X-Google-Smtp-Source: AGHT+IHkKGY89CPI6FFA16aU1d1oJTlBeNFiYnaYKv5/UM42MiQxOpY0Lv8jGLq5OjBzmO9YOzgtvsD8lUsQ5sxBIsk=
X-Received: by 2002:a05:6512:2c92:b0:530:e323:b1cd with SMTP id
 2adb3069b0e04-53546bab46bmr2046490e87.40.1725042479576; Fri, 30 Aug 2024
 11:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724159867.git.andrea.porta@suse.com> <5954e4dccc0e158cf434d2c281ad57120538409b.1724159867.git.andrea.porta@suse.com>
 <98c570cb-c2ca-4816-9ca4-94033f7fb3fb@gmx.net> <ZshZ6yAmyFoiF5qu@apocalypse>
 <015a0dd9-7a13-45b7-971a-19775a6bdd04@gmx.net> <Zsi5fNftL21vqJ3w@apocalypse>
In-Reply-To: <Zsi5fNftL21vqJ3w@apocalypse>
From: Rob Herring <robh@kernel.org>
Date: Fri, 30 Aug 2024 13:27:46 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+XSWEfNF-Dn3paf1io0vxTmfFNbPf7AfRWFf4XiOYkaw@mail.gmail.com>
Message-ID: <CAL_Jsq+XSWEfNF-Dn3paf1io0vxTmfFNbPf7AfRWFf4XiOYkaw@mail.gmail.com>
Subject: Re: [PATCH 08/11] misc: rp1: RaspberryPi RP1 misc driver
To: Stefan Wahren <wahrenst@gmx.net>, Andrea della Porta <andrea.porta@suse.com>
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
	linux-arch@vger.kernel.org, Lee Jones <lee@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 11:31=E2=80=AFAM Andrea della Porta
<andrea.porta@suse.com> wrote:
>
> Hi Stefan,
>
> On 12:23 Fri 23 Aug     , Stefan Wahren wrote:
> > Hi Andrea,
> >
> > Am 23.08.24 um 11:44 schrieb Andrea della Porta:
> > > Hi Stefan,
> > >
> > > On 18:20 Wed 21 Aug     , Stefan Wahren wrote:
> > > > Hi Andrea,
> > > >
> > > > Am 20.08.24 um 16:36 schrieb Andrea della Porta:
> > > > > The RaspberryPi RP1 is ia PCI multi function device containing
> > > > > peripherals ranging from Ethernet to USB controller, I2C, SPI
> > > > > and others.
> > > > sorry, i cannot provide you a code review, but just some comments. =
multi
> > > > function device suggests "mfd" subsystem or at least "soc" . I won'=
t
> > > > recommend misc driver here.
> > > It's true that RP1 can be called an MFD but the reason for not placin=
g
> > > it in mfd subsystem are twofold:
> > >
> > > - these discussions are quite clear about this matter: please see [1]
> > >    and [2]
> > > - the current driver use no mfd API at all
> > >
> > > This RP1 driver is not currently addressing any aspect of ARM core in=
 the
> > > SoC so I would say it should not stay in drivers/soc / either, as als=
o
> > > condifirmed by [2] again and [3] (note that Microchip LAN966x is a ve=
ry
> > > close fit to what we have here on RP1).
> > thanks i was aware of these discussions. A pointer to them or at least =
a
> > short statement in the cover letter would be great.
>
> Sure, consider it done.
>
> > >
> > > > > Implement a bare minimum driver to operate the RP1, leveraging
> > > > > actual OF based driver implementations for the on-borad periphera=
ls
> > > > > by loading a devicetree overlay during driver probe.
> > > > Can you please explain why this should be a DT overlay? The RP1 is
> > > > assembled on the Raspberry Pi 5 PCB. DT overlays are typically for =
loose
> > > > connections like displays or HATs. I think a DTSI just for the RP1 =
would
> > > > fit better and is easier to read.
> > > The dtsi solution you proposed is the one adopted downstream. It has =
its
> > > benefits of course, but there's more.
> > > With the overlay approach we can achieve more generic and agnostic ap=
proach
> > > to managing this chipset, being that it is a PCI endpoint and could b=
e
> > > possibly be reused in other hw implementations. I believe a similar
> > > reasoning could be applied to Bootlin's Microchip LAN966x patchset as
> > > well, and they also choose to approach the dtb overlay.
> > Could please add this point in the commit message. Doesn't introduce
>
> Ack.
>
> > (maintainence) issues in case U-Boot needs a RP1 driver, too?
>
> Good point. Right now u-boot does not support RP1 nor PCIe (which is a
> prerequisite for RP1 to work) on Rpi5 and I'm quite sure that it will be
> so in the near future. Of course I cannot guarantee this will be the case
> far away in time.
>
> Since u-boot is lacking support for RP1 we cannot really produce some tes=
t
> results to check the compatibility versus kernel dtb overlay but we can
> speculate a little bit about it. AFAIK u-boot would probably place the rp=
1
> node directly under its pcie@12000 node in DT while the dtb overlay will =
use
> dynamically created PCI endpoint node (dev@0) as parent for rp1 node.

u-boot could do that and it would not be following the 25+ year old
PCI bus bindings. Some things may be argued about as "Linux bindings",
but that isn't one of them.

Rob

