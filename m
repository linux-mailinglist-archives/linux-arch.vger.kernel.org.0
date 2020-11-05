Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6262A84FD
	for <lists+linux-arch@lfdr.de>; Thu,  5 Nov 2020 18:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbgKEReJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Nov 2020 12:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731718AbgKEReF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Nov 2020 12:34:05 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC426C0613CF
        for <linux-arch@vger.kernel.org>; Thu,  5 Nov 2020 09:34:05 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id b12so1119764plr.4
        for <linux-arch@vger.kernel.org>; Thu, 05 Nov 2020 09:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=tTLsC/JuQ9bT/PZn35J3jlik1A01EKZdB5uZT6NLQBA=;
        b=SuuyI97WQoL3e1V24w2VyMJKF8BUZuDbbfZcWOZtvzUs6zISDUNKj3OBsVMyJTDZ8w
         kayLQCl5PSYcdJuErzFK3EyxT3VMo2mYB7STyrJx6FQQn+hJtSVip3SlkHTEh/AAvUr3
         y1wkK/oYpD6XGy6lIgmy3ums6Au6e4RmXaR2QCJq1O89XGz578nqJL079oy8Kbap8wJS
         mOoPX0a4281MiLzTSIDqDewSme+JQGhzTD3OUnhIm9fXkp2DxOzAZaonnQfHApdV/km1
         ztwxx5HfTf+g342CtbB/GKjdApVHrIiorSOddpyboYnQ5k3HSk0rP4ThN8GbgFlLQKoE
         3ESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=tTLsC/JuQ9bT/PZn35J3jlik1A01EKZdB5uZT6NLQBA=;
        b=fO0ZG0YGaUXFOKbifvq4C8ISJCjZn0SdInqp3mbvEkhbxVH9I/u5aKtsFDHhECw1l6
         Ry0sBJuGkkQmZuUl9U5yXrxFdv0GkLRLIgc3B3xdVclHD0lcfr/Syi5ZDOtcCm6bKRZn
         bmzDnTPebrql9CkACwvdVFLZKCI9eRIAyYXx6egmKYML+Lb0AYh9bAJvY4zgXSalWqlA
         2zoAYW9BRF5V00xI46qPPj9De302Ic0co6fXbenOyKzJ0IRz3g/7j7wqv7EHwbmMXSHU
         ddDYwkyPYhzqU25p+rYt4qYCebMelrlpxzbIKITNmvtwvgQMntREliN0lpRRZt1Z40BA
         FpDA==
X-Gm-Message-State: AOAM533QN7r8JGXrXC5Ol6fFEC8UIqBbnWUfestmAVYfi3JkksygWq+x
        q7HQ4I70LEfahuJycSrrAyzv0w==
X-Google-Smtp-Source: ABdhPJyBPgbj1/snChSvWmWc+krUey7SpFzonD3pHV1MYkFo143SPttZ1q/7GRldlW1JILrJfMH1AA==
X-Received: by 2002:a17:902:e983:b029:d5:f465:55d5 with SMTP id f3-20020a170902e983b02900d5f46555d5mr3142970plb.60.1604597645101;
        Thu, 05 Nov 2020 09:34:05 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id i26sm3391428pfq.148.2020.11.05.09.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 09:34:04 -0800 (PST)
