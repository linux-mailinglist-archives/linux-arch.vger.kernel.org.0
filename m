Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03542563BA
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 02:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgH2Aji (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 20:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgH2Ajg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 20:39:36 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3EDC06121B
        for <linux-arch@vger.kernel.org>; Fri, 28 Aug 2020 17:39:35 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z9so683044wmk.1
        for <linux-arch@vger.kernel.org>; Fri, 28 Aug 2020 17:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HhE6WCMtoODE6GixkR8pydA91xEbZ/J3fzi8jE92LeQ=;
        b=W3VcIZ+WwFndRykg27fx4UwALNDRxc9RatRjzx7ZvrQZe2WZyBz5d9Qk8gbY6k5nP0
         VNVusIAIKoqjHjrvMf0/H2HPGej8mwfncRIL13Axvz2nZKO5BKP3UmCTbH4313mWm4fS
         5YweDpx+M2Y0s/WGcou3WIQ38u9L3DGvBCOmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HhE6WCMtoODE6GixkR8pydA91xEbZ/J3fzi8jE92LeQ=;
        b=B7pq2k020kmo5JRWLN7YJBPhgY9IfFYM1fRgzJ8E1ZtsLcaE/Gl5oH73KlF5RbPSh6
         TS+u7bNmPX6LBqxefHOT9mR60OFnQ5R91EMjEw7dcmuQfp4mW2bJhKxbKYStabUVAUz8
         kgL0u9qwxLciQ5Otsz5GI3Vof8g4F3UhQW7KOCdXoAvT66AOnMo83foLnY8v08DFBLj4
         sE/6oku40VYPh3/Y2od/AYrmhz/eZf170R68Y26vXNCbxwZKjd4Nh+Us9Wz/9VKooPoB
         c05wY4OLdKrbAZ4EFuBMBuvwuNOGmOsHZICBmqHxl8wu5ZcKMe15QEcl/RDehx4bV1wR
         E/YA==
X-Gm-Message-State: AOAM5318voOzpDzElRDBZqic+0TOtOv5UrTieYu6HChz+97arf8ogVwY
        lEpDeVLzGkQ4/LLmIJ3lyyA1Mf0AcfCzpM4R8RHtNWhZA1QP
X-Google-Smtp-Source: ABdhPJyyzPcyXT/pJ4cOLMn/jA4Ed9ckjP4XG70x8Qo1QsCalVaSEPEv/FXZPVLDUHToAstg/Rk4nwyZ89UlQCxSuIM=
X-Received: by 2002:a05:600c:230f:: with SMTP id 15mr1019525wmo.186.1598661573584;
 Fri, 28 Aug 2020 17:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200814214725.28818-1-atish.patra@wdc.com> <20200814214725.28818-3-atish.patra@wdc.com>
 <20200828103552.000033e3@Huawei.com>
In-Reply-To: <20200828103552.000033e3@Huawei.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 28 Aug 2020 17:39:22 -0700
Message-ID: <CAOnJCU+j2DOHdXNz2xZZGX-NcpUDGmaTasYQpMxc7W-31Ha1dQ@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 2/6] arm64, numa: Change the numa init function
 name to be generic
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

On Fri, Aug 28, 2020 at 2:37 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 14 Aug 2020 14:47:21 -0700
> Atish Patra <atish.patra@wdc.com> wrote:
>
> > As we are using generic numa implementation code, modify the init function
> > name to indicate that generic implementation.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  arch/arm64/mm/init.c       | 4 ++--
> >  drivers/base/arch_numa.c   | 8 ++++++--
> >  include/asm-generic/numa.h | 4 ++--
> >  3 files changed, 10 insertions(+), 6 deletions(-)
> >
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
> > index 73f8b49d485c..83341c807240 100644
> > --- a/drivers/base/arch_numa.c
> > +++ b/drivers/base/arch_numa.c
> > @@ -13,7 +13,9 @@
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >
> > +#ifdef CONFIG_ARM64
> >  #include <asm/acpi.h>
> > +#endif
>
> This highlights an issue.  We really don't want to define 'generic' arch
> code then match on individual architectures if at all possible.
>

I agree.

> I'm also not sure we need to.
>
> The arm64_acpi_numa_init() code is just a light wrapper around the
> standard acpi_init() call so should work fine on riscv (once ACPI
> support is ready).
>
> Can we pull that function into here

Sure. We can move the arm64_acpi_numa_init to here and rename it to
arch_acpi_numa_init.
We can keep arch_acpi_numa_init and the acpi.h included under CONFIG_ACPI_NUMA.
If RISC-V becomes ACPI ready one day, they always need to enable
CONFIG_ACPI_NUMA and reuse the generic functions.

> or perhaps a generic arch_numa_acpi.c?
>
There has not been much discussion about ACPI for RISC-V. So moving
the arm64 acpi code now to generic code would be premature
in my opinion. Currently, we don't even know how ACPI will look like
for RISC-V.

> There is probably a bit of a dance needed around acpi_disabled
> though as that can be defined in entirely different places
> depending on whether acpi is enabled or not.
> Possibly just adding an
>
> extern int acpi_disabled to include/linux/acpi.h when acpi is enabled
> will be sufficient (if ugly)?
>

We don't need to do that now unless we are moving arm64 ACPI code
implementation to generic code.
If ACPI is not enabled, it is already defined as a macro in
include/linux/acpi.h.

>
> >  #include <asm/sections.h>
> >
> >  struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
> > @@ -445,16 +447,18 @@ static int __init dummy_numa_init(void)
> >  }
> >
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
> > +#ifdef CONFIG_ARM64
> >               if (!acpi_disabled && !numa_init(arm64_acpi_numa_init))
> >                       return;
> > +#endif
> >               if (acpi_disabled && !numa_init(of_numa_init))
> >                       return;
> >       }
> > diff --git a/include/asm-generic/numa.h b/include/asm-generic/numa.h
> > index 0635c0724b7c..309eca8c0b5d 100644
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
