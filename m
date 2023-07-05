Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297D2747DB9
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jul 2023 09:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjGEHBG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jul 2023 03:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjGEHBF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2023 03:01:05 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D061D18E;
        Wed,  5 Jul 2023 00:00:55 -0700 (PDT)
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id ACABF1BF20A;
        Wed,  5 Jul 2023 07:00:51 +0000 (UTC)
Message-ID: <c63f3587-dfb6-11f2-3be4-903811bcb629@ghiti.fr>
Date:   Wed, 5 Jul 2023 09:00:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] riscv: pageattr: Fixup synchronization problem between
 init_mm and active_mm
Content-Language: en-US
To:     Guo Ren <guoren@kernel.org>
Cc:     palmer@rivosinc.com, paul.walmsley@sifive.co, zong.li@sifive.com,
        atishp@atishpatra.org, jszhang@kernel.org, bjorn@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
References: <20230629082032.3481237-1-guoren@kernel.org>
 <2ab8ca7c-a648-f73c-1815-086274af6013@ghiti.fr>
 <CAJF2gTQdr1YGTAwtrHCxSomjTHXgdzwWSff2VRKxq06S62aJtA@mail.gmail.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAJF2gTQdr1YGTAwtrHCxSomjTHXgdzwWSff2VRKxq06S62aJtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 04/07/2023 04:25, Guo Ren wrote:
> On Mon, Jul 3, 2023 at 6:17 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>> Hi Guo,
>>
>> On 29/06/2023 10:20, guoren@kernel.org wrote:
>>> From: Guo Ren <guoren@linux.alibaba.com>
>>>
>>> The machine_kexec() uses set_memory_x to add the executable attribute to the
>>> page table entry of control_code_buffer. It only modifies the init_mm but not
>>> the current->active_mm. The current kexec process won't use init_mm directly,
>>> and it depends on minor_pagefault, which is removed by commit 7d3332be011e4
>>
>> Is the removal of minor_pagefault an issue? I'm not sure I understand
>> this part of the changelog.
> I use two different work-around patches to answer your question:
> 1st:
> -----
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 705d63a59aec..b8b200c81606 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -249,7 +249,7 @@ void handle_page_fault(struct pt_regs *regs)
> * only copy the information from the master page table,
> * nothing more.
> */
> - if (unlikely((addr >= VMALLOC_START) && (addr < VMALLOC_END))) {
> + if (unlikely(addr >= 0x8000000000000000UL)) {
> vmalloc_fault(regs, code, addr);
> return;
> }
> ------
>
> 2nd:
> ------
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 8e65f0a953e5..270f50852886 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1387,7 +1387,7 @@ static void __init create_linear_mapping_page_table(void)
> if (end >= __pa(PAGE_OFFSET) + memory_limit)
> end = __pa(PAGE_OFFSET) + memory_limit;
>
> - create_linear_mapping_range(start, end, 0);
> + create_linear_mapping_range(start, end, PMD_SIZE);
> }
>
> #ifdef CONFIG_STRICT_KERNEL_RWX
> -----
>
> The removal of minor_pagefault could be an issue, but in this case
> it's the VMALLOC_START/END which prevents the minor_pagefault at
> first. I didn't say commit 7d3332be011e4 is the problem.


Sorry I still don't understand what you mean here and why you mention 
the minor pagefault, could you explain again please?


>>
>>> ("riscv: mm: Pre-allocate PGD entries for vmalloc/modules area") of 64BIT. So,
>>> when it met pud mapping on an MMU_SV39 machine, it caused the following:
>>>
>>>    kexec_core: Starting new kernel
>>>    Will call new kernel at 00300000 from hart id 0
>>>    FDT image at 747c7000
>>>    Bye...
>>>    Unable to handle kernel paging request at virtual address ffffffda23b0d000
>>>    Oops [#1]
>>>    Modules linked in:
>>>    CPU: 0 PID: 53 Comm: uinit Not tainted 6.4.0-rc6 #15
>>>    Hardware name: Sophgo Mango (DT)
>>>    epc : 0xffffffda23b0d000
>>>     ra : machine_kexec+0xa6/0xb0
>>>    epc : ffffffda23b0d000 ra : ffffffff80008272 sp : ffffffc80c173d10
>>>     gp : ffffffff8150e1e0 tp : ffffffd9073d2c40 t0 : 0000000000000000
>>>     t1 : 0000000000000042 t2 : 6567616d69205444 s0 : ffffffc80c173d50
>>>     s1 : ffffffd9076c4800 a0 : ffffffd9076c4800 a1 : 0000000000300000
>>>     a2 : 00000000747c7000 a3 : 0000000000000000 a4 : ffffffd800000000
>>>     a5 : 0000000000000000 a6 : ffffffd903619c40 a7 : ffffffffffffffff
>>>     s2 : ffffffda23b0d000 s3 : 0000000000300000 s4 : 00000000747c7000
>>>     s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000000000000000
>>>     s8 : 0000000000000000 s9 : 0000000000000000 s10: 0000000000000000
>>>     s11: 0000003f940001a0 t3 : ffffffff815351af t4 : ffffffff815351af
>>>     t5 : ffffffff815351b0 t6 : ffffffc80c173b50
>>>    status: 0000000200000100 badaddr: ffffffda23b0d000 cause: 000000000000000c
>>>
>>> Yes, Using set_memory_x API after boot has the limitation, and at least we
>>> should synchronize the current->active_mm to fix the problem.
>>>
>>> Fixes: d3ab332a5021 ("riscv: add ARCH_HAS_SET_MEMORY support")
>>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>>> Signed-off-by: Guo Ren <guoren@kernel.org>
>>> ---
>>>    arch/riscv/mm/pageattr.c | 7 +++++++
>>>    1 file changed, 7 insertions(+)
>>>
>>> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
>>> index ea3d61de065b..23d169c4ee81 100644
>>> --- a/arch/riscv/mm/pageattr.c
>>> +++ b/arch/riscv/mm/pageattr.c
>>> @@ -123,6 +123,13 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
>>>                                     &masks);
>>>        mmap_write_unlock(&init_mm);
>>>
>>> +     if (current->active_mm != &init_mm) {
>>> +             mmap_write_lock(current->active_mm);
>>> +             ret =  walk_page_range_novma(current->active_mm, start, end,
>>> +                                          &pageattr_ops, NULL, &masks);
>>> +             mmap_write_unlock(current->active_mm);
>>> +     }
>>> +
>>>        flush_tlb_kernel_range(start, end);
>>>
>>>        return ret;
>>
>> I don't understand: any page table inherits the entries of
>> swapper_pg_dir (see pgd_alloc()), so any kernel page table entry is
>> "automatically" synchronized, so why should we synchronize one 4K entry
>> explicitly? A PGD entry would need to be synced, but not a PTE entry.
> The purpose of the second walk_page_range_novma() is for pgd's entries
> synchronization. I'm a bit lazy here, I agree, it's unnecessary to
> write lower level entries again. So I would use a simple pgd entries
> synchronization from vmalloc_fault in the next version of patch, all
> right?


But vmalloc_fault was removed by commit 7d3332be011e4 for CONFIG_64BIT, 
so I don't get it: why would we need to synchronize a PGD entry in your 
case? Where does this new PGD come from? And the trap address is 
ffffffda23b0d000, which lies in the direct mapping, so why do you 
mention vmalloc_fault at all?

Sorry if I'm missing something, hope you can clarify things!

Thanks,

Alex


>
>
> --
> Best Regards
>   Guo Ren
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
