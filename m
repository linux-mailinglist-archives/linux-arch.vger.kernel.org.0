Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0863E4BF1B0
	for <lists+linux-arch@lfdr.de>; Tue, 22 Feb 2022 06:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiBVFpJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Feb 2022 00:45:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiBVFpJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Feb 2022 00:45:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B060B26AC5;
        Mon, 21 Feb 2022 21:44:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD011106F;
        Mon, 21 Feb 2022 21:44:42 -0800 (PST)
Received: from [10.163.49.161] (unknown [10.163.49.161])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E838A3F66F;
        Mon, 21 Feb 2022 21:44:39 -0800 (PST)
Subject: Re: [PATCH V2 08/30] m68k/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <1645425519-9034-1-git-send-email-anshuman.khandual@arm.com>
 <1645425519-9034-9-git-send-email-anshuman.khandual@arm.com>
 <CAMuHMdUrA4u5BTRuqTSn++vXFNn0w=HRmp9ZD_8SNZ1wMUKwwQ@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <5801fc8d-0046-8c08-0893-05dde66d48b1@arm.com>
Date:   Tue, 22 Feb 2022 11:14:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUrA4u5BTRuqTSn++vXFNn0w=HRmp9ZD_8SNZ1wMUKwwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2/21/22 5:24 PM, Geert Uytterhoeven wrote:
> Hi Anshuman,
> 
> On Mon, Feb 21, 2022 at 9:45 AM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>> This defines and exports a platform specific custom vm_get_page_prot() via
>> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
>> macros can be dropped which are no longer needed.
>>
>> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>> Cc: linux-m68k@lists.linux-m68k.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Thanks for your patch!
> 
>> --- a/arch/m68k/mm/init.c
>> +++ b/arch/m68k/mm/init.c
>> @@ -128,3 +128,107 @@ void __init mem_init(void)
>>         memblock_free_all();
>>         init_pointer_tables();
>>  }
>> +
>> +#ifdef CONFIG_COLDFIRE
>> +/*
>> + * Page protections for initialising protection_map. See mm/mmap.c
>> + * for use. In general, the bit positions are xwr, and P-items are
>> + * private, the S-items are shared.
>> + */
>> +pgprot_t vm_get_page_prot(unsigned long vm_flags)
> 
> Wouldn't it make more sense to add this to arch/m68k/mm/mcfmmu.c?

Sure, will move (#ifdef CONFIG_COLDFIRE will not be required anymore).

> 
>> +{
>> +       switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
>> +       case VM_NONE:
>> +               return PAGE_NONE;
>> +       case VM_READ:
>> +               return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
>> +                               CF_PAGE_READABLE);
>> +       case VM_WRITE:
>> +               return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
>> +                               CF_PAGE_WRITABLE);
>> +       case VM_WRITE | VM_READ:
>> +               return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
>> +                               CF_PAGE_READABLE | CF_PAGE_WRITABLE);
>> +       case VM_EXEC:
>> +               return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
>> +                               CF_PAGE_EXEC);
>> +       case VM_EXEC | VM_READ:
>> +               return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
>> +                               CF_PAGE_READABLE | CF_PAGE_EXEC);
>> +       case VM_EXEC | VM_WRITE:
>> +               return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
>> +                               CF_PAGE_WRITABLE | CF_PAGE_EXEC);
>> +       case VM_EXEC | VM_WRITE | VM_READ:
>> +               return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
>> +                               CF_PAGE_READABLE | CF_PAGE_WRITABLE |
>> +                               CF_PAGE_EXEC);
>> +       case VM_SHARED:
>> +               return PAGE_NONE;
>> +       case VM_SHARED | VM_READ:
>> +               return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
>> +                               CF_PAGE_READABLE);
> 
> This is the same as the plain VM_READ case.
> Perhaps they can be merged?

IMHO, it is worth preserving the existing switch case sequence as vm_flags
moves linearly from VM_NONE to (VM_SHARED|VM_EXEC|VM_WRITE|VM_READ). This
proposal did not attempt to further optimize any common page prot values
for various vm_flags combinations even on other platforms.

