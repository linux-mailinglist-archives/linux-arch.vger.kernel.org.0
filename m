Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D6D24935E
	for <lists+linux-arch@lfdr.de>; Wed, 19 Aug 2020 05:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgHSDSy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Aug 2020 23:18:54 -0400
Received: from foss.arm.com ([217.140.110.172]:53602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgHSDSx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Aug 2020 23:18:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D837E31B;
        Tue, 18 Aug 2020 20:18:51 -0700 (PDT)
Received: from [10.163.66.190] (unknown [10.163.66.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85D2C3F71F;
        Tue, 18 Aug 2020 20:18:44 -0700 (PDT)
Subject: Re: [RFC/RFT PATCH 1/6] numa: Move numa implementation to common code
To:     Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <Anup.Patel@wdc.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        Ganapatrao Kulkarni <gkulkarni@cavium.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200814214725.28818-1-atish.patra@wdc.com>
 <20200814214725.28818-2-atish.patra@wdc.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <2dce83a8-bda4-7664-9661-4e0542eecd57@arm.com>
Date:   Wed, 19 Aug 2020 08:48:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200814214725.28818-2-atish.patra@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 08/15/2020 03:17 AM, Atish Patra wrote:
> ARM64 numa implementation is generic enough that RISC-V can reuse that
> implementation with very minor cosmetic changes. This will help both
> ARM64 and RISC-V in terms of maintanace and feature improvement
> 
> Move the numa implementation code to common directory so that both ISAs
> can reuse this. This doesn't introduce any function changes for ARM64.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/arm64/Kconfig                            |  1 +
>  arch/arm64/include/asm/numa.h                 | 45 +---------------
>  arch/arm64/mm/Makefile                        |  1 -
>  drivers/base/Kconfig                          |  6 +++
>  drivers/base/Makefile                         |  1 +
>  .../mm/numa.c => drivers/base/arch_numa.c     |  0
>  include/asm-generic/numa.h                    | 51 +++++++++++++++++++
>  7 files changed, 60 insertions(+), 45 deletions(-)
>  rename arch/arm64/mm/numa.c => drivers/base/arch_numa.c (100%)
>  create mode 100644 include/asm-generic/numa.h
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 6d232837cbee..955a0cf75b16 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -960,6 +960,7 @@ config HOTPLUG_CPU
>  # Common NUMA Features
>  config NUMA
>  	bool "NUMA Memory Allocation and Scheduler Support"
> +	select GENERIC_ARCH_NUMA

So this introduces a generic NUMA framework selectable with GENERIC_ARCH_NUMA.

>  	select ACPI_NUMA if ACPI
>  	select OF_NUMA
>  	help
> diff --git a/arch/arm64/include/asm/numa.h b/arch/arm64/include/asm/numa.h
> index 626ad01e83bf..8c8cf4297cc3 100644
> --- a/arch/arm64/include/asm/numa.h
> +++ b/arch/arm64/include/asm/numa.h
> @@ -3,49 +3,6 @@
>  #define __ASM_NUMA_H
>  
>  #include <asm/topology.h>
> -
> -#ifdef CONFIG_NUMA
> -
> -#define NR_NODE_MEMBLKS		(MAX_NUMNODES * 2)
> -
> -int __node_distance(int from, int to);
> -#define node_distance(a, b) __node_distance(a, b)
> -
> -extern nodemask_t numa_nodes_parsed __initdata;
> -
> -extern bool numa_off;
> -
> -/* Mappings between node number and cpus on that node. */
> -extern cpumask_var_t node_to_cpumask_map[MAX_NUMNODES];
> -void numa_clear_node(unsigned int cpu);
> -
> -#ifdef CONFIG_DEBUG_PER_CPU_MAPS
> -const struct cpumask *cpumask_of_node(int node);
> -#else
> -/* Returns a pointer to the cpumask of CPUs on Node 'node'. */
> -static inline const struct cpumask *cpumask_of_node(int node)
> -{
> -	return node_to_cpumask_map[node];
> -}
> -#endif
> -
> -void __init arm64_numa_init(void);
> -int __init numa_add_memblk(int nodeid, u64 start, u64 end);
> -void __init numa_set_distance(int from, int to, int distance);
> -void __init numa_free_distance(void);
> -void __init early_map_cpu_to_node(unsigned int cpu, int nid);
> -void numa_store_cpu_info(unsigned int cpu);
> -void numa_add_cpu(unsigned int cpu);
> -void numa_remove_cpu(unsigned int cpu);
> -
> -#else	/* CONFIG_NUMA */
> -
> -static inline void numa_store_cpu_info(unsigned int cpu) { }
> -static inline void numa_add_cpu(unsigned int cpu) { }
> -static inline void numa_remove_cpu(unsigned int cpu) { }
> -static inline void arm64_numa_init(void) { }
> -static inline void early_map_cpu_to_node(unsigned int cpu, int nid) { }
> -
> -#endif	/* CONFIG_NUMA */
> +#include <asm-generic/numa.h>
>  
>  #endif	/* __ASM_NUMA_H */
> diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
> index d91030f0ffee..928c308b044b 100644
> --- a/arch/arm64/mm/Makefile
> +++ b/arch/arm64/mm/Makefile
> @@ -6,7 +6,6 @@ obj-y				:= dma-mapping.o extable.o fault.o init.o \
>  obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
>  obj-$(CONFIG_PTDUMP_CORE)	+= dump.o
>  obj-$(CONFIG_PTDUMP_DEBUGFS)	+= ptdump_debugfs.o
> -obj-$(CONFIG_NUMA)		+= numa.o
>  obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
>  KASAN_SANITIZE_physaddr.o	+= n
>  
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 8d7001712062..73c2151de194 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -210,4 +210,10 @@ config GENERIC_ARCH_TOPOLOGY
>  	  appropriate scaling, sysfs interface for reading capacity values at
>  	  runtime.
>  
> +config GENERIC_ARCH_NUMA
> +	bool
> +	help
> +	  Enable support for generic numa implementation. Currently, RISC-V
> +	  and ARM64 uses it.
> +
>  endmenu
> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> index 157452080f3d..c3d02c644222 100644
> --- a/drivers/base/Makefile
> +++ b/drivers/base/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_PINCTRL) += pinctrl.o
>  obj-$(CONFIG_DEV_COREDUMP) += devcoredump.o
>  obj-$(CONFIG_GENERIC_MSI_IRQ_DOMAIN) += platform-msi.o
>  obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
> +obj-$(CONFIG_GENERIC_ARCH_NUMA) += arch_numa.o
>  
>  obj-y			+= test/
>  
> diff --git a/arch/arm64/mm/numa.c b/drivers/base/arch_numa.c
> similarity index 100%
> rename from arch/arm64/mm/numa.c
> rename to drivers/base/arch_numa.c

drivers/base/ does not seem right place to host generic NUMA code.
Probably it should be either mm/ or kernel/. The other question here
would be if existing arm64 NUMA implementation is sufficient enough
for generic NUMA. I would expect any platform selecting this config
should get some NUMA enabled, will be that be true with present code ?
Otherwise it will be difficult to name it as GENERIC_ARCH_NUMA.
