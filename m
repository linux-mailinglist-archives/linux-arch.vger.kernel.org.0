Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB972768A47
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 05:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjGaDZV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jul 2023 23:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGaDZS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 30 Jul 2023 23:25:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DBE185;
        Sun, 30 Jul 2023 20:25:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13A9B60E08;
        Mon, 31 Jul 2023 03:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB690C433C8;
        Mon, 31 Jul 2023 03:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690773915;
        bh=NyOtGJ9ScDpXnEDjAz0B65c6xIYaJN3eVi8UQRLZtCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FZUJZ433YqwFs7OmHN5j88kuYjtPB27QdQWjHHCqJ/Q17SWW13ciuHxFd64qhh2QT
         KCfdS0ORDnAMzK1dFk3ZbWvVLocUkCqbZY2ZZfO4zw5+xWP9P9cTdELes0EUpVutE9
         qajPKK7NRr2OnJPD6T9Npv7Yj798EdUl0Ss+J9wikL/+xtHV9JQ0FSlBfaGCikT+8N
         Kf4MFDP3xeh6TY3KQmJkt4Fj+ZwBV4CmS9EqY4YbaAUkWccy7Z5yWr1fQ4yU//EjEK
         nOQU5ldm/+CHWBZMvyIgCkn5Bh1+GeifUtS5ZDWni/yENXYvbMyKipYlqbV0af3Nuy
         uwRcwcKP9d6Nw==
Date:   Sun, 30 Jul 2023 23:25:03 -0400
From:   Guo Ren <guoren@kernel.org>
To:     Alexandre Ghiti <alex@ghiti.fr>, palmer@rivosinc.com
Cc:     paul.walmsley@sifive.com, zong.li@sifive.com,
        atishp@atishpatra.org, jszhang@kernel.org, bjorn@kernel.org,
        xingxg2008@163.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH V4] riscv: kexec: Fixup synchronization problem between
 init_mm and active_mm
Message-ID: <ZMcpj33ASbmmRoAC@gmail.com>
References: <20230714103659.3146949-1-guoren@kernel.org>
 <ad6e6873-5555-624b-6050-dbbcefb91e5a@ghiti.fr>
 <CAJF2gTR72W4oA3L+138Hdenf9kASO17aMTPCkrJfcafcJ2bUKw@mail.gmail.com>
 <dbd8bc20-2cba-d89f-446a-029f50c0395b@ghiti.fr>
 <CAJF2gTTwzYDCnnVHKV7dPccu8+ynxaNR3B8cK7gsLarswoh03A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTTwzYDCnnVHKV7dPccu8+ynxaNR3B8cK7gsLarswoh03A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 21, 2023 at 08:14:42PM -0400, Guo Ren wrote:
> On Thu, Jul 20, 2023 at 4:28 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
> >
> >
> > On 18/07/2023 14:30, Guo Ren wrote:
> > > On Mon, Jul 17, 2023 at 9:17 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
> > >>
> > >> On 14/07/2023 12:36, guoren@kernel.org wrote:
> > >>> From: Guo Ren <guoren@linux.alibaba.com>
> > >>>
> > >>> The machine_kexec() uses set_memory_x to modify the direct mapping
> > >>> attributes from RW to RWX. The current implementation of set_memory_x
> > >>> does not split hugepages in the linear mapping and then when a PGD
> > >>> mapping is used, the whole PGD is marked as executable. But changing
> > >>> the permissions at the PGD level must be propagated to all the page
> > >>> tables. When kexec jumps into control_buffer, the instruction page
> > >>> fault happens, and there is no minor_pagefault for it, then panic.
> > >>>
> > >>> The bug is found on an MMU_sv39 machine, and the direct mapping used a
> > >>> 1GB PUD, the pgd entries. Here is the bug output:
> > >>>
> > >>>    kexec_core: Starting new kernel
> > >>>    Will call new kernel at 00300000 from hart id 0
> > >>>    FDT image at 747c7000
> > >>>    Bye...
> > >>>    Unable to handle kernel paging request at virtual address ffffffda23b0d000
> > >>>    Oops [#1]
> > >>>    Modules linked in:
> > >>>    CPU: 0 PID: 53 Comm: uinit Not tainted 6.4.0-rc6 #15
> > >>>    Hardware name: Sophgo Mango (DT)
> > >>>    epc : 0xffffffda23b0d000
> > >>>     ra : machine_kexec+0xa6/0xb0
> > >>>    epc : ffffffda23b0d000 ra : ffffffff80008272 sp : ffffffc80c173d10
> > >>>     gp : ffffffff8150e1e0 tp : ffffffd9073d2c40 t0 : 0000000000000000
> > >>>     t1 : 0000000000000042 t2 : 6567616d69205444 s0 : ffffffc80c173d50
> > >>>     s1 : ffffffd9076c4800 a0 : ffffffd9076c4800 a1 : 0000000000300000
> > >>>     a2 : 00000000747c7000 a3 : 0000000000000000 a4 : ffffffd800000000
> > >>>     a5 : 0000000000000000 a6 : ffffffd903619c40 a7 : ffffffffffffffff
> > >>>     s2 : ffffffda23b0d000 s3 : 0000000000300000 s4 : 00000000747c7000
> > >>>     s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000000000000000
> > >>>     s8 : 0000000000000000 s9 : 0000000000000000 s10: 0000000000000000
> > >>>     s11: 0000003f940001a0 t3 : ffffffff815351af t4 : ffffffff815351af
> > >>>     t5 : ffffffff815351b0 t6 : ffffffc80c173b50
> > >>>    status: 0000000200000100 badaddr: ffffffda23b0d000 cause: 000000000000000c
> > >>>
> > >>> Given the current flaw in the set_memory_x implementation, the simplest
> > >>> solution is to fix machine_kexec() to remap control code page outside
> > >>> the linear mapping. Because the control code buffer was moved from the
> > >>> direct mapping area to the vmalloc location, we need an additional
> > >>> va_va_offset to fix up va_pa_offset.
> > >>>
> > >>> Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
> > >>> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > >>> Reported-by: Xing XiaoGuang <xingxg2008@163.com>
> > >>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > >>> Signed-off-by: Guo Ren <guoren@kernel.org>
> > >>> ---
> > >>> Changelog:
> > >>> V4:
> > >>>    - Fixup va_pa_offset with additional va_va_offset.
> > >>>    - Add Reported-by tag.
> > >>>
> > >>> V3:
> > >>>    - Resume set_memory_x to set the _PAGE_EXEC attribute
> > >>>    - Optimize the commit log with Alexandre advice
> > >>>
> > >>> V2:
> > >>>    - Use vm_map_ram instead of modifying set_memory_x
> > >>>    - Correct Fixes tag
> > >>> ---
> > >>>    arch/riscv/include/asm/kexec.h    |  1 +
> > >>>    arch/riscv/kernel/machine_kexec.c | 18 +++++++++++++++---
> > >>>    2 files changed, 16 insertions(+), 3 deletions(-)
> > >>>
> > >>> diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
> > >>> index 2b56769cb530..17456e91476e 100644
> > >>> --- a/arch/riscv/include/asm/kexec.h
> > >>> +++ b/arch/riscv/include/asm/kexec.h
> > >>> @@ -41,6 +41,7 @@ crash_setup_regs(struct pt_regs *newregs,
> > >>>    struct kimage_arch {
> > >>>        void *fdt; /* For CONFIG_KEXEC_FILE */
> > >>>        unsigned long fdt_addr;
> > >>> +     void *control_code_buffer;
> > >>>    };
> > >>>
> > >>>    extern const unsigned char riscv_kexec_relocate[];
> > >>> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
> > >>> index 2d139b724bc8..60c1ef3c2232 100644
> > >>> --- a/arch/riscv/kernel/machine_kexec.c
> > >>> +++ b/arch/riscv/kernel/machine_kexec.c
> > >>> @@ -86,7 +86,14 @@ machine_kexec_prepare(struct kimage *image)
> > >>>
> > >>>        /* Copy the assembler code for relocation to the control page */
> > >>>        if (image->type != KEXEC_TYPE_CRASH) {
> > >>> -             control_code_buffer = page_address(image->control_code_page);
> > >>> +             control_code_buffer = vm_map_ram(&image->control_code_page,
> > >>> +                                              KEXEC_CONTROL_PAGE_SIZE/PAGE_SIZE,
> > >>> +                                              NUMA_NO_NODE);
> > >>> +             if (control_code_buffer == NULL) {
> > >>> +                     pr_err("Failed to vm_map control page\n");
> > >>> +                     return -ENOMEM;
> > >>> +             }
> > >>> +
> > >>>                control_code_buffer_sz = page_size(image->control_code_page);
> > >>>
> > >>>                if (unlikely(riscv_kexec_relocate_size > control_code_buffer_sz)) {
> > >>> @@ -99,6 +106,8 @@ machine_kexec_prepare(struct kimage *image)
> > >>>
> > >>>                /* Mark the control page executable */
> > >>>                set_memory_x((unsigned long) control_code_buffer, 1);
> > >>> +
> > >>> +             internal->control_code_buffer = control_code_buffer;
> > >>>        }
> > >>>
> > >>>        return 0;
> > >>> @@ -211,7 +220,10 @@ machine_kexec(struct kimage *image)
> > >>>        unsigned long this_cpu_id = __smp_processor_id();
> > >>>        unsigned long this_hart_id = cpuid_to_hartid_map(this_cpu_id);
> > >>>        unsigned long fdt_addr = internal->fdt_addr;
> > >>> -     void *control_code_buffer = page_address(image->control_code_page);
> > >>> +     void *control_code_buffer = internal->control_code_buffer;
> > >>> +     unsigned long va_va_offset =
> > >>> +                     (unsigned long) page_address(image->control_code_page)
> > >>> +                   - (unsigned long) control_code_buffer;
> > >>>        riscv_kexec_method kexec_method = NULL;
> > >>>
> > >>>    #ifdef CONFIG_SMP
> > >>> @@ -234,6 +246,6 @@ machine_kexec(struct kimage *image)
> > >>>        /* Jump to the relocation code */
> > >>>        pr_notice("Bye...\n");
> > >>>        kexec_method(first_ind_entry, jump_addr, fdt_addr,
> > >>> -                  this_hart_id, kernel_map.va_pa_offset);
> > >>> +                  this_hart_id, kernel_map.va_pa_offset - va_va_offset);
> > >>>        unreachable();
> > >>>    }
> > >>
> > >> I started working on the set_memory fix and the first thing to do is to
> > >> prevent the use of PGD mapping, it's too cumbersome to propagate changes
> > >> at this level: IIRC x86 keeps a list of page tables to go through
> > >> whenever that happens, that's why Bjorn pre-allocated all the PGD
> > >> entries to cover the vmalloc region.
> > >>
> > >> So, to me, the simple fix for this issue is to prevent the use of PGD
> > >> mapping. What do you think? Does the following patch work?
> > > The PGD mapping is necessary (especially for Sv32, Sv39), and it has
> > > been solved under your first advice. I think limit set_memory_x usage
> > > is the smart choice for now.
> >
> >
> > If we use PGD mappings, we won't be able to change the protections or
> > remove pages from the linear mapping as we don't have a means to
> > synchronize all the page tables. Removing pages from the linear mapping
> > is used for example for memfd_secret and certainly other things so that
> > means using PGD mappings will break a few things.
> >
> > The benefits of PGD mappings for the linear mapping was not proven, and
> We need PGD mappings for Sv32. liner mapping with 4KB would cause a
> significant performance gap in the small core (memset stride with 4KB,
> PTW with every store).
> 
> > even if I agree we should do our best to keep the largest mapping
> > possible just in case, implementing a page table synchronization seems
> > very cumbersome (x86 does that though).
> >
> > I'm not opposed to your solution, but:
Hi Alexandre & Palmer,

This patch is about fixing the problem of kexec, not solving the larger
scale of set_memory_x/pgd_mapping problems. And only limiting the
changes in the control buffer page is also necessary. Kexec shouldn't
modify direct mapping attributes.

Here is the flow of sg2042:
zsbl -> opensbi -> linux-boot (kexec boot next stage) -> linux
(ubuntu/Fedora)

Could we merge this patch first?

Best Regards
 Guo Ren

> >
> > - either we remove the PGD mappings, and your problem is fixed,
> This patch limits control_buffer_code into a 4KB page mapping entry. I
> don't think they are the same solution, even you remove the PGD
> mappings.
> 
> >
> > - or we keep PGD mappings, implement a page table synchronization, and
> > your problem is fixed.
> We need your synchronization, but not for this case.
> 
> >
> > And since we need to fix this larger problem, I don't see the point of
> > this workaround.
> This patch is for kexec. See title riscv: kexec: tag.
> 
> And I don't think your larger problem needs to be fixed. I agree with
> your first point that simply limit the usage of set_memory_x.
> 
> >
> > Thanks,
> >
> > Alex
> >
> >
> > >
> > >
> > >>
> > >> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > >> index 70fb31960b63..6dd12443bfa4 100644
> > >> --- a/arch/riscv/mm/init.c
> > >> +++ b/arch/riscv/mm/init.c
> > >> @@ -662,13 +662,12 @@ void __init create_pgd_mapping(pgd_t *pgdp,
> > >>    static uintptr_t __init best_map_size(phys_addr_t pa, uintptr_t va,
> > >>                                         phys_addr_t size)
> > >>    {
> > >> -       if (!(pa & (PGDIR_SIZE - 1)) && !(va & (PGDIR_SIZE - 1)) && size
> > >>   >= PGDIR_SIZE)
> > >> -               return PGDIR_SIZE;
> > >> -
> > >> -       if (!(pa & (P4D_SIZE - 1)) && !(va & (P4D_SIZE - 1)) && size >=
> > >> P4D_SIZE)
> > >> +       if (pgtable_l5_enabled &&
> > >> +           !(pa & (P4D_SIZE - 1)) && !(va & (P4D_SIZE - 1)) && size >=
> > >> P4D_SIZE)
> > >>                   return P4D_SIZE;
> > >>
> > >> -       if (!(pa & (PUD_SIZE - 1)) && !(va & (PUD_SIZE - 1)) && size >=
> > >> PUD_SIZE)
> > >> +       if (pgtable_l4_enabled &&
> > >> +           !(pa & (PUD_SIZE - 1)) && !(va & (PUD_SIZE - 1)) && size >=
> > >> PUD_SIZE)
> > >>                   return PUD_SIZE;
> > >>
> > >>           if (!(pa & (PMD_SIZE - 1)) && !(va & (PMD_SIZE - 1)) && size >=
> > >> PMD_SIZE)
> > >>
> > >>
> > >> Thanks,
> > >>
> > >> Alex
> > >>
> > >
> 
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
