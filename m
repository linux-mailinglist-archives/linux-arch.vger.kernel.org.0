Return-Path: <linux-arch+bounces-3789-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95D98A9BB4
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 15:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E489B23BA5
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 13:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3810B160790;
	Thu, 18 Apr 2024 13:54:20 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4702A1607B2;
	Thu, 18 Apr 2024 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448460; cv=none; b=tsllf4OmMVWAUP74NRlGsLIPqm+y0bluuyaDcGzggL6FOoXzSHzWfbH7XvW0+d3vZTeav+o7/fjcCSN+QtkQiNLnHTTML3Gi4KdMx2k/Pbm2968SXxmDJ53iLzbg/P9d+4nAPhUrNuCPU+/YZaKr4t3JAzF7Ry8oku6XF7T4gPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448460; c=relaxed/simple;
	bh=yXKPO/hvrdFwE0im3psB1dSWiai6UVdyh79F1t1raf4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u/sB7UvpO7d59wQye03KLNtn6POtQQghniYN+mgQaQ1W6WJN++6v0SEMQoRRxO2522xRVR+PKqr4iuFuc+ORqXPTXIE1AZM4qsBlL41/r0Noo+w8I/cwSBAtxp5qlHWNNixZksWzvduWIbAf/p4DYT2KUHxosj4CGZb9PKVpxkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKzjQ2WsNz6K5sZ;
	Thu, 18 Apr 2024 21:52:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9FF1D140119;
	Thu, 18 Apr 2024 21:54:13 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 14:54:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, James Morse
	<james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, <linuxarm@huawei.com>,
	<justin.he@arm.com>, <jianyong.wu@arm.com>
Subject: [PATCH v7 00/16] ACPI/arm64: add support for virtual cpu hotplug
Date: Thu, 18 Apr 2024 14:53:56 +0100
Message-ID: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Whilst it is a bit quick after v6, a couple of critical issues
were pointed out by Russell, Salil and Rafael + one build issue
had been missed, so it seems sensible to make sure those conducting
testing or further review have access to a fixed version.

v7:
  - Fix misplaced config guard that broke bisection.
  - Greatly simplify the condition on which we call
    acpi_processor_hotadd_init().
  - Improve teardown ordering.

Fundamental change v6+: At the level of common ACPI infrastructure, use
the existing hotplug path for arm64 even though what needs to be
done at the architecture specific level is quite different.

An explicit check in arch_register_cpu() for arm64 prevents
this code doing anything if Physical CPU Hotplug is signalled.

This should resolve any concerns about treating virtual CPU
hotplug as if it were physical and potential unwanted side effects
if physical CPU hotplug is added to the ARM architecture in the
future.

v6: Thanks to Rafael for extensive help with the approach + reviews.
Specific changes:
 - Do not differentiate wrt code flow between traditional CPU HP
   and the new ARM flow.  The conditions on performing hotplug actions
   do need to be adjusted though to incorporate the slightly different
   state transition
     Added PRESENT + !ENABLED -> PRESENT + ENABLED
     to existing !PRESENT + !ENABLED -> PRESENT + ENABLED
 - Enable ACPI_HOTPLUG_CPU on arm64 and drop the earlier patches that
   took various code out of the protection of that.  Now the paths
 - New patch to drop unnecessary _STA check in hotplug code. This
   code cannot be entered unless ENABLED + PRESENT are set.
 - New patch to unify the flow of already onlined (at time of driver
   load) and hotplugged CPUs in acpi/processor_driver.c.
   This change is necessary because we can't easily distinguish the
   2 cases of deferred vs hotplug calls of register_cpu() on arm64.
   It is also a nice simplification.
 - Use flags rather than a structure for the extra parameter to
   acpi_scan_check_and_detach() - Thank to Shameer for offline feedback.

Updated version of James' original introduction.

This series adds what looks like cpuhotplug support to arm64 for use in
virtual machines. It does this by moving the cpu_register() calls for
architectures that support ACPI into an arch specific call made from
the ACPI processor driver.
 
The kubernetes folk really want to be able to add CPUs to an existing VM,
in exactly the same way they do on x86. The use-case is pre-booting guests
with one CPU, then adding the number that were actually needed when the
workload is provisioned.

Wait? Doesn't arm64 support cpuhotplug already!?
In the arm world, cpuhotplug gets used to mean removing the power from a CPU.
The CPU is offline, and remains present. For x86, and ACPI, cpuhotplug
has the additional step of physically removing the CPU, so that it isn't
present anymore.
 
Arm64 doesn't support this, and can't support it: CPUs are really a slice
of the SoC, and there is not enough information in the existing ACPI tables
to describe which bits of the slice also got removed. Without a reference
machine: adding this support to the spec is a wild goose chase.
 
Critically: everything described in the firmware tables must remain present.
 
For a virtual machine this is easy as all the other bits of 'virtual SoC'
are emulated, so they can (and do) remain present when a vCPU is 'removed'.

