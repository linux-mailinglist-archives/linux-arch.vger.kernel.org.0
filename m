Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A15275489D
	for <lists+linux-arch@lfdr.de>; Sat, 15 Jul 2023 15:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjGONMA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 Jul 2023 09:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGONL7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 15 Jul 2023 09:11:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E612120;
        Sat, 15 Jul 2023 06:11:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D0B660BA1;
        Sat, 15 Jul 2023 13:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3903C433C9;
        Sat, 15 Jul 2023 13:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689426716;
        bh=17PQtY6d3Z0UbdwCJ17vdKznTHGmxUohmQTVsIBYpBs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fMqVelIFeJNsfrXxYZyoEa5TzfnGtS8YtXAARmrgZ9exu3QuJlLTsV3RqkVAb3zgo
         Q4HJhxjBs6KBP/ZmDAFXhuP8OgYg5bxapmq+zhW5SAErY4zM4EmqiXO5ofx1s9SAMT
         yi1Ev07YZn4uNOshhe0PgjP4ozqx6fFZ1jzjvt1+LlBfinC0XpJSVd23PI1jUYMoUG
         lTi+yzyhGmDvQ+y/AcOU0i2FVZVlhaeGyakCUbs7o1UK0fZgTnIwSZU7YKKgYFXY+e
         HAWbIlGP/tAnRAhFWlivf5uVVwaw1NKM4spx2tUoYdrGRt4sM95PbKjZA/kPjj/klo
         IJXdegrRmfvsQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5217ad95029so335952a12.2;
        Sat, 15 Jul 2023 06:11:56 -0700 (PDT)
X-Gm-Message-State: ABy/qLZ4ysu+wXMGNfaNPDqO595Vm2ki/8gdHzs+0xQoPzjJk9B+mn3a
        /rIVL9FrLslbFrWrTLHWGZid4MzTts44Lw6Wf1k=
X-Google-Smtp-Source: APBJJlGnMWUgYPQOzvBFlFwDpTv0Wej1AnaGlKZCCGg1taFtxTrREIF+lLqN/PBP32+xCf7GwYR//QlmJ/MR59cyDCY=
X-Received: by 2002:aa7:d605:0:b0:50b:c085:1991 with SMTP id
 c5-20020aa7d605000000b0050bc0851991mr7484346edr.19.1689426715003; Sat, 15 Jul
 2023 06:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <95c4e875-02f1-6239-bb62-41b709d21541@ghiti.fr>
 <mhng-5d9d9723-1dc1-4429-a477-eb4ece20bb87@palmer-ri-x1c9a> <CAJF2gTT4aANEzOQBSOgvFBwNxp5AAd_oTKfecC8d5mmH7YUhhA@mail.gmail.com>
In-Reply-To: <CAJF2gTT4aANEzOQBSOgvFBwNxp5AAd_oTKfecC8d5mmH7YUhhA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 15 Jul 2023 21:11:43 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ+9DcJk3WVp7D5g+0Fxev8U6PHhQqVJtwdB0gQN_GQ6A@mail.gmail.com>
Message-ID: <CAJF2gTQ+9DcJk3WVp7D5g+0Fxev8U6PHhQqVJtwdB0gQN_GQ6A@mail.gmail.com>
Subject: Re: [PATCH V2] riscv: kexec: Fixup synchronization problem between
 init_mm and active_mm
To:     Palmer Dabbelt <palmer@rivosinc.com>, xingxg2008@163.com
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

