Return-Path: <linux-arch+bounces-6527-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7CB95B5DC
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 15:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FCB01C2314F
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 13:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84181C9457;
	Thu, 22 Aug 2024 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NtUxmpci"
X-Original-To: linux-arch@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED05181310;
	Thu, 22 Aug 2024 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331891; cv=none; b=L/lBdHaDBewFvw8xCh6F7pnDNYn83FZmYC4dwiFnUTtJ56zhiv/UsWgelsunPqxUJ4ZBM5RzKkVtOpoqAsw3gKoKbpoJ2tlItdLtcpgzgifERdqMQxynJpb8nvElTduXjL2QM6y0mpFssrNx7+9XaafQuEK0Uq/UQIUlRQocB4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331891; c=relaxed/simple;
	bh=+VGKhjgsEZE4sCJ69JLJrAJccMxpl+39tmJWKUMFlWc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYZxAEvO1xMpdw/loyDqBGSX8PRTZ/J17/Z1q4UdEIFOOPcZk638VYySZz2OleyypRgVIQIOyXE6wGmTRAVx6Mx246iOOlTpAFC3Bonz/LrZdQ7vz7RQkBUHkK1m3FRuRSPTxNUurc6wOQ182PbUe/Z/7607A2yOLKvfRGho8T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NtUxmpci; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7KkZEy7FtBrCs9x5HPBYk6bPtUT9ztwHglddJCkvJ2Y=; b=NtUxmpcity96kEKIhSEKwWz6Gr
	HoPF8rO/tmSoTMeNNUitgojvekZYepkU2iq9M86hkk141y7ViQU7JTFpjYBWUeSnyOXKh8Ps1p1n/
	KIzg7COmE2G/lBb1WIg45MsIa2bpDlrhGC9MUoE099qHtFebFOLsUxJRT+/m1Lhsyh1c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sh7U9-005QKl-Ah; Thu, 22 Aug 2024 15:04:17 +0200
Date: Thu, 22 Aug 2024 15:04:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Krzysztof Kozlowski <krzk@kernel.org>,
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
	Lee Jones <lee@kernel.org>, Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 00/11] Add support for RaspberryPi RP1 PCI device using a
 DT overlay
Message-ID: <45a41ed9-2e42-4fd5-a1d5-35de93ce0512@lunn.ch>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <14990d25-40a2-46c0-bf94-25800f379a30@kernel.org>
 <Zsb_ZeczWd-gQ5po@apocalypse>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsb_ZeczWd-gQ5po@apocalypse>

> WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
> #673: FILE: drivers/pinctrl/pinctrl-rp1.c:600:
> +                               return -ENOTSUPP;
> 
> This I must investigate: I've already tried to fix it before sending the patchset
> but for some reason it wouldn't work, so I planned to fix it in the upcoming 
> releases.

ENOTSUPP is an NFS error. It should not be used outside for NFS. You
want EOPNOTSUPP.

 
> WARNING: externs should be avoided in .c files
> #331: FILE: drivers/misc/rp1/rp1-pci.c:58:
> +extern char __dtbo_rp1_pci_begin[];
> 
> True, but in this case we don't have a symbol that should be exported to other
> translation units, it just needs to be referenced inside the driver and
> consumed locally. Hence it would be better to place the extern in .c file.
 
Did you try making it static.

	Andrew