On a system that supports cpuhotplug the MADT has to describe every possible
CPU at boot. Under KVM, the vGIC needs to know about every possible vCPU before
the guest is started.
With these constraints, virtual-cpuhotplug is really just a hypervisor/firmware
policy about which CPUs can be brought online.
 
This series adds support for virtual-cpuhotplug as exactly that: firmware
policy. This may even work on a physical machine too; for a guest the part of
firmware is played by the VMM. (typically Qemu).
 
PSCI support is modified to return 'DENIED' if the CPU can't be brought
online/enabled yet. The CPU object's _STA method's enabled bit is used to
indicate firmware's current disposition. If the CPU has its enabled bit clear,
it will not be registered with sysfs, and attempts to bring it online will
fail. The notifications that _STA has changed its value then work in the same
way as physical hotplug, and firmware can cause the CPU to be registered some
time later, allowing it to be brought online.
 
This creates something that looks like cpuhotplug to user-space and the
kernel beyond arm64 architecture specific code, as the sysfs
files appear and disappear, and the udev notifications look the same.
 
One notable difference is the CPU present mask, which is exposed via sysfs.
Because the CPUs remain present throughout, they can still be seen in that mask.
This value does get used by webbrowsers to estimate the number of CPUs
as the CPU online mask is constantly changed on mobile phones.
 
Linux is tolerant of PSCI returning errors, as its always been allowed to do
that. To avoid confusing OS that can't tolerate this, we needed an additional
bit in the MADT GICC flags. This series copies ACPI_MADT_ONLINE_CAPABLE, which
appears to be for this purpose, but calls it ACPI_MADT_GICC_CPU_CAPABLE as it
has a different bit position in the GICC.
 
This code is unconditionally enabled for all ACPI architectures, though for
now only arm64 will have deferred the cpu_register() calls.

If folk want to play along at home, you'll need a copy of Qemu that supports this.
https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v2

Replace your '-smp' argument with something like:
 | -smp cpus=1,maxcpus=3,cores=3,threads=1,sockets=1
 
 then feed the following to the Qemu montior;
 | (qemu) device_add driver=host-arm-cpu,core-id=1,id=cpu1
 | (qemu) device_del cpu1

James Morse (7):
  ACPI: processor: Register deferred CPUs from acpi_processor_get_info()
  ACPI: Add post_eject to struct acpi_scan_handler for cpu hotplug
  arm64: acpi: Move get_cpu_for_acpi_id() to a header
  irqchip/gic-v3: Don't return errors from gic_acpi_match_gicc()
  irqchip/gic-v3: Add support for ACPI's disabled but 'online capable'
    CPUs
  arm64: document virtual CPU hotplug's expectations
  cpumask: Add enabled cpumask for present CPUs that can be brought
    online

Jean-Philippe Brucker (1):
  arm64: psci: Ignore DENIED CPUs

Jonathan Cameron (8):
  ACPI: processor: Simplify initial onlining to use same path for cold
    and hotplug
  cpu: Do not warn on arch_register_cpu() returning -EPROBE_DEFER
  ACPI: processor: Drop duplicated check on _STA (enabled + present)
  ACPI: processor: Move checks and availability of acpi_processor
    earlier
  ACPI: processor: Add acpi_get_processor_handle() helper
  ACPI: scan: switch to flags for acpi_scan_check_and_detach()
  arm64: arch_register_cpu() variant to check if an ACPI handle is now
    available.
  arm64: Kconfig: Enable hotplug CPU on arm64 if ACPI_PROCESSOR is
    enabled.

 .../ABI/testing/sysfs-devices-system-cpu      |   6 +
 Documentation/arch/arm64/cpu-hotplug.rst      |  79 ++++++++++++
 Documentation/arch/arm64/index.rst            |   1 +
 arch/arm64/Kconfig                            |   1 +
 arch/arm64/include/asm/acpi.h                 |  11 ++
 arch/arm64/kernel/acpi.c                      |  16 +++
 arch/arm64/kernel/acpi_numa.c                 |  11 --
 arch/arm64/kernel/psci.c                      |   2 +-
 arch/arm64/kernel/smp.c                       |  56 ++++++++-
 drivers/acpi/acpi_processor.c                 | 113 ++++++++++--------
 drivers/acpi/processor_driver.c               |  44 ++-----
 drivers/acpi/scan.c                           |  47 ++++++--
 drivers/base/cpu.c                            |  12 +-
 drivers/irqchip/irq-gic-v3.c                  |  32 +++--
 include/acpi/acpi_bus.h                       |   1 +
 include/acpi/processor.h                      |   2 +-
 include/linux/acpi.h                          |  10 +-
 include/linux/cpumask.h                       |  25 ++++
 kernel/cpu.c                                  |   3 +
 19 files changed, 357 insertions(+), 115 deletions(-)
 create mode 100644 Documentation/arch/arm64/cpu-hotplug.rst

-- 
2.39.2


