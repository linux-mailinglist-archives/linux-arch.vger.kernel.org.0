Return-Path: <linux-arch+bounces-3813-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD2B8AA375
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 21:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C97B11F21C15
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 19:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBAD194C70;
	Thu, 18 Apr 2024 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vt402P44"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF19F18412C;
	Thu, 18 Apr 2024 19:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469813; cv=none; b=MPgv9YSiVnfVq7eMppNbLrOeXGrhdQ77JHS9RySX1cwPGS4DnF164/VDqZwaD6GUB8fLmoRRTG5hnK0ToR7qzXN3F8tF1plEPEgKc0R57QC7JZ/CuIXmBa7MDWcX42IDEzUcuizZpr4pL2F1snEwNvC1QXXnY27kqaL+qQecosA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469813; c=relaxed/simple;
	bh=+mg6oNFFFf0Lxegw9N1uQpSNvXxSJ8pm7AcHBnWA7CM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4GtVIabOxVy5UvOBVTtuCr3eDyKV3NIYrJUbBAa6ifuiDtSc7LPRH2/A4RXNQU76qg2mK6aGLqLUpVv2nl2v7gScIncV9cG6qP58riT1TI/edO7Gn1Qv9wvJXP9SQdAuq81g+WXAyST3kao9WhljvTKeWDNREMrrLmZI0pHPWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vt402P44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E83C32782;
	Thu, 18 Apr 2024 19:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713469812;
	bh=+mg6oNFFFf0Lxegw9N1uQpSNvXxSJ8pm7AcHBnWA7CM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Vt402P44+opHalVbIXev0jcbDjlk5tc4cdr/wvSRlYxVhw9fLY9lrDjL+CODAWAcx
	 Txh06SmYwF7dmpPVGvXhNgFBdVjT2DWDNNx7LDO5dgjZbT8weHaB7EvJNymR90aVEG
	 rF+6RfSXfFW/rOwSJQS55pTV+Z+sQJn1xBXMLVWiNounzu7S9FqMDiLDf0CFWGN2Da
	 uHeMWUoNEKYJJBLLbQjfr9OSG3/DrJs6VfO1AHi3je9vwz3SDkjQoyuw/RJxiGbN7M
	 BQsWT8WHUnEwR9nlqcy9EwTQ1MfJC5gpaZZsiCtRmYMA9Azb/A1FrfkOo6K979JqJD
	 c1vRAzoezEAwg==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5acdbfac113so36255eaf.3;
        Thu, 18 Apr 2024 12:50:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFqymBuUFubqhx+RUcPnGXqBQe3X/Y2OFUI+cGHeI1Yq9GsSX4VdG+dQ5tK5jhUP5XYiRoejyQLq6Vig2/JAC8xC+cSNkYRFMiVheOhinM3dfLP/5JziY7jvQ+usQMZ7WESjzC0M1Wvug6F8pAWnLS22C/pfG1kE4+cfRhR0oqIlGqyTZ4h0NQ+jzn5H0ZiSnoRmBzccoOdaqKsyNipA==
X-Gm-Message-State: AOJu0YzUYFNSmM9L46swOaBO3GAsZT6HpvfIdG89tzHWn46EGT6tlht1
	caVDLf1Bg73uC7MVlg98xjYxe295dWT/HHbaLBjMnGFrhM8utiTkfsfbT8dGI7SlMqgj/CZHIAl
	qIhIqgkjRZ1niDrLxoceeRSNho/s=
X-Google-Smtp-Source: AGHT+IG/s7EKmy2bO/y6jHP2vmvuXqsiEa+jtC+cHW9NDGnh6xeBUwc5PuTsUkwf2RmJd7g2myrEOEfTZBzH1D+lIYQ=
X-Received: by 2002:a05:6820:ecb:b0:5a4:7790:61b4 with SMTP id
 en11-20020a0568200ecb00b005a4779061b4mr283085oob.0.1713469811684; Thu, 18 Apr
 2024 12:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 18 Apr 2024 21:50:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0giKShCa7AaRRmhcfTshyjDKwn487-kqRr3pqVmYJ2BrA@mail.gmail.com>
Message-ID: <CAJZ5v0giKShCa7AaRRmhcfTshyjDKwn487-kqRr3pqVmYJ2BrA@mail.gmail.com>
Subject: Re: [PATCH v7 00/16] ACPI/arm64: add support for virtual cpu hotplug
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, 
	Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Miguel Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, 
	Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com, justin.he@arm.com, 
	jianyong.wu@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 3:54=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> Whilst it is a bit quick after v6, a couple of critical issues
