Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA2826A0DC
	for <lists+linux-arch@lfdr.de>; Tue, 15 Sep 2020 10:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgIOI3H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Sep 2020 04:29:07 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2820 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726200AbgIOI3F (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Sep 2020 04:29:05 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 84069BFBFBC69C6223F5;
        Tue, 15 Sep 2020 09:28:58 +0100 (IST)
Received: from localhost (10.52.121.217) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 15 Sep
 2020 09:28:57 +0100
Date:   Tue, 15 Sep 2020 09:27:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Atish Patra <atishp@atishpatra.org>
CC:     Atish Patra <atish.patra@wdc.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>, <linux-arch@vger.kernel.org>,
        Jia He <justin.he@arm.com>, Anup Patel <anup@brainfault.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [RFC/RFT PATCH v2 2/5] arm64, numa: Change the numa init
 function name to be generic
Message-ID: <20200915092720.0000173b@Huawei.com>
In-Reply-To: <CAOnJCUJDk0LnLNwzq5DBogEsO9Ai1Rh10hqbrJjiqJXu0B+Hmw@mail.gmail.com>
References: <20200912013441.9730-1-atish.patra@wdc.com>
        <20200912013441.9730-3-atish.patra@wdc.com>
        <20200914153048.000038ed@Huawei.com>
        <CAOnJCUJDk0LnLNwzq5DBogEsO9Ai1Rh10hqbrJjiqJXu0B+Hmw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.217]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 14 Sep 2020 12:32:41 -0700
Atish Patra <atishp@atishpatra.org> wrote:

