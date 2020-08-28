Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A522557FE
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 11:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgH1JuM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Fri, 28 Aug 2020 05:50:12 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2708 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728218AbgH1JuM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 05:50:12 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id F3FFD3C63C4F4B09F077;
        Fri, 28 Aug 2020 10:50:09 +0100 (IST)
Received: from localhost (10.52.127.106) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 28 Aug
 2020 10:50:05 +0100
Date:   Fri, 28 Aug 2020 10:48:30 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Atish Patra <atish.patra@wdc.com>
CC:     <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Zong Li <zong.li@sifive.com>,
        <linux-riscv@lists.infradead.org>, Will Deacon <will@kernel.org>,
        <linux-arch@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Ganapatrao Kulkarni <gkulkarni@cavium.com>,
        Steven Price <steven.price@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Nick Hu <nickhu@andestech.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>
Subject: Re: [RFC/RFT PATCH 3/6] arm64, numa: Move pcibus_to_node definition
 to generic numa code
Message-ID: <20200828104830.000007bf@Huawei.com>
In-Reply-To: <20200814214725.28818-4-atish.patra@wdc.com>
References: <20200814214725.28818-1-atish.patra@wdc.com>
        <20200814214725.28818-4-atish.patra@wdc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.127.106]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 14 Aug 2020 14:47:22 -0700
Atish Patra <atish.patra@wdc.com> wrote:

> pcibus_to_node is used only when numa is enabled and does not depend
> on ISA. Thus, it can be moved the generic numa implementation.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

From a more general unification point of view, there seem to
be two ways architectures implement this.
Either

bus->sysdata.node

Or as here.
There are weird other options, but let us ignore those :)

That is going to take a bit of unwinding should we
want to take this unification further and perhaps we want to think
about doing this in pci generic code rather than here?

Perhaps this is one we are better keeping architecture specific for
now?

+CC Bjorn and Linux-pci


> ---
>  arch/arm64/kernel/pci.c  | 10 ----------
>  drivers/base/arch_numa.c | 11 +++++++++++
>  2 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 1006ed2d7c60..07c122946c11 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -54,16 +54,6 @@ int raw_pci_write(unsigned int domain, unsigned int bus,
>  	return b->ops->write(b, devfn, reg, len, val);
>  }
>  
> -#ifdef CONFIG_NUMA
> -
> -int pcibus_to_node(struct pci_bus *bus)
> -{
> -	return dev_to_node(&bus->dev);
> -}
> -EXPORT_SYMBOL(pcibus_to_node);
> -
> -#endif
> -
>  #ifdef CONFIG_ACPI
>  
>  struct acpi_pci_generic_root_info {
> diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> index 83341c807240..4ab1b20a615d 100644
> --- a/drivers/base/arch_numa.c
> +++ b/drivers/base/arch_numa.c
> @@ -11,6 +11,7 @@
>  #include <linux/acpi.h>
>  #include <linux/memblock.h>
>  #include <linux/module.h>
> +#include <linux/pci.h>
>  #include <linux/of.h>
>  
>  #ifdef CONFIG_ARM64
> @@ -60,6 +61,16 @@ EXPORT_SYMBOL(cpumask_of_node);
>  
>  #endif
>  
> +#ifdef CONFIG_PCI
> +
> +int pcibus_to_node(struct pci_bus *bus)
> +{
> +	return dev_to_node(&bus->dev);
> +}
> +EXPORT_SYMBOL(pcibus_to_node);
> +
> +#endif
> +
>  static void numa_update_cpu(unsigned int cpu, bool remove)
>  {
>  	int nid = cpu_to_node(cpu);


