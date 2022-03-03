Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BE94CC046
	for <lists+linux-arch@lfdr.de>; Thu,  3 Mar 2022 15:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbiCCOsx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Mar 2022 09:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbiCCOsw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Mar 2022 09:48:52 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0079BDEA07;
        Thu,  3 Mar 2022 06:48:05 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id j12so2805448vkr.0;
        Thu, 03 Mar 2022 06:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/THMqkzDE6yZOCW2bKBHdKVAal0gEaNlcezXn2aDYvA=;
        b=O8ncUiNDFdYCSZpDLjctxZWCWTS9xTMZiEKsgiKKN9lBfCwARCKk42e/B2FuN6q1CD
         jyKOWo/MC2+iK/GHmXBxPJZqX2d9uSgZUzIa8543dQuMZUNPyyKk1zLgFcYtXDQhxX/c
         1vl3uRWuAionfcDXkUVZXv7+jZ8EOI3H3x5SqS8mt4k+lV9euXwxg5cC2US7oPvo4vG0
         3QSTqrDgctDMH0NVdXz2CJT8tSMbqLie1z+k5ZLoF4dtX/g7cK7pWfNOJqZiqyOkSmrh
         uJSY8B4soDTjoaDrCnoqvOCL/bfYW8yHmXxtnyLWDrZR099Aa5d+tNj1pMXtLLqVcjKh
         gqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/THMqkzDE6yZOCW2bKBHdKVAal0gEaNlcezXn2aDYvA=;
        b=pnEitVjkS/STTdPgQLs9t+HCbMf0posGoYsJBAcCBQl8HP6gKWE+nUW9iChXD/QlxH
         ZVdUZMIMtBRsYPgDgzaoZtWaCDjwAvHPaz686wpd2T32pyD80fztUDlUCH+EIxFVAOmn
         2bpHL7kCmTGtOPIbes1kH20fBxZ32mxROQpUcJeTkjJ4UnJ2IciI0DyYyQHaPpQnVrx5
         YL4QiEK5Fh5/RTassOTY5Dv/7LQoKHfcMEpwHnpqfyVGgcLK4211HSH5x826jqmA6pJN
         g2Rg0KvKt3ysABSEjK7TeIX5kgnv+LkEJcD8Zc9Bdgoh6GUqil8Ri4rCPhOoqFR8D48M
         mpcA==
X-Gm-Message-State: AOAM532hCF6XnIwwu2V/qWtN8jPmfVQh12s3s+rwd02v60VtE8lH0uEd
        CCghN1mIfT8w9SsRlsXdDHwT/WZ7HxZab1iEYeY=
X-Google-Smtp-Source: ABdhPJwif3YoJQNXulokrVwBFfx5w4etEGY/s1W2snrMYNWNoBjpbTz95337K7DOaqJt34ChpUiTBd9n+38BTIoJ7dI=
X-Received: by 2002:a1f:9f56:0:b0:332:61fb:7adf with SMTP id
 i83-20020a1f9f56000000b0033261fb7adfmr15213804vke.20.1646318884734; Thu, 03
 Mar 2022 06:48:04 -0800 (PST)
MIME-Version: 1.0
References: <20220226110338.77547-1-chenhuacai@loongson.cn>
 <20220226110338.77547-10-chenhuacai@loongson.cn> <YiCpYRwoUSmd/GE3@kernel.org>
In-Reply-To: <YiCpYRwoUSmd/GE3@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 3 Mar 2022 22:47:53 +0800
Message-ID: <CAAhV-H4-zVjjUkoVFw4ppg_tsM-wxBZmPr-2q8zuoLDHTWAE0w@mail.gmail.com>
Subject: Re: [PATCH V6 09/22] LoongArch: Add boot and setup routines
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Mike,

