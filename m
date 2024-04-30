Return-Path: <linux-arch+bounces-4056-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254268B696E
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 06:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02A0DB209AF
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 04:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE6812E4E;
	Tue, 30 Apr 2024 04:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHVcsMBw"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFBA101C5
	for <linux-arch@vger.kernel.org>; Tue, 30 Apr 2024 04:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714451184; cv=none; b=g8P0uAGTtx2V0DzdciqitGYLOvu2UWEj3x2lFVu1kBQ8cNicNoW9gs0YBMmhoCtY6ibyVfWeDLq4Y0KGeJCUT89CUISTcORTGwxN6nHTCBUuZZnwGffK6OJMGIEOHkcxreB8SExP39zPCkBpYbzZYEswCA/1TyRydtopoTtBsB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714451184; c=relaxed/simple;
	bh=7/LvDV66mDIzCX8Ki3ehENh2BWy+/8sMXmXZYQ9n3Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9mPmr/7PT9Z9bxL9Zh0X2HU4uNbKdTIs/JQjWC5bCiO8oOY83ISbMGSb0QS1k5xfZ+iHp2nV/q+8WArM9uXX2FmZcA4ydFo6dQixiuB7FypbB99prScWFF8ARYUTmgd7bvbL0PsVoiAeJRxVmiqRjfLefKDkTpPDxHRauKgVV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHVcsMBw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714451181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/j3/XOns0oFgwfO5bxhGBltITHmRiIbor4kORGQYrjA=;
	b=bHVcsMBwWDPrziJ35+BUYvrsjCrxlHMhqasXxXqmhjkbk2505zndFORDX3WKHQAPC1nM8w
	fZvo4qplTqSe9LdRca6pvxBuawjAOBRi9zUAe0zDwZFgmA3bDs1cn3KwALrGe8Y++iS/4h
	HfxNRytjbZT3y98s4wEomUrNDwxNCRU=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-yOqOzI7VNiytio_orYq5Rw-1; Tue, 30 Apr 2024 00:26:19 -0400
X-MC-Unique: yOqOzI7VNiytio_orYq5Rw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-613dbdf5c1bso1755781a12.0
        for <linux-arch@vger.kernel.org>; Mon, 29 Apr 2024 21:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714451178; x=1715055978;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/j3/XOns0oFgwfO5bxhGBltITHmRiIbor4kORGQYrjA=;
        b=N+YWf+6IkScJMPCSGOFt5oSJHyKSq/j4UOokrJhuk+cmjHWy5pCnKtFfyY6uKWf/Xy
         YhdjtPhCEvbfsjndUOFGrZchwbjIkujiRDffo0vm5ywsvCPCjpkw9MLU63jLjOu+52zJ
         b5LGxS7V7T5XoHjk3wDN6pxCls8WDJgf1aS1k70hTa2z9CnnQYlbuXanRkJHuqPP/Med
         6Lhhk00rG3+kTpzaUT8Urbka79Cg8zC0M2g+v8cETlibu5dCiovy7PU3+clCFB0BOGiz
         oGwRc+Mrw49CClpEUen47L+9BhNukxokjlrKnojzkzgTjQi9/0yTuub+XFUyxwUMMvwo
         e1+g==
X-Forwarded-Encrypted: i=1; AJvYcCUlyfK6lLk5F6J2aURUjaJoEO7NwgF88ohcKONXy3UOymYJuuO1KKSSWXrPimEm0eA133lT7eyo17m9IV4EVwa9DPeZu2mzwWPocw==
X-Gm-Message-State: AOJu0YzKXGnx5aHUdMx+dr5TzSkBSIjcoMHeSfxj8dbheD2AOBxcFl5F
	NicZrEGoWtB/8z5bbVxKiQ9SXKOvM8yowVahQLJRLROxYGF/6xgWQQ+meExxCs9E81Yq+yAXU4m
	omodZogHtPdcRyqIuni6SH7Gz67SoCyHqMdZa9mf/VrjHe+aoeYAJ7Wd/EMQ=
X-Received: by 2002:a05:6a20:43ab:b0:1af:597f:ffa4 with SMTP id i43-20020a056a2043ab00b001af597fffa4mr1773940pzl.14.1714451178654;
        Mon, 29 Apr 2024 21:26:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH07U3E59OEv3uasYAdnnN9/WYRlSaTmrz5sCzeoOlurs0CWJYXB3V+LTa+nYaZB59wKOeCng==
X-Received: by 2002:a05:6a20:43ab:b0:1af:597f:ffa4 with SMTP id i43-20020a056a2043ab00b001af597fffa4mr1773917pzl.14.1714451178308;
        Mon, 29 Apr 2024 21:26:18 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902e74200b001e223b9eb25sm21272994plf.153.2024.04.29.21.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 21:26:17 -0700 (PDT)
Message-ID: <63f7c71a-fa01-4604-8fc6-9f52b5b31d6b@redhat.com>
Date: Tue, 30 Apr 2024 14:26:06 +1000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/16] ACPI: processor: Add acpi_get_processor_handle()
 helper
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
 <20240426135126.12802-6-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240426135126.12802-6-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/24 23:51, Jonathan Cameron wrote:
> If CONFIG_ACPI_PROCESSOR provide a helper to retrieve the
> acpi_handle for a given CPU allowing access to methods
> in DSDT.
> 
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v8: Code simplification suggested by Rafael.
>      Fixup ;; spotted by Gavin
> ---
>   drivers/acpi/acpi_processor.c | 11 +++++++++++
>   include/linux/acpi.h          |  7 +++++++
>   2 files changed, 18 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 3b180e21f325..ecc2721fecae 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -35,6 +35,17 @@ EXPORT_PER_CPU_SYMBOL(processors);
>   struct acpi_processor_errata errata __read_mostly;
>   EXPORT_SYMBOL_GPL(errata);
>   
> +acpi_handle acpi_get_processor_handle(int cpu)
> +{
> +	struct acpi_processor *pr;
> +
> +	pr = per_cpu(processors, cpu);
> +	if (pr)
> +		return pr->handle;
> +
> +	return NULL;
> +}
> +

Maybe it's worthy to have more check here, something like below.
However, it's also fine without the extra check.

	if (cpu >= nr_cpu_ids || !cpu_possible(cpu))
		return NULL;

>   static int acpi_processor_errata_piix4(struct pci_dev *dev)
>   {
>   	u8 value1 = 0;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 34829f2c517a..9844a3f9c4e5 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -309,6 +309,8 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
>   int acpi_unmap_cpu(int cpu);
>   #endif /* CONFIG_ACPI_HOTPLUG_CPU */
>   
> +acpi_handle acpi_get_processor_handle(int cpu);
> +
>   #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
>   int acpi_get_ioapic_id(acpi_handle handle, u32 gsi_base, u64 *phys_addr);
>   #endif
> @@ -1077,6 +1079,11 @@ static inline bool acpi_sleep_state_supported(u8 sleep_state)
>   	return false;
>   }
>   
> +static inline acpi_handle acpi_get_processor_handle(int cpu)
> +{
> +	return NULL;
> +}
> +
>   #endif	/* !CONFIG_ACPI */
>   
>   extern void arch_post_acpi_subsys_init(void);

Thanks,
Gavin


