Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0ABE79EE66
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 18:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjIMQiq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 12:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIMQip (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 12:38:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BD5019B1;
        Wed, 13 Sep 2023 09:38:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 042891FB;
        Wed, 13 Sep 2023 09:39:18 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8CB83F7C5;
        Wed, 13 Sep 2023 09:38:38 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: [RFC PATCH v2 00/35] ACPI/arm64: add support for virtual cpuhotplug
Date:   Wed, 13 Sep 2023 16:37:48 +0000
Message-Id: <20230913163823.7880-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello!

Changes since RFC-v1:
 * riscv is new, ia64 is gone
 * The KVM support is different, and upstream - no need to patch the host.

---

This series adds what looks like cpuhotplug support to arm64 for use in
virtual machines. It does this by moving the cpu_register() calls for
architectures that support ACPI out of the arch code by using
GENERIC_CPU_DEVICES, then into the ACPI processor driver.

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

This code is unconditionally enabled for all ACPI architectures.
If there are problems with firmware tables on some devices, the CPUs will
already be online by the time the acpi_processor_make_enabled() is called.
A mismatch here causes a firmware-bug message and kernel taint. This should
only affect people with broken firmware who also boot with maxcpus=1, and
bring CPUs online later.

I had a go at switching the remaining architectures over to GENERIC_CPU_DEVICES,
so that the Kconfig symbol can be removed, but I got stuck with powerpc
and s390.

I've only build tested Loongarch and riscv. I've removed the ia64 specific
patches, but left the changes in other patches to make git-grep review of
renames easier.

If folk want to play along at home, you'll need a copy of Qemu that supports this.
https://github.com/salil-mehta/qemu.git salil/virt-cpuhp-armv8/rfc-v2-rc6

Replace your '-smp' argument with something like:
| -smp cpus=1,maxcpus=3,cores=3,threads=1,sockets=1

then feed the following to the Qemu montior;
| (qemu) device_add driver=host-arm-cpu,core-id=1,id=cpu1
| (qemu) device_del cpu1


Why is this still an RFC? I'm still looking for confirmation from the
kubernetes/kata folk that this works for them. Because of this I've culled
the CC list...


This series is based on v6.6-rc1, and can be retrieved from:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/ virtual_cpu_hotplug/rfc/v2


Thanks,

James Morse (34):
  ACPI: Move ACPI_HOTPLUG_CPU to be disabled on arm64 and riscv
  drivers: base: Use present CPUs in GENERIC_CPU_DEVICES
  drivers: base: Allow parts of GENERIC_CPU_DEVICES to be overridden
  drivers: base: Move cpu_dev_init() after node_dev_init()
  drivers: base: Print a warning instead of panic() when register_cpu()
    fails
  arm64: setup: Switch over to GENERIC_CPU_DEVICES using
    arch_register_cpu()
  x86: intel_epb: Don't rely on link order
  x86/topology: Switch over to GENERIC_CPU_DEVICES
  LoongArch: Switch over to GENERIC_CPU_DEVICES
  riscv: Switch over to GENERIC_CPU_DEVICES
  arch_topology: Make register_cpu_capacity_sysctl() tolerant to late
    CPUs
  ACPI: Use the acpi_device_is_present() helper in more places
  ACPI: Rename acpi_scan_device_not_present() to be about enumeration
  ACPI: Only enumerate enabled (or functional) devices
  ACPI: processor: Add support for processors described as container
    packages
  ACPI: processor: Register CPUs that are online, but not described in
    the DSDT
  ACPI: processor: Register all CPUs from acpi_processor_get_info()
  ACPI: Rename ACPI_HOTPLUG_CPU to include 'present'
  ACPI: Move acpi_bus_trim_one() before acpi_scan_hot_remove()
  ACPI: Rename acpi_processor_hotadd_init and remove pre-processor
    guards
  ACPI: Add post_eject to struct acpi_scan_handler for cpu hotplug
  ACPI: Check _STA present bit before making CPUs not present
  ACPI: Warn when the present bit changes but the feature is not enabled
  drivers: base: Implement weak arch_unregister_cpu()
  LoongArch: Use the __weak version of arch_unregister_cpu()
  arm64: acpi: Move get_cpu_for_acpi_id() to a header
  ACPICA: Add new MADT GICC flags fields [code first?]
  arm64, irqchip/gic-v3, ACPI: Move MADT GICC enabled check into a
    helper
  irqchip/gic-v3: Don't return errors from gic_acpi_match_gicc()
  irqchip/gic-v3: Add support for ACPI's disabled but 'online capable'
    CPUs
  ACPI: add support to register CPUs based on the _STA enabled bit
  arm64: document virtual CPU hotplug's expectations
  ACPI: Add _OSC bits to advertise OS support for toggling CPU
    present/enabled
  cpumask: Add enabled cpumask for present CPUs that can be brought
    online

Jean-Philippe Brucker (1):
  arm64: psci: Ignore DENIED CPUs

 Documentation/arch/arm64/cpu-hotplug.rst   |  79 ++++++++++
 Documentation/arch/arm64/index.rst         |   1 +
 arch/arm64/Kconfig                         |   1 +
 arch/arm64/include/asm/acpi.h              |  11 ++
 arch/arm64/include/asm/cpu.h               |   1 -
 arch/arm64/kernel/acpi_numa.c              |  11 --
 arch/arm64/kernel/psci.c                   |   2 +-
 arch/arm64/kernel/setup.c                  |  13 +-
 arch/arm64/kernel/smp.c                    |   5 +-
 arch/ia64/Kconfig                          |   2 +
 arch/ia64/include/asm/acpi.h               |   2 +-
 arch/ia64/include/asm/cpu.h                |   5 -
 arch/ia64/kernel/acpi.c                    |   6 +-
 arch/ia64/kernel/setup.c                   |   2 +-
 arch/ia64/kernel/topology.c                |   2 +-
 arch/loongarch/Kconfig                     |   2 +
 arch/loongarch/configs/loongson3_defconfig |   2 +-
 arch/loongarch/kernel/acpi.c               |   4 +-
 arch/loongarch/kernel/topology.c           |  38 +----
 arch/riscv/Kconfig                         |   1 +
 arch/riscv/kernel/setup.c                  |  19 +--
 arch/x86/Kconfig                           |   3 +
 arch/x86/include/asm/cpu.h                 |   6 -
 arch/x86/kernel/acpi/boot.c                |   4 +-
 arch/x86/kernel/cpu/intel_epb.c            |   2 +-
 arch/x86/kernel/topology.c                 |  25 +---
 drivers/acpi/Kconfig                       |  14 +-
 drivers/acpi/acpi_processor.c              | 160 ++++++++++++++++-----
 drivers/acpi/bus.c                         |  16 +++
 drivers/acpi/device_pm.c                   |   2 +-
 drivers/acpi/device_sysfs.c                |   2 +-
 drivers/acpi/internal.h                    |   1 -
 drivers/acpi/processor_core.c              |   2 +-
 drivers/acpi/property.c                    |   2 +-
 drivers/acpi/scan.c                        | 147 ++++++++++++-------
 drivers/base/arch_topology.c               |  38 +++--
 drivers/base/cpu.c                         |  40 ++++--
 drivers/base/init.c                        |   2 +-
 drivers/firmware/psci/psci.c               |   2 +
 drivers/irqchip/irq-gic-v3.c               |  38 ++---
 include/acpi/acpi_bus.h                    |   1 +
 include/acpi/actbl2.h                      |   1 +
 include/acpi/processor.h                   |   2 +-
 include/linux/acpi.h                       |  14 +-
 include/linux/cpu.h                        |   6 +
 include/linux/cpumask.h                    |  25 ++++
 kernel/cpu.c                               |   3 +
 47 files changed, 516 insertions(+), 251 deletions(-)
 create mode 100644 Documentation/arch/arm64/cpu-hotplug.rst

-- 
2.39.2

