Return-Path: <linux-arch+bounces-6411-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEA1959EA1
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 15:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67CB9B21306
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 13:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5B3199FA9;
	Wed, 21 Aug 2024 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8y/D6aj"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4FC19994C;
	Wed, 21 Aug 2024 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246884; cv=none; b=kr04tKg/lcnmdCmy8hzVpDWA+x4ZrgTyg3+WItg0mUl1mydGDQB38TS8rwPnT4ajL9mG5Ib06AQa3wUo4ceKSS6UfjkMlPmdfseFWvScHrfp1DD1V2lD1JmRI+sGks+K+gIAFENGkiBaPqZ8WV5mR8Va3SFu+Rj045olP+rLGOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246884; c=relaxed/simple;
	bh=EfwypYdM33lZ/G4fq92xQyPXwP/Q8lFk9UP+Y3zqev8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETz4WqG+fhH3JTRrxLtLlammYzJ25doooN5qMPRErnyF0reEIRsX54sBAYRDCn7o56lSf1eWfGbNOcKi4HKMylzvoU6V1Kqjq1R4CAHx5zv9oykr6fTF7L3maCy7TomWsQgmurFg3B0jj965hb19wxDf+nRdVS7kaVX79rRADpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8y/D6aj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913DFC4AF0C;
	Wed, 21 Aug 2024 13:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724246882;
	bh=EfwypYdM33lZ/G4fq92xQyPXwP/Q8lFk9UP+Y3zqev8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N8y/D6ajVEV0BAph5QjS9IHl8V1bvulMD2qXUH9Q329DJmK+yb2x2l0ySSjgh0jM7
	 7/Q0QvG+wLcf6PqhaFlxQqY1ELM375gZZzB/4FykmIP405NOoDF+1h+mrRwcMBuG/0
	 2s3YycJls0/7SB/Fbw6aGK1kbi2sSueaGCscT8OYR7I5faFBfDcygYB6qH9qeaqY08
	 qnDenq4c3K3Mi00VqH1ClQy5fvXOIkQVAceypb2DEXf5bD2nNYSTfTPGRfGGs1QkWS
	 denv1ouRjB1LTDk4dt3OYgly9vkwtPm1XYK8fqNcvosizMDRoo+uTa70uTUAfXRg98
	 qI9Wpn51OmS2Q==
Date: Wed, 21 Aug 2024 14:27:54 +0100
From: Simon Horman <horms@kernel.org>
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
Subject: Re: [PATCH 07/11] pinctrl: rp1: Implement RaspberryPi RP1 gpio
 support
Message-ID: <20240821132754.GC6387@kernel.org>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <eb39a5f3cefff2a1240a18a255dac090af16f223.1724159867.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb39a5f3cefff2a1240a18a255dac090af16f223.1724159867.git.andrea.porta@suse.com>

On Tue, Aug 20, 2024 at 04:36:09PM +0200, Andrea della Porta wrote:
> The RP1 is an MFD supporting a gpio controller and /pinmux/pinctrl.
> Add minimum support for the gpio only portion. The driver is in
> pinctrl folder since upcoming patches will add the pinmux/pinctrl
> support where the gpio part can be seen as an addition.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

...

> diff --git a/drivers/pinctrl/pinctrl-rp1.c b/drivers/pinctrl/pinctrl-rp1.c

...

> +const struct rp1_iobank_desc rp1_iobanks[RP1_NUM_BANKS] = {
> +	/*         gpio   inte    ints     rio    pads */
> +	{  0, 28, 0x0000, 0x011c, 0x0124, 0x0000, 0x0004 },
> +	{ 28,  6, 0x4000, 0x411c, 0x4124, 0x4000, 0x4004 },
> +	{ 34, 20, 0x8000, 0x811c, 0x8124, 0x8000, 0x8004 },
> +};

rp1_iobanks seems to only be used in this file.
If so, it should be static.

Flagged by Sparse.

...

