Return-Path: <linux-arch+bounces-4055-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B048B6962
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 06:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D73C21F22115
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 04:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995FB1401B;
	Tue, 30 Apr 2024 04:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HpktrYCe"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FEB12E6A
	for <linux-arch@vger.kernel.org>; Tue, 30 Apr 2024 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714450664; cv=none; b=FDKDizwSixb0lrb1ChN2NnM+8CY3yPzdSDQAYn4IcNUwX9R3EeGcx98W3Z6nCjFY+o7/2RrniI1mnan9d0oInc4Rj7qVzHSGDYfVIk55dC6KKJMdRLxNnR1mvPhiXdT7qa2J57ktgCkjFQlxgwfCMBqlUrC+7vKNHGCxYevmPS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714450664; c=relaxed/simple;
	bh=5z0Em++5LmRCe+NCtNW4e5gRpyGk46rTSheyYeSsu+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JNsES/oUZsFT4OXwh4Sz/FhKvTvVOBtsMPKdKmAimLu2NDrtbapn05WAh36YKOBtY6KQ5lBFZoY76GdSbRlTmdT8Ne7OIzxy2a5F6R0dFG//YEWPHqeMMjrQFtrQnIYe4TpgY8Xch4FoUtkmKN/xF1qaGfoxeCJJLzUaViZwufo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HpktrYCe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714450661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WFct75rj5zT1fcuVMkkp7XGDkSWnsAkN+HgQaZ4kvE4=;
	b=HpktrYCeLgIzEdXNwSsl8G3MCHG5fVOfj02/W8rHHhoU0Uq/jAhzKB8KZuXefyLl4Qxh4D
	cn5JivQzYoepWnvMDPIzvJoI9+1/58WGokQEc66ViVlsz4CU2CS2konV5usIwNleuOsff/
	JgKnRpid3LEEAqj9T66FS4MN2wNi1Ps=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-eqVgrY-qOaOE6YOLQPowyg-1; Tue, 30 Apr 2024 00:17:39 -0400
X-MC-Unique: eqVgrY-qOaOE6YOLQPowyg-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-60a8670c960so5526894a12.3
        for <linux-arch@vger.kernel.org>; Mon, 29 Apr 2024 21:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714450658; x=1715055458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFct75rj5zT1fcuVMkkp7XGDkSWnsAkN+HgQaZ4kvE4=;
        b=S4m2D0xuD/HEaqUiOUgUzFlDSXWHxlXGe4qeyztmAJQ/qzlKgdJ4SicR6KZ7La0Udk
         /OwnfwLOjzrJQV3BEBjoivWE5I13LL8libDkBQI+RobgoDNkwBt2LBdWLE2t5420A9qk
         jD/50WzOmVNindHS6m+WAV0pueGugn7cGvBsGlJW7ZhYuFUFknL6wYuUfMMJvEiREh9p
         tv3PFTk8Fq/UwrzRD7bAQ9DhPpJT1iCZnU9kuc1dW+09nVstECWK3mMotXXCBxaPDuVt
         AGsc8b0+PEYQZtyOcOYax6GSZOw7wyK59ttYs0oVaUbIfpQSqxcOrfn/7zJ+hp3DhgnV
         /woA==
X-Forwarded-Encrypted: i=1; AJvYcCW4Iy+ekr0Jd2W5ZiWQKV5T/gxb0315pgOpg5Bf4bI6NqAlg+xGdb8ZQml49y2NIXjykX5XiToZHn7mWU8FCtAR/MLP6hwOzAFnFA==
X-Gm-Message-State: AOJu0Yw7M5StJ1ZLt3Ro0eJ2fZdBv0m2LjKRTXoAU6r4Go9oX7+pnYEe
	6WVO6I/Tg9zqSbJub+NRPumTYLLsBZ130ktDnI0lZnTE4+DamsMo3zLvyMkm/SmSfQYZIguqEZS
	2kBq2jykZIEplEww1RmXf0rjw1FD9iuEqc6zBXqZV4x9RgER8l4r6E/nFfco=
