Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3564D753037
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jul 2023 05:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjGNDz2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jul 2023 23:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjGNDz1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Jul 2023 23:55:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD3126A5;
        Thu, 13 Jul 2023 20:55:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 796E461BE6;
        Fri, 14 Jul 2023 03:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EE8C433CD;
        Fri, 14 Jul 2023 03:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689306925;
        bh=ClINz3RQbyjRixy2nvQIEdnp8Sp5J2n8LBSKLCGZslA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EQMgOFlhQUMmW9S/Y46JEwwc3fz1pTYXcFrWyw1I3MlUjx2ud2hzS1or60vX1H4pU
         M6aGqqlRY3se/NRO4ofkLnazMcyllPrmlZ5PPXWaEMivrwSmn+ZBhlZuGMOg8KULQh
         kKZU+xZurixkTYswkThfvOJM1Xhp+oJuUysJvEtalZbkYB2tF15p3zLR0iUMYSYwaB
         xlDuq80Puz1BTq8Kn+uftT17cPTXjDi2giGYFj2nVuy9eXMpgtT2o/O6xssQypYU7A
         Wrub+BmLvFuoa5HRYOJj7dppJ5ibSXYoq9NaoQAaiiengYe4X5cC6AiB5QQ8OkU93O
         zHKKdQH7PcgHA==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-51ff068c09cso1804516a12.2;
        Thu, 13 Jul 2023 20:55:25 -0700 (PDT)
X-Gm-Message-State: ABy/qLbLSsgcqO/DPNZmkpE3xzMX2EeOY/gmPcsccY6/r292TwxWzDfZ
        TYQQV3x4QxXX2USKgOb2mzVmzO6h1N93JNtqmkA=
X-Google-Smtp-Source: APBJJlGgX78320qcRTV9RrMXVuoiiAjswSJGS+S0PWwy2PB4cP88H3fObVNKz26EMzCU/XB6LgLAbCXFfTzEqApuj80=
X-Received: by 2002:aa7:d359:0:b0:51e:3558:5eb8 with SMTP id
 m25-20020aa7d359000000b0051e35585eb8mr3496853edr.19.1689306923959; Thu, 13
 Jul 2023 20:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230713150758.2956316-1-guoren@kernel.org>
In-Reply-To: <20230713150758.2956316-1-guoren@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 14 Jul 2023 11:55:12 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTWUNWs9gbH+RudLkfiDfwDeASRp8p-zcKeKN-MgZVjEw@mail.gmail.com>
Message-ID: <CAJF2gTTWUNWs9gbH+RudLkfiDfwDeASRp8p-zcKeKN-MgZVjEw@mail.gmail.com>
Subject: Re: [PATCH V3] riscv: kexec: Fixup synchronization problem between
 init_mm and active_mm
To:     guoren@kernel.org, palmer@rivosinc.com, paul.walmsley@sifive.com,
        zong.li@sifive.com, atishp@atishpatra.org, alex@ghiti.fr
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
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

Sorry, this patch is broken with riscv_kexec_relocate which depends on
direct mapping. I'm debugging on it. Please abandon it.

On Thu, Jul 13, 2023 at 11:08=E2=80=AFAM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> The machine_kexec() uses set_memory_x to modify the direct mapping
> Aattributes from RW to RWX. The current implementation of set_memory_x

