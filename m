Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3436D75D7FD
	for <lists+linux-arch@lfdr.de>; Sat, 22 Jul 2023 01:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjGUX7Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jul 2023 19:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGUX7X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jul 2023 19:59:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CA630ED;
        Fri, 21 Jul 2023 16:59:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCEF460DFD;
        Fri, 21 Jul 2023 23:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F274C43397;
        Fri, 21 Jul 2023 23:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689983961;
        bh=nL7Uxf9LHyedJ5ptAy4FvNEgMCaUaf2n0tlV63dMa9k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RvnXTCVRk34PGdj+bQvssXz4LeOTC+DbWn8hWfk6WgWbWND9AtlpCfjopnv+euggV
         vE8kYSRXU833jaRO2ZlxJl84gWNnom23X2yWT8z7pPD2isr9/cgLT/FiI0YyfHBR2p
         NswU/R7uhIvd1bN1IOnsn1lR2/ymplpwRJORCDWP6s5EstIQ8QATgP5FiwDZC+bTXa
         zjfC+yB1or+WAbbYrjtIFALfbB7s+sP2b60SaxjVSy9cWTNvPwqaEBLleB3iMNoUmB
         fusZPNJxS0iDH1lHEf8HD+vhR1+3KbVEM0FhBiVGah/Ua0ghF+1SlR1GhDUy3RBfXJ
         ViSBGV542tikg==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-51e566b1774so3080420a12.1;
        Fri, 21 Jul 2023 16:59:21 -0700 (PDT)
X-Gm-Message-State: ABy/qLaQ5cz1cjR660oKFFlr7E0qZhbuuUeZyZNgM71Nr+1TvS3ZbeBG
        iu33SvEXEXwNYrorYvaGwxf8ts/cwzsRkNX3Ncw=
X-Google-Smtp-Source: APBJJlHBERULY9uAI2Af2Xh5LWL+8JllED/iDuB/6zed6hakhaHaL7B3C2jZUryHRlWbwy9LE0TlZntWen33Js4NvTg=
X-Received: by 2002:a50:fc16:0:b0:51e:5cab:feb9 with SMTP id
 i22-20020a50fc16000000b0051e5cabfeb9mr2715190edr.33.1689983959307; Fri, 21
 Jul 2023 16:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230721145121.1854104-1-guoren@kernel.org> <5e5be2d4-c563-6beb-b5f5-df47edeebc83@ghiti.fr>
 <CAJF2gTQMAVUtC6_ftEwp=EeYR_O7yzfGYmxwrqcO6+hn2J32bA@mail.gmail.com> <87bfcd33-9741-4d6c-8b7a-1d1ee2dce61b@ghiti.fr>
In-Reply-To: <87bfcd33-9741-4d6c-8b7a-1d1ee2dce61b@ghiti.fr>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 21 Jul 2023 19:59:07 -0400
X-Gmail-Original-Message-ID: <CAJF2gTT8JV5f4Fm1F-XgfAhNWNXJquVW8-uCK-b4Qy0xztrGLA@mail.gmail.com>
Message-ID: <CAJF2gTT8JV5f4Fm1F-XgfAhNWNXJquVW8-uCK-b4Qy0xztrGLA@mail.gmail.com>
Subject: Re: [PATCH] riscv: mm: Fixup spurious fault of kernel vaddr
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     palmer@rivosinc.com, paul.walmsley@sifive.com, falcon@tinylab.org,
        bjorn@kernel.org, conor.dooley@microchip.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 21, 2023 at 4:01=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
