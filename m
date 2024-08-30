Return-Path: <linux-arch+bounces-6852-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28270966413
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 16:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1DD1C21FA8
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 14:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9C71B2509;
	Fri, 30 Aug 2024 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="g8/ybE5R"
X-Original-To: linux-arch@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE0F16DC3D;
	Fri, 30 Aug 2024 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725027735; cv=none; b=dfsryDH9RIK3pSuZMrDTJ6Yhn05pxy5s68k+QcA0WIpGdClS3LIracXcWRrS/DE5Nuc7cOlp4lWMQJg/N5Ya7rxE+Suryiuqcd65XbONWX8a4MLcAFgPFuFEoaY21p0cBrj0f8fNNh6I+rKLphjTxaO10MD195QKJH2vlmDNNxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725027735; c=relaxed/simple;
	bh=VSxdJN6tHPVIdLHJP/3S3iq04oDernv5VLzrgKR8idI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubE82tdyYvztMdEQAaaW6uuqDZFgVWYWY07AUkyou8sXnqOarPDGSHVe9DOa7vyhN5mHifqESY4jvfXLbfu/o8Olp7DEIBbfjI6qYfeiMUTymj5LWaL4xhW0efJZjJxZ41RQ4JPHpsanrtHl6gRI50voFnMEmPvHyx4sj/r5coM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=g8/ybE5R; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bu+WwSmIw/oLOQaFMHKFaLYX5AWLg2UzmPKEeZok/Fs=; b=g8/ybE5RMs2beJopUs3A2zGyNo
	U+3WuRhEZmZEtSmQfCf47ewOP0MKjJTfTHzs2lDS4T5Wg3KUJfCKSnr/VRQvXyxnXi+Cf3M6RUKp1
	YroXQk8hzSQimnQMshWZZHIoYZc5bjReKEhnsLSvZSbZ2rkpek0o0fTzliUXZNNe5QHw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sk2Vh-0068QR-0H; Fri, 30 Aug 2024 16:21:57 +0200
Date: Fri, 30 Aug 2024 16:21:56 +0200
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
Subject: Re: [PATCH 08/11] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <26efbff0-ba1a-4e9a-bc5e-4fd53ac0ed99@lunn.ch>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <5954e4dccc0e158cf434d2c281ad57120538409b.1724159867.git.andrea.porta@suse.com>
 <lrv7cpbt2n7eidog5ydhrbyo5se5l2j23n7ljxvojclnhykqs2@nfeu4wpi2d76>
 <ZtHN0B8VEGZFXs95@apocalypse>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtHN0B8VEGZFXs95@apocalypse>

On Fri, Aug 30, 2024 at 03:49:04PM +0200, Andrea della Porta wrote:
> Hi Krzysztof,
> 
> On 10:38 Wed 21 Aug     , Krzysztof Kozlowski wrote:
> > On Tue, Aug 20, 2024 at 04:36:10PM +0200, Andrea della Porta wrote:
> > > The RaspberryPi RP1 is ia PCI multi function device containing
> > > peripherals ranging from Ethernet to USB controller, I2C, SPI
> > > and others.
> > > Implement a bare minimum driver to operate the RP1, leveraging
> > > actual OF based driver implementations for the on-borad peripherals
> > > by loading a devicetree overlay during driver probe.
> > > The peripherals are accessed by mapping MMIO registers starting
> > > from PCI BAR1 region.
> > > As a minimum driver, the peripherals will not be added to the
> > > dtbo here, but in following patches.
> > > 
> > > Link: https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf
> > > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > > ---
> > >  MAINTAINERS                           |   2 +
> > >  arch/arm64/boot/dts/broadcom/rp1.dtso | 152 ++++++++++++
> > 
> > Do not mix DTS with drivers.
> > 
> > These MUST be separate.
> 
> Separating the dtso from the driver in two different patches would mean
> that the dtso patch would be ordered before the driver one. This is because
> the driver embeds the dtbo binary blob inside itself, at build time. So
> in order to build the driver, the dtso needs to be there also. This is not
> the standard approach used with 'normal' dtb/dtbo, where the dtb patch is
> ordered last wrt the driver it refers to.
> Are you sure you want to proceed in this way?

It is more about they are logically separate things. The .dtb/dtbo
describes the hardware. It should be possible to review that as a
standalone thing. The code them implements the binding. It makes no
sense to review the code until the binding is correct, because changes
to the binding will need changes to the code. Hence, we want the
binding first, then the code which implements it.

	Andrew

