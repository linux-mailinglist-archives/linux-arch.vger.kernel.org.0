Return-Path: <linux-arch+bounces-1929-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A81E98444D5
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 17:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0781C222CD
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 16:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFFB12CD84;
	Wed, 31 Jan 2024 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="g9erK1mX"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155EB12BE99;
	Wed, 31 Jan 2024 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706719711; cv=none; b=Zi1cXh4hFHenAO2wbPmo+mPiz5QF1LLG/eELaDtLVHoocYXbpitZcbFwb4spptfgaNh+a45LPF0rfABFifDRasH7jiZkeNYKz0b5BCmysILwYoK+ui5XrJFzG141iY/ek2dKbjYTeNBi0J8ktbwGgXKKEwR/AN/ilRfuc8Ai9T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706719711; c=relaxed/simple;
	bh=uNN8q0C/RCH2Ib0D79HOp3bQt0zSZQn+swSUAZGookA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F9XBchx4AVhqC4RCc8lWRyuCjShw3Ha9KvoZNRorB5G6ew87/X5gQHkH7oOPDsgtFKkyvCFtWb6UPHkmXBr8Lk+UJSJU+i7aaocxTDHYc5fU7erwhAaQD27/2TV+9STiPKJ7DCEAWU2iVmpqc6LLWAzaCxaKGC0zT8nPHG+/cnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=g9erK1mX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NgiStwBwjTR8KjyFNomNmQXHEjzb/+iZU5gWUi3MWIw=; b=g9erK1mX3CRzgEzwVpJaiR8b5n
	tRbYHAHpbphSRqkayfYmOCUH1gCx7XOaPZpRtXPV1Mz8Fn5VDNB9vB9bm9OG+i7kGTZFO6axn+X4H
	bcQejEIw2/RqiMzSPpRTqvNZDFqtA1XY7wLErEBQ+vVvetEZqs0PpWloxo7aZpoS1ntaKTUELYz0i
	H4AIu/ogdyp5wP8Iv4oQJebwhu9t3JOVsQqDDcBY0+jdFjQLWD6yvdSuoMVW/id5NsNP4ZsvYzhQE
	Yc0477BzXpcS3WBk9g/NhDDJeRZO3C9Tlksiw/x909/14cJtlSR5eMqfAyLezZvDYhKhh9vZiAy04
	3o+3JLdg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44550)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rVDkz-0003TG-2r;
	Wed, 31 Jan 2024 16:48:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rVDkt-0006Zn-Mo; Wed, 31 Jan 2024 16:48:07 +0000
Date: Wed, 31 Jan 2024 16:48:07 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, acpica-devel@lists.linuxfoundation.org,
	linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com,
	James Morse <james.morse@arm.com>
Subject: [RFC PATCH v4 00/15] ACPI/arm64: add support for virtual cpu hotplug
Message-ID: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

This is another iteration of the Arm64 virtual CPU hotplug support,
updated for the review comments on the v3 smaller series posted back
in December.

I believe all feedback has been addressed - if I have missed something
then please accept my apologies. Several patches have been dropped from
the original series, including patches 2 and 3, the ACPICA patch adding
the new GICC bits (now merged), the patch to rename ACPI_HOTPLUG_CPU
and the _OSC bits. The arch_unregister_cpu() fix has been merged into
its appropriate commit.

One change that has not been addressed yet is that it is likely that
"ACPI: add support to (un)register CPUs based on the _STA enabled bit"
needs to do more cleanup than it is doing when unregistering the CPU -
much of acpi_processor_make_not_present() probably needs to be done to
properly clean up - hence why this is still RFC for now.

It is hoped that we have reached agreement with the remainder of the
patches, and we are getting close to having something that can be
merged once the above is addressed.

This is from my aarch64/hotplug-vcpu/head branch, minus the top two
commits, and is based on v6.8-rc2.

 Documentation/ABI/testing/sysfs-devices-system-cpu |   6 +
 Documentation/arch/arm64/cpu-hotplug.rst           |  79 ++++++++++
 Documentation/arch/arm64/index.rst                 |   1 +
 arch/arm64/include/asm/acpi.h                      |  11 ++
 arch/arm64/kernel/acpi_numa.c                      |  11 --
 arch/arm64/kernel/psci.c                           |   2 +-
 arch/arm64/kernel/smp.c                            |   3 +-
 drivers/acpi/acpi_processor.c                      |  99 +++++++++++--
 drivers/acpi/device_pm.c                           |   2 +-
 drivers/acpi/device_sysfs.c                        |   2 +-
 drivers/acpi/internal.h                            |   4 +-
 drivers/acpi/property.c                            |   2 +-
 drivers/acpi/scan.c                                | 162 ++++++++++++++-------
 drivers/base/cpu.c                                 |  16 +-
 drivers/irqchip/irq-gic-v3.c                       |  32 ++--
 include/acpi/acpi_bus.h                            |   1 +
 include/linux/acpi.h                               |   5 +-
 include/linux/cpumask.h                            |  25 ++++
 kernel/cpu.c                                       |   3 +
 19 files changed, 370 insertions(+), 96 deletions(-)
 create mode 100644 Documentation/arch/arm64/cpu-hotplug.rst

