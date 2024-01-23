Return-Path: <linux-arch+bounces-1445-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7548C839033
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 14:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4408E286E72
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 13:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DBD604B0;
	Tue, 23 Jan 2024 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IdnEp3jB"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E53660269;
	Tue, 23 Jan 2024 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016519; cv=none; b=RrY/7ZmXD7f5Oa74rTuDpwtXjZeDdXImS6RlK+rA6oIcavy1+vUqHJ7TyZpkHmetR+QRtERrqTVWhPFaDoKaTLgZ47s4Jds6o9UAUr1hj0BvdHtCngZWR2lAuf8/Z1JmNDH1CpuTsYCBbAVMBGAxrL9r1c7311ErFzO/h7bhp1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016519; c=relaxed/simple;
	bh=NJc04YeV9kOqCLAh9fn3kVyDWlVh70iAMeCv/H6zMYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWagO0MgOSSzdvq20IOnL1kIO18VtdhuhIwghW+9s2Xh8rLRhc1Qg/xMYZYVv3Mi3CUppU+Fzl+I4Sq7bVB04dQ8FJpj8WyY5RvsKmlHlnqZ+qLci6VF+lUe0GXv2M8JtMdjRRDj3GbonoSiP4AhRHLi3TWxS0zqwNB1nEze7Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IdnEp3jB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bDhJF4aVPbj4qdYQrzDaOMUJoNeiDqHjPb9iFMH77ME=; b=IdnEp3jBKIndIWP5XIcwMJoMZK
	VXAFBeu/Bv043OgntYF4+y/xj9qap4lxUJj/TR17iVnq4OTkxCGofK+sQd0TfJJd2l7haKwWUVxfU
	ZJf9cDAC9ySAxC+NkZQn2KbyP01YUyuVx2Wd9QLC1WmInPbkvTtHosurY6tHla6fMQSlKB+iOcLw0
	3z1303J4SsJlIPCGZI1Q5n/8BCxks6XJq2hl5U000/f/yLcwbfqMyQRfn7uwgnT5Eo4Oy/uzxSGIX
	3OtPDik/U9GB1G5G40b6fP6tQ/K61kRvCxs7BJHtd+K/BfdeBoFp6jBvSaRd+AiGP0aW5GW3rJGXs
	1F0TkSkg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42766)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rSGpM-0002S5-2a;
	Tue, 23 Jan 2024 13:28:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rSGpL-0001z0-LP; Tue, 23 Jan 2024 13:28:31 +0000
Date: Tue, 23 Jan 2024 13:28:31 +0000
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
Subject: Re: [PATCH RFC v3 05/21] ACPI: Rename ACPI_HOTPLUG_CPU to include
 'present'
Message-ID: <Za++/11n5KA1VS3p@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
 <E1rDOgD-00Dvk2-3h@rmk-PC.armlinux.org.uk>
 <CAJZ5v0g9nfLrEf9u4Ksw6BOWJQ9iv8Z-O8RsLU6jR5zk0ahxRw@mail.gmail.com>
 <20240122180013.000016d5@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240122180013.000016d5@Huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 22, 2024 at 06:00:13PM +0000, Jonathan Cameron wrote:
> On Mon, 18 Dec 2023 21:35:16 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> 
> > On Wed, Dec 13, 2023 at 1:49 PM Russell King <rmk+kernel@armlinux.org.uk> wrote:
> > >
> > > From: James Morse <james.morse@arm.com>
> > >
> > > The code behind ACPI_HOTPLUG_CPU allows a not-present CPU to become
> > > present.  
> > 
> > Right.
> > 
> > > This isn't the only use of HOTPLUG_CPU. On arm64 and riscv
> > > CPUs can be taken offline as a power saving measure.  
> > 
> > But still there is the case in which a non-present CPU can become
> > present, isn't it there?
> 
> Not yet defined by the architectures (and I'm assuming it probably never will be).
> 
> The original proposal we took to ARM was to do exactly that - they pushed
> back hard on the basis there was no architecturally safe way to implement it.
> Too much of the ARM arch has to exist from the start of time.
> 
> https://lore.kernel.org/linux-arm-kernel/cbaa6d68-6143-e010-5f3c-ec62f879ad95@arm.com/
> is one of the relevant threads of the kernel side of that discussion.
> 
> Not to put specific words into the ARM architects mouths, but the
> short description is that there is currently no demand for working
> out how to make physical CPU hotplug possible, as such they will not
> provide an architecturally compliant way to do it for virtual CPU hotplug and
> another means is needed (which is why this series doesn't use the present bit
> for that purpose and we have the Online capable bit in MADT/GICC)
> 
> It was a 'fun' dance of several years to get to that clarification.
> As another fun fact, the same is defined for x86, but I don't think
> anyone has used it yet (GICC for ARM has an online capable bit in the flags to
> enable this, which was remarkably similar to the online capable bit in the
> flags of the Local APIC entries as added fairly recently).
> 
> > 
> > > On arm64 an offline CPU may be disabled by firmware, preventing it from
> > > being brought back online, but it remains present throughout.
> > >
> > > Adding code to prevent user-space trying to online these disabled CPUs
> > > needs some additional terminology.
> > >
> > > Rename the Kconfig symbol CONFIG_ACPI_HOTPLUG_PRESENT_CPU to reflect
> > > that it makes possible CPUs present.  
> > 
> > Honestly, I don't think that this change is necessary or even useful.
> 
> Whilst it's an attempt to avoid future confusion, the rename is
> not something I really care about so my advice to Russell is drop
> it unless you are attached to it!

While I agree that it isn't a necessity, I don't fully agree that it
isn't useful.

One of the issues will be that while Arm64 will support hotplug vCPU,
it won't be setting ACPI_HOTPLUG_CPU because it doesn't support
the present bit changing. So I can see why James decided to rename
it - because with Arm64's hotplug vCPU, the idea that ACPI_HOTPLUG_CPU
somehow enables hotplug CPU support is now no longer true.

Keeping it as ACPI_HOTPLUG_CPU makes the code less obvious, because it
leads one to assume that it ought to be enabled for Arm64's
implementatinon, and that could well cause issues in the future if
people make the assumption that "ACPI_HOTPLUG_CPU" means hotplug CPU
is supported in ACPI. It doesn't anymore.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

