Return-Path: <linux-arch+bounces-1471-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBA28394CF
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 17:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ABD82839D5
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 16:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D0B7F7F7;
	Tue, 23 Jan 2024 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aI5GPVMb"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BF3481C7;
	Tue, 23 Jan 2024 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027779; cv=none; b=AXg/hzX82jAoYMNfaWKNGs/lB3o5cEP/D041eIdf6HaZX5qAb3mzxUUdSl+TdCc5qCvFOm+sooHGZ1ve3jc3BzeMO/7fifj/770hQuIXCDpK7XKA5B2lrqArgYSOduywl/yJ1+NJUZm2e0LJ7pxBPZCwxb7wZ45D6WHA1U3tpCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027779; c=relaxed/simple;
	bh=mg1lFDQ2Cc93Q00sMStqVpL8+TpnAXOykvzRqppkaQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0Scfbg1Z/gzHRuWrJjoA+z5/Ebm6hwAPcegNSscf7HLuQfnKrHblKIAcPuWODreYeaxEX+Y5fv0DfzEt3TxV5Kr8KjQ8vhpqkbvFWm1zt0oFaccUDwboWd7/raOch78pqWLT59LpiCdstos6824CI2Tu9Oxm81VmzbZQsv+yCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aI5GPVMb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=l/85CMUwYvGkFstcoi4Kb56LZAx3H/rR4TH74ZR+ABU=; b=aI5GPVMbgrAMQLi/sxpdR2JIEB
	lD7i+cyhbu5o25Cq3bZOXaKDk8cy0Gmn/iCiM5grQc/Lgv5UbI2usWWgflQ0WEMXvX/i374t61Sp8
	JXyHiJfmV1B9tBrrumUkhF4+2QzxPqvR5LjPfK1GpAcTrn3pSCZ87oSUkCMmgZSbzgtfIgXTUbGZP
	B5aJXDK7/UCVmXh2ORo8l0dcCzSBAvDFBXvN+X/ZZMVGJlp1VT7uYvVFvsMO6r3OCSG3dac52Kz7r
	dhMY/wsZf7J+sYDfDey0TJCtGdPZSb8do/Sgu6OnmJ1nLj94n0+uoVuMExEsGDtLPU++QWS5/6er8
	75aVPHTQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33630)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rSJkv-0002kH-2j;
	Tue, 23 Jan 2024 16:36:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rSJks-00025O-9V; Tue, 23 Jan 2024 16:36:06 +0000
Date: Tue, 23 Jan 2024 16:36:06 +0000
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
Message-ID: <Za/q9jivG4OdZM0f@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
 <E1rDOgD-00Dvk2-3h@rmk-PC.armlinux.org.uk>
 <CAJZ5v0g9nfLrEf9u4Ksw6BOWJQ9iv8Z-O8RsLU6jR5zk0ahxRw@mail.gmail.com>
 <20240122180013.000016d5@Huawei.com>
 <Za++/11n5KA1VS3p@shell.armlinux.org.uk>
 <CAJZ5v0h7wsLt8d3ZoLXsK1=crAx66T42WDKNoHcg8CiHpAjS8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h7wsLt8d3ZoLXsK1=crAx66T42WDKNoHcg8CiHpAjS8g@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 23, 2024 at 05:15:54PM +0100, Rafael J. Wysocki wrote:
