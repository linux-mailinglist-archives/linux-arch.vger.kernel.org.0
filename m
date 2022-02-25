Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C863A4C47C6
	for <lists+linux-arch@lfdr.de>; Fri, 25 Feb 2022 15:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiBYOjR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Feb 2022 09:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiBYOjR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 Feb 2022 09:39:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66B71AE656;
        Fri, 25 Feb 2022 06:38:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6225260FD3;
        Fri, 25 Feb 2022 14:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D44C340E7;
        Fri, 25 Feb 2022 14:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645799923;
        bh=NPDWNX4z15E/nqAD2vGd2TQeDDWREovDKjiNWAiQWYI=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=LLFcRuCqAx0Ofpr1UyhOV9cVmRpmEYfshwPkdi7vYBN4BpX5xl3IPqDVsga3LHPcL
         yviGcRxmJEtO3joHSepSfmGTd6eUAAK9mWFMw/HXA8ypbeUfySxWQeo3OMO4uY90TC
         40asBPPg/Npk5RJI1PRFGI/utCx0Tl3znNYEfozp1/8NxSlpHXe8n9iImgG++sEaUY
         jDUaCnumZvyf4M0zH4CmE2dDIcRF1+KzXoHySpZWWeTZ9q4CKPJqEcIe/mz8KhA8kV
         N0Vx/NbOuXHsZaLsmt2lpbrMFvFwxP8Ro2sShP3875LE4dGnF6UxL9vWIymLS3Zp7q
         wtvWT/sj9f2Ag==
Message-ID: <153130cc-e8d2-e65a-ff83-0a5ed243cc1c@kernel.org>
Date:   Fri, 25 Feb 2022 08:38:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 25/30] nios2/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Content-Language: en-US
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org
References: <1644805853-21338-1-git-send-email-anshuman.khandual@arm.com>
 <1644805853-21338-26-git-send-email-anshuman.khandual@arm.com>
 <50ac6dc2-7c71-2a8b-aa00-78926351b252@kernel.org>
 <637cfc45-60ad-3cd1-5127-76ecabb87def@arm.com>
 <7043506b-ad04-4572-316c-c5498873b8b1@kernel.org>
