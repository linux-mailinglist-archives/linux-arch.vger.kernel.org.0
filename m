Return-Path: <linux-arch+bounces-3765-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B45EC8A8752
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 17:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4040BB2356A
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 15:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE932147C6B;
	Wed, 17 Apr 2024 15:19:25 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BB7147C68;
	Wed, 17 Apr 2024 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367165; cv=none; b=TltPlXpLOFJ/q6PIpzunIOhk0yhVLdXPLJVNUU8oqeu0y3Joika1q7IVeZO13kt6E3UwDWIQVLPRNbaXQsniZNDQOk5DDwCSx/PfxdClJUDuP3iWrZx0g5OCd9MzAbzKeJIq39LVJe4sy6yeC4DCqMkce3tM+dN4Q8DZFfb526U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367165; c=relaxed/simple;
	bh=pSwnn1LkiCfiG0bDGosb0X47I9S4gmfe3u/wLjepEK8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+sStYQA9KZJo79UAgNU8IzMKOpLwODjCYh9JKBUAbRx+3a7o3EKw4C/lry+ybYk/gHP6THF3+jvOwa0sJ2O5i5Q+zRQ2VOhlTCwpp2/zxCquGPPLu1bn4hFd/j47SHfqB0R2JaWnw6WW8fGioNKmCC5AUrgA2TsEmPIRxGDN70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKPZl2tRFz6D92K;
	Wed, 17 Apr 2024 23:14:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2695E140A46;
	Wed, 17 Apr 2024 23:19:21 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 17 Apr
 2024 16:19:20 +0100
Date: Wed, 17 Apr 2024 16:19:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Salil Mehta <salil.mehta@huawei.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>, Russell King
	<linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>, "Miguel
 Luis" <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, Linuxarm <linuxarm@huawei.com>,
	"justin.he@arm.com" <justin.he@arm.com>, "jianyong.wu@arm.com"
	<jianyong.wu@arm.com>
Subject: Re: [PATCH v6 04/16] ACPI: processor: Move checks and availability
 of acpi_processor earlier
Message-ID: <20240417161919.000070b4@Huawei.com>
In-Reply-To: <32aaee486f984859af713138e460075f@huawei.com>
References: <20240417131909.7925-1-Jonathan.Cameron@huawei.com>
	<20240417131909.7925-5-Jonathan.Cameron@huawei.com>
	<32aaee486f984859af713138e460075f@huawei.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


> >   		result = -ENODEV;
> >  @@ -469,15 +483,16 @@ static void acpi_processor_remove(struct
> >  acpi_device *device)
> >   	device_release_driver(pr->dev);
> >   	acpi_unbind_one(pr->dev);
> >  
> >  -	/* Clean up. */
> >  -	per_cpu(processor_device_array, pr->id) = NULL;
> >  -	per_cpu(processors, pr->id) = NULL;
> >  -
> >   	cpu_maps_update_begin();
> >   	cpus_write_lock();
> >  
> >   	/* Remove the CPU. */
> >   	arch_unregister_cpu(pr->id);
> >  +
> >  +	/* Clean up. */
> >  +	per_cpu(processor_device_array, pr->id) = NULL;
> >  +	per_cpu(processors, pr->id) = NULL;
> >  +  
> 
> 
> Shouldn't above change come after acpi_unmap_cpu() i.e. after next line?
> 
> 
> >   	acpi_unmap_cpu(pr->id);
Agreed - that is more logically correct.  I'll move it for v7.

Thanks,

Jonathan