> were pointed out by Russell, Salil and Rafael + one build issue
> had been missed, so it seems sensible to make sure those conducting
> testing or further review have access to a fixed version.
>
> v7:
>   - Fix misplaced config guard that broke bisection.
>   - Greatly simplify the condition on which we call
>     acpi_processor_hotadd_init().
>   - Improve teardown ordering.

Thank you for the update!

From a quick look, patches [01-08/16] appear to be good now, but I'll
do a more detailed review on the following days.

> Fundamental change v6+: At the level of common ACPI infrastructure, use
> the existing hotplug path for arm64 even though what needs to be
> done at the architecture specific level is quite different.
>
> An explicit check in arch_register_cpu() for arm64 prevents
> this code doing anything if Physical CPU Hotplug is signalled.
>
> This should resolve any concerns about treating virtual CPU
> hotplug as if it were physical and potential unwanted side effects
> if physical CPU hotplug is added to the ARM architecture in the
> future.
>
> v6: Thanks to Rafael for extensive help with the approach + reviews.
> Specific changes:
>  - Do not differentiate wrt code flow between traditional CPU HP
>    and the new ARM flow.  The conditions on performing hotplug actions
>    do need to be adjusted though to incorporate the slightly different
>    state transition
>      Added PRESENT + !ENABLED -> PRESENT + ENABLED
>      to existing !PRESENT + !ENABLED -> PRESENT + ENABLED
>  - Enable ACPI_HOTPLUG_CPU on arm64 and drop the earlier patches that
>    took various code out of the protection of that.  Now the paths
>  - New patch to drop unnecessary _STA check in hotplug code. This
>    code cannot be entered unless ENABLED + PRESENT are set.
>  - New patch to unify the flow of already onlined (at time of driver
>    load) and hotplugged CPUs in acpi/processor_driver.c.
>    This change is necessary because we can't easily distinguish the
>    2 cases of deferred vs hotplug calls of register_cpu() on arm64.
>    It is also a nice simplification.
>  - Use flags rather than a structure for the extra parameter to
>    acpi_scan_check_and_detach() - Thank to Shameer for offline feedback.
>
> Updated version of James' original introduction.
>
> This series adds what looks like cpuhotplug support to arm64 for use in
> virtual machines. It does this by moving the cpu_register() calls for
> architectures that support ACPI into an arch specific call made from
> the ACPI processor driver.
>
> The kubernetes folk really want to be able to add CPUs to an existing VM,
> in exactly the same way they do on x86. The use-case is pre-booting guest=
s
> with one CPU, then adding the number that were actually needed when the
> workload is provisioned.
>
> Wait? Doesn't arm64 support cpuhotplug already!?
> In the arm world, cpuhotplug gets used to mean removing the power from a =
CPU.
> The CPU is offline, and remains present. For x86, and ACPI, cpuhotplug
> has the additional step of physically removing the CPU, so that it isn't
> present anymore.
>
> Arm64 doesn't support this, and can't support it: CPUs are really a slice
> of the SoC, and there is not enough information in the existing ACPI tabl=
es
> to describe which bits of the slice also got removed. Without a reference
> machine: adding this support to the spec is a wild goose chase.
>
> Critically: everything described in the firmware tables must remain prese=
nt.
>
> For a virtual machine this is easy as all the other bits of 'virtual SoC'
> are emulated, so they can (and do) remain present when a vCPU is 'removed=
'.
>
> On a system that supports cpuhotplug the MADT has to describe every possi=
ble
> CPU at boot. Under KVM, the vGIC needs to know about every possible vCPU =
before
> the guest is started.
> With these constraints, virtual-cpuhotplug is really just a hypervisor/fi=
rmware
> policy about which CPUs can be brought online.
>
> This series adds support for virtual-cpuhotplug as exactly that: firmware
> policy. This may even work on a physical machine too; for a guest the par=
t of
> firmware is played by the VMM. (typically Qemu).
>
> PSCI support is modified to return 'DENIED' if the CPU can't be brought
> online/enabled yet. The CPU object's _STA method's enabled bit is used to
> indicate firmware's current disposition. If the CPU has its enabled bit c=
lear,
> it will not be registered with sysfs, and attempts to bring it online wil=
l
> fail. The notifications that _STA has changed its value then work in the =
same
> way as physical hotplug, and firmware can cause the CPU to be registered =
some
> time later, allowing it to be brought online.
>
> This creates something that looks like cpuhotplug to user-space and the
> kernel beyond arm64 architecture specific code, as the sysfs
> files appear and disappear, and the udev notifications look the same.
>
> One notable difference is the CPU present mask, which is exposed via sysf=
s.
> Because the CPUs remain present throughout, they can still be seen in tha=
t mask.
> This value does get used by webbrowsers to estimate the number of CPUs
> as the CPU online mask is constantly changed on mobile phones.
>
> Linux is tolerant of PSCI returning errors, as its always been allowed to=
 do
