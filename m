Return-Path: <linux-arch+bounces-3946-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFFD8B1865
	for <lists+linux-arch@lfdr.de>; Thu, 25 Apr 2024 03:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518401F23E5C
	for <lists+linux-arch@lfdr.de>; Thu, 25 Apr 2024 01:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA73FBA42;
	Thu, 25 Apr 2024 01:20:39 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E232599;
	Thu, 25 Apr 2024 01:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714008039; cv=none; b=dNu2qFvD27vmNZQ/YdDmPoIN6pw5xO9OtEP2k2HDJQNug7We9yyJOuyX3nUFmwAgwLh5wEPtq2FqWCdKMiDdJjyHaPfbO5x2JhXXuJZ4a/JjBi0V0L3fwELInkqeP1hgEzlYtClvFcWoIevWITwBH7dwNm+7lIqrxv9h7W1UUJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714008039; c=relaxed/simple;
	bh=zL62D1yctwFMaxehdNJzXgBvgzYkbKTm0HHQpGl9Tf0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DxW2UP44elLFzkVpoc12CZW/5IAFWUEAoF56oltxkrUByPP7y1zXfIOHWFU3uuppCXRxBFN0SDh/T/SkeT2J4MehYFHVTx9iUa3eJORZyzXzDPiNyaOIK8cdlaESeQ81kPyQn25zQqrpaH8ovXRb8Szzy1ME1SMvy4r8AXGwYYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VPydF6KhCztT1D;
	Thu, 25 Apr 2024 09:17:21 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (unknown [7.185.36.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C9A7180080;
	Thu, 25 Apr 2024 09:20:33 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 09:20:32 +0800
Subject: Re: [PATCH v7 04/16] ACPI: processor: Move checks and availability of
 acpi_processor earlier
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, James Morse
	<james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <linuxarm@huawei.com>, <justin.he@arm.com>,
	<jianyong.wu@arm.com>
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
 <20240418135412.14730-5-Jonathan.Cameron@huawei.com>
 <0cfc4e2d-65ab-0040-2c7d-fad83f32455b@huawei.com>
 <20240424181857.00000e0f@Huawei.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <56cdbd13-d7c8-4f02-64f0-216b72847e45@huawei.com>
Date: Thu, 25 Apr 2024 09:20:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240424181857.00000e0f@Huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)

On 2024/4/25 1:18, Jonathan Cameron wrote:
> On Tue, 23 Apr 2024 19:53:34 +0800
> Hanjun Guo <guohanjun@huawei.com> wrote:
> 
>>> @@ -232,6 +263,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
>>>    	acpi_status status = AE_OK;
>>>    	static int cpu0_initialized;
>>>    	unsigned long long value;
>>> +	int ret;
>>>    
>>>    	acpi_processor_errata();
>>>    
>>> @@ -316,10 +348,12 @@ static int acpi_processor_get_info(struct acpi_device *device)
>>>    	 *  because cpuid <-> apicid mapping is persistent now.
>>>    	 */
>>>    	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
>>> -		int ret = acpi_processor_hotadd_init(pr);
>>> +		ret = acpi_processor_hotadd_init(pr, device);
>>>    
>>>    		if (ret)
>>> -			return ret;
>>> +			goto err;
>>> +	} else {
>>> +		acpi_processor_set_per_cpu(pr, device);
>>>    	}
>>>    
>>>    	/*
>>> @@ -357,6 +391,10 @@ static int acpi_processor_get_info(struct acpi_device *device)
>>>    		arch_fix_phys_package_id(pr->id, value);
>>>    
>>>    	return 0;
>>> +
>>> +err:
>>> +	per_cpu(processors, pr->id) = NULL;
>>
>> ...
>>
>>> +	return ret;
>>>    }
>>>    
>>>    /*
>>> @@ -365,8 +403,6 @@ static int acpi_processor_get_info(struct acpi_device *device)
>>>     * (cpu_data(cpu)) values, like CPU feature flags, family, model, etc.
>>>     * Such things have to be put in and set up by the processor driver's .probe().
>>>     */
>>> -static DEFINE_PER_CPU(void *, processor_device_array);
>>> -
>>>    static int acpi_processor_add(struct acpi_device *device,
>>>    					const struct acpi_device_id *id)
>>>    {
>>> @@ -395,28 +431,6 @@ static int acpi_processor_add(struct acpi_device *device,
>>>    	if (result) /* Processor is not physically present or unavailable */
>>>    		return 0;
>>>    
>>> -	BUG_ON(pr->id >= nr_cpu_ids);
>>> -
>>> -	/*
>>> -	 * Buggy BIOS check.
>>> -	 * ACPI id of processors can be reported wrongly by the BIOS.
>>> -	 * Don't trust it blindly
>>> -	 */
>>> -	if (per_cpu(processor_device_array, pr->id) != NULL &&
>>> -	    per_cpu(processor_device_array, pr->id) != device) {
>>> -		dev_warn(&device->dev,
>>> -			"BIOS reported wrong ACPI id %d for the processor\n",
>>> -			pr->id);
>>> -		/* Give up, but do not abort the namespace scan. */
>>> -		goto err;
>>> -	}
>>> -	/*
>>> -	 * processor_device_array is not cleared on errors to allow buggy BIOS
>>> -	 * checks.
>>> -	 */
>>> -	per_cpu(processor_device_array, pr->id) = device;
>>> -	per_cpu(processors, pr->id) = pr;
>>
>> Nit: seems we need to remove the duplicated
>> per_cpu(processors, pr->id) = NULL; in acpi_processor_add():
>>
>> --- a/drivers/acpi/acpi_processor.c
>> +++ b/drivers/acpi/acpi_processor.c
>> @@ -446,7 +446,6 @@ static int acpi_processor_add(struct acpi_device
>> *device,
>>     err:
>>           free_cpumask_var(pr->throttling.shared_cpu_map);
>>           device->driver_data = NULL;
>> -       per_cpu(processors, pr->id) = NULL;
> 
> I don't follow.  This path is used if processor_get_info() succeeded and
> we later fail.  I don't see where the the duplication is?

It is! Thanks for the clarification.

Thanks
Hanjun

