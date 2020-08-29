Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FBC2563AF
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 02:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgH2AcN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 20:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgH2AcK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 20:32:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D798C061264
        for <linux-arch@vger.kernel.org>; Fri, 28 Aug 2020 17:32:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c15so648107wrs.11
        for <linux-arch@vger.kernel.org>; Fri, 28 Aug 2020 17:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EnuZn/M2lzAJWyAIXtLX4M4QtFwlZSSzh146mAOXAjk=;
        b=sTC4ij59BsYkVreq5DVgZaFYoXHncgMbX2v+R8885l+xH2JQGoWh6OXFM4c/H6D5DX
         AKBM7ooUQ/cBWmSM3I3rHv93e+QMndKakD3tL678T/kDW+C3hpP1JnxL5JVd2bRvKo6Q
         8XVH7eKWG9nUItp2tiIw+mTk8LYyb8z7mod4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EnuZn/M2lzAJWyAIXtLX4M4QtFwlZSSzh146mAOXAjk=;
        b=fGdZjHLWpX4Innq62LiOfU0tVtE/4hAgeVIhemPjurqwXULeJo8sQxygCNas0QCr09
         mwJEfoF8dXxZToFeL78CHViL7XaraPLAZy/JIJv/lYYklxxTJIK0hvoXEUCDDJCy3axY
         Tn5f+0gWFKPFYS3ELBsDOrcN/+HKDpf0c2DotIpG6Dg5ytwFFGw7Z9gcREO8otQjLsf9
         JGpGPq2mapYndQ2ebZ+yVYSfTtYoN9TOUnks8DEi8Sa2HISBRxlZ/WAdCj0uhh33CPUB
         NsIsAj/qUdrIzO4YktFwi6/EseUX0UFGCsw+CKdOi17SUiD9V2fCN5n7QtLZ+W61qas1
         87PA==
X-Gm-Message-State: AOAM532traI2ydvZ0ME8Wto4yYmwdY7nX3CMw2880G0yGtXMxRxhLhbT
        0wdcI1zILvROx1GfEdREYMx4MgzXehBkWwfWpKma
X-Google-Smtp-Source: ABdhPJx40JH8GqHxHD/A5mY8HvJho+at1dJwD96NVwF6YY9Iao+1NQ8Z2Zv6cBNn3NDdO9FyHOExM6NtWNrii+npYZ8=
X-Received: by 2002:adf:f7c3:: with SMTP id a3mr1233550wrq.162.1598661128695;
 Fri, 28 Aug 2020 17:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200814214725.28818-1-atish.patra@wdc.com> <20200814214725.28818-2-atish.patra@wdc.com>
 <20200828102233.00006ef4@Huawei.com>
In-Reply-To: <20200828102233.00006ef4@Huawei.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 28 Aug 2020 17:31:57 -0700
Message-ID: <CAOnJCUJn7=ufw1rjyZesLSki+KZDX5c5KbwGNo8-EeXTQkMxoQ@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 1/6] numa: Move numa implementation to common code
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ganapatrao Kulkarni <gkulkarni@cavium.com>,
        Steven Price <steven.price@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Nick Hu <nickhu@andestech.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 28, 2020 at 2:24 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 14 Aug 2020 14:47:20 -0700
