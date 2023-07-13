Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD5D752647
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jul 2023 17:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjGMPLe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jul 2023 11:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjGMPLb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Jul 2023 11:11:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835F91FEA;
        Thu, 13 Jul 2023 08:11:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4A7B618D3;
        Thu, 13 Jul 2023 15:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C66C433C7;
        Thu, 13 Jul 2023 15:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689261088;
        bh=ZtH+GlDdivHu1TyKQKqKVvi/5sgtqO1BM92IP1CZDd4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r6DFa7JgL+R5DiacvzwCcXVkQs266hF+0rdKOrdVRB7p/e4dTVX1SLB0WY10UmCIn
         eogmUL43AYZalMgWqHa+LyALJgqUqtkgnJP4W1c6LUdZFrHlH6URYO3zlNo8jteLCj
         jNUa4j/77juspqoBwWJWDup9xb40ypPSXu+7tGMnbfKuctvUHufbPcsSPY/UT8pYZb
         USSgUYB8LfxO6USS9jwK6ojFBI2oJyOfU9bqppC9ndLFtNvNASu439eeuknplyYKIB
         xB10kf8sD3VhHXpemKo7w3S6g4c/Wz4R6XA5fzAtt6m+gVyTJTDGE21ej4k/7xzT9H
         UQDrjfPEC7PXw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4fb761efa7aso1449327e87.0;
        Thu, 13 Jul 2023 08:11:28 -0700 (PDT)
X-Gm-Message-State: ABy/qLYtqHPYFvSOXnDl3+cMmH/vcAQuvOpC7iObbruGXZ2UC6fRTpFw
        z58xhPRWIU/K05n7Z3lJyScdgvVsG0s2tp4Qads=
X-Google-Smtp-Source: APBJJlFHu2HbFrvQZCoSTqmJ1NrwbmAbDYKuB5uzDzk9yIFMs3p6qkhlU2xelBlC1OrpFuEn/SQGYyLj0oqw+HkmkDg=
X-Received: by 2002:a05:6512:3125:b0:4f9:5571:544f with SMTP id
 p5-20020a056512312500b004f95571544fmr1370193lfd.17.1689261086124; Thu, 13 Jul
 2023 08:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <95c4e875-02f1-6239-bb62-41b709d21541@ghiti.fr> <mhng-5d9d9723-1dc1-4429-a477-eb4ece20bb87@palmer-ri-x1c9a>
In-Reply-To: <mhng-5d9d9723-1dc1-4429-a477-eb4ece20bb87@palmer-ri-x1c9a>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 13 Jul 2023 11:11:13 -0400
X-Gmail-Original-Message-ID: <CAJF2gTT4aANEzOQBSOgvFBwNxp5AAd_oTKfecC8d5mmH7YUhhA@mail.gmail.com>
Message-ID: <CAJF2gTT4aANEzOQBSOgvFBwNxp5AAd_oTKfecC8d5mmH7YUhhA@mail.gmail.com>
Subject: Re: [PATCH V2] riscv: kexec: Fixup synchronization problem between
 init_mm and active_mm
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     alex@ghiti.fr, Paul Walmsley <paul.walmsley@sifive.com>,
        zong.li@sifive.com, atishp@atishpatra.org, jszhang@kernel.org,
        bjorn@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        guoren@linux.alibaba.com
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

