Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507B52695AA
	for <lists+linux-arch@lfdr.de>; Mon, 14 Sep 2020 21:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgINTdA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Sep 2020 15:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgINTcy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Sep 2020 15:32:54 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0594BC061788
        for <linux-arch@vger.kernel.org>; Mon, 14 Sep 2020 12:32:53 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t10so890005wrv.1
        for <linux-arch@vger.kernel.org>; Mon, 14 Sep 2020 12:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Us7lcvMi6/juANI567+eDOv0NC7aDZ1rCBImYBzCjjY=;
        b=RMhLNj4hwDp/sij+u7Xt0WzbDyZJ7KkwOKYMFTc+T6IDeM4seqg4eQ8D32XXFeiVU4
         fIgCy7kd2vK5cILMkAwq5hkdhEJb/3AtJ3lPC31s0bREHNpT/LWAnpoZMC+tQ56W7iaV
         YTTBPkqZ3PG79DD8M/+ks+qCnZgtGpPhTpb1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Us7lcvMi6/juANI567+eDOv0NC7aDZ1rCBImYBzCjjY=;
        b=UhDIbfWKEGNG9fHtUUwwZ5LPATwnTMGdKA4m2LP7N/yNCaoJzDCmYkMkkSLF9/sm7R
         yaDqp0f5KYoRNp3NXUgo9OqT3rHCs6/JtswmMGG1kz4b7PX457FQHc3/tfDkg0d1d4QZ
         ZJEHnXD0G6OWKGOqqgs3NbppqBvlPU1opgnCUGywFMkRh+9BF9jGGwD25w8IPfCuuoLz
         F2B2h90eMBLIX/HRMFsJPQvDwFpHoab4elkT/6xz/wlNEyKOImoekNKZc0Ci6GPIpEYO
         Ni5ldnPydDEfJ9yxyAiM+q9UIlyGFc8W4OWW3RF01+MZwDAh1WeWUw1DGO94nKV7jyp+
         9e4w==
X-Gm-Message-State: AOAM531VZTXjaNUtfHsuYhMsjxxTiuXdgsphN7Xg2HVfOWHckZHTuI4e
        J6vbvXUcU9IcFOfUDjGy0/oDdtMgA6G5NVLhZqQd
X-Google-Smtp-Source: ABdhPJwr2e01SFAfRKittjeu8Yn4CtQYGSBGeU9WwDQLbg3IArfSGvyE9PL+h3E8H8MOGruD0+/Q607ecqEl1/UDI6M=
X-Received: by 2002:a5d:4bcf:: with SMTP id l15mr17380744wrt.384.1600111972296;
 Mon, 14 Sep 2020 12:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200912013441.9730-1-atish.patra@wdc.com> <20200912013441.9730-3-atish.patra@wdc.com>
 <20200914153048.000038ed@Huawei.com>
In-Reply-To: <20200914153048.000038ed@Huawei.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 14 Sep 2020 12:32:41 -0700
Message-ID: <CAOnJCUJDk0LnLNwzq5DBogEsO9Ai1Rh10hqbrJjiqJXu0B+Hmw@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH v2 2/5] arm64, numa: Change the numa init function
 name to be generic
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        Jia He <justin.he@arm.com>, Anup Patel <anup@brainfault.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 14, 2020 at 7:32 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 11 Sep 2020 18:34:38 -0700
> Atish Patra <atish.patra@wdc.com> wrote:
>
> > As we are using generic numa implementation code, modify the init function
> > name to indicate that generic implementation.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
>
> A few comments inline but more about which layer we do the build protections
> at than anything important.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  arch/arm64/kernel/acpi_numa.c | 13 -------------
> >  arch/arm64/mm/init.c          |  4 ++--
> >  drivers/base/arch_numa.c      | 29 ++++++++++++++++++++++++++---
> >  include/asm-generic/numa.h    |  4 ++--
> >  4 files changed, 30 insertions(+), 20 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
> > index 7ff800045434..96502ff92af5 100644
> > --- a/arch/arm64/kernel/acpi_numa.c
> > +++ b/arch/arm64/kernel/acpi_numa.c
> > @@ -117,16 +117,3 @@ void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
> >
> >       node_set(node, numa_nodes_parsed);
> >  }
> > -
> > -int __init arm64_acpi_numa_init(void)
> > -{
> > -     int ret;
> > -
> > -     ret = acpi_numa_init();
> > -     if (ret) {
> > -             pr_info("Failed to initialise from firmware\n");
> > -             return ret;
> > -     }
> > -
> > -     return srat_disabled() ? -EINVAL : 0;
> > -}
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 481d22c32a2e..93b660229e1d 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -418,10 +418,10 @@ void __init bootmem_init(void)
> >       max_pfn = max_low_pfn = max;
> >       min_low_pfn = min;
> >
> > -     arm64_numa_init();
> > +     arch_numa_init();
> >
> >       /*
> > -      * must be done after arm64_numa_init() which calls numa_init() to
> > +      * must be done after arch_numa_init() which calls numa_init() to
> >        * initialize node_online_map that gets used in hugetlb_cma_reserve()
> >        * while allocating required CMA size across online nodes.
> >        */
> > diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> > index 73f8b49d485c..a4039dcabd3e 100644
> > --- a/drivers/base/arch_numa.c
> > +++ b/drivers/base/arch_numa.c
> > @@ -13,7 +13,9 @@
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >
> > +#ifdef CONFIG_ACPI_NUMA
> >  #include <asm/acpi.h>
> > +#endif
>
> Could include linux/acpi.h which I think gets you everything you need in here
> and has protections against building for non ACPI cases.
>