On Thu, Jul 13, 2023 at 11:11=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote:
>
> On Wed, Jul 12, 2023 at 10:43=E2=80=AFAM Palmer Dabbelt <palmer@rivosinc.=
com> wrote:
> >
> > On Tue, 11 Jul 2023 04:07:22 PDT (-0700), alex@ghiti.fr wrote:
> > > Hi Guo,
> > >
> > >
> > > On 10/07/2023 07:40, guoren@kernel.org wrote:
> > >> From: Guo Ren <guoren@linux.alibaba.com>
> > >>
> > >> The machine_kexec() uses set_memory_x to modify the direct mapping
> > >> attributes from RW to RWX. But set_memory_x only changes the init_mm=
's
> > >> attributes, not current->active_mm, so when kexec jumps into
> > >> control_buffer, the instruction page fault happens, and there is no
> > >> minor_pagefault for it, then panic.
> > >
> > >
> > > I think it needs more details like this:
> > >
> > > "The current implementation of set_memory_x does not split hugepages =
in
> > > the linear mapping and then when a PGD mapping is used, the whole PGD=
 is
> > > marked as executable. But changing the permissions at the PGD level m=
ust
> > > be propagated to all the page tables."
> > >
> > >
> > >>
> > >> The bug is found on an MMU_sv39 machine, and the direct mapping used=
 a
