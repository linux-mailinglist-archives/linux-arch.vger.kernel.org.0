Return-Path: <linux-arch+bounces-6423-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BA395A153
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 17:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7018E1F23F59
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 15:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F142B14D422;
	Wed, 21 Aug 2024 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtZjkQ1J"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFD014A4EA;
	Wed, 21 Aug 2024 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724253883; cv=none; b=CLOukCxOROp0r+CkMiyGqBAQIhMiGa8Q+ZUgCqOgRdOkMjAfT4qTtGQDaDLL2laxbKcQs2qfXDFSdT4Z9InjWJwoxzvZVa0s5bElxZum6tcbOmSQRuFbKOoIeykOL3IAP90szW/R2RKUY39/IGrtO9pK/249+BHoNNqqmMgZCQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724253883; c=relaxed/simple;
	bh=1ZjtB2qfgq/kDPmIlWye3dfIwc8C55gZjyVxcfwSetA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=A103vzlgwJlPw7BDmsJpRrrOpgTe8UdNr7sNemR23iJflgsLzjSt4Ho9kSX8alzayWBvSx9ptasOHmR9PwtgI4TfAKgSkFxqOmhyyfpM1aSSjNHjZXeXIAl+CNT3huGkfuW1FO69yXrNvr9005zye4XHhvOs0hbjnOKgHYQlw0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtZjkQ1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6A2C32786;
	Wed, 21 Aug 2024 15:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724253883;
	bh=1ZjtB2qfgq/kDPmIlWye3dfIwc8C55gZjyVxcfwSetA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TtZjkQ1JoqTb6Y/uUb/+73JdcHZH9WrH/IHzsTJfRG26ORrRRXSHBUa3Ueb/e9SOb
	 k+YJ0KHOXTGtYG5oazohYwVwQQK3KDEf/71BUc7OXOdTJlVctngwIuzs1C7lde3MAJ
	 pOkDSlsc+fkPkwpLUeIcPRhz8rIzG5YpUUSjE4eFZTv5Ru4EgJPTmgquBbi2iVyxUh
	 C9U5Ua+xUG0hSc+Wj/prm44j9A3uSlbySmXCbjYORNrb9ll2z/NTmnAWCB0ivJqWDj
	 SwHlMZ5c2nYJuioTX1efrHNcneRaN9R8CdTYDaqgpWaDSBzN320A/M3P/+osCa1kUz
	 7lcpXCYz5QVmQ==
Date: Wed, 21 Aug 2024 10:24:41 -0500
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
	Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 03/11] PCI: of_property: Sanitize 32 bit PCI address
 parsed from DT
Message-ID: <20240821152441.GA222583@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b4fa91380fc4754ea80f47330c613e4f6b6592c.1724159867.git.andrea.porta@suse.com>

On Tue, Aug 20, 2024 at 04:36:05PM +0200, Andrea della Porta wrote:
> The of_pci_set_address() function parse devicetree PCI range specifier

s/parse/parses/ ? 

> assuming the address is 'sanitized' at the origin, i.e. without checking
> whether the incoming address is 32 or 64 bit has specified in the flags.
> In this way an address with no OF_PCI_ADDR_SPACE_MEM64 set in the flagss

s/flagss/flags/

> could leak through and the upper 32 bits of the address will be set too,
> and this violates the PCI specs stating that ion 32 bit address the upper

s/ion/in/

> bit should be zero.

I don't understand this code, so I'm probably missing something.  It
looks like the interesting path here is:

  of_pci_prop_ranges
    res = &pdev->resource[...];
    for (j = 0; j < num; j++) {
      val64 = res[j].start;
      of_pci_set_address(..., val64, 0, flags, false);
 +      if (OF_PCI_ADDR_SPACE_MEM64)
 +        prop[1] = upper_32_bits(val64);
 +      else
 +        prop[1] = 0;

OF_PCI_ADDR_SPACE_MEM64 tells us about the size of the PCI bus
address, but the address (val64) is a CPU physical address, not a PCI
bus address, so I don't understand why of_pci_set_address() should use
OF_PCI_ADDR_SPACE_MEM64 to clear part of the CPU address.

Add blank lines between paragraphs.

> This could cause mapping translation mismatch on PCI devices (e.g. RP1)
> that are expected to be addressed with a 64 bit address while advertising
> a 32 bit address in the PCI config region.
> Add a check in of_pci_set_address() to set upper 32 bits to zero in case
> the address has no 64 bit flag set.

Is this an indication of a DT error?  Have you seen this cause a
problem?  If so, what does it look like to a user?  I.e., how could a
user find this patch if they saw a problem?

> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  drivers/pci/of_property.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> index 5a0b98e69795..77865facdb4a 100644
> --- a/drivers/pci/of_property.c
> +++ b/drivers/pci/of_property.c
> @@ -60,7 +60,10 @@ static void of_pci_set_address(struct pci_dev *pdev, u32 *prop, u64 addr,
>  	prop[0] |= flags | reg_num;
>  	if (!reloc) {
>  		prop[0] |= OF_PCI_ADDR_FIELD_NONRELOC;
> -		prop[1] = upper_32_bits(addr);
> +		if (FIELD_GET(OF_PCI_ADDR_FIELD_SS, flags) == OF_PCI_ADDR_SPACE_MEM64)
> +			prop[1] = upper_32_bits(addr);
> +		else
> +			prop[1] = 0;
>  		prop[2] = lower_32_bits(addr);
>  	}
>  }
> -- 
> 2.35.3
> 

