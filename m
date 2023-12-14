Return-Path: <linux-arch+bounces-1051-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C7881397B
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 19:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F7C1F21CB7
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 18:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BE367E88;
	Thu, 14 Dec 2023 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tY1PZOXl"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD8B10A;
	Thu, 14 Dec 2023 10:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F6v3AKzs82rkOxn7Bw7IYQ7aZOZcvY0R37BDizdoEeM=; b=tY1PZOXlkxfPhC2ytAtA0EChgV
	8xCikVzwQf/d2ei3BQiYpgHklnc1tZ55NIOKpAXSmHbLYqZAbjznFALBKmUxTrM4w2RITv7a7Q6XV
	8XubzTsdDZhxlotwEGrTMzdgUb1Yg7n7Iz5rqFqo47poHwJ4ccKf3791BCJtbXIwi8MIlAzn1uWTE
	OOYF2o+5Hj7dg2UbMDFo2mAQX/FDQEqk8jY8NDjlNrtMtGVSQ16JC/qnqo216nVBiSVzT5rfswiQP
	CqIDdHbL71hGf6tFcrchFr7OZ0y0UeWzp4gUjEYw/EhCnmIE43HhXw9gXHQ3o86quWAXEeKRp0wEP
	IVtRjJdA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55476)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rDqA1-0001pW-1e;
	Thu, 14 Dec 2023 18:10:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rDqA2-0002m4-0s; Thu, 14 Dec 2023 18:10:14 +0000
Date: Thu, 14 Dec 2023 18:10:13 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, acpica-devel@lists.linuxfoundation.org,
	linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
	Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com,
	James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 01/21] ACPI: Only enumerate enabled (or
 functional) devices
Message-ID: <ZXtFBYJEX2RrFrwj@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
 <E1rDOfs-00DvjY-HQ@rmk-PC.armlinux.org.uk>
 <20231214173241.0000260f@Huawei.com>
 <CAJZ5v0jymOtZ0y65K9wE8FJk+ZKwP+FoGm4AKHXcYVfQJL9MVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jymOtZ0y65K9wE8FJk+ZKwP+FoGm4AKHXcYVfQJL9MVw@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 14, 2023 at 06:47:00PM +0100, Rafael J. Wysocki wrote:
> On Thu, Dec 14, 2023 at 6:32 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Wed, 13 Dec 2023 12:49:16 +0000
> > Russell King (Oracle) <rmk+kernel@armlinux.org.uk> wrote:
> >
> > > From: James Morse <james.morse@arm.com>
> > >
> > > Today the ACPI enumeration code 'visits' all devices that are present.
> > >
> > > This is a problem for arm64, where CPUs are always present, but not
> > > always enabled. When a device-check occurs because the firmware-policy
> > > has changed and a CPU is now enabled, the following error occurs:
> > > | acpi ACPI0007:48: Enumeration failure
> > >
> > > This is ultimately because acpi_dev_ready_for_enumeration() returns
> > > true for a device that is not enabled. The ACPI Processor driver
> > > will not register such CPUs as they are not 'decoding their resources'.
> > >
> > > Change acpi_dev_ready_for_enumeration() to also check the enabled bit.
> > > ACPI allows a device to be functional instead of maintaining the
> > > present and enabled bit. Make this behaviour an explicit check with
> > > a reference to the spec, and then check the present and enabled bits.
> > > This is needed to avoid enumerating present && functional devices that
> > > are not enabled.
> > >
> > > Signed-off-by: James Morse <james.morse@arm.com>
> > > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > > Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > ---
> > > If this change causes problems on deployed hardware, I suggest an
> > > arch opt-in: ACPI_IGNORE_STA_ENABLED, that causes
> > > acpi_dev_ready_for_enumeration() to only check the present bit.
> >
> > My gut feeling (having made ACPI 'fixes' in the past that ran into
> > horribly broken firmware and had to be reverted) is reduce the blast
> > radius preemptively from the start. I'd love to live in a world were
> > that wasn't necessary but I don't trust all the generators of ACPI tables.
> > I'll leave it to Rafael and other ACPI experts suggest how narrow we should
> > make it though - arch opt in might be narrow enough.
> 
> A chicken bit wouldn't help much IMO, especially in the cases when
> working setups get broken.
> 
> I would very much prefer to limit the scope of it, say to processors
> only, in the first place.

Thanks for the feedback and the idea.

I guess we need something like:

	if (device->status.present)
		return device->device_type != ACPI_BUS_TYPE_PROCESSOR ||
		       device->status.enabled;
	else
		return device->status.functional;

so we only check device->status.enabled for processor-type devices?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

