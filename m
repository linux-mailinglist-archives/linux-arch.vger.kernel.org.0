Return-Path: <linux-arch+bounces-7086-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D9896E3E0
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 22:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03442823CA
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 20:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5D41A2570;
	Thu,  5 Sep 2024 20:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsjR3g/7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507CC1946B5;
	Thu,  5 Sep 2024 20:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567419; cv=none; b=HqFD3+8bWTTaEQKbeGopBuAqkr2GXHdsRfSCUNRAXT9CE8PeLKxB9DXjTNa4g+57LyWPKForQkbSSVbIP7P3wxqcK+gSA/yjbWJ/L0vOdLHtr3y50cCMR8M27jaRQLnFD97YDM6Dnp6CUk2OehTO3DgY6YxF2WE8G1mVbNHEEho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567419; c=relaxed/simple;
	bh=oOrc4XFmXO7UWLqnMJyq0ZtqgmmLYbyMcYG1L7W+7R8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Wwo9rK1G3NEb+bc918QKubKDeN93Nm5gutn05abBToNJwxGGGgXHD6B2bZncdWUKAvnVGJ5U7AFlBk4zaWkkazPnf7/OMhJZ2tvr3TCmmFfWvyFZDVZEWz/szb866EYeffACCVyimOHzyyKk/F/9RefKs2ObFaXNLSexvEd/JG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsjR3g/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4C0C4CEC3;
	Thu,  5 Sep 2024 20:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725567418;
	bh=oOrc4XFmXO7UWLqnMJyq0ZtqgmmLYbyMcYG1L7W+7R8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FsjR3g/7qQB4gi6gQ9RJe09XF0lhU9RDIS65EF9eR8pufSZx3XUVXFcKuAsN5vCTg
	 YbIXCDluUqqPGFG5RDUHS39Rc0LUd5lZ3O6jDmROgqjuueAKjiVHDxcRxRiQvtWj2h
	 fqWmWUbDLI0jkK876ryQqsAtOf/5h/5j+X1+bsDS9LXLzGS1UbDVgsqJ9+P+PDtK6S
	 LIzAK4mda7NISRizuFn0Pnr07uFs7DTNRHEN0rLNQXQVsP6nAWBEjpbGEjcWCNp8+V
	 FDUcU22Dz/kT2d/cCZI5EsnUHqN5kodzOLqI0GZoscnBGoJNrcirN87tzj7Z4uc6f7
	 8DJglFSaWIiYg==
Date: Thu, 5 Sep 2024 15:16:56 -0500
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
Message-ID: <20240905201656.GA391855@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ztnft3p3tb_kP1jc@apocalypse>

[+cc Lizhi]

On Thu, Sep 05, 2024 at 06:43:35PM +0200, Andrea della Porta wrote:
> On 17:26 Tue 03 Sep     , Bjorn Helgaas wrote:
> > On Mon, Aug 26, 2024 at 09:51:02PM +0200, Andrea della Porta wrote:
> > > On 10:24 Wed 21 Aug     , Bjorn Helgaas wrote:
> > > > On Tue, Aug 20, 2024 at 04:36:05PM +0200, Andrea della Porta wrote:
> > > > > The of_pci_set_address() function parses devicetree PCI range
> > > > > specifier assuming the address is 'sanitized' at the origin,
> > > > > i.e. without checking whether the incoming address is 32 or 64
> > > > > bit has specified in the flags.  In this way an address with no
> > > > > OF_PCI_ADDR_SPACE_MEM64 set in the flags could leak through and
> > > > > the upper 32 bits of the address will be set too, and this
> > > > > violates the PCI specs stating that in 32 bit address the upper
> > > > > bit should be zero.
> > 
> > > > I don't understand this code, so I'm probably missing something.  It
> > > > looks like the interesting path here is:
> > > > 
> > > >   of_pci_prop_ranges
> > > >     res = &pdev->resource[...];
> > > >     for (j = 0; j < num; j++) {
> > > >       val64 = res[j].start;
> > > >       of_pci_set_address(..., val64, 0, flags, false);
> > > >  +      if (OF_PCI_ADDR_SPACE_MEM64)
> > > >  +        prop[1] = upper_32_bits(val64);
> > > >  +      else
> > > >  +        prop[1] = 0;
> ...
> > However, the CPU physical address space and the PCI bus address are
> > not the same.  Generic code paths should account for that different by
> > applying an offset (the offset will be zero on many platforms where
> > CPU and PCI bus addresses *look* the same).
> > 
> > So a generic code path like of_pci_prop_ranges() that basically copies
> > a CPU physical address to a PCI bus address looks broken to me.
> 
> Hmmm, I'd say that a translation from one bus type to the other is
> going on nonetheless, and this is done in the current upstream function
> as well. This patch of course does not add the translation (which is
> already in place), just to do it avoiding generating inconsistent address.

I think I was looking at this backwards.  I assumed we were *parsing"
a "ranges" property, but I think in fact we're *building* a "ranges"
property to describe an existing PCI device (either a PCI-to-PCI
bridge or an endpoint).  For such devices there is no address
translation.

Any address translation would only occur at a PCI host bridge that has
CPU address space on the upstream side and PCI address space on the
downstream side.

Since (IIUC), we're building "ranges" for a device in the interior of
a PCI hierarchy where address translation doesn't happen, I think both
the parent and child addresses in "ranges" should be in the PCI
address space.

But right now, I think they're both in the CPU address space, and we
basically do this:

  of_pci_prop_ranges(struct pci_dev *pdev, ...)
    res = &pdev->resource[...];
    for (j = 0; j < num; j++) {   # iterate through BARs or windows
      val64 = res[j].start;       # CPU physical address
      # <convert to PCI address space>
      of_pci_set_address(..., rp[i].parent_addr, val64, ...)
        rp[i].parent_addr = val64
      if (pci_is_bridge(pdev))
        memcpy(rp[i].child_addr, rp[i].parent_addr)
      else
        rp[i].child_addr[0] = j   # child addr unset/unused

Here "res" is a PCI BAR or bridge window, and it contains CPU physical
addresses, so "val64" is a CPU physical address.  It looks to me like
we should convert to a PCI bus address at the point noted above, based
on any translation described by the PCI host bridge.  That *should*
naturally result in a 32-bit value if OF_PCI_ADDR_SPACE_MEM64 is not
set.

> > Maybe my expectation of this being described in DT is mistaken.
> 
> Not sure what you mean here, the address being translated are coming from
> DT, in fact they are described by "ranges" properties.

Right, for my own future reference since I couldn't find a generic
description of "ranges" in Documentation/devicetree/:

[1] https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#ranges

