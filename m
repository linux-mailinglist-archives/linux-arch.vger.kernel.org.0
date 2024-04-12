Return-Path: <linux-arch+bounces-3621-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 027E88A30CB
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 16:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E4C1F22A8A
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 14:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF42D14199C;
	Fri, 12 Apr 2024 14:37:30 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398DD139D08;
	Fri, 12 Apr 2024 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932650; cv=none; b=IROwARMgcoLkx2jr/b6txEpyRaFPGNmeUxA/cSn8Gf12nZoMENUa586xKBL2iMZ+xjG1Y3xKcG0AZMmPJDCHzccu+0pSr1zSVJ6Ct4BR6mPHmfNrmRreGiTWhlaDMHgASJXrqp7JE8gUJlfkL1ZvC18/TWqVNGqH8vYXEI1lyTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932650; c=relaxed/simple;
	bh=5jQ/z0hIABqGfFs/vlElMc3UutE1y31PUUouiZIidY4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i6AzMRKE4IuSUKy+YfxvQrmgxoSuQ+PmhVoB//yXye5PdWjhSMxedyz05XfyPjs6Dv3dr+Y9vbQxKyeWGwNtkMyWaHCj8qfOutHAe4EiXRhkVfFhsu7JJSVSQjRy9nkFj9j/3eIriWVeTKGWGDbZPVLyA9Ztr4P7rfSwTwMjVDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VGJyC58Xwz6JB1y;
	Fri, 12 Apr 2024 22:35:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 750BB1408FE;
	Fri, 12 Apr 2024 22:37:17 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 15:37:16 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, <x86@kernel.org>, Russell King
	<linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>, Miguel
 Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
CC: <linuxarm@huawei.com>, <justin.he@arm.com>, <jianyong.wu@arm.com>
Subject: [PATCH v5 00/18] ACPI/arm64: add support for virtual cpu hotplug
Date: Fri, 12 Apr 2024 15:37:01 +0100
Message-ID: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

This patch set changes hands again in an attempt to set a new record for
most people who have worked on a single problem.

Miguel has been working on a rename and factoring out of arch
specific code patch set that will clash with this.
https://lore.kernel.org/linux-acpi/20240409150536.9933-1-miguel.luis@oracle.com/
[RFC PATCH 0/4] ACPI: processor: refactor acpi_processor_{get_info|remove}

v5 changes:
- Rebase on Rafael's rework of acpi_scan_check_and_detach() series that
  superceeded the original first patch.
  https://lore.kernel.org/linux-acpi/6021126.lOV4Wx5bFT@kreacher/
  That dealt with what I thought was the most controversial part of the
  series - checking the enabled bit ACPI _STA for CPUS.
- Change the overall handling so that arch_register_cpu() returns
  -EPROBE_DEFER if the particular architecture is not yet ready to
  answer the question of whether a particular CPU maybe used.
  This occurs for ARM64 + ACPI in 2 cases.
  1) At the initial callsite early in boot, before the AML interpreter
     is available and so the code can't query _STA.
  2) If _STA is queried but a particular CPU is present but not enabled.
     Those are the ones we are going to hotplug later.
  For all other architectures and ARM64 DT boots the this deferred
  flow is not used.
- Make the _make_enabled() and _make_not_enabled() flows more similar
  to the _make_present() and _make_not_present(). There are still
  sufficient differences that I don't think it makes sense to combine
  the code, but ensuring the locking and NUMA handling brings them
  closer together.  Note than an additional series will address the
  question of onlining and offlining the NUMA node as for now it
  will always be present (that series is not necessary for initial
  merge of this feature).

Dropped RFC because I think this is getting close to ready for merging
and now we are interested in normal review rather than calling out
significant remaining questions.

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
 
This creates something that looks like cpuhotplug to user-space, as the sysfs
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

If there are problems with firmware tables on some devices, the CPUs will
already be online by the time the acpi_processor_make_enabled() is called.
A mismatch here causes a firmware-bug message and kernel taint. This should
only affect people with broken firmware who also boot with maxcpus=1, and
bring CPUs online later.
 
If folk want to play along at home, you'll need a copy of Qemu that supports this.
https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v2

Replace your '-smp' argument with something like:
 | -smp cpus=1,maxcpus=3,cores=3,threads=1,sockets=1
 
 then feed the following to the Qemu montior;
 | (qemu) device_add driver=host-arm-cpu,core-id=1,id=cpu1
 | (qemu) device_del cpu1

James Morse (11):
  ACPI: processor: Register deferred CPUs from acpi_processor_get_info()
  ACPI: Rename acpi_processor_hotadd_init and  remove pre-processor
    guards
  ACPI: Add post_eject to struct acpi_scan_handler for cpu hotplug
  ACPI: Check _STA present bit before making CPUs not present
  ACPI: Warn when the present bit changes but the feature is not enabled
  arm64: acpi: Move get_cpu_for_acpi_id() to a header
  irqchip/gic-v3: Don't return errors from gic_acpi_match_gicc()
  irqchip/gic-v3: Add support for ACPI's disabled but 'online capable'
    CPUs
  ACPI: add support to (un)register CPUs based on the _STA enabled bit
  arm64: document virtual CPU hotplug's expectations
  cpumask: Add enabled cpumask for present CPUs that can be brought
    online

Jean-Philippe Brucker (1):
  arm64: psci: Ignore DENIED CPUs

Jonathan Cameron (5):
  cpu: Do not warn on arch_register_cpu() returning -EPROBE_DEFER
  ACPI: processor: Set the ACPI_COMPANION for the struct cpu instance
  ACPI: utils: Add an acpi_sta_enabled() helper and use it in
    acpi_processor_make_present()
  ACPI: scan: Add parameter to allow defering some actions in
    acpi_scan_check_and_detach.
  arm64: arch_register_cpu() variant to allow checking of ACPI _STA

Russell King (1):
  ACPI: convert acpi_processor_post_eject() to use IS_ENABLED()

 .../ABI/testing/sysfs-devices-system-cpu      |   6 +
 Documentation/arch/arm64/cpu-hotplug.rst      |  79 ++++++++++++
 Documentation/arch/arm64/index.rst            |   1 +
 arch/arm64/include/asm/acpi.h                 |  11 ++
 arch/arm64/kernel/acpi_numa.c                 |  11 --
 arch/arm64/kernel/psci.c                      |   2 +-
 arch/arm64/kernel/smp.c                       |  23 +++-
 drivers/acpi/acpi_processor.c                 | 112 +++++++++++++++---
 drivers/acpi/scan.c                           |  57 +++++++--
 drivers/acpi/utils.c                          |  21 ++++
 drivers/base/cpu.c                            |  12 +-
 drivers/irqchip/irq-gic-v3.c                  |  32 +++--
 include/acpi/acpi_bus.h                       |   2 +
 include/linux/acpi.h                          |   5 +-
 include/linux/cpumask.h                       |  25 ++++
 kernel/cpu.c                                  |   3 +
 16 files changed, 346 insertions(+), 56 deletions(-)
 create mode 100644 Documentation/arch/arm64/cpu-hotplug.rst

-- 
2.39.2


