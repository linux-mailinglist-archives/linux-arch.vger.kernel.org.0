Return-Path: <linux-arch+bounces-3546-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 394778A001D
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 20:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 917EEB21A91
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 18:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641122E405;
	Wed, 10 Apr 2024 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Eih04ugn"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC05363E;
	Wed, 10 Apr 2024 18:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712775384; cv=none; b=IiBzD55Heu7H98dBYWYWUST0kQzuuMlYsRxxUc0LalVslUqg70HcKCbhgMz22U+o7RMCuGB3KcwpDo/d3CAHFCOjJsCAiHYvB7dyNqZZlGCUW+k+w/eYrHiMSOfP0xKF9jDC+WLiHzS5K/Ul0aEZFDYuJuRodkrMpFf/EIM9DrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712775384; c=relaxed/simple;
	bh=z8uL29ol4D/VzeVxNrLkekTvpm9qYZqbPbEmZ0BnNKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMqUGRhpYI+3ScR7JZ6Xvhy/jp+0JxEQMskHzRXSrAgjbBgMYYwc2w2wGtp2JDd8iYxfO3KBqS/2mG06IlEvdWHFQeMEnMgWkWrbhCEcAwqvhLBmWJTLVxSR6nrdMFyuRPYsHCspfCsZbhV2xH5viXAlAeMlB+gMCy0apeEDIcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Eih04ugn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U8bqg6vv1xN246qvsvrQZYNVGTMrjTXzu9x/4q0URWY=; b=Eih04ugnqStfjTGj8LCSTHRa8I
	JVKC9gkRyoCXJUkvOs3gxMIVb6pp3NE4PiFgKq38B/dWSfl77kt3RXU5fC9mMMM6OCB3O8hcgUx2S
	Iv1Pl/+4KblR/zsHS7r1cSKoeP4zO0tKaJGaX6F+EpE3lDTPTujdhDVlzVNGQN9/rLbNsvowxTg2K
	CWuVQR8+MaNkHOw8BqdKVjxzsNgCldrupd7faINLxt+omBYy9HAtuQW8d1cgHLKwfslwkV2lecqX8
	goWQIWe7kLglAMnYY1F9r7DLY0WiKdfvrjCoo58dPUxqUlo+NqnwAQtfmvkjDxde80Y5aYlKd0JtS
	qpMjAr0Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38784)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rud77-0008Nd-2R;
	Wed, 10 Apr 2024 19:56:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rud73-0006BQ-2Q; Wed, 10 Apr 2024 19:56:01 +0100
Date: Wed, 10 Apr 2024 19:56:00 +0100
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
Subject: Re: [PATCH RFC v4 02/15] ACPI: processor: Register all CPUs from
 acpi_processor_get_info()
Message-ID: <ZhbgwBBvh6ccdO7x@shell.armlinux.org.uk>
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
 <E1rVDmU-0027YP-Jz@rmk-PC.armlinux.org.uk>
 <CAJZ5v0iiJpUWq5GMSnKFWQTzn_bdwoQz9m=hDaXNg4Lj_ePF4g@mail.gmail.com>
 <20240322185327.00002416@Huawei.com>
 <20240410134318.0000193c@huawei.com>
 <CAJZ5v0ggD042sfz3jDXQVDUxQZu_AWaF2ox-Me8CvFeRB8nczw@mail.gmail.com>
 <20240410145005.00003050@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410145005.00003050@Huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 10, 2024 at 02:50:05PM +0100, Jonathan Cameron wrote:
> If we get rid of this catch all, solution would be to move the
> !acpi_disabled check into the arm64 version of arch_cpu_register()
> because we would only want the delayed registration path to be
> used on ACPI cases where the question of CPU availability can't
> yet be resolved.

Aren't we then needing two arch_register_cpu() implementations?
I'm assuming that you're suggesting that the !acpi_disabled, then
do nothing check is moved into arch_register_cpu() - or to put it
another way, arch_register_cpu() does nothing if ACPI is enabled.

If arch_register_cpu() does nothing if ACPI is enabled, how do
CPUs get registered (and sysfs files get created to control them)
on ACPI systems? ACPI wouldn't be able to call arch_register_cpu(),
so I suspect you'll need an ACPI-specific version of this function.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