Date:   Thu, 05 Nov 2020 09:34:04 -0800 (PST)
X-Google-Original-Date: Thu, 05 Nov 2020 09:32:00 PST (-0800)
Subject:     Re: [PATCH v4 5/5] riscv: Add numa support for riscv64 platform
In-Reply-To: <20201006001752.248564-6-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        greentime.hu@sifive.com, aou@eecs.berkeley.edu,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        anup@brainfault.org, Arnd Bergmann <arnd@arndb.de>,
        catalin.marinas@arm.com, david@redhat.com,
        Greg KH <gregkh@linuxfoundation.org>, justin.he@arm.com,
        Jonathan.Cameron@huawei.com, wangkefeng.wang@huawei.com,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        rppt@kernel.org, nsaenzjulienne@suse.de,
        Paul Walmsley <paul.walmsley@sifive.com>, rafael@kernel.org,
        steven.price@arm.com, will@kernel.org, zong.li@sifive.com,
        linux-arm-kernel@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-78302817-9862-47d3-97a2-61d406377210@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 05 Oct 2020 17:17:52 PDT (-0700), Atish Patra wrote:
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
>  	default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
>
>  config ARCH_FLATMEM_ENABLE
> -	def_bool y
> +	def_bool !NUMA
>
>  config ARCH_SPARSEMEM_ENABLE
>  	def_bool y
> @@ -295,6 +295,35 @@ config TUNE_GENERIC
>
>  endchoice
>
> +# Common NUMA Features
> +config NUMA
> +	bool "NUMA Memory Allocation and Scheduler Support"
> +	select GENERIC_ARCH_NUMA
> +	select OF_NUMA
> +	select ARCH_SUPPORTS_NUMA_BALANCING
> +	help
> +	  Enable NUMA (Non-Uniform Memory Access) support.
> +
> +	  The kernel will try to allocate memory used by a CPU on the
> +	  local memory of the CPU and add some more NUMA awareness to the kernel.
> +
> +config NODES_SHIFT
> +	int "Maximum NUMA Nodes (as a power of 2)"
> +	range 1 10
> +	default "2"
> +	depends on NEED_MULTIPLE_NODES
> +	help
> +	  Specify the maximum number of NUMA Nodes available on the target
> +	  system.  Increases memory reserved to accommodate various tables.
> +
> +config USE_PERCPU_NUMA_NODE_ID
> +	def_bool y
> +	depends on NUMA
> +
> +config NEED_PER_CPU_EMBED_FIRST_CHUNK
> +	def_bool y
> +	depends on NUMA
> +
>  config RISCV_ISA_C
>  	bool "Emit compressed instructions when building Linux"
>  	default y
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
> +#define NODE_DATA(nid)		(node_data[(nid)])
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
> +#endif	/* __ASM_NUMA_H */
> diff --git a/arch/riscv/include/asm/pci.h b/arch/riscv/include/asm/pci.h
> index 1c473a1bd986..658e112c3ce7 100644
> --- a/arch/riscv/include/asm/pci.h
> +++ b/arch/riscv/include/asm/pci.h
> @@ -32,6 +32,20 @@ static inline int pci_proc_domain(struct pci_bus *bus)
>  	/* always show the domain in /proc */
>  	return 1;
>  }
> +
> +#ifdef	CONFIG_NUMA
> +
> +static inline int pcibus_to_node(struct pci_bus *bus)
> +{
> +	return dev_to_node(&bus->dev);
> +}
> +#ifndef cpumask_of_pcibus
> +#define cpumask_of_pcibus(bus)	(pcibus_to_node(bus) == -1 ?		\
> +				 cpu_all_mask :				\
> +				 cpumask_of_node(pcibus_to_node(bus)))
> +#endif
> +#endif	/* CONFIG_NUMA */
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
> -	int i;
> +	int i, ret;
> +
> +	for_each_online_node(i)
> +		register_one_node(i);
>
>  	for_each_possible_cpu(i) {
>  		struct cpu *cpu = &per_cpu(cpu_devices, i);
>
>  		cpu->hotpluggable = cpu_has_hotplug(i);
> -		register_cpu(cpu, i);
> +		ret = register_cpu(cpu, i);
> +		if (unlikely(ret))
> +			pr_warn("Warning: %s: register_cpu %d failed (%d)\n",
> +			       __func__, i, ret);
>  	}
>
>  	return 0;
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
>  	int cpuid;
>  	int ret;
> +	unsigned int curr_cpuid;
> +
> +	curr_cpuid = smp_processor_id();
> +	numa_store_cpu_info(curr_cpuid);
> +	numa_add_cpu(curr_cpuid);
>
>  	/* This covers non-smp usecase mandated by "nosmp" option */
>  	if (max_cpus == 0)
>  		return;
>
>  	for_each_possible_cpu(cpuid) {
> -		if (cpuid == smp_processor_id())
> +		if (cpuid == curr_cpuid)
>  			continue;
>  		if (cpu_ops[cpuid]->cpu_prepare) {
>  			ret = cpu_ops[cpuid]->cpu_prepare(cpuid);
> @@ -59,6 +65,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  				continue;
>  		}
>  		set_cpu_present(cpuid, true);
> +		numa_store_cpu_info(cpuid);
>  	}
>  }
>
> @@ -79,6 +86,7 @@ void __init setup_smp(void)
>  		if (hart == cpuid_to_hartid_map(0)) {
>  			BUG_ON(found_boot_cpu);
>  			found_boot_cpu = 1;
> +			early_map_cpu_to_node(0, of_node_to_nid(dn));
>  			continue;
>  		}
>  		if (cpuid >= NR_CPUS) {
> @@ -88,6 +96,7 @@ void __init setup_smp(void)
>  		}
>
>  		cpuid_to_hartid_map(cpuid) = hart;
> +		early_map_cpu_to_node(cpuid, of_node_to_nid(dn));
>  		cpuid++;
>  	}
>
> @@ -153,6 +162,7 @@ asmlinkage __visible void smp_callin(void)
>  	current->active_mm = mm;
>
>  	notify_cpu_starting(curr_cpuid);
> +	numa_add_cpu(curr_cpuid);
>  	update_siblings_masks(curr_cpuid);
>  	set_cpu_online(curr_cpuid, 1);
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
>  	early_init_fdt_scan_reserved_mem();
>  	memblock_allow_resize();
> -	memblock_dump_all();
>
>  	for_each_memblock(memory, reg) {
>  		unsigned long start_pfn = memblock_region_memory_base_pfn(reg);
> @@ -570,9 +570,11 @@ void __init paging_init(void)
>
>  void __init misc_mem_init(void)
>  {
> +	arch_numa_init();
>  	sparse_init();
>  	zone_sizes_init();
>  	resource_init();
> +	memblock_dump_all();
>  }
>
>  #ifdef CONFIG_SPARSEMEM_VMEMMAP

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