> On Tue, Jan 23, 2024 at 2:28 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Mon, Jan 22, 2024 at 06:00:13PM +0000, Jonathan Cameron wrote:
> > > On Mon, 18 Dec 2023 21:35:16 +0100
> > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > >
> > > > On Wed, Dec 13, 2023 at 1:49 PM Russell King <rmk+kernel@armlinux.org.uk> wrote:
> > > > >
> > > > > From: James Morse <james.morse@arm.com>
> > > > >
> > > > > The code behind ACPI_HOTPLUG_CPU allows a not-present CPU to become
> > > > > present.
> > > >
> > > > Right.
> > > >
> > > > > This isn't the only use of HOTPLUG_CPU. On arm64 and riscv
> > > > > CPUs can be taken offline as a power saving measure.
> > > >
> > > > But still there is the case in which a non-present CPU can become
> > > > present, isn't it there?
> > >
> > > Not yet defined by the architectures (and I'm assuming it probably never will be).
> > >
> > > The original proposal we took to ARM was to do exactly that - they pushed
> > > back hard on the basis there was no architecturally safe way to implement it.
> > > Too much of the ARM arch has to exist from the start of time.
> > >
> > > https://lore.kernel.org/linux-arm-kernel/cbaa6d68-6143-e010-5f3c-ec62f879ad95@arm.com/
> > > is one of the relevant threads of the kernel side of that discussion.
> > >
> > > Not to put specific words into the ARM architects mouths, but the
> > > short description is that there is currently no demand for working
> > > out how to make physical CPU hotplug possible, as such they will not
> > > provide an architecturally compliant way to do it for virtual CPU hotplug and
> > > another means is needed (which is why this series doesn't use the present bit
> > > for that purpose and we have the Online capable bit in MADT/GICC)
> > >
> > > It was a 'fun' dance of several years to get to that clarification.
> > > As another fun fact, the same is defined for x86, but I don't think
> > > anyone has used it yet (GICC for ARM has an online capable bit in the flags to
> > > enable this, which was remarkably similar to the online capable bit in the
> > > flags of the Local APIC entries as added fairly recently).
> > >
> > > >
> > > > > On arm64 an offline CPU may be disabled by firmware, preventing it from
> > > > > being brought back online, but it remains present throughout.
> > > > >
> > > > > Adding code to prevent user-space trying to online these disabled CPUs
> > > > > needs some additional terminology.
> > > > >
> > > > > Rename the Kconfig symbol CONFIG_ACPI_HOTPLUG_PRESENT_CPU to reflect
> > > > > that it makes possible CPUs present.
> > > >
> > > > Honestly, I don't think that this change is necessary or even useful.
> > >
> > > Whilst it's an attempt to avoid future confusion, the rename is
> > > not something I really care about so my advice to Russell is drop
> > > it unless you are attached to it!
> >
> > While I agree that it isn't a necessity, I don't fully agree that it
> > isn't useful.
> >
> > One of the issues will be that while Arm64 will support hotplug vCPU,
> > it won't be setting ACPI_HOTPLUG_CPU because it doesn't support
> > the present bit changing. So I can see why James decided to rename
> > it - because with Arm64's hotplug vCPU, the idea that ACPI_HOTPLUG_CPU
> > somehow enables hotplug CPU support is now no longer true.
> >
> > Keeping it as ACPI_HOTPLUG_CPU makes the code less obvious, because it
> > leads one to assume that it ought to be enabled for Arm64's
> > implementatinon, and that could well cause issues in the future if
> > people make the assumption that "ACPI_HOTPLUG_CPU" means hotplug CPU
> > is supported in ACPI. It doesn't anymore.
> 
> On x86 there is no confusion AFAICS.  It's always meant "as long as
> the platform supports it".

That's x86, which supports physical CPU hotplug. We're introducing
support for Arm64 here which doesn't support physical CPU hotplug.

						ACPI-based	Physical	Virtual
Arch	HOTPLUG_CPU	ACPI_HOTPLUG_CPU	Hotplug		Hotplug		Hotplug
Arm64	Y		N			Y		N		Y
x86	Y		Y			Y		Y		Y

So ACPI_HOTPLUG_CPU becomes totally misnamed with the introduction
of hotplug on Arm64.

If we want to just look at stuff from an x86 perspective, then yes,
it remains correct to call it ACPI_HOTPLUG_CPU. It isn't correct as
soon as we add Arm64, as I already said.

And honestly, a two line quip to my reasoned argument is not IMHO
an acceptable reply.

... getting close to throwing the rag in over this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

