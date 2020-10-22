Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD71295801
	for <lists+linux-arch@lfdr.de>; Thu, 22 Oct 2020 07:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507990AbgJVFkn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Oct 2020 01:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2444542AbgJVFkn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Oct 2020 01:40:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D49C0613CE
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2020 22:40:43 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g12so535316wrp.10
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2020 22:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=57MKFsdWHuxy2mud/f3sRav90H6vR3X3bXB+aK2zwsM=;
        b=Cga0QxL4oWgJW16fKnIb/E1PxyhOqCbXnjgtfqpdhhj0ffgmcTsXVUkR6C9z5kxeWw
         cORHo/iZkjn5wKo7FZbw87BDXvzo4CujaHumqXPD5TQKq3zFL6UUjBCxp0OjZGjNj8pB
         relmLSTginw62ENyCwqLiy8SB6SM7TXnFOovgG/o3o0LK+DCxyI66SgWse6dhNkJ+C6v
         H8YEUMxFHpLGbJe4p3psTyWebQjqF818unNVH6nAkyrt/2yG5hEn0vh1HPeFNFcxPD8Y
         P7G76i6A2rjEddM0PzCnFa4ikDxm+E50S12XDGPPAq3VXqTFKsdUK4lkpLvYBgPGF1SU
         T5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=57MKFsdWHuxy2mud/f3sRav90H6vR3X3bXB+aK2zwsM=;
        b=rDO1gG1GudPe9qM6EukQY0t8y2RwZFI48wzHNN6cJk84YlCLdAxNfIh/1E6c9KGNzN
         bRWj5A00wmnXjBF+9FM1OdUXg91nxqtyIC5AYsR13uTV6aq7Q5TSrLDS9u4RrTJy6572
         71u1P7WVE9KV0zUFoY7cwZDqjStr+IJ+WGqms/baxvaicaikJla4uBXinK5UDmSMbsYU
         szH8jnMCbxxzI7wBpDduJSKqeaBCaAYAC1Gn9RbgK3Hq4aCgfcZOeYaQeNO0rlgHsLOt
         rFTKCk/ZAUtS4SCjkVNCyzrX090yNNyWoqd5gnASdHU771rQ4VYtLn0rJV4B91ihZVAI
         UZrw==
X-Gm-Message-State: AOAM5323I7tDUT0UDAr/zALo6kNG9B0BmO+uIVvndyygFnkll2dE6EQl
        ZRhfFaSgTbeDMM2s65Tlou7iv9m9LVDPnlqABV5CPQ==
X-Google-Smtp-Source: ABdhPJxYEqJskkiSHliaBgmXxUtWHmk6epcxfVz5x1u6SUxa3ULx/Oc+QHT5Ohu/ricNlRWAa5tFdiWartwo6vIGEC8=
X-Received: by 2002:adf:e54b:: with SMTP id z11mr803140wrm.128.1603345241725;
 Wed, 21 Oct 2020 22:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201006001752.248564-1-atish.patra@wdc.com> <20201006001752.248564-6-atish.patra@wdc.com>
