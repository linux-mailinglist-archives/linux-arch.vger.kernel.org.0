Return-Path: <linux-arch+bounces-3766-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E958A87E5
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 17:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ABDF1F24022
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 15:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0339F1487FA;
	Wed, 17 Apr 2024 15:38:50 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13DD1487F1;
	Wed, 17 Apr 2024 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368329; cv=none; b=UwGM78zlH1SFT0qa/RkCosQinq/sg2+bUsLzNJu2G/pGW93bb4hXIkAn3QihgsD6ppU6WEeVp7m0coVHBWHBPZG13f5Jl7Mwz8c/mt9Vkzj2P0jwlcBF2mAJPyjZlDxgSExhMZCSNNhuLpLpvToAuMxTV4J9ddSTP0rR2t5uKQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368329; c=relaxed/simple;
	bh=GEwKcew9dkrK7al83zqmzbXTl8DFGOiIto9YUHLUKgI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AENnMVv308UNu3yM9loaH62fdAS9vBwj0Nb6Rujzxr+QEZdJ1vWkWBdqGoLQxWTCv4xFFJLg6LF6kuiHXuAl0PH9ATok8lCfZMQHaGHedqhrsizK6+4NJKKZyYP2FW+iWN2LasFH9QE9aPxRNFJtPo3GIdxSeYsDvc412AqA/XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKQ4W5nkBz6F951;
	Wed, 17 Apr 2024 23:36:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 35D8B140B38;
	Wed, 17 Apr 2024 23:38:44 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 17 Apr
 2024 16:38:43 +0100
Date: Wed, 17 Apr 2024 16:38:42 +0100
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
Subject: Re: [PATCH v6 06/16] ACPI: processor: Register deferred CPUs from
 acpi_processor_get_info()
Message-ID: <20240417163842.0000415e@Huawei.com>
In-Reply-To: <22ace9b108ee488eb017f5b3e8facb8d@huawei.com>
References: <20240417131909.7925-1-Jonathan.Cameron@huawei.com>
	<20240417131909.7925-7-Jonathan.Cameron@huawei.com>
	<22ace9b108ee488eb017f5b3e8facb8d@huawei.com>
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

On Wed, 17 Apr 2024 16:03:51 +0100
Salil Mehta <salil.mehta@huawei.com> wrote:

> >  From: Jonathan Cameron <jonathan.cameron@huawei.com>
> >  Sent: Wednesday, April 17, 2024 2:19 PM
> >  
> >  From: James Morse <james.morse@arm.com>
> >  
> >  The arm64 specific arch_register_cpu() call may defer CPU registration until
> >  the ACPI interpreter is available and the _STA method can be evaluated.
> >  
> >  If this occurs, then a second attempt is made in acpi_processor_get_info().
> >  Note that the arm64 specific call has not yet been added so for now this will
> >  be called for the original hotplug case.
> >  
> >  For architectures that do not defer until the ACPI Processor driver loads
> >  (e.g. x86), for initially present CPUs there will already be a CPU device. If
> >  present do not try to register again.
> >  
> >  Systems can still be booted with 'acpi=off', or not include an ACPI
> >  description at all as in these cases arch_register_cpu() will not have
> >  deferred registration when first called.
> >  
> >  This moves the CPU register logic back to a subsys_initcall(), while the
> >  memory nodes will have been registered earlier.
> >  Note this is where the call was prior to the cleanup series so there should be
> >  no side effects of moving it back again for this specific case.
> >  
> >  [PATCH 00/21] Initial cleanups for vCPU HP.
> >  https://lore.kernel.org/all/ZVyz%2FVe5pPu8AWoA@shell.armlinux.org.uk/
> >  
> >  e.g. 5b95f94c3b9f ("x86/topology: Switch over to GENERIC_CPU_DEVICES")
> >  
> >  Signed-off-by: James Morse <james.morse@arm.com>
> >  Reviewed-by: Gavin Shan <gshan@redhat.com>
> >  Tested-by: Miguel Luis <miguel.luis@oracle.com>
> >  Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> >  Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> >  Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> >  Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >  Signed-off-by: Joanthan Cameron <Jonathan.Cameron@huawei.com>
> >  ---
> >  v6: Squash the two paths for conventional CPU Hotplug and arm64
> >      vCPU HP.
> >  v5: Update commit message to make it clear this is moving the
> >      init back to where it was until very recently.
> >  
> >      No longer change the condition in the earlier registration point
> >      as that will be handled by the arm64 registration routine
> >      deferring until called again here.
> >  ---
> >   drivers/acpi/acpi_processor.c | 12 +++++++++++-
> >   1 file changed, 11 insertions(+), 1 deletion(-)
> >  
> >  diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> >  index 7ecb13775d7f..0cac77961020 100644
> >  --- a/drivers/acpi/acpi_processor.c
> >  +++ b/drivers/acpi/acpi_processor.c
> >  @@ -356,8 +356,18 @@ static int acpi_processor_get_info(struct
> >  acpi_device *device)
> >   	 *
> >   	 *  NOTE: Even if the processor has a cpuid, it may not be present
> >   	 *  because cpuid <-> apicid mapping is persistent now.
> >  +	 *
> >  +	 *  Note this allows 3 flows, it is up to the arch_register_cpu()
> >  +	 *  call to reject any that are not supported on a given architecture.
> >  +	 *  A) CPU becomes present.
> >  +	 *  B) Previously invalid logical CPU ID (Same as becoming present)
> >  +	 *  C) CPU already present and now being enabled (and wasn't
> >  registered
> >  +	 *     early on an arch that doesn't defer to here)
> >   	 */
> >  -	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
> >  +	if ((!invalid_logical_cpuid(pr->id) && cpu_present(pr->id) &&
> >  +	     !get_cpu_device(pr->id)) ||
> >  +	    invalid_logical_cpuid(pr->id) ||
> >  +	    !cpu_present(pr->id)) {  
> 
> 
Hi Salil,

Thanks for quick review!

> Logic is clear but it is ugly. We should turn them into macro or inline.

You've found the 'ugly' in this approach vs keeping them separate.

For this version I wanted to keep it clear that indeed this condition
is a complex mess of different things (and to let people compare
it easily with the two paths in v5 to convinced themselves this
is the same) 

It's also a little tricky to do, so will need some thought.

I don't think a simple acpi_cpu_is_hotplug() condition is useful
as it just moves the complexity away from where a reader is looking
and it would only be used in this one case.

It doesn't separate well into finer grained subconditions because
(C) is a messy case of the vCPU HP case and a not done
something else earlier.  The disadvantage of only deferring for
arm64 and not other architectures.

The best I can quickly come up with is something like this:
#define acpi_cpu_not_present(cpu) \
	(invalid_logical_cpuid(cpu) || !cpu_present(cpu))
#define acpi_cpu_not_enabled(cpu) \
	(!invalid_logical_cpuid(cpu) || cpu_present(cpu))

	if ((apci_cpu_not_enabled(pr->id) && !get_cpu_device(pr->id) ||
	    acpi_cpu_not_present(pr->id))

Which would still need the same amount of documentation. The
code still isn't enough for me to immediately be able to see
what is going on.

So maybe worth it... I'm not sure.  Rafael, you get to keep this
fun, what would you prefer?

Jonathan


> 
> 
> Thanks
> Salil.


