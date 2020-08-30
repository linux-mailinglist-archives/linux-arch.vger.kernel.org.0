Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC492256C88
	for <lists+linux-arch@lfdr.de>; Sun, 30 Aug 2020 09:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgH3HWj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Aug 2020 03:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgH3HWh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 30 Aug 2020 03:22:37 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A91C061573
        for <linux-arch@vger.kernel.org>; Sun, 30 Aug 2020 00:22:36 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q9so2641519wmj.2
        for <linux-arch@vger.kernel.org>; Sun, 30 Aug 2020 00:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4opMeD0irkmL+H/7a2xU8cjZEUDcxPJmk8YZgecU11U=;
        b=ev41B5EFXjL0HxofoOjttHQ6QGEn6veUb6kOs0Ns242BN1OiMhySf9H/hh07Qnpbkg
         MMpLIVSS65ZDgDHIx7PElFL0cBpwbRgELXBC7jdMB0bsznVUrSRYgX1ja2svjiYa/Pf/
         oxnXESGpn2lQhS8u6tRI8ir0+iNweFG5aY838=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4opMeD0irkmL+H/7a2xU8cjZEUDcxPJmk8YZgecU11U=;
        b=s+DgnqaNJw8UBpYNxMU4dOlxeURVO+YbknSvgatIzXI/9wkPfby5qBULMrIzbSKcxC
         8wj2BSm6jEijVUIOsCt9oK0HEz0No1iqhrqigkvhPc1uVoHfVjDDE+TnEoFJM8N8oUwO
         M5tg2U2A+InANJFXcEY9RTAJGMRzVUpWbqTjxQQkjQQASBSfeB0NSohuXda+eDyx2eNE
         Tj/ej3bpqtwdxhy7PZL0eHr5j5wmIUwofKI/3LPpJAepbP1i2EYkBtINVePxc3/ji4UI
         brvQIfyTBmrN6/3YCAat++pz9PsuJrTkNSCzHXNbS5KQYypl8k29yqRyIJc4BqwpxJT3
         KhEA==
X-Gm-Message-State: AOAM5322hYiLud/wQYSFpsZQZ0/8TuOT7/827WRApDBEBuU8/98ErFGn
        8dHdIsdW3ToRtMVbvI8xVm2TvL8k8qZloVPuOZn5SkielZQ6
X-Google-Smtp-Source: ABdhPJzQzOQBHc1leDOQrEXNb0qMTYMct/i4koF+5cCOM/9s3foq/y8nV/Q1mKIYmeHaHIuX7z9qqfUoyU2G3WRZDWc=
X-Received: by 2002:a05:600c:230f:: with SMTP id 15mr5945544wmo.186.1598772155263;
 Sun, 30 Aug 2020 00:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAOnJCULtHzQKJNE4OO_U2NMaW6pX38Pw7dLywGc9og1BuuAYNQ@mail.gmail.com>
 <20200830025438.GA9624@bjorn-Precision-5520>
In-Reply-To: <20200830025438.GA9624@bjorn-Precision-5520>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Sun, 30 Aug 2020 00:22:24 -0700
Message-ID: <CAOnJCU+-=_Tjm1Wc8se1moTa7fJxzJJafiw=My7mPLBmszwccQ@mail.gmail.com>
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

