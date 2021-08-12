Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81A63EA3BF
	for <lists+linux-arch@lfdr.de>; Thu, 12 Aug 2021 13:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhHLL3m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Aug 2021 07:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbhHLL3m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Aug 2021 07:29:42 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF3AC061765
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 04:29:17 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id h18so6465284ilc.5
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 04:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A5XzyNiQQZEA3HkV14Zc5Dwc7aH+duZWHMuUUW4D/ow=;
        b=MP2kuqV4TfewDJEnxZmdqOhKWwlzFLwBj4Au2GOk28DiqiFqjt32icF2Ic55gYSXSs
         jM/j1N8fRTjaR66Lfa27nAf/5vK3niSCG0+5VnVnA4alYqqUUDtsy2GCX41TvG/Z7gaM
         gQupOelMWE9WAbLB409jyXMA0QNGJmzbWlQnY6U2jMo56L4Ac0xlLpLZIfsLyjXxXITP
         AgIeN2Hi1UyGIHXeYMmLoYwGa/EA6ZaW5Vu78M4luXF/ZkRbRPZyYJDpmsUYWUCMTjoZ
         3xmlYY6V74ASb25ZE0wBDvCU9qQH5wFpOZDdsyYVELzPk8PmyGXkrdxXpQJfOb5n+UkT
         rP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A5XzyNiQQZEA3HkV14Zc5Dwc7aH+duZWHMuUUW4D/ow=;
        b=fh4kXqfnQSpbCfTC2xtCIUSd3eWjPr9PWgo3USOFg74WHlf/HZ32TNnQVq+k4b8cBJ
         ABX35ndleA32O7X38ArrXwKUJLNFx/TgJWhTLpBOq4hvRzSiLwB61DvDlJXocXYdi6ay
         y1sWED8ya3VD4GQ/eL5ZFHxdeqKXmPuexOUp8Rsqp4bJ0r73fcxzyzFtYO2wmu2GBdfj
         RZ2vBKyU7KS58NGv9/qDhEBtJa+qo5lZIHsc/GNcuuIozsnNRkrt8va/D7L47s0LX0tY
         yFBm8Z1x2NYowW+DZtFcohTuJVQ9f3JlyHlZTTiZRheBIPVipOG+1oInwNrjGXVrR2F2
         SURg==
X-Gm-Message-State: AOAM532/Fu79KTdpXO0xc5CmS/9PGpi+rLbrTNWXV4VhHgN6vP4tNJVu
        uZUlJR8ZPMfM1oYHlVhoxhV9TlDNqg1bmwEfUQI=
X-Google-Smtp-Source: ABdhPJwEdkkP3RhDknBVhwFp5xTGcWlmUrHJW61bwnM8wxwKpT8LlAbn7StJcUvghvFFsSXO4P5MdMMGmb16va9gbX4=
X-Received: by 2002:a05:6e02:13a1:: with SMTP id h1mr2489338ilo.126.1628767756892;
 Thu, 12 Aug 2021 04:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-16-chenhuacai@loongson.cn> <CAK8P3a35-46xOdVFCo=ta6x6FfU9+drERsK=OdUxR3uSRJRcQw@mail.gmail.com>
In-Reply-To: <CAK8P3a35-46xOdVFCo=ta6x6FfU9+drERsK=OdUxR3uSRJRcQw@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 12 Aug 2021 19:29:05 +0800
Message-ID: <CAAhV-H6DCX_5cnHJHH5Bo2JjmaOkxg0Aa_VeRgv=F+avmPum7Q@mail.gmail.com>
Subject: Re: [PATCH 15/19] LoongArch: Add PCI controller support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Tue, Jul 6, 2021 at 6:17 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > Loongson64 based systems are PC-like systems which use PCI/PCIe as its
> > I/O bus, This patch adds the PCI host controller support for LoongArch.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  arch/loongarch/include/asm/pci.h  | 124 ++++++++++++++++++
> >  arch/loongarch/pci/acpi.c         | 194 ++++++++++++++++++++++++++++
> >  arch/loongarch/pci/mmconfig.c     | 105 +++++++++++++++
> >  arch/loongarch/pci/pci-loongson.c | 130 +++++++++++++++++++
> >  arch/loongarch/pci/pci.c          | 207 ++++++++++++++++++++++++++++++
>
> PCI controller support should generally live in drivers/pci/controller/ and
> get reviewed by the subsystem maintainers.
>
> > +/*
> > + * This file essentially defines the interface between board specific
> > + * PCI code and LoongArch common PCI code. Should potentially put into
> > + * include/asm/pci.h file.
> > + */
> > +
> > +#include <linux/ioport.h>
> > +#include <linux/list.h>
> > +
> > +extern const struct pci_ops *__read_mostly loongarch_pci_ops;
>
> There is already an abstraction for this in the common code, don't add another.
OK, thanks.

