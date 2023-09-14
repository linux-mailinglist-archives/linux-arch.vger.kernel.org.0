Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0107A0AF3
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 18:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjINQlq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 12:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjINQlp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 12:41:45 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486AD1FD7;
        Thu, 14 Sep 2023 09:41:41 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RmjkP6LwKz6K5xM;
        Fri, 15 Sep 2023 00:41:01 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 14 Sep
 2023 17:41:38 +0100
Date:   Thu, 14 Sep 2023 17:41:37 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     James Morse <james.morse@arm.com>
CC:     <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
        <linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        <x86@kernel.org>, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <jianyong.wu@arm.com>, <justin.he@arm.com>
Subject: Re: [RFC PATCH v2 33/35] arm64: document virtual CPU hotplug's
 expectations
Message-ID: <20230914174137.00000a62@Huawei.com>
In-Reply-To: <20230913163823.7880-34-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
        <20230913163823.7880-34-james.morse@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 13 Sep 2023 16:38:21 +0000
James Morse <james.morse@arm.com> wrote:

> Add a description of physical and virtual CPU hotplug, explain the
> differences and elaborate on what is required in ACPI for a working
> virtual hotplug system.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
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

Hi James,

I guess you know I'm going to comment on this given I got a bit fixated on it
at the Linaro Open Discussions call the other day.

This is the corner case that I think needs discussion. So far there is nothing
the ACPI spec that says anything about unplugability of CPUs so I see this as a
Linux implementation choice and I think it may be a problem for the cloud tennant
scalability usecases.  The problem is legacy operating systems. Some of whom may have
a different interpretation of the ACPI Spec unless we make sure it addresses this.

At time of VM startup, I want to provide a flexible number of CPUs say, 1 to 64 -
but the customer paid for 4 currently so I want to start them off with 4. 
To make this model work I have to know if they are running a hotplug capable OS
and, even if the current OSC ACPI code first proposal goes forwards, I either have to
ask customers to tell me they support it, or boot to find out (relying on OSC handshake
late in boot).

Code first proposal mentioned:
https://bugzilla.tianocore.org/show_bug.cgi?id=4481

If the guest doesn't support CPU hotplug I need to set enabled for the 4 CPUs. Once
booted I can use that OSC to discover if they can ever take advantage of hotplug
CPUs (arguably we could tweak that definition or add another to say they are fine
with me removing them as well).

If they do support CPU hotplug maximum flexiblity suggests I set enabled for CPU 0
and online capable for the next 3 and rely on the OS optimistically poking the
oneline capable ones to see if they are there at boot.

Of course one option is stick with what you have here and treat it as customer
lock-in they can only get bigger, not smaller.  Might be acceptable as might
the horrible approach of trying to hot unplug a CPU and getting no reply
(not a good user experience)

I probably haven't described that well.

Jonathan


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

