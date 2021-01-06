Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470052EBA12
	for <lists+linux-arch@lfdr.de>; Wed,  6 Jan 2021 07:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbhAFGhS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Jan 2021 01:37:18 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:38173 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbhAFGhS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jan 2021 01:37:18 -0500
Received: from [192.168.1.100] (lfbn-gre-1-231-212.w90-112.abo.wanadoo.fr [90.112.190.212])
        (Authenticated sender: alex@ghiti.fr)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 26377200002;
        Wed,  6 Jan 2021 06:36:32 +0000 (UTC)
Subject: Re: [RFC PATCH 01/12] riscv: Move kernel mapping outside of linear
 mapping
To:     Anup Patel <anup@brainfault.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>, Christoph Hellwig <hch@lst.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
References: <20210104195840.1593-1-alex@ghiti.fr>
 <20210104195840.1593-2-alex@ghiti.fr>
 <CAAhSdy1h+Akz-esWVG2oeLuhjDedcJyvRntV5LuaK8LhirD=Sw@mail.gmail.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <a10129d7-33e4-ba05-7c50-3852ba2f1993@ghiti.fr>
Date:   Wed, 6 Jan 2021 01:36:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAAhSdy1h+Akz-esWVG2oeLuhjDedcJyvRntV5LuaK8LhirD=Sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Anup,

