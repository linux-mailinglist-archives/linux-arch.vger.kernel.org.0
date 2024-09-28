Return-Path: <linux-arch+bounces-7480-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C12989150
	for <lists+linux-arch@lfdr.de>; Sat, 28 Sep 2024 22:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64B7B1F211B1
	for <lists+linux-arch@lfdr.de>; Sat, 28 Sep 2024 20:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893D115FCE5;
	Sat, 28 Sep 2024 20:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HN6l/kql"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B4923774;
	Sat, 28 Sep 2024 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727554640; cv=none; b=rD9oQZlM1czX9pW+L9DSjhkIEG77TnaxdHKayjfqdxEOeKkcUQua6O6jz3v9eA9VmwmaaNQKTzYHjaGG2FKQpiTUcKiYrJ9dGyBBOFDV+fWCzJcAowGZlRFh9yYOuc1mh1AhdAt0pxM6p3kXXq49nSo4lUv+CUy4U/i/08zdeJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727554640; c=relaxed/simple;
	bh=GxLnxv0XYQXvlin9TcvZ4RiHtAZjSqilKKtgN9ttjaY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bWpU6JlkPjs+vIpWZ+oLa20d2VyokvAP86K7sShakOYkoYvbYslFNPNFiQ/SHPh3j09ieqKNh1Fez4x3LKuk5J30gkudSrpWqil1UumFqHtax/wi+9cG39CxU/RBSB0+ByPyInUKs4bIVKD7BaswLk21aBELEVkbQbc5OmE5lb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HN6l/kql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85778C4CEC3;
	Sat, 28 Sep 2024 20:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727554639;
	bh=GxLnxv0XYQXvlin9TcvZ4RiHtAZjSqilKKtgN9ttjaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HN6l/kqlpNLRnX4Tj3J6WmkbDtid6/YNBPS/tnLJtWZVxlTextqj2bwj8ktQuWByR
	 TYBf6EnmSnIf1nXJODJHVTzzqZ4s8nq3czWZ9esZozC1LrmBHzsBdYHxjGulC3Gwmi
	 KgNMC1fUuAf+wWNHdjhMht8FJNaYv/bV5HpQ0RlrS+0ZsPoFrDolCPWENRUPmxF93k
	 G8pecxcSctXbSKJ67xAHr1Zs8GuZg6LHhZrrxt24NTJJyXPmo4SdafNQ8WkjSEsVW+
	 zLblasZLivej8yvdAgRi1/mG7+RPJvxgwkp6csgTsA0646WhXcvKTUdQ/MaGnV0W7z
	 H1TjnpPJ3ff5A==
Date: Sat, 28 Sep 2024 15:17:17 -0500
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
Message-ID: <20240928201717.GA99402@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvZVPA6ov5XgScpz@apocalypse>