>
> > +/*
> > + * Each pci channel is a top-level PCI bus seem by CPU.         A machine  with
> > + * multiple PCI channels may have multiple PCI host controllers or a
> > + * single controller supporting multiple channels.
> > + */
> > +struct pci_controller {
> > +       struct list_head list;
> > +       struct pci_bus *bus;
> > +       struct device_node *of_node;
> > +
> > +       struct pci_ops *pci_ops;
> > +       struct resource *mem_resource;
> > +       unsigned long mem_offset;
> > +       struct resource *io_resource;
> > +       unsigned long io_offset;
> > +       unsigned long io_map_base;
> > +       struct resource *busn_resource;
> > +
> > +       unsigned int node;
> > +       unsigned int index;
> > +       unsigned int need_domain_info;
> > +#ifdef CONFIG_ACPI
> > +       struct acpi_device *companion;
> > +#endif
> > +       phys_addr_t mcfg_addr;
> > +};
> > +
> > +extern void pcibios_add_root_resources(struct list_head *resources);
> > +
> > +extern phys_addr_t mcfg_addr_init(int domain);
> > +
> > +#ifdef CONFIG_PCI_DOMAINS
> > +static inline void set_pci_need_domain_info(struct pci_controller *hose,
> > +                                           int need_domain_info)
> > +{
> > +       hose->need_domain_info = need_domain_info;
> > +}
> > +#endif /* CONFIG_PCI_DOMAINS */
>
> Just use PCI_DOMAINS unconditionally
OK, thanks.

>
> > +
> > +/*
> > + * Can be used to override the logic in pci_scan_bus for skipping
> > + * already-configured bus numbers - to be used for buggy BIOSes
> > + * or architectures with incomplete PCI setup by the loader
> > + */
> > +static inline unsigned int pcibios_assign_all_busses(void)
> > +{
> > +       return 1;
> > +}
>
> Since you use ACPI, the BIOS should be responsible for assigning the
> buses, otherwise the ACPI data may be mismatched with the PCI
> device locations that the kernel sees.
>
> > +#define PCIBIOS_MIN_IO         0
>
> I think this means PCI devices can reuse ports that are reserved
> for ISA devices. Since you claim to support ISA, I think this should
> be 0x1000
OK, thanks.

>
> > +
> > +int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
> > +                                               int reg, int len, u32 *val)
> > +{
> > +       struct pci_bus *bus_tmp = pci_find_bus(domain, bus);
> > +
> > +       if (bus_tmp)
> > +               return bus_tmp->ops->read(bus_tmp, devfn, reg, len, val);
> > +       return -EINVAL;
> > +}
> > +
> > +int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
> > +                                               int reg, int len, u32 val)
> > +{
> > +       struct pci_bus *bus_tmp = pci_find_bus(domain, bus);
> > +
> > +       if (bus_tmp)
> > +               return bus_tmp->ops->write(bus_tmp, devfn, reg, len, val);
> > +       return -EINVAL;
> > +}
>
> This looks like you copied from arch/arm64. I think the code really
> needs to be generalized more. Maybe move the arm64 implementation
> to drivers/acpi/ so it can be shared with loongarch?
Emmm, this seems like a future story..

Huacai
>
> > +/*
> > + * We need to avoid collisions with `mirrored' VGA ports
> > + * and other strange ISA hardware, so we always want the
> > + * addresses to be allocated in the 0x000-0x0ff region
> > + * modulo 0x400.
> > + *
> > + * Why? Because some silly external IO cards only decode
> > + * the low 10 bits of the IO address. The 0x00-0xff region
> > + * is reserved for motherboard devices that decode all 16
> > + * bits, so it's ok to allocate at, say, 0x2800-0x28ff,
> > + * but we want to try to avoid allocating at 0x2900-0x2bff
> > + * which might have be mirrored at 0x0100-0x03ff..
> > + */
> > +resource_size_t
> > +pcibios_align_resource(void *data, const struct resource *res,
> > +                      resource_size_t size, resource_size_t align)
> > +{
> > +       struct pci_dev *dev = data;
> > +       struct pci_controller *hose = dev->sysdata;
> > +       resource_size_t start = res->start;
> > +
> > +       if (res->flags & IORESOURCE_IO) {
> > +               /* Make sure we start at our min on all hoses */
> > +               if (start < PCIBIOS_MIN_IO + hose->io_resource->start)
> > +                       start = PCIBIOS_MIN_IO + hose->io_resource->start;
> > +
> > +               /*
> > +                * Put everything into 0x00-0xff region modulo 0x400
> > +                */
> > +               if (start & 0x300)
> > +                       start = (start + 0x3ff) & ~0x3ff;
> > +       } else if (res->flags & IORESOURCE_MEM) {
> > +               /* Make sure we start at our min on all hoses */
> > +               if (start < PCIBIOS_MIN_MEM)
> > +                       start = PCIBIOS_MIN_MEM;
> > +       }
> > +
> > +       return start;
> > +}
>
> Same here, please don't add another copy of this function.
>
>
>        Arnd
