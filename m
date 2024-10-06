Return-Path: <linux-arch+bounces-7723-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCBD991E0F
	for <lists+linux-arch@lfdr.de>; Sun,  6 Oct 2024 13:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF51B1F21BAD
	for <lists+linux-arch@lfdr.de>; Sun,  6 Oct 2024 11:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DF8175D38;
	Sun,  6 Oct 2024 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KMPf2RQ2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BB414D2B9
	for <linux-arch@vger.kernel.org>; Sun,  6 Oct 2024 11:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728213639; cv=none; b=HitVNlrjeI24Mm5nkIPIvIZAOHoXZxjatGm8wL6QE2czebbSutA4ierupIf7YjeyLZX/RKyc5mDCczSd9kkh+XdAIvhDkMUEH0KAFO61TdJNSC7S3ObLUzKYpRY52OVN/uQaDzkpSiA7xMRaPwrkoKgs4raR0127Ij5a9kbomck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728213639; c=relaxed/simple;
	bh=xwtqRkymQbWLyrHFQs3l8k1xM6HJQbYROF9P9jVE/4Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOqsvua/I9K4kPMtiufduxj2pny5jJJYBmX0d+gp3vvDaKi4+lz0hoWP7qsxcxtjMqWDUCOIrJozlWm2xbBG76aV+AcZT/zlyXcljTiQMU0DXEQyhB8zz5EDajgmyqWjz6a3NMMLmJFwFy+yBQTq/LxDLZuZ1K7YMlyv54lhGqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KMPf2RQ2; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5c8af23a4fcso4348831a12.0
        for <linux-arch@vger.kernel.org>; Sun, 06 Oct 2024 04:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728213636; x=1728818436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rPsiLERRYU7D4j4sUXncuZrtdOCgoc8Hb9DOFm6I+ts=;
        b=KMPf2RQ2S80PWikuJAszy5ChAGaZ3wfgUaxRHVPphN2a4+mzYYDhJyskVxY63NEli+
         fKc+45p+rrDk3Uj2IVirwYWG3HB0VYaB5ez10VsEfKW0CH/D9FqenB63qpYmHPC9p7X8
         q7S+Ok+nPWKcklc+PRAmch99W4iIskS/24qg4OIDxK9+7A0zH8lnTLH/mDf62amT/5bm
         nxQnC3xStf3uZwvd2urCAGgWZGNSSOfu1RzOOaZ1jNVCRvhhsFIOKfzdQNEq4K2syw7R
         zKQ8WuSpdgSRSwdwkgtDDp37upC4bsrdSNh9m4niu/+3j6Yyc3oqRP8ZgEOcDTrDiWd7
         WExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728213636; x=1728818436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPsiLERRYU7D4j4sUXncuZrtdOCgoc8Hb9DOFm6I+ts=;
        b=fwnLZ8eYkMDxzwom/fZ7xfm3upZZO3UcNmu4CwM9lCVpsMkrWsz4E70IFJQMNIFKzJ
         l2FhnYiHCpqt1WxbukGh68qGM+ZtpLTa3BCsubSZRidLXNDmLgBlkFiuTdxeSyl70Qr5
         vqrkjaNeSHPJb+nVn7EEiT/8FPNa2bNMQr5qZxJGCftJ2JgoDgKI1ZsoruHOkgIJblS8
         KdFOTPUOAm4k1eIMe2o5tA8PW/od2GUP6QYQ80dVjP2me8NDVQsLXt2LNppFo6MXpnPv
         gHp9gto0dkeGqon1Y35PWJHzyzSSDdn/6R1ofRzgmL42PCEbZNni4KJC3rSBMuzqnipQ
         z4jw==
X-Forwarded-Encrypted: i=1; AJvYcCUVtr3X39NiXCkmlNoSb2/sm1BRl4mBLu3nDxMeMzurate3HfU8xVpwAS4cddNlB1F4Kq63SGrHBmo6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7LRE4/660VfZSkqvyqHrkMN+a0WCR/X2jnzM6MAxYMxQjP2MH
	zpKBxoRMvZtUu0kiNBNnzQfKZjAEZ62YcIn9U/QhGcU/pw9MdSk6jD4Qk0OXIj8=