On Fri, Sep 27, 2024 at 08:48:28AM +0200, Andrea della Porta wrote:
> On 15:16 Thu 05 Sep     , Bjorn Helgaas wrote:
> > On Thu, Sep 05, 2024 at 06:43:35PM +0200, Andrea della Porta wrote:
> > > On 17:26 Tue 03 Sep     , Bjorn Helgaas wrote:
> > > > On Mon, Aug 26, 2024 at 09:51:02PM +0200, Andrea della Porta wrote:
> > > > > On 10:24 Wed 21 Aug     , Bjorn Helgaas wrote:
> > > > > > On Tue, Aug 20, 2024 at 04:36:05PM +0200, Andrea della Porta wrote:
> > > > > > > The of_pci_set_address() function parses devicetree PCI range
> > > > > > > specifier assuming the address is 'sanitized' at the origin,
> > > > > > > i.e. without checking whether the incoming address is 32 or 64
> > > > > > > bit has specified in the flags.  In this way an address with no
> > > > > > > OF_PCI_ADDR_SPACE_MEM64 set in the flags could leak through and
> > > > > > > the upper 32 bits of the address will be set too, and this
> > > > > > > violates the PCI specs stating that in 32 bit address the upper
> > > > > > > bit should be zero.
> > > > 
> > > > > > I don't understand this code, so I'm probably missing something.  It
> > > > > > looks like the interesting path here is:
> > > > > > 
> > > > > >   of_pci_prop_ranges
> > > > > >     res = &pdev->resource[...];
> > > > > >     for (j = 0; j < num; j++) {
> > > > > >       val64 = res[j].start;
> > > > > >       of_pci_set_address(..., val64, 0, flags, false);
> > > > > >  +      if (OF_PCI_ADDR_SPACE_MEM64)
> > > > > >  +        prop[1] = upper_32_bits(val64);
> > > > > >  +      else
> > > > > >  +        prop[1] = 0;
> > > ...
> > > > However, the CPU physical address space and the PCI bus address are
> > > > not the same.  Generic code paths should account for that different by
> > > > applying an offset (the offset will be zero on many platforms where
> > > > CPU and PCI bus addresses *look* the same).
> > > > 
> > > > So a generic code path like of_pci_prop_ranges() that basically copies
> > > > a CPU physical address to a PCI bus address looks broken to me.
> > > 
> > > Hmmm, I'd say that a translation from one bus type to the other is
> > > going on nonetheless, and this is done in the current upstream function
> > > as well. This patch of course does not add the translation (which is
> > > already in place), just to do it avoiding generating inconsistent address.
> > 
> > I think I was looking at this backwards.  I assumed we were *parsing"
> > a "ranges" property, but I think in fact we're *building* a "ranges"
> > property to describe an existing PCI device (either a PCI-to-PCI
> > bridge or an endpoint).  For such devices there is no address
> > translation.
> > 
> > Any address translation would only occur at a PCI host bridge that has
> > CPU address space on the upstream side and PCI address space on the
> > downstream side.
> > 
> > Since (IIUC), we're building "ranges" for a device in the interior of
> > a PCI hierarchy where address translation doesn't happen, I think both
> > the parent and child addresses in "ranges" should be in the PCI
> > address space.
> > 
> > But right now, I think they're both in the CPU address space, and we
> > basically do this:
> > 
> >   of_pci_prop_ranges(struct pci_dev *pdev, ...)
> >     res = &pdev->resource[...];
> >     for (j = 0; j < num; j++) {   # iterate through BARs or windows
> >       val64 = res[j].start;       # CPU physical address
> >       # <convert to PCI address space>
> >       of_pci_set_address(..., rp[i].parent_addr, val64, ...)
> >         rp[i].parent_addr = val64
> >       if (pci_is_bridge(pdev))
> >         memcpy(rp[i].child_addr, rp[i].parent_addr)
> >       else
> >         rp[i].child_addr[0] = j   # child addr unset/unused
> > 
> > Here "res" is a PCI BAR or bridge window, and it contains CPU physical
> > addresses, so "val64" is a CPU physical address.  It looks to me like
> > we should convert to a PCI bus address at the point noted above, based
> > on any translation described by the PCI host bridge.  That *should*
> > naturally result in a 32-bit value if OF_PCI_ADDR_SPACE_MEM64 is not
> > set.
> 
> That's exactly the point, except that right now a 64 bit address would
> "unnaturally" pass through even if OF_PCI_ADDR_SPACE_MEM64 is not set.
> Hence the purpose of this patch.

From your earlier email
(https://lore.kernel.org/r/Zszcps6bnCcdFa54@apocalypse):

> Without this patch the range translation chain is broken, like this:

> pcie@120000: <0x2000000 0x00 0x00    0x1f 0x00                0x00 0xfffffffc>;
> ~~~ chain breaks here ~~~
> pci@0      : <0x82000000 0x1f 0x00   0x82000000 0x1f 0x00     0x00 0x600000>;
> dev@0,0    : <0x01 0x00 0x00         0x82010000 0x1f 0x00     0x00 0x400000>;
> rp1@0      : <0xc0 0x40000000        0x01 0x00 0x00           0x00 0x400000>;

The cover letter said "RP1 is an MFD chipset that acts as a
south-bridge PCIe endpoint .. the RP1 as an endpoint itself is
discoverable via usual PCI enumeration".

I assume pcie@120000 is the PCI host bridge and is already in the
original DT describing the platform.  I assume pci@0 is a Root Port
and dev@0,0 is the RP1 Endpoint, and the existing code already adds
them as they are enumerated when pci_bus_add_device() calls
of_pci_make_dev_node(), and I think this series adds the rp1@0
description.

And the "ranges" properties are built when of_pci_make_dev_node()
eventually calls of_pci_prop_ranges().  With reference to sec 2.2.1.1
of https://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf
and
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#ranges,
I *think* your example says:

pcie@120000 has:
  child phys.hi	      0x02000000    n=0 p=0 t=0 ss=10b
  child phys.mid,lo   0x00000000_00000000
  parent phys.hi,lo   0x0000001f_00000000
  length hi,lo        0x00000000_fffffffc

which would make it a bridge where the child (PCI) address space is
relocatable non-prefetchable 32-bit memory space at
0x00000000-0xfffffffc, and the corresponding parent address space is
0x1f_00000000-0x1f_fffffffc.  That means the host bridge applies an
address translation of "child_addr = parent_addr - 0x1f_00000000".

pci@0 has:
  child phys.hi	      0x82000000    n=1 p=0 t=0 ss=10b
  child phys.mid,lo   0x0000001f_00000000
  parent phys.hi      0x82000000    n=1 p=0 t=0 ss=10b
  parent phys.mid,lo  0x0000001f_00000000
  length hi,lo        0x00000000_00600000

which would make it a PCI-to-PCI bridge (I assume a PCIe Root Port),
where the child (secondary bus) address space is the non-relocatable
non-prefetchable 32-bit memory space 0x1f_00000000-0x1f_005fffff and
the parent (primary bus) address space is also non-relocatable
non-prefetchable 32-bit memory space at 0x1f_00000000-0x1f_005fffff.

This looks wrong to me because the pci@0 parent address space
(0x1f_00000000-0x1f_005fffff) should be inside the pcie@120000 child
address space (0x00000000-0xfffffffc), but it's not.

IIUC, this patch clears the upper 32 bits in the pci@0 parent address
space.  That would make things work correctly in this case because
that happens to be the exact translation of pcie@120000, so it results
in pci@0 parent address space of 0x00000000-0x005fffff.

But I don't think it works in general because there's no requirement
that the host bridge address translation be that simple.  For example,
if we have two host bridges, and we want each to have 2GB of 32-bit
PCI address space starting at 0x0, it might look like this:

  0x00000002_00000000 -> PCI 0x00000000 (subtract 0x00000002_00000000)
  0x00000002_80000000 -> PCI 0x00000000 (subtract 0x00000002_80000000)

In this case simply ignoring the high 32 bits of the CPU address isn't
the correct translation for the second host bridge.  I think we should
look at each host bridge's "ranges", find the difference between its
parent and child addresses, and apply the same difference to
everything below that bridge.

> while with the patch applied the chain correctly become:

> pcie@120000: <0x2000000 0x00 0x00    0x1f 0x00                0x00 0xfffffffc>;
> pci@0      : <0x82000000 0x00 0x00   0x82000000 0x00 0x00     0x00 0x600000>;
> dev@0,0    : <0x01 0x00 0x00         0x82010000 0x00 0x00     0x00 0x400000>;
> rp1@0      : <0xc0 0x40000000        0x01 0x00 0x00           0x00 0x400000>;

> > > > Maybe my expectation of this being described in DT is mistaken.
> > > 
> > > Not sure what you mean here, the address being translated are coming from
> > > DT, in fact they are described by "ranges" properties.
> > 
> > Right, for my own future reference since I couldn't find a generic
> > description of "ranges" in Documentation/devicetree/:
> > 
> > [1] https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#ranges