On Thu, Mar 3, 2022 at 7:41 PM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Sat, Feb 26, 2022 at 07:03:25PM +0800, Huacai Chen wrote:
> > This patch adds basic boot, setup and reset routines for LoongArch.
> > LoongArch uses UEFI-based firmware. The firmware uses ACPI and DMI/
> > SMBIOS to pass configuration information to the Linux kernel (in elf
> > format).
> >
> > Now the boot information passed to kernel is like this:
> > 1, kernel get 3 register values (a0, a1 and a2) from bootloader.
> > 2, a0 is "argc", a1 is "argv", so "kernel cmdline" comes from a0/a1.
> > 3, a2 is "environ", which is a pointer to "struct bootparamsinterface".
> > 4, "struct bootparamsinterface" include a "systemtable" pointer, whose
> >    type is "efi_system_table_t". Most configuration information, include
> >    ACPI tables and SMBIOS tables, come from here.
> >
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: linux-efi@vger.kernel.org
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
>
> ...
>
> > diff --git a/arch/loongarch/include/asm/dmi.h b/arch/loongarch/include/asm/dmi.h
> > new file mode 100644
> > index 000000000000..d2d4b89624f8
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/dmi.h
> > @@ -0,0 +1,24 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_DMI_H
> > +#define _ASM_DMI_H
> > +
> > +#include <linux/io.h>
> > +#include <linux/memblock.h>
> > +
> > +#define dmi_early_remap(x, l)        dmi_remap(x, l)
> > +#define dmi_early_unmap(x, l)        dmi_unmap(x)
> > +#define dmi_alloc(l)         memblock_alloc_low(l, PAGE_SIZE)
>
> Are there any restrictions on addressing of the memory allocated with
> dmi_alloc()?
>
> If no, please use memblock_alloc().
OK, I will try memblock_alloc().
>
> > +
> > +static inline void *dmi_remap(u64 phys_addr, unsigned long size)
> > +{
> > +     return ((void *)TO_CAC(phys_addr));
> > +}
> > +
> > +static inline void dmi_unmap(void *addr)
> > +{
> > +}
> > +
> > +#endif /* _ASM_DMI_H */
>
> ...
>
> > diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
> > new file mode 100644
> > index 000000000000..3f2101fd19bd
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/acpi.c
> > @@ -0,0 +1,338 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * acpi.c - Architecture-Specific Low-Level ACPI Boot Support
> > + *
> > + * Author: Jianmin Lv <lvjianmin@loongson.cn>
> > + *         Huacai Chen <chenhuacai@loongson.cn>
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/acpi.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/memblock.h>
> > +#include <linux/serial_core.h>
> > +#include <asm/io.h>
> > +#include <asm/loongson.h>
> > +
> > +int acpi_disabled;
> > +EXPORT_SYMBOL(acpi_disabled);
> > +int acpi_noirq;
> > +int acpi_pci_disabled;
> > +EXPORT_SYMBOL(acpi_pci_disabled);
> > +int acpi_strict = 1; /* We have no workarounds on LoongArch */
> > +int num_processors;
> > +int disabled_cpus;
> > +enum acpi_irq_model_id acpi_irq_model = ACPI_IRQ_MODEL_PLATFORM;
> > +
> > +u64 acpi_saved_sp;
> > +
> > +#define MAX_CORE_PIC 256
> > +
> > +#define PREFIX                       "ACPI: "
> > +
> > +int acpi_gsi_to_irq(u32 gsi, unsigned int *irqp)
> > +{
> > +     if (irqp != NULL)
> > +             *irqp = acpi_register_gsi(NULL, gsi, -1, -1);
> > +     return (*irqp >= 0) ? 0 : -EINVAL;
> > +}
> > +EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
> > +
> > +int acpi_isa_irq_to_gsi(unsigned int isa_irq, u32 *gsi)
> > +{
> > +     if (gsi)
> > +             *gsi = isa_irq;
> > +     return 0;
> > +}
> > +
> > +/*
> > + * success: return IRQ number (>=0)
> > + * failure: return < 0
> > + */
> > +int acpi_register_gsi(struct device *dev, u32 gsi, int trigger, int polarity)
> > +{
> > +     int id;
> > +     struct irq_fwspec fwspec;
> > +
> > +     switch (gsi) {
> > +     case GSI_MIN_CPU_IRQ ... GSI_MAX_CPU_IRQ:
> > +             fwspec.fwnode = liointc_domain->fwnode;
> > +             fwspec.param[0] = gsi - GSI_MIN_CPU_IRQ;
> > +             fwspec.param_count = 1;
> > +
> > +             return irq_create_fwspec_mapping(&fwspec);
> > +
> > +     case GSI_MIN_LPC_IRQ ... GSI_MAX_LPC_IRQ:
> > +             if (!pch_lpc_domain)
> > +                     return -EINVAL;
> > +
> > +             fwspec.fwnode = pch_lpc_domain->fwnode;
> > +             fwspec.param[0] = gsi - GSI_MIN_LPC_IRQ;
> > +             fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
> > +             fwspec.param_count = 2;
> > +
> > +             return irq_create_fwspec_mapping(&fwspec);
> > +
> > +     case GSI_MIN_PCH_IRQ ... GSI_MAX_PCH_IRQ:
> > +             id = find_pch_pic(gsi);
> > +             if (id < 0)
> > +                     return -EINVAL;
> > +
> > +             fwspec.fwnode = pch_pic_domain[id]->fwnode;
> > +             fwspec.param[0] = gsi - acpi_pchpic[id]->gsi_base;
> > +             fwspec.param[1] = IRQ_TYPE_LEVEL_HIGH;
> > +             fwspec.param_count = 2;
> > +
> > +             return irq_create_fwspec_mapping(&fwspec);
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +EXPORT_SYMBOL_GPL(acpi_register_gsi);
> > +
> > +void acpi_unregister_gsi(u32 gsi)
> > +{
> > +
> > +}
> > +EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
> > +
> > +void __init __iomem * __acpi_map_table(unsigned long phys, unsigned long size)
> > +{
> > +
> > +     if (!phys || !size)
> > +             return NULL;
> > +
> > +     return early_memremap(phys, size);
> > +}
> > +void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
> > +{
> > +     if (!map || !size)
> > +             return;
> > +
> > +     early_memunmap(map, size);
> > +}
> > +
> > +void __init __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
> > +{
> > +     if (!memblock_is_memory(phys))
> > +             return ioremap(phys, size);
>
> Is it possible that ACPI memory will be backed by a different *physical*
> device than system RAM?
Because acpi_os_ioremap() is used both for ACPI memory and ACPI
registers, registers need uncached maps.

>
> > +     else
> > +             return ioremap_cache(phys, size);
>
> If the address is in memory, why it needs to be ioremap'ed?
The default acpi_os_ioremap() implementation is ioremap_cache(), so we
keep it for memory.

>
> > +}
>
> ...
>
> > +void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
> > +{
> > +     memblock_mark_nomap(addr, size);
> > +}
>
> Is there any problem if the memory ranges used by ACPI will be mapped into
> the kernel page tables?
>
> If not, consider dropping this function.
This API is mostly used for ACPI upgrading. ACPI upgrading alloc a
normal memory block and then is used as ACPI memory, and this memory
block will not be used by the page allocator. Other architectures,
such as ARM64, do the same thing here.

>
> ...
>
> > diff --git a/arch/loongarch/kernel/mem.c b/arch/loongarch/kernel/mem.c
> > new file mode 100644
> > index 000000000000..361d108a2b82
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/mem.c
> > @@ -0,0 +1,89 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#include <linux/fs.h>
> > +#include <linux/mm.h>
> > +#include <linux/memblock.h>
> > +
> > +#include <asm/bootinfo.h>
> > +#include <asm/loongson.h>
> > +#include <asm/sections.h>
> > +
> > +void __init early_memblock_init(void)
> > +{
> > +     int i;
> > +     u32 mem_type;
> > +     u64 mem_start, mem_end, mem_size;
> > +
> > +     /* Parse memory information */
> > +     for (i = 0; i < loongson_mem_map->map_count; i++) {
> > +             mem_type = loongson_mem_map->map[i].mem_type;
> > +             mem_start = loongson_mem_map->map[i].mem_start;
> > +             mem_size = loongson_mem_map->map[i].mem_size;
> > +             mem_end = mem_start + mem_size;
> > +
> > +             switch (mem_type) {
> > +             case ADDRESS_TYPE_SYSRAM:
> > +                     memblock_add(mem_start, mem_size);
> > +                     if (max_low_pfn < (mem_end >> PAGE_SHIFT))
> > +                             max_low_pfn = mem_end >> PAGE_SHIFT;
> > +                     break;
> > +             }
> > +     }
> > +     memblock_set_current_limit(PFN_PHYS(max_low_pfn));
> > +}
> > +
> > +void __init fw_init_memory(void)
> > +{
> > +     int i;
> > +     u32 mem_type;
> > +     u64 mem_start, mem_end, mem_size;
> > +     unsigned long start_pfn, end_pfn;
> > +     static unsigned long num_physpages;
> > +
> > +     /* Parse memory information */
> > +     for (i = 0; i < loongson_mem_map->map_count; i++) {
> > +             mem_type = loongson_mem_map->map[i].mem_type;
> > +             mem_start = loongson_mem_map->map[i].mem_start;
> > +             mem_size = loongson_mem_map->map[i].mem_size;
> > +             mem_end = mem_start + mem_size;
>
> I think this loop can be merged with loop in early_memblock_init() then ...
>
> > +
> > +             switch (mem_type) {
> > +             case ADDRESS_TYPE_SYSRAM:
> > +                     mem_start = PFN_ALIGN(mem_start);
> > +                     mem_end = PFN_ALIGN(mem_end - PAGE_SIZE + 1);
> > +                     num_physpages += (mem_size >> PAGE_SHIFT);
> > +                     memblock_set_node(mem_start, mem_size, &memblock.memory, 0);
>
> this will become memblock_add_node()
>
> > +                     break;
> > +             case ADDRESS_TYPE_ACPI:
> > +                     mem_start = PFN_ALIGN(mem_start);
> > +                     mem_end = PFN_ALIGN(mem_end - PAGE_SIZE + 1);
> > +                     num_physpages += (mem_size >> PAGE_SHIFT);
> > +                     memblock_add(mem_start, mem_size);
> > +                     memblock_set_node(mem_start, mem_size, &memblock.memory, 0);
>
> as well as this.
early_memblock_init() only adds the "usable" memory (SYSRAM) for early
use and without numa node information. Other types of memory are
handled later by fw_init_memory()/fw_init_numa_memory(), depending on
whether CONFIG_NUMA is enabled. So, in
fw_init_memory()/fw_init_numa_memory() we only need to call
memblock_set_node() to add the node information for SYSRAM type.

>
> > +                     memblock_mark_nomap(mem_start, mem_size);
>
> You don't want to use MEMBLOCK_NOMAP unless there is a problem with normal
> accesses to this memory.
>
> > +                     fallthrough;
> > +             case ADDRESS_TYPE_RESERVED:
> > +                     memblock_reserve(mem_start, mem_size);
> > +                     break;
> > +             }
> > +     }
> > +
> > +     get_pfn_range_for_nid(0, &start_pfn, &end_pfn);
> > +     pr_info("start_pfn=0x%lx, end_pfn=0x%lx, num_physpages:0x%lx\n",
> > +                             start_pfn, end_pfn, num_physpages);
> > +
> > +     NODE_DATA(0)->node_start_pfn = start_pfn;
> > +     NODE_DATA(0)->node_spanned_pages = end_pfn - start_pfn;
>
> This is now handled by the generic code at free_area_init(), no need to
> keep it here.
OK, thanks.

>
> > +
> > +     /* used by finalize_initrd() */
> > +     max_low_pfn = end_pfn;
> > +
> > +     /* Reserve the first 2MB */
> > +     memblock_reserve(PHYS_OFFSET, 0x200000);
> > +
> > +     /* Reserve the kernel text/data/bss */
> > +     memblock_reserve(__pa_symbol(&_text),
> > +                      __pa_symbol(&_end) - __pa_symbol(&_text));
> > +}
>
> ...
>
> > diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
> > new file mode 100644
> > index 000000000000..8dfe1d9b55f7
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/setup.c
> > @@ -0,0 +1,495 @@
>
> ...
>
> > +/*
> > + * Manage initrd
> > + */
> > +#ifdef CONFIG_BLK_DEV_INITRD
> > +
> > +static unsigned long __init init_initrd(void)
> > +{
> > +     if (!phys_initrd_start || !phys_initrd_size)
> > +             goto disable;
> > +
> > +     initrd_start = (unsigned long)phys_to_virt(phys_initrd_start);
> > +     initrd_end   = (unsigned long)phys_to_virt(phys_initrd_start + phys_initrd_size);
> > +
> > +     if (!initrd_start || initrd_end <= initrd_start)
> > +             goto disable;
> > +
> > +     if (initrd_start & ~PAGE_MASK) {
> > +             pr_err("initrd start must be page aligned\n");
> > +             goto disable;
> > +     }
> > +     if (initrd_start < PAGE_OFFSET) {
> > +             pr_err("initrd start < PAGE_OFFSET\n");
> > +             goto disable;
> > +     }
> > +
> > +     ROOT_DEV = Root_RAM0;
> > +
> > +     return 0;
> > +disable:
> > +     initrd_start = 0;
> > +     initrd_end = 0;
> > +     return 0;
> > +}
> > +
> > +static void __init finalize_initrd(void)
> > +{
>
> Any reason to have this separate function from init_initrd?
OK, I'll try to combine them.

>
> > +     unsigned long size = initrd_end - initrd_start;
> > +
> > +     if (size == 0) {
> > +             pr_info("Initrd not found or empty");
> > +             goto disable;
> > +     }
> > +     if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
> > +             pr_err("Initrd extends beyond end of memory");
> > +             goto disable;
> > +     }
> > +
> > +
> > +     memblock_reserve(__pa(initrd_start), size);
> > +     initrd_below_start_ok = 1;
> > +
> > +     pr_info("Initial ramdisk at: 0x%lx (%lu bytes)\n",
> > +             initrd_start, size);
> > +     return;
> > +disable:
> > +     pr_cont(" - disabling initrd\n");
> > +     initrd_start = 0;
> > +     initrd_end = 0;
> > +}
> > +
> > +#else  /* !CONFIG_BLK_DEV_INITRD */
> > +
> > +static unsigned long __init init_initrd(void)
> > +{
> > +     return 0;
> > +}
> > +
> > +#define finalize_initrd()    do {} while (0)
> > +
> > +#endif
> > +
> > +static int usermem __initdata;
> > +
> > +static int __init early_parse_mem(char *p)
> > +{
> > +     phys_addr_t start, size;
> > +
> > +     /*
> > +      * If a user specifies memory size, we
> > +      * blow away any automatically generated
> > +      * size.
> > +      */
> > +     if (usermem == 0) {
> > +             usermem = 1;
> > +             memblock_remove(memblock_start_of_DRAM(),
> > +                     memblock_end_of_DRAM() - memblock_start_of_DRAM());
> > +     }
> > +     start = 0;
> > +     size = memparse(p, &p);
> > +     if (*p == '@')
> > +             start = memparse(p + 1, &p);
> > +
> > +     memblock_add(start, size);
> > +
> > +     return 0;
> > +}
> > +early_param("mem", early_parse_mem);
> > +
> > +static int __init early_parse_memmap(char *p)
> > +{
> > +     char *oldp;
> > +     u64 start_at, mem_size;
> > +
> > +     if (!p)
> > +             return -EINVAL;
> > +
> > +     if (!strncmp(p, "exactmap", 8)) {
> > +             pr_err("\"memmap=exactmap\" invalid on LoongArch\n");
> > +             return 0;
> > +     }
> > +
> > +     oldp = p;
> > +     mem_size = memparse(p, &p);
> > +     if (p == oldp)
> > +             return -EINVAL;
> > +
> > +     if (*p == '@') {
> > +             start_at = memparse(p+1, &p);
> > +             memblock_add(start_at, mem_size);
> > +     } else if (*p == '#') {
> > +             pr_err("\"memmap=nn#ss\" (force ACPI data) invalid on LoongArch\n");
> > +             return -EINVAL;
> > +     } else if (*p == '$') {
> > +             start_at = memparse(p+1, &p);
> > +             memblock_add(start_at, mem_size);
> > +             memblock_reserve(start_at, mem_size);
> > +     } else {
> > +             pr_err("\"memmap\" invalid format!\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (*p == '\0') {
> > +             usermem = 1;
> > +             return 0;
> > +     } else
> > +             return -EINVAL;
> > +}
> > +early_param("memmap", early_parse_memmap);
>
> The memmap= processing is a hack indented to workaround bugs in firmware
> related to the memory detection. Please don't copy if over unless there is
> really strong reason.
Hmmm, I have read the documents, most archs only support mem=limit,
but MIPS support mem=limit@base. memmap not only supports
memmap=limit@base, but also a lot of advanced syntax. LoongArch needs
both limit and limit@base syntax. So can we make our code to support
only mem=limit and memmap=limit@base, and remove all other syntax
here?

>
> ...
>
> > +/*
> > + * arch_mem_init - initialize memory management subsystem
> > + */
> > +static void __init arch_mem_init(char **cmdline_p)
> > +{
> > +     if (usermem)
> > +             pr_info("User-defined physical RAM map overwrite\n");
> > +
> > +     check_kernel_sections_mem();
> > +
> > +     memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);
> > +
> > +     memblock_set_current_limit(PFN_PHYS(max_low_pfn));
> > +
> > +     /*
> > +      * In order to reduce the possibility of kernel panic when failed to
> > +      * get IO TLB memory under CONFIG_SWIOTLB, it is better to allocate
> > +      * low memory as small as possible before plat_swiotlb_setup(), so
> > +      * make sparse_init() using top-down allocation.
> > +      */
> > +     memblock_set_bottom_up(false);
> > +     sparse_init();
> > +     memblock_set_bottom_up(true);
>
> Does loongarch have the same IO TLB requirements as MIPS?
Yes, we have a large amount of memory, but there are many 32-bit PCI devices.

>
> > +
> > +     swiotlb_init(1);
> > +
> > +     dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
> > +
> > +     memblock_dump_all();
> > +
> > +     early_memtest(PFN_PHYS(ARCH_PFN_OFFSET), PFN_PHYS(max_low_pfn));
> > +}
>
> --
> Sincerely yours,
> Mike.