On Sat, Aug 29, 2020 at 7:54 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Aug 28, 2020 at 06:11:50PM -0700, Atish Patra wrote:
> > On Fri, Aug 28, 2020 at 9:15 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Fri, Aug 28, 2020 at 10:48:30AM +0100, Jonathan Cameron wrote:
> > > > On Fri, 14 Aug 2020 14:47:22 -0700
> > > > Atish Patra <atish.patra@wdc.com> wrote:
> > > >
> > > > > pcibus_to_node is used only when numa is enabled and does not depend
> > > > > on ISA. Thus, it can be moved the generic numa implementation.
> > > > >
> > > > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > >
> > > > From a more general unification point of view, there seem to
> > > > be two ways architectures implement this.
> > > > Either
> > > >
> > > > bus->sysdata.node
> > > >
> > > > Or as here.
> > > > There are weird other options, but let us ignore those :)
> > > >
> > > > That is going to take a bit of unwinding should we
> > > > want to take this unification further and perhaps we want to think
> > > > about doing this in pci generic code rather than here?
> > > >
> > > > Perhaps this is one we are better keeping architecture specific for
> > > > now?
> > > >
> > > > +CC Bjorn and Linux-pci
> > > >
> > > >
> > > > > ---
> > > > >  arch/arm64/kernel/pci.c  | 10 ----------
> > > > >  drivers/base/arch_numa.c | 11 +++++++++++
> > > > >  2 files changed, 11 insertions(+), 10 deletions(-)
> > > > >
> > > > > diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> > > > > index 1006ed2d7c60..07c122946c11 100644
> > > > > --- a/arch/arm64/kernel/pci.c
> > > > > +++ b/arch/arm64/kernel/pci.c
> > > > > @@ -54,16 +54,6 @@ int raw_pci_write(unsigned int domain, unsigned int bus,
> > > > >     return b->ops->write(b, devfn, reg, len, val);
> > > > >  }
> > > > >
> > > > > -#ifdef CONFIG_NUMA
> > > > > -
> > > > > -int pcibus_to_node(struct pci_bus *bus)
> > > > > -{
> > > > > -   return dev_to_node(&bus->dev);
> > > > > -}
> > > > > -EXPORT_SYMBOL(pcibus_to_node);
> > > > > -
> > > > > -#endif
> > > > > -
> > > > >  #ifdef CONFIG_ACPI
> > > > >
> > > > >  struct acpi_pci_generic_root_info {
> > > > > diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> > > > > index 83341c807240..4ab1b20a615d 100644
> > > > > --- a/drivers/base/arch_numa.c
> > > > > +++ b/drivers/base/arch_numa.c
> > > > > @@ -11,6 +11,7 @@
> > > > >  #include <linux/acpi.h>
> > > > >  #include <linux/memblock.h>
> > > > >  #include <linux/module.h>
> > > > > +#include <linux/pci.h>
> > > > >  #include <linux/of.h>
> > > > >
> > > > >  #ifdef CONFIG_ARM64
> > > > > @@ -60,6 +61,16 @@ EXPORT_SYMBOL(cpumask_of_node);
> > > > >
> > > > >  #endif
> > > > >
> > > > > +#ifdef CONFIG_PCI
> > > > > +
> > > > > +int pcibus_to_node(struct pci_bus *bus)
> > > > > +{
> > > > > +   return dev_to_node(&bus->dev);
> > > > > +}
> > > > > +EXPORT_SYMBOL(pcibus_to_node);
> > > > > +
> > > > > +#endif
> > >
> > > I certainly agree that this should not be arch-specific, but I'm not
> > > really in favor of adding this PCI gunk in drivers/base.
> > >
> > > I think we can do better (eventually) by getting rid of
> > > pcibus_to_node() completely.  It's not used very much except by
> > > cpumask_of_pcibus(), which itself is hardly used at all.
> > >
> > I am a bit confused here. A quick grep suggested that pcibus_to_node()
> > is also called from generic pci probe,
> > controller and few drivers(block, infiniband) as well. Maybe I am
> > missing something here ?
>
> I didn't say it was *only* used by cpumask_of_pcibus().  13 of the 29
> calls are from cpumask_of_pcibus().
>
Ahh okay. Sorry I misunderstood that.

> As you point out, there are a few drivers that use it.  They typically
> have a pci_dev, so they do the equivalent of pcibus_to_node(pdev->bus).
> That seems silly; they should just do dev_to_node(&pdev->dev) instead.
>

That covers the use case for ARM64. There are other arch implementations
as well which retrieve node information from sysdata which seems to be
type casted to different structures on different arch.
What should be done for those ?

> I looked at this once, and it seems like there might have been a
> wrinkle like the pdev->dev node not being set correctly or something.
> If that's the case, I think it should be fixed.
>
> > We can move the pcibus_to_node to arch specific code for now if that's
> > what is preferred.
>
> Now I'm the one who's confused :)  Most arches, including arm64,
> already have arch-specific implementations of pcibus_to_node().  I
> didn't look at the rest of the series to see if there's a reason you
> need to move pcibus_to_node() from arch/arm64/kernel/pci.c to
> drivers//base/arch_numa.c.  If you don't need to, I would just leave
> it where it is.
>

The reason I moved it from arch/arm64/kernel/pci.c to drivers//base/arch_numa.c.
so that we don't have to define it for RISC-V. But it's just a single
line function and
we can define it in RISC-V as well. I will try that in v2.

> > > > >  static void numa_update_cpu(unsigned int cpu, bool remove)
> > > > >  {
> > > > >     int nid = cpu_to_node(cpu);



-- 
Regards,
Atish
