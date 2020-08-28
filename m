Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D8C25574D
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 11:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgH1JPA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 05:15:00 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2705 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728218AbgH1JO7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 05:14:59 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 0691E849B36AE79719A5;
        Fri, 28 Aug 2020 10:14:58 +0100 (IST)
Received: from localhost (10.52.127.106) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 28 Aug
 2020 10:14:56 +0100
Date:   Fri, 28 Aug 2020 10:13:21 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Atish Patra <atishp@atishpatra.org>
CC:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nick Hu <nickhu@andestech.com>, Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Ganapatrao Kulkarni <gkulkarni@cavium.com>,
        "Steven Price" <steven.price@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zong Li <zong.li@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [RFC/RFT PATCH 1/6] numa: Move numa implementation to common
 code
Message-ID: <20200828101321.00002f42@Huawei.com>
In-Reply-To: <CAOnJCULb9sAJ4GMUdcMDn2SfAo+U-GXq5JdcKOkD5BfkdMT8aw@mail.gmail.com>
References: <20200814214725.28818-1-atish.patra@wdc.com>
        <20200814214725.28818-2-atish.patra@wdc.com>
        <2dce83a8-bda4-7664-9661-4e0542eecd57@arm.com>
        <CAOnJCULbzjsefufgBgonBowgctEqeuLKixskD=5ph8-jUOmM+g@mail.gmail.com>
        <4caa2123-970a-0241-bb6e-03bd0f8478db@arm.com>
        <CAOnJCULb9sAJ4GMUdcMDn2SfAo+U-GXq5JdcKOkD5BfkdMT8aw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.127.106]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 21 Aug 2020 14:58:22 -0700
Atish Patra <atishp@atishpatra.org> wrote:

