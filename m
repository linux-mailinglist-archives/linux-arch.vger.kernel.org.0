Return-Path: <linux-arch+bounces-1088-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21328814D44
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 17:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550341C23D2A
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 16:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F008F3DBA9;
	Fri, 15 Dec 2023 16:38:41 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641613D396;
	Fri, 15 Dec 2023 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SsFGt2jlqz67LyQ;
	Sat, 16 Dec 2023 00:36:38 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3075A1400D4;
	Sat, 16 Dec 2023 00:38:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Dec
 2023 16:38:36 +0000
Date: Fri, 15 Dec 2023 16:38:35 +0000
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
	<jianyong.wu@arm.com>, <justin.he@arm.com>, James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 15/21] irqchip/gic-v3: Add support for ACPI's
 disabled but 'online capable' CPUs
Message-ID: <20231215163835.00005d02@Huawei.com>
In-Reply-To: <E1rDOh2-00Dvl1-H6@rmk-PC.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
	<E1rDOh2-00Dvl1-H6@rmk-PC.armlinux.org.uk>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 13 Dec 2023 12:50:28 +0000
Russell King (Oracle) <rmk+kernel@armlinux.org.uk> wrote:

> From: James Morse <james.morse@arm.com>
> 
> To support virtual CPU hotplug, ACPI has added an 'online capable' bit
> to the MADT GICC entries. This indicates a disabled CPU entry may not
> be possible to online via PSCI until firmware has set enabled bit in
> _STA.
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
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Seems resonable, but this contains the blob that makes the change I called
out in the previous patch relevant. With a forwards reference in that patch.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ----
> Disabled but online-capable CPUs cause this message to be printed
> if their redistributors are described via GICC:
> | GICv3: CPU 3's redistributor is inaccessible: this CPU can't be brought online
> 
> If ACPI's _STA tries to make the cpu present later, this message is printed:
> | Changing CPU present bit is not supported
> 
> Changes since RFC v2:
>  * use gicc->flags & (ACPI_MADT_ENABLED | ACPI_MADT_GICC_CPU_CAPABLE)
> ---
>  drivers/irqchip/irq-gic-v3.c | 14 ++++++++++++++
>  include/linux/acpi.h         |  2 +-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index ebecd4546830..6d0f98d3540e 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -2370,11 +2370,25 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
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
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 19d009ca9e7a..00be66683505 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -238,7 +238,7 @@ void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
>  
>  static inline bool acpi_gicc_is_usable(struct acpi_madt_generic_interrupt *gicc)
>  {
> -	return gicc->flags & ACPI_MADT_ENABLED;
> +	return gicc->flags & (ACPI_MADT_ENABLED | ACPI_MADT_GICC_CPU_CAPABLE);

This is where the change is made that broke the code path in
the previous patch.  No problem with splitting that across patches but maybe call out
why in the patch intro for previous patch.

>  }
>  
>  /* the following numa functions are architecture-dependent */


