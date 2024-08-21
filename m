Return-Path: <linux-arch+bounces-6410-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D087A959E7B
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 15:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6171C215EC
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 13:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07A3199949;
	Wed, 21 Aug 2024 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gt5sU611"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A268F188A33;
	Wed, 21 Aug 2024 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246286; cv=none; b=jOc8l4I/GUfnFxhMpeDryu5GDu0Fp2h7eRyQOhE478+aUfkBxlBXdwRJSQOz44UYZ2e3/AFIHi1q5byaMcJZyAe9CG+X0pEUs4PBaSYhiXvP4R9MX7XB2p6TraOav4uHiV+HGvOgifzMtV4fNTM8FK+edkgT1k3oeSmmKCb//Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246286; c=relaxed/simple;
	bh=4J5Z1SoLstMKvuEFmueN5cD92XhXbF48rhCyXiWqfc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5FWs69e56flx3XlUUxnvB41e7bPd5vI1bKKTEccrSV8205l4Xx3Hy9xdic75KfsqrEwRqyTcJzsESdjAa+9EUPdjSRIU4HgI3w8oAB9ah67MhFxQyVTKFylWyb8kvSXNTVLb7sIsZeqDXxbQpwl2Am+LVB7B/rxu4dgW45Y+Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gt5sU611; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D13AC32782;
	Wed, 21 Aug 2024 13:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724246286;
	bh=4J5Z1SoLstMKvuEFmueN5cD92XhXbF48rhCyXiWqfc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gt5sU611t1gy+i8JnErfPLmmKuJIbmOK6bDfgnJfFMunesDxEgSJWKQHJH7HorUt2
	 KWMOlcQ2O1Y2uFn29Q9JrGDY84kKO6op6X2DWdH0So1eEgpqTG1GhN4NgBAPFFYjR3
	 6iQ8eTcht9a9xvQEVwWrUygQ9Gc7PxiX1Zd3Cm8WKs8qT7kAKv90AZ4QRmEnyxazHL
	 Mo5+8Rox6+uBq9xMTj6WH7xnRuesauC+3GrfvSULC9u/Vm/wW431RGkU17h/qsRTI0
	 GoXlW0w4qVTdOb4tgA679+OVfJJO9DHJuJiU8Cx2HwVAKabf9gbL6BvtxF+vMe/BTP
	 CrKWiO7SWrtqw==
Date: Wed, 21 Aug 2024 14:17:57 +0100
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
Subject: Re: [PATCH 06/11] clk: rp1: Add support for clocks provided by RP1
Message-ID: <20240821131757.GB6387@kernel.org>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <a378cc652b7e92b4022141dd2f20711e1771eb72.1724159867.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a378cc652b7e92b4022141dd2f20711e1771eb72.1724159867.git.andrea.porta@suse.com>

On Tue, Aug 20, 2024 at 04:36:08PM +0200, Andrea della Porta wrote:
> RaspberryPi RP1 is an MFD providing, among other peripherals, several
> clock generators and PLLs that drives the sub-peripherals.
> Add the driver to support the clock providers.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

...

> diff --git a/drivers/clk/clk-rp1.c b/drivers/clk/clk-rp1.c
> new file mode 100644
> index 000000000000..d18e711c0623
> --- /dev/null
> +++ b/drivers/clk/clk-rp1.c
> @@ -0,0 +1,1655 @@
> +// SPDX-License-Identifier: GPL

checkpatch says:

WARNING: 'SPDX-License-Identifier: GPL' is not supported in LICENSES/...

...

> +static int rp1_clock_set_parent(struct clk_hw *hw, u8 index)
> +{
> +	struct rp1_clock *clock = container_of(hw, struct rp1_clock, hw);
> +	struct rp1_clockman *clockman = clock->clockman;
> +	const struct rp1_clock_data *data = clock->data;
> +	u32 ctrl, sel;
> +
> +	spin_lock(&clockman->regs_lock);
> +	ctrl = clockman_read(clockman, data->ctrl_reg);
> +
> +	if (index >= data->num_std_parents) {
> +		/* This is an aux source request */
> +		if (index >= data->num_std_parents + data->num_aux_parents)

It looks like &clockman->regs_lock needs to be unlocked here.

Flagged by Smatch, Sparse. and Coccinelle.

> +			return -EINVAL;
> +
> +		/* Select parent from aux list */
> +		ctrl = set_register_field(ctrl, index - data->num_std_parents,
> +					  CLK_CTRL_AUXSRC_MASK,
> +					  CLK_CTRL_AUXSRC_SHIFT);
> +		/* Set src to aux list */
> +		ctrl = set_register_field(ctrl, AUX_SEL, data->clk_src_mask,
> +					  CLK_CTRL_SRC_SHIFT);
> +	} else {
> +		ctrl = set_register_field(ctrl, index, data->clk_src_mask,
> +					  CLK_CTRL_SRC_SHIFT);
> +	}
> +
> +	clockman_write(clockman, data->ctrl_reg, ctrl);
> +	spin_unlock(&clockman->regs_lock);
> +
> +	sel = rp1_clock_get_parent(hw);
> +	WARN(sel != index, "(%s): Parent index req %u returned back %u\n",
> +	     data->name, index, sel);
> +
> +	return 0;
> +}

...

