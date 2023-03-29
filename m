Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504FC6CD1D7
	for <lists+linux-arch@lfdr.de>; Wed, 29 Mar 2023 07:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjC2FxJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Mar 2023 01:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjC2FxH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Mar 2023 01:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413E130F1
        for <linux-arch@vger.kernel.org>; Tue, 28 Mar 2023 22:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680069139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ObUDCyiUsnFV1cy9shzpagULe7hh9olQM4+SK/lwxlA=;
        b=DKWvKmxBTtCPIC+wD41bCymfjUeZW5Pvi1G8dUjMBR2BWVH6xTuN9/7oXujqaJsaKrNW3S
        aLhWgDSsE+oUWDlXvPD5ZiY5uv2eidrwjHFI26dHauy+Lo5NWlrfgAhIvcNwUhqkdPdBYK
        SbctQY2SV6inlM13W7KkC7iUhq0aefE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-22dEl1aZNOCW5mTj-7VZmg-1; Wed, 29 Mar 2023 01:52:18 -0400
X-MC-Unique: 22dEl1aZNOCW5mTj-7VZmg-1
Received: by mail-pg1-f199.google.com with SMTP id q1-20020a656841000000b0050be5e5bb24so3919019pgt.3
        for <linux-arch@vger.kernel.org>; Tue, 28 Mar 2023 22:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680069137; x=1682661137;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ObUDCyiUsnFV1cy9shzpagULe7hh9olQM4+SK/lwxlA=;
        b=pgeCiFg91uwJIl6Z3oZieatIZoaEghGtfN+/z3B0QZqorq6sZ0r2cqhBC5g8EUSomE
         sEiRVRfpAzpvGGb70eKszrgtRzo9ozy2FdBvx45tKki1ZdYNkdplQgly4RHxVMuyjKWL
         y2SK89qkx13hiVLgOTESwegPYmuNuauvX08Vv3a6qehxmusKbLxbs7Q9/enTJsa1qcD2
         LD8LYFJ2yY6jbViUicPTmESXUfkQPKKeMVrR1bvezKy1/mzaPfxCwkUqNmW91Ip8LFbk
         yUOQf1EKZ5Iq6LsUBOHZYpH4+TN/eF3ftEPZqtBGNRBmFvADLXSnxViXTsQPnIrYJyXV
         Cq1Q==
X-Gm-Message-State: AAQBX9eV3Hm7Ylb5tNPLMQdY/wOlT2jn/Zlex5TxeT9AZ4KE0kYsWEqu
        LDLVY0ZqG3JjFlhFQyR0a+cTicXk1Sx3Q9FYzFFUienJOIi3h6LoB6F2fmkXKJWSN4sQF97JPQg
        4Lvl62hhJwyJd5k1cV4SoJw==
X-Received: by 2002:aa7:8b1a:0:b0:628:630:a374 with SMTP id f26-20020aa78b1a000000b006280630a374mr16086113pfd.2.1680069136921;
        Tue, 28 Mar 2023 22:52:16 -0700 (PDT)
X-Google-Smtp-Source: AKy350asRmMJZp2hmdpkoKSWcwC36pg3waaI7AAJ2maRryhwQrlS9edWxJxJU43lWsoujJkkL3PQZg==
X-Received: by 2002:aa7:8b1a:0:b0:628:630:a374 with SMTP id f26-20020aa78b1a000000b006280630a374mr16086084pfd.2.1680069136580;
        Tue, 28 Mar 2023 22:52:16 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id i12-20020aa787cc000000b00580e3917af7sm15101517pfo.117.2023.03.28.22.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 22:52:16 -0700 (PDT)
Message-ID: <e17627fb-283e-dd42-94c1-f89dea167577@redhat.com>
Date:   Wed, 29 Mar 2023 13:52:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 00/32] ACPI/arm64: add support for virtual cpuhotplug
To:     James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
        loongarch@lists.linux.dev, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Len Brown <lenb@kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20230203135043.409192-1-james.morse@arm.com>
Content-Language: en-US
From:   Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20230203135043.409192-1-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi James,

