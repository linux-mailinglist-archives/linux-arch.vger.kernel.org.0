Return-Path: <linux-arch+bounces-7793-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2633993BFF
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 03:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55CDE1F226FA
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 01:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F67B669;
	Tue,  8 Oct 2024 01:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRrydWrd"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644FBEC4;
	Tue,  8 Oct 2024 01:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728349691; cv=none; b=RUSIPjGgnPRqVKhwmNp31LuvNB8Tw2Xw9HPlW697ZXVNpQuNx04n7U24vBc+hanUnjp1X0gperQJI6E7xlURotuRV66/Gl3B4OBZ6S8nH24BnBqdCdDWLMhI9OjIWnHGVTIZpzfywjjxrFLmBYabMoso5muc2QK6UqkrCr+H0bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728349691; c=relaxed/simple;
	bh=J2Nr7fmMyEWoumwX5k+h1Kr1J+Kf7NiK9qAvLzlafdc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rlMWvzYpOm8fFEw0p+96q9rTappsFRJt8P8xgeLHiUGN/P6+CA4k4386V4TtSvWHM664qX5jk/a8NB7k8ux4XOW0Fu8zvnpWq5NUhYkUELmr4THR6roG/+gGuy7kz/dkMTs4BqStIekJHF9ymkSEOOARBEBjPsrVSO1eYqb4wGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRrydWrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB77C4CEC6;
	Tue,  8 Oct 2024 01:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728349690;
	bh=J2Nr7fmMyEWoumwX5k+h1Kr1J+Kf7NiK9qAvLzlafdc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WRrydWrd9YlGa0Z9P9TQSoFVXleerZO60E+YHAoNCW8Q/AGUAjPGbimrmTOWoYn5k
	 e5KqW+0NHhe8dwrJ9e5N/Tw8M3l6yht5X7nUb2mxLwHbRNWuJqLxSJlAdero7XxAGt
	 I0xpQ0ff0kfuipQH69xT+xb36IvFCvGSrdXpI6SfirF1G1xa38xDpZJsCtzXuOOXb+
	 9GD9imdhYkNjhrWH9Eo5TpRiwoz0KmEIftWTxUAC+VOhrwwYIe0/vzZ/KiaEaqf4jP
	 CMueLYvV13VPtaFCjAC+8LNrCbLs6MT6dRJpwzcb0DbGhmNOvEm5SVN8r7gcHhNTt6
	 xvFHxjyv10PAw==
Date: Mon, 7 Oct 2024 20:08:08 -0500
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
Message-ID: <20241008010808.GA455773@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwJyk9XouLfd24VG@apocalypse>

