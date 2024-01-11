Return-Path: <linux-arch+bounces-1351-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE67182B4E0
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 19:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2E51C21089
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 18:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA26E53819;
	Thu, 11 Jan 2024 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QdyXNbVg"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243AFDF57;
	Thu, 11 Jan 2024 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sG0vta/K25cX+m3KWmJQGIOyHDu76/qWE53sJiW1pFo=; b=QdyXNbVgAPkw53YLTW5MFLAwGd
	JSmyBJYT187WJ9+lEgwFU4PhK1dNACRkVKJfr68Vrl3dvWbrfDcajsyxvDC+L+X9FlhxRdzkHifJ7
	Nyxxyw4E6rhW4a9StvHd/8k0K7cZ2ejK8wWeAxlnWB3EXAqRbexHDSm2Ym+JznIMwLMETkZI1EOBF
	aFTVH+8Oirspf3X8ccXVNUEcwyl/yFabJZJG4kbTOUGr9HGQnWzceum2L980kdwneZgFV/2GpF9u7
	+ZMQvD6P6lp8CqjbYvw2rm5IOxMyXQjXa+F/gD8ocRGtER1nVEgTt8Q6I3eYKL9yLoSjoGENQ2Kyy
	yStOVlHw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54562)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rO04n-0006t8-0R;
	Thu, 11 Jan 2024 18:46:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rO04l-0006ah-8R; Thu, 11 Jan 2024 18:46:47 +0000
Date: Thu, 11 Jan 2024 18:46:47 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, acpica-devel@lists.linuxfoundation.org,
	linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
	Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com,
	James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 02/21] ACPI: processor: Add support for processors
 described as container packages
Message-ID: <ZaA3l4yjgCXxSiVg@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
 <E1rDOfx-00Dvje-MS@rmk-PC.armlinux.org.uk>
 <CAJZ5v0iB0bS6nmjQ++pV1zp5YSGuigbffK5VD3wsX+8bY9MA5w@mail.gmail.com>
 <20240111175908.00002f46@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240111175908.00002f46@Huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 11, 2024 at 05:59:08PM +0000, Jonathan Cameron wrote:
> On Mon, 18 Dec 2023 21:17:34 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> 
> > On Wed, Dec 13, 2023 at 1:49 PM Russell King <rmk+kernel@armlinux.org.uk> wrote:
> > >
> > > From: James Morse <james.morse@arm.com>
> 
> Done some digging + machine faking.  This is mid stage results at best.
> 
> Summary: I don't think this patch is necessary.  If anyone happens to be in
> the mood for testing on various platforms, can you drop this patch and
> see if everything still works.
> 
> With this patch in place, and a processor container containing
> Processor() objects acpi_process_add is called twice - once via
> the path added here and once via acpi_bus_attach etc.
> 
> Maybe it's a left over from earlier approaches to some of this?

From what you're saying, it seems that way. It would be really good to
get a reply from James to see whether he agrees - or at least get the
reason why this patch is in the series... but I suspect that will never
come.

> Both cases are covered by the existing handling without this.
> 
> I'm far from clear on why we need this patch.  Presumably
> it's the reference in the description on it breaking for
> Processor Package containing Processor() objects that matters
> after a move... I'm struggling to find that move though!

I do know that James did a lot of testing, so maybe he found some
corner case somewhere which made this necessary - but without input
from James, we can't know that.

So, maybe the right way forward on this is to re-test the series
with this patch dropped, and see whether there's any ill effects.
It should be possible to resurect the patch if it does turn out to
be necessary.

Does that sound like a good way forward?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

