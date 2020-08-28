Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9CD255EA2
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 18:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgH1QPf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 12:15:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgH1QPZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 12:15:25 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7DFA208D5;
        Fri, 28 Aug 2020 16:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598631325;
        bh=WDy36I6Z4orTZPoGujoAX7lI0c2B80UVvjLy+uuLcNA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XXzEkWMbwa7hJsKl3WWxYs9ZIzvl4XBfLjgS8Mijz+ElFIFxllHByPMzK3VHEqITH
         1D4I/umOYAh/U5wOHQaoIwJATfekh83VfUHN8EJZaCCfchYknTM4ZCIMFUd0DL6dnq
         F9ieOAP4skNybw+ZwBfOKkffDedrwcNXg5u8hBDU=
Date:   Fri, 28 Aug 2020 11:15:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Zong Li <zong.li@sifive.com>, linux-riscv@lists.infradead.org,
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
        linux-arm-kernel@lists.infradead.org,
        Nick Hu <nickhu@andestech.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [RFC/RFT PATCH 3/6] arm64, numa: Move pcibus_to_node definition
 to generic numa code
Message-ID: <20200828161523.GA2158345@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828104830.000007bf@Huawei.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 28, 2020 at 10:48:30AM +0100, Jonathan Cameron wrote:
> On Fri, 14 Aug 2020 14:47:22 -0700
> Atish Patra <atish.patra@wdc.com> wrote:
> 
> > pcibus_to_node is used only when numa is enabled and does not depend
> > on ISA. Thus, it can be moved the generic numa implementation.
> > 
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> 
> From a more general unification point of view, there seem to
> be two ways architectures implement this.
> Either
> 
> bus->sysdata.node
> 
> Or as here.
> There are weird other options, but let us ignore those :)
> 
> That is going to take a bit of unwinding should we
> want to take this unification further and perhaps we want to think
> about doing this in pci generic code rather than here?
> 
> Perhaps this is one we are better keeping architecture specific for
> now?
> 
> +CC Bjorn and Linux-pci
> 
> 
> > ---
> >  arch/arm64/kernel/pci.c  | 10 ----------
> >  drivers/base/arch_numa.c | 11 +++++++++++
> >  2 files changed, 11 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> > index 1006ed2d7c60..07c122946c11 100644
> > --- a/arch/arm64/kernel/pci.c
> > +++ b/arch/arm64/kernel/pci.c
> > @@ -54,16 +54,6 @@ int raw_pci_write(unsigned int domain, unsigned int bus,
> >  	return b->ops->write(b, devfn, reg, len, val);
> >  }
> >  
> > -#ifdef CONFIG_NUMA
> > -
> > -int pcibus_to_node(struct pci_bus *bus)
> > -{
> > -	return dev_to_node(&bus->dev);
> > -}
> > -EXPORT_SYMBOL(pcibus_to_node);
> > -
> > -#endif
> > -
> >  #ifdef CONFIG_ACPI
> >  
> >  struct acpi_pci_generic_root_info {
> > diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> > index 83341c807240..4ab1b20a615d 100644
> > --- a/drivers/base/arch_numa.c
> > +++ b/drivers/base/arch_numa.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/acpi.h>
> >  #include <linux/memblock.h>
> >  #include <linux/module.h>
> > +#include <linux/pci.h>
> >  #include <linux/of.h>
> >  
> >  #ifdef CONFIG_ARM64
> > @@ -60,6 +61,16 @@ EXPORT_SYMBOL(cpumask_of_node);
> >  
> >  #endif
> >  
> > +#ifdef CONFIG_PCI
> > +
> > +int pcibus_to_node(struct pci_bus *bus)
> > +{
> > +	return dev_to_node(&bus->dev);
> > +}
> > +EXPORT_SYMBOL(pcibus_to_node);
> > +
> > +#endif

I certainly agree that this should not be arch-specific, but I'm not
really in favor of adding this PCI gunk in drivers/base.

I think we can do better (eventually) by getting rid of
pcibus_to_node() completely.  It's not used very much except by
cpumask_of_pcibus(), which itself is hardly used at all.

> >  static void numa_update_cpu(unsigned int cpu, bool remove)
> >  {
> >  	int nid = cpu_to_node(cpu);
> 
> 
