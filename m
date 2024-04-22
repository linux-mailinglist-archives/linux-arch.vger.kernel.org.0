Return-Path: <linux-arch+bounces-3884-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F50F8ACB13
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 12:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 818E7B2268E
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 10:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9B21474C2;
	Mon, 22 Apr 2024 10:40:26 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898FF145FEE;
	Mon, 22 Apr 2024 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782426; cv=none; b=d+Nb7oaWBsw3uI+EtQ7WUfFdtDbqdNV84F/VAi6wMm5ted9IKS7zD3mJ00Ny9Pl/gdw71xPJ0t1RnID6wOs7IqJDPVkae0j/e7TT3Z1FPP5bIfmyUl+R4OVfKf8p7X3k9tmjI8YijcltkSdQJrT+kyblrOuWqonqYSLwSlUpx2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782426; c=relaxed/simple;
	bh=WESzDnZr/ZbZRFMVHV7KsfSq/ogLXqrvN6/XlpZVySI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OECx92nNfQHq3XL39WOKD6MsqSuiTXIz+WQF4PpAk/vyfqWjeyTkqlIpFH8DXO/avNSS7C3UIW+Rq01KQZeZaFL+Ma1rk8GQc9LrMfcD/yJ33wkU4Ke76FI3HJ6TzBV3K4u9rampH/DRYaLx3hNrz1mN2QFcCV5AvQfYV1J9o5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VNMCf3ykfz6K6RQ;
	Mon, 22 Apr 2024 18:38:06 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 25D08140AE5;
	Mon, 22 Apr 2024 18:40:22 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 22 Apr
 2024 11:40:21 +0100
Date: Mon, 22 Apr 2024 11:40:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, "James Morse"
	<james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	<linuxarm@huawei.com>, Marc Zyngier <maz@kernel.org>
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, <justin.he@arm.com>,
	<jianyong.wu@arm.com>
Subject: Re: [PATCH v7 11/16] irqchip/gic-v3: Add support for ACPI's
 disabled but 'online capable' CPUs
Message-ID: <20240422114020.0000294f@Huawei.com>
In-Reply-To: <20240418135412.14730-12-Jonathan.Cameron@huawei.com>
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
	<20240418135412.14730-12-Jonathan.Cameron@huawei.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 18 Apr 2024 14:54:07 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

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
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

+CC Marc,

Whilst this has been unchanged for a long time, I'm not 100% sure
we've specifically drawn your attention to it before now.

Jonathan

> 
> ---
> v7: No Change.
> ---
>  drivers/irqchip/irq-gic-v3.c | 21 +++++++++++++++++++--
>  include/linux/acpi.h         |  3 ++-
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 10af15f93d4d..66132251c1bb 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -2363,11 +2363,25 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
>  				(struct acpi_madt_generic_interrupt *)header;
>  	u32 reg = readl_relaxed(acpi_data.dist_base + GICD_PIDR2) & GIC_PIDR2_ARCH_MASK;
>  	u32 size = reg == GIC_PIDR2_ARCH_GICv4 ? SZ_64K * 4 : SZ_64K * 2;
> +	int cpu = get_cpu_for_acpi_id(gicc->uid);
>  	void __iomem *redist_base;
>  
>  	if (!acpi_gicc_is_usable(gicc))
>  		return 0;
>  
> +	/*
> +	 * Capable but disabled CPUs can be brought online later. What about
> +	 * the redistributor? ACPI doesn't want to say!
> +	 * Virtual hotplug systems can use the MADT's "always-on" GICR entries.
> +	 * Otherwise, prevent such CPUs from being brought online.
> +	 */
> +	if (!(gicc->flags & ACPI_MADT_ENABLED)) {
> +		pr_warn_once("CPU %u's redistributor is inaccessible: this CPU can't be brought online\n", cpu);
> +		set_cpu_present(cpu, false);
> +		set_cpu_possible(cpu, false);
> +		return 0;
> +	}
> +
>  	redist_base = ioremap(gicc->gicr_base_address, size);
>  	if (!redist_base)
>  		return -ENOMEM;
> @@ -2413,9 +2427,12 @@ static int __init gic_acpi_match_gicc(union acpi_subtable_headers *header,
>  
>  	/*
>  	 * If GICC is enabled and has valid gicr base address, then it means
> -	 * GICR base is presented via GICC
> +	 * GICR base is presented via GICC. The redistributor is only known to
> +	 * be accessible if the GICC is marked as enabled. If this bit is not
> +	 * set, we'd need to add the redistributor at runtime, which isn't
> +	 * supported.
>  	 */
> -	if (acpi_gicc_is_usable(gicc) && gicc->gicr_base_address)
> +	if (gicc->flags & ACPI_MADT_ENABLED && gicc->gicr_base_address)
>  		acpi_data.enabled_rdists++;
>  
>  	return 0;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 9844a3f9c4e5..fcfb7bb6789e 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -239,7 +239,8 @@ void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
>  
>  static inline bool acpi_gicc_is_usable(struct acpi_madt_generic_interrupt *gicc)
>  {
> -	return gicc->flags & ACPI_MADT_ENABLED;
> +	return gicc->flags & (ACPI_MADT_ENABLED |
> +			      ACPI_MADT_GICC_ONLINE_CAPABLE);
>  }
>  
>  /* the following numa functions are architecture-dependent */


