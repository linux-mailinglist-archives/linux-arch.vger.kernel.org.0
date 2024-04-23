Return-Path: <linux-arch+bounces-3905-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DC58ADDC5
	for <lists+linux-arch@lfdr.de>; Tue, 23 Apr 2024 08:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29F4D1F22F04
	for <lists+linux-arch@lfdr.de>; Tue, 23 Apr 2024 06:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0F52B2CF;
	Tue, 23 Apr 2024 06:49:19 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EFD31A8F;
	Tue, 23 Apr 2024 06:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713854959; cv=none; b=MKf+dcw4rSmj/AaPG+ZRRfYrwA5WJaWx03OTZ6nNPZMHQR1AzPtNM+NSnELSv0Vs/nRlk/J2VcV+YXtYE4e2q4TGXiwkSmsJYea/L/zQAguP7KmDxYFaJkctJxYSDIYI90lKejpgWP59PCXWmwr3j/KNcgBHBH2Kf+AocCOPN+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713854959; c=relaxed/simple;
	bh=Aq1VgWGzGQgF1/SQ+Vi/rmVivciffKOD9w3vnI5XwbU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FQoluyPncW/S4bngjQb/QsmF7fVRAizwO7NBZmPe6cH/bgeaNB/zFB42l9x7Ly3rPkA483FTn2UYf48uqGV10zZ6n6zy+FrsjH/Sf+cANzLUsH3L2d/UtKWFDzjhPvmQoR2sL2FzyOVcvRKT0itBN9MRJHCwlCMZmiI0ERVxmQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VNt166W9szXlvc;
	Tue, 23 Apr 2024 14:45:46 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (unknown [7.185.36.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 98DAC140427;
	Tue, 23 Apr 2024 14:49:14 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 14:49:13 +0800
Subject: Re: [PATCH v7 03/16] ACPI: processor: Drop duplicated check on _STA
 (enabled + present)
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Thomas Gleixner
	<tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
	<linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, <x86@kernel.org>, Russell King
	<linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>, Miguel
 Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, <linuxarm@huawei.com>,
	<justin.he@arm.com>, <jianyong.wu@arm.com>
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
 <20240418135412.14730-4-Jonathan.Cameron@huawei.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <c13f7424-3a7f-4c3e-3e8d-81e9fcf0caf7@huawei.com>
Date: Tue, 23 Apr 2024 14:49:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240418135412.14730-4-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)

On 2024/4/18 21:53, Jonathan Cameron wrote:
> The ACPI bus scan will only result in acpi_processor_add() being called
> if _STA has already been checked and the result is that the
> processor is enabled and present.  Hence drop this additional check.
> 
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v7: No change
> v6: New patch to drop this unnecessary code. Now I think we only
>      need to explicitly read STA to print a warning in the ARM64
>      arch_unregister_cpu() path where we want to know if the
>      present bit has been unset as well.
> ---
>   drivers/acpi/acpi_processor.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 7fc924aeeed0..ba0a6f0ac841 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -186,17 +186,11 @@ static void __init acpi_pcc_cpufreq_init(void) {}
>   #ifdef CONFIG_ACPI_HOTPLUG_CPU
>   static int acpi_processor_hotadd_init(struct acpi_processor *pr)
>   {
> -	unsigned long long sta;
> -	acpi_status status;
>   	int ret;
>   
>   	if (invalid_phys_cpuid(pr->phys_id))
>   		return -ENODEV;
>   
> -	status = acpi_evaluate_integer(pr->handle, "_STA", NULL, &sta);
> -	if (ACPI_FAILURE(status) || !(sta & ACPI_STA_DEVICE_PRESENT))
> -		return -ENODEV;
> -
>   	cpu_maps_update_begin();
>   	cpus_write_lock();

Since the status bits were checked before acpi_processor_add() being
called, do we need to remove the if (!acpi_device_is_enabled(device))
check in acpi_processor_add() as well?

Thanks
Hanjun

