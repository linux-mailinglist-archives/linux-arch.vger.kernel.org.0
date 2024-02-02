Return-Path: <linux-arch+bounces-2005-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC948475AA
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 18:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F0D1F2A20A
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 17:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F34614A4D9;
	Fri,  2 Feb 2024 17:04:21 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA8E148FF0;
	Fri,  2 Feb 2024 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893461; cv=none; b=VsdUsCftPhVRBYsewDY7aKRD2pBliwUZFx/brhk6kU9uwbslADsXTbwXFTUkt2mYH6a22gaDEhGTMSc19/M+bFw5KOAmjk11xBzVI2nBW2Om11aR3vKEdDE1aFWkIx08QNF99p2yrxE0ACUXOMhj0+x3MHSEEIqCSc2rRnermE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893461; c=relaxed/simple;
	bh=+6PX3jMjQrHTOGNXA5nPZT3qkryf5lBqoyw4ViAwdas=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qMJNc3ggIgSTtivM/VQGoBlUKanWt+y3otX2f/FbG6Vx839/D/GcS5nSZh4f0hTniBFw8FAzs0qnwhMmsDcQOUN7sH1qKP/WndVtA6GkcD9VSk1+cZsSxzt5OaBDP34Waib2aoN8Vvhjnx8pUvvkDoBvJ/TJJZGGYmrdHO7nZ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TRMV93hsYz6J9h8;
	Sat,  3 Feb 2024 01:00:49 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 69A141400CD;
	Sat,  3 Feb 2024 01:04:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 2 Feb
 2024 17:04:14 +0000
Date: Fri, 2 Feb 2024 17:04:13 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
CC: <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, <acpica-devel@lists.linuxfoundation.org>,
	<linux-csky@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-ia64@vger.kernel.org>, <linux-parisc@vger.kernel.org>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	<jianyong.wu@arm.com>, <justin.he@arm.com>, James Morse
	<james.morse@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RFC v4 14/15] arm64: document virtual CPU hotplug's
 expectations
Message-ID: <20240202170413.0000154e@Huawei.com>
In-Reply-To: <E1rVDnU-0027Zf-GF@rmk-PC.armlinux.org.uk>
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
	<E1rVDnU-0027Zf-GF@rmk-PC.armlinux.org.uk>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 31 Jan 2024 16:50:48 +0000
Russell King (Oracle) <rmk+kernel@armlinux.org.uk> wrote:

> From: James Morse <james.morse@arm.com>
> 
> Add a description of physical and virtual CPU hotplug, explain the
> differences and elaborate on what is required in ACPI for a working
> virtual hotplug system.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Outstanding comment:
>  https://lore.kernel.org/r/20230914174137.00000a62@Huawei.com

Outstanding but an ACPI Spec question rather than one about this description.
I've finally regained access to Mantis etc so can follow that up at some point.

If we get clarify on how to tell that CPUs that are present and enabled at boot
can be removed later we can relax this text to allow for that.


>  https://lore.kernel.org/r/20231215170428.00000d81@Huawei.com
That's a comment on the above comment to say I'm fine with it as is :)

This @Huawei guy is really annoying ;)

Jonathan