On Wed, Dec 13, 2023 at 12:47:31PM +0000, Russell King (Oracle) wrote:
> Hi,
> 
> This is this remaining patches for ARM64 virtual cpu hotplug, which
> follows on from the previous set of 21 patches that GregKH has
> recently queued up, and "x86: intel_epb: Don't rely on link order"
> which can be found at:
> 
> https://lore.kernel.org/r/E1r6SeD-00DCuK-M6@rmk-PC.armlinux.org.uk
> https://lore.kernel.org/r/ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk
> 
> The entire series can be found at:
> 
>  git://git.armlinux.org.uk/~rmk/linux-arm.git aarch64/hotplug-vcpu/head
> 
> The original cover message from the entire series is below the
> diffstat.
> 
>  Documentation/arch/arm64/cpu-hotplug.rst   |  79 ++++++++++++++++
>  Documentation/arch/arm64/index.rst         |   1 +
>  arch/arm64/include/asm/acpi.h              |  11 +++
>  arch/arm64/kernel/acpi_numa.c              |  11 ---
>  arch/arm64/kernel/psci.c                   |   2 +-
>  arch/arm64/kernel/smp.c                    |   3 +-
>  arch/loongarch/Kconfig                     |   2 +-
>  arch/loongarch/configs/loongson3_defconfig |   2 +-
>  arch/loongarch/kernel/acpi.c               |   4 +-
>  arch/x86/Kconfig                           |   3 +-
>  arch/x86/kernel/acpi/boot.c                |   4 +-
>  drivers/acpi/Kconfig                       |  13 ++-
>  drivers/acpi/acpi_processor.c              | 141 ++++++++++++++++++++++++++---
>  drivers/acpi/bus.c                         |  16 ++++
>  drivers/acpi/device_pm.c                   |   2 +-
>  drivers/acpi/device_sysfs.c                |   2 +-
>  drivers/acpi/internal.h                    |   1 -
>  drivers/acpi/property.c                    |   2 +-
>  drivers/acpi/scan.c                        | 140 ++++++++++++++++++----------
>  drivers/base/cpu.c                         |  16 +++-
>  drivers/irqchip/irq-gic-v3.c               |  32 ++++---
>  include/acpi/acpi_bus.h                    |   1 +
>  include/acpi/actbl2.h                      |   1 +
>  include/linux/acpi.h                       |  10 +-
>  include/linux/cpumask.h                    |  25 +++++
>  kernel/cpu.c                               |   3 +
>  26 files changed, 421 insertions(+), 106 deletions(-)
> 
> On Tue, Oct 24, 2023 at 04:15:28PM +0100, Russell King (Oracle) wrote:
> > Hi,
> > 
> > I'm posting James' patch set updated with most of the review comments
> > from his RFC v2 series back in September. Individual patches have a
> > changelog attached at the bottom of the commit message. Those which
> > I have finished updating have my S-o-b on them, those which still have
> > outstanding review comments from RFC v2 do not. In some of these cases
> > I've asked questions and am waiting for responses.
> > 
> > I'm posting this as RFC v3 because there's still some unaddressed
> > comments and it's clearly not ready for merging. Even if it was ready
> > to be merged, it is too late in this development cycle to be taking
> > this change in, so there would be little point posting it non-RFC.
> > Also James stated that he's waiting for confirmation from the
> > Kubernetes/Kata folk - I have no idea what the status is there.
> > 
> > I will be sending each patch individually to a wider audience
> > appropriate for that patch - apologies to those missing out on this
> > cover message. I have added more mailing lists to the series with the
> > exception of the acpica list in a hope of this cover message also
> > reaching those folk.
> > 
> > The changes that aren't included are:
> > 
> > 1. Updates for my patch that was merged via Thomas (thanks!):
> >    c4dd854f740c cpu-hotplug: Provide prototypes for arch CPU registration
> >    rather than having this change spread through James' patches.
> > 
> > 2. New patch - simplification of PA-RISC's smp_prepare_boot_cpu()
> > 
> > 3. Moved "ACPI: Use the acpi_device_is_present() helper in more places"
> >    and "ACPI: Rename acpi_scan_device_not_present() to be about
> >    enumeration" to the beginning of the series - these two patches are
> >    already queued up for merging into 6.7.
> > 
> > 4. Moved "arm64, irqchip/gic-v3, ACPI: Move MADT GICC enabled check into
> >    a helper" to the beginning of the series, which has been submitted,
> >    but as yet the fate of that posting isn't known.
> > 
> > The first four patches in this series are provided for completness only.
> > 
> > There is an additional patch in James' git tree that isn't in the set
> > of patches that James posted: "ACPI: processor: Only call
> > arch_unregister_cpu() if HOTPLUG_CPU is selected" which looks to me to
> > be a workaround for arch_unregister_cpu() being under the ifdef. I've
> > commented on this on the RFC v2 posting making a suggestion, but as yet
> > haven't had any response.
> > 
> > I've included almost all of James' original covering body below the
> > diffstat.
> > 
> > The reason that I'm doing this is to help move this code forward so
> > hopefully it can be merged - which is why I have been keen to dig out
> > from James' patches anything that can be merged and submit it
> > separately, since this is a feature for which some users have a
> > definite need for.
> > 
> > Please note that I haven't tested this beyond building for aarch64 at
> > the present time.
> > 
> > The series can be found at:
> > 
> >  git://git.armlinux.org.uk/~rmk/linux-arm.git aarch64/hotplug-vcpu/v6.6-rc7
> > 
> >  Documentation/arch/arm64/cpu-hotplug.rst   |  79 +++++++++++++++
> >  Documentation/arch/arm64/index.rst         |   1 +
> >  arch/arm64/Kconfig                         |   1 +
> >  arch/arm64/include/asm/acpi.h              |  11 +++
> >  arch/arm64/include/asm/cpu.h               |   1 -
> >  arch/arm64/kernel/acpi_numa.c              |  11 ---
> >  arch/arm64/kernel/psci.c                   |   2 +-
> >  arch/arm64/kernel/setup.c                  |  13 +--
> >  arch/arm64/kernel/smp.c                    |   5 +-
> >  arch/ia64/Kconfig                          |   3 +
> >  arch/ia64/include/asm/acpi.h               |   2 +-
> >  arch/ia64/include/asm/cpu.h                |   6 --
> >  arch/ia64/kernel/acpi.c                    |   6 +-
> >  arch/ia64/kernel/setup.c                   |   2 +-
> >  arch/ia64/kernel/topology.c                |  35 +------
> >  arch/loongarch/Kconfig                     |   2 +
> >  arch/loongarch/configs/loongson3_defconfig |   2 +-
> >  arch/loongarch/kernel/acpi.c               |   4 +-
> >  arch/loongarch/kernel/topology.c           |  38 +-------
> >  arch/parisc/kernel/smp.c                   |   8 +-
> >  arch/riscv/Kconfig                         |   1 +
> >  arch/riscv/kernel/setup.c                  |  19 +---
> >  arch/x86/Kconfig                           |   3 +
> >  arch/x86/include/asm/cpu.h                 |   4 -
> >  arch/x86/kernel/acpi/boot.c                |   4 +-
> >  arch/x86/kernel/cpu/intel_epb.c            |   2 +-
> >  arch/x86/kernel/topology.c                 |  27 +-----
> >  drivers/acpi/Kconfig                       |  14 ++-
> >  drivers/acpi/acpi_processor.c              | 151 +++++++++++++++++++++++------
> >  drivers/acpi/bus.c                         |  16 +++
> >  drivers/acpi/device_pm.c                   |   2 +-
> >  drivers/acpi/device_sysfs.c                |   2 +-
> >  drivers/acpi/internal.h                    |   1 -
> >  drivers/acpi/processor_core.c              |   2 +-
> >  drivers/acpi/property.c                    |   2 +-
> >  drivers/acpi/scan.c                        | 148 ++++++++++++++++++----------
> >  drivers/base/arch_topology.c               |  38 +++++---
> >  drivers/base/cpu.c                         |  44 +++++++--
> >  drivers/base/init.c                        |   2 +-
> >  drivers/base/node.c                        |   7 --
> >  drivers/firmware/psci/psci.c               |   2 +
> >  drivers/irqchip/irq-gic-v3.c               |  38 +++++---
> >  include/acpi/acpi_bus.h                    |   1 +
> >  include/acpi/actbl2.h                      |   1 +
> >  include/linux/acpi.h                       |  13 ++-
> >  include/linux/cpu.h                        |   4 +
> >  include/linux/cpumask.h                    |  25 +++++
> >  kernel/cpu.c                               |   3 +
> >  48 files changed, 516 insertions(+), 292 deletions(-)
> > 
> > 
> > On Wed, Sep 13, 2023 at 04:37:48PM +0000, James Morse wrote:
> > > Hello!
> > > 
> > > Changes since RFC-v1:
> > >  * riscv is new, ia64 is gone
> > >  * The KVM support is different, and upstream - no need to patch the host.
> > > 
> > > ---
> > > 
> > > This series adds what looks like cpuhotplug support to arm64 for use in
> > > virtual machines. It does this by moving the cpu_register() calls for
> > > architectures that support ACPI out of the arch code by using
> > > GENERIC_CPU_DEVICES, then into the ACPI processor driver.
> > > 
> > > The kubernetes folk really want to be able to add CPUs to an existing VM,
> > > in exactly the same way they do on x86. The use-case is pre-booting guests
> > > with one CPU, then adding the number that were actually needed when the
> > > workload is provisioned.
> > > 
> > > Wait? Doesn't arm64 support cpuhotplug already!?
> > > In the arm world, cpuhotplug gets used to mean removing the power from a CPU.
> > > The CPU is offline, and remains present. For x86, and ACPI, cpuhotplug
> > > has the additional step of physically removing the CPU, so that it isn't
> > > present anymore.
> > > 
> > > Arm64 doesn't support this, and can't support it: CPUs are really a slice
> > > of the SoC, and there is not enough information in the existing ACPI tables
> > > to describe which bits of the slice also got removed. Without a reference
> > > machine: adding this support to the spec is a wild goose chase.
> > > 
> > > Critically: everything described in the firmware tables must remain present.
> > > 
> > > For a virtual machine this is easy as all the other bits of 'virtual SoC'
> > > are emulated, so they can (and do) remain present when a vCPU is 'removed'.
> > > 
> > > On a system that supports cpuhotplug the MADT has to describe every possible
> > > CPU at boot. Under KVM, the vGIC needs to know about every possible vCPU before
> > > the guest is started.
> > > With these constraints, virtual-cpuhotplug is really just a hypervisor/firmware
> > > policy about which CPUs can be brought online.
> > > 
> > > This series adds support for virtual-cpuhotplug as exactly that: firmware
> > > policy. This may even work on a physical machine too; for a guest the part of
> > > firmware is played by the VMM. (typically Qemu).
> > > 
> > > PSCI support is modified to return 'DENIED' if the CPU can't be brought
> > > online/enabled yet. The CPU object's _STA method's enabled bit is used to
> > > indicate firmware's current disposition. If the CPU has its enabled bit clear,
> > > it will not be registered with sysfs, and attempts to bring it online will
> > > fail. The notifications that _STA has changed its value then work in the same
> > > way as physical hotplug, and firmware can cause the CPU to be registered some
> > > time later, allowing it to be brought online.
> > > 
> > > This creates something that looks like cpuhotplug to user-space, as the sysfs
> > > files appear and disappear, and the udev notifications look the same.
> > > 
> > > One notable difference is the CPU present mask, which is exposed via sysfs.
> > > Because the CPUs remain present throughout, they can still be seen in that mask.
> > > This value does get used by webbrowsers to estimate the number of CPUs
> > > as the CPU online mask is constantly changed on mobile phones.
> > > 
> > > Linux is tolerant of PSCI returning errors, as its always been allowed to do
> > > that. To avoid confusing OS that can't tolerate this, we needed an additional
> > > bit in the MADT GICC flags. This series copies ACPI_MADT_ONLINE_CAPABLE, which
> > > appears to be for this purpose, but calls it ACPI_MADT_GICC_CPU_CAPABLE as it
> > > has a different bit position in the GICC.
> > > 
> > > This code is unconditionally enabled for all ACPI architectures.
> > > If there are problems with firmware tables on some devices, the CPUs will
> > > already be online by the time the acpi_processor_make_enabled() is called.
> > > A mismatch here causes a firmware-bug message and kernel taint. This should
> > > only affect people with broken firmware who also boot with maxcpus=1, and
> > > bring CPUs online later.
> > > 
> > > I had a go at switching the remaining architectures over to GENERIC_CPU_DEVICES,
> > > so that the Kconfig symbol can be removed, but I got stuck with powerpc
> > > and s390.
> > > 
> > > I've only build tested Loongarch and riscv. I've removed the ia64 specific
> > > patches, but left the changes in other patches to make git-grep review of
> > > renames easier.
> > > 
> > > If folk want to play along at home, you'll need a copy of Qemu that supports this.
> > > https://github.com/salil-mehta/qemu.git salil/virt-cpuhp-armv8/rfc-v2-rc6
> > > 
> > > Replace your '-smp' argument with something like:
> > > | -smp cpus=1,maxcpus=3,cores=3,threads=1,sockets=1
> > > 
> > > then feed the following to the Qemu montior;
> > > | (qemu) device_add driver=host-arm-cpu,core-id=1,id=cpu1
> > > | (qemu) device_del cpu1
> > > 
> > > 
> > > Why is this still an RFC? I'm still looking for confirmation from the
> > > kubernetes/kata folk that this works for them. Because of this I've culled
> > > the CC list...
> > > 
> > > 
> > > This series is based on v6.6-rc1, and can be retrieved from:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/ virtual_cpu_hotplug/rfc/v2
> > > 
> > > 
> > > Thanks,
> > > 
> > > James Morse (34):
> > >   ACPI: Move ACPI_HOTPLUG_CPU to be disabled on arm64 and riscv
> > >   drivers: base: Use present CPUs in GENERIC_CPU_DEVICES
> > >   drivers: base: Allow parts of GENERIC_CPU_DEVICES to be overridden
> > >   drivers: base: Move cpu_dev_init() after node_dev_init()
> > >   drivers: base: Print a warning instead of panic() when register_cpu()
> > >     fails
> > >   arm64: setup: Switch over to GENERIC_CPU_DEVICES using
> > >     arch_register_cpu()
> > >   x86: intel_epb: Don't rely on link order
> > >   x86/topology: Switch over to GENERIC_CPU_DEVICES
> > >   LoongArch: Switch over to GENERIC_CPU_DEVICES
> > >   riscv: Switch over to GENERIC_CPU_DEVICES
> > >   arch_topology: Make register_cpu_capacity_sysctl() tolerant to late
> > >     CPUs
> > >   ACPI: Use the acpi_device_is_present() helper in more places
> > >   ACPI: Rename acpi_scan_device_not_present() to be about enumeration
> > >   ACPI: Only enumerate enabled (or functional) devices
> > >   ACPI: processor: Add support for processors described as container
> > >     packages
> > >   ACPI: processor: Register CPUs that are online, but not described in
> > >     the DSDT
> > >   ACPI: processor: Register all CPUs from acpi_processor_get_info()
> > >   ACPI: Rename ACPI_HOTPLUG_CPU to include 'present'
> > >   ACPI: Move acpi_bus_trim_one() before acpi_scan_hot_remove()
> > >   ACPI: Rename acpi_processor_hotadd_init and remove pre-processor
> > >     guards
> > >   ACPI: Add post_eject to struct acpi_scan_handler for cpu hotplug
> > >   ACPI: Check _STA present bit before making CPUs not present
> > >   ACPI: Warn when the present bit changes but the feature is not enabled
> > >   drivers: base: Implement weak arch_unregister_cpu()
> > >   LoongArch: Use the __weak version of arch_unregister_cpu()
> > >   arm64: acpi: Move get_cpu_for_acpi_id() to a header
> > >   ACPICA: Add new MADT GICC flags fields [code first?]
> > >   arm64, irqchip/gic-v3, ACPI: Move MADT GICC enabled check into a
> > >     helper
> > >   irqchip/gic-v3: Don't return errors from gic_acpi_match_gicc()
> > >   irqchip/gic-v3: Add support for ACPI's disabled but 'online capable'
> > >     CPUs
> > >   ACPI: add support to register CPUs based on the _STA enabled bit
> > >   arm64: document virtual CPU hotplug's expectations
> > >   ACPI: Add _OSC bits to advertise OS support for toggling CPU
> > >     present/enabled
> > >   cpumask: Add enabled cpumask for present CPUs that can be brought
> > >     online
> > > 
> > > Jean-Philippe Brucker (1):
> > >   arm64: psci: Ignore DENIED CPUs
> > 
> > -- 
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> > 
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

