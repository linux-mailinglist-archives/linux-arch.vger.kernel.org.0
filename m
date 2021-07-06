Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D573BC963
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 12:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhGFKUe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 06:20:34 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:42595 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhGFKUe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 06:20:34 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N1cvQ-1l3TfW39SK-011wh0 for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021
 12:17:54 +0200
Received: by mail-wm1-f48.google.com with SMTP id h18-20020a05600c3512b029020e4ceb9588so1305602wmq.5
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 03:17:54 -0700 (PDT)
X-Gm-Message-State: AOAM530/wfWPa7ixcu+4c96punewn4j9m3lOHw1fksZDkU0Uuh9VmP8M
        b7qXaclIiUPV1MzT7imLAbOU/WSaFtNvfLaYp2A=
X-Google-Smtp-Source: ABdhPJzkoa25N3YN0iT1enzSkMNAsAOjNuOuUqCEwFD2c5is+jfq7M8mq+RFKaHkIgLC3Q2j9/k8hB+cyAWhgYxTUxM=
X-Received: by 2002:a1c:4e0c:: with SMTP id g12mr3914276wmh.120.1625566674453;
 Tue, 06 Jul 2021 03:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn> <20210706041820.1536502-16-chenhuacai@loongson.cn>
In-Reply-To: <20210706041820.1536502-16-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Jul 2021 12:17:38 +0200
X-Gmail-Original-Message-ID: <CAK8P3a35-46xOdVFCo=ta6x6FfU9+drERsK=OdUxR3uSRJRcQw@mail.gmail.com>
Message-ID: <CAK8P3a35-46xOdVFCo=ta6x6FfU9+drERsK=OdUxR3uSRJRcQw@mail.gmail.com>
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
X-Provags-ID: V03:K1:bUXTEf5cPHIEH+qK1Tx2LayCg33DQedDYUlWG8s9zqT9lRBhcQX
 LZ9Kcj6NcYBcMP2kkFpyeB8jGI+tdjxueMIwRkt4ZRypN+fpS9+9+PrBJi6BCQS+vUPW845
 rjlNUIu0d5tz1X2dDQpkYpw4dc/dopJ7qmBecsz9PzJ97vtLVMzd6rm4cpfZI6oyuEqns/m
 woN7BySGLuEBLl58COo+g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VH7BabnQk4E=:APvOsmA79BlRNdKtwZgUNW
 IPwcBkApP5ExQgv3Fwr8DApo2ayiWkbTzW2bNigK99gyqoj5en7ScTEOlwIcfOBRxWZLvjmqR
 qL7k9Jt/OiNW2EpImIdpfrs2k8QybJJ8YRR7YX+nDkge9fYVQnDHy2/UeEkFEq8iEetwOR5LE
 B1+NDp/5oaeJEjqoE3lMpivcX1VhgbqKH6eRu51jMFyNe1ChkbIToyfj6PbDLehZUV8M960rp
 bSzLCasJuoAYnjKNv50weEZql5PQ8j+VfJ+iez0SmQvtMHOTcc4t+AoQ301NTEZgavs4+rd5G
 ulyuXS85S4+srj/qCdxP6nGKQ/z5pPprGg0nY/zNJaa0+FGjwSjsvMlqHDRQU0RXi8vzp3LKv
 OJ/ziy9HfXJ0x17PvQM6wIUK+kO0Yy6NdWip3NFM779Kfa5Q/wNZ2f5n8TKuQ3c7U3YLNHbLX
 7I+cMZk4Fr99KhrcTVXpikdPhtfR320xBSU0aSN79DmS685Vev9l3v6tYWYDHUfUVIrNlzLnK
 diw3QWsZSoCLA18euUJ6FCF7GpqpQOd2rGG8O5cpkbrestuyc7LKVWX1q9tEyc7vnwoioRgYe
 EWZvSb+bGg7KOE10mHeqwAoNhX40OBr7o2+dlsnBHnOTBc9kxG1c6j2KQdqSoZKx/JOVlfHUq
 SW7vBwc4h58ayCu5D7tbf1bdJRF6YBf0aobySTlEPoS4JfPQCqOQaMMez6cozYyIzW28Im2nn
 XMX+9ghf14a0YKE3JVCeeY7dtADJwAcQpEzAgWKqk6benXRsvI1udrvdJ/zMxOD9PWArZv4f2
 O/UvFiCrGYmbX6/uFEUm3HvJqyL+6nbM4JBmaW/WKqrAIy6ocaniBIz/E7bWFKbevDUULjArV
 2iYIXfOW0MO/tRcjlhZsQJ3kOJvEDd/O4Ynxe0lYBcQ7HclvaOtgTR0qK2KAVMVB1+sg/Ys3+
 px/uQIxm8o8Dv1iQh0luVx/S3X2WQnVSKOMC675cvV+Jgf74iK/gZ
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
