Return-Path: <linux-arch+bounces-2496-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0627C85BA9B
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 12:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF76B1F2232A
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 11:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CB0664D4;
	Tue, 20 Feb 2024 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fsSLVnDr"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA952664B9;
	Tue, 20 Feb 2024 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428635; cv=none; b=VYcHdssyao42YM2CJYLKpT54LoMGr+BQhSrsJocOtgeQyOmEQEyjJ99+4Bj+7SnsdYR3oCWa9QBgEnmWMfgs1AOqR32H5CT3T7VfYYBXvdzhGOgCQDDOXNeiLHBjBoDQkXomtT5ojb7D0rBsryAmD1Qrv8mfakD8bV30JuibVRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428635; c=relaxed/simple;
	bh=+DvpbPLBThjvTjdhN6hhOmNTy8Eu3RCG1WwHjSmI7lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JO+b/Qw5V4bQ+SjmVfDzMxQhOULGanGBqBAzjOtNK7f5a56NidNzS+6rXj6zpx1sE/IDRH6wD9NdgLwlBD3tI6T18oKLBWcCvRsgiGL+wUdJMgxY0igY5VKfaBTbNzdtdcgHqVFpsiZimDO0hHOebgK913Gp5FUn+P0eOz0/wwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fsSLVnDr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8IV/wZQmZmc4s7oLURGMbrTnuZsGulpwAe3ozx8f5sY=; b=fsSLVnDrrExhI/ODinstjQY7lP
	HmvWm3h/RGYKlbPxL1A0a3vxKmj936BI7nB63cCc77mwlQtB7EkoPA6H14gi2c2p/E94vjc8iDvBG
	sTYvRG6F3Jh/G9K03LitnZXPFDFStmjvubNkyGKrSSNOKoBdv7pX/cIa7f/wQ/uTRXxgtCGsX+Xd9
	iNnRTbExTSaP+A26vWf8MLn40QWYwDxMJQpAEhTzYKM60BfWf5+Zlf6TMkgCCa9IB3sdf1E4sBH1y
	44k/ZKPTxdYPW/5h1mZtb/SBW5Ce7+ZtjigBjo2MnUsRqUrJzu0YXrD8uzaVjFfif5eSByJylyZiq
	gtWBI+NA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39114)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rcOKU-0002Jp-0v;
	Tue, 20 Feb 2024 11:30:30 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rcOKT-0000pa-2v; Tue, 20 Feb 2024 11:30:29 +0000
Date: Tue, 20 Feb 2024 11:30:28 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, acpica-devel@lists.linuxfoundation.org,
	linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
	Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com,
	James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH RFC v4 01/15] ACPI: Only enumerate enabled (or
 functional) processor devices
Message-ID: <ZdSNVPjsti7XKxCV@shell.armlinux.org.uk>
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
 <E1rVDmP-0027YJ-EW@rmk-PC.armlinux.org.uk>
 <CAJZ5v0hY_LXp41WMVPhiLosPe7YVzF38Uz=EhmJqVwqFn==Upw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hY_LXp41WMVPhiLosPe7YVzF38Uz=EhmJqVwqFn==Upw@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 15, 2024 at 09:10:39PM +0100, Rafael J. Wysocki wrote:
> On Wed, Jan 31, 2024 at 5:49 PM Russell King <rmk+kernel@armlinux.org.uk> wrote:
> >
> > From: James Morse <james.morse@arm.com>
> >
> > Today the ACPI enumeration code 'visits' all devices that are present.
> >
> > This is a problem for arm64, where CPUs are always present, but not
> > always enabled. When a device-check occurs because the firmware-policy
> > has changed and a CPU is now enabled, the following error occurs:
> > | acpi ACPI0007:48: Enumeration failure
> >
> > This is ultimately because acpi_dev_ready_for_enumeration() returns
> > true for a device that is not enabled. The ACPI Processor driver
> > will not register such CPUs as they are not 'decoding their resources'.
> >
> > ACPI allows a device to be functional instead of maintaining the
> > present and enabled bit, but we can't simply check the enabled bit
> > for all devices since firmware can be buggy.
> >
> > If ACPI indicates that the device is present and enabled, then all well
> > and good, we can enumate it. However, if the device is present and not
> > enabled, then we also check whether the device is a processor device
> > to limit the impact of this new check to just processor devices.
> >
> > This avoids enumerating present && functional processor devices that
> > are not enabled.
> >
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Co-developed-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> I can queue this up for 6.9 as it looks like the rest of the series
> will still need some work.  What do you think?

That seems to be the only way we can make some progress with this
series. I've no idea how we progress from here because I can't answer
your questions on patch 2.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

