Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C4B74C465
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jul 2023 15:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjGINkS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jul 2023 09:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjGINkR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jul 2023 09:40:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54057103;
        Sun,  9 Jul 2023 06:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1D1760BEC;
        Sun,  9 Jul 2023 13:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032F8C433C7;
        Sun,  9 Jul 2023 13:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688910014;
        bh=tZgkSd7oymqonWNvgX6gc+9exz3n3C13pRvO6OYLDFs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kfl2UYkHiE2r6L0jaK47wVVykz32Lxq0PCkGXxOOS87tLul/IGwcrzWl74f2yYSP7
         rXM2zka6CCH/eN4Eh1Iu13KhddsUH4DiigqZDYk/Zwlt+E3NG5NsvpjQP6qQFq5PU1
         M8CEAOQiAoDINErrZiDpiZT6v2iwBhILV2Ws0v9dtX7ZGJU++3Tjng+SNDOrsF0CY1
         AK6uLwy6VPfTExw0G7oJObR+WKVEqjquTj6S7djGfz7VyFcPSj4F+VFBhNr9SibQAk
         fPjpT2l10UFe9okC5yrIZtk6cyMVe5GS+VU3m0waxGqViy02DbVuSIxHz9ybNnNnBe
         XDWqBiW55jaTA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so6942682a12.0;
        Sun, 09 Jul 2023 06:40:13 -0700 (PDT)
X-Gm-Message-State: ABy/qLYnWIxQicbW4M+ebOjF4VT2OEaUmfDzugRKsn0mOeokYr46RdFr
        pFx8pjLbo9tJk4Cc6HbKop3PXEnX/d/UL131Dvc=
X-Google-Smtp-Source: APBJJlFt0elwP4WrtSl0ldTm2Qz34A5kQ8iW84OMzjbmMHdWyTJIha+ylJb4Hv4yM5KrP/2WvIjDbYkOz25ESMViPUI=
X-Received: by 2002:a05:6402:34c1:b0:51e:53be:9ddc with SMTP id
 w1-20020a05640234c100b0051e53be9ddcmr3746534edc.2.1688910012179; Sun, 09 Jul
 2023 06:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230629082032.3481237-1-guoren@kernel.org> <2ab8ca7c-a648-f73c-1815-086274af6013@ghiti.fr>
 <CAJF2gTQdr1YGTAwtrHCxSomjTHXgdzwWSff2VRKxq06S62aJtA@mail.gmail.com>
 <c63f3587-dfb6-11f2-3be4-903811bcb629@ghiti.fr> <CAJF2gTSpgpr3irJd3p=1cLSjBh+tTgoLh3rr1p_i+jj6xj50UQ@mail.gmail.com>
 <41be0796-c884-bffa-8b3b-8b2da1cc2709@ghiti.fr>
In-Reply-To: <41be0796-c884-bffa-8b3b-8b2da1cc2709@ghiti.fr>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 9 Jul 2023 21:40:00 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT0bLKinb9-zyVxbnk4sDEhAPhxHoJC5VfaV70=mXHd7w@mail.gmail.com>
Message-ID: <CAJF2gTT0bLKinb9-zyVxbnk4sDEhAPhxHoJC5VfaV70=mXHd7w@mail.gmail.com>
Subject: Re: [PATCH] riscv: pageattr: Fixup synchronization problem between
 init_mm and active_mm
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     palmer@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
        zong.li@sifive.com, atishp@atishpatra.org, jszhang@kernel.org,
        bjorn@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 5, 2023 at 8:06=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wrot=
e:
>
> + fixed Paul's address
>
>
> On 05/07/2023 11:15, Guo Ren wrote:
> > On Wed, Jul 5, 2023 at 3:01=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> =
wrote:
> >>
> >> On 04/07/2023 04:25, Guo Ren wrote:
> >>> On Mon, Jul 3, 2023 at 6:17=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr=
> wrote:
> >>>> Hi Guo,
> >>>>
> >>>> On 29/06/2023 10:20, guoren@kernel.org wrote:
> >>>>> From: Guo Ren <guoren@linux.alibaba.com>
> >>>>>
> >>>>> The machine_kexec() uses set_memory_x to add the executable attribu=
te to the
> >>>>> page table entry of control_code_buffer. It only modifies the init_=
mm but not
> >>>>> the current->active_mm. The current kexec process won't use init_mm=
 directly,
