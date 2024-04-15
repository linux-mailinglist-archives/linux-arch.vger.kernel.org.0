Return-Path: <linux-arch+bounces-3678-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD35D8A4E19
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 13:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99EB1C22142
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 11:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7CD66B50;
	Mon, 15 Apr 2024 11:51:36 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E1D5FBA3;
	Mon, 15 Apr 2024 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713181896; cv=none; b=n4WY4UeXyNldLcOHhNaUlGBxl7ft5BC4DG9qhZfNqVjlnzoPuHNvyZKuuvQktuR5HxeEC1+x8PejmuB8uxKbugXVZUgBD0KvLkOLB3C/utHNiD5HHBUfTdcCfrZm1fB/ZbR0Gc7NyOHq8jYrM82J7+G86bowDfxi0ZVnbUb8Tq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713181896; c=relaxed/simple;
	bh=+ONUFydMP432KJ+n6/I96tgswg/pF1TBrAE5SoLFanQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fNX276k/PUAbf66r6rBKRhPi9PYMTKSJq4B2cGQIY/Ns3zqJT+Qc5DOzIFyjuYznXwIN2KQ4T2prQ1f7h8GMcheJU/bjxm2wFkq5ZQ6GRS+t2liSFAL26PcB8/Pz/MsVxVQONqRNBDApG/5kNCgJrPTC5i1zXfZWyIIfao5sSS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VJ57P1SgRz6JBTv;
	Mon, 15 Apr 2024 19:49:37 +0800 (CST)
Received: from lhrpeml500004.china.huawei.com (unknown [7.191.163.9])
	by mail.maildlp.com (Postfix) with ESMTPS id 3EF60140CB9;
	Mon, 15 Apr 2024 19:51:31 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 12:51:30 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.035;
 Mon, 15 Apr 2024 12:51:30 +0100
From: Salil Mehta <salil.mehta@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>, "Russell King (Oracle)"
	<linux@armlinux.org.uk>, "Rafael J. Wysocki" <rafael@kernel.org>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>, Miguel Luis
	<miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, "Jean-Philippe
 Brucker" <jean-philippe@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Linuxarm
	<linuxarm@huawei.com>, "justin.he@arm.com" <justin.he@arm.com>,
	"jianyong.wu@arm.com" <jianyong.wu@arm.com>
Subject: RE: [PATCH v5 03/18] ACPI: processor: Register deferred CPUs from
 acpi_processor_get_info()
Thread-Topic: [PATCH v5 03/18] ACPI: processor: Register deferred CPUs from
 acpi_processor_get_info()
Thread-Index: AQHajOchpfPN+k2lSk2QcH/fNdeOvbFk5HgAgAAdgQCAAAqxAIAEJ9JQ
Date: Mon, 15 Apr 2024 11:51:30 +0000
Message-ID: <e80bfa8cb9b74997a4214e531366c71d@huawei.com>
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
 <20240412143719.11398-4-Jonathan.Cameron@huawei.com>
 <CAJZ5v0gNvy2e=hOGQQ2kLpnrDr8=QGBax-E5odEJ=7BA8qW-9A@mail.gmail.com>
 <ZhmWkE+fCEG/WFoi@shell.armlinux.org.uk> <87bk6ez4hj.ffs@tglx>
In-Reply-To: <87bk6ez4hj.ffs@tglx>
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

Hello,

