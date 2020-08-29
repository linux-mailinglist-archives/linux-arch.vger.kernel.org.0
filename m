Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA05F2563EC
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 03:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgH2BMP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 21:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgH2BMN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 21:12:13 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738F9C061264
        for <linux-arch@vger.kernel.org>; Fri, 28 Aug 2020 18:12:12 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b18so713721wrs.7
        for <linux-arch@vger.kernel.org>; Fri, 28 Aug 2020 18:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=39XN9yo1hBG3Se1gfQYF3vziZZPdblGeQ4oQR1sH/O8=;
        b=UgCNc6zV3jHlrg/Fv8Pd/IrqWUk206ZSYfkd1Atuw6CbnwlSWhIo20Ev2bp0NzbxNE
         5+Oqahty8CR5kwHAXEbFaKD1X/femDV4haD3dBHW5mwpqzOGgAoCxqHujgVFfx1UHLfQ
         DbN1P+h/aae5Xy6kl9NPJkMdJU0rMyidTucdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39XN9yo1hBG3Se1gfQYF3vziZZPdblGeQ4oQR1sH/O8=;
        b=jiDIDu/O9hNqtEggYyb3EsCc3ZQEMwIduKjqzLmH1E6ZgwE5hZBD4sft+yVTWpZrFR
         Qs15lDRBMvGHm0XkK+3J/HbGM22ZCUxe4pOC77FuUhOC7NHkFVdc353mO5HcrYCYkVmS
         wHs97b1gD/7aBUly07CNdge18LyutDdmy1uejoV1wag0CxnUR33nbKNinW2COiNnjalJ
         OaOnYwP/b2kx22XcbyafeWdd3dWzhtLDqgSyaqcJuYwhERApfPVjMo+gTaNp1acOkvsA
         /Z3PyDrKAzqqO3px+vgJpyFUplXaiix0Fv004m09EJK6n1PrBnCV9eGPe5K1JoC9H9b5
         5+/g==
X-Gm-Message-State: AOAM531JrAQy5yscA9b2eG7pkfIZNmpHVXaf9J5dMf8b34FgwXhB0ISw
        kbn2ZFw6jxHSLbiugZ8mPUWzcsihcA7ewX4A+QFU
X-Google-Smtp-Source: ABdhPJzw5EtgUVJ3RG403SG6FcBlDty/Ese8S3VaJefPy33FqMxh5pEHcZSuvxcoiYJMWxt5uOMYBnTEwf6FImhkxMA=
X-Received: by 2002:adf:e411:: with SMTP id g17mr1444394wrm.77.1598663531166;
 Fri, 28 Aug 2020 18:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200828104830.000007bf@Huawei.com> <20200828161523.GA2158345@bjorn-Precision-5520>
In-Reply-To: <20200828161523.GA2158345@bjorn-Precision-5520>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 28 Aug 2020 18:11:50 -0700
Message-ID: <CAOnJCULtHzQKJNE4OO_U2NMaW6pX38Pw7dLywGc9og1BuuAYNQ@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 3/6] arm64, numa: Move pcibus_to_node definition
 to generic numa code
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ganapatrao Kulkarni <gkulkarni@cavium.com>,
        Steven Price <steven.price@arm.com>, linux-pci@vger.kernel.org,
        Greentime Hu <greentime.hu@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
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

On Fri, Aug 28, 2020 at 9:15 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Aug 28, 2020 at 10:48:30AM +0100, Jonathan Cameron wrote:
> > On Fri, 14 Aug 2020 14:47:22 -0700
> > Atish Patra <atish.patra@wdc.com> wrote:
> >
> > > pcibus_to_node is used only when numa is enabled and does not depend
> > > on ISA. Thus, it can be moved the generic numa implementation.
> > >
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> >
> > From a more general unification point of view, there seem to
> > be two ways architectures implement this.
> > Either
> >
> > bus->sysdata.node
> >
> > Or as here.
> > There are weird other options, but let us ignore those :)
> >
> > That is going to take a bit of unwinding should we
> > want to take this unification further and perhaps we want to think
> > about doing this in pci generic code rather than here?
> >
> > Perhaps this is one we are better keeping architecture specific for
> > now?
> >
> > +CC Bjorn and Linux-pci
> >
> >
> > > ---
> > >  arch/arm64/kernel/pci.c  | 10 ----------
> > >  drivers/base/arch_numa.c | 11 +++++++++++
> > >  2 files changed, 11 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> > > index 1006ed2d7c60..07c122946c11 100644
> > > --- a/arch/arm64/kernel/pci.c
> > > +++ b/arch/arm64/kernel/pci.c
> > > @@ -54,16 +54,6 @@ int raw_pci_write(unsigned int domain, unsigned int bus,
> > >     return b->ops->write(b, devfn, reg, len, val);
> > >  }
> > >
> > > -#ifdef CONFIG_NUMA
> > > -
> > > -int pcibus_to_node(struct pci_bus *bus)
> > > -{
> > > -   return dev_to_node(&bus->dev);
> > > -}
> > > -EXPORT_SYMBOL(pcibus_to_node);
> > > -
> > > -#endif
> > > -
> > >  #ifdef CONFIG_ACPI
> > >
> > >  struct acpi_pci_generic_root_info {
> > > diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> > > index 83341c807240..4ab1b20a615d 100644
> > > --- a/drivers/base/arch_numa.c
> > > +++ b/drivers/base/arch_numa.c
> > > @@ -11,6 +11,7 @@
> > >  #include <linux/acpi.h>
> > >  #include <linux/memblock.h>
> > >  #include <linux/module.h>
> > > +#include <linux/pci.h>
> > >  #include <linux/of.h>
> > >
> > >  #ifdef CONFIG_ARM64
> > > @@ -60,6 +61,16 @@ EXPORT_SYMBOL(cpumask_of_node);
> > >
> > >  #endif
> > >
> > > +#ifdef CONFIG_PCI
> > > +
> > > +int pcibus_to_node(struct pci_bus *bus)
> > > +{
> > > +   return dev_to_node(&bus->dev);
> > > +}
> > > +EXPORT_SYMBOL(pcibus_to_node);
> > > +
> > > +#endif
>
> I certainly agree that this should not be arch-specific, but I'm not
> really in favor of adding this PCI gunk in drivers/base.
>
> I think we can do better (eventually) by getting rid of
> pcibus_to_node() completely.  It's not used very much except by
> cpumask_of_pcibus(), which itself is hardly used at all.
>
I am a bit confused here. A quick grep suggested that pcibus_to_node()
is also called from generic pci probe,
controller and few drivers(block, infiniband) as well. Maybe I am
missing something here ?

We can move the pcibus_to_node to arch specific code for now if that's
what is preferred.

> > >  static void numa_update_cpu(unsigned int cpu, bool remove)
> > >  {
> > >     int nid = cpu_to_node(cpu);
> >
> >
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



--
Regards,
Atish
