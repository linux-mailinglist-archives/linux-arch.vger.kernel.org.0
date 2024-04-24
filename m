Return-Path: <linux-arch+bounces-3930-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2556B8B10F6
	for <lists+linux-arch@lfdr.de>; Wed, 24 Apr 2024 19:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06C128B0DD
	for <lists+linux-arch@lfdr.de>; Wed, 24 Apr 2024 17:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E181016F286;
	Wed, 24 Apr 2024 17:24:55 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A53416EC12;
	Wed, 24 Apr 2024 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979495; cv=none; b=IL59b8+N8ryYAjQZeAJG8C2cljknJdVgpwVGLR8x3DQ5Ec8NAydCKIhwkE2XIo27FXSqbc71jR9p66V5QySF0ENMbPYIRe6cnDQFyepv1d5i3LteO8bWvGs6JY/02W/dzstG+9+ULTc5kH64m5aa/tyAMAAHASUdYiCRYu3f2jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979495; c=relaxed/simple;
	bh=LKqpVipEJ5RO7oa344mviLVllKDE6mTQjJzr3s4gB5I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ndfz/xkRVSZfGvdr0jKWg8ap8eZZ1RVWwBjvtkprlWF+Xjw60qjVs0Kajov3UByuTWOFaSJWHxvvbqG1E4CIBT7Iw/hhGhAuhdEG+4n+BKpPy2RqEwMq2F35CEdM9OgBCQ4wHd3HB6+gDTn7xRM5yY7pJI0j1Uj5QWXanO61aeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VPm5J2bxkz6K6Lt;
	Thu, 25 Apr 2024 01:22:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 30DCB140A34;
	Thu, 25 Apr 2024 01:24:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 24 Apr
 2024 18:24:50 +0100
Date: Wed, 24 Apr 2024 18:24:50 +0100
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
	<linuxarm@huawei.com>
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, <justin.he@arm.com>,
	<jianyong.wu@arm.com>
Subject: Re: [PATCH v7 14/16] arm64: Kconfig: Enable hotplug CPU on arm64 if
 ACPI_PROCESSOR is enabled.
Message-ID: <20240424182450.0000694f@Huawei.com>
In-Reply-To: <20240418135412.14730-15-Jonathan.Cameron@huawei.com>
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
	<20240418135412.14730-15-Jonathan.Cameron@huawei.com>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 18 Apr 2024 14:54:10 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> In order to move arch_register_cpu() to be called via the same path
> for initially present CPUs described by ACPI and hotplugged CPUs
> ACPI_HOTPLUG_CPU needs to be enabled.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v7: No change.
> ---
>  arch/arm64/Kconfig       |  1 +
>  arch/arm64/kernel/acpi.c | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7b11c98b3e84..fed7d0d54179 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -5,6 +5,7 @@ config ARM64
>  	select ACPI_CCA_REQUIRED if ACPI
>  	select ACPI_GENERIC_GSI if ACPI
>  	select ACPI_GTDT if ACPI
> +	select ACPI_HOTPLUG_CPU if ACPI_PROCESSOR
>  	select ACPI_IORT if ACPI
>  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>  	select ACPI_MCFG if (ACPI && PCI)
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index dba8fcec7f33..a74e80d58df3 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -29,6 +29,7 @@
>  #include <linux/pgtable.h>
>  
>  #include <acpi/ghes.h>
> +#include <acpi/processor.h>
>  #include <asm/cputype.h>
>  #include <asm/cpu_ops.h>
>  #include <asm/daifflags.h>
> @@ -413,6 +414,21 @@ void arch_reserve_mem_area(acpi_physical_address addr, size_t size)
>  	memblock_mark_nomap(addr, size);
>  }
>  
> +#ifdef CONFIG_ACPI_HOTPLUG_CPU
> +int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 apci_id,
> +		 int *pcpu)
> +{

There are shipping firmware's in the wild that have DSDT entries for
way more CPUs than are actually present and don't bother with niceties like
providing _STA() methods.

As such, we need to check somewhere that the pcpu after this call is valid.

Given today this only applies to arm64 (as the x86 code has an implementation
of this function that will replace an invalid ID with a valid one) I'll add
a small catch here.

	if (*pcpu < 0) {
		pr_warn("Unable to map from CPU ACPI ID to anything useful\n");
		return -EINVAL;
	}

I'll have an entirely polite discussion with the relevant team at somepoint, but
on the plus side this is a sensible bit of hardening.

Jonathan

p.s. I want all those other cores!!!!

> +	return 0;
> +}
> +EXPORT_SYMBOL(acpi_map_cpu); /* check why */
> +
> +int acpi_unmap_cpu(int cpu)
> +{
> +	return 0;
> +}
> +EXPORT_SYMBOL(acpi_unmap_cpu);
> +#endif /* CONFIG_ACPI_HOTPLUG_CPU */
> +
>  #ifdef CONFIG_ACPI_FFH
>  /*
>   * Implements ARM64 specific callbacks to support ACPI FFH Operation Region as