>  From: Thomas Gleixner <tglx@linutronix.de>
>  Sent: Friday, April 12, 2024 9:55 PM
> =20
>  On Fri, Apr 12 2024 at 21:16, Russell King (Oracle) wrote:
>  > On Fri, Apr 12, 2024 at 08:30:40PM +0200, Rafael J. Wysocki wrote:
>  >> Say acpi_map_cpu) / acpi_unmap_cpu() are turned into arch calls.
>  >> What's the difference then?  The locking, which should be fine if I'm
>  >> not mistaken and need_hotplug_init that needs to be set if this code
>  >> runs after the processor driver has loaded AFAICS.
>  >
>  > It is over this that I walked away from progressing this code, because
>  > I don't think it's quite as simple as you make it out to be.
>  >
>  > Yes, acpi_map_cpu() and acpi_unmap_cpu() are already arch
>  implemented
>  > functions, so Arm64 can easily provide stubs for these that do nothing=
.
>  > That never caused me any concern.
>  >
>  > What does cause me great concern though are the finer details. For
>  > example, above you seem to drop the evaluation of _STA for the
>  > "make_present" case - I've no idea whether that is something that
>  > should be deleted or not (if it is something that can be deleted, then
>  > why not delete it now?)
>  >
>  > As for the cpu locking, I couldn't find anything in
>  > arch_register_cpu() that depends on the cpu_maps_update stuff nor
>  > needs the cpus_write_lock being taken - so I've no idea why the
>  > "make_present" case takes these locks.
> =20
>  Anything which updates a CPU mask, e.g. cpu_present_mask, after early
>  boot must hold the appropriate write locks. Otherwise it would be possib=
le
>  to online a CPU which just got marked present, but the registration has =
not
>  completed yet.
> =20
>  > Finally, the "pr->flags.need_hotplug_init =3D 1" thing... it's not
>  > obvious that this is required - remember that with Arm64's "enabled"
>  > toggling, the "processor" is a slice of the system and doesn't
>  > actually go away - it's just "not enabled" for use.
>  >
>  > Again, as "processors" in Arm64 are slices of the system, they have to
>  > be fully described in ACPI before the OS boots, and they will be
>  > marked as being "present", which means they will be enumerated, and
>  > the driver will be probed. Any processor that is not to be used will
>  > not have its enabled bit set. It is my understanding that every
>  > processor will result in the ACPI processor driver being bound to it
>  > whether its enabled or not.
>  >
>  > The difference between real hotplug and Arm64 hotplug is that real
>  > hotplug makes stuff not-present (and thus unenumerable). Arm64
>  hotplug
>  > makes stuff not-enabled which is still enumerable.
> =20
>  Define "real hotplug" :)
> =20
>  Real physical hotplug does not really exist. That's at least true for x8=
6, where
>  the physical hotplug support was chased for a while, but never ended up =
in
>  production.
> =20
>  Though virtualization happily jumped on it to hot add/remove CPUs to/fro=
m
>  a guest.
> =20
>  There are limitations to this and we learned it the hard way on X86. At =
the
>  end we came up with the following restrictions:
> =20
>      1) All possible CPUs have to be advertised at boot time via firmware
>         (ACPI/DT/whatever) independent of them being present at boot time
>         or not.
> =20
>         That guarantees proper sizing and ensures that associations
>         between hardware entities and software representations and the
>         resulting topology are stable for the lifetime of a system.
> =20
>         It is really required to know the full topology of the system at
>         boot time especially with hybrid CPUs where some of the cores
>         have hyperthreading and the others do not.
> =20
> =20
>      2) Hot add can only mark an already registered (possible) CPU
>         present. Adding non-registered CPUs after boot is not possible.
> =20
>         The CPU must have been registered in #1 already to ensure that
>         the system topology does not suddenly change in an incompatible
>         way at run-time.
> =20
>  The same restriction would apply to real physical hotplug. I don't think=
 that's
>  any different for ARM64 or any other architecture.


There is a difference:

1.   ARM arch does not allows for any processor to be NOT present. Hence, b=
ecause of
this restriction any of its related per-cpu components must be present and =
enumerated
at the boot time as well (exposed by firmware and ACPI). This means all the=
 enumerated
processors will be marked as 'present' but they might exist in NOT enabled =
(_STA.enabled=3D0)
state.
=20
There was one clear difference and please correct me if I'm wrong here,  fo=
r x86, the LAPIC
associated with the x86 core can be brought online later even after boot?

But for ARM Arch, processors and its corresponding per-cpu components like =
redistributors
all need to be present and enumerated during the boot time. Redistributors =
are part of
ALWAYS-ON power domain.=20

2.  Agreed regarding the topology. Are you suggesting that we must call arc=
h_register_cpu()
during boot time for all the 'present' CPUs? Even if that's the case, we mi=
ght still want to defer
registration of the cpu device (register_cpu() API) with the Linux device m=
odel. Later is what
we are doing to hide/unhide the CPUs from the user while STA.Enabled Bit is=
 toggled due to
CPU (un)plug action.


Best regards
Salil.


> =20
>  Hope that helps.
> =20
>  Thanks,
> =20
>          tglx


