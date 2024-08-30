Return-Path: <linux-arch+bounces-6850-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D803C9663CF
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 16:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4E51F232FF
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 14:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2181E1B1D5A;
	Fri, 30 Aug 2024 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="haLZ8908"
X-Original-To: linux-arch@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B2D1AF4F8;
	Fri, 30 Aug 2024 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725027051; cv=none; b=WwcKJFIlFpbA0CkPdQJVT9b5txmR78mpiaPQKCLnts7yMKAdIkeTYn+yrVSO8YNpk14/4bXrQXLQCHco+oA1c1KNAE/Uyjj2c5SI3Ebl5/9eSQc0V+VoMxv/CZdCMseSwG2wgeAIq+8KR/PODS2M8FF0wCJWceoubcUBbVN136I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725027051; c=relaxed/simple;
	bh=s4ofsPLllTgoEZz5zcK/aCOTMmpqFnd/GqJpSB5kJaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ha1U3BLkzqNOteFXI8o33OYn6b4g5JwQZegN0RSUnYlebdj3Qd0/B63ZsQeeW/ST9ZQKDheAdwApGsZB1IljjAai7Du/zaOH0SQvKtZOXB5fnKKjrvtoaM+89IT/9aTfkMOdgwvKcr4+BZdUmJK3fJYSqmPvwfcEP1RTtoU1+/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=haLZ8908; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uDcaebjvS3BGJm2mNwOKtW7qt1HOm0LrXI8UJBsCjr4=; b=haLZ8908g6RDC+VOGOw83NdP89
	CeMPQLDvAK1hacZ5Q+EEj1yIsZ0PaIMoSfgNYOvLOOaN27XdqMy1bcvmuVBG9AD3sycn7kPSdsGk0
	RpiOOZLgoac+3bM3ztwfjZr04JbHp+Wh6jTzzcYEBpmYIy8VRneE9X7tOYOkBojC8bBU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sk2KZ-0068J6-EH; Fri, 30 Aug 2024 16:10:27 +0200
Date: Fri, 30 Aug 2024 16:10:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
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
Message-ID: <334b382a-c9ab-47e4-b860-b8477f04c3fb@lunn.ch>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <14990d25-40a2-46c0-bf94-25800f379a30@kernel.org>
 <Zsb_ZeczWd-gQ5po@apocalypse>
 <45a41ed9-2e42-4fd5-a1d5-35de93ce0512@lunn.ch>
 <ZtBjMpMGtA4WfDij@apocalypse>
 <e6e6c230-370f-4b04-8cb7-4158dd51efdc@lunn.ch>
 <ZtFWyAX_7OR5yYDS@apocalypse>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtFWyAX_7OR5yYDS@apocalypse>

> On a second thought, are you really sure we want to proceed with the header file?
> After all the only line in it would be the extern declaration and the only one to
> include it would be rp1-dev.c. Moreover, an header file would convey the false
> premise that you can include it and use that symbol while in fact it should be
> only used inside the driver.
> OTOH, not creating that header file will continue to trigger the warning...

The header file does not need to be in global scope. It could be in
the driver source directory. As such, nothing outside of the driver
can use it.

Headers like this have multiple proposes. One is they make a symbol
visible to the linker. But having two different .c files include the
header enables type checking, which for long term maintenance is just
as important. So a one line header is fine.

	Andrew


