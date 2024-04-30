Return-Path: <linux-arch+bounces-4070-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EF98B7761
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 15:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4FBF1C22220
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 13:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467FD171E64;
	Tue, 30 Apr 2024 13:43:00 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4790171E45;
	Tue, 30 Apr 2024 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484580; cv=none; b=i05TZTj5OrEgW+KrZ80K9ucrU+jpIokVBC8W0z34A7qMreh18nUZ3AuQZSVgUUgvtyPSEUK809mMD2iATzPIVwiZBfEDNIXcrGoV1Myn1k1UDF1N3sGPjcGRlIVYnIuUAztovotbX1yJA18edFdPQdTX/QdSxjC0LVrzsaHHiUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484580; c=relaxed/simple;
	bh=fHHfP3R98+26HqGgdZlRCT+RABIBzlHZU7lRM67x8cY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jf1OFLqucZpP/TqVK8u09FmszfqbudAZNV4KFpqM8jNuiN6xnQ2W/PJkLc18A7P1+DNsu8h0Nrt3u/TcNc++mvMKdvVtCeM1PSIWxyid1RuqRVNemj5McDfADR4Mqh60G/+Y1lvpu+sTyM30NWZiQlnermccigLAK77e5Ap6118=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTLt564WBz6GD6f;
	Tue, 30 Apr 2024 21:40:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EA1011400DC;
	Tue, 30 Apr 2024 21:42:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Apr
 2024 14:42:50 +0100
Date: Tue, 30 Apr 2024 14:42:48 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Gavin Shan <gshan@redhat.com>, <linuxarm@huawei.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, "James Morse"
	<james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier
	<maz@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <justin.he@arm.com>, <jianyong.wu@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Sudeep Holla
	<sudeep.holla@arm.com>
Subject: Re: [PATCH v8 04/16] ACPI: processor: Move checks and availability
 of acpi_processor earlier
Message-ID: <20240430144217.00003bf6@huawei.com>
In-Reply-To: <20240430111341.00003dba@huawei.com>
References: <20240426135126.12802-1-Jonathan.Cameron@huawei.com>
	<20240426135126.12802-5-Jonathan.Cameron@huawei.com>
	<80a2e07f-ecb2-48af-b2be-646f17e0e63e@redhat.com>
	<20240430102838.00006e04@Huawei.com>
	<20240430111341.00003dba@huawei.com>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 30 Apr 2024 11:13:41 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Tue, 30 Apr 2024 10:28:38 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Tue, 30 Apr 2024 14:17:24 +1000
