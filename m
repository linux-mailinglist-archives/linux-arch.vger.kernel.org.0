Return-Path: <linux-arch+bounces-1425-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B54D7836EFB
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 19:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30CBD1F2D4B7
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 18:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE871EF1A;
	Mon, 22 Jan 2024 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RX/YM9Pw"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21AF1366;
	Mon, 22 Jan 2024 17:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944612; cv=none; b=uuceAu28MuarZOoszuwrF8Fmc2A4kI/6lUCdM8bDdRlnDXhSn7F11WD1dNT4pVKOv2NNV6Rryadlk4vBzz60sAoQr3mH7ziBwCMuKumFQQEbc+MWZExKPFXVoJvVjmPy1cxQp9hFEw8Fga4UuvQfjEegH0IY0Ep13Hu70pT8R4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944612; c=relaxed/simple;
	bh=oisddIVCSvEu5TDLFqhbkrWXTfVLsyPwSrs8LV1BFts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ov81L58ca6egF+63MSD9qAnm/gt7yU9hfqQGH2NB9h6eeXp3+QQoDiHmgYk83OxMjJKVHfUUMfYSCu8CXkg8ltGz+qIKPUPPgvXn0zbwrHzMiG/5vC4PFuSRBmrOgwAmdhQCpo/05n3H7VT3uICwFYbfVWtPP99rs7a4KObis4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RX/YM9Pw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tqeHdyzk9+LqVKL+Enz5ftndgdvcVseYfwgC7K5xJtc=; b=RX/YM9PwgXxnH0nCr+3iTk8zEu
	evRNa8qak5GpCSjIuF9kG8Ay111DoUzbNpfuCblFeFkBV/fTl433eI5+zAwCHTum0KS01/4Egw5yl
	CtcuTmz+CxuTQRXWXGvmhc7nGHZlb2VvQz+1yrMEKR7yDDAIdbmQaT5B4MQMK5DwYKhXFzXm9VySw
	jZW0uiJxM2NHvoRc0cunafkRBO7+IXV3Ba5DRwtXMnzKPSFxTpf0q/YJhA0/0zbu9jdfzOawjKtoM
	VbvdA1aeq1giRiAjuDGeujTIeI1BX41XMKWx1yFIWgavtQCfYdrinAa3q975nzSh5mU9bJXuzi2RC
	xS+GfMUg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34032)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rRy7a-0001Gs-09;
	Mon, 22 Jan 2024 17:30:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rRy7Z-0001C6-GD; Mon, 22 Jan 2024 17:30:05 +0000
Date: Mon, 22 Jan 2024 17:30:05 +0000
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
Subject: Re: [PATCH RFC v3 03/21] ACPI: processor: Register CPUs that are
 online, but not described in the DSDT
Message-ID: <Za6mHRJVjb6M1mun@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
 <E1rDOg2-00Dvjk-RI@rmk-PC.armlinux.org.uk>
 <CAJZ5v0ju1JHgpjuFLHZVs4NZiARG6iBZN_wza6c2e0kDhZjK0w@mail.gmail.com>
 <ZaURtUvWQyjYfiiO@shell.armlinux.org.uk>
 <20240122160227.00002d83@Huawei.com>
 <CAJZ5v0hamuXJ_w-TSmVb=5jGide=Lb7sCjbzzNb_rFuPrvkgxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hamuXJ_w-TSmVb=5jGide=Lb7sCjbzzNb_rFuPrvkgxQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 22, 2024 at 05:22:46PM +0100, Rafael J. Wysocki wrote:
> On Mon, Jan 22, 2024 at 5:02 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Mon, 15 Jan 2024 11:06:29 +0000
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> >
> > > On Mon, Dec 18, 2023 at 09:22:03PM +0100, Rafael J. Wysocki wrote:
> > > > On Wed, Dec 13, 2023 at 1:49 PM Russell King <rmk+kernel@armlinux.org.uk> wrote:
> > > > >
> > > > > From: James Morse <james.morse@arm.com>
> > > > >
> > > > > ACPI has two descriptions of CPUs, one in the MADT/APIC table, the other
> > > > > in the DSDT. Both are required. (ACPI 6.5's 8.4 "Declaring Processors"
> > > > > says "Each processor in the system must be declared in the ACPI
> > > > > namespace"). Having two descriptions allows firmware authors to get
> > > > > this wrong.
> > > > >
> > > > > If CPUs are described in the MADT/APIC, they will be brought online
> > > > > early during boot. Once the register_cpu() calls are moved to ACPI,
> > > > > they will be based on the DSDT description of the CPUs. When CPUs are
> > > > > missing from the DSDT description, they will end up online, but not
> > > > > registered.
> > > > >
> > > > > Add a helper that runs after acpi_init() has completed to register
> > > > > CPUs that are online, but weren't found in the DSDT. Any CPU that
> > > > > is registered by this code triggers a firmware-bug warning and kernel
> > > > > taint.
> > > > >
> > > > > Qemu TCG only describes the first CPU in the DSDT, unless cpu-hotplug
> > > > > is configured.
> > > >
> > > > So why is this a kernel problem?
> > >
> > > So what are you proposing should be the behaviour here? What this
> > > statement seems to be saying is that QEMU as it exists today only
> > > describes the first CPU in DSDT.
> >
> > This confuses me somewhat, because I'm far from sure which machines this
> > is true for in QEMU.  I'm guessing it's a legacy thing with
> > some old distro version of QEMU - so we'll have to paper over it anyway
> > but for current QEMU I'm not sure it's true.
> >
> > Helpfully there are a bunch of ACPI table tests so I've been checking
> > through all the multi CPU cases.
> >
> > CPU hotplug not enabled.
> > pc/DSDT.dimmpxm  - 4x Processor entries.  -smp 4
> > pc/DSDT.acpihmat - 2x Processor entries.  -smp 2
> > q35/DSDT.acpihmat - 2x Processor entries. -smp 2
> > virt/DSDT.acpihmatvirt - 4x ACPI0007 entries -smp 4
> > q35/DSDT.acpihmat-noinitiator - 4 x Processor () entries -smp 4
> > virt/DSDT.topology - 8x ACPI0007 entries
> >
> > I've also looked at the code and we have various types of
> > CPU hotplug on x86 but they all build appropriate numbers of
> > Processor() entries in DSDT.
> > Arm likewise seems to build the right number of ACPI0007 entries
> > (and doesn't yet have CPU HP support).
> >
> > If anyone can add a reference on why this is needed that would be very
> > helpful.
> 
> Yes, it would.
> 
> Personally, I would prefer to assume that it is not necessary until it
> turns out that (1) there is firmware with this issue actually in use
> and (2) updating the firmware in question to follow the specification
> is not practical.
> 
> Otherwise, we'd make it easier to ship non-compliant firmware for no
> good reason.

If Salil can't come up with a reason, then I'm in favour of dropping
the patch like already done for patch 2. If the code change serves no
useful purpose, there's no point in making the change.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