In-Reply-To: <7043506b-ad04-4572-316c-c5498873b8b1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2/25/22 08:29, Dinh Nguyen wrote:
> 
> 
> On 2/25/22 02:52, Anshuman Khandual wrote:
>>
>>
>> On 2/25/22 7:01 AM, Dinh Nguyen wrote:
>>> Hi Anshuman,
>>>
>>> On 2/13/22 20:30, Anshuman Khandual wrote:
>>>> This defines and exports a platform specific custom 
>>>> vm_get_page_prot() via
>>>> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and 
>>>> __PXXX
>>>> macros can be dropped which are no longer needed.
>>>>
>>>> Cc: Dinh Nguyen <dinguyen@kernel.org>
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> Acked-by: Dinh Nguyen <dinguyen@kernel.org>
>>>> ---
>>>>    arch/nios2/Kconfig               |  1 +
>>>>    arch/nios2/include/asm/pgtable.h | 16 ------------
>>>>    arch/nios2/mm/init.c             | 45 
>>>> ++++++++++++++++++++++++++++++++
>>>>    3 files changed, 46 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
>>>> index 33fd06f5fa41..85a58a357a3b 100644
>>>> --- a/arch/nios2/Kconfig
>>>> +++ b/arch/nios2/Kconfig
>>>> @@ -6,6 +6,7 @@ config NIOS2
>>>>        select ARCH_HAS_SYNC_DMA_FOR_CPU
>>>>        select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>>>>        select ARCH_HAS_DMA_SET_UNCACHED
>>>> +    select ARCH_HAS_VM_GET_PAGE_PROT
>>>>        select ARCH_NO_SWAP
>>>>        select COMMON_CLK
>>>>        select TIMER_OF
>>>> diff --git a/arch/nios2/include/asm/pgtable.h 
>>>> b/arch/nios2/include/asm/pgtable.h
>>>> index 4a995fa628ee..2678dad58a63 100644
>>>> --- a/arch/nios2/include/asm/pgtable.h
>>>> +++ b/arch/nios2/include/asm/pgtable.h
>>>> @@ -40,24 +40,8 @@ struct mm_struct;
>>>>     */
>>>>      /* Remove W bit on private pages for COW support */
>>>> -#define __P000    MKP(0, 0, 0)
>>>> -#define __P001    MKP(0, 0, 1)
>>>> -#define __P010    MKP(0, 0, 0)    /* COW */
>>>> -#define __P011    MKP(0, 0, 1)    /* COW */
>>>> -#define __P100    MKP(1, 0, 0)
>>>> -#define __P101    MKP(1, 0, 1)
>>>> -#define __P110    MKP(1, 0, 0)    /* COW */
>>>> -#define __P111    MKP(1, 0, 1)    /* COW */
>>>>      /* Shared pages can have exact HW mapping */
>>>> -#define __S000    MKP(0, 0, 0)
>>>> -#define __S001    MKP(0, 0, 1)
>>>> -#define __S010    MKP(0, 1, 0)
>>>> -#define __S011    MKP(0, 1, 1)
>>>> -#define __S100    MKP(1, 0, 0)
>>>> -#define __S101    MKP(1, 0, 1)
>>>> -#define __S110    MKP(1, 1, 0)
>>>> -#define __S111    MKP(1, 1, 1)
>>>>      /* Used all over the kernel */
>>>>    #define PAGE_KERNEL __pgprot(_PAGE_PRESENT | _PAGE_CACHED | 
>>>> _PAGE_READ | \
>>>> diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
>>>> index 613fcaa5988a..311b2146a248 100644
>>>> --- a/arch/nios2/mm/init.c
>>>> +++ b/arch/nios2/mm/init.c
>>>> @@ -124,3 +124,48 @@ const char *arch_vma_name(struct vm_area_struct 
>>>> *vma)
>>>>    {
>>>>        return (vma->vm_start == KUSER_BASE) ? "[kuser]" : NULL;
>>>>    }
>>>> +
>>>> +pgprot_t vm_get_page_prot(unsigned long vm_flags)
>>>> +{
>>>> +    switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
>>>> +    case VM_NONE:
>>>> +        return MKP(0, 0, 0);
>>>> +    case VM_READ:
>>>> +        return MKP(0, 0, 1);
>>>> +    /* COW */
>>>> +    case VM_WRITE:
>>>> +        return MKP(0, 0, 0);
>>>> +    /* COW */
>>>> +    case VM_WRITE | VM_READ:
>>>> +        return MKP(0, 0, 1);
>>>> +    case VM_EXEC:
>>>> +        return MKP(1, 0, 0);
>>>> +    case VM_EXEC | VM_READ:
>>>> +        return MKP(1, 0, 1);
>>>> +    /* COW */
>>>> +    case VM_EXEC | VM_WRITE:
>>>> +        return MKP(1, 0, 0);
>>>> +    /* COW */
>>>> +    case VM_EXEC | VM_WRITE | VM_READ:
>>>> +        return MKP(1, 0, 1);
>>>> +    case VM_SHARED:
>>>> +        return MKP(0, 0, 0);
>>>> +    case VM_SHARED | VM_READ:
>>>> +        return MKP(0, 0, 1);
>>>> +    case VM_SHARED | VM_WRITE:
>>>> +        return MKP(0, 1, 0);
>>>> +    case VM_SHARED | VM_WRITE | VM_READ:
>>>> +        return MKP(0, 1, 1);
>>>> +    case VM_SHARED | VM_EXEC:
>>>> +        return MKP(1, 0, 0);
>>>> +    case VM_SHARED | VM_EXEC | VM_READ:
>>>> +        return MKP(1, 0, 1);
>>>> +    case VM_SHARED | VM_EXEC | VM_WRITE:
>>>> +        return MKP(1, 1, 0);
>>>> +    case VM_SHARED | VM_EXEC | VM_WRITE | VM_READ:
>>>> +        return MKP(1, 1, 1);
>>>> +    default:
>>>> +        BUILD_BUG();
>>>> +    }
>>>> +}
>>>> +EXPORT_SYMBOL(vm_get_page_prot);
>>>
>>> I'm getting this compile error after applying this patch when build 
>>> NIOS2:
>>
>> Hmm, that is strange.
>>
>> Did you apply the entire series or atleast upto the nios2 patch ? Generic
>> vm_get_page_prot() should not be called (which is build complaining here)
>> when ARCH_HAS_VM_GET_PAGE_PROT is already enabled on nios2 platform.
>>
>> Ran a quick build test on nios2 for the entire series and also just upto
>> this particular patch, build was successful.
>>
> 
> Ok, I did not apply the whole series, just this patch.
> 


Is someone taking this whole series or should I just take this patch?

Dinh
