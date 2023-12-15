Return-Path: <linux-arch+bounces-1092-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7FB814DD3
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 18:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3674B231F5
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 17:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43E43EA9F;
	Fri, 15 Dec 2023 17:04:35 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6203EA82;
	Fri, 15 Dec 2023 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SsFsm2gd0z6JB0q;
	Sat, 16 Dec 2023 01:03:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B695140390;
	Sat, 16 Dec 2023 01:04:30 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Dec
 2023 17:04:29 +0000
Date: Fri, 15 Dec 2023 17:04:28 +0000
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
	<jianyong.wu@arm.com>, <justin.he@arm.com>, James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 19/21] arm64: document virtual CPU hotplug's
 expectations
Message-ID: <20231215170428.00000d81@Huawei.com>
In-Reply-To: <E1rDOhN-00DvlU-2e@rmk-PC.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
	<E1rDOhN-00DvlU-2e@rmk-PC.armlinux.org.uk>
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

On Wed, 13 Dec 2023 12:50:49 +0000
Russell King (Oracle) <rmk+kernel@armlinux.org.uk> wrote:

> From: James Morse <james.morse@arm.com>
> 
> Add a description of physical and virtual CPU hotplug, explain the
> differences and elaborate on what is required in ACPI for a working
> virtual hotplug system.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  Outstanding comment:
>   https://lore.kernel.org/r/20230914174137.00000a62@Huawei.com

Hmm. This one is the comment that if we allow for a legacy unware guest, we
have no way of indicating that CPUS that were enabled at boot can ever be removed.

Effectively that means that without the cloud being aware of the VM capabilities
before it is booted (and can maybe use the proposed OSC) there is no way of knowing
if a CPU can be removed.  Sounds profitable :)

I'm fine with that.  So as long a people grasp the concern and we make sure that
the QEMU side doesn't change it's legacy behavior (I think we are fine in Salil's
latest set).

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


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


