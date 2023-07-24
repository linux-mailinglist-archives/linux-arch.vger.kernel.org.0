Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF23C75EEA2
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jul 2023 11:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjGXJFu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jul 2023 05:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGXJFs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jul 2023 05:05:48 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BB1187;
        Mon, 24 Jul 2023 02:05:45 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DA42BC0005;
        Mon, 24 Jul 2023 09:05:40 +0000 (UTC)
Message-ID: <292abea1-59b7-13d4-0b27-ac00f7e7f20e@ghiti.fr>
Date:   Mon, 24 Jul 2023 11:05:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] riscv: mm: Fixup spurious fault of kernel vaddr
Content-Language: en-US
To:     Guo Ren <guoren@kernel.org>
Cc:     palmer@rivosinc.com, paul.walmsley@sifive.com, falcon@tinylab.org,
        bjorn@kernel.org, conor.dooley@microchip.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
References: <20230721145121.1854104-1-guoren@kernel.org>
 <5e5be2d4-c563-6beb-b5f5-df47edeebc83@ghiti.fr>
 <CAJF2gTQMAVUtC6_ftEwp=EeYR_O7yzfGYmxwrqcO6+hn2J32bA@mail.gmail.com>
 <87bfcd33-9741-4d6c-8b7a-1d1ee2dce61b@ghiti.fr>
 <CAJF2gTT8JV5f4Fm1F-XgfAhNWNXJquVW8-uCK-b4Qy0xztrGLA@mail.gmail.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAJF2gTT8JV5f4Fm1F-XgfAhNWNXJquVW8-uCK-b4Qy0xztrGLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 22/07/2023 01:59, Guo Ren wrote:
> On Fri, Jul 21, 2023 at 4:01 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>>
>> On 21/07/2023 18:08, Guo Ren wrote:
>>> On Fri, Jul 21, 2023 at 11:19 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>>>> On 21/07/2023 16:51, guoren@kernel.org wrote:
>>>>> From: Guo Ren <guoren@linux.alibaba.com>
>>>>>
>>>>> RISC-V specification permits the caching of PTEs whose V (Valid)
>>>>> bit is clear. Operating systems must be written to cope with this
>>>>> possibility, but implementers are reminded that eagerly caching
>>>>> invalid PTEs will reduce performance by causing additional page
>>>>> faults.
>>>>>
>>>>> So we must keep vmalloc_fault for the spurious page faults of kernel
>>>>> virtual address from an OoO machine.
>>>>>
>>>>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>>>>> Signed-off-by: Guo Ren <guoren@kernel.org>
>>>>> ---
>>>>>     arch/riscv/mm/fault.c | 3 +--
>>>>>     1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
>>>>> index 85165fe438d8..f662c9eae7d4 100644
>>>>> --- a/arch/riscv/mm/fault.c
>>>>> +++ b/arch/riscv/mm/fault.c
>>>>> @@ -258,8 +258,7 @@ void handle_page_fault(struct pt_regs *regs)
>>>>>          * only copy the information from the master page table,
>>>>>          * nothing more.
>>>>>          */
>>>>> -     if ((!IS_ENABLED(CONFIG_MMU) || !IS_ENABLED(CONFIG_64BIT)) &&
>>>>> -         unlikely(addr >= VMALLOC_START && addr < VMALLOC_END)) {
>>>>> +     if (unlikely(addr >= TASK_SIZE)) {
>>>>>                 vmalloc_fault(regs, code, addr);
>>>>>                 return;
>>>>>         }
>>>> Can you share what you are trying to fix here?
>>> We met a spurious page fault panic on an OoO machine.
>>>
>>> 1. The processor speculative execution brings the V=0 entries into the
>>> TLB in the kernel virtual address.
>>> 2. Linux kernel installs the kernel virtual address with the page, and V=1
>>> 3. When kernel code access the kernel virtual address, it would raise
>>> a page fault as the V=0 entry in the tlb.
>>> 4. No vmalloc_fault, then panic.
>>>
>>>> I have a fix (that's currently running our CI) for commit 7d3332be011e
>>>> ("riscv: mm: Pre-allocate PGD entries for vmalloc/modules area") that
>>>> implements flush_cache_vmap() since we lost the vmalloc_fault.
>>> Could you share that patch?
>>
>> Here we go:
>>
>>
>> Author: Alexandre Ghiti <alexghiti@rivosinc.com>
>> Date:   Fri Jul 21 08:43:44 2023 +0000
>>
>>       riscv: Implement flush_cache_vmap()
>>
>>       The RISC-V kernel needs a sfence.vma after a page table
>> modification: we
>>       used to rely on the vmalloc fault handling to emit an sfence.vma, but
>>       commit 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for
>>       vmalloc/modules area") got rid of this path for 64-bit kernels, so
>> now we
>>       need to explicitly emit a sfence.vma in flush_cache_vmap().
>>
>>       Note that we don't need to implement flush_cache_vunmap() as the
>> generic
>>       code should emit a flush tlb after unmapping a vmalloc region.
>>
>>       Fixes: 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for
>> vmalloc/modules area")
>>       Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>
>> diff --git a/arch/riscv/include/asm/cacheflush.h
>> b/arch/riscv/include/asm/cacheflush.h
>> index 8091b8bf4883..b93ffddf8a61 100644
>> --- a/arch/riscv/include/asm/cacheflush.h
>> +++ b/arch/riscv/include/asm/cacheflush.h
>> @@ -37,6 +37,10 @@ static inline void flush_dcache_page(struct page *page)
>>    #define flush_icache_user_page(vma, pg, addr, len) \
>>           flush_icache_mm(vma->vm_mm, 0)
>>
>> +#ifdef CONFIG_64BIT
>> +#define flush_cache_vmap(start, end) flush_tlb_kernel_range(start, end)
>> +#endif
> I don't want that, and flush_tlb_kernel_range is flush_tlb_all. In
> addition, it would call IPI, which is a performance killer.


At the moment, flush_tlb_kernel_range() indeed calls flush_tlb_all() but 
that needs to be fixed, see my last patchset 
https://lore.kernel.org/linux-riscv/20230711075434.10936-1-alexghiti@rivosinc.com/.

But can you at least check that this fixes your issue? It would be 
interesting to see if the problem comes from vmalloc or something else.


> What's the problem of spurious fault replay? It only costs a
> local_tlb_flush with vaddr.


We had this exact discussion internally this week, and the fault replay 
seems like a solution. But that needs to be thought carefully: the 
vmalloc fault was removed for a reason (see Bjorn commit log), tracing 
functions can use vmalloc() in the path of the vmalloc fault, causing an 
infinite trap loop. And here you are simply re-enabling this problem. In 
addition, this patch makes vmalloc_fault() catch *all* kernel faults in 
the kernel address space, so any genuine kernel fault would loop forever 
in vmalloc_fault().


For now, the simplest solution is to implement flush_cache_vmap() 
because riscv needs a sfence.vma when adding a new mapping, and if 
that's a "performance killer", let's measure that and implement 
something like this patch is trying to do. I may be wrong, but there 
aren't many new kernel mappings that would require a call to 
flush_cache_vmap() so I disagree with the performance killer argument, 
but happy to be proven otherwise!

Thanks,

Alex


>
>> +
>>    #ifndef CONFIG_SMP
>>
>>    #define flush_icache_all() local_flush_icache_all()
>>
>>
>> Let me know if that works for you!
>>
>>
>>>
> --
> Best Regards
>   Guo Ren
