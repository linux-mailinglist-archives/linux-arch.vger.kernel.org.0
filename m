Return-Path: <linux-arch+bounces-1476-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C347C839917
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 20:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E2D6B293D6
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 19:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A402128391;
	Tue, 23 Jan 2024 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vRan/bi5"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEC91272A6;
	Tue, 23 Jan 2024 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036380; cv=none; b=e1JlcbZGmxNM5QMCllcGX5jlyv5jzpyJCNW0bDfkE7vncYvPJFp+7/6bIqSwYM7lS9Zrrj2FOJCC+t2zu6NGqxx9vHCZzqX0YeTm8RLoNF3HXPaJgPFT3IUUCsKlFuOEUiZ95OngHSuBX7dUmu0vUrTyS/hYhWQDd3ol2uFFRow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036380; c=relaxed/simple;
	bh=ySjjUg8RzP9A8J42QkRInGL0nGJUmL/zFsBqrhAgj8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCzjY3qvHU9lu8YgphwkfmakTJaTxre1XlcrAzE9aTw4tcnr1A8PW4az9fLQR23G+Boc33PIkSJsrgcmrDyICrdFvgqNhysx0E2pPY8v4wm8ZJtCyDcKaV7hfrFarw6pu5t/rLlevX+GDgQqupVM9BP2iswIBh8+XA7xTW4dQbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vRan/bi5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=c7jyabwg/Gcd391zhMBEMP+D/5cte4n4suwF6Q62H+Y=; b=vRan/bi5apyC8dSGoST/c20x/k
	PM0LwwOzHGfZlPtpiITE+/lkbpOpKKBYOfsLG6ACL6Yxg1Vb4il5vPHhWQe6ozY5tGKd/82KiTys3
	EoC+HHy5VRm03Ci4xBoIxLEwpYi3zYSQ2pfRQQGMvw6JWJpFRjP2orPSU0pgJ5CQV6O9aCG5maeAN
	sgZGvB0UnbS0ua4lwnWxCPhPXTWOCBeHhmMbc0ESG0TDKbl8MxSxre21VhI7u+Gk3q4uB44mfwuvO
	kEy0kjBSW+uk5PfoZljPtxySgnIKxzmUUeXj5gI7uN4fEnqMocKZ8/Sw+VVAfFuz/22sg6jXLQ851
	zPCWsuzA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57364)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rSLze-0002xN-0p;
	Tue, 23 Jan 2024 18:59:30 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rSLzZ-0002Ah-Ly; Tue, 23 Jan 2024 18:59:25 +0000
Date: Tue, 23 Jan 2024 18:59:25 +0000
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
Subject: Re: [PATCH RFC v3 05/21] ACPI: Rename ACPI_HOTPLUG_CPU to include
 'present'
Message-ID: <ZbAMjZoybVfiAGcT@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
 <E1rDOgD-00Dvk2-3h@rmk-PC.armlinux.org.uk>
 <CAJZ5v0g9nfLrEf9u4Ksw6BOWJQ9iv8Z-O8RsLU6jR5zk0ahxRw@mail.gmail.com>
 <20240122180013.000016d5@Huawei.com>
 <Za++/11n5KA1VS3p@shell.armlinux.org.uk>
 <CAJZ5v0h7wsLt8d3ZoLXsK1=crAx66T42WDKNoHcg8CiHpAjS8g@mail.gmail.com>
 <Za/q9jivG4OdZM0f@shell.armlinux.org.uk>
 <CAJZ5v0gwe02uzAQoX0QDHo35OTEozpbnqC6vukjM3aE6HMq9WQ@mail.gmail.com>
 <ZbADTBLDEFtdglho@shell.armlinux.org.uk>
 <CAJZ5v0jh-EdrnjkJep++UDo+Uv4hmR7VV4KYVdF4CK2K+5XLtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jh-EdrnjkJep++UDo+Uv4hmR7VV4KYVdF4CK2K+5XLtg@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 23, 2024 at 07:26:57PM +0100, Rafael J. Wysocki wrote:
