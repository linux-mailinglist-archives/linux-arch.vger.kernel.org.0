Return-Path: <linux-arch+bounces-1772-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A577F840915
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 15:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7CC1F23697
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 14:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC97E152E0F;
	Mon, 29 Jan 2024 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zshAlN5d"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E7D152E1A;
	Mon, 29 Jan 2024 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540144; cv=none; b=ZnTLyDBY9qGNtnV5HI1KpfrW9xx3jvALLy93RJ6VPfwGvD1HwkpABbxx16IPUAw/P1+tTSjeJMtoIUm5DuJAxs7l/tORM009G54JWHnucUwA3YM8eyPoWGeSFbeYgYkM5LN7durqk1mWZUvo7XCqs2Ev//yiwbfOj/ueapQPN4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540144; c=relaxed/simple;
	bh=N1VX0f01FK+lMbnRSIPKyBtfZOPatHcFypn75HDFeM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4JhHawlGg0ehqrr1PZPNqSfMwpllSQvyrY5UwO62VHeyHu7fAWLEKyUWIzBeSfyfOM36Pw+fNsRdqQZHrZsghsrJJZNjAZ4YxbDRq/PraelWXY0wcEkAuV0N1R18LBiUaE6hpTfAQGAU4Xw4hlLmGhzAop3EO0d7YMCLbTX4oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zshAlN5d; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=M1dyK4/mPjmXezB9OECra+eUv49q0u5KCO/rCTgyWjo=; b=zshAlN5dO4KSpCUyuhnHvqGFw5
	Gh7/mHP6cgVBHrE5nMDsXFPalTDr1ZzFPzRd+TI3s6neNq9Af58Vp3/mYT3mH1KRmbTzeAaN4hL6H
	fwQhoOIa1yKFj+i7nMitwQv1yOG0Pz0nUWKhd2M/o536j+TlvQga+8v5LJ3avKX49iZjAYE3R321y
	O2ps7v/NwXnLCZBPRDhB722lFSCJPiCiWdXOhGxpRCt+7PfqIGluNFkn4mXrYxw2Koq2c9Rr4ObDV
	7YwmV/eFjDI793/wrAU7O0xFV+v50tPaN/a1bIX95nRfhzCTLPIOqUuhcS09c50fU0hLrjkOGJEos
	mD5qTJTg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60316)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rUT2l-0000YR-0u;
	Mon, 29 Jan 2024 14:55:27 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rUT2f-0004dh-CJ; Mon, 29 Jan 2024 14:55:21 +0000
Date: Mon, 29 Jan 2024 14:55:21 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
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
Subject: Re: [PATCH RFC v3 01/21] ACPI: Only enumerate enabled (or
 functional) devices
Message-ID: <Zbe8WQRASx6D6RaG@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
 <ZXxxa+XZjPZtNfJ+@shell.armlinux.org.uk>
 <20231215161539.00000940@Huawei.com>
 <5760569.DvuYhMxLoT@kreacher>
 <20240102143925.00004361@Huawei.com>
 <20240111101949.000075dc@Huawei.com>
 <ZZ/CR/6Voec066DR@shell.armlinux.org.uk>
 <20240112115205.000043b0@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112115205.000043b0@Huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi Jonathan,

On Fri, Jan 12, 2024 at 11:52:05AM +0000, Jonathan Cameron wrote:
> On Thu, 11 Jan 2024 10:26:15 +0000
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > @@ -2381,16 +2388,38 @@ EXPORT_SYMBOL_GPL(acpi_dev_clear_dependencies);
> >   * acpi_dev_ready_for_enumeration - Check if the ACPI device is ready for enumeration
> >   * @device: Pointer to the &struct acpi_device to check
> >   *
> > - * Check if the device is present and has no unmet dependencies.
> > + * Check if the device is functional or enabled and has no unmet dependencies.
> >   *
> > - * Return true if the device is ready for enumeratino. Otherwise, return false.
> > + * Return true if the device is ready for enumeration. Otherwise, return false.
> >   */
> >  bool acpi_dev_ready_for_enumeration(const struct acpi_device *device)
> >  {
> >  	if (device->flags.honor_deps && device->dep_unmet)
> >  		return false;
> >  
> > -	return acpi_device_is_present(device);
> > +	/*
> > +	 * ACPI 6.5's 6.3.7 "_STA (Device Status)" allows firmware to return
> > +	 * (!present && functional) for certain types of devices that should be
> > +	 * enumerated. Note that the enabled bit should not be set unless the
> > +	 * present bit is set.
> > +	 *
> > +	 * However, limit this only to processor devices to reduce possible
> > +	 * regressions with firmware.
> > +	 */
> > +	if (device->status.functional)
> > +		return true;

I have a report from within Oracle that this causes testing failures
with QEMU using -smp cpus=2,maxcpus=4. I think it needs to be:

	if (!device->status.present)
		return device->status.functional;

	if (device->status.enabled)
		return true;

	return !acpi_device_is_processor(device);

So we can better understand the history here, let's list it as a
truth table. P=present, F=functional, E=enabled, Orig=how the code
is in mainline, James=James' original proposal, Rafael=the proposed
replacement but seems to be buggy, Rmk=the fixed version that passes
tests:

P F E	Orig	James	Rafael		Rmk
0 0 0	0	0	0		0
0 0 1	0	0	0		0
0 1 0	1	1	1		1
0 1 1	1	0	1		1
1 0 0	1	0	!processor	!processor
1 0 1	1	1	1		1
1 1 0	1	0	1		!processor
1 1 1	1	1	1		1

Any objections to this?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