> >>>>> and it depends on minor_pagefault, which is removed by commit 7d333=
2be011e4
> >>>> Is the removal of minor_pagefault an issue? I'm not sure I understan=
d
> >>>> this part of the changelog.
> >>> I use two different work-around patches to answer your question:
> >>> 1st:
> >>> -----
> >>> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> >>> index 705d63a59aec..b8b200c81606 100644
> >>> --- a/arch/riscv/mm/fault.c
> >>> +++ b/arch/riscv/mm/fault.c
> >>> @@ -249,7 +249,7 @@ void handle_page_fault(struct pt_regs *regs)
> >>> * only copy the information from the master page table,
> >>> * nothing more.
> >>> */
> >>> - if (unlikely((addr >=3D VMALLOC_START) && (addr < VMALLOC_END))) {
> >>> + if (unlikely(addr >=3D 0x8000000000000000UL)) {
> >>> vmalloc_fault(regs, code, addr);
> >>> return;
> >>> }
> >>> ------
> >>>
> >>> 2nd:
> >>> ------
> >>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> >>> index 8e65f0a953e5..270f50852886 100644
> >>> --- a/arch/riscv/mm/init.c
> >>> +++ b/arch/riscv/mm/init.c
> >>> @@ -1387,7 +1387,7 @@ static void __init create_linear_mapping_page_t=
able(void)
> >>> if (end >=3D __pa(PAGE_OFFSET) + memory_limit)
> >>> end =3D __pa(PAGE_OFFSET) + memory_limit;
> >>>
> >>> - create_linear_mapping_range(start, end, 0);
> >>> + create_linear_mapping_range(start, end, PMD_SIZE);
> >>> }
> >>>
> >>> #ifdef CONFIG_STRICT_KERNEL_RWX
> >>> -----
> >>>
> >>> The removal of minor_pagefault could be an issue, but in this case
> >>> it's the VMALLOC_START/END which prevents the minor_pagefault at
> >>> first. I didn't say commit 7d3332be011e4 is the problem.
> >>
> >> Sorry I still don't understand what you mean here and why you mention
> >> the minor pagefault, could you explain again please?
> >>
> >>
> >>>>> ("riscv: mm: Pre-allocate PGD entries for vmalloc/modules area") of=
 64BIT. So,
