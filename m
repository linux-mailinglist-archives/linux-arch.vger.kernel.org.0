Return-Path: <linux-arch+bounces-6565-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E7D95DBC8
	for <lists+linux-arch@lfdr.de>; Sat, 24 Aug 2024 07:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83EAF282C26
	for <lists+linux-arch@lfdr.de>; Sat, 24 Aug 2024 05:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952DF14A4C9;
	Sat, 24 Aug 2024 05:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pZqnuwYs"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35425DF71;
	Sat, 24 Aug 2024 05:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724476651; cv=none; b=fCCOk7EEXxga7AlY0Psb6zmvTbKWVY68+V1fle3uRykNB+sSSdqJnW3llZxZCtwsYCPRw1/348dXr2BxnwfzbOX/zUqyNkypNXK9GmTYQ8T706Ys+yk+6Ja8GeX2v7Ej9YNzis+i3L7y3GxocNSAjS7AUcCSrNwYXtnpVOphUCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724476651; c=relaxed/simple;
	bh=EKYIrWqwELDuWb3+1xndQubTjiUIzzsdrYkz/a+9peg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbHVeSqJuATJ+UIOQm7VBr90zlKp0ToZYwtPoCdcFB1UC3Eght2p63T8Hpb65kHRAQ3Sk8p46CGMSJGscgseC7SKa3ol28nD8v/XRunIllJkeQzmrMCUhjcJFyuq+FZ5Nseazz8RtaHvzl9ddlThkckerDwI3ooQQMXYtdcXqJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pZqnuwYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F32AC32781;
	Sat, 24 Aug 2024 05:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724476650;
	bh=EKYIrWqwELDuWb3+1xndQubTjiUIzzsdrYkz/a+9peg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pZqnuwYsOzkoT3F9shGWLvGPerTWUfF0y4EdZ8YS9ToqCEk6X5+bleX9MUuRgeyH4
	 5Wd2IjUbdRYlpBJetz7loeGfYFQm0Z33Iqt2DBks4qGptCbzJtrFjDq1+uIzDbEjRs
	 o4Czi84+1cftdJ6971GCbffFbs0pIQqLAAkXwiGk=
Date: Sat, 24 Aug 2024 09:53:18 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Subject: Re: [PATCH 08/11] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <2024082420-secluding-rearrange-fcfd@gregkh>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <5954e4dccc0e158cf434d2c281ad57120538409b.1724159867.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5954e4dccc0e158cf434d2c281ad57120538409b.1724159867.git.andrea.porta@suse.com>

On Tue, Aug 20, 2024 at 04:36:10PM +0200, Andrea della Porta wrote:
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2610,6 +2610,9 @@
>  #define PCI_VENDOR_ID_TEKRAM		0x1de1
>  #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
>  
> +#define PCI_VENDOR_ID_RPI		0x1de4
> +#define PCI_DEVICE_ID_RP1_C0		0x0001

Minor thing, but please read the top of this file.  As you aren't using
these values anywhere outside of this one driver, there's no need to add
these values to pci_ids.h.  Just keep them local to the .c file itself.

thanks,

greg k-h