X-Received: by 2002:a05:6a21:99a1:b0:1aa:5e75:d31f with SMTP id ve33-20020a056a2199a100b001aa5e75d31fmr2010452pzb.16.1714450657968;
        Mon, 29 Apr 2024 21:17:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFES1V3wsak41bo4jYaZviVPRarqHfJAK9UnRag7Jd4ap+/A5BK+dXuv6S+yktJTMceHUvKDw==
X-Received: by 2002:a05:6a21:99a1:b0:1aa:5e75:d31f with SMTP id ve33-20020a056a2199a100b001aa5e75d31fmr2010426pzb.16.1714450657571;
        Mon, 29 Apr 2024 21:17:37 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902680c00b001ec4db46318sm118687plk.232.2024.04.29.21.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 21:17:36 -0700 (PDT)
Message-ID: <80a2e07f-ecb2-48af-b2be-646f17e0e63e@redhat.com>
Date: Tue, 30 Apr 2024 14:17:24 +1000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/16] ACPI: processor: Move checks and availability of
 acpi_processor earlier
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, x86@kernel.org, Russell King
 <linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Miguel Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>,
 Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com,
 justin.he@arm.com, jianyong.wu@arm.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>
References: <20240426135126.12802-1-Jonathan.Cameron@huawei.com>
 <20240426135126.12802-5-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240426135126.12802-5-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/24 23:51, Jonathan Cameron wrote:
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
> 
> ---
> v8: On buggy bios detection when setting per_cpu structures
>      do not carry on.
>      Fix up the clearing of per cpu structures to remove unwanted
>      side effects and ensure an error code isn't use to reference them.
> ---
>   drivers/acpi/acpi_processor.c | 79 +++++++++++++++++++++--------------
>   1 file changed, 48 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index ba0a6f0ac841..3b180e21f325 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -183,8 +183,38 @@ static void __init acpi_pcc_cpufreq_init(void) {}
>   #endif /* CONFIG_X86 */
>   
>   /* Initialization */
> +static DEFINE_PER_CPU(void *, processor_device_array);
> +
> +static bool acpi_processor_set_per_cpu(struct acpi_processor *pr,
> +				       struct acpi_device *device)
> +{
> +	BUG_ON(pr->id >= nr_cpu_ids);

One blank line after BUG_ON() if we need to follow original implementation.

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

It depends on how the return value is handled by the caller if the namespace
is continued to be scanned. The caller can be acpi_processor_hotadd_init()
and acpi_processor_get_info() after this patch is applied. So I think this
specific comment need to be moved to the caller.

Besides, it seems acpi_processor_set_per_cpu() isn't properly called and
memory leakage can happen. More details are given below.

> +		return false;
> +	}
> +	/*
> +	 * processor_device_array is not cleared on errors to allow buggy BIOS
> +	 * checks.
> +	 */
> +	per_cpu(processor_device_array, pr->id) = device;
> +	per_cpu(processors, pr->id) = pr;
> +
> +	return true;
> +}
> +
>   #ifdef CONFIG_ACPI_HOTPLUG_CPU
> -static int acpi_processor_hotadd_init(struct acpi_processor *pr)
> +static int acpi_processor_hotadd_init(struct acpi_processor *pr,
> +				      struct acpi_device *device)
>   {
>   	int ret;
>   
> @@ -198,8 +228,15 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
>   	if (ret)
>   		goto out;
>   
> +	if (!acpi_processor_set_per_cpu(pr, device)) {
> +		acpi_unmap_cpu(pr->id);
> +		goto out;
> +	}
> +

With the 'goto out', zero is returned from acpi_processor_hotadd_init() to acpi_processor_get_info().
The zero return value is carried from acpi_map_cpu() in acpi_processor_hotadd_init(). If I'm correct,
we need return errno from acpi_processor_get_info() to acpi_processor_add() so that cleanup can be
done. For example, the cleanup corresponding to the 'err' tag can be done in acpi_processor_add().
Otherwise, we will have memory leakage.

>   	ret = arch_register_cpu(pr->id);
>   	if (ret) {
> +		/* Leave the processor device array in place to detect buggy bios */
> +		per_cpu(processors, pr->id) = NULL;
>   		acpi_unmap_cpu(pr->id);
>   		goto out;
>   	}
> @@ -217,7 +254,8 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
>   	return ret;
>   }
>   #else
> -static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
> +static inline int acpi_processor_hotadd_init(struct acpi_processor *pr,
> +					     struct acpi_device *device)
>   {
>   	return -ENODEV;
>   }
> @@ -316,10 +354,13 @@ static int acpi_processor_get_info(struct acpi_device *device)
>   	 *  because cpuid <-> apicid mapping is persistent now.
>   	 */
>   	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
> -		int ret = acpi_processor_hotadd_init(pr);
> +		int ret = acpi_processor_hotadd_init(pr, device);
>   
>   		if (ret)
>   			return ret;
> +	} else {
> +		if (!acpi_processor_set_per_cpu(pr, device))
> +			return 0;
>   	}
>   

