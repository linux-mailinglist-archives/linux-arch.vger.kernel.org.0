Return-Path: <linux-arch+bounces-6617-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8E995ECF2
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2024 11:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9AF3B20EEE
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2024 09:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA2513CA9C;
	Mon, 26 Aug 2024 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gs5VIHMv"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC14813FD66;
	Mon, 26 Aug 2024 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724663929; cv=none; b=lZCQbtFXyLmFUWDg5yMeFeq+HI3sPH6flIahkNt20CDJNK7A92410BEDCiWjeoouh23xABTLQTzL9MvPNvl280xcVWN+rvXK5kkhACBgZs5f9xjTPgJwEsfo2NnNbzKVwznGBawhDG5t00DKdq4dc4koMdazcPeFDH8ZEBu5GC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724663929; c=relaxed/simple;
	bh=8siODDACXT+fimTC/2UB/6V4VeORso2YfO6qi6K2GWM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afs6z3McbWuimXB49jR/TQfR39D/UKvZ2Tr5Jh3DltWkUeAK1RuppSSsw/FiqvGsyUgjxR6DdN3xBQZVSGOT/7edunrCiarxJymc0P6LJtJVQU0nDO6LX3cCjtXYbTTbhMQv9O3LPplnS187QPlmCsZqLQmQUBwFGcU6NlUCE2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gs5VIHMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E4DC4FF01;
	Mon, 26 Aug 2024 09:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724663928;
	bh=8siODDACXT+fimTC/2UB/6V4VeORso2YfO6qi6K2GWM=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=gs5VIHMv8spP85k6bkA+JhcXCek1/3703narVXeBPqZtMt1jtyHyoWE9679L411Oz
	 I8+vkPjwCkJ+oqW7JJHDZ7adTeUNO9w9ZYY9tY7LeQpb7zmz3D3F9NXS7oBHJGmBc0
	 0tF0LtV6MOGtqaXVly3GK+32b34WVP5kT4BwLhcw=
Date: Mon, 26 Aug 2024 11:18:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrea della Porta <andrea.porta@suse.com>,
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
Subject: Re: [PATCH 08/11] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <2024082635-demeanor-yanking-dfc5@gregkh>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <5954e4dccc0e158cf434d2c281ad57120538409b.1724159867.git.andrea.porta@suse.com>
 <2024082420-secluding-rearrange-fcfd@gregkh>
 <ZsxF1ZvsrJbmWzQH@apocalypse>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsxF1ZvsrJbmWzQH@apocalypse>

On Mon, Aug 26, 2024 at 11:07:33AM +0200, Andrea della Porta wrote:
> Hi Greg,
> 
> On 09:53 Sat 24 Aug     , Greg Kroah-Hartman wrote:
> > On Tue, Aug 20, 2024 at 04:36:10PM +0200, Andrea della Porta wrote:
> > > --- a/include/linux/pci_ids.h
> > > +++ b/include/linux/pci_ids.h
> > > @@ -2610,6 +2610,9 @@
> > >  #define PCI_VENDOR_ID_TEKRAM		0x1de1
> > >  #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
> > >  
> > > +#define PCI_VENDOR_ID_RPI		0x1de4
> > > +#define PCI_DEVICE_ID_RP1_C0		0x0001
> > 
> > Minor thing, but please read the top of this file.  As you aren't using
> > these values anywhere outside of this one driver, there's no need to add
> > these values to pci_ids.h.  Just keep them local to the .c file itself.
> >
> 
> Thanks, I've read the top part of that file. The reason I've declared those
> two macroes in pci_ids.h is that I'm using them both in the
> main driver (rp1-pci.c) and in drivers/pci/quirks.c.

Ah, missed that, sorry, nevermind.

greg k-h

