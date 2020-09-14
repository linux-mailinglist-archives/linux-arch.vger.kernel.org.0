Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED2D268D6A
	for <lists+linux-arch@lfdr.de>; Mon, 14 Sep 2020 16:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgINOWu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Sep 2020 10:22:50 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2817 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726772AbgINOWr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Sep 2020 10:22:47 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 12434ADA93495CC8BBE9;
        Mon, 14 Sep 2020 15:22:41 +0100 (IST)
Received: from localhost (10.52.126.156) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 14 Sep
 2020 15:22:40 +0100
Date:   Mon, 14 Sep 2020 15:21:03 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Atish Patra <atish.patra@wdc.com>
CC:     <linux-kernel@vger.kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anup Patel <anup@brainfault.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David Hildenbrand" <david@redhat.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jia He <justin.he@arm.com>, <linux-arch@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        "Mike Rapoport" <rppt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>
Subject: Re: [RFC/RFT PATCH v2 1/5] numa: Move numa implementation to common
 code
Message-ID: <20200914152103.000062e3@Huawei.com>
In-Reply-To: <20200912013441.9730-2-atish.patra@wdc.com>
References: <20200912013441.9730-1-atish.patra@wdc.com>
        <20200912013441.9730-2-atish.patra@wdc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.156]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 11 Sep 2020 18:34:37 -0700
Atish Patra <atish.patra@wdc.com> wrote:

> ARM64 numa implementation is generic enough that RISC-V can reuse that
> implementation with very minor cosmetic changes. This will help both
> ARM64 and RISC-V in terms of maintanace and feature improvement
> 
> Move the numa implementation code to common directory so that both ISAs
> can reuse this. This doesn't introduce any function changes for ARM64.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
Looks good to me.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  arch/arm64/Kconfig                            |  1 +
>  arch/arm64/include/asm/numa.h                 | 45 +----------------
>  arch/arm64/mm/Makefile                        |  1 -
>  drivers/base/Kconfig                          |  6 +++
>  drivers/base/Makefile                         |  1 +
>  .../mm/numa.c => drivers/base/arch_numa.c     |  0
>  include/asm-generic/numa.h                    | 49 +++++++++++++++++++
>  7 files changed, 58 insertions(+), 45 deletions(-)
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
> index 8d7001712062..c5956c8845cc 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -210,4 +210,10 @@ config GENERIC_ARCH_TOPOLOGY
>  	  appropriate scaling, sysfs interface for reading capacity values at
>  	  runtime.
>  
> +config GENERIC_ARCH_NUMA
> +	bool
> +	help
> +	  Enable support for generic NUMA implementation. Currently, RISC-V
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
> diff --git a/include/asm-generic/numa.h b/include/asm-generic/numa.h
> new file mode 100644
> index 000000000000..2718d5a6ff03
> --- /dev/null
> +++ b/include/asm-generic/numa.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_GENERIC_NUMA_H
> +#define __ASM_GENERIC_NUMA_H
> +
> +#ifdef CONFIG_NUMA
> +
> +#define NR_NODE_MEMBLKS		(MAX_NUMNODES * 2)
> +
> +int __node_distance(int from, int to);
> +#define node_distance(a, b) __node_distance(a, b)
> +
> +extern nodemask_t numa_nodes_parsed __initdata;
> +
> +extern bool numa_off;
> +
> +/* Mappings between node number and cpus on that node. */
> +extern cpumask_var_t node_to_cpumask_map[MAX_NUMNODES];
> +void numa_clear_node(unsigned int cpu);
> +
> +#ifdef CONFIG_DEBUG_PER_CPU_MAPS
> +const struct cpumask *cpumask_of_node(int node);
> +#else
> +/* Returns a pointer to the cpumask of CPUs on Node 'node'. */
> +static inline const struct cpumask *cpumask_of_node(int node)
> +{
> +	return node_to_cpumask_map[node];
> +}
> +#endif
> +
> +void __init arm64_numa_init(void);
> +int __init numa_add_memblk(int nodeid, u64 start, u64 end);
> +void __init numa_set_distance(int from, int to, int distance);
> +void __init numa_free_distance(void);
> +void __init early_map_cpu_to_node(unsigned int cpu, int nid);
> +void numa_store_cpu_info(unsigned int cpu);
> +void numa_add_cpu(unsigned int cpu);
> +void numa_remove_cpu(unsigned int cpu);
> +
> +#else	/* CONFIG_NUMA */
> +
> +static inline void numa_store_cpu_info(unsigned int cpu) { }
> +static inline void numa_add_cpu(unsigned int cpu) { }
> +static inline void numa_remove_cpu(unsigned int cpu) { }
> +static inline void arm64_numa_init(void) { }
> +static inline void early_map_cpu_to_node(unsigned int cpu, int nid) { }
> +
> +#endif	/* CONFIG_NUMA */
> +
> +#endif	/* __ASM_GENERIC_NUMA_H */


