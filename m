Return-Path: <linux-arch+bounces-6629-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A29D895F9F9
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2024 21:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56FFF1F23B71
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2024 19:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0863198E99;
	Mon, 26 Aug 2024 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AHghUoTk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B788120D
	for <linux-arch@vger.kernel.org>; Mon, 26 Aug 2024 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724701862; cv=none; b=BGryzPPsmEbot9G2hV6YLb2k4BSaqflxVLiDe94BU7llfhg0MhjpXI3jgtwYoxrlMD/IOO13sJGxNIrT4g7ceQTTvudyggsqJuwR1uxgM3jl3HagcgPRR4ftnGfnK9m6EBg15EwMYmSS1Ayhpo8H50Xj+R7zb6s6AxN2xGuHiQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724701862; c=relaxed/simple;
	bh=MMfRm30DKmAgIRDJDysPRmHSCruCns16kqlRyLPykmk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moeeu+fYzQZsKhmvLX+5XpEa8OrOmtfSZhKQNyjw53Qx0M03HnwCi0WYOpFCzPqceem/g7M7zV3AFgCfG4KxZJBtkI80nnknzUBr8FWAtdQrvUpMxHmwMkfa7EBOcVT32gvcbm4E0kx61A/6yQM5Hr5NPvnNtxQYijCoyBSVzv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AHghUoTk; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-42816ca782dso41185795e9.2
        for <linux-arch@vger.kernel.org>; Mon, 26 Aug 2024 12:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724701858; x=1725306658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nm1b7fe+EM2KbxsMouqWXhXxk0JeYyRkXhbMRY2MV68=;
        b=AHghUoTkE4yOiAJy4LNPy1fRpzci6tNt0XLPUUrS/9LFDz+62u0CiSkq11a5sqrZB1
         ejDhhkmaBRMWLSLdpjLiKiNkLPySpx6kRxpBkhtLof7zvZTuA4noA2uMK2Om6wpUe4Ot
         KHfz+HmnN7t/yIN3LGi52LusAA83E3EwB1vXT1NoF2sgA3f+PnSFzJ0marK48bmP2pk/
         C1fSCgiOzw8SGKRL7I4PJidY0bUbroj2SuGSeZ4np+7v+pNBaNFIz5M0SfOw+AFvdeln
         2KeAMh00RnCFuoEpTsBJV3v4pYRgRyTpCi42EhyMndSWuyR/AnalfKoRfeL/yQTJDjpc
         hTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724701858; x=1725306658;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nm1b7fe+EM2KbxsMouqWXhXxk0JeYyRkXhbMRY2MV68=;
        b=DrBApiOq4DMVFZ1C60mEQGZvIfscdm/e9wBz2lWWeOcqA5Evf7itZC42bvFjn5TmRj
         9N4SeQyem7Ii4oDKRKOpcWwJKgCejaWyuaO+k/XhPtlRaMKWllG7AsGnuKIyOxHd6eAm
         X69cZKlLC+gYn5KEI5W+vBNuDOeHH+8Uw/2CuwHIkXARPkDFayiehQx67nfZzn+nguhH
         dflrFYZnfdbh6oB0jWcTEzKy5O7LUgLgzKwwbN0W0FVZ6iZelvGq0kFmHMf05vGnp2nP
         Cam3BohbYFwpHfQoCZxKHsSPzPsZJcNBlmz0d4dRMF0UJ6r3Lzo+cmHIIx7qHfSuAUia
         gaTg==
X-Forwarded-Encrypted: i=1; AJvYcCUr8ak0PLMfjsuIWc/SeAZDsxDQ+TYu7s1Ak89cOZWAvSFihCPYOsRjpjYcPivhjLTavaqp9Fs5GYuZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyFQW+O6ggQTavmhOdG2DxF4sSSHKajoRcC2/kfo0p1yldEvp73
	1qf87trybysh9h/NGHuPRkTWYWAFVjEZfLoiE2nrUl+YGgQ1NlFsBBIVEFKyMNk=
X-Google-Smtp-Source: AGHT+IF2zQ2HTqZgToRotlgcOcl2W6GGPXIdSXXSe9YgqKKpwd3OPRH5/4dJ7SYP5S2nDsD/4FzRPA==
X-Received: by 2002:a5d:4cc2:0:b0:371:72a8:15e with SMTP id ffacd0b85a97d-37311855fecmr7064417f8f.16.1724701857803;
        Mon, 26 Aug 2024 12:50:57 -0700 (PDT)