Sure. will do that.

> >  #include <asm/sections.h>
> >
> >  struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
> > @@ -444,16 +446,37 @@ static int __init dummy_numa_init(void)
> >       return 0;
> >  }
> >
> > +#ifdef CONFIG_ACPI_NUMA
> > +int __init arch_acpi_numa_init(void)
> > +{
> > +     int ret;
> > +
> > +     ret = acpi_numa_init();
>
> I wonder if this is the correct level at which to stub this out
> as opposed to providing a stub for acpi_numa_init()
> and srat_disabled()
>

I guess you mean adding a stub in acpi.h and acpi_numa.h ?
As it would touch x86 related code as well, I think it is better to do
it as a followup
series when we try to unify x86 numa code as well (at least some part of it) ?

> At this stage I'm not sure I care too strongly though.
>
> > +     if (ret) {
> > +             pr_info("Failed to initialise from firmware\n");
> > +             return ret;
> > +     }
> > +
> > +     return srat_disabled() ? -EINVAL : 0;
> > +}
> > +#else
> > +int __init arch_acpi_numa_init(void)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> > +
> > +#endif
> > +
> >  /**
> > - * arm64_numa_init() - Initialize NUMA
> > + * arch_numa_init() - Initialize NUMA
> >   *
> >   * Try each configured NUMA initialization method until one succeeds. The
> >   * last fallback is dummy single node config encomapssing whole memory.
> >   */
> > -void __init arm64_numa_init(void)
> > +void __init arch_numa_init(void)
> >  {
> >       if (!numa_off) {
> > -             if (!acpi_disabled && !numa_init(arm64_acpi_numa_init))
> > +             if (!acpi_disabled && !numa_init(arch_acpi_numa_init))
> >                       return;
> >               if (acpi_disabled && !numa_init(of_numa_init))
> >                       return;
> > diff --git a/include/asm-generic/numa.h b/include/asm-generic/numa.h
> > index 2718d5a6ff03..e7962db4ba44 100644
> > --- a/include/asm-generic/numa.h
> > +++ b/include/asm-generic/numa.h
> > @@ -27,7 +27,7 @@ static inline const struct cpumask *cpumask_of_node(int node)
> >  }
> >  #endif
> >
> > -void __init arm64_numa_init(void);
> > +void __init arch_numa_init(void);
> >  int __init numa_add_memblk(int nodeid, u64 start, u64 end);
> >  void __init numa_set_distance(int from, int to, int distance);
> >  void __init numa_free_distance(void);
> > @@ -41,7 +41,7 @@ void numa_remove_cpu(unsigned int cpu);
> >  static inline void numa_store_cpu_info(unsigned int cpu) { }
> >  static inline void numa_add_cpu(unsigned int cpu) { }
> >  static inline void numa_remove_cpu(unsigned int cpu) { }
> > -static inline void arm64_numa_init(void) { }
> > +static inline void arch_numa_init(void) { }
> >  static inline void early_map_cpu_to_node(unsigned int cpu, int nid) { }
> >
> >  #endif       /* CONFIG_NUMA */
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
