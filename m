Return-Path: <linux-arch+bounces-1774-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B059840999
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 16:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2666028C0C1
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 15:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484EE155A40;
	Mon, 29 Jan 2024 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XPirihBl"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650DF153BD7;
	Mon, 29 Jan 2024 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541422; cv=none; b=P2BQGLDVqUNHFQVBdoXQEPYXy5WPFgkSc3xLt3RXSQ4jBBb4FvRpqFMamrIIFE4p3QaoIq+9Dqslatde3Fx9//YVg9nvPqlMSueN2OWcJoEA06qZTx7QqXdM8JbuERqGJ+BcONs0jkxfVM04/YSYoOjphygHFJbDjjUhgBm710w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541422; c=relaxed/simple;
	bh=3Nso3RAPlpi4tQMZv/DRHSv/5C/+syfOdDGfCD8LWEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEym8esRkjPZ5M3pRm0VVNLC4SnHoyH8d/tbcgQXhaMqdHbngRv6rtHgWNdLGtVSFNdeQeAIYq3/0ysyOWLagqNv1vBsS6ffWts/77Wi1uWnICd8aMszTyEzhV3/Jt+v5WGi5BBA8HKwTwW4geayBp4gyiWUgn5ofkeeYoL+mwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XPirihBl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=98Gr9ITR366GR6pU9VeYRdKpJCJHm8fElGj3k6A8yhQ=; b=XPirihBlNGWgXcIxNottRzcHGS
	NoDXCharW/9OS/EVteV5i5UEkYdapJIGEis1ZIPLbbJarGR3tDTlk9DQdykevMyYiBM22zXTWlJtv
	l/ASau/dV30a1KcQZ1PRAwizv1rWCgTgTUcsZJ4f0+s5kR0GnJU+5Yuxt2ixt4dEPcNY4EZkharl1
	Kkb9pv1otyt7lkLicWQlhfAq564HCDlX/tSE6QnXWmCmGTk2trVwgwSQDZwC+fua5mF5NmHYGrn0Z
	Si8uI1ArLvDovc9gHZ10bH1dfhdlYxx95pVaY4Z9Co+XhQ8IpJaUv453QExZXwxFeqqZ34/TVR5YZ
	z0Az2T1Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48498)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rUTNV-0000Zx-1f;
	Mon, 29 Jan 2024 15:16:53 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rUTNS-0004ei-Ql; Mon, 29 Jan 2024 15:16:50 +0000
Date: Mon, 29 Jan 2024 15:16:50 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
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
Message-ID: <ZbfBYgdLzvEX/VjN@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
 <ZXxxa+XZjPZtNfJ+@shell.armlinux.org.uk>
 <20231215161539.00000940@Huawei.com>
 <5760569.DvuYhMxLoT@kreacher>
 <20240102143925.00004361@Huawei.com>
 <20240111101949.000075dc@Huawei.com>
 <ZZ/CR/6Voec066DR@shell.armlinux.org.uk>
 <20240112115205.000043b0@Huawei.com>
 <Zbe8WQRASx6D6RaG@shell.armlinux.org.uk>
 <CAJZ5v0iba93EhQB2k3LMdb2YczndbRmF5WGRYHhnqCHq6TQJ0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iba93EhQB2k3LMdb2YczndbRmF5WGRYHhnqCHq6TQJ0A@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 29, 2024 at 04:05:42PM +0100, Rafael J. Wysocki wrote:
> On Mon, Jan 29, 2024 at 3:55 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > Hi Jonathan,
> >
> > On Fri, Jan 12, 2024 at 11:52:05AM +0000, Jonathan Cameron wrote:
> > > On Thu, 11 Jan 2024 10:26:15 +0000
> > > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > > > @@ -2381,16 +2388,38 @@ EXPORT_SYMBOL_GPL(acpi_dev_clear_dependencies);
> > > >   * acpi_dev_ready_for_enumeration - Check if the ACPI device is ready for enumeration
> > > >   * @device: Pointer to the &struct acpi_device to check
> > > >   *
> > > > - * Check if the device is present and has no unmet dependencies.
> > > > + * Check if the device is functional or enabled and has no unmet dependencies.
> > > >   *
> > > > - * Return true if the device is ready for enumeratino. Otherwise, return false.
> > > > + * Return true if the device is ready for enumeration. Otherwise, return false.
> > > >   */
> > > >  bool acpi_dev_ready_for_enumeration(const struct acpi_device *device)
> > > >  {
> > > >     if (device->flags.honor_deps && device->dep_unmet)
> > > >             return false;
> > > >
> > > > -   return acpi_device_is_present(device);
> > > > +   /*
> > > > +    * ACPI 6.5's 6.3.7 "_STA (Device Status)" allows firmware to return
> > > > +    * (!present && functional) for certain types of devices that should be
> > > > +    * enumerated. Note that the enabled bit should not be set unless the
> > > > +    * present bit is set.
> > > > +    *
> > > > +    * However, limit this only to processor devices to reduce possible
> > > > +    * regressions with firmware.
> > > > +    */
> > > > +   if (device->status.functional)
> > > > +           return true;
> >
> > I have a report from within Oracle that this causes testing failures
> > with QEMU using -smp cpus=2,maxcpus=4. I think it needs to be:
> >
> >         if (!device->status.present)
> >                 return device->status.functional;
> >
> >         if (device->status.enabled)
> >                 return true;
> >
> >         return !acpi_device_is_processor(device);
> 
> The above is fine by me.
> 
> > So we can better understand the history here, let's list it as a
> > truth table. P=present, F=functional, E=enabled, Orig=how the code
> > is in mainline, James=James' original proposal, Rafael=the proposed
> > replacement but seems to be buggy, Rmk=the fixed version that passes
> > tests:
> >
> > P F E   Orig    James   Rafael          Rmk
> > 0 0 0   0       0       0               0
> > 0 0 1   0       0       0               0
> > 0 1 0   1       1       1               1
> > 0 1 1   1       0       1               1
> > 1 0 0   1       0       !processor      !processor
> > 1 0 1   1       1       1               1
> > 1 1 0   1       0       1               !processor
> > 1 1 1   1       1       1               1
> >
> > Any objections to this?
> 
> So AFAIAC it can return false if not enabled, but present and
> functional.  [Side note: I'm wondering what "functional" means then,
> but whatever.]

From ACPI v6.5 (bit 3 is our "status.functional":

 _STA may return bit 0 clear (not present) with bit [3] set (device is
 functional). This case is used to indicate a valid device for which no
 device driver should be loaded (for example, a bridge device.) Children
 of this device may be present and valid. OSPM should continue
 enumeration below a device whose _STA returns this bit combination.

So, for this case, acpi_dev_ready_for_enumeration() returning true for
this case is correct, since we're supposed to enumerate it and child
devices.

It's probably also worth pointing out that in the above table, the two
combinations with P=0 E=1 goes against the spec, but are included for
completness.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

