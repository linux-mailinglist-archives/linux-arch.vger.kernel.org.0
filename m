Return-Path: <linux-arch+bounces-3786-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8A28A94C2
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 10:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9CA31F22960
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 08:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ABB13E404;
	Thu, 18 Apr 2024 08:16:40 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA2513A86D;
	Thu, 18 Apr 2024 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713428199; cv=none; b=KCgngxxqePKnhpLLT3/VgVEhqEgSfiDuErulacpcu+dFj9wDBJ5YvtvPCHitjZu4AM0Y5TfvZEh1v/C++oN520EzQVBzAYBRef8jFHqzpSQIYr3js3Z7Ti53J4Do8uy1XQkaPB1rm2+iYpFBvnmyDMcyEAXnd0CMK6ZNekEtC9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713428199; c=relaxed/simple;
	bh=+sCIQ6w4afRiSlqasIZfv0b05YQ2xgJ9KieX+ucnx74=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XLtsxpPVTJjMz06wLKrcUebsOP/1hh7v4961F2+XSCN1clSpfSMg/UAhDwJkWkatABYJjOKmLSmFYqXMmCbaAT52b9Tgi4KwxCZVcApdj0k+/k+rgTuYtkT48jwAb01AZKL3PZdrW38XSsbcknG1YvDejmWeJdsAjMvCHqaeFxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKr8L2MwSz6D9BV;
	Thu, 18 Apr 2024 16:11:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 256E5140519;
	Thu, 18 Apr 2024 16:16:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Apr
 2024 09:16:28 +0100
Date: Thu, 18 Apr 2024 09:16:27 +0100
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
Subject: Re: [PATCH v6 04/16] ACPI: processor: Move checks and availability
 of acpi_processor earlier
Message-ID: <20240417174707.00002e86@huawei.com>
In-Reply-To: <20240417131909.7925-5-Jonathan.Cameron@huawei.com>
References: <20240417131909.7925-1-Jonathan.Cameron@huawei.com>
 <20240417131909.7925-5-Jonathan.Cameron@huawei.com>
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

On Wed, 17 Apr 2024 14:18:57 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Make the per_cpu(processors, cpu) entries available earlier so that
> they are available in arch_register_cpu() as ARM64 will need access
> to the acpi_handle to distinguish between acpi_processor_add()
> and earlier registration attempts (which will fail as _STA cannot
> be checked).
> 
> Reorder the remove flow to clear this per_cpu() after
> arch_unregister_cpu() has completed, allowing it to be used in
> there as well.
> 
> Note that on x86 for the CPU hotplug case, the pr->id prior to
> acpi_map_cpu() may be invalid. Thus the per_cpu() structures
> must be initialized after that call or after checking the ID
> is valid (not hotplug path).
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v6: As per discussion in v5 thread, don't use the cpu->dev and
>     make this data available earlier by moving the assignment checks
>     int acpi_processor_get_info().
> ---
>  drivers/acpi/acpi_processor.c | 79 +++++++++++++++++++++--------------
>  1 file changed, 47 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index ba0a6f0ac841..2c164451ab53 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -184,7 +184,35 @@ static void __init acpi_pcc_cpufreq_init(void) {}
>  
>  /* Initialization */
>  #ifdef CONFIG_ACPI_HOTPLUG_CPU
Note I messed up a rebase here.  This ifdef should come after the new function
(see later)

Will fix for v7.
> -static int acpi_processor_hotadd_init(struct acpi_processor *pr)
> +static DEFINE_PER_CPU(void *, processor_device_array);
> +
> +static void acpi_processor_set_per_cpu(struct acpi_processor *pr,
> +				       struct acpi_device *device)
> +{
> +	BUG_ON(pr->id >= nr_cpu_ids);
> +	/*
> +	 * Buggy BIOS check.
> +	 * ACPI id of processors can be reported wrongly by the BIOS.
> +	 * Don't trust it blindly
> +	 */
> +	if (per_cpu(processor_device_array, pr->id) != NULL &&
> +	    per_cpu(processor_device_array, pr->id) != device) {
> +		dev_warn(&device->dev,
> +			 "BIOS reported wrong ACPI id %d for the processor\n",
> +			 pr->id);
> +		/* Give up, but do not abort the namespace scan. */
> +		return;
> +	}
> +	/*
> +	 * processor_device_array is not cleared on errors to allow buggy BIOS
> +	 * checks.
> +	 */
> +	per_cpu(processor_device_array, pr->id) = device;
> +	per_cpu(processors, pr->id) = pr;
> +}
> +

The ifdef should be here as...

> +static int acpi_processor_hotadd_init(struct acpi_processor *pr,
> +				      struct acpi_device *device)
>  {
>  	int ret;
>  
> @@ -198,6 +226,8 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
>  	if (ret)
>  		goto out;
>  
> +	acpi_processor_set_per_cpu(pr, device);
> +
>  	ret = arch_register_cpu(pr->id);
>  	if (ret) {
>  		acpi_unmap_cpu(pr->id);
> @@ -217,7 +247,8 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
>  	return ret;
>  }
>  #else
> -static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
> +static inline int acpi_processor_hotadd_init(struct acpi_processor *pr,
> +					     struct acpi_device *device)
>  {
>  	return -ENODEV;
>  }
> @@ -232,6 +263,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
>  	acpi_status status = AE_OK;
>  	static int cpu0_initialized;
>  	unsigned long long value;
> +	int ret;
>  
>  	acpi_processor_errata();
>  
> @@ -316,10 +348,12 @@ static int acpi_processor_get_info(struct acpi_device *device)
>  	 *  because cpuid <-> apicid mapping is persistent now.
>  	 */
>  	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
> -		int ret = acpi_processor_hotadd_init(pr);
> +		ret = acpi_processor_hotadd_init(pr, device);
>  
>  		if (ret)
> -			return ret;
> +			goto err;
> +	} else {
> +		acpi_processor_set_per_cpu(pr, device);

This is not covered by CONFIG_ACPI_HOTPLUG_CPU

>  	}