> > Gavin Shan <gshan@redhat.com> wrote:
> >   
> > > On 4/26/24 23:51, Jonathan Cameron wrote:    
> > > > Make the per_cpu(processors, cpu) entries available earlier so that
> > > > they are available in arch_register_cpu() as ARM64 will need access
> > > > to the acpi_handle to distinguish between acpi_processor_add()
> > > > and earlier registration attempts (which will fail as _STA cannot
> > > > be checked).
> > > > 
> > > > Reorder the remove flow to clear this per_cpu() after
> > > > arch_unregister_cpu() has completed, allowing it to be used in
> > > > there as well.
> > > > 
> > > > Note that on x86 for the CPU hotplug case, the pr->id prior to
> > > > acpi_map_cpu() may be invalid. Thus the per_cpu() structures
> > > > must be initialized after that call or after checking the ID
> > > > is valid (not hotplug path).
> > > > 
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > 
> > > > ---
> > > > v8: On buggy bios detection when setting per_cpu structures
> > > >      do not carry on.
> > > >      Fix up the clearing of per cpu structures to remove unwanted
> > > >      side effects and ensure an error code isn't use to reference them.
> > > > ---
> > > >   drivers/acpi/acpi_processor.c | 79 +++++++++++++++++++++--------------
> > > >   1 file changed, 48 insertions(+), 31 deletions(-)
> > > > 
> > > > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> > > > index ba0a6f0ac841..3b180e21f325 100644
> > > > --- a/drivers/acpi/acpi_processor.c
> > > > +++ b/drivers/acpi/acpi_processor.c
> > > > @@ -183,8 +183,38 @@ static void __init acpi_pcc_cpufreq_init(void) {}
> > > >   #endif /* CONFIG_X86 */
> > > >   
> > > >   /* Initialization */
> > > > +static DEFINE_PER_CPU(void *, processor_device_array);
> > > > +
> > > > +static bool acpi_processor_set_per_cpu(struct acpi_processor *pr,
> > > > +				       struct acpi_device *device)
> > > > +{
> > > > +	BUG_ON(pr->id >= nr_cpu_ids);      
> > > 
> > > One blank line after BUG_ON() if we need to follow original implementation.    
> > 
> > Sure unintentional - I'll put that back.
> >   
> > >     
> > > > +	/*
> > > > +	 * Buggy BIOS check.
> > > > +	 * ACPI id of processors can be reported wrongly by the BIOS.
> > > > +	 * Don't trust it blindly
> > > > +	 */
> > > > +	if (per_cpu(processor_device_array, pr->id) != NULL &&
> > > > +	    per_cpu(processor_device_array, pr->id) != device) {
> > > > +		dev_warn(&device->dev,
> > > > +			 "BIOS reported wrong ACPI id %d for the processor\n",
> > > > +			 pr->id);
> > > > +		/* Give up, but do not abort the namespace scan. */      
> > > 
> > > It depends on how the return value is handled by the caller if the namespace
> > > is continued to be scanned. The caller can be acpi_processor_hotadd_init()
> > > and acpi_processor_get_info() after this patch is applied. So I think this
> > > specific comment need to be moved to the caller.    
> > 
> > Good point. This gets messy and was an unintended change.
> > 
> > Previously the options were:
> > 1) acpi_processor_get_info() failed for other reasons - this code was never called.
> > 2) acpi_processor_get_info() succeeded without acpi_processor_hotadd_init (non hotplug)
> >    this code then ran and would paper over the problem doing a bunch of cleanup under err.
> > 3) acpi_processor_get_info() succeeded with acpi_processor_hotadd_init called.
> >    This code then ran and would paper over the problem doing a bunch of cleanup under err.
> > 
> > We should maintain that or argue cleanly against it.
> > 
> > This isn't helped the the fact I have no idea which cases we care about for that bios
> > bug handling.  Do any of those bios's ever do hotplug?  Guess we have to try and maintain
> > whatever protection this was offering.
> > 
> > Also, the original code leaks data in some paths and I have limited idea
> > of whether it is intentional or not. So to tidy the issue up that you've identified
> > I'll need to try and make that code consistent first.
> > 
> > I suspect the only way to do that is going to be to duplicate the allocations we
> > 'want' to leak to deal with the bios bug detection.
> > 
> > For example acpi_processor_get_info() failing leaks pr and pr->throttling.shared_cpu_map
> > before this series. After this series we need pr to leak because it's used for the detection
> > via processor_device_array.
> > 
> > I'll work through this but it's going to be tricky to tell if we get right.
> > Step 1 will be closing the existing leaks and then we will have something
> > consistent to build on.
> >   
> I 'think' that fixing the original leaks makes this all much more straight forward.
> That return 0 for acpi_processor_get_info() never made sense as far as I can tell.
> The pr isn't used after this point.
> 
> What about something along lines of.
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 161c95c9d60a..97cff4492304 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -392,8 +392,10 @@ static int acpi_processor_add(struct acpi_device *device,
>         device->driver_data = pr;
> 
>         result = acpi_processor_get_info(device);
> -       if (result) /* Processor is not physically present or unavailable */
> -               return 0;
> +       if (result) { /* Processor is not physically present or unavailable */
> +               result = 0;
> +               goto err_free_throttling_mask;

FWIW this is wrong, should be goto err_clear_driver_data
(you can see it set just at the top of this block and that never fails!)
The err_free_throttling_mask label should be unused and hence won't exist in v9.

> +       }
> 
>         BUG_ON(pr->id >= nr_cpu_ids);
> 
> @@ -408,7 +410,7 @@ static int acpi_processor_add(struct acpi_device *device,
>                         "BIOS reported wrong ACPI id %d for the processor\n",
>                         pr->id);
>                 /* Give up, but do not abort the namespace scan. */
> -               goto err;
> +               goto err_clear_driver_data;
>         }
>         /*
>          * processor_device_array is not cleared on errors to allow buggy BIOS
> @@ -420,12 +422,12 @@ static int acpi_processor_add(struct acpi_device *device,
>         dev = get_cpu_device(pr->id);
>         if (!dev) {
>                 result = -ENODEV;
> -               goto err;
> +               goto err_clear_per_cpu;
>         }
> 
>         result = acpi_bind_one(dev, device);
>         if (result)
> -               goto err;
> +               goto err_clear_per_cpu;
> 
>         pr->dev = dev;
> 
> @@ -436,10 +438,12 @@ static int acpi_processor_add(struct acpi_device *device,
>         dev_err(dev, "Processor driver could not be attached\n");
>         acpi_unbind_one(dev);
> 
> - err:
> -       free_cpumask_var(pr->throttling.shared_cpu_map);
> -       device->driver_data = NULL;
> + err_clear_per_cpu:
>         per_cpu(processors, pr->id) = NULL;
> + err_clear_driver_data:
> +       device->driver_data = NULL;
> + err_free_throttling_mask:
> +       free_cpumask_var(pr->throttling.shared_cpu_map);
>   err_free_pr:
>         kfree(pr);
>         return result;
> 
> Then the diff on this patch is simply:
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 3c49eae1e943..3b75f5aeb7ab 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -200,7 +200,6 @@ static bool acpi_processor_set_per_cpu(struct acpi_processor *pr,
>                 dev_warn(&device->dev,
>                          "BIOS reported wrong ACPI id %d for the processor\n",
>                          pr->id);
> -               /* Give up, but do not abort the namespace scan. */
>                 return false;
>         }
>         /*
> @@ -230,13 +229,14 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr,
>                 goto out;
> 
>         if (!acpi_processor_set_per_cpu(pr, device)) {
> +               ret = -EINVAL;
>                 acpi_unmap_cpu(pr->id);
>                 goto out;
>         }
> 
>         ret = arch_register_cpu(pr->id);
>         if (ret) {
> -               /* Leave the processor device array in place to detect buggy bios */
> +x              /* Leave the processor device array in place to detect buggy bios */
>                 per_cpu(processors, pr->id) = NULL;
>                 acpi_unmap_cpu(pr->id);
>                 goto out;
> @@ -262,7 +262,7 @@ static inline int acpi_processor_hotadd_init(struct acpi_processor *pr,
>  }
>  #endif /* CONFIG_ACPI_HOTPLUG_CPU */
> 
> -static int acpi_processor_get_info(struct acpi_device *device)
> +static int acpi_processor_get_info(struct acpi_device *device, bool bios_bug)
>  {
>         union acpi_object object = { 0 };
>         struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
> @@ -361,7 +361,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
>                         return ret;
>         } else {
>                 if (!acpi_processor_set_per_cpu(pr, device))
> -                       return 0;
> +                       return -EINVAL;
>         }
> 
>         /*
> > > 
> > > Besides, it seems acpi_processor_set_per_cpu() isn't properly called and
> > > memory leakage can happen. More details are given below.
> > >     
> > > > +		return false;
> > > > +	}
> > > > +	/*
> > > > +	 * processor_device_array is not cleared on errors to allow buggy BIOS
> > > > +	 * checks.
> > > > +	 */
> > > > +	per_cpu(processor_device_array, pr->id) = device;
> > > > +	per_cpu(processors, pr->id) = pr;
> > > > +
> > > > +	return true;
> > > > +}
> > > > +
> > > >   #ifdef CONFIG_ACPI_HOTPLUG_CPU
> > > > -static int acpi_processor_hotadd_init(struct acpi_processor *pr)
> > > > +static int acpi_processor_hotadd_init(struct acpi_processor *pr,
> > > > +				      struct acpi_device *device)
> > > >   {
> > > >   	int ret;
> > > >   
> > > > @@ -198,8 +228,15 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
> > > >   	if (ret)
> > > >   		goto out;
> > > >   
> > > > +	if (!acpi_processor_set_per_cpu(pr, device)) {
> > > > +		acpi_unmap_cpu(pr->id);
> > > > +		goto out;
> > > > +	}
> > > > +      
> > > 
> > > With the 'goto out', zero is returned from acpi_processor_hotadd_init() to acpi_processor_get_info().  
> 
> Indeed a bug :(
> 
> > > The zero return value is carried from acpi_map_cpu() in acpi_processor_hotadd_init(). If I'm correct,
> > > we need return errno from acpi_processor_get_info() to acpi_processor_add() so that cleanup can be
> > > done. For example, the cleanup corresponding to the 'err' tag can be done in acpi_processor_add().
> > > Otherwise, we will have memory leakage.  
> 
> The confusion here was that previously acpi_processor_add() was missing error cleanup for
> acpi_processor_get_info().  With that in place I think it's all much simpler.
> 
> Thanks for your eagle eyes!
> 
> Jonathan
> 
> 
> > >     
> > > >   	ret = arch_register_cpu(pr->id);
> > > >   	if (ret) {
> > > > +		/* Leave the processor device array in place to detect buggy bios */
> > > > +		per_cpu(processors, pr->id) = NULL;
> > > >   		acpi_unmap_cpu(pr->id);
> > > >   		goto out;
> > > >   	}
> > > > @@ -217,7 +254,8 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
> > > >   	return ret;
> > > >   }
> > > >   #else
> > > > -static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
> > > > +static inline int acpi_processor_hotadd_init(struct acpi_processor *pr,
> > > > +					     struct acpi_device *device)
> > > >   {
> > > >   	return -ENODEV;
> > > >   }
> > > > @@ -316,10 +354,13 @@ static int acpi_processor_get_info(struct acpi_device *device)
> > > >   	 *  because cpuid <-> apicid mapping is persistent now.
> > > >   	 */
> > > >   	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
> > > > -		int ret = acpi_processor_hotadd_init(pr);
> > > > +		int ret = acpi_processor_hotadd_init(pr, device);
> > > >   
> > > >   		if (ret)
> > > >   			return ret;
> > > > +	} else {
> > > > +		if (!acpi_processor_set_per_cpu(pr, device))
> > > > +			return 0;
> > > >   	}
> > > >         
> > > 
> > > For non-hotplug case, we still need pass the error to acpi_processor_add() so that
> > > cleanup corresponding 'err' tag can be done. Otherwise, we will have memory leakage.
> > >     
> > > >   	/*
> > > > @@ -365,8 +406,6 @@ static int acpi_processor_get_info(struct acpi_device *device)
> > > >    * (cpu_data(cpu)) values, like CPU feature flags, family, model, etc.
> > > >    * Such things have to be put in and set up by the processor driver's .probe().
> > > >    */
> > > > -static DEFINE_PER_CPU(void *, processor_device_array);
> > > > -
> > > >   static int acpi_processor_add(struct acpi_device *device,
> > > >   					const struct acpi_device_id *id)
> > > >   {
> > > > @@ -395,28 +434,6 @@ static int acpi_processor_add(struct acpi_device *device,
> > > >   	if (result) /* Processor is not physically present or unavailable */
> > > >   		return 0;
> > > >   
> > > > -	BUG_ON(pr->id >= nr_cpu_ids);
> > > > -
> > > > -	/*
> > > > -	 * Buggy BIOS check.
> > > > -	 * ACPI id of processors can be reported wrongly by the BIOS.
> > > > -	 * Don't trust it blindly
> > > > -	 */
> > > > -	if (per_cpu(processor_device_array, pr->id) != NULL &&
> > > > -	    per_cpu(processor_device_array, pr->id) != device) {
> > > > -		dev_warn(&device->dev,
> > > > -			"BIOS reported wrong ACPI id %d for the processor\n",
> > > > -			pr->id);
> > > > -		/* Give up, but do not abort the namespace scan. */
> > > > -		goto err;
> > > > -	}
> > > > -	/*
> > > > -	 * processor_device_array is not cleared on errors to allow buggy BIOS
> > > > -	 * checks.
> > > > -	 */
> > > > -	per_cpu(processor_device_array, pr->id) = device;
> > > > -	per_cpu(processors, pr->id) = pr;
> > > > -
> > > >   	dev = get_cpu_device(pr->id);
> > > >   	if (!dev) {
> > > >   		result = -ENODEV;
> > > > @@ -469,10 +486,6 @@ static void acpi_processor_remove(struct acpi_device *device)
> > > >   	device_release_driver(pr->dev);
> > > >   	acpi_unbind_one(pr->dev);
> > > >   
> > > > -	/* Clean up. */
> > > > -	per_cpu(processor_device_array, pr->id) = NULL;
> > > > -	per_cpu(processors, pr->id) = NULL;
> > > > -
> > > >   	cpu_maps_update_begin();
> > > >   	cpus_write_lock();
> > > >   
> > > > @@ -480,6 +493,10 @@ static void acpi_processor_remove(struct acpi_device *device)
> > > >   	arch_unregister_cpu(pr->id);
> > > >   	acpi_unmap_cpu(pr->id);
> > > >   
> > > > +	/* Clean up. */
> > > > +	per_cpu(processor_device_array, pr->id) = NULL;
> > > > +	per_cpu(processors, pr->id) = NULL;
> > > > +
> > > >   	cpus_write_unlock();
> > > >   	cpu_maps_update_done();
> > > >         
> > > 
> > > Thanks,
> > > Gavin
> > >     
> >   
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