Received: from localhost ([87.13.33.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f41f249sm488655485a.126.2024.08.26.12.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 12:50:57 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 26 Aug 2024 21:51:02 +0200
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
	Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 03/11] PCI: of_property: Sanitize 32 bit PCI address
 parsed from DT
Message-ID: <Zszcps6bnCcdFa54@apocalypse>
Mail-Followup-To: Bjorn Helgaas <helgaas@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
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
References: <8b4fa91380fc4754ea80f47330c613e4f6b6592c.1724159867.git.andrea.porta@suse.com>
 <20240821152441.GA222583@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821152441.GA222583@bhelgaas>

Hi Bjorn,

On 10:24 Wed 21 Aug     , Bjorn Helgaas wrote:
> On Tue, Aug 20, 2024 at 04:36:05PM +0200, Andrea della Porta wrote:
> > The of_pci_set_address() function parse devicetree PCI range specifier
> 
> s/parse/parses/ ? 

Ack.

> 
> > assuming the address is 'sanitized' at the origin, i.e. without checking
> > whether the incoming address is 32 or 64 bit has specified in the flags.
> > In this way an address with no OF_PCI_ADDR_SPACE_MEM64 set in the flagss
> 
> s/flagss/flags/

Ack.

> 
> > could leak through and the upper 32 bits of the address will be set too,
> > and this violates the PCI specs stating that ion 32 bit address the upper
> 
> s/ion/in/

Ack.

> 
> > bit should be zero.
> 
> I don't understand this code, so I'm probably missing something.  It
> looks like the interesting path here is:
> 
>   of_pci_prop_ranges
>     res = &pdev->resource[...];
>     for (j = 0; j < num; j++) {
>       val64 = res[j].start;
>       of_pci_set_address(..., val64, 0, flags, false);
>  +      if (OF_PCI_ADDR_SPACE_MEM64)
>  +        prop[1] = upper_32_bits(val64);
>  +      else
>  +        prop[1] = 0;
> 
> OF_PCI_ADDR_SPACE_MEM64 tells us about the size of the PCI bus
> address, but the address (val64) is a CPU physical address, not a PCI
> bus address, so I don't understand why of_pci_set_address() should use
> OF_PCI_ADDR_SPACE_MEM64 to clear part of the CPU address.
>

It all starts from of_pci_prop_ranges(), that is the caller of of_pci_set_address().
val64 (i.e. res[j].start) is the address part of a struct resource that has
its own flags.  Those flags are directly translated to of_pci_range flags by
of_pci_get_addr_flags(), so any IORESOURCE_MEM_64 / IORESOURCE_MEM in the
resource flag will respectively become OF_PCI_ADDR_SPACE_MEM64 / OF_PCI_ADDR_SPACE_MEM32
in pci range.
What is advertised as 32 bit at the origin (val64) should not become a 64
bit PCI address at the output of of_pci_set_address(), so the upper 32 bit
portion should be dropped. 
This is explicitly stated in [1] (see page 5), where a space code of 0b10
implies that the upper 32 bit of the address must be zeroed out.
Please note that of_pci_prop_ranges() will be called only in case 
CONFIG_PCI_DYNAMIC_OF_NODES is enabled to populate ranges for pci bridges and
pci endpoint for which a quirk is declared, so I would say not a very
often recurring use case.
 
[1] - https://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf

> Add blank lines between paragraphs.

Ack.

> 
> > This could cause mapping translation mismatch on PCI devices (e.g. RP1)
> > that are expected to be addressed with a 64 bit address while advertising
> > a 32 bit address in the PCI config region.
> > Add a check in of_pci_set_address() to set upper 32 bits to zero in case
> > the address has no 64 bit flag set.
> 
> Is this an indication of a DT error?  Have you seen this cause a
> problem?  If so, what does it look like to a user?  I.e., how could a
> user find this patch if they saw a problem?

Not neccessarily a DT error, but an inconsistent representation of addresses
wrt the specs. I incidentally encountered this on RaspberryPi 5, where
the PCI config space for the RP1 endpoint shows 32 bit BARs (basically an
offset from zero) but the effective address to which the CPU can access the
device is 64 bit nonetheless (0x1f_00000000).  I believe this is backed by
some non standard hw wiring.

Without this patch the range translation chain is broken, like this:

pcie@120000: <0x2000000 0x00 0x00    0x1f 0x00                0x00 0xfffffffc>;
~~~ chain breaks here ~~~
pci@0      : <0x82000000 0x1f 0x00   0x82000000 0x1f 0x00     0x00 0x600000>;
dev@0,0    : <0x01 0x00 0x00         0x82010000 0x1f 0x00     0x00 0x400000>;
rp1@0      : <0xc0 0x40000000        0x01 0x00 0x00           0x00 0x400000>;

while with the patch applied the chain correctly become:

pcie@120000: <0x2000000 0x00 0x00    0x1f 0x00                0x00 0xfffffffc>;
pci@0      : <0x82000000 0x00 0x00   0x82000000 0x00 0x00     0x00 0x600000>;
dev@0,0    : <0x01 0x00 0x00         0x82010000 0x00 0x00     0x00 0x400000>;
rp1@0      : <0xc0 0x40000000        0x01 0x00 0x00           0x00 0x400000>;

I'm not advocating here that this patch is fixing the behaviour on Rpi5, this
is just a nice side effect of the correct address representation. I think we can
also probably fix it by patching the pcie node in the devicetree like this:

pcie@120000: <0x2000000 0xi1f 0x00    0x1f 0x00                0x00 0xfffffffc>;

but this is of course just a 1:1 mapping, while the address will still be at
least 'virtually' unconsistent, showing 64 bit address wihile the 32 bit flag is
set.
The net symptoms to the user would be, in the case of the RP1, a platform driver
of one of its sub-peripheral that fails to be probed.

Many thanks,
Andrea

> 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >  drivers/pci/of_property.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> > index 5a0b98e69795..77865facdb4a 100644
> > --- a/drivers/pci/of_property.c
> > +++ b/drivers/pci/of_property.c
> > @@ -60,7 +60,10 @@ static void of_pci_set_address(struct pci_dev *pdev, u32 *prop, u64 addr,
> >  	prop[0] |= flags | reg_num;
> >  	if (!reloc) {
> >  		prop[0] |= OF_PCI_ADDR_FIELD_NONRELOC;
> > -		prop[1] = upper_32_bits(addr);
> > +		if (FIELD_GET(OF_PCI_ADDR_FIELD_SS, flags) == OF_PCI_ADDR_SPACE_MEM64)
> > +			prop[1] = upper_32_bits(addr);
> > +		else
> > +			prop[1] = 0;
> >  		prop[2] = lower_32_bits(addr);
> >  	}
> >  }
> > -- 
> > 2.35.3
> > 