> does not split hugepages in the linear mapping and then when a PGD
> mapping is used, the whole PGD is marked as executable. But changing
> the permissions at the PGD level must be propagated to all the page
> tables. When kexec jumps into control_buffer, the instruction page
> fault happens, and there is no minor_pagefault for it, then panic.
>
> The bug is found on an MMU_sv39 machine, and the direct mapping used a
> 1GB PUD, the pgd entries. Here is the bug output:
>
>  kexec_core: Starting new kernel
>  Will call new kernel at 00300000 from hart id 0
>  FDT image at 747c7000
>  Bye...
>  Unable to handle kernel paging request at virtual address ffffffda23b0d0=
00
>  Oops [#1]
>  Modules linked in:
>  CPU: 0 PID: 53 Comm: uinit Not tainted 6.4.0-rc6 #15
>  Hardware name: Sophgo Mango (DT)
>  epc : 0xffffffda23b0d000
>   ra : machine_kexec+0xa6/0xb0
>  epc : ffffffda23b0d000 ra : ffffffff80008272 sp : ffffffc80c173d10
>   gp : ffffffff8150e1e0 tp : ffffffd9073d2c40 t0 : 0000000000000000
>   t1 : 0000000000000042 t2 : 6567616d69205444 s0 : ffffffc80c173d50
>   s1 : ffffffd9076c4800 a0 : ffffffd9076c4800 a1 : 0000000000300000
>   a2 : 00000000747c7000 a3 : 0000000000000000 a4 : ffffffd800000000
>   a5 : 0000000000000000 a6 : ffffffd903619c40 a7 : ffffffffffffffff
>   s2 : ffffffda23b0d000 s3 : 0000000000300000 s4 : 00000000747c7000
>   s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000000000000000
>   s8 : 0000000000000000 s9 : 0000000000000000 s10: 0000000000000000
>   s11: 0000003f940001a0 t3 : ffffffff815351af t4 : ffffffff815351af
>   t5 : ffffffff815351b0 t6 : ffffffc80c173b50
>  status: 0000000200000100 badaddr: ffffffda23b0d000 cause: 00000000000000=
0c
>
> Given the current flaw in the set_memory_x implementation, the simplest
> solution is to fix machine_kexec() to remap control code page outside
> the linear mapping.
>
> Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping=
")
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
> Changelog:
> V3:
>  - Resume set_memory_x to set the _PAGE_EXEC attribute
>  - Optimize the commit log with Alexandre advice
>
> V2:
>  - Use vm_map_ram instead of modifying set_memory_x
>  - Correct Fixes tag
> ---
>  arch/riscv/include/asm/kexec.h    |  1 +
>  arch/riscv/kernel/machine_kexec.c | 13 +++++++++++--
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexe=
c.h
> index 2b56769cb530..17456e91476e 100644
> --- a/arch/riscv/include/asm/kexec.h
> +++ b/arch/riscv/include/asm/kexec.h
> @@ -41,6 +41,7 @@ crash_setup_regs(struct pt_regs *newregs,
>  struct kimage_arch {
>         void *fdt; /* For CONFIG_KEXEC_FILE */
>         unsigned long fdt_addr;
> +       void *control_code_buffer;
>  };
>
>  extern const unsigned char riscv_kexec_relocate[];
> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machin=
e_kexec.c
> index 2d139b724bc8..83b499178902 100644
> --- a/arch/riscv/kernel/machine_kexec.c
> +++ b/arch/riscv/kernel/machine_kexec.c
> @@ -86,7 +86,14 @@ machine_kexec_prepare(struct kimage *image)
>
>         /* Copy the assembler code for relocation to the control page */
>         if (image->type !=3D KEXEC_TYPE_CRASH) {
> -               control_code_buffer =3D page_address(image->control_code_=
page);
> +               control_code_buffer =3D vm_map_ram(&image->control_code_p=
age,
> +                                                KEXEC_CONTROL_PAGE_SIZE/=
PAGE_SIZE,
> +                                                NUMA_NO_NODE);
> +               if (control_code_buffer =3D=3D NULL) {
> +                       pr_err("Failed to vm_map control page\n");
> +                       return -ENOMEM;
> +               }
> +
>                 control_code_buffer_sz =3D page_size(image->control_code_=
page);
>
>                 if (unlikely(riscv_kexec_relocate_size > control_code_buf=
fer_sz)) {
> @@ -99,6 +106,8 @@ machine_kexec_prepare(struct kimage *image)
>
>                 /* Mark the control page executable */
>                 set_memory_x((unsigned long) control_code_buffer, 1);
> +
> +               internal->control_code_buffer =3D control_code_buffer;
>         }
>
>         return 0;
> @@ -211,7 +220,7 @@ machine_kexec(struct kimage *image)
>         unsigned long this_cpu_id =3D __smp_processor_id();
>         unsigned long this_hart_id =3D cpuid_to_hartid_map(this_cpu_id);
>         unsigned long fdt_addr =3D internal->fdt_addr;
> -       void *control_code_buffer =3D page_address(image->control_code_pa=
ge);
> +       void *control_code_buffer =3D internal->control_code_buffer;
>         riscv_kexec_method kexec_method =3D NULL;
>
>  #ifdef CONFIG_SMP
> --
> 2.36.1
>


--
Best Regards
 Guo Ren
