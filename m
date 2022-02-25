Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A1C4C40BD
	for <lists+linux-arch@lfdr.de>; Fri, 25 Feb 2022 09:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238707AbiBYIzP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Feb 2022 03:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237759AbiBYIzO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 Feb 2022 03:55:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2524B22A29E;
        Fri, 25 Feb 2022 00:54:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4F49106F;
        Fri, 25 Feb 2022 00:54:41 -0800 (PST)
Received: from [10.163.51.16] (unknown [10.163.51.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 086403F70D;
        Fri, 25 Feb 2022 00:54:39 -0800 (PST)
Subject: Re: [PATCH 25/30] nios2/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     Dinh Nguyen <dinguyen@kernel.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org
References: <1644805853-21338-1-git-send-email-anshuman.khandual@arm.com>
 <1644805853-21338-26-git-send-email-anshuman.khandual@arm.com>
 <50ac6dc2-7c71-2a8b-aa00-78926351b252@kernel.org>
 <637cfc45-60ad-3cd1-5127-76ecabb87def@arm.com>
Message-ID: <34d2e89c-5264-1510-ef8e-a4719b4114ee@arm.com>
Date:   Fri, 25 Feb 2022 14:24:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <637cfc45-60ad-3cd1-5127-76ecabb87def@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2/25/22 2:22 PM, Anshuman Khandual wrote:
> 
> On 2/25/22 7:01 AM, Dinh Nguyen wrote:
>> Hi Anshuman,
>>
>> On 2/13/22 20:30, Anshuman Khandual wrote:
>>> This defines and exports a platform specific custom vm_get_page_prot() via
>>> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
>>> macros can be dropped which are no longer needed.
>>>
>>> Cc: Dinh Nguyen <dinguyen@kernel.org>
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> Acked-by: Dinh Nguyen <dinguyen@kernel.org>
>>> ---
>>>   arch/nios2/Kconfig               |  1 +
>>>   arch/nios2/include/asm/pgtable.h | 16 ------------
>>>   arch/nios2/mm/init.c             | 45 ++++++++++++++++++++++++++++++++
>>>   3 files changed, 46 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
>>> index 33fd06f5fa41..85a58a357a3b 100644
>>> --- a/arch/nios2/Kconfig
>>> +++ b/arch/nios2/Kconfig
>>> @@ -6,6 +6,7 @@ config NIOS2
>>>       select ARCH_HAS_SYNC_DMA_FOR_CPU
>>>       select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>>>       select ARCH_HAS_DMA_SET_UNCACHED
>>> +    select ARCH_HAS_VM_GET_PAGE_PROT
>>>       select ARCH_NO_SWAP
>>>       select COMMON_CLK
>>>       select TIMER_OF
>>> diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
>>> index 4a995fa628ee..2678dad58a63 100644
>>> --- a/arch/nios2/include/asm/pgtable.h
>>> +++ b/arch/nios2/include/asm/pgtable.h
>>> @@ -40,24 +40,8 @@ struct mm_struct;
>>>    */
>>>     /* Remove W bit on private pages for COW support */
>>> -#define __P000    MKP(0, 0, 0)
>>> -#define __P001    MKP(0, 0, 1)
>>> -#define __P010    MKP(0, 0, 0)    /* COW */
>>> -#define __P011    MKP(0, 0, 1)    /* COW */
>>> -#define __P100    MKP(1, 0, 0)
>>> -#define __P101    MKP(1, 0, 1)
>>> -#define __P110    MKP(1, 0, 0)    /* COW */
>>> -#define __P111    MKP(1, 0, 1)    /* COW */
>>>     /* Shared pages can have exact HW mapping */
>>> -#define __S000    MKP(0, 0, 0)
>>> -#define __S001    MKP(0, 0, 1)
>>> -#define __S010    MKP(0, 1, 0)
>>> -#define __S011    MKP(0, 1, 1)
>>> -#define __S100    MKP(1, 0, 0)
>>> -#define __S101    MKP(1, 0, 1)
>>> -#define __S110    MKP(1, 1, 0)
>>> -#define __S111    MKP(1, 1, 1)
>>>     /* Used all over the kernel */
>>>   #define PAGE_KERNEL __pgprot(_PAGE_PRESENT | _PAGE_CACHED | _PAGE_READ | \
>>> diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
>>> index 613fcaa5988a..311b2146a248 100644
>>> --- a/arch/nios2/mm/init.c
>>> +++ b/arch/nios2/mm/init.c
>>> @@ -124,3 +124,48 @@ const char *arch_vma_name(struct vm_area_struct *vma)
>>>   {
>>>       return (vma->vm_start == KUSER_BASE) ? "[kuser]" : NULL;
>>>   }
>>> +
>>> +pgprot_t vm_get_page_prot(unsigned long vm_flags)
>>> +{
>>> +    switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
>>> +    case VM_NONE:
>>> +        return MKP(0, 0, 0);
>>> +    case VM_READ:
>>> +        return MKP(0, 0, 1);
>>> +    /* COW */
>>> +    case VM_WRITE:
>>> +        return MKP(0, 0, 0);
>>> +    /* COW */
>>> +    case VM_WRITE | VM_READ:
>>> +        return MKP(0, 0, 1);
>>> +    case VM_EXEC:
>>> +        return MKP(1, 0, 0);
>>> +    case VM_EXEC | VM_READ:
>>> +        return MKP(1, 0, 1);
>>> +    /* COW */
>>> +    case VM_EXEC | VM_WRITE:
>>> +        return MKP(1, 0, 0);
>>> +    /* COW */
>>> +    case VM_EXEC | VM_WRITE | VM_READ:
>>> +        return MKP(1, 0, 1);
>>> +    case VM_SHARED:
>>> +        return MKP(0, 0, 0);
>>> +    case VM_SHARED | VM_READ:
>>> +        return MKP(0, 0, 1);
>>> +    case VM_SHARED | VM_WRITE:
>>> +        return MKP(0, 1, 0);
>>> +    case VM_SHARED | VM_WRITE | VM_READ:
>>> +        return MKP(0, 1, 1);
>>> +    case VM_SHARED | VM_EXEC:
>>> +        return MKP(1, 0, 0);
>>> +    case VM_SHARED | VM_EXEC | VM_READ:
>>> +        return MKP(1, 0, 1);
>>> +    case VM_SHARED | VM_EXEC | VM_WRITE:
>>> +        return MKP(1, 1, 0);
>>> +    case VM_SHARED | VM_EXEC | VM_WRITE | VM_READ:
>>> +        return MKP(1, 1, 1);
>>> +    default:
>>> +        BUILD_BUG();
>>> +    }
>>> +}
>>> +EXPORT_SYMBOL(vm_get_page_prot);
>> I'm getting this compile error after applying this patch when build NIOS2:
> Hmm, that is strange.
> 
> Did you apply the entire series or atleast upto the nios2 patch ? Generic
> vm_get_page_prot() should not be called (which is build complaining here)
> when ARCH_HAS_VM_GET_PAGE_PROT is already enabled on nios2 platform.
> 
> Ran a quick build test on nios2 for the entire series and also just upto
> this particular patch, build was successful.
> 

Please refer to the latest version V2 instead.

https://lore.kernel.org/linux-mm/1645425519-9034-1-git-send-email-anshuman.khandual@arm.com/
