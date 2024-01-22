Return-Path: <linux-arch+bounces-1432-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F198375AB
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 22:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1473D1F28B44
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 21:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C90482DB;
	Mon, 22 Jan 2024 21:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XtyKsMO6"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8277482D1;
	Mon, 22 Jan 2024 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705960594; cv=none; b=i8hjAvBWh8M9rJmYc5rKtMPrDFRlkZwR0w3mSwok36IeojqP+uYxDGK+0UJPizqLBPLXR/FseBQ1Ru7e2xAP6GMzRKtoMWLymdBUTzGhQ3Jj+kOqU9dO0bArlL0Jge4HAFdkGKwf94bVycri2uve7MUgDPNOemvS8CKsc4uPqn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705960594; c=relaxed/simple;
	bh=J8tuHVuaRf99BTjAxEXGtJuL5FiKMuM5URapCqBOWYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNMZvzMP28Cr9njWSm5dY5LwhGYOwmexYPGCarCthcqhhELbhXYnTof+hy9NZM+MBh2/BI8HqqLQ1Fu3hjDX5aKleAdRXsNlW/k+DsDnZgCL0cb4w6GvxIyYC/Ks7WaTBStMInOzsSWk6h2NUgVWxrx3JvUa1kNKImiIw+3r3HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XtyKsMO6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DlkxdPo00vFXMtifZbwmiD3pZWcfGIoDSDnanNUdXxo=; b=XtyKsMO6Yn2dYk1lNRNde3BiDP
	un+RAJyMR6k8+9e/yJl2r+Ov0qOcDIbhiz/y/7GX3fw87B0GNJ/3HmCLVJiLb2Ks1V96LgACams6f
	cX+obUMvFpeX/Pmcl6RnUH2y50c9vxvFy0DDxefuB+2qrsso/uyXuGtyvj3A9FRQHRH/QBhxa5OTm
	Zz/RSWt46rOm+BHPj4216FX8QXMjUNV0DnJe0jlcqUzpr7YBglGllncVFHK+j40azOzpeA1xvOtkS
	tXvN5txsFycplH3UgwgXX380INC6PxDJ2P3HQ+KLP+EUK49pbp89QiATkRHw/56ttdlNvv/I2Oqdt
	A0vRazAA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50158)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rS2HI-0001cI-2Q;
	Mon, 22 Jan 2024 21:56:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rS2HC-0001MW-T5; Mon, 22 Jan 2024 21:56:18 +0000
Date: Mon, 22 Jan 2024 21:56:18 +0000
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
Subject: Re: [PATCH RFC v3 04/21] ACPI: processor: Register all CPUs from
 acpi_processor_get_info()
Message-ID: <Za7kglu6qO1n5ZCg@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
 <E1rDOg7-00Dvjq-VZ@rmk-PC.armlinux.org.uk>
 <CAJZ5v0je=-oVnSumZs=dzcyVuVUeVeTgO7yOnjGg1igyrS7EHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0je=-oVnSumZs=dzcyVuVUeVeTgO7yOnjGg1igyrS7EHQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Dec 18, 2023 at 09:30:50PM +0100, Rafael J. Wysocki wrote:
> On Wed, Dec 13, 2023 at 1:49 PM Russell King <rmk+kernel@armlinux.org.uk> wrote:
> > Systems can still be booted with 'acpi=off', or not include an
> > ACPI description at all. For these, the CPUs continue to be
> > registered by cpu_dev_register_generic().
> >
> > This moves the CPU register logic back to a subsys_initcall(),
> > while the memory nodes will have been registered earlier.
> 
> Isn't this somewhat risky?

Not really. The earlier full series moved the registration of CPUs
from subsys (by the various architecture specific code) into the
driver core - thus moving it much earlier. This patch merely
restores it back to the subsys initialisation stage.

There is a low chance that something _could_ have become reliant
on that change - and the longer it takes for this change to be
merged, the more risk there is that something could become reliant
on CPUs being registered very early.

Maybe this ought to be spelt out more explicitly that it's merely
restoring the point at which CPUs are registered.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

