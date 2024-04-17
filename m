Return-Path: <linux-arch+bounces-3764-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E65E8A870E
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 17:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8DF1F22997
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 15:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4E2146D54;
	Wed, 17 Apr 2024 15:08:26 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA201422B6;
	Wed, 17 Apr 2024 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366506; cv=none; b=YWWpwSQqkykzVLArrWXlSu6wilGLm9NRIWrhY6oxFAJotaMUggSL3Z8kLG5U0SiYbRR9tz7PhVONgBueIYwekE/62flosUCEtmYIi1V5hLsBBvMNhH9n7MxkidxpM5xjPG8/m35Fx4c5uWHiXSoe74TTpgOtV9fvtexaVUnszPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366506; c=relaxed/simple;
	bh=HqB8OvnMPHquKHqjaWqykqAsPhGspLSoZS5hbWSpSPY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q3KfCWlThLk5M+wDR1MYUokqMWVqQbpPzj2oPv2zwPfSVE6+DsbYla6Bj0jouseuwgOWgclUO3W+bfg8r5nx2S/WVkvdNkCM7idhxUORB60iDKNKbLtZF/FxTxyizp6Q7sNza4W7MRfjAHH6C/iPTuBBNtk9Y8zcxO312t2pRDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKPL40LLgz6D93L;
	Wed, 17 Apr 2024 23:03:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C1736140B63;
	Wed, 17 Apr 2024 23:08:21 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 16:08:21 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.035;
 Wed, 17 Apr 2024 16:08:21 +0100
From: Salil Mehta <salil.mehta@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Thomas Gleixner
	<tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>, Russell King
	<linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>, "Miguel
 Luis" <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Linuxarm <linuxarm@huawei.com>,
	"justin.he@arm.com" <justin.he@arm.com>, "jianyong.wu@arm.com"
	<jianyong.wu@arm.com>
Subject: RE: [PATCH v6 04/16] ACPI: processor: Move checks and availability of
 acpi_processor earlier
Thread-Topic: [PATCH v6 04/16] ACPI: processor: Move checks and availability
 of acpi_processor earlier
Thread-Index: AQHakMoeuXZIO/2VFU+Xa55KmvuTN7Fsj+bw
Date: Wed, 17 Apr 2024 15:08:21 +0000
Message-ID: <32aaee486f984859af713138e460075f@huawei.com>
References: <20240417131909.7925-1-Jonathan.Cameron@huawei.com>
 <20240417131909.7925-5-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240417131909.7925-5-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>  From: Jonathan Cameron <jonathan.cameron@huawei.com>
>  Sent: Wednesday, April 17, 2024 2:19 PM
> =20
>  Make the per_cpu(processors, cpu) entries available earlier so that they=
 are