> On Wed, Aug 19, 2020 at 8:20 PM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
> >
> >
> >
> > On 08/20/2020 12:48 AM, Atish Patra wrote:  
> > > On Tue, Aug 18, 2020 at 8:19 PM Anshuman Khandual
> > > <anshuman.khandual@arm.com> wrote:  
> > >>
> > >>
> > >>
> > >> On 08/15/2020 03:17 AM, Atish Patra wrote:  
> > >>> ARM64 numa implementation is generic enough that RISC-V can reuse that
> > >>> implementation with very minor cosmetic changes. This will help both
> > >>> ARM64 and RISC-V in terms of maintanace and feature improvement
> > >>>
> > >>> Move the numa implementation code to common directory so that both ISAs
> > >>> can reuse this. This doesn't introduce any function changes for ARM64.
> > >>>
> > >>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > >>> ---
> > >>>  arch/arm64/Kconfig                            |  1 +
> > >>>  arch/arm64/include/asm/numa.h                 | 45 +---------------
> > >>>  arch/arm64/mm/Makefile                        |  1 -
> > >>>  drivers/base/Kconfig                          |  6 +++
> > >>>  drivers/base/Makefile                         |  1 +
> > >>>  .../mm/numa.c => drivers/base/arch_numa.c     |  0
> > >>>  include/asm-generic/numa.h                    | 51 +++++++++++++++++++
> > >>>  7 files changed, 60 insertions(+), 45 deletions(-)
> > >>>  rename arch/arm64/mm/numa.c => drivers/base/arch_numa.c (100%)
> > >>>  create mode 100644 include/asm-generic/numa.h
> > >>>
> > >>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > >>> index 6d232837cbee..955a0cf75b16 100644
> > >>> --- a/arch/arm64/Kconfig
> > >>> +++ b/arch/arm64/Kconfig
> > >>> @@ -960,6 +960,7 @@ config HOTPLUG_CPU
> > >>>  # Common NUMA Features
> > >>>  config NUMA
> > >>>       bool "NUMA Memory Allocation and Scheduler Support"
> > >>> +     select GENERIC_ARCH_NUMA  
> > >>
> > >> So this introduces a generic NUMA framework selectable with GENERIC_ARCH_NUMA.
> > >>  
> > >>>       select ACPI_NUMA if ACPI
> > >>>       select OF_NUMA
> > >>>       help
> > >>> diff --git a/arch/arm64/include/asm/numa.h b/arch/arm64/include/asm/numa.h
> > >>> index 626ad01e83bf..8c8cf4297cc3 100644
> > >>> --- a/arch/arm64/include/asm/numa.h
> > >>> +++ b/arch/arm64/include/asm/numa.h
> > >>> @@ -3,49 +3,6 @@
> > >>>  #define __ASM_NUMA_H
> > >>>
> > >>>  #include <asm/topology.h>
> > >>> -
> > >>> -#ifdef CONFIG_NUMA
> > >>> -
> > >>> -#define NR_NODE_MEMBLKS              (MAX_NUMNODES * 2)
> > >>> -
> > >>> -int __node_distance(int from, int to);
> > >>> -#define node_distance(a, b) __node_distance(a, b)
> > >>> -
> > >>> -extern nodemask_t numa_nodes_parsed __initdata;
> > >>> -
> > >>> -extern bool numa_off;
> > >>> -
> > >>> -/* Mappings between node number and cpus on that node. */
> > >>> -extern cpumask_var_t node_to_cpumask_map[MAX_NUMNODES];
> > >>> -void numa_clear_node(unsigned int cpu);
> > >>> -
> > >>> -#ifdef CONFIG_DEBUG_PER_CPU_MAPS
> > >>> -const struct cpumask *cpumask_of_node(int node);
> > >>> -#else
> > >>> -/* Returns a pointer to the cpumask of CPUs on Node 'node'. */
> > >>> -static inline const struct cpumask *cpumask_of_node(int node)
> > >>> -{
> > >>> -     return node_to_cpumask_map[node];
> > >>> -}
> > >>> -#endif
> > >>> -
> > >>> -void __init arm64_numa_init(void);
> > >>> -int __init numa_add_memblk(int nodeid, u64 start, u64 end);
> > >>> -void __init numa_set_distance(int from, int to, int distance);
> > >>> -void __init numa_free_distance(void);
> > >>> -void __init early_map_cpu_to_node(unsigned int cpu, int nid);
> > >>> -void numa_store_cpu_info(unsigned int cpu);
> > >>> -void numa_add_cpu(unsigned int cpu);
> > >>> -void numa_remove_cpu(unsigned int cpu);
> > >>> -
> > >>> -#else        /* CONFIG_NUMA */
> > >>> -
> > >>> -static inline void numa_store_cpu_info(unsigned int cpu) { }
> > >>> -static inline void numa_add_cpu(unsigned int cpu) { }
> > >>> -static inline void numa_remove_cpu(unsigned int cpu) { }
> > >>> -static inline void arm64_numa_init(void) { }
> > >>> -static inline void early_map_cpu_to_node(unsigned int cpu, int nid) { }
> > >>> -
> > >>> -#endif       /* CONFIG_NUMA */
> > >>> +#include <asm-generic/numa.h>
> > >>>
> > >>>  #endif       /* __ASM_NUMA_H */
> > >>> diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
> > >>> index d91030f0ffee..928c308b044b 100644
> > >>> --- a/arch/arm64/mm/Makefile
> > >>> +++ b/arch/arm64/mm/Makefile
> > >>> @@ -6,7 +6,6 @@ obj-y                         := dma-mapping.o extable.o fault.o init.o \
> > >>>  obj-$(CONFIG_HUGETLB_PAGE)   += hugetlbpage.o
> > >>>  obj-$(CONFIG_PTDUMP_CORE)    += dump.o
> > >>>  obj-$(CONFIG_PTDUMP_DEBUGFS) += ptdump_debugfs.o
> > >>> -obj-$(CONFIG_NUMA)           += numa.o
> > >>>  obj-$(CONFIG_DEBUG_VIRTUAL)  += physaddr.o
> > >>>  KASAN_SANITIZE_physaddr.o    += n
> > >>>
> > >>> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> > >>> index 8d7001712062..73c2151de194 100644
> > >>> --- a/drivers/base/Kconfig
> > >>> +++ b/drivers/base/Kconfig
> > >>> @@ -210,4 +210,10 @@ config GENERIC_ARCH_TOPOLOGY
> > >>>         appropriate scaling, sysfs interface for reading capacity values at
> > >>>         runtime.
> > >>>
> > >>> +config GENERIC_ARCH_NUMA
> > >>> +     bool
> > >>> +     help
> > >>> +       Enable support for generic numa implementation. Currently, RISC-V
> > >>> +       and ARM64 uses it.
> > >>> +
> > >>>  endmenu
> > >>> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> > >>> index 157452080f3d..c3d02c644222 100644
> > >>> --- a/drivers/base/Makefile
> > >>> +++ b/drivers/base/Makefile
> > >>> @@ -23,6 +23,7 @@ obj-$(CONFIG_PINCTRL) += pinctrl.o
> > >>>  obj-$(CONFIG_DEV_COREDUMP) += devcoredump.o
> > >>>  obj-$(CONFIG_GENERIC_MSI_IRQ_DOMAIN) += platform-msi.o
> > >>>  obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
> > >>> +obj-$(CONFIG_GENERIC_ARCH_NUMA) += arch_numa.o
> > >>>
> > >>>  obj-y                        += test/
> > >>>
> > >>> diff --git a/arch/arm64/mm/numa.c b/drivers/base/arch_numa.c
> > >>> similarity index 100%
> > >>> rename from arch/arm64/mm/numa.c
> > >>> rename to drivers/base/arch_numa.c  
> > >>
> > >> drivers/base/ does not seem right place to host generic NUMA code.  
> > >
> > > I chose drivers/base because the common topology code is also present there.
> > > drivers/base/arch_topology.c under GENERIC_ARCH_TOPOLOGY
> > > The idea is to keep all common arch(at least between RISC-V & ARM64)
> > > related code at one place.
> > >  
> > >> Probably it should be either mm/ or kernel/. The other question here  
> > >
> > > I am fine with mm/arch_numa.c as well if that is preferred over driver/base.  
> >
> > GENERIC_ARCH_NUMA being near other shared code such as GENERIC_ARCH_TOPOLOGY
> > do make sense. That being said, its a small nit and can be figured out later.
> >  
> > >  
> > >> would be if existing arm64 NUMA implementation is sufficient enough
> > >> for generic NUMA. I would expect any platform selecting this config
> > >> should get some NUMA enabled, will be that be true with present code ?  
> > >
> > > It is for RISC-V. Here is the RISC-V support patch (last patch in the series)
> > >
> > > http://lists.infradead.org/pipermail/linux-riscv/2020-August/001659.html
> > >  
> >
> > + Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > There is another patch/discussion which is trying to unify ARM64 NUMA init
> > code with X86 (https://patchwork.kernel.org/patch/11651437/). I am wondering
> > if all three platforms could use GENERIC_ARCH_NUMA.
> >  
> 
> Gmail decided to convert my previous reply to HTML for some reason and
> was blocked by the mailing lists.
> Here was my earlier response and apologies for the noise if you
> received it twice.
> 
> That is certainly an awesome goal to achieve. I agree that there are a
> lot of similarities between two implementations
> that can be leveraged under common code. But the current arm64 or x86
> numa implementation
> have also enough differences that  can't just be reused for either.
> This series did not introduce any functional
> difference to arm64 numa code and just moved the existing code between
> files. I don't think that's possible
> for x86 under GENERIC_ARCH_NUMA. It requires a bit more effort to do
> that and I am interested to explore that.
> 
> How about merging this series first and slowly moving pieces of x86
> NUMA code to generic numa code as a separate series ?

I'm in favour of this step wise approach.  We aren't making things worse
by sharing this code between arm64 and riscv other than perhaps needing
to sanity check a few more platforms.

As discussed at Plumbers it might be a tall order to successfully share
all this code with x86 but perhaps there are some parts we can.

Jonathan

> 
> > >> Otherwise it will be difficult to name it as GENERIC_ARCH_NUMA.
> > >>
> > >> _______________________________________________
> > >> linux-riscv mailing list
> > >> linux-riscv@lists.infradead.org
> > >> http://lists.infradead.org/mailman/listinfo/linux-riscv  
> > >
> > >
> > >  
> 
> 
> 