> 
>> +       case VM_SHARED | VM_WRITE:
>> +               return PAGE_SHARED;
>> +       case VM_SHARED | VM_WRITE | VM_READ:
>> +               return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
>> +                               CF_PAGE_READABLE | CF_PAGE_SHARED);
>> +       case VM_SHARED | VM_EXEC:
>> +               return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
>> +                               CF_PAGE_EXEC);
> 
> Same as plain VM_EXEC.
> 
>> +       case VM_SHARED | VM_EXEC | VM_READ:
>> +               return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
>> +                               CF_PAGE_READABLE | CF_PAGE_EXEC);
> 
> Same as plain VM_EXEC | VM_READ.
> 
>> +       case VM_SHARED | VM_EXEC | VM_WRITE:
>> +               return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
>> +                               CF_PAGE_SHARED | CF_PAGE_EXEC);
>> +       case VM_SHARED | VM_EXEC | VM_WRITE | VM_READ:
>> +               return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
>> +                               CF_PAGE_READABLE | CF_PAGE_SHARED |
>> +                               CF_PAGE_EXEC);
>> +       default:
>> +               BUILD_BUG();
>> +       }
>> +}
>> +#endif
>> +
>> +#ifdef CONFIG_SUN3
>> +/*
>> + * Page protections for initialising protection_map. The sun3 has only two
>> + * protection settings, valid (implying read and execute) and writeable. These
>> + * are as close as we can get...
>> + */
>> +pgprot_t vm_get_page_prot(unsigned long vm_flags)
> 
> Wouldn't it make more sense to add this to arch/m68k/mm/sun3mmu.c?

