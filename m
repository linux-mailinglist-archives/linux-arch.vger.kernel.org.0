Return-Path: <linux-arch+bounces-2003-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CABB847542
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 17:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AFFA1C21BE7
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 16:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318FB1487DD;
	Fri,  2 Feb 2024 16:47:08 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A8014830C;
	Fri,  2 Feb 2024 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892428; cv=none; b=S01rtwxBfKT0lSB+W6oZ+ZxSPglsyOVA3e0wdPAR6I6Q29pSZry0ETpvlRuVo6wwr/Theow5ytEfhCYLd7IfxELTVINP5Jrvceyp/eoGb8sHWaRfPXkZmYbsI4py+IhEqLptVh8Jf2cOdFWED6fc3dIb5DOzo2AQsmx3RZ2pJh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892428; c=relaxed/simple;
	bh=26hBVqodoG9bwdGKyK7l/MWn5xbCFjtAsU0T6ZD6m6M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tGCX/XDcgZufefGwKeg3eORGih46qLBnUXy3npb2cNTP2acM+GnVQxCPyfBFetW3gIizZh1J1Xu8jKKYXpYNxuMugj1yDhuHeA8bfPGeZIVecdK6yYQuEtGE/I238EFnKZO6rLTETmdVglpJt+MqSCVIINodliQrUk8C3RKsiLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TRM6d5P4Bz6K7G4;
	Sat,  3 Feb 2024 00:43:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 822581400CD;
	Sat,  3 Feb 2024 00:47:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 2 Feb
 2024 16:47:02 +0000
Date: Fri, 2 Feb 2024 16:47:02 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
CC: <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, <acpica-devel@lists.linuxfoundation.org>,
	<linux-csky@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-ia64@vger.kernel.org>, <linux-parisc@vger.kernel.org>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	<jianyong.wu@arm.com>, <justin.he@arm.com>, James Morse
	<james.morse@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RFC v4 11/15] irqchip/gic-v3: Add support for ACPI's
 disabled but 'online capable' CPUs
Message-ID: <20240202164702.00001c5b@Huawei.com>
In-Reply-To: <E1rVDnE-0027ZI-VR@rmk-PC.armlinux.org.uk>
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
	<E1rVDnE-0027ZI-VR@rmk-PC.armlinux.org.uk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 31 Jan 2024 16:50:32 +0000
Russell King (Oracle) <rmk+kernel@armlinux.org.uk> wrote:

> From: James Morse <james.morse@arm.com>
> 
> To support virtual CPU hotplug, ACPI has added an 'online capable' bit
> to the MADT GICC entries. This indicates a disabled CPU entry may not
> be possible to online via PSCI until firmware has set enabled bit in
> _STA.
> 
> This means that a "usable" GIC is one that is marked as either enabled,
> or online capable. Therefore, change acpi_gicc_is_usable() to check both
> bits. However, we need to change the test in gic_acpi_match_gicc() back
> to testing just the enabled bit so the count of enabled distributors is
> correct.
> 
> What about the redistributor in the GICC entry? ACPI doesn't want to say.
> Assume the worst: When a redistributor is described in the GICC entry,
> but the entry is marked as disabled at boot, assume the redistributor
> is inaccessible.
> 
> The GICv3 driver doesn't support late online of redistributors, so this
> means the corresponding CPU can't be brought online either. Clear the
> possible and present bits.
> 
> Systems that want CPU hotplug in a VM can ensure their redistributors
> are always-on, and describe them that way with a GICR entry in the MADT.
> 
> When mapping redistributors found via GICC entries, handle the case
> where the arch code believes the CPU is present and possible, but it
> does not have an accessible redistributor. Print a warning and clear
> the present and possible bits.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



