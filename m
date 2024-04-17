Return-Path: <linux-arch+bounces-3770-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6D48A8965
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 18:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EAB91F2494E
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 16:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8500C171065;
	Wed, 17 Apr 2024 16:55:13 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C593F1581F0;
	Wed, 17 Apr 2024 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372913; cv=none; b=gwWlhWvavu34uf6ylA9wxOJuFNHCzPdlURyaZ0evVcufcawCenAbbej0wHm15FthVgl8cIc498UrDfswKKDl3fVZU8opOa4bko5j5GpiIYMoFsWmrpZDFnLwQpRCkba1JGvTj3f17AhXWSld+ctuF1UJ7A6RDXE8SmLkI29LVfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372913; c=relaxed/simple;
	bh=LTW2xvAuavXyOzbR1XOTWRWDNOnqiX2ba2R8DGu801k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kxVVUJJcyWMXjM8UtOZyJayfPnVesnxUyGcIZDNVdxVH1TFIG+OPMCAxKbQKoOPQDPrdI+j9RqfiU3hl6IWsQo5UwLtGj3n2qqhq8TJvuQXjcGHyDSG5vwDkTmlFJ89koS/rO2yYVPEJmQLTKgh8Ugj9uprcIXlPeEAfMC5ZOZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKRmg57swz67n5j;
	Thu, 18 Apr 2024 00:53:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 17FCF140B38;
	Thu, 18 Apr 2024 00:55:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 17 Apr
 2024 17:55:07 +0100
Date: Wed, 17 Apr 2024 17:55:06 +0100
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
Subject: Re: [PATCH v6 13/16] arm64: arch_register_cpu() variant to check if
 an ACPI handle is now available.
Message-ID: <20240417175506.00004934@Huawei.com>
In-Reply-To: <073c665c658e40f080c766803d326b77@huawei.com>
References: <20240417131909.7925-1-Jonathan.Cameron@huawei.com>
	<20240417131909.7925-14-Jonathan.Cameron@huawei.com>
	<073c665c658e40f080c766803d326b77@huawei.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 17 Apr 2024 17:33:02 +0100
Salil Mehta <salil.mehta@huawei.com> wrote:

> Hi Jonathan,
> 
> >  From: Jonathan Cameron <jonathan.cameron@huawei.com>
> >  Sent: Wednesday, April 17, 2024 2:19 PM
> >  
> >  The ARM64 architecture does not support physical CPU HP today.
> >  To avoid any possibility of a bug against such an architecture if defined in
> >  future, check for the physical CPU HP case (not present) and return an error
> >  on any such attempt.
> >  
> >  On ARM64 virtual CPU Hotplug relies on the status value that can be queried
> >  via the AML method _STA for the CPU object.
> >  
> >  There are two conditions in which the CPU can be registered.
> >  1) ACPI disabled.
> >  2) ACPI enabled and the acpi_handle is available.
> >     _STA evaluates to the CPU is both enabled and present.
> >     (Note that in absence of the _STA method they are always in this
> >      state).
> >  
> >  If neither of these conditions is met the CPU is not 'yet' ready to be used
> >  and -EPROBE_DEFER is returned.
> >  
> >  Success occurs in the early attempt to register the CPUs if we are booting
> >  with DT (no concept yet of vCPU HP) if not it succeeds for already enabled
> >  CPUs when the ACPI Processor driver attaches to them.  Finally it may
> >  succeed via the CPU Hotplug code indicating that the CPU is now enabled.
> >  
> >  For ACPI if CONFIG_ACPI_PROCESSOR the only path to get to
> >  arch_register_cpu() with that handle set is via
> >  acpi_processor_hot_add_init() which is only called from an ACPI bus scan in
> >  which _STA has already been queried there is no need to repeat it here.
> >  Add a comment to remind us of this in the future.
> >  
> >  Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> >  Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >  ---
> >  v6: Add protection again Physical CPU HP to the arch specific code
> >      and don't actually check _STA
> >  
> >  Tested on arm64 with ACPI + DT build and DT only builds, booting with ACPI
> >  and DT as appropriate.
> >  ---
> >   arch/arm64/kernel/smp.c | 53
> >  +++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 53 insertions(+)
> >  
> >  diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c index
> >  dc0e0b3ec2d4..ccb6ad347df9 100644
> >  --- a/arch/arm64/kernel/smp.c
> >  +++ b/arch/arm64/kernel/smp.c
> >  @@ -504,6 +504,59 @@ static int __init smp_cpu_setup(int cpu)  static bool
> >  bootcpu_valid __initdata;  static unsigned int cpu_count = 1;
> >  
> >  +int arch_register_cpu(int cpu)
> >  +{
> >  +	acpi_handle acpi_handle = acpi_get_processor_handle(cpu);
> >  +	struct cpu *c = &per_cpu(cpu_devices, cpu);
> >  +
> >  +	if (!acpi_disabled && !acpi_handle &&
> >  +	    IS_ENABLED(CONFIG_ACPI_HOTPLUG_CPU))
> >  +		return -EPROBE_DEFER;
> >  +
> >  +#ifdef CONFIG_ACPI_HOTPLUG_CPU
> >  +	/* For now block anything that looks like physical CPU Hotplug */
> >  +	if (invalid_logical_cpuid(cpu) || !cpu_present(cpu)) {
> >  +		pr_err_once("Changing CPU present bit is not
> >  supported\n");
> >  +		return -ENODEV;
> >  +	}
> >  +#endif
> >  +
> >  +	/*
> >  +	 * Availability of the acpi handle is sufficient to establish
> >  +	 * that _STA has aleady been checked. No need to recheck here.
> >  +	 */
> >  +	c->hotpluggable = arch_cpu_is_hotpluggable(cpu);
> >  +  
> 
> 
> We would still need 'enabled' bitmask as applications need a way to clearly
> get which processors are enabled and usable in case of ARM64. Otherwise,
> they will end up scanning the entire MAX CPU space to figure out which
> processors have been plugged or unplugged. It is inefficient to bank upon
> errors to detect this and unnecessary to scan again and again.
>            
> +            set_cpu_enabled(cpu, true);   // will need this change
> 
> 
> And its corresponding additions of enabled bitmask along side the present masks.
> 
> I think we had this discussion in Linaro Open Discussions group few years
> back.

Agreed - but if I understand correctly that is  handled in patch 16 -
which introduced the enabled bitmask. I tested that works and it all seems fine.
Done for all architectures in register_cpu() and unregister_cpu() rather
than in arch specific code.

Jonathan


> 
> 
> >  +	return register_cpu(c, cpu);
> >  +}
> >  +
> >  +#ifdef CONFIG_ACPI_HOTPLUG_CPU
> >  +void arch_unregister_cpu(int cpu)
> >  +{
> >  +	acpi_handle acpi_handle = acpi_get_processor_handle(cpu);
> >  +	struct cpu *c = &per_cpu(cpu_devices, cpu);
> >  +	acpi_status status;
> >  +	unsigned long long sta;
> >  +
> >  +	if (!acpi_handle) {
> >  +		pr_err_once("Removing a CPU without associated ACPI
> >  handle\n");
> >  +		return;
> >  +	}
> >  +
> >  +	status = acpi_evaluate_integer(acpi_handle, "_STA", NULL, &sta);
> >  +	if (ACPI_FAILURE(status))
> >  +		return;
> >  +
> >  +	/* For now do not allow anything that looks like physical CPU HP */
> >  +	if (cpu_present(cpu) && !(sta & ACPI_STA_DEVICE_PRESENT)) {
> >  +		pr_err_once("Changing CPU present bit is not
> >  supported\n");
> >  +		return;
> >  +	}
> >  +  
> 
> For the same reasons as above:
> 
> +            set_cpu_enabled(cpu, flase);   // will need this change
> 
> 
> >  +	unregister_cpu(c);
> >  +}
> >  +#endif /* CONFIG_ACPI_HOTPLUG_CPU */
> >  +
> >   #ifdef CONFIG_ACPI
> >   static struct acpi_madt_generic_interrupt cpu_madt_gicc[NR_CPUS];
> >  
> >  --
> >  2.39.2  
> 