>
> On 21/07/2023 18:08, Guo Ren wrote:
> > On Fri, Jul 21, 2023 at 11:19=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr=
> wrote:
> >>
> >> On 21/07/2023 16:51, guoren@kernel.org wrote:
> >>> From: Guo Ren <guoren@linux.alibaba.com>
> >>>
> >>> RISC-V specification permits the caching of PTEs whose V (Valid)
> >>> bit is clear. Operating systems must be written to cope with this
> >>> possibility, but implementers are reminded that eagerly caching
> >>> invalid PTEs will reduce performance by causing additional page
> >>> faults.
> >>>
> >>> So we must keep vmalloc_fault for the spurious page faults of kernel
> >>> virtual address from an OoO machine.
> >>>
> >>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> >>> Signed-off-by: Guo Ren <guoren@kernel.org>
> >>> ---
> >>>    arch/riscv/mm/fault.c | 3 +--
> >>>    1 file changed, 1 insertion(+), 2 deletions(-)
> >>>
> >>> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> >>> index 85165fe438d8..f662c9eae7d4 100644
> >>> --- a/arch/riscv/mm/fault.c
> >>> +++ b/arch/riscv/mm/fault.c
> >>> @@ -258,8 +258,7 @@ void handle_page_fault(struct pt_regs *regs)
> >>>         * only copy the information from the master page table,
> >>>         * nothing more.
> >>>         */
> >>> -     if ((!IS_ENABLED(CONFIG_MMU) || !IS_ENABLED(CONFIG_64BIT)) &&
> >>> -         unlikely(addr >=3D VMALLOC_START && addr < VMALLOC_END)) {
> >>> +     if (unlikely(addr >=3D TASK_SIZE)) {
> >>>                vmalloc_fault(regs, code, addr);
> >>>                return;
> >>>        }
> >>
> >> Can you share what you are trying to fix here?
> > We met a spurious page fault panic on an OoO machine.
> >
> > 1. The processor speculative execution brings the V=3D0 entries into th=
e
> > TLB in the kernel virtual address.
> > 2. Linux kernel installs the kernel virtual address with the page, and =
V=3D1
> > 3. When kernel code access the kernel virtual address, it would raise
> > a page fault as the V=3D0 entry in the tlb.
> > 4. No vmalloc_fault, then panic.
> >
> >> I have a fix (that's currently running our CI) for commit 7d3332be011e
> >> ("riscv: mm: Pre-allocate PGD entries for vmalloc/modules area") that
> >> implements flush_cache_vmap() since we lost the vmalloc_fault.
> > Could you share that patch?
>
>
> Here we go:
>
>
> Author: Alexandre Ghiti <alexghiti@rivosinc.com>
> Date:   Fri Jul 21 08:43:44 2023 +0000
>
>      riscv: Implement flush_cache_vmap()
>
>      The RISC-V kernel needs a sfence.vma after a page table
> modification: we
>      used to rely on the vmalloc fault handling to emit an sfence.vma, bu=
t
>      commit 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for
>      vmalloc/modules area") got rid of this path for 64-bit kernels, so
> now we
>      need to explicitly emit a sfence.vma in flush_cache_vmap().
>
>      Note that we don't need to implement flush_cache_vunmap() as the
> generic
>      code should emit a flush tlb after unmapping a vmalloc region.
>
>      Fixes: 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for
> vmalloc/modules area")
>      Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> diff --git a/arch/riscv/include/asm/cacheflush.h
> b/arch/riscv/include/asm/cacheflush.h
> index 8091b8bf4883..b93ffddf8a61 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -37,6 +37,10 @@ static inline void flush_dcache_page(struct page *page=
)
>   #define flush_icache_user_page(vma, pg, addr, len) \
>          flush_icache_mm(vma->vm_mm, 0)
>
> +#ifdef CONFIG_64BIT
> +#define flush_cache_vmap(start, end) flush_tlb_kernel_range(start, end)
> +#endif
I don't want that, and flush_tlb_kernel_range is flush_tlb_all. In
addition, it would call IPI, which is a performance killer.

What's the problem of spurious fault replay? It only costs a
local_tlb_flush with vaddr.

> +
>   #ifndef CONFIG_SMP
>
>   #define flush_icache_all() local_flush_icache_all()
>
>
> Let me know if that works for you!
>
>
> >
> >

--
Best Regards
 Guo Ren
