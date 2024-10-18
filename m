Return-Path: <linux-arch+bounces-8283-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2FC9A49A5
	for <lists+linux-arch@lfdr.de>; Sat, 19 Oct 2024 00:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A16C1F24BA6
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 22:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54528190486;
	Fri, 18 Oct 2024 22:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgTGP/U7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B1218CBF5;
	Fri, 18 Oct 2024 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729290533; cv=none; b=XbVA/gzCiXgedhg0uV8PkR0WG2Y+5fYGb/k674ud9qpG6K9RPJLUQnG47F59tDKR8n9ZRDrOqV/yezC99bGfgoeGA0sLQX99xCVLVyBoZ1ge7qGNQvbdrvETjTJdDnmwSqAS7mram8+EGUnkBwe06V86TQiWHHsOsdcN6zN9Yc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729290533; c=relaxed/simple;
	bh=G7Ash0PGoqdQ1AiafmIA65zN/S2zqb3jjZ3jwkABAmI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=J/h+5MnbWEJ2cEmbXFbc3MLoVuAJGfvQaja0GbOUfVHWmChsxkTb6lBwQeg9g9URq6yLOliakZKlllA2ivEY1IecO7MZjWa06ylCPhkwVfxv7yM8WpIAJY54uaga++uU+JVotcw1FyN2snqnmrXNnW6CspTGOI8qvKfthIavcFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgTGP/U7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83466C4CEC3;
	Fri, 18 Oct 2024 22:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729290532;
	bh=G7Ash0PGoqdQ1AiafmIA65zN/S2zqb3jjZ3jwkABAmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TgTGP/U7RKKcvPPDH/bduN4P+U9gnrm0Owu3NhDvqbrFzpKYGJofveh67iMhF47gx
	 DxVHWjcKgwrn0iaN76NwGiQWk7/xxcY4rQ+L7pp1Nd2Kkk8TtzJo0YFYXbvIMxdEF0
	 J98vlhBXDMn0lJZ7WllGBfhRVDNosEI0FDeDXB/ThdbS9hWCIKjA2foUu2K9he0EGJ
	 S+NQxiL+7x4VLYidgjOMEj9kW0pDFYr1mO2ilHgqV71iwnLywxOWjlcAupEJSfjrS9
	 2j1cm0fzRHFBQBJ78vHz0A0bjwC5hD5OBpJSPRFaKgLnRJcC4ltNXYLLZf1cuA+LuL
	 BJ2cjkBNl6jwg==
Date: Fri, 18 Oct 2024 17:28:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
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
	Stefan Wahren <wahrenst@gmx.net>, Lizhi Hou <lizhi.hou@amd.com>
Subject: Re: [PATCH 03/11] PCI: of_property: Sanitize 32 bit PCI address
 parsed from DT
Message-ID: <20241018222850.GA766393@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxJXZ9R-Qp9CNmJk@apocalypse>

On Fri, Oct 18, 2024 at 02:41:11PM +0200, Andrea della Porta wrote:
> On 20:08 Mon 07 Oct     , Bjorn Helgaas wrote:
> ... 

> > Yes, this is exactly the problem.  The pci@0 parent and child
> > addresses in "ranges" are both in the PCI address space.  But we
> > start with pdev->resource[N], which is a CPU address.  To get the PCI
> > address, we need to apply pci_bus_address().  If the host bridge
> > windows are set up correctly, the window->offset used in
> > pcibios_resource_to_bus() should yield the PCI bus address.
> 
> You mean something like this, I think:
> 
> @@ -129,7 +129,7 @@ static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
>                 if (of_pci_get_addr_flags(&res[j], &flags))
>                         continue;
>  
> -               val64 = res[j].start;
> +               val64 = pci_bus_address(pdev, &res[j] - pdev->resource);
>                 of_pci_set_address(pdev, rp[i].parent_addr, val64, 0, flags,
>                                    false);
>                 if (pci_is_bridge(pdev)) {

Yes.

> > I think it should look like this:
> > 
> >   pci@0: <0x82000000 0x0 0x00000000 0x82000000 0x0 0x00000000 0x0 0x600000>;
> 
> indeed, with the above patch applied, the result is exactly as you expected.
> ...

> > > > But I don't think it works in general because there's no
> > > > requirement that the host bridge address translation be that
> > > > simple.  For example, if we have two host bridges, and we want
> > > > each to have 2GB of 32-bit PCI address space starting at 0x0,
> > > > it might look like this:
> > > > 
> > > >   0x00000002_00000000 -> PCI 0x00000000 (subtract 0x00000002_00000000)
> > > >   0x00000002_80000000 -> PCI 0x00000000 (subtract 0x00000002_80000000)
> > > > 
> > > > In this case simply ignoring the high 32 bits of the CPU
> > > > address isn't the correct translation for the second host
> > > > bridge.  I think we should look at each host bridge's
> > > > "ranges", find the difference between its parent and child
> > > > addresses, and apply the same difference to everything below
> > > > that bridge.
> > > 
> > > Not sure I've got this scenario straight: can you please provide
> > > the topology and the bit setting (32/64 bit) for those ranges?
> > > Also, is this scenario coming from a real use case or is it
> > > hypothetical?
> > 
> > This scenario is purely hypothetical, but it's a legal topology
> > that we should handle correctly.  It's two host bridges, with
> > independent PCI hierarchies below them:
> > 
> >   Host bridge A: [mem 0x2_00000000-0x2_7fffffff window] (bus address 0x00000000-0x7fffffff)
> >   Host bridge B: [mem 0x2_80000000-0x2_ffffffff window] (bus address 0x00000000-0x7fffffff)
> > 
> > Bridge A has an MMIO aperture at CPU addresses
> > 0x2_00000000-0x2_7fffffff, and when it initiates PCI transactions on
> > its secondary side, the PCI address is CPU_addr - 0x2_00000000.
> > 
> > Similarly, bridge B has an MMIO aperture at CPU addresses 
> > 0x2_80000000-0x2_ffffffff, and when it initiates PCI transactions on 
> > its secondary side, the PCI address is CPU_addr - 0x2_80000000.
> > 
> > Both hierarchies use PCI bus addresses in the 0x00000000-0x7fffffff
> > range.  In a topology like this, you can't convert a bus address back
> > to a CPU address unless you know which hierarchy it's in.
> > pcibios_bus_to_resource() takes a pci_bus pointer, which tells you
> > which hierarchy (and which host bridge address translation) to use.
> 
> Agreed. While I think about how to adjust that specific patch,i
> let's drop it from this patchset since the aforementioned change is
> properly fixing the translation issue.

OK.  I assume you mean to drop the "PCI: of_property: Sanitize 32 bit
PCI address parsed from DT" patch?  Or replace it with the
pci_bus_address() addition above?

Bjorn

