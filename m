Return-Path: <linux-arch+bounces-931-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1860880F756
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 20:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49CB81C20D1B
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 19:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3C752751;
	Tue, 12 Dec 2023 19:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vw1L6XLY"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AC68E;
	Tue, 12 Dec 2023 11:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tzSIob+ZloljYLW+tLDyKC/69ft7pcQwsMOiIXpJIok=; b=vw1L6XLYMrjE3sFENIwANCt1v3
	7cAzma3wPHfPcHoG9wwkMxGWUzWDApvWXx2iDNH1wm+zJnUto1Pm0srAC0ESTdJFqRhA5HgZkecv8
	6ZxXy2SdOV32NspEw3waqQJesyFiNyElMKU1mfQ7hGyutNpt8Eu8Cl0dTo9npe2YUMHIcFLtUzR2U
	r0CtlsCPasqY8qOEIs+t339Sv6zjT1PVHzSLP70GRefywlApYbHkmdsoRLcx9nXuUlWRQTuyIkVQH
	vfIu2gbTC4MCO7Zmq8ZOWgZZVe6GhwFIl7d/pw5GgsMAFTOUidPZyLz8lj/YwebHDzhG7lGYuwBiP
	2nXhXZXA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33796)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rD8u0-0007MS-0Z;
	Tue, 12 Dec 2023 19:58:48 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rD8ty-0000ih-JG; Tue, 12 Dec 2023 19:58:46 +0000
Date: Tue, 12 Dec 2023 19:58:46 +0000
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
	James Morse <james.morse@arm.com>
Subject: Re: [RFC PATCH v3 00/39] ACPI/arm64: add support for virtual
 cpuhotplug
Message-ID: <ZXi7do4mVfdsz/k0@shell.armlinux.org.uk>
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
 <CAJZ5v0j-73_+9U3ngDAf9w1ADDhBTKctJdWboqUk-okH2TQGyg@mail.gmail.com>
 <ZW4ZBkj2oCmxv55T@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZW4ZBkj2oCmxv55T@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Dec 04, 2023 at 06:23:02PM +0000, Russell King (Oracle) wrote:
> On Tue, Oct 24, 2023 at 08:26:58PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Oct 24, 2023 at 5:15 PM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > Hi,
> > >
> > > I'm posting James' patch set updated with most of the review comments
> > > from his RFC v2 series back in September. Individual patches have a
> > > changelog attached at the bottom of the commit message. Those which
> > > I have finished updating have my S-o-b on them, those which still have
> > > outstanding review comments from RFC v2 do not. In some of these cases
> > > I've asked questions and am waiting for responses.
> > >
> > > I'm posting this as RFC v3 because there's still some unaddressed
> > > comments and it's clearly not ready for merging. Even if it was ready
> > > to be merged, it is too late in this development cycle to be taking
> > > this change in, so there would be little point posting it non-RFC.
> > > Also James stated that he's waiting for confirmation from the
> > > Kubernetes/Kata folk - I have no idea what the status is there.
> > >
> > > I will be sending each patch individually to a wider audience
> > > appropriate for that patch - apologies to those missing out on this
> > > cover message. I have added more mailing lists to the series with the
> > > exception of the acpica list in a hope of this cover message also
> > > reaching those folk.
> > >
> > > The changes that aren't included are:
> > >
> > > 1. Updates for my patch that was merged via Thomas (thanks!):
> > >    c4dd854f740c cpu-hotplug: Provide prototypes for arch CPU registration
> > >    rather than having this change spread through James' patches.
> > >
> > > 2. New patch - simplification of PA-RISC's smp_prepare_boot_cpu()
> > >
> > > 3. Moved "ACPI: Use the acpi_device_is_present() helper in more places"
> > >    and "ACPI: Rename acpi_scan_device_not_present() to be about
> > >    enumeration" to the beginning of the series - these two patches are
> > >    already queued up for merging into 6.7.
> > >
> > > 4. Moved "arm64, irqchip/gic-v3, ACPI: Move MADT GICC enabled check into
> > >    a helper" to the beginning of the series, which has been submitted,
> > >    but as yet the fate of that posting isn't known.
> > >
> > > The first four patches in this series are provided for completness only.
> > >
> > > There is an additional patch in James' git tree that isn't in the set
> > > of patches that James posted: "ACPI: processor: Only call
> > > arch_unregister_cpu() if HOTPLUG_CPU is selected" which looks to me to
> > > be a workaround for arch_unregister_cpu() being under the ifdef. I've
> > > commented on this on the RFC v2 posting making a suggestion, but as yet
> > > haven't had any response.
> > >
> > > I've included almost all of James' original covering body below the
> > > diffstat.
> > >
> > > The reason that I'm doing this is to help move this code forward so
> > > hopefully it can be merged - which is why I have been keen to dig out
> > > from James' patches anything that can be merged and submit it
> > > separately, since this is a feature for which some users have a
> > > definite need for.
> > 
> > I've gone through the series and there is at least one thing in it
> > that concerns me a lot and some others that at least appear to be
> > really questionable.
> > 
> > I need more time to send comments which I'm not going to do before the
> > 6.7 merge window (sorry), but from what I can say right now, this is
> > not looking good.
> 
> Hi Rafael,
> 
> Will you be able to send your comments, so that we can find out what
> your other concerns are please? I'm getting questions from interested
> parties who want to know what your concerns are.
> 
> Nothing much has changed to the ACPI changes, so I think it's still
> valid to have the comments back for this.

Hi Rafael,

Another gentle prod on this...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

