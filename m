Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AD2767C93
	for <lists+linux-arch@lfdr.de>; Sat, 29 Jul 2023 08:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjG2Gka (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Jul 2023 02:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjG2Gk3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Jul 2023 02:40:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F5C3C33;
        Fri, 28 Jul 2023 23:40:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 117FE602F9;
        Sat, 29 Jul 2023 06:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7D1C433CC;
        Sat, 29 Jul 2023 06:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690612824;
        bh=CI7Q0bSDUFRUz5cf9sJg74y/advLjvwEO/S6YAFjxfw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CBfmnuZM1ZSR7LImwbKgGLQsckvfNz7liIxag4nE02UbpntxGjR8a7FEmF+gKfXRr
         Uk2hEInl+V0gbQgudGV8lRpMbF7SWOPxX6n4kr6HPsDqa2M+R1U2IVQL5HShYSJINu
         TxXbHEq47Y6zpM2SGjrwD4qJCTLYPvISBAFn9nZ2KuMTvTivxmJnMBBZtJnEEKFyen
         TKLY1swNOvPHa6QJAMn+bqPy1xzPX/DOnaEubvgSdlDouqxOeSAMiyZ6ks7umlpsCM
         +ydvOBMtRDiP9bnrCONQh+GFXg5yM+fxAlKXF82FyjPrbYEIqsdqrWgCqP+/IQ5mLH
         rQn6T73G4MxiA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5227e5d9d96so3539957a12.2;
        Fri, 28 Jul 2023 23:40:24 -0700 (PDT)
X-Gm-Message-State: ABy/qLalu73x1DrPUmAy8F27rNi81OXC5lk5wC4Fs3p0aMetQM0rP8X0
        Lr6Rn8ORcKIAESgnfes43Fdrh7eBc3czm8SCiNU=
X-Google-Smtp-Source: APBJJlG1ZyrqEWpx7V6NBWjihkT4/lIOFuimVeUmJacRzB1mUXBSuY0J4QdEtuDygLNwFdsmH5hnmCxSpoxqnLz2eUg=
X-Received: by 2002:aa7:da41:0:b0:51e:3d13:4a12 with SMTP id
 w1-20020aa7da41000000b0051e3d134a12mr3494100eds.34.1690612822528; Fri, 28 Jul
 2023 23:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230721145121.1854104-1-guoren@kernel.org> <5e5be2d4-c563-6beb-b5f5-df47edeebc83@ghiti.fr>
 <CAJF2gTQMAVUtC6_ftEwp=EeYR_O7yzfGYmxwrqcO6+hn2J32bA@mail.gmail.com>
 <87bfcd33-9741-4d6c-8b7a-1d1ee2dce61b@ghiti.fr> <CAJF2gTT8JV5f4Fm1F-XgfAhNWNXJquVW8-uCK-b4Qy0xztrGLA@mail.gmail.com>
 <292abea1-59b7-13d4-0b27-ac00f7e7f20e@ghiti.fr>
In-Reply-To: <292abea1-59b7-13d4-0b27-ac00f7e7f20e@ghiti.fr>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 29 Jul 2023 14:40:11 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQZhdQCFyz0eJo6VnLZzPDxK5WNRJqpr=BRLsdCdjG2gA@mail.gmail.com>
Message-ID: <CAJF2gTQZhdQCFyz0eJo6VnLZzPDxK5WNRJqpr=BRLsdCdjG2gA@mail.gmail.com>
Subject: Re: [PATCH] riscv: mm: Fixup spurious fault of kernel vaddr
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     palmer@rivosinc.com, paul.walmsley@sifive.com, falcon@tinylab.org,
        bjorn@kernel.org, conor.dooley@microchip.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Sorry for the late reply, Alexandre. I'm busy with other suffs.

On Mon, Jul 24, 2023 at 5:05=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
>
> On 22/07/2023 01:59, Guo Ren wrote:
> > On Fri, Jul 21, 2023 at 4:01=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr>=
 wrote:
> >>
> >> On 21/07/2023 18:08, Guo Ren wrote:
> >>> On Fri, Jul 21, 2023 at 11:19=E2=80=AFPM Alexandre Ghiti <alex@ghiti.=
fr> wrote:
> >>>> On 21/07/2023 16:51, guoren@kernel.org wrote:
> >>>>> From: Guo Ren <guoren@linux.alibaba.com>
> >>>>>
> >>>>> RISC-V specification permits the caching of PTEs whose V (Valid)
> >>>>> bit is clear. Operating systems must be written to cope with this
> >>>>> possibility, but implementers are reminded that eagerly caching
> >>>>> invalid PTEs will reduce performance by causing additional page
> >>>>> faults.
> >>>>>
> >>>>> So we must keep vmalloc_fault for the spurious page faults of kerne=
l
> >>>>> virtual address from an OoO machine.
> >>>>>
> >>>>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> >>>>> Signed-off-by: Guo Ren <guoren@kernel.org>
> >>>>> ---
> >>>>>     arch/riscv/mm/fault.c | 3 +--
> >>>>>     1 file changed, 1 insertion(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> >>>>> index 85165fe438d8..f662c9eae7d4 100644
> >>>>> --- a/arch/riscv/mm/fault.c
> >>>>> +++ b/arch/riscv/mm/fault.c
> >>>>> @@ -258,8 +258,7 @@ void handle_page_fault(struct pt_regs *regs)
> >>>>>          * only copy the information from the master page table,
> >>>>>          * nothing more.
> >>>>>          */
> >>>>> -     if ((!IS_ENABLED(CONFIG_MMU) || !IS_ENABLED(CONFIG_64BIT)) &&
> >>>>> -         unlikely(addr >=3D VMALLOC_START && addr < VMALLOC_END)) =
{
> >>>>> +     if (unlikely(addr >=3D TASK_SIZE)) {
> >>>>>                 vmalloc_fault(regs, code, addr);
> >>>>>                 return;
> >>>>>         }
> >>>> Can you share what you are trying to fix here?
> >>> We met a spurious page fault panic on an OoO machine.
> >>>
> >>> 1. The processor speculative execution brings the V=3D0 entries into =
the
> >>> TLB in the kernel virtual address.
> >>> 2. Linux kernel installs the kernel virtual address with the page, an=
d V=3D1
> >>> 3. When kernel code access the kernel virtual address, it would raise
> >>> a page fault as the V=3D0 entry in the tlb.
> >>> 4. No vmalloc_fault, then panic.
> >>>
> >>>> I have a fix (that's currently running our CI) for commit 7d3332be01=
1e
> >>>> ("riscv: mm: Pre-allocate PGD entries for vmalloc/modules area") tha=
t
> >>>> implements flush_cache_vmap() since we lost the vmalloc_fault.
> >>> Could you share that patch?
> >>
> >> Here we go:
> >>
> >>
> >> Author: Alexandre Ghiti <alexghiti@rivosinc.com>
> >> Date:   Fri Jul 21 08:43:44 2023 +0000
> >>
> >>       riscv: Implement flush_cache_vmap()
> >>
> >>       The RISC-V kernel needs a sfence.vma after a page table
> >> modification: we
> >>       used to rely on the vmalloc fault handling to emit an sfence.vma=
, but
> >>       commit 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for
> >>       vmalloc/modules area") got rid of this path for 64-bit kernels, =
so
> >> now we
> >>       need to explicitly emit a sfence.vma in flush_cache_vmap().
> >>
> >>       Note that we don't need to implement flush_cache_vunmap() as the
> >> generic
> >>       code should emit a flush tlb after unmapping a vmalloc region.
> >>
> >>       Fixes: 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for
> >> vmalloc/modules area")
> >>       Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> >>
> >> diff --git a/arch/riscv/include/asm/cacheflush.h
> >> b/arch/riscv/include/asm/cacheflush.h
> >> index 8091b8bf4883..b93ffddf8a61 100644
> >> --- a/arch/riscv/include/asm/cacheflush.h
> >> +++ b/arch/riscv/include/asm/cacheflush.h
> >> @@ -37,6 +37,10 @@ static inline void flush_dcache_page(struct page *p=
age)
> >>    #define flush_icache_user_page(vma, pg, addr, len) \
> >>           flush_icache_mm(vma->vm_mm, 0)
> >>
> >> +#ifdef CONFIG_64BIT
> >> +#define flush_cache_vmap(start, end) flush_tlb_kernel_range(start, en=
d)
> >> +#endif
> > I don't want that, and flush_tlb_kernel_range is flush_tlb_all. In
> > addition, it would call IPI, which is a performance killer.
>
>
> At the moment, flush_tlb_kernel_range() indeed calls flush_tlb_all() but
> that needs to be fixed, see my last patchset
> https://lore.kernel.org/linux-riscv/20230711075434.10936-1-alexghiti@rivo=
sinc.com/.
>
> But can you at least check that this fixes your issue? It would be
> interesting to see if the problem comes from vmalloc or something else.
It could solve my issue.

>
>
> > What's the problem of spurious fault replay? It only costs a
> > local_tlb_flush with vaddr.
>
>
> We had this exact discussion internally this week, and the fault replay
> seems like a solution. But that needs to be thought carefully: the
> vmalloc fault was removed for a reason (see Bjorn commit log), tracing
> functions can use vmalloc() in the path of the vmalloc fault, causing an
> infinite trap loop. And here you are simply re-enabling this problem.
Thx for mentioning it, and I will solve it in the next version of the patch=
:

-static inline void vmalloc_fault(struct pt_regs *regs, int code,
unsigned long addr)
+static void notrace vmalloc_fault(struct pt_regs *regs, int code,
unsigned long addr)

> In
> addition, this patch makes vmalloc_fault() catch *all* kernel faults in
> the kernel address space, so any genuine kernel fault would loop forever
> in vmalloc_fault().
We check whether kernel vaddr is valid by the page_table, not range.
I'm sure "the any genuine kernel fault would loop forever in
vmalloc_fault()" is about what? Could you give an example?

>
>
> For now, the simplest solution is to implement flush_cache_vmap()
> because riscv needs a sfence.vma when adding a new mapping, and if
It's not a local_tlb_flush, and it would ipi broadcast all harts.
on_each_cpu(__ipi_flush_tlb_all, NULL, 1);

That's too horrible.

Some custom drivers or test codes may care about it.

> that's a "performance killer", let's measure that and implement
> something like this patch is trying to do. I may be wrong, but there
> aren't many new kernel mappings that would require a call to
> flush_cache_vmap() so I disagree with the performance killer argument,
> but happy to be proven otherwise!

1. I agree to pre-allocate pgd entries. It's good for performance, but
don't do that when Sv32.
2. We still need vmalloc_fault to match ISA spec requirements. (Some
vendors' microarchitectures (e.g., T-HEAD c910) could prevent V=3D0 into
TLB when PTW, then they don't need it.)
3. Only when vmalloc_fault can't solve the problem, then let's think
about the flush_cache_vmap() solution.

>
> Thanks,
>
> Alex
>
>
> >
> >> +
> >>    #ifndef CONFIG_SMP
> >>
> >>    #define flush_icache_all() local_flush_icache_all()
> >>
> >>
> >> Let me know if that works for you!
> >>
> >>
> >>>
> > --
> > Best Regards
> >   Guo Ren



--
Best Regards
 Guo Ren
