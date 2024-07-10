Return-Path: <linux-arch+bounces-5341-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AEB92CCDB
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 10:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF637B2470E
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 08:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6609686250;
	Wed, 10 Jul 2024 08:23:54 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A7B1EB40;
	Wed, 10 Jul 2024 08:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599834; cv=none; b=r4rVgq6SLNasR8O6olVi3lM/o+ku4RZXnLsPxnKn1urTuZJxvYabG4K232D/SUrdblgIaCORjnOCEgCt5ka2X/dzjDfDNdnZpzitq2R6/FpRh3JbRKFGOf1a+0hiMEmdByAJ/AkF++7vqCpUVgPFd8auJjsDr2fVpHYVocAL1uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599834; c=relaxed/simple;
	bh=lLbZWWhD2Kc0m9i1WyKM0bivY2hDTrq14bOoB/ilx0Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IIkSLV9qg2R+y2UKkBamQx0vLB+9pjY2ec+lNQL8BG7Q3DSKYT+29ajlKr2ksRErRWdyceCUE/CII/JzWo4BBicl9AAKw581nyHQtv54Ywi/nNbo5x3W7aoS0CmklLeEgFSz2yETwNAuCfPLHi2HI2zrk9snVtWOnNIl0TpyNd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WJrRs4clwz6K91l;
	Wed, 10 Jul 2024 16:21:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 40FB01401DC;
	Wed, 10 Jul 2024 16:23:49 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 10 Jul
 2024 09:23:48 +0100
Date: Wed, 10 Jul 2024 09:23:47 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Huacai Chen <chenhuacai@kernel.org>
CC: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Peter
 Zijlstra" <peterz@infradead.org>, <loongarch@lists.linux.dev>,
	<x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, James Morse
	<james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, "Jean-Philippe
 Brucker" <jean-philippe@linaro.org>, Hanjun Guo <guohanjun@huawei.com>, Gavin
 Shan <gshan@redhat.com>, Ingo Molnar <mingo@redhat.com>, "Borislav Petkov"
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<linuxarm@huawei.com>, <justin.he@arm.com>, <jianyong.wu@arm.com>
Subject: Re: [PATCH v10 18/19] arm64: document virtual CPU hotplug's
 expectations
Message-ID: <20240710092347.00005b99@Huawei.com>
In-Reply-To: <CAAhV-H6Ghfj74hcOQCn6yz4t-_p=WkYdmWRrw=v8FK6t+f_EkA@mail.gmail.com>
References: <20240529133446.28446-1-Jonathan.Cameron@huawei.com>
	<20240529133446.28446-19-Jonathan.Cameron@huawei.com>
	<CAAhV-H6Ghfj74hcOQCn6yz4t-_p=WkYdmWRrw=v8FK6t+f_EkA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 30 Jun 2024 20:53:51 +0800
Huacai Chen <chenhuacai@kernel.org> wrote:

> Hi, Jonathan,
>=20
> On Wed, May 29, 2024 at 9:44=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > From: James Morse <james.morse@arm.com>
> >
> > Add a description of physical and virtual CPU hotplug, explain the
> > differences and elaborate on what is required in ACPI for a working
> > virtual hotplug system.
> >
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > Reviewed-by: Gavin Shan <gshan@redhat.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  Documentation/arch/arm64/cpu-hotplug.rst | 79 ++++++++++++++++++++++++
> >  Documentation/arch/arm64/index.rst       |  1 +
> >  2 files changed, 80 insertions(+)
> >
> > diff --git a/Documentation/arch/arm64/cpu-hotplug.rst b/Documentation/a=
rch/arm64/cpu-hotplug.rst
> > new file mode 100644
> > index 000000000000..76ba8d932c72
> > --- /dev/null
> > +++ b/Documentation/arch/arm64/cpu-hotplug.rst
> > @@ -0,0 +1,79 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +.. _cpuhp_index:
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +CPU Hotplug and ACPI
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +CPU hotplug in the arm64 world is commonly used to describe the kernel=
 taking
> > +CPUs online/offline using PSCI. This document is about ACPI firmware a=
llowing
> > +CPUs that were not available during boot to be added to the system lat=
er.
> > +
> > +``possible`` and ``present`` refer to the state of the CPU as seen by =
linux.
> > +
> > +
> > +CPU Hotplug on physical systems - CPUs not present at boot
> > +----------------------------------------------------------
> > +
> > +Physical systems need to mark a CPU that is ``possible`` but not ``pre=
sent`` as
> > +being ``present``. An example would be a dual socket machine, where th=
e package
> > +in one of the sockets can be replaced while the system is running.
> > +
> > +This is not supported.
> > +
> > +In the arm64 world CPUs are not a single device but a slice of the sys=
tem.
> > +There are no systems that support the physical addition (or removal) o=
f CPUs
> > +while the system is running, and ACPI is not able to sufficiently desc=
ribe
> > +them.
> > +
> > +e.g. New CPUs come with new caches, but the platform's cache toplogy is
> > +described in a static table, the PPTT. How caches are shared between C=
PUs is
> > +not discoverable, and must be described by firmware.
> > +
> > +e.g. The GIC redistributor for each CPU must be accessed by the driver=
 during
