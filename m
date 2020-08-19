Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B87624A6C3
	for <lists+linux-arch@lfdr.de>; Wed, 19 Aug 2020 21:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgHSTSw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Aug 2020 15:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgHSTSt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Aug 2020 15:18:49 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE91C061757
        for <linux-arch@vger.kernel.org>; Wed, 19 Aug 2020 12:18:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a14so22613618wra.5
        for <linux-arch@vger.kernel.org>; Wed, 19 Aug 2020 12:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IkV7VhnsBdLN5xuM+4/Dxe2A0Bhih4c3yWE1VbJNFHA=;
        b=eznmiXT/ntOWTcbnncE2n/WNhmHddQZEgFJUBCiShFAcFDlu9FzB3r2ycGBZ3UmF3N
         PiinjnQH0SB4qCQRoV/7274AhJc9J9KY+TpaOFTg7ON6MmrpQtRVZdyNNPdw3JKckvVx
         JoK+fssO/3zqRKD1Zplv74ZxQetjyp1iS4yCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IkV7VhnsBdLN5xuM+4/Dxe2A0Bhih4c3yWE1VbJNFHA=;
        b=Iya/OZpSh39PgJOE0jvcHfbwS0H/xPo/4E2XhndfUxiewrHryHGVw0lPC5av6C6Ph1
         WmWdB25ZmPOu4H9A/uolC76wz5IEtctFUMPCm+pcjVR+pGvHW6Ygf4tZQMgqwxhf3wwy
         k6BqQUprHZ+tqhrX9Qg3I44CmCGDCdJwHo15JWeQjzcVgpPWYjk2RkcsddHLaKP9Uv7L
         esvXmWLlgfe7cMZmgc4rHvyK7+i6YFEws3g8+kjjhe2dSzvB4bw1jCiver/mQbeFeZJm
         RkeC/uZ2vUrACG218tr01SQk6EDeMUF8LJSn0d8WACIHzGwkMSCJCgm7PlMITwA4om8U
         29QA==
X-Gm-Message-State: AOAM531ZRWSH0riL4qfcNKTXvxWEc6NXSUTcH85tP6y6oXdKk+5t7kiA
        KYgTf0vveTXW5OvUFTJ89l59RU3AMEogsG0Hxa7S
X-Google-Smtp-Source: ABdhPJwd8eZe43zhhxrKSyHk8/9Xy7z3Xl6wnyt0GLOGhtBxLf3mrLHEx+ftJjVR/96tWAd3U/iDbcJGcHrccbxH9fI=
X-Received: by 2002:adf:f7c3:: with SMTP id a3mr25600526wrq.162.1597864727706;
 Wed, 19 Aug 2020 12:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200814214725.28818-1-atish.patra@wdc.com> <20200814214725.28818-2-atish.patra@wdc.com>
 <2dce83a8-bda4-7664-9661-4e0542eecd57@arm.com>
In-Reply-To: <2dce83a8-bda4-7664-9661-4e0542eecd57@arm.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 19 Aug 2020 12:18:36 -0700
Message-ID: <CAOnJCULbzjsefufgBgonBowgctEqeuLKixskD=5ph8-jUOmM+g@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 1/6] numa: Move numa implementation to common code
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nick Hu <nickhu@andestech.com>, Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Ganapatrao Kulkarni <gkulkarni@cavium.com>,
        Steven Price <steven.price@arm.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 18, 2020 at 8:19 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 08/15/2020 03:17 AM, Atish Patra wrote:
> > ARM64 numa implementation is generic enough that RISC-V can reuse that
> > implementation with very minor cosmetic changes. This will help both
> > ARM64 and RISC-V in terms of maintanace and feature improvement
> >
> > Move the numa implementation code to common directory so that both ISAs
> > can reuse this. This doesn't introduce any function changes for ARM64.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
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
>
> So this introduces a generic NUMA framework selectable with GENERIC_ARCH_NUMA.
>
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
>
> drivers/base/ does not seem right place to host generic NUMA code.

I chose drivers/base because the common topology code is also present there.
drivers/base/arch_topology.c under GENERIC_ARCH_TOPOLOGY
The idea is to keep all common arch(at least between RISC-V & ARM64)
related code at one place.

> Probably it should be either mm/ or kernel/. The other question here

I am fine with mm/arch_numa.c as well if that is preferred over driver/base.

> would be if existing arm64 NUMA implementation is sufficient enough
> for generic NUMA. I would expect any platform selecting this config
> should get some NUMA enabled, will be that be true with present code ?

It is for RISC-V. Here is the RISC-V support patch (last patch in the series)

http://lists.infradead.org/pipermail/linux-riscv/2020-August/001659.html

> Otherwise it will be difficult to name it as GENERIC_ARCH_NUMA.
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
