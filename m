Return-Path: <linux-arch+bounces-6395-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D65429591AE
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 02:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B3E282292
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 00:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED0D4A24;
	Wed, 21 Aug 2024 00:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8KQlM1S"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011DC17F7;
	Wed, 21 Aug 2024 00:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724199381; cv=none; b=f2xfdj4Bg7SM9tPnbp37vApn7FkNxEr2DNQUPDmPNwBO7cqzkqEtTwf+nUdzrLvVtKAl8McdDe4rWsleqZPB7NOr6/moH5addWJ0HAvOm18KNwIEuks3gsTS4Dqbul19WEHtNCFxiwkRpaC6Mr1gg1SAnJbpg4gyfQ8LRMelhR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724199381; c=relaxed/simple;
	bh=//umJAjmzAHbb4srtnO6p7v3lXCw1BpKooPGruKj3YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyIRIbwqzI/yXN6NhJxL5k/K0yWWKNNfl1WFH7tuNBaLaa5t3q9z4tuz9hoI6sVKnWQvR6Tgd/Q0rl/R8a7p6FZZFv9uHstPLh/I1eSevg2BdtJkRSMqjklvPdsd0Rb9O0/Kv0Ve5VERxMA4QemL+ZCUtjok2ztOdQ3fWjuMPC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8KQlM1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D40DC4AF0B;
	Wed, 21 Aug 2024 00:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724199380;
	bh=//umJAjmzAHbb4srtnO6p7v3lXCw1BpKooPGruKj3YA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X8KQlM1SytAKYaLYGKjUz1REIaj2OSxhUitYLdZDhbSPUm+zX/n9d16vFT2QAuH+t
	 gRVIKK+04YVkR6EPmSuh0C6nOhanaGhRH0wIWK4naUn2w1uZl8uwHWI3y2mssctyjl
	 0frL43b32OAch2HL/8vT8AD+BpumetAHSJPiJ/WMT4RR9Qc2idkWKBT82xQcfgaPIm
	 q/VC4vMsptGQhU0h7I2LgO61rK80P5F0B0tguEZC8SIfByjBsVZmPGPfkG3ZAn+S0S
	 Y9hgUuLVMsBU/bK7a4OHKAWCAgtfwoB+yNoxm4PHjV43MFU/C3auVSDpM4VgrsFPnR
	 su1kG3ad1mLCw==
Date: Tue, 20 Aug 2024 19:16:18 -0500
From: Rob Herring <robh@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
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
Subject: Re: [PATCH 04/11] of: address: Preserve the flags portion on 1:1
 dma-ranges mapping
Message-ID: <20240821001618.GA2309328-robh@kernel.org>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <5ca13a5b01c6c737f07416be53eb05b32811da21.1724159867.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ca13a5b01c6c737f07416be53eb05b32811da21.1724159867.git.andrea.porta@suse.com>

On Tue, Aug 20, 2024 at 04:36:06PM +0200, Andrea della Porta wrote:
> A missing or empty dma-ranges in a DT node implies a 1:1 mapping for dma
> translations. In this specific case, rhe current behaviour is to zero out

typo

> the entire specifier so that the translation could be carried on as an
> offset from zero.  This includes address specifier that has flags (e.g.
> PCI ranges).
> Once the flags portion has been zeroed, the translation chain is broken
> since the mapping functions will check the upcoming address specifier

What does "upcoming address" mean?

> against mismatching flags, always failing the 1:1 mapping and its entire
> purpose of always succeeding.
> Set to zero only the address portion while passing the flags through.

Can you point me to what the failing DT looks like. I'm puzzled how 
things would have worked for anyone.


> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  drivers/of/address.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index d669ce25b5f9..5a6d55a67aa8 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -443,7 +443,8 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
>  	}
>  	if (ranges == NULL || rlen == 0) {
>  		offset = of_read_number(addr, na);
> -		memset(addr, 0, pna * 4);
> +		/* copy the address while preserving the flags */
> +		memset(addr + pbus->flag_cells, 0, (pna - pbus->flag_cells) * 4);
>  		pr_debug("empty ranges; 1:1 translation\n");
>  		goto finish;
>  	}
> -- 
> 2.35.3
> 

