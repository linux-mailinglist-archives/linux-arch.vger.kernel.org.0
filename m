Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22334FA752
	for <lists+linux-arch@lfdr.de>; Sat,  9 Apr 2022 13:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbiDILia (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 Apr 2022 07:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiDILi3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 9 Apr 2022 07:38:29 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5576E6565;
        Sat,  9 Apr 2022 04:36:22 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KbCkC4fZ6z9sTL;
        Sat,  9 Apr 2022 13:36:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lY7tFaIkTcqy; Sat,  9 Apr 2022 13:36:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KbCkC3V0xz9sT3;
        Sat,  9 Apr 2022 13:36:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 61A1F8B76D;
        Sat,  9 Apr 2022 13:36:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xy5JHFm3eEDp; Sat,  9 Apr 2022 13:36:19 +0200 (CEST)
Received: from [192.168.203.47] (unknown [192.168.203.47])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 88E408B765;
        Sat,  9 Apr 2022 13:36:18 +0200 (CEST)
Message-ID: <8f1d5ba5-c03e-d222-ffc0-d9a6baea1037@csgroup.eu>
Date:   Sat, 9 Apr 2022 13:36:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V4 2/7] powerpc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Content-Language: fr-FR
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20220407103251.1209606-1-anshuman.khandual@arm.com>
 <20220407103251.1209606-3-anshuman.khandual@arm.com>
 <e860f404-af69-aebc-c5eb-8822a585e653@csgroup.eu>
In-Reply-To: <e860f404-af69-aebc-c5eb-8822a585e653@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 08/04/2022 à 14:53, Christophe Leroy a écrit :
> 
> 
> Le 07/04/2022 à 12:32, Anshuman Khandual a écrit :
>> This defines and exports a platform specific custom vm_get_page_prot() 
>> via
>> subscribing ARCH_HAS_VM_GET_PAGE_PROT. While here, this also localizes
>> arch_vm_get_page_prot() as powerpc_vm_get_page_prot() and moves it near
>> vm_get_page_prot().
>>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   arch/powerpc/Kconfig            |  1 +
>>   arch/powerpc/include/asm/mman.h | 12 ------------
>>   arch/powerpc/mm/mmap.c          | 26 ++++++++++++++++++++++++++
>>   3 files changed, 27 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 174edabb74fa..eb9b6ddbf92f 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -140,6 +140,7 @@ config PPC
>>       select ARCH_HAS_TICK_BROADCAST        if 
>> GENERIC_CLOCKEVENTS_BROADCAST
>>       select ARCH_HAS_UACCESS_FLUSHCACHE
>>       select ARCH_HAS_UBSAN_SANITIZE_ALL
>> +    select ARCH_HAS_VM_GET_PAGE_PROT
>>       select ARCH_HAVE_NMI_SAFE_CMPXCHG
>>       select ARCH_KEEP_MEMBLOCK
>>       select ARCH_MIGHT_HAVE_PC_PARPORT
>> diff --git a/arch/powerpc/include/asm/mman.h 
>> b/arch/powerpc/include/asm/mman.h
>> index 7cb6d18f5cd6..1b024e64c8ec 100644
>> --- a/arch/powerpc/include/asm/mman.h
>> +++ b/arch/powerpc/include/asm/mman.h
>> @@ -24,18 +24,6 @@ static inline unsigned long 
>> arch_calc_vm_prot_bits(unsigned long prot,
>>   }
>>   #define arch_calc_vm_prot_bits(prot, pkey) 
>> arch_calc_vm_prot_bits(prot, pkey)
>> -static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
>> -{
>> -#ifdef CONFIG_PPC_MEM_KEYS
>> -    return (vm_flags & VM_SAO) ?
>> -        __pgprot(_PAGE_SAO | vmflag_to_pte_pkey_bits(vm_flags)) :
>> -        __pgprot(0 | vmflag_to_pte_pkey_bits(vm_flags));
>> -#else
>> -    return (vm_flags & VM_SAO) ? __pgprot(_PAGE_SAO) : __pgprot(0);
>> -#endif
>> -}
>> -#define arch_vm_get_page_prot(vm_flags) arch_vm_get_page_prot(vm_flags)
>> -
>>   static inline bool arch_validate_prot(unsigned long prot, unsigned 
>> long addr)
>>   {
>>       if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM | 
>> PROT_SAO))
>> diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
>> index c475cf810aa8..cd17bd6fa36b 100644
>> --- a/arch/powerpc/mm/mmap.c
>> +++ b/arch/powerpc/mm/mmap.c
>> @@ -254,3 +254,29 @@ void arch_pick_mmap_layout(struct mm_struct *mm, 
>> struct rlimit *rlim_stack)
>>           mm->get_unmapped_area = arch_get_unmapped_area_topdown;
>>       }
>>   }
>> +
>> +#ifdef CONFIG_PPC64
>> +static pgprot_t powerpc_vm_get_page_prot(unsigned long vm_flags)
>> +{
>> +#ifdef CONFIG_PPC_MEM_KEYS
>> +    return (vm_flags & VM_SAO) ?
>> +        __pgprot(_PAGE_SAO | vmflag_to_pte_pkey_bits(vm_flags)) :
>> +        __pgprot(0 | vmflag_to_pte_pkey_bits(vm_flags));
>> +#else
>> +    return (vm_flags & VM_SAO) ? __pgprot(_PAGE_SAO) : __pgprot(0);
>> +#endif
>> +}
>> +#else
>> +static pgprot_t powerpc_vm_get_page_prot(unsigned long vm_flags)
>> +{
>> +    return __pgprot(0);
>> +}
>> +#endif /* CONFIG_PPC64 */
> 
> Can we reduce this forest of #ifdefs and make it more readable ?
> 
> mm/mmap.c is going away with patch 
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/d6d849621f821af253e777a24eda4c648814a76e.1646847562.git.christophe.leroy@csgroup.eu/ 
> 
> 
> So it would be better to add two versions of vm_get_page_prot(), for 
> instance one in mm/pgtable_64.c and one in mm/pgtable_32.c

Indeed, you don't need anything at all for PPC32. All you need to do is

	select ARCH_HAS_VM_GET_PAGE_PROT if PPC64

And in fact it could even be PPC_BOOK3S_64 instead of PPC64 because 
CONFIG_PPC_MEM_KEYS depends on PPC_BOOK3S_64 and _PAGE_SAO is 0 on 
nohash/64.

So you can then put it into arch/powerpc/mm/book3s64/pgtable.c


> 
> 
>> +
>> +pgprot_t vm_get_page_prot(unsigned long vm_flags)
>> +{
>> +    return __pgprot(pgprot_val(protection_map[vm_flags &
>> +            (VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]) |
>> +           pgprot_val(powerpc_vm_get_page_prot(vm_flags)));
>> +}
>> +EXPORT_SYMBOL(vm_get_page_prot);
> 
> By the way I'm a bit puzzled with the name powerpc_vm_get_page_prot(), 
> the name suggests that it's just a powerpc replacement of 
> vm_get_page_prot(). I'd prefer if it was named __vm_get_page_prot(), it 
> would be clearer that it is a complement to vm_get_page_prot() and not a 
> remplacement.
> 
> Christophe
