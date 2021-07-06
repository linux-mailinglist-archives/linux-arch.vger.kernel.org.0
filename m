Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50A53BCB55
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 13:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhGFLEw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 07:04:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231469AbhGFLEw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jul 2021 07:04:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E950261A2B
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 11:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625569333;
        bh=48LgFH3oPLoKHDbGLyMxfKJj3kIYo5QKUKl4btuEwHc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WC3pPDI2+71Uh9QeRFksg2CHO4Z6ezOWFakVuTVKrjRwcus0DHIpH3fUOJb4or7js
         0/EOrOFDuLI67U2j8Z9YHlBzXrGuUV2GdHIIotRUbNfvDB92PHdz/4oGVJQgZs/h9S
         ipBf2eKw4BZNUAlHbPP+L6nUxWp1yeaqJuInr3tkz/r516kZ0ksXsYwh4GIbpVLXIp
         Xzo5tt6NnTf9Gu59NpVYsZjkosIFfe0MBtz95K4r7AYnEx80nBFtdSsiQ19x7fomUu
         QfXwts4KFyoNJ8jWCWESFU5SXEu40COlMFKrVWCcrnw44U0lAkTb8H8+nnuc46i5u/
         RAzymlnr7Z6fg==
Received: by mail-wr1-f46.google.com with SMTP id n9so8231576wrs.13
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 04:02:13 -0700 (PDT)
X-Gm-Message-State: AOAM532ZcIfU9BdGm0+0PKWm+1AxKm5hEjjSS5CxdL6m991JEYvvfLtU
        onIh1kQysewhomQMJK1Ey0SDwj6MeZDxK6avLLw=
X-Google-Smtp-Source: ABdhPJxK7YdY2Wibir4c9gP7F1/qaw6WLaFt7GxVKqm3HslamfRg0rREfskLFl26yPQcpxahq42JiaLjsEquA3VK2lE=
X-Received: by 2002:adf:ee10:: with SMTP id y16mr21029383wrn.99.1625569332516;
 Tue, 06 Jul 2021 04:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-16-chenhuacai@loongson.cn> <CAK8P3a35-46xOdVFCo=ta6x6FfU9+drERsK=OdUxR3uSRJRcQw@mail.gmail.com>
In-Reply-To: <CAK8P3a35-46xOdVFCo=ta6x6FfU9+drERsK=OdUxR3uSRJRcQw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 6 Jul 2021 13:01:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2jOTEsZZAWtrCOF2v1-YypoLmGRYY9iovQYCdcEMHqtw@mail.gmail.com>
Message-ID: <CAK8P3a2jOTEsZZAWtrCOF2v1-YypoLmGRYY9iovQYCdcEMHqtw@mail.gmail.com>
Subject: Re: [PATCH 15/19] LoongArch: Add PCI controller support
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> Loongson64 based systems are PC-like systems which use PCI/PCIe as its
> I/O bus, This patch adds the PCI host controller support for LoongArch.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/include/asm/pci.h  | 124 ++++++++++++++++++
>  arch/loongarch/pci/acpi.c         | 194 ++++++++++++++++++++++++++++
>  arch/loongarch/pci/mmconfig.c     | 105 +++++++++++++++
>  arch/loongarch/pci/pci-loongson.c | 130 +++++++++++++++++++
>  arch/loongarch/pci/pci.c          | 207 ++++++++++++++++++++++++++++++

PCI controller support should generally live in drivers/pci/controller/ and
get reviewed by the subsystem maintainers.

> +/*
> + * This file essentially defines the interface between board specific
> + * PCI code and LoongArch common PCI code. Should potentially put into
> + * include/asm/pci.h file.
> + */
> +
> +#include <linux/ioport.h>
> +#include <linux/list.h>
> +
> +extern const struct pci_ops *__read_mostly loongarch_pci_ops;

There is already an abstraction for this in the common code, don't add another.

