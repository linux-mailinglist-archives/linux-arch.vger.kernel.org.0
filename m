Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD9CEBB1F7
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2019 12:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405672AbfIWKLc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Sep 2019 06:11:32 -0400
Received: from foss.arm.com ([217.140.110.172]:39990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405389AbfIWKLc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Sep 2019 06:11:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C59CA1000;
        Mon, 23 Sep 2019 03:11:31 -0700 (PDT)
Received: from [10.162.40.137] (p8cg001049571a15.blr.arm.com [10.162.40.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 537933F694;
        Mon, 23 Sep 2019 03:11:29 -0700 (PDT)
Subject: Re: [PATCH] arm64: use generic free_initrd_mem()
To:     Mike Rapoport <rppt@kernel.org>, Laura Abbott <labbott@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <1568618488-19055-1-git-send-email-rppt@kernel.org>
 <0ba20aa4-d2dd-2263-6b5f-16a5c8a39f67@redhat.com>
 <20190916135542.GC5196@rapoport-lnx>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <e1ffc4f9-91cc-a4e1-b549-c28a392bdc71@arm.com>
Date:   Mon, 23 Sep 2019 15:41:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190916135542.GC5196@rapoport-lnx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 09/16/2019 07:25 PM, Mike Rapoport wrote:
> (added linux-arch)
> 
> On Mon, Sep 16, 2019 at 08:23:29AM -0400, Laura Abbott wrote:
>> On 9/16/19 8:21 AM, Mike Rapoport wrote:
>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>
>>> arm64 calls memblock_free() for the initrd area in its implementation of
>>> free_initrd_mem(), but this call has no actual effect that late in the boot
>>> process. By the time initrd is freed, all the reserved memory is managed by
>>> the page allocator and the memblock.reserved is unused, so there is no
>>> point to update it.
>>>
>>
>> People like to use memblock for keeping track of memory even if it has no
>> actual effect. We made this change explicitly (see 05c58752f9dc ("arm64: To remove
>> initrd reserved area entry from memblock") That said, moving to the generic
>> APIs would be nice. Maybe we can find another place to update the accounting?
> 
> Any other place in arch/arm64 would make it messy because it would have to
> duplicate keepinitrd logic.
> 
> We could put the memblock_free() in the generic free_initrd_mem() with
> something like:
> 
> diff --git a/init/initramfs.c b/init/initramfs.c
> index c47dad0..403c6a0 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -531,6 +531,10 @@ void __weak free_initrd_mem(unsigned long start,
> unsigned long end)
>  {
>         free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
>                         "initrd");
> +
> +#ifdef CONFIG_ARCH_KEEP_MEMBLOCK
> +       memblock_free(__virt_to_phys(start), end - start);
> +#endif
>  }

This makes sense.

>  
>  #ifdef CONFIG_KEXEC_CORE
> 
> 
> Then powerpc and s390 folks will also be able to track the initrd memory :)

Sure.

> 
>>> Without the memblock_free() call the only difference between arm64 and the
>>> generic versions of free_initrd_mem() is the memory poisoning. Switching
>>> arm64 to the generic version will enable the poisoning.
>>>
>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>>> ---
>>>
>>> I've boot tested it on qemu and I've checked that kexec works.
>>>
>>>  arch/arm64/mm/init.c | 8 --------
>>>  1 file changed, 8 deletions(-)
>>>
>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>> index f3c7952..8ad2934 100644
>>> --- a/arch/arm64/mm/init.c
>>> +++ b/arch/arm64/mm/init.c
>>> @@ -567,14 +567,6 @@ void free_initmem(void)
>>>  	unmap_kernel_range((u64)__init_begin, (u64)(__init_end - __init_begin));
>>>  }
>>> -#ifdef CONFIG_BLK_DEV_INITRD
>>> -void __init free_initrd_mem(unsigned long start, unsigned long end)
>>> -{
>>> -	free_reserved_area((void *)start, (void *)end, 0, "initrd");
>>> -	memblock_free(__virt_to_phys(start), end - start);
>>> -}
>>> -#endif
>>> -
>>>  /*
>>>   * Dump out memory limit information on panic.
>>>   */
>>>
>>
> 
