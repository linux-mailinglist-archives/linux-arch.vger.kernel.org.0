Return-Path: <linux-arch+bounces-6805-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F4F9645B7
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 15:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60DE6281D0D
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 13:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDA01946CA;
	Thu, 29 Aug 2024 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EWDG+Ss2"
X-Original-To: linux-arch@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A758C446D1;
	Thu, 29 Aug 2024 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724936698; cv=none; b=dJSUo7KekPmAAAEY+FIfRKJSvjRlDFjd57/6JpydPzcSUOMKgIdZZTc0CmvAHqGmHFLwy1gKU+M0XSTVb++yAFvpqIGgJ8M+Foa7eBXeTMftu9om0q7wfpL2GNRBp78MxCtJrShlVfWhR5J8rejHNQrjF81fhKYHmvA98M4hN4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724936698; c=relaxed/simple;
	bh=UhDaGLB/mOLNG4B8tNonftJ2ypq5RcsXKjJ98PC4GPw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyZVit4C17xvSwI9AGppBYv7dh/TZhuY+1wEOEbIYACW76J54RIy1MLaEgDtHooRXGaJ7aGhGUJTvCQ+tuWaoS8RJtFUGwCUTGKYmXAx/K4AMaq8qDbMh8gNUsmPw01FwbYqTJ7V6JE+7LDuFjRtrGP1OrVHxM0AQ2v7V8B6DZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EWDG+Ss2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eXdqGdpHqqcHz+9A73eYJ6/htjXVJkDwZRRfnYO2WdA=; b=EWDG+Ss2a1WYH/bQYF4m4LmmQV
	ZY+30gV6mB7Y2SDxBz5+yaU7dIgV026VnMituKYjYkKEVXw+KAtNS7lzWWvmmS+qPbLo+bTxtstlX
	GTM3YQBnn4tZUnN6XsoKqGEdl9VMXl4Q7PZ6Bxe0wSNlfMII2DxQcJ2Am7/YM/xM/byw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sjepJ-0062Kk-33; Thu, 29 Aug 2024 15:04:37 +0200
Date: Thu, 29 Aug 2024 15:04:37 +0200
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
Message-ID: <e6e6c230-370f-4b04-8cb7-4158dd51efdc@lunn.ch>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <14990d25-40a2-46c0-bf94-25800f379a30@kernel.org>
 <Zsb_ZeczWd-gQ5po@apocalypse>
 <45a41ed9-2e42-4fd5-a1d5-35de93ce0512@lunn.ch>
 <ZtBjMpMGtA4WfDij@apocalypse>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtBjMpMGtA4WfDij@apocalypse>

> > > WARNING: externs should be avoided in .c files
> > > #331: FILE: drivers/misc/rp1/rp1-pci.c:58:
> > > +extern char __dtbo_rp1_pci_begin[];
> > > 
> > > True, but in this case we don't have a symbol that should be exported to other
> > > translation units, it just needs to be referenced inside the driver and
> > > consumed locally. Hence it would be better to place the extern in .c file.
> >  
> > Did you try making it static.
> 
> The dtso is compiled into an obj and linked with the driver which is in
> a different transaltion unit. I'm not aware on other ways to include that
> symbol without declaring it extern (the exception being some hackery 
> trick that compile the dtso into a .c file to be included into the driver
> main source file). 
> Or probably I'm not seeing what you are proposing, could you please elaborate
> on that?

Sorry, i jumped to the wrong conclusion. Often it is missing static
keyword which causes warnings. However, you say it needs to be global
scope.

Reading the warning again:

> > > WARNING: externs should be avoided in .c files

It is wanting you to put it in a .h file, which then gets
included by the two users.

	Andrew

