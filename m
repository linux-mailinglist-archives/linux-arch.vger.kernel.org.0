Return-Path: <linux-arch+bounces-3929-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0671F8B10C6
	for <lists+linux-arch@lfdr.de>; Wed, 24 Apr 2024 19:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F2F3B277AF
	for <lists+linux-arch@lfdr.de>; Wed, 24 Apr 2024 17:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB9316D32E;
	Wed, 24 Apr 2024 17:19:05 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB228161326;
	Wed, 24 Apr 2024 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979145; cv=none; b=B6JRQdCs4N0/nGCe2Hl5Qjrg4gEda73B2cqzp5OeFYQO444Y9AYh+cMQ4q4+adzJoXxzIU49vu7oMoJfZh7qKPbvC/kyzYcGi6rN3/6rcNNmCGtnddBpRc90Ioy53Mf1qzCgO4qcRTD02keQnJQJxQ4z+KJqNu1fBTuQr9ftcgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979145; c=relaxed/simple;
	bh=BCrtxFaK5T02MtCXr6aEAaVrhNkNdyl/HwxjkUTvu8I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VfPP/GR0mZiQVAfd2ELPIf09pqMkC509LoOELJL4nekbMJP12n7rjHx6s5cHSmLrasdbdBoNsUr9FvqONxGqkbeZ5MzibVyqvE60OzSDuE0nVg8BIYNknZ9Agbg8cWAtt6MXlUTZOmsBBA33eWrS+cG2K00fspW1dpkSSLLfuOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VPlyX1jGBz6K65n;
	Thu, 25 Apr 2024 01:16:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0E35E140A70;
	Thu, 25 Apr 2024 01:18:59 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 24 Apr
 2024 18:18:58 +0100
Date: Wed, 24 Apr 2024 18:18:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Hanjun Guo <guohanjun@huawei.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, "James Morse"
	<james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <linuxarm@huawei.com>, <justin.he@arm.com>,
	<jianyong.wu@arm.com>
Subject: Re: [PATCH v7 04/16] ACPI: processor: Move checks and availability
 of acpi_processor earlier
Message-ID: <20240424181857.00000e0f@Huawei.com>
In-Reply-To: <0cfc4e2d-65ab-0040-2c7d-fad83f32455b@huawei.com>
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
	<20240418135412.14730-5-Jonathan.Cameron@huawei.com>
	<0cfc4e2d-65ab-0040-2c7d-fad83f32455b@huawei.com>
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

On Tue, 23 Apr 2024 19:53:34 +0800
Hanjun Guo <guohanjun@huawei.com> wrote:

> > @@ -232,6 +263,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
> >   	acpi_status status = AE_OK;
> >   	static int cpu0_initialized;
> >   	unsigned long long value;
> > +	int ret;
> >   
> >   	acpi_processor_errata();
> >   
> > @@ -316,10 +348,12 @@ static int acpi_processor_get_info(struct acpi_device *device)
> >   	 *  because cpuid <-> apicid mapping is persistent now.
> >   	 */
> >   	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
> > -		int ret = acpi_processor_hotadd_init(pr);
> > +		ret = acpi_processor_hotadd_init(pr, device);
> >   
> >   		if (ret)
> > -			return ret;
> > +			goto err;
> > +	} else {
> > +		acpi_processor_set_per_cpu(pr, device);
> >   	}
> >   
> >   	/*
> > @@ -357,6 +391,10 @@ static int acpi_processor_get_info(struct acpi_device *device)
> >   		arch_fix_phys_package_id(pr->id, value);
> >   
> >   	return 0;
> > +
> > +err:
> > +	per_cpu(processors, pr->id) = NULL;  
> 
> ...
> 
> > +	return ret;
> >   }
> >   
> >   /*
> > @@ -365,8 +403,6 @@ static int acpi_processor_get_info(struct acpi_device *device)
> >    * (cpu_data(cpu)) values, like CPU feature flags, family, model, etc.
> >    * Such things have to be put in and set up by the processor driver's .probe().
> >    */
> > -static DEFINE_PER_CPU(void *, processor_device_array);
> > -
> >   static int acpi_processor_add(struct acpi_device *device,
> >   					const struct acpi_device_id *id)
> >   {
> > @@ -395,28 +431,6 @@ static int acpi_processor_add(struct acpi_device *device,
> >   	if (result) /* Processor is not physically present or unavailable */
> >   		return 0;
> >   
> > -	BUG_ON(pr->id >= nr_cpu_ids);
> > -
> > -	/*
> > -	 * Buggy BIOS check.
> > -	 * ACPI id of processors can be reported wrongly by the BIOS.
> > -	 * Don't trust it blindly
> > -	 */
> > -	if (per_cpu(processor_device_array, pr->id) != NULL &&
> > -	    per_cpu(processor_device_array, pr->id) != device) {
> > -		dev_warn(&device->dev,
> > -			"BIOS reported wrong ACPI id %d for the processor\n",
> > -			pr->id);
> > -		/* Give up, but do not abort the namespace scan. */
> > -		goto err;
> > -	}
> > -	/*
> > -	 * processor_device_array is not cleared on errors to allow buggy BIOS
> > -	 * checks.
> > -	 */
> > -	per_cpu(processor_device_array, pr->id) = device;
> > -	per_cpu(processors, pr->id) = pr;  
> 
> Nit: seems we need to remove the duplicated
> per_cpu(processors, pr->id) = NULL; in acpi_processor_add():
> 
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -446,7 +446,6 @@ static int acpi_processor_add(struct acpi_device 
> *device,
>    err:
>          free_cpumask_var(pr->throttling.shared_cpu_map);
>          device->driver_data = NULL;
> -       per_cpu(processors, pr->id) = NULL;

I don't follow.  This path is used if processor_get_info() succeeded and
we later fail.  I don't see where the the duplication is?


>    err_free_pr:
>          kfree(pr);
>          return result;
> 
> Thanks
> Hanjun