> ---
>  Documentation/arch/arm64/cpu-hotplug.rst | 79 ++++++++++++++++++++++++
>  Documentation/arch/arm64/index.rst       |  1 +
>  2 files changed, 80 insertions(+)
>  create mode 100644 Documentation/arch/arm64/cpu-hotplug.rst
> 
> diff --git a/Documentation/arch/arm64/cpu-hotplug.rst b/Documentation/arch/arm64/cpu-hotplug.rst
> new file mode 100644
> index 000000000000..76ba8d932c72
> --- /dev/null
> +++ b/Documentation/arch/arm64/cpu-hotplug.rst
> @@ -0,0 +1,79 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. _cpuhp_index:
> +
> +====================
> +CPU Hotplug and ACPI
> +====================
> +
> +CPU hotplug in the arm64 world is commonly used to describe the kernel taking
> +CPUs online/offline using PSCI. This document is about ACPI firmware allowing
> +CPUs that were not available during boot to be added to the system later.
> +
> +``possible`` and ``present`` refer to the state of the CPU as seen by linux.
> +
> +
> +CPU Hotplug on physical systems - CPUs not present at boot
> +----------------------------------------------------------
> +
> +Physical systems need to mark a CPU that is ``possible`` but not ``present`` as
> +being ``present``. An example would be a dual socket machine, where the package
> +in one of the sockets can be replaced while the system is running.
> +
> +This is not supported.
> +
> +In the arm64 world CPUs are not a single device but a slice of the system.
> +There are no systems that support the physical addition (or removal) of CPUs
> +while the system is running, and ACPI is not able to sufficiently describe
> +them.
> +
> +e.g. New CPUs come with new caches, but the platform's cache toplogy is
> +described in a static table, the PPTT. How caches are shared between CPUs is
> +not discoverable, and must be described by firmware.
> +
> +e.g. The GIC redistributor for each CPU must be accessed by the driver during
> +boot to discover the system wide supported features. ACPI's MADT GICC
> +structures can describe a redistributor associated with a disabled CPU, but
> +can't describe whether the redistributor is accessible, only that it is not
> +'always on'.
> +
> +arm64's ACPI tables assume that everything described is ``present``.
> +
> +
> +CPU Hotplug on virtual systems - CPUs not enabled at boot
> +---------------------------------------------------------
> +
> +Virtual systems have the advantage that all the properties the system will
> +ever have can be described at boot. There are no power-domain considerations
> +as such devices are emulated.
> +
> +CPU Hotplug on virtual systems is supported. It is distinct from physical
> +CPU Hotplug as all resources are described as ``present``, but CPUs may be
> +marked as disabled by firmware. Only the CPU's online/offline behaviour is
> +influenced by firmware. An example is where a virtual machine boots with a
> +single CPU, and additional CPUs are added once a cloud orchestrator deploys
> +the workload.
> +
> +For a virtual machine, the VMM (e.g. Qemu) plays the part of firmware.
> +
> +Virtual hotplug is implemented as a firmware policy affecting which CPUs can be
> +brought online. Firmware can enforce its policy via PSCI's return codes. e.g.
> +``DENIED``.
> +
> +The ACPI tables must describe all the resources of the virtual machine. CPUs
> +that firmware wishes to disable either from boot (or later) should not be
> +``enabled`` in the MADT GICC structures, but should have the ``online capable``
> +bit set, to indicate they can be enabled later. The boot CPU must be marked as
> +``enabled``.  The 'always on' GICR structure must be used to describe the
> +redistributors.
> +
> +CPUs described as ``online capable`` but not ``enabled`` can be set to enabled
> +by the DSDT's Processor object's _STA method. On virtual systems the _STA method
> +must always report the CPU as ``present``. Changes to the firmware policy can
> +be notified to the OS via device-check or eject-request.
> +
> +CPUs described as ``enabled`` in the static table, should not have their _STA
> +modified dynamically by firmware. Soft-restart features such as kexec will
> +re-read the static properties of the system from these static tables, and
> +may malfunction if these no longer describe the running system. Linux will
> +re-discover the dynamic properties of the system from the _STA method later
> +during boot.
> diff --git a/Documentation/arch/arm64/index.rst b/Documentation/arch/arm64/index.rst
> index d08e924204bf..78544de0a8a9 100644
> --- a/Documentation/arch/arm64/index.rst
> +++ b/Documentation/arch/arm64/index.rst
> @@ -13,6 +13,7 @@ ARM64 Architecture
>      asymmetric-32bit
>      booting
>      cpu-feature-registers
> +    cpu-hotplug
>      elf_hwcaps
>      hugetlbpage
>      kdump