> > >> 1GB PUD, the pgd entries. Here is the bug output:
> > >>
> > >>   kexec_core: Starting new kernel
> > >>   Will call new kernel at 00300000 from hart id 0
> > >>   FDT image at 747c7000
> > >>   Bye...
> > >>   Unable to handle kernel paging request at virtual address ffffffda=
23b0d000
> > >>   Oops [#1]
> > >>   Modules linked in:
> > >>   CPU: 0 PID: 53 Comm: uinit Not tainted 6.4.0-rc6 #15
> > >>   Hardware name: Sophgo Mango (DT)
> > >>   epc : 0xffffffda23b0d000
> > >>    ra : machine_kexec+0xa6/0xb0
> > >>   epc : ffffffda23b0d000 ra : ffffffff80008272 sp : ffffffc80c173d10
> > >>    gp : ffffffff8150e1e0 tp : ffffffd9073d2c40 t0 : 0000000000000000
> > >>    t1 : 0000000000000042 t2 : 6567616d69205444 s0 : ffffffc80c173d50
> > >>    s1 : ffffffd9076c4800 a0 : ffffffd9076c4800 a1 : 0000000000300000
> > >>    a2 : 00000000747c7000 a3 : 0000000000000000 a4 : ffffffd800000000
> > >>    a5 : 0000000000000000 a6 : ffffffd903619c40 a7 : ffffffffffffffff
> > >>    s2 : ffffffda23b0d000 s3 : 0000000000300000 s4 : 00000000747c7000
> > >>    s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000000000000000
> > >>    s8 : 0000000000000000 s9 : 0000000000000000 s10: 0000000000000000
> > >>    s11: 0000003f940001a0 t3 : ffffffff815351af t4 : ffffffff815351af
> > >>    t5 : ffffffff815351b0 t6 : ffffffc80c173b50
> > >>   status: 0000000200000100 badaddr: ffffffda23b0d000 cause: 00000000=
0000000c
> > >>
> > >> The solution is to fix machine_kexec() to remap control code page ou=
tside
> > >> the linear mapping.
> > >
> > >
> > > "Given the current flaw in the set_memory_x implementation, the simpl=
est
> > > solution is to ..."
> > >
> > >
> > >>
> > >> Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear ma=
pping")
> > >> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > >> Signed-off-by: Guo Ren <guoren@kernel.org>
> > >> Cc: Alexandre Ghiti <alex@ghiti.fr>
> > >> ---
> > >> Changelog:
> > >> V2:
> > >>   - Use vm_map_ram instead of modifying set_memory_x
> > >>   - Correct Fixes tag
> > >> ---
> > >>   arch/riscv/include/asm/kexec.h    |  1 +
> > >>   arch/riscv/kernel/machine_kexec.c | 14 ++++++++++----
> > >>   2 files changed, 11 insertions(+), 4 deletions(-)
> > >>
> > >> diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm=
/kexec.h
> > >> index 2b56769cb530..17456e91476e 100644
> > >> --- a/arch/riscv/include/asm/kexec.h
> > >> +++ b/arch/riscv/include/asm/kexec.h
> > >> @@ -41,6 +41,7 @@ crash_setup_regs(struct pt_regs *newregs,
> > >>   struct kimage_arch {
> > >>      void *fdt; /* For CONFIG_KEXEC_FILE */
> > >>      unsigned long fdt_addr;
> > >> +    void *control_code_buffer;
> > >>   };
> > >>
> > >>   extern const unsigned char riscv_kexec_relocate[];
> > >> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/m=
achine_kexec.c
> > >> index 2d139b724bc8..eeb209775107 100644
> > >> --- a/arch/riscv/kernel/machine_kexec.c
> > >> +++ b/arch/riscv/kernel/machine_kexec.c
> > >> @@ -86,7 +86,14 @@ machine_kexec_prepare(struct kimage *image)
> > >>
> > >>      /* Copy the assembler code for relocation to the control page *=
/
> > >>      if (image->type !=3D KEXEC_TYPE_CRASH) {
> > >> -            control_code_buffer =3D page_address(image->control_cod=
e_page);
> > >> +            control_code_buffer =3D vm_map_ram(&image->control_code=
_page,
> > >> +                                             KEXEC_CONTROL_PAGE_SIZ=
E/PAGE_SIZE,
> > >> +                                             NUMA_NO_NODE);
> > >> +            if (control_code_buffer =3D=3D NULL) {
> > >> +                    pr_err("Failed to vm_map control page\n");
> > >> +                    return -ENOMEM;
> > >> +            }
> > >> +
> > >>              control_code_buffer_sz =3D page_size(image->control_cod=
e_page);
> > >>
> > >>              if (unlikely(riscv_kexec_relocate_size > control_code_b=
uffer_sz)) {
> > >> @@ -97,8 +104,7 @@ machine_kexec_prepare(struct kimage *image)
> > >>              memcpy(control_code_buffer, riscv_kexec_relocate,
> > >>                      riscv_kexec_relocate_size);
> > >>
> > >> -            /* Mark the control page executable */
> > >> -            set_memory_x((unsigned long) control_code_buffer, 1);
> > >> +            internal->control_code_buffer =3D control_code_buffer;
> > >
> > >
> > > Where is this mapping marked as executable? I see that vm_map_ram() m=
aps
> > > the pages as PAGE_KERNEL, which does not set PAGE_EXEC.
> > >
> > >
> > >>      }
> > >>
> > >>      return 0;
> > >> @@ -211,7 +217,7 @@ machine_kexec(struct kimage *image)
> > >>      unsigned long this_cpu_id =3D __smp_processor_id();
> > >>      unsigned long this_hart_id =3D cpuid_to_hartid_map(this_cpu_id)=
;
> > >>      unsigned long fdt_addr =3D internal->fdt_addr;
> > >> -    void *control_code_buffer =3D page_address(image->control_code_=
page);
> > >> +    void *control_code_buffer =3D internal->control_code_buffer;
> > >>      riscv_kexec_method kexec_method =3D NULL;
> > >>
> > >>   #ifdef CONFIG_SMP
> > >
> > >
> > > Otherwise, you can add:
> > >
> > > Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > >
> > > Thanks,
> > >
> > > Alex
> >
> > Thanks for looking at this.  Guo: do you have a re-spit that fixes the
> > issues Alex pointed out?  Sorry if I just missed it.
> Sorry for the late reply. Here is the patch of v3:
> https://lore.kernel.org/linux-riscv/20230713150758.2956316-1-guoren@kerne=
l.org/
@Palmer Dabbelt

Above V3 has been abandoned; I've updated it to V4:
https://lore.kernel.org/linux-riscv/20230714103659.3146949-1-guoren@kernel.=
org/

Xing Xiaoguang has tested it:
https://lore.kernel.org/lkml/6b766b2b.2e5.189570f5ee6.Coremail.xingxg2008@1=
63.com/

>
>
>
> --
> Best Regards
>  Guo Ren



--=20
Best Regards
 Guo Ren