> On Tue, Jan 23, 2024 at 7:20 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Tue, Jan 23, 2024 at 06:43:59PM +0100, Rafael J. Wysocki wrote:
> > > On Tue, Jan 23, 2024 at 5:36 PM Russell King (Oracle)
> > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > On Tue, Jan 23, 2024 at 05:15:54PM +0100, Rafael J. Wysocki wrote:
> > > > > On Tue, Jan 23, 2024 at 2:28 PM Russell King (Oracle)
> > > > > <linux@armlinux.org.uk> wrote:
> > > > > >
> > > > > > On Mon, Jan 22, 2024 at 06:00:13PM +0000, Jonathan Cameron wrote:
> > > > > > > On Mon, 18 Dec 2023 21:35:16 +0100
> > > > > > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > > > > >
> > > > > > > > On Wed, Dec 13, 2023 at 1:49 PM Russell King <rmk+kernel@armlinux.org.uk> wrote:
> > > > > > > > >
> > > > > > > > > From: James Morse <james.morse@arm.com>
> > > > > > > > >
> > > > > > > > > The code behind ACPI_HOTPLUG_CPU allows a not-present CPU to become
> > > > > > > > > present.
> > > > > > > >
> > > > > > > > Right.
> > > > > > > >
> > > > > > > > > This isn't the only use of HOTPLUG_CPU. On arm64 and riscv
> > > > > > > > > CPUs can be taken offline as a power saving measure.
> > > > > > > >
> > > > > > > > But still there is the case in which a non-present CPU can become
> > > > > > > > present, isn't it there?
> > > > > > >
> > > > > > > Not yet defined by the architectures (and I'm assuming it probably never will be).
> > > > > > >
> > > > > > > The original proposal we took to ARM was to do exactly that - they pushed
> > > > > > > back hard on the basis there was no architecturally safe way to implement it.
> > > > > > > Too much of the ARM arch has to exist from the start of time.
> > > > > > >
> > > > > > > https://lore.kernel.org/linux-arm-kernel/cbaa6d68-6143-e010-5f3c-ec62f879ad95@arm.com/
> > > > > > > is one of the relevant threads of the kernel side of that discussion.
> > > > > > >
> > > > > > > Not to put specific words into the ARM architects mouths, but the
> > > > > > > short description is that there is currently no demand for working
> > > > > > > out how to make physical CPU hotplug possible, as such they will not
> > > > > > > provide an architecturally compliant way to do it for virtual CPU hotplug and
> > > > > > > another means is needed (which is why this series doesn't use the present bit
> > > > > > > for that purpose and we have the Online capable bit in MADT/GICC)
> > > > > > >
> > > > > > > It was a 'fun' dance of several years to get to that clarification.
> > > > > > > As another fun fact, the same is defined for x86, but I don't think
> > > > > > > anyone has used it yet (GICC for ARM has an online capable bit in the flags to
> > > > > > > enable this, which was remarkably similar to the online capable bit in the
> > > > > > > flags of the Local APIC entries as added fairly recently).
> > > > > > >
> > > > > > > >
> > > > > > > > > On arm64 an offline CPU may be disabled by firmware, preventing it from
> > > > > > > > > being brought back online, but it remains present throughout.
> > > > > > > > >
> > > > > > > > > Adding code to prevent user-space trying to online these disabled CPUs
> > > > > > > > > needs some additional terminology.
> > > > > > > > >
> > > > > > > > > Rename the Kconfig symbol CONFIG_ACPI_HOTPLUG_PRESENT_CPU to reflect
> > > > > > > > > that it makes possible CPUs present.
> > > > > > > >
> > > > > > > > Honestly, I don't think that this change is necessary or even useful.
> > > > > > >
> > > > > > > Whilst it's an attempt to avoid future confusion, the rename is
> > > > > > > not something I really care about so my advice to Russell is drop
> > > > > > > it unless you are attached to it!
> > > > > >
> > > > > > While I agree that it isn't a necessity, I don't fully agree that it
> > > > > > isn't useful.
> > > > > >
> > > > > > One of the issues will be that while Arm64 will support hotplug vCPU,
> > > > > > it won't be setting ACPI_HOTPLUG_CPU because it doesn't support
> > > > > > the present bit changing. So I can see why James decided to rename
> > > > > > it - because with Arm64's hotplug vCPU, the idea that ACPI_HOTPLUG_CPU
> > > > > > somehow enables hotplug CPU support is now no longer true.
> > > > > >
> > > > > > Keeping it as ACPI_HOTPLUG_CPU makes the code less obvious, because it
> > > > > > leads one to assume that it ought to be enabled for Arm64's
> > > > > > implementatinon, and that could well cause issues in the future if
> > > > > > people make the assumption that "ACPI_HOTPLUG_CPU" means hotplug CPU
> > > > > > is supported in ACPI. It doesn't anymore.
> > > > >
> > > > > On x86 there is no confusion AFAICS.  It's always meant "as long as
> > > > > the platform supports it".
> > > >
> > > > That's x86, which supports physical CPU hotplug. We're introducing
> > > > support for Arm64 here which doesn't support physical CPU hotplug.
> > > >
> > > >                                                 ACPI-based      Physical        Virtual
> > > > Arch    HOTPLUG_CPU     ACPI_HOTPLUG_CPU        Hotplug         Hotplug         Hotplug
> > > > Arm64   Y               N                       Y               N               Y
> > > > x86     Y               Y                       Y               Y               Y
> > > >
> > > > So ACPI_HOTPLUG_CPU becomes totally misnamed with the introduction
> > > > of hotplug on Arm64.
> > > >
> > > > If we want to just look at stuff from an x86 perspective, then yes,
> > > > it remains correct to call it ACPI_HOTPLUG_CPU. It isn't correct as
> > > > soon as we add Arm64, as I already said.
> > >
> > > And if you rename it, it becomes less confusing for ARM64, but more
> > > confusing for x86, which basically is my point.
> > >
> > > IMO "hotplug" covers both cases well enough and "hotplug present" is
> > > only accurate for one of them.
> > >
> > > > And honestly, a two line quip to my reasoned argument is not IMHO
> > > > an acceptable reply.
> > >
> > > Well, I'm not even sure how to respond to this ...
> >
> > The above explanation you give would have been useful...
> >
> > I don't see how "hotplug" covers both cases. As I've tried to point
> > out many times now, ACPI_HOTPLUG_CPU is N for Arm64, yet it supports
> > ACPI based hotplug. How does ACPI_HOTPLUG_CPU cover Arm64 if it's
> > N there?
> 
> But IIUC this change is preliminary for changing it (or equivalent
> option with a different name) to Y, isn't it?

No. As I keep saying, ACPI_HOTPLUG_CPU ends up N on Arm64 even when
it supports hotplug CPU via ACPI.

Even with the full Arm64 patch set here, under arch/ we still only
have:

arch/loongarch/Kconfig: select ACPI_HOTPLUG_PRESENT_CPU if ACPI_PROCESSOR && HOTPLUG_CPU
arch/x86/Kconfig:       select ACPI_HOTPLUG_PRESENT_CPU         if ACPI_PROCESSOR && HOTPLUG_CPU

To say it yet again, ACPI_HOTPLUG_(PRESENT_)CPU is *never* set on
Arm64.

> > IMHO it totally doesn't, and moreover, it goes against what
> > one would logically expect - and this is why I have a problem with
> > your effective NAK for this change. I believe you are basically
> > wrong on this for the reasons I've given - that ACPI_HOTPLUG_CPU
> > will be N for Arm64 despite it supporting ACPI-based CPU hotplug.
> 
> So I still have to understand how renaming it for all architectures
> (including x86) is supposed to help.
> 
> It will still be the same option under a different name.  How does
> that change things technically?

Do you think that it makes any sense to have support for ACPI-based
hotplug CPU *and* having it functional with a configuration symbol
named "ACPI_HOTPLUG_CPU" to be set to N ? That's essentially what
you are advocating for...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