> > +boot to discover the system wide supported features. ACPI's MADT GICC
> > +structures can describe a redistributor associated with a disabled CPU=
, but
> > +can't describe whether the redistributor is accessible, only that it i=
s not
> > +'always on'.
> > +
> > +arm64's ACPI tables assume that everything described is ``present``.
> > +
> > +
> > +CPU Hotplug on virtual systems - CPUs not enabled at boot
> > +--------------------------------------------------------- =20
> In my opinion "enabled" is not a good description here. It is too
> general and confusing. For example, in enable_nonboot_cpus(), "enable"
> means make a "present" CPU "online", while in ACPI MADT, "enabled"
> means "possible" but not "present". So I suggest rename "enabled" to
> "pending" or "usable" or some other better words. Thanks.
Hi Huacai,

Tricky to find a good word given the mess of terms being reused.
The use of enabled is specifically referring to the terms used in ACPI
so I think will be hard to get away from without making that connection
really non obvious. =20

The 'enabled' text in ACPI does describe 'enabled' as
meaning 'ready for use'.  So perhaps
CPU Hotplug on virtual systems - CPUs that are not ready for use at boot
and rely on the existing text that says this is about the enabled and
online capable bits to make that connection?
The snag is that phrasing kind of suggests they are just late for some
reason rather than it being a policy thing in the hypervisor.

James, I think this is your text, any thoughts?

Jonathan


>=20
> Huacai.
>=20
> > +
> > +Virtual systems have the advantage that all the properties the system =
will
> > +ever have can be described at boot. There are no power-domain consider=
ations
> > +as such devices are emulated.
> > +
> > +CPU Hotplug on virtual systems is supported. It is distinct from physi=
cal
> > +CPU Hotplug as all resources are described as ``present``, but CPUs ma=
y be
> > +marked as disabled by firmware. Only the CPU's online/offline behaviou=
r is
> > +influenced by firmware. An example is where a virtual machine boots wi=
th a
> > +single CPU, and additional CPUs are added once a cloud orchestrator de=
ploys
> > +the workload.
> > +
> > +For a virtual machine, the VMM (e.g. Qemu) plays the part of firmware.
> > +
> > +Virtual hotplug is implemented as a firmware policy affecting which CP=
Us can be
> > +brought online. Firmware can enforce its policy via PSCI's return code=
s. e.g.
> > +``DENIED``.
> > +
> > +The ACPI tables must describe all the resources of the virtual machine=
. CPUs
> > +that firmware wishes to disable either from boot (or later) should not=
 be
> > +``enabled`` in the MADT GICC structures, but should have the ``online =
capable``
> > +bit set, to indicate they can be enabled later. The boot CPU must be m=
arked as
> > +``enabled``.  The 'always on' GICR structure must be used to describe =
the
> > +redistributors.
> > +
> > +CPUs described as ``online capable`` but not ``enabled`` can be set to=
 enabled
> > +by the DSDT's Processor object's _STA method. On virtual systems the _=
STA method
> > +must always report the CPU as ``present``. Changes to the firmware pol=
icy can
> > +be notified to the OS via device-check or eject-request.
> > +
> > +CPUs described as ``enabled`` in the static table, should not have the=
ir _STA
> > +modified dynamically by firmware. Soft-restart features such as kexec =
will
> > +re-read the static properties of the system from these static tables, =
and
> > +may malfunction if these no longer describe the running system. Linux =
will
> > +re-discover the dynamic properties of the system from the _STA method =
later
> > +during boot.
> > diff --git a/Documentation/arch/arm64/index.rst b/Documentation/arch/ar=
m64/index.rst
> > index d08e924204bf..78544de0a8a9 100644
> > --- a/Documentation/arch/arm64/index.rst
> > +++ b/Documentation/arch/arm64/index.rst
> > @@ -13,6 +13,7 @@ ARM64 Architecture
> >      asymmetric-32bit
> >      booting
> >      cpu-feature-registers
> > +    cpu-hotplug
> >      elf_hwcaps
> >      hugetlbpage
> >      kdump
> > --
> > 2.39.2
> >
> > =20


