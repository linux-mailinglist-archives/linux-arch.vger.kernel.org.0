Return-Path: <linux-arch+bounces-3772-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C67E8A89C6
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 19:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB0F1C220BA
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 17:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6149C171E50;
	Wed, 17 Apr 2024 17:03:42 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7431D17166B;
	Wed, 17 Apr 2024 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373422; cv=none; b=B9wNPGnI5ggWl58oCH1p8THMwgJFcsZ52hqJIjyFeePSopEugd6dDvMaROeLZLr7Rji5PiSjP9CLunGAD5rdwyhMSn0MDmxT9nGOFdzTRTYkkj0Jl9QofOIO5isVQt1oJf71QiQ5mpuPcAXVlkm4ZAa+7gFvowf3Dy09pqxJC7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373422; c=relaxed/simple;
	bh=5LjZxXRpQmZ1Cx272OXhRlHioTFt4XuGDVYUrurra6I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iiXcJhiah8h5Lp5b10AbMhHhDjERUkQuzVdpQbIUo95CM7IfC5ifHduFKtobOp1U22pdGuPK5HyTBBFnryDAH7Y+b0+67ostyNuwU4+k3qaatLNGMON98yolPw8FC/4hnvHtvfLVZmbjynIqnn59j6ZL8I/tdZsOfdR+Wlnxo1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKRv43sY6z6K8kJ;
	Thu, 18 Apr 2024 00:58:40 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F4A51400CD;
	Thu, 18 Apr 2024 01:03:38 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 18:03:38 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.035;
 Wed, 17 Apr 2024 18:03:38 +0100
From: Salil Mehta <salil.mehta@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
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
Subject: RE: [PATCH v6 13/16] arm64: arch_register_cpu() variant to check if
 an ACPI handle is now available.
Thread-Topic: [PATCH v6 13/16] arm64: arch_register_cpu() variant to check if
 an ACPI handle is now available.
Thread-Index: AQHakMrD47/IJzgFn0S+CVdTscwPrLFspk/w///3VwCAABK8AA==
Date: Wed, 17 Apr 2024 17:03:37 +0000
Message-ID: <0a8835e8d8884f4cbc30928d7d32d7e2@huawei.com>
References: <20240417131909.7925-1-Jonathan.Cameron@huawei.com>
	<20240417131909.7925-14-Jonathan.Cameron@huawei.com>
	<073c665c658e40f080c766803d326b77@huawei.com>
 <20240417175506.00004934@Huawei.com>