> that. To avoid confusing OS that can't tolerate this, we needed an additi=
onal
> bit in the MADT GICC flags. This series copies ACPI_MADT_ONLINE_CAPABLE, =
which
> appears to be for this purpose, but calls it ACPI_MADT_GICC_CPU_CAPABLE a=
s it
> has a different bit position in the GICC.
>
> This code is unconditionally enabled for all ACPI architectures, though f=
or
> now only arm64 will have deferred the cpu_register() calls.
>
> If folk want to play along at home, you'll need a copy of Qemu that suppo=
rts this.
> https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v2
>
> Replace your '-smp' argument with something like:
>  | -smp cpus=3D1,maxcpus=3D3,cores=3D3,threads=3D1,sockets=3D1
>
>  then feed the following to the Qemu montior;
>  | (qemu) device_add driver=3Dhost-arm-cpu,core-id=3D1,id=3Dcpu1
>  | (qemu) device_del cpu1
>
> James Morse (7):
>   ACPI: processor: Register deferred CPUs from acpi_processor_get_info()
>   ACPI: Add post_eject to struct acpi_scan_handler for cpu hotplug
>   arm64: acpi: Move get_cpu_for_acpi_id() to a header
>   irqchip/gic-v3: Don't return errors from gic_acpi_match_gicc()
>   irqchip/gic-v3: Add support for ACPI's disabled but 'online capable'
>     CPUs
>   arm64: document virtual CPU hotplug's expectations
>   cpumask: Add enabled cpumask for present CPUs that can be brought
>     online
>
> Jean-Philippe Brucker (1):
>   arm64: psci: Ignore DENIED CPUs
>
> Jonathan Cameron (8):
>   ACPI: processor: Simplify initial onlining to use same path for cold
>     and hotplug
>   cpu: Do not warn on arch_register_cpu() returning -EPROBE_DEFER
>   ACPI: processor: Drop duplicated check on _STA (enabled + present)
>   ACPI: processor: Move checks and availability of acpi_processor
>     earlier
>   ACPI: processor: Add acpi_get_processor_handle() helper
>   ACPI: scan: switch to flags for acpi_scan_check_and_detach()
>   arm64: arch_register_cpu() variant to check if an ACPI handle is now
>     available.
>   arm64: Kconfig: Enable hotplug CPU on arm64 if ACPI_PROCESSOR is
>     enabled.
>
>  .../ABI/testing/sysfs-devices-system-cpu      |   6 +
>  Documentation/arch/arm64/cpu-hotplug.rst      |  79 ++++++++++++
>  Documentation/arch/arm64/index.rst            |   1 +
>  arch/arm64/Kconfig                            |   1 +
>  arch/arm64/include/asm/acpi.h                 |  11 ++
>  arch/arm64/kernel/acpi.c                      |  16 +++
>  arch/arm64/kernel/acpi_numa.c                 |  11 --
>  arch/arm64/kernel/psci.c                      |   2 +-
>  arch/arm64/kernel/smp.c                       |  56 ++++++++-
>  drivers/acpi/acpi_processor.c                 | 113 ++++++++++--------
>  drivers/acpi/processor_driver.c               |  44 ++-----
>  drivers/acpi/scan.c                           |  47 ++++++--
>  drivers/base/cpu.c                            |  12 +-
>  drivers/irqchip/irq-gic-v3.c                  |  32 +++--
>  include/acpi/acpi_bus.h                       |   1 +
>  include/acpi/processor.h                      |   2 +-
>  include/linux/acpi.h                          |  10 +-
>  include/linux/cpumask.h                       |  25 ++++
>  kernel/cpu.c                                  |   3 +
>  19 files changed, 357 insertions(+), 115 deletions(-)
>  create mode 100644 Documentation/arch/arm64/cpu-hotplug.rst
>
> --
> 2.39.2
>
>