Le 1/5/21 à 6:40 AM, Anup Patel a écrit :
> On Tue, Jan 5, 2021 at 1:29 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>>
>> This is a preparatory patch for relocatable kernel and sv48 support.
>>
>> The kernel used to be linked at PAGE_OFFSET address therefore we could use
>> the linear mapping for the kernel mapping. But the relocated kernel base
>> address will be different from PAGE_OFFSET and since in the linear mapping,
>> two different virtual addresses cannot point to the same physical address,
>> the kernel mapping needs to lie outside the linear mapping so that we don't
>> have to copy it at the same physical offset.
>>
>> The kernel mapping is moved to the last 2GB of the address space and then
>> BPF and modules are also pushed to the same range since they have to lie
>> close to the kernel inside a 2GB window.
>>
>> Note then that KASLR implementation will simply have to move the kernel in
>> this 2GB range and modify BPF/modules regions accordingly.
>>
>> In addition, by moving the kernel to the end of the address space, both
>> sv39 and sv48 kernels will be exactly the same without needing to be
>> relocated at runtime.
> 
> Awesome ! This is a good approach with no performance impact.
> 
>>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> ---
>>   arch/riscv/boot/loader.lds.S     |  3 +-
>>   arch/riscv/include/asm/page.h    | 10 ++++-
>>   arch/riscv/include/asm/pgtable.h | 39 +++++++++++++------
>>   arch/riscv/kernel/head.S         |  3 +-
>>   arch/riscv/kernel/module.c       |  4 +-
>>   arch/riscv/kernel/vmlinux.lds.S  |  3 +-
>>   arch/riscv/mm/init.c             | 65 ++++++++++++++++++++++++--------
>>   arch/riscv/mm/physaddr.c         |  2 +-
>>   8 files changed, 94 insertions(+), 35 deletions(-)
>>
>> diff --git a/arch/riscv/boot/loader.lds.S b/arch/riscv/boot/loader.lds.S
>> index 47a5003c2e28..62d94696a19c 100644
>> --- a/arch/riscv/boot/loader.lds.S
>> +++ b/arch/riscv/boot/loader.lds.S
>> @@ -1,13 +1,14 @@
>>   /* SPDX-License-Identifier: GPL-2.0 */
>>
>>   #include <asm/page.h>
>> +#include <asm/pgtable.h>
>>
>>   OUTPUT_ARCH(riscv)
>>   ENTRY(_start)
>>
>>   SECTIONS
>>   {
>> -       . = PAGE_OFFSET;
>> +       . = KERNEL_LINK_ADDR;
>>
>>          .payload : {
>>                  *(.payload)
>> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
>> index 2d50f76efe48..98188e315e8d 100644
>> --- a/arch/riscv/include/asm/page.h
>> +++ b/arch/riscv/include/asm/page.h
>> @@ -90,18 +90,26 @@ typedef struct page *pgtable_t;
>>
>>   #ifdef CONFIG_MMU
>>   extern unsigned long va_pa_offset;
>> +extern unsigned long va_kernel_pa_offset;
>>   extern unsigned long pfn_base;
>>   #define ARCH_PFN_OFFSET                (pfn_base)
>>   #else
>>   #define va_pa_offset           0
>> +#define va_kernel_pa_offset    0
>>   #define ARCH_PFN_OFFSET                (PAGE_OFFSET >> PAGE_SHIFT)
>>   #endif /* CONFIG_MMU */
>>
>>   extern unsigned long max_low_pfn;
>>   extern unsigned long min_low_pfn;
>> +extern unsigned long kernel_virt_addr;
>>
>>   #define __pa_to_va_nodebug(x)  ((void *)((unsigned long) (x) + va_pa_offset))
>> -#define __va_to_pa_nodebug(x)  ((unsigned long)(x) - va_pa_offset)
>> +#define linear_mapping_va_to_pa(x)     ((unsigned long)(x) - va_pa_offset)
>> +#define kernel_mapping_va_to_pa(x)     \
>> +       ((unsigned long)(x) - va_kernel_pa_offset)
>> +#define __va_to_pa_nodebug(x)          \
>> +       (((x) < KERNEL_LINK_ADDR) ?             \
>> +               linear_mapping_va_to_pa(x) : kernel_mapping_va_to_pa(x))
>>
>>   #ifdef CONFIG_DEBUG_VIRTUAL
>>   extern phys_addr_t __virt_to_phys(unsigned long x);
>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>> index 183f1f4b2ae6..102b728ca146 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -11,23 +11,32 @@
>>
>>   #include <asm/pgtable-bits.h>
>>
>> -#ifndef __ASSEMBLY__
>> -
>> -/* Page Upper Directory not used in RISC-V */
>> -#include <asm-generic/pgtable-nopud.h>
>> -#include <asm/page.h>
>> -#include <asm/tlbflush.h>
>> -#include <linux/mm_types.h>
>> +#ifndef CONFIG_MMU
>> +#define KERNEL_VIRT_ADDR       PAGE_OFFSET
>> +#define KERNEL_LINK_ADDR       PAGE_OFFSET
>> +#else
>>
>> -#ifdef CONFIG_MMU
>> +#define ADDRESS_SPACE_END      (UL(-1))
>> +/*
>> + * Leave 2GB for kernel, modules and BPF at the end of the address space
>> + */
>> +#define KERNEL_VIRT_ADDR       (ADDRESS_SPACE_END - SZ_2G + 1)
>> +#define KERNEL_LINK_ADDR       KERNEL_VIRT_ADDR
>>
>>   #define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
>>   #define VMALLOC_END      (PAGE_OFFSET - 1)
>>   #define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
>>
>> +/* KASLR should leave at least 128MB for BPF after the kernel */
>>   #define BPF_JIT_REGION_SIZE    (SZ_128M)
>> -#define BPF_JIT_REGION_START   (PAGE_OFFSET - BPF_JIT_REGION_SIZE)
>> -#define BPF_JIT_REGION_END     (VMALLOC_END)
>> +#define BPF_JIT_REGION_START   PFN_ALIGN((unsigned long)&_end)
>> +#define BPF_JIT_REGION_END     (BPF_JIT_REGION_START + BPF_JIT_REGION_SIZE)
>> +
>> +/* Modules always live before the kernel */
>> +#ifdef CONFIG_64BIT
>> +#define VMALLOC_MODULE_START   (PFN_ALIGN((unsigned long)&_end) - SZ_2G)
>> +#define VMALLOC_MODULE_END     (PFN_ALIGN((unsigned long)&_start))
>> +#endif
> 
> This does not look right or I am missing something.
> 
> I think the VMALLOC_MODULE_START should be:
> #define VMALLOC_MODULE_START   (PFN_ALIGN((unsigned long)&_start) - SZ_2G)
> 

I think the patch is correct: worst-case, we want the first address of 
the module area to be able to access the last address of the kernel, so 
we must use _end and not _start to guarantee that the difference between 
those 2 addresses is not greater than 2GB.

>>
>>   /*
>>    * Roughly size the vmemmap space to be large enough to fit enough
>> @@ -57,9 +66,16 @@
>>   #define FIXADDR_SIZE     PGDIR_SIZE
>>   #endif
>>   #define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
>> -
>>   #endif
>>
>> +#ifndef __ASSEMBLY__
>> +
>> +/* Page Upper Directory not used in RISC-V */
>> +#include <asm-generic/pgtable-nopud.h>
>> +#include <asm/page.h>
>> +#include <asm/tlbflush.h>
>> +#include <linux/mm_types.h>
>> +
>>   #ifdef CONFIG_64BIT
>>   #include <asm/pgtable-64.h>
>>   #else
>> @@ -467,6 +483,7 @@ static inline void __kernel_map_pages(struct page *page, int numpages, int enabl
>>
>>   #define kern_addr_valid(addr)   (1) /* FIXME */
>>
>> +extern char _start[];
>>   extern void *dtb_early_va;
>>   extern uintptr_t dtb_early_pa;
>>   void setup_bootmem(void);
>> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>> index 7e849797c9c3..66f40c49bf68 100644
>> --- a/arch/riscv/kernel/head.S
>> +++ b/arch/riscv/kernel/head.S
>> @@ -69,7 +69,8 @@ pe_head_start:
>>   #ifdef CONFIG_MMU
>>   relocate:
>>          /* Relocate return address */
>> -       li a1, PAGE_OFFSET
>> +       la a1, kernel_virt_addr
>> +       REG_L a1, 0(a1)
>>          la a2, _start
>>          sub a1, a1, a2
>>          add ra, ra, a1
>> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
>> index 104fba889cf7..75a0b9541266 100644
>> --- a/arch/riscv/kernel/module.c
>> +++ b/arch/riscv/kernel/module.c
>> @@ -408,12 +408,10 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
>>   }
>>
>>   #if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
>> -#define VMALLOC_MODULE_START \
>> -        max(PFN_ALIGN((unsigned long)&_end - SZ_2G), VMALLOC_START)
>>   void *module_alloc(unsigned long size)
>>   {
>>          return __vmalloc_node_range(size, 1, VMALLOC_MODULE_START,
>> -                                   VMALLOC_END, GFP_KERNEL,
>> +                                   VMALLOC_MODULE_END, GFP_KERNEL,
>>                                      PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
>>                                      __builtin_return_address(0));
>>   }
>> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
>> index 3ffbd6cbdb86..c21dc46f41be 100644
>> --- a/arch/riscv/kernel/vmlinux.lds.S
>> +++ b/arch/riscv/kernel/vmlinux.lds.S
>> @@ -4,7 +4,8 @@
>>    * Copyright (C) 2017 SiFive
>>    */
>>
>> -#define LOAD_OFFSET PAGE_OFFSET
>> +#include <asm/pgtable.h>
>> +#define LOAD_OFFSET KERNEL_LINK_ADDR
>>   #include <asm/vmlinux.lds.h>
>>   #include <asm/page.h>
>>   #include <asm/cache.h>
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 8e577f14f120..9d06ff0e015a 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -23,6 +23,9 @@
>>
>>   #include "../kernel/head.h"
>>
>> +unsigned long kernel_virt_addr = KERNEL_VIRT_ADDR;
>> +EXPORT_SYMBOL(kernel_virt_addr);
>> +
>>   unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
>>                                                          __page_aligned_bss;
>>   EXPORT_SYMBOL(empty_zero_page);
>> @@ -201,8 +204,12 @@ void __init setup_bootmem(void)
>>   #ifdef CONFIG_MMU
>>   static struct pt_alloc_ops pt_ops;
>>
>> +/* Offset between linear mapping virtual address and kernel load address */
>>   unsigned long va_pa_offset;
>>   EXPORT_SYMBOL(va_pa_offset);
>> +/* Offset between kernel mapping virtual address and kernel load address */
>> +unsigned long va_kernel_pa_offset;
>> +EXPORT_SYMBOL(va_kernel_pa_offset);
>>   unsigned long pfn_base;
>>   EXPORT_SYMBOL(pfn_base);
>>
>> @@ -316,7 +323,7 @@ static phys_addr_t __init alloc_pmd_early(uintptr_t va)
>>   {
>>          uintptr_t pmd_num;
>>
>> -       pmd_num = (va - PAGE_OFFSET) >> PGDIR_SHIFT;
>> +       pmd_num = (va - kernel_virt_addr) >> PGDIR_SHIFT;
>>          BUG_ON(pmd_num >= NUM_EARLY_PMDS);
>>          return (uintptr_t)&early_pmd[pmd_num * PTRS_PER_PMD];
>>   }
>> @@ -431,17 +438,34 @@ static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
>>   #error "setup_vm() is called from head.S before relocate so it should not use absolute addressing."
>>   #endif
>>
>> +static uintptr_t load_pa, load_sz;
>> +
>> +static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size)
>> +{
>> +       uintptr_t va, end_va;
>> +
>> +       end_va = kernel_virt_addr + load_sz;
>> +       for (va = kernel_virt_addr; va < end_va; va += map_size)
>> +               create_pgd_mapping(pgdir, va,
>> +                                  load_pa + (va - kernel_virt_addr),
>> +                                  map_size, PAGE_KERNEL_EXEC);
>> +}
>> +
>>   asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>>   {
>> -       uintptr_t va, pa, end_va;
>> -       uintptr_t load_pa = (uintptr_t)(&_start);
>> -       uintptr_t load_sz = (uintptr_t)(&_end) - load_pa;
>> -       uintptr_t map_size = best_map_size(load_pa, MAX_EARLY_MAPPING_SIZE);
>> +       uintptr_t pa;
>> +       uintptr_t map_size;
>>   #ifndef __PAGETABLE_PMD_FOLDED
>>          pmd_t fix_bmap_spmd, fix_bmap_epmd;
>>   #endif
>>
>> +       load_pa = (uintptr_t)(&_start);
>> +       load_sz = (uintptr_t)(&_end) - load_pa;
>> +       map_size = best_map_size(load_pa, MAX_EARLY_MAPPING_SIZE);
>> +
>>          va_pa_offset = PAGE_OFFSET - load_pa;
>> +       va_kernel_pa_offset = kernel_virt_addr - load_pa;
>> +
>>          pfn_base = PFN_DOWN(load_pa);
>>
>>          /*
>> @@ -470,26 +494,22 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>>          create_pmd_mapping(fixmap_pmd, FIXADDR_START,
>>                             (uintptr_t)fixmap_pte, PMD_SIZE, PAGE_TABLE);
>>          /* Setup trampoline PGD and PMD */
>> -       create_pgd_mapping(trampoline_pg_dir, PAGE_OFFSET,
>> +       create_pgd_mapping(trampoline_pg_dir, kernel_virt_addr,
>>                             (uintptr_t)trampoline_pmd, PGDIR_SIZE, PAGE_TABLE);
>> -       create_pmd_mapping(trampoline_pmd, PAGE_OFFSET,
>> +       create_pmd_mapping(trampoline_pmd, kernel_virt_addr,
>>                             load_pa, PMD_SIZE, PAGE_KERNEL_EXEC);
>>   #else
>>          /* Setup trampoline PGD */
>> -       create_pgd_mapping(trampoline_pg_dir, PAGE_OFFSET,
>> +       create_pgd_mapping(trampoline_pg_dir, kernel_virt_addr,
>>                             load_pa, PGDIR_SIZE, PAGE_KERNEL_EXEC);
>>   #endif
>>
>>          /*
>> -        * Setup early PGD covering entire kernel which will allows
>> +        * Setup early PGD covering entire kernel which will allow
>>           * us to reach paging_init(). We map all memory banks later
>>           * in setup_vm_final() below.
>>           */
>> -       end_va = PAGE_OFFSET + load_sz;
>> -       for (va = PAGE_OFFSET; va < end_va; va += map_size)
>> -               create_pgd_mapping(early_pg_dir, va,
>> -                                  load_pa + (va - PAGE_OFFSET),
>> -                                  map_size, PAGE_KERNEL_EXEC);
>> +       create_kernel_page_table(early_pg_dir, map_size);
>>
>>   #ifndef __PAGETABLE_PMD_FOLDED
>>          /* Setup early PMD for DTB */
>> @@ -549,6 +569,7 @@ static void __init setup_vm_final(void)
>>          uintptr_t va, map_size;
>>          phys_addr_t pa, start, end;
>>          u64 i;
>> +       static struct vm_struct vm_kernel = { 0 };
>>
>>          /**
>>           * MMU is enabled at this point. But page table setup is not complete yet.
>> @@ -565,7 +586,7 @@ static void __init setup_vm_final(void)
>>                             __pa_symbol(fixmap_pgd_next),
>>                             PGDIR_SIZE, PAGE_TABLE);
>>
>> -       /* Map all memory banks */
>> +       /* Map all memory banks in the linear mapping */
>>          for_each_mem_range(i, &start, &end) {
>>                  if (start >= end)
>>                          break;
>> @@ -577,10 +598,22 @@ static void __init setup_vm_final(void)
>>                  for (pa = start; pa < end; pa += map_size) {
>>                          va = (uintptr_t)__va(pa);
>>                          create_pgd_mapping(swapper_pg_dir, va, pa,
>> -                                          map_size, PAGE_KERNEL_EXEC);
>> +                                          map_size, PAGE_KERNEL);
>>                  }
>>          }
>>
>> +       /* Map the kernel */
>> +       create_kernel_page_table(swapper_pg_dir, PMD_SIZE);
>> +
>> +       /* Reserve the vmalloc area occupied by the kernel */
>> +       vm_kernel.addr = (void *)kernel_virt_addr;
>> +       vm_kernel.phys_addr = load_pa;
>> +       vm_kernel.size = (load_sz + PMD_SIZE - 1) & ~(PMD_SIZE - 1);
>> +       vm_kernel.flags = VM_MAP | VM_NO_GUARD;
>> +       vm_kernel.caller = __builtin_return_address(0);
>> +
>> +       vm_area_add_early(&vm_kernel);
>> +
>>          /* Clear fixmap PTE and PMD mappings */
>>          clear_fixmap(FIX_PTE);
>>          clear_fixmap(FIX_PMD);
>> diff --git a/arch/riscv/mm/physaddr.c b/arch/riscv/mm/physaddr.c
>> index e8e4dcd39fed..35703d5ef5fd 100644
>> --- a/arch/riscv/mm/physaddr.c
>> +++ b/arch/riscv/mm/physaddr.c
>> @@ -23,7 +23,7 @@ EXPORT_SYMBOL(__virt_to_phys);
>>
>>   phys_addr_t __phys_addr_symbol(unsigned long x)
>>   {
>> -       unsigned long kernel_start = (unsigned long)PAGE_OFFSET;
>> +       unsigned long kernel_start = (unsigned long)kernel_virt_addr;
>>          unsigned long kernel_end = (unsigned long)_end;
>>
>>          /*
>> --
>> 2.20.1
>>
> 
> Apart from the minor comment above, this looks good to me.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks for your time Anup,

> 
> Regards,
> Anup
> 

Alex