For non-hotplug case, we still need pass the error to acpi_processor_add() so that
cleanup corresponding 'err' tag can be done. Otherwise, we will have memory leakage.

>   	/*
> @@ -365,8 +406,6 @@ static int acpi_processor_get_info(struct acpi_device *device)
>    * (cpu_data(cpu)) values, like CPU feature flags, family, model, etc.
>    * Such things have to be put in and set up by the processor driver's .probe().
>    */
> -static DEFINE_PER_CPU(void *, processor_device_array);
> -
>   static int acpi_processor_add(struct acpi_device *device,
>   					const struct acpi_device_id *id)
>   {
> @@ -395,28 +434,6 @@ static int acpi_processor_add(struct acpi_device *device,
>   	if (result) /* Processor is not physically present or unavailable */
>   		return 0;
>   
> -	BUG_ON(pr->id >= nr_cpu_ids);
> -
> -	/*
> -	 * Buggy BIOS check.
> -	 * ACPI id of processors can be reported wrongly by the BIOS.
> -	 * Don't trust it blindly
> -	 */
> -	if (per_cpu(processor_device_array, pr->id) != NULL &&
> -	    per_cpu(processor_device_array, pr->id) != device) {
> -		dev_warn(&device->dev,
> -			"BIOS reported wrong ACPI id %d for the processor\n",
> -			pr->id);
> -		/* Give up, but do not abort the namespace scan. */
> -		goto err;
> -	}
> -	/*
> -	 * processor_device_array is not cleared on errors to allow buggy BIOS
> -	 * checks.
> -	 */
> -	per_cpu(processor_device_array, pr->id) = device;
> -	per_cpu(processors, pr->id) = pr;
> -
>   	dev = get_cpu_device(pr->id);
>   	if (!dev) {
>   		result = -ENODEV;
> @@ -469,10 +486,6 @@ static void acpi_processor_remove(struct acpi_device *device)
>   	device_release_driver(pr->dev);
>   	acpi_unbind_one(pr->dev);
>   
> -	/* Clean up. */
> -	per_cpu(processor_device_array, pr->id) = NULL;
> -	per_cpu(processors, pr->id) = NULL;
> -
>   	cpu_maps_update_begin();
>   	cpus_write_lock();
>   
> @@ -480,6 +493,10 @@ static void acpi_processor_remove(struct acpi_device *device)
>   	arch_unregister_cpu(pr->id);
>   	acpi_unmap_cpu(pr->id);
>   
> +	/* Clean up. */
> +	per_cpu(processor_device_array, pr->id) = NULL;
> +	per_cpu(processors, pr->id) = NULL;
> +
>   	cpus_write_unlock();
>   	cpu_maps_update_done();
>   

Thanks,
Gavin