>  available in arch_register_cpu() as ARM64 will need access to the
>  acpi_handle to distinguish between acpi_processor_add() and earlier
>  registration attempts (which will fail as _STA cannot be checked).
> =20
>  Reorder the remove flow to clear this per_cpu() after
>  arch_unregister_cpu() has completed, allowing it to be used in there as
>  well.
> =20
>  Note that on x86 for the CPU hotplug case, the pr->id prior to
>  acpi_map_cpu() may be invalid. Thus the per_cpu() structures must be
>  initialized after that call or after checking the ID is valid (not hotpl=
ug path).
> =20
>  Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>  ---
>  v6: As per discussion in v5 thread, don't use the cpu->dev and
>      make this data available earlier by moving the assignment checks
>      int acpi_processor_get_info().
>  ---
>   drivers/acpi/acpi_processor.c | 79 +++++++++++++++++++++--------------
>   1 file changed, 47 insertions(+), 32 deletions(-)
> =20
>  diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor=
.c
>  index ba0a6f0ac841..2c164451ab53 100644
>  --- a/drivers/acpi/acpi_processor.c
>  +++ b/drivers/acpi/acpi_processor.c
>  @@ -184,7 +184,35 @@ static void __init acpi_pcc_cpufreq_init(void) {}
> =20
>   /* Initialization */
>   #ifdef CONFIG_ACPI_HOTPLUG_CPU
>  -static int acpi_processor_hotadd_init(struct acpi_processor *pr)
>  +static DEFINE_PER_CPU(void *, processor_device_array);
>  +
>  +static void acpi_processor_set_per_cpu(struct acpi_processor *pr,
>  +				       struct acpi_device *device)
>  +{
>  +	BUG_ON(pr->id >=3D nr_cpu_ids);
>  +	/*
>  +	 * Buggy BIOS check.
>  +	 * ACPI id of processors can be reported wrongly by the BIOS.
>  +	 * Don't trust it blindly
>  +	 */
>  +	if (per_cpu(processor_device_array, pr->id) !=3D NULL &&
>  +	    per_cpu(processor_device_array, pr->id) !=3D device) {
>  +		dev_warn(&device->dev,
>  +			 "BIOS reported wrong ACPI id %d for the  processor\n",
>  +			 pr->id);
>  +		/* Give up, but do not abort the namespace scan. */
>  +		return;
>  +	}
>  +	/*
>  +	 * processor_device_array is not cleared on errors to allow buggy  BIO=
S
>  +	 * checks.
>  +	 */
>  +	per_cpu(processor_device_array, pr->id) =3D device;
>  +	per_cpu(processors, pr->id) =3D pr;
>  +}
>  +
>  +static int acpi_processor_hotadd_init(struct acpi_processor *pr,
>  +				      struct acpi_device *device)
>   {
>   	int ret;
> =20
>  @@ -198,6 +226,8 @@ static int acpi_processor_hotadd_init(struct
>  acpi_processor *pr)
>   	if (ret)
>   		goto out;
> =20
>  +	acpi_processor_set_per_cpu(pr, device);
>  +
>   	ret =3D arch_register_cpu(pr->id);
>   	if (ret) {
>   		acpi_unmap_cpu(pr->id);
>  @@ -217,7 +247,8 @@ static int acpi_processor_hotadd_init(struct
>  acpi_processor *pr)
>   	return ret;
>   }
>   #else
>  -static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
>  +static inline int acpi_processor_hotadd_init(struct acpi_processor *pr,
>  +					     struct acpi_device *device)
>   {
>   	return -ENODEV;
>   }
>  @@ -232,6 +263,7 @@ static int acpi_processor_get_info(struct acpi_devic=
e
>  *device)
>   	acpi_status status =3D AE_OK;
>   	static int cpu0_initialized;
>   	unsigned long long value;
>  +	int ret;
> =20
>   	acpi_processor_errata();
> =20
>  @@ -316,10 +348,12 @@ static int acpi_processor_get_info(struct
>  acpi_device *device)
>   	 *  because cpuid <-> apicid mapping is persistent now.
>   	 */
>   	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
>  -		int ret =3D acpi_processor_hotadd_init(pr);
>  +		ret =3D acpi_processor_hotadd_init(pr, device);
> =20
>   		if (ret)
>  -			return ret;
>  +			goto err;
>  +	} else {
>  +		acpi_processor_set_per_cpu(pr, device);
>   	}
> =20
>   	/*
>  @@ -357,6 +391,10 @@ static int acpi_processor_get_info(struct
>  acpi_device *device)
>   		arch_fix_phys_package_id(pr->id, value);
> =20
>   	return 0;
>  +
>  +err:
>  +	per_cpu(processors, pr->id) =3D NULL;
>  +	return ret;
>   }
> =20
>   /*
>  @@ -365,8 +403,6 @@ static int acpi_processor_get_info(struct acpi_devic=
e
>  *device)
>    * (cpu_data(cpu)) values, like CPU feature flags, family, model, etc.
>    * Such things have to be put in and set up by the processor driver's
>  .probe().
>    */
>  -static DEFINE_PER_CPU(void *, processor_device_array);
>  -
>   static int acpi_processor_add(struct acpi_device *device,
>   					const struct acpi_device_id *id)
>   {
>  @@ -395,28 +431,6 @@ static int acpi_processor_add(struct acpi_device
>  *device,
>   	if (result) /* Processor is not physically present or unavailable */
>   		return 0;
> =20
>  -	BUG_ON(pr->id >=3D nr_cpu_ids);
>  -
>  -	/*
>  -	 * Buggy BIOS check.
>  -	 * ACPI id of processors can be reported wrongly by the BIOS.
>  -	 * Don't trust it blindly
>  -	 */
>  -	if (per_cpu(processor_device_array, pr->id) !=3D NULL &&
>  -	    per_cpu(processor_device_array, pr->id) !=3D device) {
>  -		dev_warn(&device->dev,
>  -			"BIOS reported wrong ACPI id %d for the  processor\n",
>  -			pr->id);
>  -		/* Give up, but do not abort the namespace scan. */
>  -		goto err;
>  -	}
>  -	/*
>  -	 * processor_device_array is not cleared on errors to allow buggy  BIO=
S
>  -	 * checks.
>  -	 */
>  -	per_cpu(processor_device_array, pr->id) =3D device;
>  -	per_cpu(processors, pr->id) =3D pr;
>  -
>   	dev =3D get_cpu_device(pr->id);
>   	if (!dev) {
>   		result =3D -ENODEV;
>  @@ -469,15 +483,16 @@ static void acpi_processor_remove(struct
>  acpi_device *device)
>   	device_release_driver(pr->dev);
>   	acpi_unbind_one(pr->dev);
> =20
>  -	/* Clean up. */
>  -	per_cpu(processor_device_array, pr->id) =3D NULL;
>  -	per_cpu(processors, pr->id) =3D NULL;
>  -
>   	cpu_maps_update_begin();
>   	cpus_write_lock();
> =20
>   	/* Remove the CPU. */
>   	arch_unregister_cpu(pr->id);
>  +
>  +	/* Clean up. */
>  +	per_cpu(processor_device_array, pr->id) =3D NULL;
>  +	per_cpu(processors, pr->id) =3D NULL;
>  +


Shouldn't above change come after acpi_unmap_cpu() i.e. after next line?


>   	acpi_unmap_cpu(pr->id);
> =20
>   	cpus_write_unlock();
>  --
>  2.39.2