X-Google-Smtp-Source: AGHT+IG48id+lRY4xtL1ujqx4VpcR8QxySGV9q44wlS56hapCTBDQPNEacp1RsUNT7MPHUN2ohWifQ==
X-Received: by 2002:a17:907:7f89:b0:a99:435c:89f2 with SMTP id a640c23a62f3a-a99435c8ce0mr357354766b.63.1728213635990;
        Sun, 06 Oct 2024 04:20:35 -0700 (PDT)
Received: from localhost (host-79-32-222-228.retail.telecomitalia.it. [79.32.222.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993d92ed5dsm185689766b.63.2024.10.06.04.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 04:20:35 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Sun, 6 Oct 2024 13:20:51 +0200
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
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
	Stefan Wahren <wahrenst@gmx.net>, Lizhi Hou <lizhi.hou@amd.com>
Subject: Re: [PATCH 03/11] PCI: of_property: Sanitize 32 bit PCI address
 parsed from DT
Message-ID: <ZwJyk9XouLfd24VG@apocalypse>
References: <ZvZVPA6ov5XgScpz@apocalypse>
 <20240928201717.GA99402@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928201717.GA99402@bhelgaas>

Hi Bjorn,

On 15:17 Sat 28 Sep     , Bjorn Helgaas wrote:
...
> From your earlier email
> (https://lore.kernel.org/r/Zszcps6bnCcdFa54@apocalypse):
> 
> > Without this patch the range translation chain is broken, like this:
> 
> > pcie@120000: <0x2000000 0x00 0x00    0x1f 0x00                0x00 0xfffffffc>;
> > ~~~ chain breaks here ~~~
> > pci@0      : <0x82000000 0x1f 0x00   0x82000000 0x1f 0x00     0x00 0x600000>;
> > dev@0,0    : <0x01 0x00 0x00         0x82010000 0x1f 0x00     0x00 0x400000>;
> > rp1@0      : <0xc0 0x40000000        0x01 0x00 0x00           0x00 0x400000>;
> 
> The cover letter said "RP1 is an MFD chipset that acts as a
> south-bridge PCIe endpoint .. the RP1 as an endpoint itself is
> discoverable via usual PCI enumeration".
> 
> I assume pcie@120000 is the PCI host bridge and is already in the
> original DT describing the platform.  I assume pci@0 is a Root Port
> and dev@0,0 is the RP1 Endpoint, and the existing code already adds
> them as they are enumerated when pci_bus_add_device() calls
> of_pci_make_dev_node(), and I think this series adds the rp1@0
> description.

Correct.

> 
> And the "ranges" properties are built when of_pci_make_dev_node()
> eventually calls of_pci_prop_ranges().  With reference to sec 2.2.1.1
> of https://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf
> and
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#ranges,
> I *think* your example says:
> 
> pcie@120000 has:
>   child phys.hi	      0x02000000    n=0 p=0 t=0 ss=10b
>   child phys.mid,lo   0x00000000_00000000
>   parent phys.hi,lo   0x0000001f_00000000
>   length hi,lo        0x00000000_fffffffc
> 
> which would make it a bridge where the child (PCI) address space is
> relocatable non-prefetchable 32-bit memory space at
> 0x00000000-0xfffffffc, and the corresponding parent address space is
> 0x1f_00000000-0x1f_fffffffc.  That means the host bridge applies an
> address translation of "child_addr = parent_addr - 0x1f_00000000".
> 
> pci@0 has:
>   child phys.hi	      0x82000000    n=1 p=0 t=0 ss=10b
>   child phys.mid,lo   0x0000001f_00000000
>   parent phys.hi      0x82000000    n=1 p=0 t=0 ss=10b
>   parent phys.mid,lo  0x0000001f_00000000
>   length hi,lo        0x00000000_00600000
> 
> which would make it a PCI-to-PCI bridge (I assume a PCIe Root Port),
> where the child (secondary bus) address space is the non-relocatable
> non-prefetchable 32-bit memory space 0x1f_00000000-0x1f_005fffff and
> the parent (primary bus) address space is also non-relocatable
> non-prefetchable 32-bit memory space at 0x1f_00000000-0x1f_005fffff.
> 
> This looks wrong to me because the pci@0 parent address space
> (0x1f_00000000-0x1f_005fffff) should be inside the pcie@120000 child
> address space (0x00000000-0xfffffffc), but it's not.

Exactly, that example refers to the 'uncorrected' case, i.e. without the
patch applied.

> 
> IIUC, this patch clears the upper 32 bits in the pci@0 parent address
> space.  That would make things work correctly in this case because
> that happens to be the exact translation of pcie@120000, so it results
> in pci@0 parent address space of 0x00000000-0x005fffff.

Right. I think we sould split it into two issues:

[1] RP1 acknowledges a 32 bit BAR address from its config space while the
device must be accessed using a 64 bit address (that is cpu address
0x1f_00000000), which sounds strange to me but I guess that is how
the hw interconnect has been designed, so we need to cope with it.

[2] I still think that the of_pci_set_address() function should be amended
to avoid generating invalid 64 address when 32 bit flag is set.

As you noted, fixing [2] will incidentally also let [1] work: I think
we can try to solve [1] the proper way and maybe defer [2] for a separate
patch.
To solve [1] I've dropped this patch and tried to solve it from devicetree,
modifying the following mapping:

pcie@120000: <0x3000000 0x1f 0x00    0x1f 0x00                0x00 0xfffffffc>;

so we now have a 1:1 64 bit mapping from 0x1f_00000000 to 0x1f_00000000.
I thought it would result in something like this:

pcie@120000: <0x3000000 0x1f 0x00    0x1f 0x00                0x00 0xfffffffc>;
pci@0      : <0x82000000 0x1f 0x00   0x82000000 0x1f 0x00     0x00 0x600000>;
dev@0,0    : <0x01 0x00 0x00         0x82010000 0x1f 0x00     0x00 0x400000>;
rp1@0      : <0xc0 0x40000000        0x01 0x00 0x00           0x00 0x400000>;

but it fails instead (err: "can't assign; no space") in pci_assign_resource()
function trying to match the size using pci_clip_resource_to_region(). It turned
out that the clipping is done against 32 bit memory region 'pci_32_bit',and
this is failing because the original region addresses to be clipped wxxiereas 64
bit wide. The 'culprit' seems to be the function devm_of_pci_get_host_bridge_resources()
dropping IORESOURCE_MEM_64 on any memory resource, which seems to be a change
somewhat specific to a RK3399 case (see commit 3bd6b8271ee66), but I'm not sure
whether it can be considered generic.

So, I'm actually at an empasse here.

Also, while taking a look at the resulting devicetree, I'm a bit confused by the
fact that the parent address generated by of_pci_prop_ranges() for the pci@0,0
bridge seems to be taken from the parent address of the pcie@120000 node. Shouldn't
it be taken from the child address of pcie@120000, instead?

> 
> But I don't think it works in general because there's no requirement
> that the host bridge address translation be that simple.  For example,
> if we have two host bridges, and we want each to have 2GB of 32-bit
> PCI address space starting at 0x0, it might look like this:
> 
>   0x00000002_00000000 -> PCI 0x00000000 (subtract 0x00000002_00000000)
>   0x00000002_80000000 -> PCI 0x00000000 (subtract 0x00000002_80000000)
> 
> In this case simply ignoring the high 32 bits of the CPU address isn't
> the correct translation for the second host bridge.  I think we should
> look at each host bridge's "ranges", find the difference between its
> parent and child addresses, and apply the same difference to
> everything below that bridge.

Not sure I've got this scenario straight: can you please provide the topology
and the bit setting (32/64 bit) for those ranges? Also, is this scenario coming
from a real use case or is it hypothetical?

Many thanks,
Andrea

...