> +/*
> + * Each pci channel is a top-level PCI bus seem by CPU.         A machine  with
> + * multiple PCI channels may have multiple PCI host controllers or a
> + * single controller supporting multiple channels.
> + */
> +struct pci_controller {
> +       struct list_head list;
> +       struct pci_bus *bus;
> +       struct device_node *of_node;
> +
> +       struct pci_ops *pci_ops;
> +       struct resource *mem_resource;
> +       unsigned long mem_offset;
> +       struct resource *io_resource;
> +       unsigned long io_offset;
> +       unsigned long io_map_base;
> +       struct resource *busn_resource;
> +
> +       unsigned int node;
> +       unsigned int index;
> +       unsigned int need_domain_info;
> +#ifdef CONFIG_ACPI
> +       struct acpi_device *companion;
> +#endif
> +       phys_addr_t mcfg_addr;
> +};
> +
> +extern void pcibios_add_root_resources(struct list_head *resources);
> +
> +extern phys_addr_t mcfg_addr_init(int domain);
> +
> +#ifdef CONFIG_PCI_DOMAINS
> +static inline void set_pci_need_domain_info(struct pci_controller *hose,
> +                                           int need_domain_info)
> +{
> +       hose->need_domain_info = need_domain_info;
> +}
> +#endif /* CONFIG_PCI_DOMAINS */

Just use PCI_DOMAINS unconditionally

> +
> +/*
> + * Can be used to override the logic in pci_scan_bus for skipping
> + * already-configured bus numbers - to be used for buggy BIOSes
> + * or architectures with incomplete PCI setup by the loader
> + */
> +static inline unsigned int pcibios_assign_all_busses(void)
> +{
> +       return 1;
> +}

Since you use ACPI, the BIOS should be responsible for assigning the
buses, otherwise the ACPI data may be mismatched with the PCI
device locations that the kernel sees.

> +#define PCIBIOS_MIN_IO         0

I think this means PCI devices can reuse ports that are reserved
for ISA devices. Since you claim to support ISA, I think this should
be 0x1000

> +
> +int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
> +                                               int reg, int len, u32 *val)
> +{
> +       struct pci_bus *bus_tmp = pci_find_bus(domain, bus);
> +
> +       if (bus_tmp)
> +               return bus_tmp->ops->read(bus_tmp, devfn, reg, len, val);
> +       return -EINVAL;
> +}
> +
> +int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
> +                                               int reg, int len, u32 val)
> +{
> +       struct pci_bus *bus_tmp = pci_find_bus(domain, bus);
> +
> +       if (bus_tmp)
> +               return bus_tmp->ops->write(bus_tmp, devfn, reg, len, val);
> +       return -EINVAL;
> +}

This looks like you copied from arch/arm64. I think the code really
needs to be generalized more. Maybe move the arm64 implementation
to drivers/acpi/ so it can be shared with loongarch?

> +/*
> + * We need to avoid collisions with `mirrored' VGA ports
> + * and other strange ISA hardware, so we always want the
> + * addresses to be allocated in the 0x000-0x0ff region
> + * modulo 0x400.
> + *
> + * Why? Because some silly external IO cards only decode
> + * the low 10 bits of the IO address. The 0x00-0xff region
> + * is reserved for motherboard devices that decode all 16
> + * bits, so it's ok to allocate at, say, 0x2800-0x28ff,
> + * but we want to try to avoid allocating at 0x2900-0x2bff
> + * which might have be mirrored at 0x0100-0x03ff..
> + */
> +resource_size_t
> +pcibios_align_resource(void *data, const struct resource *res,
> +                      resource_size_t size, resource_size_t align)
> +{
> +       struct pci_dev *dev = data;
> +       struct pci_controller *hose = dev->sysdata;
> +       resource_size_t start = res->start;
> +
> +       if (res->flags & IORESOURCE_IO) {
> +               /* Make sure we start at our min on all hoses */
> +               if (start < PCIBIOS_MIN_IO + hose->io_resource->start)
> +                       start = PCIBIOS_MIN_IO + hose->io_resource->start;
> +
> +               /*
> +                * Put everything into 0x00-0xff region modulo 0x400
> +                */
> +               if (start & 0x300)
> +                       start = (start + 0x3ff) & ~0x3ff;
> +       } else if (res->flags & IORESOURCE_MEM) {
> +               /* Make sure we start at our min on all hoses */
> +               if (start < PCIBIOS_MIN_MEM)
> +                       start = PCIBIOS_MIN_MEM;
> +       }
> +
> +       return start;
> +}

Same here, please don't add another copy of this function.


       Arnd
