Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504814CD2BE
	for <lists+linux-arch@lfdr.de>; Fri,  4 Mar 2022 11:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbiCDKue (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Mar 2022 05:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiCDKue (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Mar 2022 05:50:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4CD5B8B8;
        Fri,  4 Mar 2022 02:49:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04749B827E0;
        Fri,  4 Mar 2022 10:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0405C340E9;
        Fri,  4 Mar 2022 10:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646390983;
        bh=/fzsqOjvxlJfpDTQHQyahusZXTlcolIKENy9tXtYbME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cKv2gtF8kJ1Egr7w35fuFRDG6AJDnkA9gTxr5KJuLnNjZ9w5SwUTrgBwMlBF2Lkdl
         4i+iUVjAOGmh+Q0vvsZ/gnesiPZ3Q8M7cz0DWG9STSO6hrEmiQsZGdXYJwrROJ/PeY
         6z+WShjunGDp8jlJuB3nilvxr6ApJ4ty8RS5sIvF0loHe9Ob1mNC0DNKmo60MEO/hg
         TP4cV12RijnlG2U5z0B9wxhO+JfMH4eAEhOZbfbCMA5pUxQ+NywXN+iAw0xL/SuEyR
         3TD4SozGGHIVXTcLO90v7Wgxt72hvN1cp0l03G/Dj4gLFMQik2VRqSxe4ZM/tMZN2z
         ZUaHhjDj6v+zw==
Date:   Fri, 4 Mar 2022 12:49:31 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Huacai Chen <chenhuacai@gmail.com>
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
Subject: Re: [PATCH V6 09/22] LoongArch: Add boot and setup routines
Message-ID: <YiHuuyqW8KSAri/M@kernel.org>
References: <20220226110338.77547-1-chenhuacai@loongson.cn>
 <20220226110338.77547-10-chenhuacai@loongson.cn>
 <YiCpYRwoUSmd/GE3@kernel.org>
 <CAAhV-H4-zVjjUkoVFw4ppg_tsM-wxBZmPr-2q8zuoLDHTWAE0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H4-zVjjUkoVFw4ppg_tsM-wxBZmPr-2q8zuoLDHTWAE0w@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Thu, Mar 03, 2022 at 10:47:53PM +0800, Huacai Chen wrote:
> Hi, Mike,
> 
> On Thu, Mar 3, 2022 at 7:41 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Sat, Feb 26, 2022 at 07:03:25PM +0800, Huacai Chen wrote:
> > > This patch adds basic boot, setup and reset routines for LoongArch.
> > > LoongArch uses UEFI-based firmware. The firmware uses ACPI and DMI/
> > > SMBIOS to pass configuration information to the Linux kernel (in elf
> > > format).
> > >
> > > Now the boot information passed to kernel is like this:
> > > 1, kernel get 3 register values (a0, a1 and a2) from bootloader.
> > > 2, a0 is "argc", a1 is "argv", so "kernel cmdline" comes from a0/a1.
> > > 3, a2 is "environ", which is a pointer to "struct bootparamsinterface".
> > > 4, "struct bootparamsinterface" include a "systemtable" pointer, whose
> > >    type is "efi_system_table_t". Most configuration information, include
> > >    ACPI tables and SMBIOS tables, come from here.
> > >
> > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > Cc: linux-efi@vger.kernel.org
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> >
> > > +void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
> > > +{
> > > +     memblock_mark_nomap(addr, size);
> > > +}
> >
> > Is there any problem if the memory ranges used by ACPI will be mapped into
> > the kernel page tables?
> >
> > If not, consider dropping this function.
>
> This API is mostly used for ACPI upgrading. ACPI upgrading alloc a
> normal memory block and then is used as ACPI memory, and this memory
> block will not be used by the page allocator. Other architectures,
> such as ARM64, do the same thing here.

ARM64 had quite a lot of issues with NOMAP memory, so I'd recommend to
avoid using memblock_mark_nomap() unless it is required by MMU constraints
on loongarch.

I'm not familiar with loongarch MMU details, so I can only give some
background for NOMAP for you to decide.

Marking memory region NOMAP is required when this region cannot be a part
of the kernel linear mapping because MMU does not allow aliased mappings
with different caching modes. E.g. in ARM64 case, ACPI memory that should
be mapped uncached cannot be mapped as cached in the kernel linear map.

If the memory block should not be used by the page allocator, it should be
memblock_reserve()'ed rather than marked NOMAP.
 
> > > diff --git a/arch/loongarch/kernel/mem.c b/arch/loongarch/kernel/mem.c
> > > new file mode 100644
> > > index 000000000000..361d108a2b82
> > > --- /dev/null
> > > +++ b/arch/loongarch/kernel/mem.c
> > > @@ -0,0 +1,89 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > > + */
> > > +#include <linux/fs.h>
> > > +#include <linux/mm.h>
> > > +#include <linux/memblock.h>
> > > +
> > > +#include <asm/bootinfo.h>
> > > +#include <asm/loongson.h>
> > > +#include <asm/sections.h>
> > > +
> > > +void __init early_memblock_init(void)
> > > +{
> > > +     int i;
> > > +     u32 mem_type;
> > > +     u64 mem_start, mem_end, mem_size;
> > > +
> > > +     /* Parse memory information */
> > > +     for (i = 0; i < loongson_mem_map->map_count; i++) {
> > > +             mem_type = loongson_mem_map->map[i].mem_type;
> > > +             mem_start = loongson_mem_map->map[i].mem_start;
> > > +             mem_size = loongson_mem_map->map[i].mem_size;
> > > +             mem_end = mem_start + mem_size;
> > > +
> > > +             switch (mem_type) {
> > > +             case ADDRESS_TYPE_SYSRAM:
> > > +                     memblock_add(mem_start, mem_size);
> > > +                     if (max_low_pfn < (mem_end >> PAGE_SHIFT))
> > > +                             max_low_pfn = mem_end >> PAGE_SHIFT;
> > > +                     break;
> > > +             }
> > > +     }
> > > +     memblock_set_current_limit(PFN_PHYS(max_low_pfn));
> > > +}
> > > +
> > > +void __init fw_init_memory(void)
> > > +{
> > > +     int i;
> > > +     u32 mem_type;
> > > +     u64 mem_start, mem_end, mem_size;
> > > +     unsigned long start_pfn, end_pfn;
> > > +     static unsigned long num_physpages;
> > > +
> > > +     /* Parse memory information */
> > > +     for (i = 0; i < loongson_mem_map->map_count; i++) {
> > > +             mem_type = loongson_mem_map->map[i].mem_type;
> > > +             mem_start = loongson_mem_map->map[i].mem_start;
> > > +             mem_size = loongson_mem_map->map[i].mem_size;
> > > +             mem_end = mem_start + mem_size;
> >
> > I think this loop can be merged with loop in early_memblock_init() then ...
> >
> > > +
> > > +             switch (mem_type) {
> > > +             case ADDRESS_TYPE_SYSRAM:
> > > +                     mem_start = PFN_ALIGN(mem_start);
> > > +                     mem_end = PFN_ALIGN(mem_end - PAGE_SIZE + 1);
> > > +                     num_physpages += (mem_size >> PAGE_SHIFT);
> > > +                     memblock_set_node(mem_start, mem_size, &memblock.memory, 0);
> >
> > this will become memblock_add_node()
> >
> > > +                     break;
> > > +             case ADDRESS_TYPE_ACPI:
> > > +                     mem_start = PFN_ALIGN(mem_start);
> > > +                     mem_end = PFN_ALIGN(mem_end - PAGE_SIZE + 1);
> > > +                     num_physpages += (mem_size >> PAGE_SHIFT);
> > > +                     memblock_add(mem_start, mem_size);
> > > +                     memblock_set_node(mem_start, mem_size, &memblock.memory, 0);
> >
> > as well as this.
> early_memblock_init() only adds the "usable" memory (SYSRAM) for early
> use and without numa node information. Other types of memory are
> handled later by fw_init_memory()/fw_init_numa_memory(), depending on
> whether CONFIG_NUMA is enabled. So, in
> fw_init_memory()/fw_init_numa_memory() we only need to call
> memblock_set_node() to add the node information for SYSRAM type.

There are two potential issues here with doing memblock_add() and
memblock_set_node() and memblock_reserve() separately with a couple of
functions called in between.

First, and most important is that you must to memblock_reserve() all the
memory used by the firmware, like ADDRESS_TYPE_ACPI, ADDRESS_TYPE_RESERVED,
kernel image, initrd etc *before* any call to memblock_alloc*()
functions. If you add memory to memblock before reserving firmware regions,
a call to memblock_alloc*() may allocate the used memory and all kinds of
errors may happen because of that. 

Second, presuming you use SRAT for NUMA information, if you set nodes in
memblock after there were memory allocations from memblock you may impair
the ability to hot-remove memory banks.

So ideally, the physical memory detection and registration should follow
something like:

* memblock_reserve() the memory used by firmware, kernel and initrd
* detect NUMA topology
* add memory regions along with their node ids to memblock.

s390::setup_arch() is a good example of doing early reservations:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/s390/kernel/setup.c#n988
 
> > > diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
> > > new file mode 100644
> > > index 000000000000..8dfe1d9b55f7
> > > --- /dev/null
> > > +++ b/arch/loongarch/kernel/setup.c
> > > +
> > > +static int usermem __initdata;
> > > +
> > > +static int __init early_parse_mem(char *p)
> > > +{
> > > +     phys_addr_t start, size;
> > > +
> > > +     /*
> > > +      * If a user specifies memory size, we
> > > +      * blow away any automatically generated
> > > +      * size.
> > > +      */
> > > +     if (usermem == 0) {
> > > +             usermem = 1;
> > > +             memblock_remove(memblock_start_of_DRAM(),
> > > +                     memblock_end_of_DRAM() - memblock_start_of_DRAM());
> > > +     }
> > > +     start = 0;
> > > +     size = memparse(p, &p);
> > > +     if (*p == '@')
> > > +             start = memparse(p + 1, &p);
> > > +
> > > +     memblock_add(start, size);
> > > +
> > > +     return 0;
> > > +}
> > > +early_param("mem", early_parse_mem);
> > > +
> > > +static int __init early_parse_memmap(char *p)
> > > +{
> > > +     char *oldp;
> > > +     u64 start_at, mem_size;
> > > +
> > > +     if (!p)
> > > +             return -EINVAL;
> > > +
> > > +     if (!strncmp(p, "exactmap", 8)) {
> > > +             pr_err("\"memmap=exactmap\" invalid on LoongArch\n");
> > > +             return 0;
> > > +     }
> > > +
> > > +     oldp = p;
> > > +     mem_size = memparse(p, &p);
> > > +     if (p == oldp)
> > > +             return -EINVAL;
> > > +
> > > +     if (*p == '@') {
> > > +             start_at = memparse(p+1, &p);
> > > +             memblock_add(start_at, mem_size);
> > > +     } else if (*p == '#') {
> > > +             pr_err("\"memmap=nn#ss\" (force ACPI data) invalid on LoongArch\n");
> > > +             return -EINVAL;
> > > +     } else if (*p == '$') {
> > > +             start_at = memparse(p+1, &p);
> > > +             memblock_add(start_at, mem_size);
> > > +             memblock_reserve(start_at, mem_size);
> > > +     } else {
> > > +             pr_err("\"memmap\" invalid format!\n");
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     if (*p == '\0') {
> > > +             usermem = 1;
> > > +             return 0;
> > > +     } else
> > > +             return -EINVAL;
> > > +}
> > > +early_param("memmap", early_parse_memmap);
> >
> > The memmap= processing is a hack indented to workaround bugs in firmware
> > related to the memory detection. Please don't copy if over unless there is
> > really strong reason.
>
> Hmmm, I have read the documents, most archs only support mem=limit,
> but MIPS support mem=limit@base. memmap not only supports
> memmap=limit@base, but also a lot of advanced syntax. LoongArch needs
> both limit and limit@base syntax. So can we make our code to support
> only mem=limit and memmap=limit@base, and remove all other syntax
> here?

The documentation describes what was there historically and both these
options tend not to play well with complex memory layouts.

If you must have them it's better to use x86 as an example rather than
MIPS, just take into the account that on x86 memory always starts from 0,
so they never needed to have a different base.

For what use-cases LoongArch needs options?

-- 
Sincerely yours,
Mike.