On Wed, Jul 12, 2023 at 10:43=E2=80=AFAM Palmer Dabbelt <palmer@rivosinc.co=
m> wrote:
>
> On Tue, 11 Jul 2023 04:07:22 PDT (-0700), alex@ghiti.fr wrote:
> > Hi Guo,
> >
> >
> > On 10/07/2023 07:40, guoren@kernel.org wrote:
> >> From: Guo Ren <guoren@linux.alibaba.com>
> >>
> >> The machine_kexec() uses set_memory_x to modify the direct mapping
> >> attributes from RW to RWX. But set_memory_x only changes the init_mm's
> >> attributes, not current->active_mm, so when kexec jumps into
> >> control_buffer, the instruction page fault happens, and there is no
> >> minor_pagefault for it, then panic.
> >
> >
> > I think it needs more details like this:
> >
> > "The current implementation of set_memory_x does not split hugepages in
> > the linear mapping and then when a PGD mapping is used, the whole PGD i=
s
> > marked as executable. But changing the permissions at the PGD level mus=
t
> > be propagated to all the page tables."
> >
> >
> >>
> >> The bug is found on an MMU_sv39 machine, and the direct mapping used a
> >> 1GB PUD, the pgd entries. Here is the bug output:
> >>
> >>   kexec_core: Starting new kernel
> >>   Will call new kernel at 00300000 from hart id 0
> >>   FDT image at 747c7000
> >>   Bye...
> >>   Unable to handle kernel paging request at virtual address ffffffda23=
b0d000
> >>   Oops [#1]
> >>   Modules linked in:
> >>   CPU: 0 PID: 53 Comm: uinit Not tainted 6.4.0-rc6 #15
> >>   Hardware name: Sophgo Mango (DT)
> >>   epc : 0xffffffda23b0d000
> >>    ra : machine_kexec+0xa6/0xb0
> >>   epc : ffffffda23b0d000 ra : ffffffff80008272 sp : ffffffc80c173d10
> >>    gp : ffffffff8150e1e0 tp : ffffffd9073d2c40 t0 : 0000000000000000
> >>    t1 : 0000000000000042 t2 : 6567616d69205444 s0 : ffffffc80c173d50
> >>    s1 : ffffffd9076c4800 a0 : ffffffd9076c4800 a1 : 0000000000300000
> >>    a2 : 00000000747c7000 a3 : 0000000000000000 a4 : ffffffd800000000
> >>    a5 : 0000000000000000 a6 : ffffffd903619c40 a7 : ffffffffffffffff
> >>    s2 : ffffffda23b0d000 s3 : 0000000000300000 s4 : 00000000747c7000
> >>    s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000000000000000
> >>    s8 : 0000000000000000 s9 : 0000000000000000 s10: 0000000000000000
> >>    s11: 0000003f940001a0 t3 : ffffffff815351af t4 : ffffffff815351af
> >>    t5 : ffffffff815351b0 t6 : ffffffc80c173b50
> >>   status: 0000000200000100 badaddr: ffffffda23b0d000 cause: 0000000000=
00000c
> >>
> >> The solution is to fix machine_kexec() to remap control code page outs=
ide
> >> the linear mapping.
> >
> >
> > "Given the current flaw in the set_memory_x implementation, the simples=
t
> > solution is to ..."
> >
> >
> >>
> >> Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapp=
ing")
> >> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> >> Signed-off-by: Guo Ren <guoren@kernel.org>
> >> Cc: Alexandre Ghiti <alex@ghiti.fr>
> >> ---
> >> Changelog:
> >> V2:
> >>   - Use vm_map_ram instead of modifying set_memory_x
> >>   - Correct Fixes tag
> >> ---
> >>   arch/riscv/include/asm/kexec.h    |  1 +
> >>   arch/riscv/kernel/machine_kexec.c | 14 ++++++++++----
> >>   2 files changed, 11 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/k=
exec.h
> >> index 2b56769cb530..17456e91476e 100644
> >> --- a/arch/riscv/include/asm/kexec.h
> >> +++ b/arch/riscv/include/asm/kexec.h
> >> @@ -41,6 +41,7 @@ crash_setup_regs(struct pt_regs *newregs,
> >>   struct kimage_arch {
> >>      void *fdt; /* For CONFIG_KEXEC_FILE */
> >>      unsigned long fdt_addr;
> >> +    void *control_code_buffer;
> >>   };
> >>
> >>   extern const unsigned char riscv_kexec_relocate[];
> >> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/mac=
hine_kexec.c
> >> index 2d139b724bc8..eeb209775107 100644
> >> --- a/arch/riscv/kernel/machine_kexec.c
> >> +++ b/arch/riscv/kernel/machine_kexec.c
> >> @@ -86,7 +86,14 @@ machine_kexec_prepare(struct kimage *image)
> >>
> >>      /* Copy the assembler code for relocation to the control page */
> >>      if (image->type !=3D KEXEC_TYPE_CRASH) {
> >> -            control_code_buffer =3D page_address(image->control_code_=
page);
> >> +            control_code_buffer =3D vm_map_ram(&image->control_code_p=
age,
> >> +                                             KEXEC_CONTROL_PAGE_SIZE/=
PAGE_SIZE,
> >> +                                             NUMA_NO_NODE);
> >> +            if (control_code_buffer =3D=3D NULL) {
> >> +                    pr_err("Failed to vm_map control page\n");
> >> +                    return -ENOMEM;
> >> +            }
> >> +
> >>              control_code_buffer_sz =3D page_size(image->control_code_=
page);
> >>
> >>              if (unlikely(riscv_kexec_relocate_size > control_code_buf=
fer_sz)) {
> >> @@ -97,8 +104,7 @@ machine_kexec_prepare(struct kimage *image)
> >>              memcpy(control_code_buffer, riscv_kexec_relocate,
> >>                      riscv_kexec_relocate_size);
> >>
> >> -            /* Mark the control page executable */
> >> -            set_memory_x((unsigned long) control_code_buffer, 1);
> >> +            internal->control_code_buffer =3D control_code_buffer;
> >
> >
> > Where is this mapping marked as executable? I see that vm_map_ram() map=
s
> > the pages as PAGE_KERNEL, which does not set PAGE_EXEC.
> >
> >
> >>      }
> >>
> >>      return 0;
> >> @@ -211,7 +217,7 @@ machine_kexec(struct kimage *image)
> >>      unsigned long this_cpu_id =3D __smp_processor_id();
> >>      unsigned long this_hart_id =3D cpuid_to_hartid_map(this_cpu_id);
> >>      unsigned long fdt_addr =3D internal->fdt_addr;
> >> -    void *control_code_buffer =3D page_address(image->control_code_pa=
ge);
> >> +    void *control_code_buffer =3D internal->control_code_buffer;
> >>      riscv_kexec_method kexec_method =3D NULL;
> >>
> >>   #ifdef CONFIG_SMP
> >
> >
> > Otherwise, you can add:
> >
> > Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> >
> > Thanks,
> >
> > Alex
>
> Thanks for looking at this.  Guo: do you have a re-spit that fixes the
> issues Alex pointed out?  Sorry if I just missed it.
Sorry for the late reply. Here is the patch of v3:
https://lore.kernel.org/linux-riscv/20230713150758.2956316-1-guoren@kernel.=
org/



--=20
Best Regards
 Guo Ren