On Sun, Oct 06, 2024 at 01:20:51PM +0200, Andrea della Porta wrote:
> On 15:17 Sat 28 Sep, Bjorn Helgaas wrote:
> ...
> > From your earlier email
> > (https://lore.kernel.org/r/Zszcps6bnCcdFa54@apocalypse):
> > 
> > > Without this patch the range translation chain is broken, like this:
> > 
> > > pcie@120000: <0x2000000 0x00 0x00    0x1f 0x00                0x00 0xfffffffc>;
> > > ~~~ chain breaks here ~~~
> > > pci@0      : <0x82000000 0x1f 0x00   0x82000000 0x1f 0x00     0x00 0x600000>;
> > > dev@0,0    : <0x01 0x00 0x00         0x82010000 0x1f 0x00     0x00 0x400000>;
> > > rp1@0      : <0xc0 0x40000000        0x01 0x00 0x00           0x00 0x400000>;
> > 
> > The cover letter said "RP1 is an MFD chipset that acts as a
> > south-bridge PCIe endpoint .. the RP1 as an endpoint itself is
> > discoverable via usual PCI enumeration".
> > 
> > I assume pcie@120000 is the PCI host bridge and is already in the
> > original DT describing the platform.  I assume pci@0 is a Root Port
> > and dev@0,0 is the RP1 Endpoint, and the existing code already adds
> > them as they are enumerated when pci_bus_add_device() calls
> > of_pci_make_dev_node(), and I think this series adds the rp1@0
> > description.
> 
> Correct.
> 
> > And the "ranges" properties are built when of_pci_make_dev_node()
> > eventually calls of_pci_prop_ranges().  With reference to sec 2.2.1.1
> > of https://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf
> > and
> > https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#ranges,
> > I *think* your example says:
> > 
> > pcie@120000 has:
> >   child phys.hi       0x02000000    n=0 p=0 t=0 ss=10b
> >   child phys.mid,lo   0x00000000_00000000
> >   parent phys.hi,lo   0x0000001f_00000000
> >   length hi,lo        0x00000000_fffffffc
> > 
> > which would make it a bridge where the child (PCI) address space is
> > relocatable non-prefetchable 32-bit memory space at
> > 0x00000000-0xfffffffc, and the corresponding parent address space is
> > 0x1f_00000000-0x1f_fffffffc.  That means the host bridge applies an
> > address translation of "child_addr = parent_addr - 0x1f_00000000".
> > 
> > pci@0 has:
> >   child phys.hi       0x82000000    n=1 p=0 t=0 ss=10b
> >   child phys.mid,lo   0x0000001f_00000000
> >   parent phys.hi      0x82000000    n=1 p=0 t=0 ss=10b
> >   parent phys.mid,lo  0x0000001f_00000000
> >   length hi,lo        0x00000000_00600000
> > 
> > which would make it a PCI-to-PCI bridge (I assume a PCIe Root Port),
> > where the child (secondary bus) address space is the non-relocatable
> > non-prefetchable 32-bit memory space 0x1f_00000000-0x1f_005fffff and
> > the parent (primary bus) address space is also non-relocatable
> > non-prefetchable 32-bit memory space at 0x1f_00000000-0x1f_005fffff.
> > 
> > This looks wrong to me because the pci@0 parent address space
> > (0x1f_00000000-0x1f_005fffff) should be inside the pcie@120000 child
> > address space (0x00000000-0xfffffffc), but it's not.
> 
> Exactly, that example refers to the 'uncorrected' case, i.e. without the
> patch applied.
> 
> > IIUC, this patch clears the upper 32 bits in the pci@0 parent address
> > space.  That would make things work correctly in this case because
> > that happens to be the exact translation of pcie@120000, so it results
> > in pci@0 parent address space of 0x00000000-0x005fffff.
> 
> Right. I think we should split it into two issues:
> 
> [1] RP1 acknowledges a 32 bit BAR address from its config space while the
> device must be accessed using a 64 bit address (that is cpu address
> 0x1f_00000000), which sounds strange to me but I guess that is how
> the hw interconnect has been designed, so we need to cope with it.

It's common that PCI bus addresses are identical to CPU physical
addresses, but by no means universal.  More details in
Documentation/core-api/dma-api-howto.rst

> [2] I still think that the of_pci_set_address() function should be amended
> to avoid generating invalid 64 address when 32 bit flag is set.
> 
> As you noted, fixing [2] will incidentally also let [1] work: I think
> we can try to solve [1] the proper way and maybe defer [2] for a separate
> patch.
> To solve [1] I've dropped this patch and tried to solve it from devicetree,
> modifying the following mapping:
> 
> pcie@120000: <0x3000000 0x1f 0x00    0x1f 0x00                0x00 0xfffffffc>;
> 
> so we now have a 1:1 64 bit mapping from 0x1f_00000000 to 0x1f_00000000.

That's the wrong thing to change.  pcie@120000 is fine; it's pci@0
that's incorrect.

pcie@120000 is the host bridge, and its "ranges" must describe the
address translation it performs between the primary (CPU) side and the
secondary (PCI) side.  Either this offset is built into the hardware
and can't be changed, or the offset is configured by firmware and the
DT has to match.

So I think this description is correct:

  pcie@120000: <0x2000000 0x0 0x00000000 0x1f 0x00000000 0x0 0xfffffffc>;

which means we have an aperture from CPU physical addresses to PCI bus
addresses like this:

  Host bridge: [mem 0x1f_00000000-0x1f_fffffffb window] (bus address 0x00000000-0xfffffffb)

> I thought it would result in something like this:
> 
> pcie@120000: <0x3000000 0x1f 0x00    0x1f 0x00                0x00 0xfffffffc>;
> pci@0      : <0x82000000 0x1f 0x00   0x82000000 0x1f 0x00     0x00 0x600000>;
> dev@0,0    : <0x01 0x00 0x00         0x82010000 0x1f 0x00     0x00 0x400000>;
> rp1@0      : <0xc0 0x40000000        0x01 0x00 0x00           0x00 0x400000>;
> 
> but it fails instead (err: "can't assign; no space") in pci_assign_resource()
> function trying to match the size using pci_clip_resource_to_region(). It turned
> out that the clipping is done against 32 bit memory region 'pci_32_bit',and
> this is failing because the original region addresses to be clipped wxxiereas 64
> bit wide. The 'culprit' seems to be the function devm_of_pci_get_host_bridge_resources()
> dropping IORESOURCE_MEM_64 on any memory resource, which seems to be a change
> somewhat specific to a RK3399 case (see commit 3bd6b8271ee66), but I'm not sure
> whether it can be considered generic.

I think the problem is that we're building the pci@0 (Root Port)
"ranges" incorrectly.  pci@0 is a PCI-PCI bridge, which cannot do any
address translation, so its parent and child address spaces must both
be inside the pcie@120000 *child* address space.

> Also, while taking a look at the resulting devicetree, I'm a bit confused by the
> fact that the parent address generated by of_pci_prop_ranges() for the pci@0,0
> bridge seems to be taken from the parent address of the pcie@120000 node. Shouldn't
> it be taken from the child address of pcie@120000, instead?

Yes, this is exactly the problem.  The pci@0 parent and child
addresses in "ranges" are both in the PCI address space.  But we
start with pdev->resource[N], which is a CPU address.  To get the PCI
address, we need to apply pci_bus_address().  If the host bridge
windows are set up correctly, the window->offset used in
pcibios_resource_to_bus() should yield the PCI bus address.

I think it should look like this:

  pci@0: <0x82000000 0x0 0x00000000 0x82000000 0x0 0x00000000 0x0 0x600000>;

By default lspci shows you the CPU addresses for BARs, so you should
see something like this:

  00:02.0 PCI bridge
    Memory behind bridge: 1f00000000-1ffffffffb
    Capabilities: [40] Express Root Port

If you run "lspci -b", it will show you PCI bus addresses instead,
which should look like this:

  00:02.0 PCI bridge
    Memory behind bridge: 00000000-fffffffb
    Capabilities: [40] Express Root Port

> > But I don't think it works in general because there's no requirement
> > that the host bridge address translation be that simple.  For example,
> > if we have two host bridges, and we want each to have 2GB of 32-bit
> > PCI address space starting at 0x0, it might look like this:
> > 
> >   0x00000002_00000000 -> PCI 0x00000000 (subtract 0x00000002_00000000)
> >   0x00000002_80000000 -> PCI 0x00000000 (subtract 0x00000002_80000000)
> > 
> > In this case simply ignoring the high 32 bits of the CPU address isn't
> > the correct translation for the second host bridge.  I think we should
> > look at each host bridge's "ranges", find the difference between its
> > parent and child addresses, and apply the same difference to
> > everything below that bridge.
> 
> Not sure I've got this scenario straight: can you please provide the topology
> and the bit setting (32/64 bit) for those ranges? Also, is this scenario coming
> from a real use case or is it hypothetical?

This scenario is purely hypothetical, but it's a legal topology that
we should handle correctly.  It's two host bridges, with independent
PCI hierarchies below them:

  Host bridge A: [mem 0x2_00000000-0x2_7fffffff window] (bus address 0x00000000-0x7fffffff)
  Host bridge B: [mem 0x2_80000000-0x2_ffffffff window] (bus address 0x00000000-0x7fffffff)

Bridge A has an MMIO aperture at CPU addresses
0x2_00000000-0x2_7fffffff, and when it initiates PCI transactions on
its secondary side, the PCI address is CPU_addr - 0x2_00000000.

Similarly, bridge B has an MMIO aperture at CPU addresses 
0x2_80000000-0x2_ffffffff, and when it initiates PCI transactions on 
its secondary side, the PCI address is CPU_addr - 0x2_80000000.

Both hierarchies use PCI bus addresses in the 0x00000000-0x7fffffff
range.  In a topology like this, you can't convert a bus address back
to a CPU address unless you know which hierarchy it's in.
pcibios_bus_to_resource() takes a pci_bus pointer, which tells you
which hierarchy (and which host bridge address translation) to use.

Bjorn

