Return-Path: <linux-arch+bounces-6976-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C27C996AC30
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 00:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2677DB2413C
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 22:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4261D5888;
	Tue,  3 Sep 2024 22:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZn4TZXV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5E51EBFE4;
	Tue,  3 Sep 2024 22:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725402406; cv=none; b=nDLxfs5UW/Qeh6He6KB0MfPwPE/grdeGGxDR469836Ph5SgumU4hoAfGwWtwNIUiRVMsk5Pg8SiAL0SyAljToD++j8XLm1LHmMbnYmYjFIgsok8ddRUnkgKoZKji4ICjPc7+bspNSnIForNeZKgGyPakq/1B4+KI7VxE/InvPM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725402406; c=relaxed/simple;
	bh=YXQIagdDPc90ZbJET9jNpaM1MPJKmJ5Y5fngYc6zZ5E=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VZMM6QfOdfOIsPgcFMIvR2Co69DR7Vwe9M2ZEKtZZ6911mC8xz9L4Hl6YD6H7dv+Je6L9OfqOa1ZE4MtzfXdRAzUeYBwUmlHv08Bru2sfpZq77UfYVbB/QVYjrrDWC9kFf02JsvFpcfQcj60PoXPtwU5KMExDBb2qHgOT07xXiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZn4TZXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE497C4CEC4;
	Tue,  3 Sep 2024 22:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725402406;
	bh=YXQIagdDPc90ZbJET9jNpaM1MPJKmJ5Y5fngYc6zZ5E=;
	h=Date:From:To:Subject:In-Reply-To:From;
	b=dZn4TZXVbXEzEwa3ibet6GkytN3NXh0+F+/hWh7n22CyMZmwuMO1drbR6aDqPSH/m
	 1onS+XmaNIzxiX4h1AD6FfLhQyYnaF2/AgM8LQSsl2aVq3kh1VZZBtMEcyN3NWmoV7
	 WlGawzRAr97kNfsueOFPzVcWLHcCL9fx1uyE4BVpWiZCD3Br+lCJ4EnLT86dFuTSFv
	 RNtwJ1gX9LNZsCrEFoRM1ff4GhTGAT9H3wladciEnJy5WJx+dAMD0kSmMMoulZg4hk
	 aulQSWoX0q7ifdHNpRfXx5NwOgTa64bW7nZm0ZcA6mpu5hGiXwivszhbdpATg3smEr
	 PHbM0Q+6gtxrw==
Date: Tue, 3 Sep 2024 17:26:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
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
Subject: Re: [PATCH 03/11] PCI: of_property: Sanitize 32 bit PCI address
 parsed from DT
Message-ID: <20240903222644.GA126427@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zszcps6bnCcdFa54@apocalypse>

On Mon, Aug 26, 2024 at 09:51:02PM +0200, Andrea della Porta wrote:
> On 10:24 Wed 21 Aug     , Bjorn Helgaas wrote:
> > On Tue, Aug 20, 2024 at 04:36:05PM +0200, Andrea della Porta wrote:
> > > The of_pci_set_address() function parses devicetree PCI range
> > > specifier assuming the address is 'sanitized' at the origin,
> > > i.e. without checking whether the incoming address is 32 or 64
> > > bit has specified in the flags.  In this way an address with no
> > > OF_PCI_ADDR_SPACE_MEM64 set in the flags could leak through and
> > > the upper 32 bits of the address will be set too, and this
> > > violates the PCI specs stating that in 32 bit address the upper
> > > bit should be zero.

> > I don't understand this code, so I'm probably missing something.  It
> > looks like the interesting path here is:
> > 
> >   of_pci_prop_ranges
> >     res = &pdev->resource[...];
> >     for (j = 0; j < num; j++) {
> >       val64 = res[j].start;
> >       of_pci_set_address(..., val64, 0, flags, false);
> >  +      if (OF_PCI_ADDR_SPACE_MEM64)
> >  +        prop[1] = upper_32_bits(val64);
> >  +      else
> >  +        prop[1] = 0;
> > 
> > OF_PCI_ADDR_SPACE_MEM64 tells us about the size of the PCI bus
> > address, but the address (val64) is a CPU physical address, not a PCI
> > bus address, so I don't understand why of_pci_set_address() should use
> > OF_PCI_ADDR_SPACE_MEM64 to clear part of the CPU address.
> 
> It all starts from of_pci_prop_ranges(), that is the caller of
> of_pci_set_address().

> val64 (i.e. res[j].start) is the address part of a struct resource
> that has its own flags.  Those flags are directly translated to
> of_pci_range flags by of_pci_get_addr_flags(), so any
> IORESOURCE_MEM_64 / IORESOURCE_MEM in the resource flag will
> respectively become OF_PCI_ADDR_SPACE_MEM64 /
> OF_PCI_ADDR_SPACE_MEM32 in pci range.

> What is advertised as 32 bit at the origin (val64) should not become
> a 64 bit PCI address at the output of of_pci_set_address(), so the
> upper 32 bit portion should be dropped. 

> This is explicitly stated in [1] (see page 5), where a space code of 0b10
> implies that the upper 32 bit of the address must be zeroed out.

OK, I was confused and thought IORESOURCE_MEM_64 was telling us
something about the *CPU* address, but it's actually telling us
something about what *PCI bus* addresses are possible, i.e., whether
it's a 32-bit BAR or a 64-bit BAR.

However, the CPU physical address space and the PCI bus address are
not the same.  Generic code paths should account for that different by
applying an offset (the offset will be zero on many platforms where
CPU and PCI bus addresses *look* the same).

So a generic code path like of_pci_prop_ranges() that basically copies
a CPU physical address to a PCI bus address looks broken to me.

Maybe my expectation of this being described in DT is mistaken.

Bjorn