On 2/3/23 21:50, James Morse wrote:
> Hello!
> 
> This series adds what looks like cpuhotplug support to arm64 for use in
> virtual machines. It does this by moving the cpu_register() calls for
> architectures that support ACPI out of the arch code by using
> GENERIC_CPU_DEVICES, then into the ACPI processor driver.
> 
> The kubernetes folk really want to be able to add CPUs to an existing VM,
> in exactly the same way they do on x86. The use-case is pre-booting guests
> with one CPU, then adding the number that were actually needed when the
> workload is provisioned.
> 
> Wait? Doesn't arm64 support cpuhotplug already!?
> In the arm world, cpuhotplug gets used to mean removing the power from a CPU.
> The CPU is offline, and remains present. For x86, and ACPI, cpuhotplug
> has the additional step of physically removing the CPU, so that it isn't
> present anymore.
> 
> Arm64 doesn't support this, and can't support it: CPUs are really a slice
> of the SoC, and there is not enough information in the existing ACPI tables
> to describe which bits of the slice also got removed. Without a reference
> machine: adding this support to the spec is a wild goose chase.
> 
> Critically: everything described in the firmware tables must remain present.
> 
> For a virtual machine this is easy as all the other bits of 'virtual SoC'
> are emulated, so they can (and do) remain present when a vCPU is 'removed'.
> 
> On a system that supports cpuhotplug the MADT has to describe every possible
> CPU at boot. Under KVM, the vGIC needs to know about every possible vCPU before
> the guest is started.
> With these constraints, virtual-cpuhotplug is really just a hypervisor/firmware
> policy about which CPUs can be brought online.
> 
> This series adds support for virtual-cpuhotplug as exactly that: firmware
> policy. This may even work on a physical machine too; for a guest the part of
> firmware is played by the VMM. (typically Qemu).
> 
> PSCI support is modified to return 'DENIED' if the CPU can't be brought
> online/enabled yet. The CPU object's _STA method's enabled bit is used to
> indicate firmware's current disposition. If the CPU has its enabled bit clear,
> it will not be registered with sysfs, and attempts to bring it online will
> fail. The notifications that _STA has changed its value then work in the same
> way as physical hotplug, and firmware can cause the CPU to be registered some
> time later, allowing it to be brought online.
> 
> This creates something that looks like cpuhotplug to user-space, as the sysfs
> files appear and disappear, and the udev notifications look the same.
> 
> One notable difference is the CPU present mask, which is exposed via sysfs.
> Because the CPUs remain present throughout, they can still be seen in that mask.
> This value does get used by webbrowsers to estimate the number of CPUs
> as the CPU online mask is constantly changed on mobile phones.
> 
> Linux is tolerant of PSCI returning errors, as its always been allowed to do
> that. To avoid confusing OS that can't tolerate this, we needed an additional
> bit in the MADT GICC flags. This series copies ACPI_MADT_ONLINE_CAPABLE, which
> appears to be for this purpose, but calls it ACPI_MADT_GICC_CPU_CAPABLE as it
> has a different bit position in the GICC.
> 
> This code is unconditionally enabled for all ACPI architectures.
> If there are problems with firmware tables on some devices, the CPUs will
> already be online by the time the acpi_processor_make_enabled() is called.
> A mismatch here causes a firmware-bug message and kernel taint. This should
> only affect people with broken firmware who also boot with maxcpus=1, and
> bring CPUs online later.
> 
> I had a go at switching the remaining architectures over to GENERIC_CPU_DEVICES,
> so that the Kconfig symbol can be removed, but I got stuck with powerpc
> and s390.
> 
> 
> The first patch has already been posted as a fix here:
> https://www.spinics.net/lists/linux-ia64/msg21920.html
> I've only build tested Loongarch and ia64.
> 
> 
> If folk want to play along at home, you'll need a copy of Qemu that supports this.
> https://github.com/salil-mehta/qemu.git salil/virt-cpuhp-armv8/rfc-v1-port29092022.psci.present
> 
> You'll need to fix the numbers of KVM_CAP_ARM_HVC_TO_USER and KVM_CAP_ARM_PSCI_TO_USER
> to match your host kernel. Replace your '-smp' argument with something like:
> | -smp cpus=1,maxcpus=3,cores=3,threads=1,sockets=1
> 
> then feed the following to the Qemu montior;
> | (qemu) device_add driver=host-arm-cpu,core-id=1,id=cpu1
> | (qemu) device_del cpu1
> 
> 
> This series is based on v6.2-rc3, and can be retrieved from:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/ virtual_cpu_hotplug/rfc/v1

I applied this patch series on v6.2-rc3 and using the QEMU cloned from 
the salil-mehta/qemu.git repo. But when I try to run the QEMU, it shows:

$ qemu-system-aarch64: -accel kvm: Failed to enable 
KVM_CAP_ARM_PSCI_TO_USER cap.

Here is the command I use:

$ qemu-system-aarch64
-machine virt
-bios /usr/share/qemu-efi-aarch64/QEMU_EFI.fd
-accel kvm
-m 4096
-smp cpus=1,maxcpus=3,cores=3,threads=1,sockets=1
-cpu host
-qmp unix:./src.socket,server,nowait
-hda ./XXX.qcow2
-serial unix:./src.serial,server,nowait
-monitor stdio

It seems something related to your notice: You'll need to fix the 
numbers of KVM_CAP_ARM_HVC_TO_USER and KVM_CAP_ARM_PSCI_TO_USER
to match your host kernel.

But I'm not actually understand what should I fix, since I haven't 
review the patch series. Could you give me some more information? Maybe 
I'm doing something wrong.

Thanks,

