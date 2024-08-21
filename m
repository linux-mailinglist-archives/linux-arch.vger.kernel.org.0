Return-Path: <linux-arch+bounces-6400-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCE29597CB
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 12:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B0B5B220D6
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 10:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0569D1D31A3;
	Wed, 21 Aug 2024 08:43:18 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5650A1D3198;
	Wed, 21 Aug 2024 08:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724229797; cv=none; b=gEc1/8gsb3UR/n4ZACRZHtyKOQHbcySAmo5V/dq45t7vb69QT6W6Arg34IDjK32s8uI42Ts0tc0dwSxIcEpEmloNLUsaVVRjPskE8gfjflRBwuoEMh7hdOXx/3ycVWBcw1JQTku35/rCMb+Ysdf7PpNHoRS+JvEf1hQ5WmRQNKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724229797; c=relaxed/simple;
	bh=EFh3J6gSVnh0OIcnb7FDDNwMmB0QrDYqubDGp6rISSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuJQQsJDCPFlGKfPdtTiB7Gc4adGC/32J2wpCnBeXaVDTmuKz1uJ4BTS5gLV+zyxb2dbSnJjRBfmXOfVr39B+kQLvw0Dzb3OfHKVaUSVNc6r5CoPFOhUMlNeO2dm0DM7IZHZ3kFBxxbYzeMzAJebWRcazYmD4V+sRQwfADAuaJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso54262295e9.0;
        Wed, 21 Aug 2024 01:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724229795; x=1724834595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1Rv5V3A8cW9MeG+rpAd1sSVBgalSm2FnHWC0fKkaAo=;
        b=IiiWGlJA0Sloh6efbKr8kCQWjetaIyJddwoa/D9vCqrQiMt8Z/SC5r/BjQZO6qyiSg
         rvmBIt6MaGdK/FIvxEs98lXtyZFnhYyFiUrvByIbDbY+UhRmW1C3BhCS3vBUX21IVC7q
         C0jXN550gA3lU2ehdgkaDhHa75HHIeW6qI6lXD4bj0mMKOgMAjSUIJRNSGjlurQeiK9x
         +aUUqp/e+Dw8ckpLb2BYlFoZRSEZEe/3OXTa3GlvHlTI7DthcJUjtmu2C/yBSp0qYGa1
         SkIuqpDtYRAVf0mbV+GYzIxXpKgvazCWD+Q/DKfy48RclPgeAZr5zR4t1dIdycPUHXSg
         RYtA==
X-Forwarded-Encrypted: i=1; AJvYcCUcFhzbM+SnMtZ7EZwFgnr2vxHte5ksa+IKewAGbiL2l9Jk64M7Fbf7AuTQHSbUVsUZnoWA51v8eF83eg==@vger.kernel.org, AJvYcCV3c7P2R2XQgTJLY8ycPv/613eL4JfLt+eJrEri+LzQICGc8SK/vGBfQVSdXD5UWE7FjwFc/8Qn@vger.kernel.org, AJvYcCWYRcDlEpEpT+W/XzdiQc4kpAqXDmgHf688mgkYbBpdrQM/+dvPN/YZrJAQL1PQKgcq7wvsFhevw3jT@vger.kernel.org, AJvYcCWfNkSnjuYDPJleuK5tMSIO9DPg+q2Dw8nwf7oeucFK7YnuQKa58S7WHzBIqZdhcoBofbwVNflrAdggTfOu@vger.kernel.org, AJvYcCWsvGxsvB2alOjKmPakuOksDp6OBWoCNmnERBysM7hy/dD7Z8K32U1VdY+23aNBXuzhNzVG2EJHlM3N@vger.kernel.org, AJvYcCXGz/Y8qSKGPJrZQv6ctf8ygNXBPF3j3XnrMka/1Tez7aACJVILImif1nyOY/iEFIXV2Tc9E8Ba9/X2DA==@vger.kernel.org, AJvYcCXYaR3LIzDPczOlwJT5dGaU3HHy6k1po7XOljFDn7IYaXkkvLMW3I52h96SYLkTAUxc2pD/h7AXn/Lv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3brI71exCCGVsxUiYcKnzGLe8Vi3reH78vH3n3TNIxAUXcKkR
	1s8t0l92jjL34FRul81kCeLk7kyY/zi8WPoYv2csd0EYLhjreh0v
X-Google-Smtp-Source: AGHT+IGzXw6aX6SHbsnieU7vRNqZRg6rOYULTsDsFIvZftBwi+J0k6IBv7BXwURwraCoeVv8ToFQcw==
X-Received: by 2002:adf:ce02:0:b0:368:4e28:47f7 with SMTP id ffacd0b85a97d-372fd57c923mr1019754f8f.6.1724229794443;
        Wed, 21 Aug 2024 01:43:14 -0700 (PDT)
Received: from krzk-bin ([178.197.215.209])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42abefa224esm17367135e9.32.2024.08.21.01.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 01:43:13 -0700 (PDT)
Date: Wed, 21 Aug 2024 10:43:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Saravana Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, 
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 11/11] arm64: dts: rp1: Add support for MACB contained in
 RP1
Message-ID: <c3cgkrwnwkrzr67viuvo66ckkxc4ehcye4zomcqdwy2h4dabol@wjp4cd4clm77>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <a3fde99c2e522ef1fbf4e4bb125bc1d97a715eaf.1724159867.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3fde99c2e522ef1fbf4e4bb125bc1d97a715eaf.1724159867.git.andrea.porta@suse.com>

On Tue, Aug 20, 2024 at 04:36:13PM +0200, Andrea della Porta wrote:
> RaspberryPi RP1 is multi function PCI endpoint device that
> exposes several subperipherals via PCI BAR.
> Add an ethernet node for Cadence MACB to the RP1 dtso
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  arch/arm64/boot/dts/broadcom/rp1.dtso | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/broadcom/rp1.dtso b/arch/arm64/boot/dts/broadcom/rp1.dtso
> index d80178a278ee..b40e203c28d5 100644
> --- a/arch/arm64/boot/dts/broadcom/rp1.dtso
> +++ b/arch/arm64/boot/dts/broadcom/rp1.dtso
> @@ -78,6 +78,29 @@ rp1_clocks: clocks@c040018000 {
>  							       <50000000>;   // RP1_CLK_ETH_TSU
>  				};
>  
> +				rp1_eth: ethernet@c040100000 {
> +					reg = <0xc0 0x40100000  0x0 0x4000>;
> +					compatible = "cdns,macb";

Please start using DTS coding style...

Best regards,
Krzysztof