> >>>>> when it met pud mapping on an MMU_SV39 machine, it caused the follo=
wing:
> >>>>>
> >>>>>     kexec_core: Starting new kernel
> >>>>>     Will call new kernel at 00300000 from hart id 0
> >>>>>     FDT image at 747c7000
> >>>>>     Bye...
> >>>>>     Unable to handle kernel paging request at virtual address fffff=
fda23b0d000
> >>>>>     Oops [#1]
> >>>>>     Modules linked in:
> >>>>>     CPU: 0 PID: 53 Comm: uinit Not tainted 6.4.0-rc6 #15
> >>>>>     Hardware name: Sophgo Mango (DT)
> >>>>>     epc : 0xffffffda23b0d000
> >>>>>      ra : machine_kexec+0xa6/0xb0
> >>>>>     epc : ffffffda23b0d000 ra : ffffffff80008272 sp : ffffffc80c173=
d10
> >>>>>      gp : ffffffff8150e1e0 tp : ffffffd9073d2c40 t0 : 0000000000000=
000
> >>>>>      t1 : 0000000000000042 t2 : 6567616d69205444 s0 : ffffffc80c173=
d50
> >>>>>      s1 : ffffffd9076c4800 a0 : ffffffd9076c4800 a1 : 0000000000300=
000
> >>>>>      a2 : 00000000747c7000 a3 : 0000000000000000 a4 : ffffffd800000=
000
> >>>>>      a5 : 0000000000000000 a6 : ffffffd903619c40 a7 : fffffffffffff=
fff
> >>>>>      s2 : ffffffda23b0d000 s3 : 0000000000300000 s4 : 00000000747c7=
000
> >>>>>      s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000000000000=
000
> >>>>>      s8 : 0000000000000000 s9 : 0000000000000000 s10: 0000000000000=
000
> >>>>>      s11: 0000003f940001a0 t3 : ffffffff815351af t4 : ffffffff81535=
1af
> >>>>>      t5 : ffffffff815351b0 t6 : ffffffc80c173b50
> >>>>>     status: 0000000200000100 badaddr: ffffffda23b0d000 cause: 00000=
0000000000c
> >>>>>
> >>>>> Yes, Using set_memory_x API after boot has the limitation, and at l=
east we
> >>>>> should synchronize the current->active_mm to fix the problem.
> >>>>>
> >>>>> Fixes: d3ab332a5021 ("riscv: add ARCH_HAS_SET_MEMORY support")
> >>>>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> >>>>> Signed-off-by: Guo Ren <guoren@kernel.org>
> >>>>> ---
> >>>>>     arch/riscv/mm/pageattr.c | 7 +++++++
> >>>>>     1 file changed, 7 insertions(+)
> >>>>>
> >>>>> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> >>>>> index ea3d61de065b..23d169c4ee81 100644
> >>>>> --- a/arch/riscv/mm/pageattr.c
> >>>>> +++ b/arch/riscv/mm/pageattr.c
> >>>>> @@ -123,6 +123,13 @@ static int __set_memory(unsigned long addr, in=
t numpages, pgprot_t set_mask,
> >>>>>                                      &masks);
> >>>>>         mmap_write_unlock(&init_mm);
> >>>>>
> >>>>> +     if (current->active_mm !=3D &init_mm) {
> >>>>> +             mmap_write_lock(current->active_mm);
> >>>>> +             ret =3D  walk_page_range_novma(current->active_mm, st=
art, end,
> >>>>> +                                          &pageattr_ops, NULL, &ma=
sks);
> >>>>> +             mmap_write_unlock(current->active_mm);
> >>>>> +     }
> >>>>> +
> >>>>>         flush_tlb_kernel_range(start, end);
> >>>>>
> >>>>>         return ret;
> >>>> I don't understand: any page table inherits the entries of
> >>>> swapper_pg_dir (see pgd_alloc()), so any kernel page table entry is
> >>>> "automatically" synchronized, so why should we synchronize one 4K en=
try
> >>>> explicitly? A PGD entry would need to be synced, but not a PTE entry=
.
> >>> The purpose of the second walk_page_range_novma() is for pgd's entrie=
s
> >>> synchronization. I'm a bit lazy here, I agree, it's unnecessary to
> >>> write lower level entries again. So I would use a simple pgd entries
> >>> synchronization from vmalloc_fault in the next version of patch, all
> >>> right?
> >>
> >> But vmalloc_fault was removed by commit 7d3332be011e4 for CONFIG_64BIT=
,
> >> so I don't get it: why would we need to synchronize a PGD entry in you=
r
> >> case? Where does this new PGD come from? And the trap address is
> >> ffffffda23b0d000, which lies in the direct mapping, so why do you
> >> mention vmalloc_fault at all?
> > The machine_kexec() uses set_memory_x to modify the direct mapping
> > attributes from RW to RWX. But set_memory_x only changes the init_mm's
> > attributes, not current->active_mm, so when kexec jumps into
> > control_buffer, the instruction page fault happens, and there is no
> > minor_pagefault for it, then panic.
> >
> > I found the bug on an MMU_sv39 machine, and the direct mapping used a
> > 1GB PUD, the pgd entries. This patch could solve the problem by
> > synchronizing a PGD entry between init_mm and current->active_mm.
>
>
> Ok I get it now, thanks. So a few thoughts:
>
> - the trap address is in the linear mapping, so there won't be any sync
> in the trap handler. Even if we implemented such behavior, waiting for a
> fault to synchronize those mappings is error-prone (see commit
> 7d3332be011e4)
>
> - this is Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the
> linear mapping")
>
> - that only happens if we use the largest mapping possible size for the
> current mode: one simple solution is to restrict to the second largest
> size (2MB for sv39, 1GB for sv48, 512GB for sv57).
>
> - your solution only works in this case, but we should fix the larger
> problem: we need to sync all the page tables if such things happen, not
> just the "calling" one.
>
> - set_memory* changing the protection of a whole PUD mapping for a
> single page is a problem: if we set_memory_ro() a single page, we end up
> with a 1GB linear mapping set to read only (which will obviously be
> problematic!)
>
> - can we really use set_memory* on the direct mapping? Maybe we should
> simply not, and the solution is to fix machine_kexec() so it remaps this
> page outside the linear mapping.
Okay, I agree to limit usage of set_memory*. And I would let
machine_kexec() remaps control_buffer_page  in the next version of
patch instead of modifing linear mapping.

>
> - at the moment, we do not deal with the linear mapping in set_memory*
> (for example, when used with modules, we protect the module mapping in
> the vmalloc region but don't do anything with its linear mapping alias,
> I have that on my todo list for a moment now).
>
> The best very short-term solution to me is to restrict to the second
> largest size (easy to hack that in best_map_size()).
>
> And to me the long term solution is to split those mappings: that fixes
> all the issues mentioned above + the thing with the modules (but I have
> to dig a bit more, no other archs seems to do that).
>
> That's interesting, thanks for bringing that up, let me know what you
> think, I'll keep digging!
>
> Alex
>
>
> >
> >> Sorry if I'm missing something, hope you can clarify things!
> >>
> >> Thanks,
> >>
> >> Alex
> >>
> >>
> >>>
> >>> --
> >>> Best Regards
> >>>    Guo Ren
> >>>
> >>> _______________________________________________
> >>> linux-riscv mailing list
> >>> linux-riscv@lists.infradead.org
> >>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> >



--=20
Best Regards
 Guo Ren