> 
> 
> Thanks,
> 
> James Morse (29):
>    ia64: Fix build error due to switch case label appearing next to
>      declaration
>    ACPI: Move ACPI_HOTPLUG_CPU to be enabled per architecture
>    drivers: base: Use present CPUs in GENERIC_CPU_DEVICES
>    drivers: base: Allow parts of GENERIC_CPU_DEVICES to be overridden
>    drivers: base: Move cpu_dev_init() after node_dev_init()
>    arm64: setup: Switch over to GENERIC_CPU_DEVICES using
>      arch_register_cpu()
>    ia64/topology: Switch over to GENERIC_CPU_DEVICES
>    x86/topology: Switch over to GENERIC_CPU_DEVICES
>    LoongArch: Switch over to GENERIC_CPU_DEVICES
>    arch_topology: Make register_cpu_capacity_sysctl() tolerant to late
>      CPUs
>    ACPI: processor: Add support for processors described as container
>      packages
>    ACPI: processor: Register CPUs that are online, but not described in
>      the DSDT
>    ACPI: processor: Register all CPUs from acpi_processor_get_info()
>    ACPI: Rename ACPI_HOTPLUG_CPU to include 'present'
>    ACPI: Move acpi_bus_trim_one() before acpi_scan_hot_remove()
>    ACPI: Rename acpi_processor_hotadd_init and remove pre-processor
>      guards
>    ACPI: Add post_eject to struct acpi_scan_handler for cpu hotplug
>    ACPI: Check _STA present bit before making CPUs not present
>    ACPI: Warn when the present bit changes but the feature is not enabled
>    drivers: base: Implement weak arch_unregister_cpu()
>    LoongArch: Use the __weak version of arch_unregister_cpu()
>    arm64: acpi: Move get_cpu_for_acpi_id() to a header
>    ACPICA: Add new MADT GICC flags fields [code first?]
>    arm64, irqchip/gic-v3, ACPI: Move MADT GICC enabled check into a
>      helper
>    irqchip/gic-v3: Don't return errors from gic_acpi_match_gicc()
>    irqchip/gic-v3: Add support for ACPI's disabled but 'online capable'
>      CPUs
>    ACPI: add support to register CPUs based on the _STA enabled bit
>    arm64: document virtual CPU hotplug's expectations
>    cpumask: Add enabled cpumask for present CPUs that can be brought
>      online
> 
> Jean-Philippe Brucker (3):
>    arm64: psci: Ignore DENIED CPUs
>    KVM: arm64: Pass hypercalls to userspace
>    KVM: arm64: Pass PSCI calls to userspace
> 
>   Documentation/arm64/cpu-hotplug.rst       |  79 ++++++++++++
>   Documentation/arm64/index.rst             |   1 +
>   Documentation/virt/kvm/api.rst            |  31 ++++-
>   Documentation/virt/kvm/arm/hypercalls.rst |   1 +
>   arch/arm64/Kconfig                        |   1 +
>   arch/arm64/include/asm/acpi.h             |  11 ++
>   arch/arm64/include/asm/cpu.h              |   1 -
>   arch/arm64/include/asm/kvm_host.h         |   2 +
>   arch/arm64/kernel/acpi_numa.c             |  11 --
>   arch/arm64/kernel/psci.c                  |   2 +-
>   arch/arm64/kernel/setup.c                 |  13 +-
>   arch/arm64/kernel/smp.c                   |   5 +-
>   arch/arm64/kvm/arm.c                      |  15 ++-
>   arch/arm64/kvm/hypercalls.c               |  28 ++++-
>   arch/arm64/kvm/psci.c                     |  13 ++
>   arch/ia64/Kconfig                         |   2 +
>   arch/ia64/include/asm/acpi.h              |   2 +-
>   arch/ia64/include/asm/cpu.h               |  11 --
>   arch/ia64/kernel/acpi.c                   |   6 +-
>   arch/ia64/kernel/setup.c                  |   2 +-
>   arch/ia64/kernel/sys_ia64.c               |   7 +-
>   arch/ia64/kernel/topology.c               |  35 +-----
>   arch/loongarch/Kconfig                    |   2 +
>   arch/loongarch/kernel/topology.c          |  31 +----
>   arch/x86/Kconfig                          |   2 +
>   arch/x86/include/asm/cpu.h                |   6 -
>   arch/x86/kernel/acpi/boot.c               |   4 +-
>   arch/x86/kernel/topology.c                |  19 +--
>   drivers/acpi/Kconfig                      |   5 +-
>   drivers/acpi/acpi_processor.c             | 146 +++++++++++++++++-----
>   drivers/acpi/processor_core.c             |   2 +-
>   drivers/acpi/scan.c                       | 116 +++++++++++------
>   drivers/base/arch_topology.c              |  38 ++++--
>   drivers/base/cpu.c                        |  31 ++++-
>   drivers/base/init.c                       |   2 +-
>   drivers/firmware/psci/psci.c              |   2 +
>   drivers/irqchip/irq-gic-v3.c              |  38 +++---
>   include/acpi/acpi_bus.h                   |   1 +
>   include/acpi/actbl2.h                     |   1 +
>   include/kvm/arm_hypercalls.h              |   1 +
>   include/kvm/arm_psci.h                    |   4 +
>   include/linux/acpi.h                      |  10 +-
>   include/linux/cpu.h                       |   6 +
>   include/linux/cpumask.h                   |  25 ++++
>   include/uapi/linux/kvm.h                  |   2 +
>   kernel/cpu.c                              |   3 +
>   46 files changed, 532 insertions(+), 244 deletions(-)
>   create mode 100644 Documentation/arm64/cpu-hotplug.rst
> 

-- 
Shaoqin