In-Reply-To: <20240417175506.00004934@Huawei.com>
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
>  Sent: Wednesday, April 17, 2024 5:55 PM
> =20
>  On Wed, 17 Apr 2024 17:33:02 +0100
>  Salil Mehta <salil.mehta@huawei.com> wrote:
> =20
>  > Hi Jonathan,
>  >
>  > >  From: Jonathan Cameron <jonathan.cameron@huawei.com>
>  > >  Sent: Wednesday, April 17, 2024 2:19 PM
>  > >
>  > >  The ARM64 architecture does not support physical CPU HP today.
>  > >  To avoid any possibility of a bug against such an architecture if
>  > > defined in  future, check for the physical CPU HP case (not present)
>  > > and return an error  on any such attempt.
>  > >
>  > >  On ARM64 virtual CPU Hotplug relies on the status value that can be
>  > > queried  via the AML method _STA for the CPU object.
>  > >
>  > >  There are two conditions in which the CPU can be registered.
>  > >  1) ACPI disabled.
>  > >  2) ACPI enabled and the acpi_handle is available.
>  > >     _STA evaluates to the CPU is both enabled and present.
>  > >     (Note that in absence of the _STA method they are always in this
>  > >      state).
>  > >
>  > >  If neither of these conditions is met the CPU is not 'yet' ready to
>  > > be used  and -EPROBE_DEFER is returned.
>  > >
>  > >  Success occurs in the early attempt to register the CPUs if we are
>  > > booting  with DT (no concept yet of vCPU HP) if not it succeeds for
>  > > already enabled  CPUs when the ACPI Processor driver attaches to
>  > > them.  Finally it may  succeed via the CPU Hotplug code indicating t=
hat
>  the CPU is now enabled.
>  > >
>  > >  For ACPI if CONFIG_ACPI_PROCESSOR the only path to get to
>  > >  arch_register_cpu() with that handle set is via
>  > >  acpi_processor_hot_add_init() which is only called from an ACPI bus
>  > > scan in  which _STA has already been queried there is no need to rep=
eat
>  it here.
>  > >  Add a comment to remind us of this in the future.
>  > >
>  > >  Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
>  > >  Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>  > >  ---
>  > >  v6: Add protection again Physical CPU HP to the arch specific code
>  > >      and don't actually check _STA
>  > >
>  > >  Tested on arm64 with ACPI + DT build and DT only builds, booting
>  > > with ACPI  and DT as appropriate.
>  > >  ---
>  > >   arch/arm64/kernel/smp.c | 53
>  > >  +++++++++++++++++++++++++++++++++++++++++
>  > >   1 file changed, 53 insertions(+)
>  > >
>  > >  diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>  > > index
>  > >  dc0e0b3ec2d4..ccb6ad347df9 100644
>  > >  --- a/arch/arm64/kernel/smp.c
>  > >  +++ b/arch/arm64/kernel/smp.c
>  > >  @@ -504,6 +504,59 @@ static int __init smp_cpu_setup(int cpu)
>  > > static bool  bootcpu_valid __initdata;  static unsigned int
>  > > cpu_count =3D 1;
>  > >
>  > >  +int arch_register_cpu(int cpu)
>  > >  +{
>  > >  +	acpi_handle acpi_handle =3D acpi_get_processor_handle(cpu);
>  > >  +	struct cpu *c =3D &per_cpu(cpu_devices, cpu);
>  > >  +
>  > >  +	if (!acpi_disabled && !acpi_handle &&
>  > >  +	    IS_ENABLED(CONFIG_ACPI_HOTPLUG_CPU))
>  > >  +		return -EPROBE_DEFER;
>  > >  +
>  > >  +#ifdef CONFIG_ACPI_HOTPLUG_CPU
>  > >  +	/* For now block anything that looks like physical CPU Hotplug */
>  > >  +	if (invalid_logical_cpuid(cpu) || !cpu_present(cpu)) {
>  > >  +		pr_err_once("Changing CPU present bit is not
>  > >  supported\n");
>  > >  +		return -ENODEV;
>  > >  +	}
>  > >  +#endif
>  > >  +
>  > >  +	/*
>  > >  +	 * Availability of the acpi handle is sufficient to establish
>  > >  +	 * that _STA has aleady been checked. No need to recheck here.
>  > >  +	 */
>  > >  +	c->hotpluggable =3D arch_cpu_is_hotpluggable(cpu);
>  > >  +
>  >
>  >
>  > We would still need 'enabled' bitmask as applications need a way to
>  > clearly get which processors are enabled and usable in case of ARM64.
>  > Otherwise, they will end up scanning the entire MAX CPU space to
>  > figure out which processors have been plugged or unplugged. It is
>  > inefficient to bank upon errors to detect this and unnecessary to scan
>  again and again.
>  >
>  > +            set_cpu_enabled(cpu, true);   // will need this change
>  >
>  >
>  > And its corresponding additions of enabled bitmask along side the pres=
ent
>  masks.
>  >
>  > I think we had this discussion in Linaro Open Discussions group few
>  > years back.
> =20
>  Agreed - but if I understand correctly that is  handled in patch 16 - wh=
ich
>  introduced the enabled bitmask. I tested that works and it all seems fin=
e.
>  Done for all architectures in register_cpu() and unregister_cpu() rather=
 than
>  in arch specific code.


Sorry, I missed that. Yes, this logic is already present in later patches.


Thanks
Salil.


> =20
>  Jonathan
> =20
> =20
>  >
>  >
>  > >  +	return register_cpu(c, cpu);
>  > >  +}
>  > >  +
>  > >  +#ifdef CONFIG_ACPI_HOTPLUG_CPU
>  > >  +void arch_unregister_cpu(int cpu)
>  > >  +{
>  > >  +	acpi_handle acpi_handle =3D acpi_get_processor_handle(cpu);
>  > >  +	struct cpu *c =3D &per_cpu(cpu_devices, cpu);
>  > >  +	acpi_status status;
>  > >  +	unsigned long long sta;
>  > >  +
>  > >  +	if (!acpi_handle) {
>  > >  +		pr_err_once("Removing a CPU without associated ACPI
>  > >  handle\n");
>  > >  +		return;
>  > >  +	}
>  > >  +
>  > >  +	status =3D acpi_evaluate_integer(acpi_handle, "_STA", NULL, &sta)=
;
>  > >  +	if (ACPI_FAILURE(status))
>  > >  +		return;
>  > >  +
>  > >  +	/* For now do not allow anything that looks like physical CPU HP =
*/
>  > >  +	if (cpu_present(cpu) && !(sta & ACPI_STA_DEVICE_PRESENT)) {
>  > >  +		pr_err_once("Changing CPU present bit is not
>  > >  supported\n");
>  > >  +		return;
>  > >  +	}
>  > >  +
>  >
>  > For the same reasons as above:
>  >
>  > +            set_cpu_enabled(cpu, flase);   // will need this change
>  >
>  >
>  > >  +	unregister_cpu(c);
>  > >  +}
>  > >  +#endif /* CONFIG_ACPI_HOTPLUG_CPU */  +
>  > >   #ifdef CONFIG_ACPI
>  > >   static struct acpi_madt_generic_interrupt cpu_madt_gicc[NR_CPUS];
>  > >
>  > >  --
>  > >  2.39.2
>  >