In-Reply-To: <20201006001752.248564-6-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 22 Oct 2020 11:10:29 +0530
Message-ID: <CAAhSdy3f7oxMBh=39gULRbd-7saMwmAm1-dikV7ijE5BK2dhsw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] riscv: Add numa support for riscv64 platform
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jia He <justin.he@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-arch@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 6, 2020 at 5:48 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> Use the generic numa implementation to add NUMA support for RISC-V.
> This is based on Greentime's patch[1] but modified to use generic NUMA
> implementation and few more fixes.
>
> [1] https://lkml.org/lkml/2020/1/10/233
>
> Co-developed-by: Greentime Hu <greentime.hu@sifive.com>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/Kconfig              | 31 ++++++++++++++++++++++++++++++-
>  arch/riscv/include/asm/mmzone.h | 13 +++++++++++++
>  arch/riscv/include/asm/numa.h   |  8 ++++++++
>  arch/riscv/include/asm/pci.h    | 14 ++++++++++++++
>  arch/riscv/kernel/setup.c       | 10 ++++++++--
>  arch/riscv/kernel/smpboot.c     | 12 +++++++++++-
>  arch/riscv/mm/init.c            |  4 +++-
>  7 files changed, 87 insertions(+), 5 deletions(-)
>  create mode 100644 arch/riscv/include/asm/mmzone.h
>  create mode 100644 arch/riscv/include/asm/numa.h
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index df18372861d8..7beb6ddb6eb1 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -137,7 +137,7 @@ config PAGE_OFFSET
>         default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
>
>  config ARCH_FLATMEM_ENABLE
> -       def_bool y
> +       def_bool !NUMA
>
>  config ARCH_SPARSEMEM_ENABLE
>         def_bool y
> @@ -295,6 +295,35 @@ config TUNE_GENERIC
>
>  endchoice
>
> +# Common NUMA Features
> +config NUMA
> +       bool "NUMA Memory Allocation and Scheduler Support"
> +       select GENERIC_ARCH_NUMA
> +       select OF_NUMA
> +       select ARCH_SUPPORTS_NUMA_BALANCING
> +       help
> +         Enable NUMA (Non-Uniform Memory Access) support.
> +
> +         The kernel will try to allocate memory used by a CPU on the
> +         local memory of the CPU and add some more NUMA awareness to the kernel.
> +
> +config NODES_SHIFT
> +       int "Maximum NUMA Nodes (as a power of 2)"
> +       range 1 10
> +       default "2"
> +       depends on NEED_MULTIPLE_NODES
> +       help
> +         Specify the maximum number of NUMA Nodes available on the target
> +         system.  Increases memory reserved to accommodate various tables.
> +
> +config USE_PERCPU_NUMA_NODE_ID
> +       def_bool y
> +       depends on NUMA
> +
> +config NEED_PER_CPU_EMBED_FIRST_CHUNK
> +       def_bool y
> +       depends on NUMA
> +
>  config RISCV_ISA_C
>         bool "Emit compressed instructions when building Linux"
>         default y
> diff --git a/arch/riscv/include/asm/mmzone.h b/arch/riscv/include/asm/mmzone.h
> new file mode 100644
> index 000000000000..fa17e01d9ab2
> --- /dev/null
> +++ b/arch/riscv/include/asm/mmzone.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_MMZONE_H
> +#define __ASM_MMZONE_H
> +
> +#ifdef CONFIG_NUMA
> +
> +#include <asm/numa.h>
> +
> +extern struct pglist_data *node_data[];
> +#define NODE_DATA(nid)         (node_data[(nid)])
> +
> +#endif /* CONFIG_NUMA */
> +#endif /* __ASM_MMZONE_H */
> diff --git a/arch/riscv/include/asm/numa.h b/arch/riscv/include/asm/numa.h
> new file mode 100644
> index 000000000000..8c8cf4297cc3
> --- /dev/null
> +++ b/arch/riscv/include/asm/numa.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_NUMA_H
> +#define __ASM_NUMA_H
> +
> +#include <asm/topology.h>
> +#include <asm-generic/numa.h>
> +
> +#endif /* __ASM_NUMA_H */
> diff --git a/arch/riscv/include/asm/pci.h b/arch/riscv/include/asm/pci.h
> index 1c473a1bd986..658e112c3ce7 100644
> --- a/arch/riscv/include/asm/pci.h
> +++ b/arch/riscv/include/asm/pci.h
> @@ -32,6 +32,20 @@ static inline int pci_proc_domain(struct pci_bus *bus)
>         /* always show the domain in /proc */
>         return 1;
>  }
> +
> +#ifdef CONFIG_NUMA
> +
> +static inline int pcibus_to_node(struct pci_bus *bus)
> +{
> +       return dev_to_node(&bus->dev);
> +}
> +#ifndef cpumask_of_pcibus
> +#define cpumask_of_pcibus(bus) (pcibus_to_node(bus) == -1 ?            \
> +                                cpu_all_mask :                         \
> +                                cpumask_of_node(pcibus_to_node(bus)))
> +#endif
> +#endif /* CONFIG_NUMA */
> +
>  #endif  /* CONFIG_PCI */
>
>  #endif  /* _ASM_RISCV_PCI_H */
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 07fa6d13367e..53a806a9cbaf 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -101,13 +101,19 @@ void __init setup_arch(char **cmdline_p)
>
>  static int __init topology_init(void)
>  {
> -       int i;
> +       int i, ret;
> +
> +       for_each_online_node(i)
> +               register_one_node(i);
>
>         for_each_possible_cpu(i) {
>                 struct cpu *cpu = &per_cpu(cpu_devices, i);
>
>                 cpu->hotpluggable = cpu_has_hotplug(i);
> -               register_cpu(cpu, i);
> +               ret = register_cpu(cpu, i);
> +               if (unlikely(ret))
> +                       pr_warn("Warning: %s: register_cpu %d failed (%d)\n",
> +                              __func__, i, ret);
>         }
>
>         return 0;
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 96167d55ed98..5e276c25646f 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -27,6 +27,7 @@
>  #include <asm/cpu_ops.h>
>  #include <asm/irq.h>
>  #include <asm/mmu_context.h>
> +#include <asm/numa.h>
>  #include <asm/tlbflush.h>
>  #include <asm/sections.h>
>  #include <asm/sbi.h>
> @@ -45,13 +46,18 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  {
>         int cpuid;
>         int ret;
> +       unsigned int curr_cpuid;
> +
> +       curr_cpuid = smp_processor_id();
> +       numa_store_cpu_info(curr_cpuid);
> +       numa_add_cpu(curr_cpuid);
>
>         /* This covers non-smp usecase mandated by "nosmp" option */
>         if (max_cpus == 0)
>                 return;
>
>         for_each_possible_cpu(cpuid) {
> -               if (cpuid == smp_processor_id())
> +               if (cpuid == curr_cpuid)
>                         continue;
>                 if (cpu_ops[cpuid]->cpu_prepare) {
>                         ret = cpu_ops[cpuid]->cpu_prepare(cpuid);
> @@ -59,6 +65,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>                                 continue;
>                 }
>                 set_cpu_present(cpuid, true);
> +               numa_store_cpu_info(cpuid);
>         }
>  }
>
> @@ -79,6 +86,7 @@ void __init setup_smp(void)
>                 if (hart == cpuid_to_hartid_map(0)) {
>                         BUG_ON(found_boot_cpu);
>                         found_boot_cpu = 1;
> +                       early_map_cpu_to_node(0, of_node_to_nid(dn));
>                         continue;
>                 }
>                 if (cpuid >= NR_CPUS) {
> @@ -88,6 +96,7 @@ void __init setup_smp(void)
>                 }
>
>                 cpuid_to_hartid_map(cpuid) = hart;
> +               early_map_cpu_to_node(cpuid, of_node_to_nid(dn));
>                 cpuid++;
>         }
>
> @@ -153,6 +162,7 @@ asmlinkage __visible void smp_callin(void)
>         current->active_mm = mm;
>
>         notify_cpu_starting(curr_cpuid);
> +       numa_add_cpu(curr_cpuid);
>         update_siblings_masks(curr_cpuid);
>         set_cpu_online(curr_cpuid, 1);
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 114c3966aadb..c4046e11d264 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -20,6 +20,7 @@
>  #include <asm/soc.h>
>  #include <asm/io.h>
>  #include <asm/ptdump.h>
> +#include <asm/numa.h>
>
>  #include "../kernel/head.h"
>
> @@ -185,7 +186,6 @@ void __init setup_bootmem(void)
>
>         early_init_fdt_scan_reserved_mem();
>         memblock_allow_resize();
> -       memblock_dump_all();
>
>         for_each_memblock(memory, reg) {
>                 unsigned long start_pfn = memblock_region_memory_base_pfn(reg);
> @@ -570,9 +570,11 @@ void __init paging_init(void)
>
>  void __init misc_mem_init(void)
>  {
> +       arch_numa_init();
>         sparse_init();
>         zone_sizes_init();
>         resource_init();
> +       memblock_dump_all();
>  }
>
>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
> --
> 2.25.1
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