Sure, will move (#ifdef CONFIG_SUN3 will not be required anymore).

> 
>> +{
>> +       switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
>> +       case VM_NONE:
>> +               return PAGE_NONE;
>> +       case VM_READ:
>> +               return PAGE_READONLY;
>> +       case VM_WRITE:
>> +       case VM_WRITE | VM_READ:
> 
> So you did merge some of them...

Only when they follow vm_flags linear sequence.

> 
>> +               return PAGE_COPY;
>> +       case VM_EXEC:
>> +       case VM_EXEC | VM_READ:
>> +               return PAGE_READONLY;
> 
> But not all? More below...

Right, because did not want to shuffle up vm_flags linear sequence.

> 
>> +       case VM_EXEC | VM_WRITE:
>> +       case VM_EXEC | VM_WRITE | VM_READ:
>> +               return PAGE_COPY;
>> +       case VM_SHARED:
>> +               return PAGE_NONE;
>> +       case VM_SHARED | VM_READ:
>> +               return PAGE_READONLY;
>> +       case VM_SHARED | VM_WRITE:
>> +       case VM_SHARED | VM_WRITE | VM_READ:
>> +               return PAGE_SHARED;
>> +       case VM_SHARED | VM_EXEC:
>> +       case VM_SHARED | VM_EXEC | VM_READ:
>> +               return PAGE_READONLY;
>> +       case VM_SHARED | VM_EXEC | VM_WRITE:
>> +       case VM_SHARED | VM_EXEC | VM_WRITE | VM_READ:
>> +               return PAGE_SHARED;
>> +       default:
>> +               BUILD_BUG();
>> +       }
>> +}
>> +#endif
>> +EXPORT_SYMBOL(vm_get_page_prot);
>> diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
>> index ecbe948f4c1a..495ba0ea083c 100644
>> --- a/arch/m68k/mm/motorola.c
>> +++ b/arch/m68k/mm/motorola.c
>> @@ -400,12 +400,9 @@ void __init paging_init(void)
>>
>>         /* Fix the cache mode in the page descriptors for the 680[46]0.  */
>>         if (CPU_IS_040_OR_060) {
>> -               int i;
>>  #ifndef mm_cachebits
>>                 mm_cachebits = _PAGE_CACHE040;
>>  #endif
>> -               for (i = 0; i < 16; i++)
>> -                       pgprot_val(protection_map[i]) |= _PAGE_CACHE040;
>>         }
>>
>>         min_addr = m68k_memory[0].addr;
>> @@ -483,3 +480,48 @@ void __init paging_init(void)
>>         max_zone_pfn[ZONE_DMA] = memblock_end_of_DRAM();
>>         free_area_init(max_zone_pfn);
>>  }
>> +
>> +/*
>> + * The m68k can't do page protection for execute, and considers that
>> + * the same are read. Also, write permissions imply read permissions.
>> + * This is the closest we can get..
>> + */
>> +pgprot_t vm_get_page_prot(unsigned long vm_flags)
> 
> Good, this one is in arch/m68k/mm/motorola.c :-)
> 
>> +{
>> +       unsigned long cachebits = 0;
>> +
>> +       if (CPU_IS_040_OR_060)
>> +               cachebits = _PAGE_CACHE040;
> 
> If you would use the non-"_C"-variants (e.g. PAGE_NONE instead of
> PAGE_NONE_C) below, you would get the cachebits handling for free!
> After that, the "_C" variants are no longer used, and can be removed.
> Cfr. arch/m68k/include/asm/motorola_pgtable.h:

Right.

> 
>     #define PAGE_NONE       __pgprot(_PAGE_PROTNONE | _PAGE_ACCESSED |
> mm_cachebits)
>     #define PAGE_SHARED     __pgprot(_PAGE_PRESENT | _PAGE_ACCESSED |
> mm_cachebits)
>     #define PAGE_COPY       __pgprot(_PAGE_PRESENT | _PAGE_RONLY |
> _PAGE_ACCESSED | mm_cachebits)
>     #define PAGE_READONLY   __pgprot(_PAGE_PRESENT | _PAGE_RONLY |
> _PAGE_ACCESSED | mm_cachebits)
>     #define PAGE_KERNEL     __pgprot(_PAGE_PRESENT | _PAGE_DIRTY |
> _PAGE_ACCESSED | mm_cachebits)
> 
>     /* Alternate definitions that are compile time constants, for
>        initializing protection_map.  The cachebits are fixed later.  */
>     #define PAGE_NONE_C     __pgprot(_PAGE_PROTNONE | _PAGE_ACCESSED)
>     #define PAGE_SHARED_C   __pgprot(_PAGE_PRESENT | _PAGE_ACCESSED)
>     #define PAGE_COPY_C     __pgprot(_PAGE_PRESENT | _PAGE_RONLY |
> _PAGE_ACCESSED)
>     #define PAGE_READONLY_C __pgprot(_PAGE_PRESENT | _PAGE_RONLY |
> _PAGE_ACCESSED)

Will drop all _C definitions and change switch case as mentioned above.

> 
> BTW, this shows you left a reference in a comment to the now-gone
> "protection_map".  There are several more across the tree.

Right, will remove them all.

> 
>> +
>> +       switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
>> +       case VM_NONE:
>> +               return __pgprot(pgprot_val(PAGE_NONE_C) | cachebits);
>> +       case VM_READ:
>> +               return __pgprot(pgprot_val(PAGE_READONLY_C) | cachebits);
>> +       case VM_WRITE:
>> +       case VM_WRITE | VM_READ:
>> +               return __pgprot(pgprot_val(PAGE_COPY_C) | cachebits);
>> +       case VM_EXEC:
>> +       case VM_EXEC | VM_READ:
>> +               return __pgprot(pgprot_val(PAGE_READONLY_C) | cachebits);
>> +       case VM_EXEC | VM_WRITE:
>> +       case VM_EXEC | VM_WRITE | VM_READ:
>> +               return __pgprot(pgprot_val(PAGE_COPY_C) | cachebits);
>> +       case VM_SHARED:
>> +               return __pgprot(pgprot_val(PAGE_NONE_C) | cachebits);
> 
> Same as the VM_NONE case.  More to be merged below...

As explained earlier.
