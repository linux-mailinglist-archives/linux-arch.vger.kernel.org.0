Return-Path: <linux-arch+bounces-8265-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D959A3E97
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 14:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D051C20AE1
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 12:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1E342A97;
	Fri, 18 Oct 2024 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UBsdd+Ac"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712562AEFB
	for <linux-arch@vger.kernel.org>; Fri, 18 Oct 2024 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729255255; cv=none; b=mIeic7WRQy7MjGI8TVP4jygEAN9bpRE4XxXL2kjADKwhL0HLiSCcl+nawobhoilTd0lqZmsbB+WTe7eyeixUTHyk92mUdKsHGZ+P4nJOgRgubxAAojxhX25WZw8mrsEQ0jwqnB8YY9kE7wH34c9pVJLZ9UXfq5UQ6aJOBscrABk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729255255; c=relaxed/simple;
	bh=NepPP9+EUJkQE6AAFekh9hvZnrPeDE2ASN5F2g/sxaQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjovcqlgmnuOFr27zXD1Rj364H5gQ+VFPhBW4Y99uzvnEOCudQmcsjWW09DzsTKPG/uQYWeauf0k0cOpuIFsYjYVUwjRI3q/DQjVVaTwx7YMpls0Q1q8DsM6ALm0NMdcyuTUO9QweY4MPH6BabxwHLFU6EML2QZyfPr4KMBYwas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UBsdd+Ac; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso226379066b.1
        for <linux-arch@vger.kernel.org>; Fri, 18 Oct 2024 05:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729255252; x=1729860052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9DykL4kRhQMn7Cbt8yrjSApwATRDvV4AIHohgrmqOh0=;
        b=UBsdd+AcJeTPSj7VbDDbVayFFlXZEceFq+/3BzPSGVEd/vqIQ1Xo7f24O8TX9JYYJX
         2uKOpn2wggd9+3uwrDa1FdqY+j/MdsZjlY4KKebecfW2xuNJnp5NjaaFczFrBFKmpXA2
         5V/L0TI4GwuDTbdpHutCyoSnArESUECp8EBEYEx5FdUYa/OpdlfTi5UaWYAzURH22Toj
         glP0mVzYNvaDNBTOuVqKcQmd/JluRvWygUycKTa+wvCFrqCUsbNq9ImkRQmK+iFXZwKP
         snrH8Lho4I7A5slljx30zdGrTO+4JnlRHtI1/7ZukalCy6atc5M+U3943fiUh9M1hMP/
         QhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729255252; x=1729860052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DykL4kRhQMn7Cbt8yrjSApwATRDvV4AIHohgrmqOh0=;
        b=p8nQr/nTaCvvCKUWsYWF71Ku1BPsBlLAEGZzsv2tctDrKYyK9+OJ1p0W1DmkXPoXbM
         sYrA9UexXAPfcQTReqUBJK4jQTX50W4re9MxYw1dUT0mDepvCF7G5v/r6PYQq1l49AKR
         eNHkPyvvpnowbQYDO7OBVyKanKWH6ukW5YWqqqKfwYW1eb9bV+zEU63Tkvj9IR0N8qhT
         1QeKEdeobC0+jDkypTG6lqDFwLjVJfNk1lvVVYlTuPl/jz6AvAs3r08oLFVkO/q+HtmP
         Ili9/wMqEqiEIFIf8NQAdyT2q0MNR03pKlX/7bBHiYUXJu6vr7ykt+vBVw0ySI9nPSg6
         vOuw==
X-Forwarded-Encrypted: i=1; AJvYcCXqnnQl7puEPmDS68fbwULXjjVPgvQibNlMve1jRLUJ8M+Jh0qUhDoSi8dKT3u889+818AWs/XrtBup@vger.kernel.org
X-Gm-Message-State: AOJu0YwpMHFHTgYsJzAYGJeQnubS08e6ZjMkWA93oCqtfpsQ5gp5SV6u
	JrdJ4isOh54adAT2PAVtzOKXpmOwYg3XHyrhtJW8mr34aGN8sQV7UaO1AZuvC+8=