> On Mon, Sep 14, 2020 at 7:32 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Fri, 11 Sep 2020 18:34:38 -0700
> > Atish Patra <atish.patra@wdc.com> wrote:
> >  
> > > As we are using generic numa implementation code, modify the init function
> > > name to indicate that generic implementation.
> > >
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>  
> >
> > A few comments inline but more about which layer we do the build protections
> > at than anything important.
> >
> > Thanks,
> >
> > Jonathan
> >  
> > > ---
> > >  arch/arm64/kernel/acpi_numa.c | 13 -------------
> > >  arch/arm64/mm/init.c          |  4 ++--
> > >  drivers/base/arch_numa.c      | 29 ++++++++++++++++++++++++++---
> > >  include/asm-generic/numa.h    |  4 ++--
> > >  4 files changed, 30 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
> > > index 7ff800045434..96502ff92af5 100644
> > > --- a/arch/arm64/kernel/acpi_numa.c
> > > +++ b/arch/arm64/kernel/acpi_numa.c
> > > @@ -117,16 +117,3 @@ void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
> > >
> > >       node_set(node, numa_nodes_parsed);
> > >  }
> > > -
> > > -int __init arm64_acpi_numa_init(void)
> > > -{
> > > -     int ret;
> > > -
> > > -     ret = acpi_numa_init();
> > > -     if (ret) {
> > > -             pr_info("Failed to initialise from firmware\n");
> > > -             return ret;
> > > -     }
> > > -
> > > -     return srat_disabled() ? -EINVAL : 0;
> > > -}
> > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > > index 481d22c32a2e..93b660229e1d 100644
> > > --- a/arch/arm64/mm/init.c
> > > +++ b/arch/arm64/mm/init.c
> > > @@ -418,10 +418,10 @@ void __init bootmem_init(void)
> > >       max_pfn = max_low_pfn = max;
> > >       min_low_pfn = min;
> > >
> > > -     arm64_numa_init();
> > > +     arch_numa_init();
> > >
> > >       /*
> > > -      * must be done after arm64_numa_init() which calls numa_init() to
> > > +      * must be done after arch_numa_init() which calls numa_init() to
> > >        * initialize node_online_map that gets used in hugetlb_cma_reserve()
> > >        * while allocating required CMA size across online nodes.
> > >        */
> > > diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> > > index 73f8b49d485c..a4039dcabd3e 100644
> > > --- a/drivers/base/arch_numa.c
> > > +++ b/drivers/base/arch_numa.c
> > > @@ -13,7 +13,9 @@
> > >  #include <linux/module.h>
> > >  #include <linux/of.h>
> > >
> > > +#ifdef CONFIG_ACPI_NUMA
> > >  #include <asm/acpi.h>
> > > +#endif  
> >
> > Could include linux/acpi.h which I think gets you everything you need in here
> > and has protections against building for non ACPI cases.
> >  
> 
> Sure. will do that.
> 
> > >  #include <asm/sections.h>
> > >
> > >  struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
> > > @@ -444,16 +446,37 @@ static int __init dummy_numa_init(void)
> > >       return 0;
> > >  }
> > >
> > > +#ifdef CONFIG_ACPI_NUMA
> > > +int __init arch_acpi_numa_init(void)
> > > +{
> > > +     int ret;
> > > +
> > > +     ret = acpi_numa_init();  
> >
> > I wonder if this is the correct level at which to stub this out
> > as opposed to providing a stub for acpi_numa_init()
> > and srat_disabled()
> >  
> 
> I guess you mean adding a stub in acpi.h and acpi_numa.h ?
> As it would touch x86 related code as well, I think it is better to do
> it as a followup
> series when we try to unify x86 numa code as well (at least some part of it) ?

It would only affect x86 not using ACPI.  
If that happened, you wouldn't expect it to current call these stubs anyway.

Sure, can leave it for later.

Jonathan

> 
> > At this stage I'm not sure I care too strongly though.
> >  
> > > +     if (ret) {
> > > +             pr_info("Failed to initialise from firmware\n");
> > > +             return ret;
> > > +     }
> > > +
> > > +     return srat_disabled() ? -EINVAL : 0;
> > > +}
> > > +#else
> > > +int __init arch_acpi_numa_init(void)
> > > +{
> > > +     return -EOPNOTSUPP;
> > > +}
> > > +
> > > +#endif
> > > +
> > >  /**
> > > - * arm64_numa_init() - Initialize NUMA
> > > + * arch_numa_init() - Initialize NUMA
> > >   *
> > >   * Try each configured NUMA initialization method until one succeeds. The
> > >   * last fallback is dummy single node config encomapssing whole memory.
> > >   */
> > > -void __init arm64_numa_init(void)
> > > +void __init arch_numa_init(void)
> > >  {
> > >       if (!numa_off) {
> > > -             if (!acpi_disabled && !numa_init(arm64_acpi_numa_init))
> > > +             if (!acpi_disabled && !numa_init(arch_acpi_numa_init))
> > >                       return;
> > >               if (acpi_disabled && !numa_init(of_numa_init))
> > >                       return;
> > > diff --git a/include/asm-generic/numa.h b/include/asm-generic/numa.h
> > > index 2718d5a6ff03..e7962db4ba44 100644
> > > --- a/include/asm-generic/numa.h
> > > +++ b/include/asm-generic/numa.h
> > > @@ -27,7 +27,7 @@ static inline const struct cpumask *cpumask_of_node(int node)
> > >  }
> > >  #endif
> > >
> > > -void __init arm64_numa_init(void);
> > > +void __init arch_numa_init(void);
> > >  int __init numa_add_memblk(int nodeid, u64 start, u64 end);
> > >  void __init numa_set_distance(int from, int to, int distance);
> > >  void __init numa_free_distance(void);
> > > @@ -41,7 +41,7 @@ void numa_remove_cpu(unsigned int cpu);
> > >  static inline void numa_store_cpu_info(unsigned int cpu) { }
> > >  static inline void numa_add_cpu(unsigned int cpu) { }
> > >  static inline void numa_remove_cpu(unsigned int cpu) { }
> > > -static inline void arm64_numa_init(void) { }
> > > +static inline void arch_numa_init(void) { }
> > >  static inline void early_map_cpu_to_node(unsigned int cpu, int nid) { }
> > >
> > >  #endif       /* CONFIG_NUMA */  
> >
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv  
> 
> 
> 


