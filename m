Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B912EBA18
	for <lists+linux-arch@lfdr.de>; Wed,  6 Jan 2021 07:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbhAFGjl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Jan 2021 01:39:41 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:46819 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbhAFGjl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jan 2021 01:39:41 -0500
X-Originating-IP: 90.112.190.212
Received: from [192.168.1.100] (lfbn-gre-1-231-212.w90-112.abo.wanadoo.fr [90.112.190.212])
        (Authenticated sender: alex@ghiti.fr)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id C21CFC0002;
        Wed,  6 Jan 2021 06:38:56 +0000 (UTC)
Subject: Re: [RFC PATCH 04/12] riscv: Allow to dynamically define VA_BITS
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
 <20210104195840.1593-5-alex@ghiti.fr>
 <CAAhSdy0Diu3nD+QswUUr7Ox+FdZGRedivJ6gNU2dYUCaOx8KjA@mail.gmail.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <6c3d062b-69e0-820e-0c45-53e6930c0350@ghiti.fr>
Date:   Wed, 6 Jan 2021 01:38:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAAhSdy0Diu3nD+QswUUr7Ox+FdZGRedivJ6gNU2dYUCaOx8KjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 1/5/21 à 7:06 AM, Anup Patel a écrit :
> On Tue, Jan 5, 2021 at 1:33 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>>
>> With 4-level page table folding at runtime, we don't know at compile time
>> the size of the virtual address space so we must set VA_BITS dynamically
>> so that sparsemem reserves the right amount of memory for struct pages.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> ---
>>   arch/riscv/Kconfig                 | 10 ----------
>>   arch/riscv/include/asm/pgtable.h   | 11 +++++++++--
>>   arch/riscv/include/asm/sparsemem.h |  6 +++++-
>>   3 files changed, 14 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 44377fd7860e..2979a44103be 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -122,16 +122,6 @@ config ZONE_DMA32
>>          bool
>>          default y if 64BIT
>>
>> -config VA_BITS
>> -       int
>> -       default 32 if 32BIT
>> -       default 39 if 64BIT
>> -
>> -config PA_BITS
>> -       int
>> -       default 34 if 32BIT
>> -       default 56 if 64BIT
>> -
>>   config PAGE_OFFSET
>>          hex
>>          default 0xC0000000 if 32BIT && MAXPHYSMEM_2GB
>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>> index 102b728ca146..c7973bfd65bc 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -43,8 +43,14 @@
>>    * struct pages to map half the virtual address space. Then
>>    * position vmemmap directly below the VMALLOC region.
>>    */
>> +#ifdef CONFIG_64BIT
>> +#define VA_BITS                39
>> +#else
>> +#define VA_BITS                32
>> +#endif
>> +
>>   #define VMEMMAP_SHIFT \
>> -       (CONFIG_VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
>> +       (VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
>>   #define VMEMMAP_SIZE   BIT(VMEMMAP_SHIFT)
>>   #define VMEMMAP_END    (VMALLOC_START - 1)
>>   #define VMEMMAP_START  (VMALLOC_START - VMEMMAP_SIZE)
>> @@ -83,6 +89,7 @@
>>   #endif /* CONFIG_64BIT */
>>
>>   #ifdef CONFIG_MMU
>> +
>>   /* Number of entries in the page global directory */
>>   #define PTRS_PER_PGD    (PAGE_SIZE / sizeof(pgd_t))
>>   /* Number of entries in the page table */
>> @@ -453,7 +460,7 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>>    * and give the kernel the other (upper) half.
>>    */
>>   #ifdef CONFIG_64BIT
>> -#define KERN_VIRT_START        (-(BIT(CONFIG_VA_BITS)) + TASK_SIZE)
>> +#define KERN_VIRT_START        (-(BIT(VA_BITS)) + TASK_SIZE)
>>   #else
>>   #define KERN_VIRT_START        FIXADDR_START
>>   #endif
>> diff --git a/arch/riscv/include/asm/sparsemem.h b/arch/riscv/include/asm/sparsemem.h
>> index 45a7018a8118..63acaecc3374 100644
>> --- a/arch/riscv/include/asm/sparsemem.h
>> +++ b/arch/riscv/include/asm/sparsemem.h
>> @@ -4,7 +4,11 @@
>>   #define _ASM_RISCV_SPARSEMEM_H
>>
>>   #ifdef CONFIG_SPARSEMEM
>> -#define MAX_PHYSMEM_BITS       CONFIG_PA_BITS
>> +#ifdef CONFIG_64BIT
>> +#define MAX_PHYSMEM_BITS       56
>> +#else
>> +#define MAX_PHYSMEM_BITS       34
>> +#endif /* CONFIG_64BIT */
>>   #define SECTION_SIZE_BITS      27
>>   #endif /* CONFIG_SPARSEMEM */
>>
>> --
>> 2.20.1
>>
> 
> Looks good to me.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,

> 
> Regards,
> Anup
> 

Alex