X-Google-Smtp-Source: AGHT+IGKGlI5U6acm0UPw/vtEqZLZZNRs4tL7ATU0Wt6GltRPSfjPzSBXo/n0wxDoTzpCi5atrc0Sw==
X-Received: by 2002:a17:907:94d2:b0:a99:ec3c:15cd with SMTP id a640c23a62f3a-a9a69ccf8a4mr209343466b.54.1729255251547;
        Fri, 18 Oct 2024 05:40:51 -0700 (PDT)
Received: from localhost (host-95-234-228-50.retail.telecomitalia.it. [95.234.228.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68bf5f4asm91053466b.157.2024.10.18.05.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 05:40:51 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 18 Oct 2024 14:41:11 +0200
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
Message-ID: <ZxJXZ9R-Qp9CNmJk@apocalypse>
References: <ZwJyk9XouLfd24VG@apocalypse>
 <20241008010808.GA455773@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008010808.GA455773@bhelgaas>

Hi Bjorn,

On 20:08 Mon 07 Oct     , Bjorn Helgaas wrote:
... 
> It's common that PCI bus addresses are identical to CPU physical
> addresses, but by no means universal.  More details in
> Documentation/core-api/dma-api-howto.rst
> 
> > [2] I still think that the of_pci_set_address() function should be amended
> > to avoid generating invalid 64 address when 32 bit flag is set.
> > 
> > As you noted, fixing [2] will incidentally also let [1] work: I think
> > we can try to solve [1] the proper way and maybe defer [2] for a separate
> > patch.
> > To solve [1] I've dropped this patch and tried to solve it from devicetree,
> > modifying the following mapping:
> > 
> > pcie@120000: <0x3000000 0x1f 0x00    0x1f 0x00                0x00 0xfffffffc>;
> > 
> > so we now have a 1:1 64 bit mapping from 0x1f_00000000 to 0x1f_00000000.
> 
> That's the wrong thing to change.  pcie@120000 is fine; it's pci@0
> that's incorrect.
> 
> pcie@120000 is the host bridge, and its "ranges" must describe the
> address translation it performs between the primary (CPU) side and the
> secondary (PCI) side.  Either this offset is built into the hardware
> and can't be changed, or the offset is configured by firmware and the
> DT has to match.
> 
> So I think this description is correct:
> 
>   pcie@120000: <0x2000000 0x0 0x00000000 0x1f 0x00000000 0x0 0xfffffffc>;
> 
> which means we have an aperture from CPU physical addresses to PCI bus
> addresses like this:
> 
>   Host bridge: [mem 0x1f_00000000-0x1f_fffffffb window] (bus address 0x00000000-0xfffffffb)
> 
> > I thought it would result in something like this:
> > 
> > pcie@120000: <0x3000000 0x1f 0x00    0x1f 0x00                0x00 0xfffffffc>;
> > pci@0      : <0x82000000 0x1f 0x00   0x82000000 0x1f 0x00     0x00 0x600000>;
> > dev@0,0    : <0x01 0x00 0x00         0x82010000 0x1f 0x00     0x00 0x400000>;
> > rp1@0      : <0xc0 0x40000000        0x01 0x00 0x00           0x00 0x400000>;
> > 
> > but it fails instead (err: "can't assign; no space") in pci_assign_resource()
> > function trying to match the size using pci_clip_resource_to_region(). It turned
> > out that the clipping is done against 32 bit memory region 'pci_32_bit',and
> > this is failing because the original region addresses to be clipped wxxiereas 64
> > bit wide. The 'culprit' seems to be the function devm_of_pci_get_host_bridge_resources()
> > dropping IORESOURCE_MEM_64 on any memory resource, which seems to be a change
> > somewhat specific to a RK3399 case (see commit 3bd6b8271ee66), but I'm not sure
> > whether it can be considered generic.
> 
> I think the problem is that we're building the pci@0 (Root Port)
> "ranges" incorrectly.  pci@0 is a PCI-PCI bridge, which cannot do any
> address translation, so its parent and child address spaces must both
> be inside the pcie@120000 *child* address space.
> 
> > Also, while taking a look at the resulting devicetree, I'm a bit confused by the
> > fact that the parent address generated by of_pci_prop_ranges() for the pci@0,0
> > bridge seems to be taken from the parent address of the pcie@120000 node. Shouldn't
> > it be taken from the child address of pcie@120000, instead?
> 
> Yes, this is exactly the problem.  The pci@0 parent and child
> addresses in "ranges" are both in the PCI address space.  But we
> start with pdev->resource[N], which is a CPU address.  To get the PCI
> address, we need to apply pci_bus_address().  If the host bridge
> windows are set up correctly, the window->offset used in
> pcibios_resource_to_bus() should yield the PCI bus address.

You mean something like this, I think:

@@ -129,7 +129,7 @@ static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
                if (of_pci_get_addr_flags(&res[j], &flags))
                        continue;
 
-               val64 = res[j].start;
+               val64 = pci_bus_address(pdev, &res[j] - pdev->resource);
                of_pci_set_address(pdev, rp[i].parent_addr, val64, 0, flags,
                                   false);
                if (pci_is_bridge(pdev)) {

> 
> I think it should look like this:
> 
>   pci@0: <0x82000000 0x0 0x00000000 0x82000000 0x0 0x00000000 0x0 0x600000>;

indeed, with the above patch applied, the result is exactly as you expected.

> 
> By default lspci shows you the CPU addresses for BARs, so you should
> see something like this:
> 
>   00:02.0 PCI bridge
>     Memory behind bridge: 1f00000000-1ffffffffb
>     Capabilities: [40] Express Root Port
> 
> If you run "lspci -b", it will show you PCI bus addresses instead,
> which should look like this:
> 
>   00:02.0 PCI bridge
>     Memory behind bridge: 00000000-fffffffb
>     Capabilities: [40] Express Root Port
> 
> > > But I don't think it works in general because there's no requirement
> > > that the host bridge address translation be that simple.  For example,
> > > if we have two host bridges, and we want each to have 2GB of 32-bit
> > > PCI address space starting at 0x0, it might look like this:
> > > 
> > >   0x00000002_00000000 -> PCI 0x00000000 (subtract 0x00000002_00000000)
> > >   0x00000002_80000000 -> PCI 0x00000000 (subtract 0x00000002_80000000)
> > > 
> > > In this case simply ignoring the high 32 bits of the CPU address isn't
> > > the correct translation for the second host bridge.  I think we should
> > > look at each host bridge's "ranges", find the difference between its
> > > parent and child addresses, and apply the same difference to
> > > everything below that bridge.
> > 
> > Not sure I've got this scenario straight: can you please provide the topology
> > and the bit setting (32/64 bit) for those ranges? Also, is this scenario coming
> > from a real use case or is it hypothetical?
> 
> This scenario is purely hypothetical, but it's a legal topology that
> we should handle correctly.  It's two host bridges, with independent
> PCI hierarchies below them:
> 
>   Host bridge A: [mem 0x2_00000000-0x2_7fffffff window] (bus address 0x00000000-0x7fffffff)
>   Host bridge B: [mem 0x2_80000000-0x2_ffffffff window] (bus address 0x00000000-0x7fffffff)
> 
> Bridge A has an MMIO aperture at CPU addresses
> 0x2_00000000-0x2_7fffffff, and when it initiates PCI transactions on
> its secondary side, the PCI address is CPU_addr - 0x2_00000000.
> 
> Similarly, bridge B has an MMIO aperture at CPU addresses 
> 0x2_80000000-0x2_ffffffff, and when it initiates PCI transactions on 
> its secondary side, the PCI address is CPU_addr - 0x2_80000000.
> 
> Both hierarchies use PCI bus addresses in the 0x00000000-0x7fffffff
> range.  In a topology like this, you can't convert a bus address back
> to a CPU address unless you know which hierarchy it's in.
> pcibios_bus_to_resource() takes a pci_bus pointer, which tells you
> which hierarchy (and which host bridge address translation) to use.

Agreed. While I think about how to adjust that specific patch,i let's drop it from
this patchset since the aforementioned change is properly fixing the translation
issue.

> 
> Bjora

Many thanks,
Andrea

