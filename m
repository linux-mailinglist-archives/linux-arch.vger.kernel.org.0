Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4702736CE
	for <lists+linux-arch@lfdr.de>; Tue, 22 Sep 2020 01:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgIUXub (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Sep 2020 19:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbgIUXua (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Sep 2020 19:50:30 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858D4C061755
        for <linux-arch@vger.kernel.org>; Mon, 21 Sep 2020 16:50:30 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id m6so15038783wrn.0
        for <linux-arch@vger.kernel.org>; Mon, 21 Sep 2020 16:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Y1U9iOOezYjCOoSPo/fvJd1TAyzAwihRmGNwzWZWTg=;
        b=E/KUgl8kVQeaBO5tKkqTMAySFYVmhQ+29OfnU/pcF5XqLDAj3IUqUB7nONZnshcY1c
         HH8iRtQ4ruQX/MPlEpnL9na3p24tSCCkCrFOz167nx/PaxVdCPNFPZCcSTrJmt10Eo1i
         lpRs+tqxJOq8eM8AwWGcWIiN3zFvZsnD2NGaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Y1U9iOOezYjCOoSPo/fvJd1TAyzAwihRmGNwzWZWTg=;
        b=bxys+VtAqnbsDD2CsHZJeIe/qtqWAtvXb88FtFWr3NM8u/CpRUOM+KTImkTFalbG0n
         8Mh+pwcWvwcDTV2lZdl0iJGZ3JAITFgk6Vps6ndOjzQLnoWg+KJ0pNQgoAYG1T8yV+Nh
         V9cGMfBtcE+/Du//qT1e5tXdnMJdoEwJnnPEN02STRziq8G2jFNLJMtGc6LH3wXdtcTy
         hk84hDY+6Wb/HP8ZSJ53zbJhYyUP051XxYotY4XlBa+Zwj/NHR4ym0Rylgd1G6mNjGGL
         wppm3eYQ/WF0VIpUdEbJrzZfIJgcSH07V0i7u695xniZVDlxEQKyPZl4/VfnZ1ffx1xQ
         PlpQ==
X-Gm-Message-State: AOAM532MYbdSJYh4P6AEhlo/0vXOm8zdthrCJc4dO5xDwsQb0Rs+jCLP
        czk+Z/cnppTLmACBamQonBjtPhQy8Hm08SZ6ghDk
X-Google-Smtp-Source: ABdhPJw2IeRlvWLmwCeYs9YRK4GBQmKJ92ij4ToI7a1BmtiQYXkXLov+SRIDwmstOVNyvvPfcdOX9/+PYbjmLndPxnI=
X-Received: by 2002:adf:81c6:: with SMTP id 64mr2135564wra.176.1600732229175;
 Mon, 21 Sep 2020 16:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200918201140.3172284-1-atish.patra@wdc.com> <20200918201140.3172284-3-atish.patra@wdc.com>
 <20200921100131.00005238@Huawei.com>
In-Reply-To: <20200921100131.00005238@Huawei.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 21 Sep 2020 16:50:18 -0700
Message-ID: <CAOnJCUKwn6dh8yuEf__Sr9uKyjTwSJyb8UFJo31-_ZDA_kmOwQ@mail.gmail.com>
Subject: Re: [RFT PATCH v3 2/5] arm64, numa: Change the numa init functions
 name to be generic
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Atish Patra <atish.patra@wdc.com>, linux-arch@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, Arnd Bergmann <arnd@arndb.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anup Patel <anup@brainfault.org>,
        David Hildenbrand <david@redhat.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Steven Price <steven.price@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 21, 2020 at 2:03 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 18 Sep 2020 13:11:37 -0700
> Atish Patra <atish.patra@wdc.com> wrote:
>
> > As we are using generic numa implementation code, modify the acpi & numa
> > init functions name to indicate that generic implementation.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
>
> Other than the double include of linux/acpi.h below this looks good to me.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> > ---
> >  arch/arm64/kernel/acpi_numa.c | 13 -------------
> >  arch/arm64/mm/init.c          |  4 ++--
> >  drivers/base/arch_numa.c      | 31 +++++++++++++++++++++++++++----
> >  include/asm-generic/numa.h    |  4 ++--
> >  4 files changed, 31 insertions(+), 21 deletions(-)
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
> > index 73f8b49d485c..1649c90a3bc5 100644
> > --- a/drivers/base/arch_numa.c
> > +++ b/drivers/base/arch_numa.c
> > @@ -13,7 +13,9 @@
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >
> > -#include <asm/acpi.h>
> > +#ifdef CONFIG_ACPI_NUMA
> > +#include <linux/acpi.h>
> > +#endif
>
> Why do we need this ifdef stuff here?
> In particular acpi_disabled is defined in that header
> in the !CONFIG_ACPI case so seems like we should include it always.
>
> Also given we've just moved arch/arm64/numa.c to become this file,
> it has an include of that header a few lines off the top of this diff anyway.
>
> So I think you can just drop the additional include here.
>

Ahh Yes. Sorry for the oversight. Fixed it.

>
> >  #include <asm/sections.h>
> >
> >  struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
> > @@ -444,16 +446,37 @@ static int __init dummy_numa_init(void)
> >       return 0;
> >  }
> >
> > +#ifdef CONFIG_ACPI_NUMA
> > +static int __init arch_acpi_numa_init(void)
> > +{
> > +     int ret;
> > +
> > +     ret = acpi_numa_init();
> > +     if (ret) {
> > +             pr_info("Failed to initialise from firmware\n");
> > +             return ret;
> > +     }
> > +
> > +     return srat_disabled() ? -EINVAL : 0;
> > +}
> > +#else
> > +static int __init arch_acpi_numa_init(void)
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