> Atish Patra <atish.patra@wdc.com> wrote:
>
> > ARM64 numa implementation is generic enough that RISC-V can reuse that
> > implementation with very minor cosmetic changes. This will help both
> > ARM64 and RISC-V in terms of maintanace and feature improvement
> >
> > Move the numa implementation code to common directory so that both ISAs
> > can reuse this. This doesn't introduce any function changes for ARM64.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Hi Atish,
>
> One trivial question inline.  Otherwise subject to Anshuman's point about
> location, this looks fine to me.
>
> I'll run some sanity checks later.
>
> Jonathan
> > ---
> >  arch/arm64/Kconfig                            |  1 +
> >  arch/arm64/include/asm/numa.h                 | 45 +---------------
> >  arch/arm64/mm/Makefile                        |  1 -
> >  drivers/base/Kconfig                          |  6 +++
> >  drivers/base/Makefile                         |  1 +
> >  .../mm/numa.c => drivers/base/arch_numa.c     |  0
> >  include/asm-generic/numa.h                    | 51 +++++++++++++++++++
> >  7 files changed, 60 insertions(+), 45 deletions(-)
> >  rename arch/arm64/mm/numa.c => drivers/base/arch_numa.c (100%)
> >  create mode 100644 include/asm-generic/numa.h
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 6d232837cbee..955a0cf75b16 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -960,6 +960,7 @@ config HOTPLUG_CPU
> >  # Common NUMA Features
> >  config NUMA
> >       bool "NUMA Memory Allocation and Scheduler Support"
> > +     select GENERIC_ARCH_NUMA
> >       select ACPI_NUMA if ACPI
> >       select OF_NUMA
> >       help
> > diff --git a/arch/arm64/include/asm/numa.h b/arch/arm64/include/asm/numa.h
> > index 626ad01e83bf..8c8cf4297cc3 100644
> > --- a/arch/arm64/include/asm/numa.h
> > +++ b/arch/arm64/include/asm/numa.h
> > @@ -3,49 +3,6 @@
> >  #define __ASM_NUMA_H
> >
> >  #include <asm/topology.h>
> > -
> > -#ifdef CONFIG_NUMA
> > -
> > -#define NR_NODE_MEMBLKS              (MAX_NUMNODES * 2)
> > -
> > -int __node_distance(int from, int to);
> > -#define node_distance(a, b) __node_distance(a, b)
> > -
> > -extern nodemask_t numa_nodes_parsed __initdata;
> > -
> > -extern bool numa_off;
> > -
> > -/* Mappings between node number and cpus on that node. */
> > -extern cpumask_var_t node_to_cpumask_map[MAX_NUMNODES];
> > -void numa_clear_node(unsigned int cpu);
> > -
> > -#ifdef CONFIG_DEBUG_PER_CPU_MAPS
> > -const struct cpumask *cpumask_of_node(int node);
> > -#else
> > -/* Returns a pointer to the cpumask of CPUs on Node 'node'. */
> > -static inline const struct cpumask *cpumask_of_node(int node)
> > -{
> > -     return node_to_cpumask_map[node];
> > -}
> > -#endif
> > -
> > -void __init arm64_numa_init(void);
> > -int __init numa_add_memblk(int nodeid, u64 start, u64 end);
> > -void __init numa_set_distance(int from, int to, int distance);
> > -void __init numa_free_distance(void);
> > -void __init early_map_cpu_to_node(unsigned int cpu, int nid);
> > -void numa_store_cpu_info(unsigned int cpu);
> > -void numa_add_cpu(unsigned int cpu);
> > -void numa_remove_cpu(unsigned int cpu);
> > -
> > -#else        /* CONFIG_NUMA */
> > -
> > -static inline void numa_store_cpu_info(unsigned int cpu) { }
> > -static inline void numa_add_cpu(unsigned int cpu) { }
> > -static inline void numa_remove_cpu(unsigned int cpu) { }
> > -static inline void arm64_numa_init(void) { }
> > -static inline void early_map_cpu_to_node(unsigned int cpu, int nid) { }
> > -
> > -#endif       /* CONFIG_NUMA */
> > +#include <asm-generic/numa.h>
> >
> >  #endif       /* __ASM_NUMA_H */
> > diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
> > index d91030f0ffee..928c308b044b 100644
> > --- a/arch/arm64/mm/Makefile
> > +++ b/arch/arm64/mm/Makefile
> > @@ -6,7 +6,6 @@ obj-y                         := dma-mapping.o extable.o fault.o init.o \
> >  obj-$(CONFIG_HUGETLB_PAGE)   += hugetlbpage.o
> >  obj-$(CONFIG_PTDUMP_CORE)    += dump.o
> >  obj-$(CONFIG_PTDUMP_DEBUGFS) += ptdump_debugfs.o
> > -obj-$(CONFIG_NUMA)           += numa.o
> >  obj-$(CONFIG_DEBUG_VIRTUAL)  += physaddr.o
> >  KASAN_SANITIZE_physaddr.o    += n
> >
> > diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> > index 8d7001712062..73c2151de194 100644
> > --- a/drivers/base/Kconfig
> > +++ b/drivers/base/Kconfig
> > @@ -210,4 +210,10 @@ config GENERIC_ARCH_TOPOLOGY
> >         appropriate scaling, sysfs interface for reading capacity values at
> >         runtime.
> >
> > +config GENERIC_ARCH_NUMA
> > +     bool
> > +     help
> > +       Enable support for generic numa implementation. Currently, RISC-V
> > +       and ARM64 uses it.
> > +
> >  endmenu
> > diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> > index 157452080f3d..c3d02c644222 100644
> > --- a/drivers/base/Makefile
> > +++ b/drivers/base/Makefile
> > @@ -23,6 +23,7 @@ obj-$(CONFIG_PINCTRL) += pinctrl.o
> >  obj-$(CONFIG_DEV_COREDUMP) += devcoredump.o
> >  obj-$(CONFIG_GENERIC_MSI_IRQ_DOMAIN) += platform-msi.o
> >  obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
> > +obj-$(CONFIG_GENERIC_ARCH_NUMA) += arch_numa.o
> >
> >  obj-y                        += test/
> >
> > diff --git a/arch/arm64/mm/numa.c b/drivers/base/arch_numa.c
> > similarity index 100%
> > rename from arch/arm64/mm/numa.c
> > rename to drivers/base/arch_numa.c
> > diff --git a/include/asm-generic/numa.h b/include/asm-generic/numa.h
> > new file mode 100644
> > index 000000000000..0635c0724b7c
> > --- /dev/null
> > +++ b/include/asm-generic/numa.h
> > @@ -0,0 +1,51 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __ASM_GENERIC_NUMA_H
> > +#define __ASM_GENERIC_NUMA_H
> > +
> > +#ifdef CONFIG_NUMA
> > +
> > +#define NR_NODE_MEMBLKS              (MAX_NUMNODES * 2)
> > +
> > +int __node_distance(int from, int to);
> > +#define node_distance(a, b) __node_distance(a, b)
> > +
> > +extern nodemask_t numa_nodes_parsed __initdata;
> > +
> > +extern bool numa_off;
> > +
> > +/* Mappings between node number and cpus on that node. */
> > +extern cpumask_var_t node_to_cpumask_map[MAX_NUMNODES];
> > +void numa_clear_node(unsigned int cpu);
> > +
> > +#ifdef CONFIG_DEBUG_PER_CPU_MAPS
> > +const struct cpumask *cpumask_of_node(int node);
> > +#else
> > +/* Returns a pointer to the cpumask of CPUs on Node 'node'. */
> > +static inline const struct cpumask *cpumask_of_node(int node)
> > +{
> > +     return node_to_cpumask_map[node];
> > +}
> > +#endif
> > +
> > +void __init arm64_numa_init(void);
> > +int __init numa_add_memblk(int nodeid, u64 start, u64 end);
> > +void __init numa_set_distance(int from, int to, int distance);
> > +void __init numa_free_distance(void);
> > +void __init early_map_cpu_to_node(unsigned int cpu, int nid);
> > +void numa_store_cpu_info(unsigned int cpu);
> > +void numa_add_cpu(unsigned int cpu);
> > +void numa_remove_cpu(unsigned int cpu);
> > +
> > +#else        /* CONFIG_NUMA */
> > +
> > +static inline void numa_store_cpu_info(unsigned int cpu) { }
> > +static inline void numa_add_cpu(unsigned int cpu) { }
> > +static inline void numa_remove_cpu(unsigned int cpu) { }
> > +static inline void arm64_numa_init(void) { }
> > +static inline void early_map_cpu_to_node(unsigned int cpu, int nid) { }
> > +
> > +#endif       /* CONFIG_NUMA */
> > +
> > +#include <asm/topology.h>
>
> Why the include here?
>

Sorry. This was a spillover from the previous patch. Thanks for catching it.
I will fix it in v2.
> > +
> > +#endif       /* __ASM_GENERIC_NUMA_H */
>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
