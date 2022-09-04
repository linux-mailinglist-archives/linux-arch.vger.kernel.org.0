Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68FA5AC42D
	for <lists+linux-arch@lfdr.de>; Sun,  4 Sep 2022 13:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiIDLzi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Sep 2022 07:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbiIDLzg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 4 Sep 2022 07:55:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC81C31202;
        Sun,  4 Sep 2022 04:55:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C5A460F2A;
        Sun,  4 Sep 2022 11:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5307C43144;
        Sun,  4 Sep 2022 11:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662292531;
        bh=Ifm2jYc+GVOxme67tkpAAP8iyU1lr0Sp7tXITH/Z1GM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s/L8Mh2KYjDkg50qhjjMDk0QuQeZqOYMhZJhMOY5aBVuHngWMDD0I5dz4naEAcGSc
         3r6HauWmbM/ykl6Wy9QZLJ6papSxMOCrBjI3eXl6GaRYQzlum0bSI+Ax9UvuR/AnXz
         GKmsLVW3kyVciXMFUcYmiPL7inUhBu5Ne2MCmMM9U0T4EGL/yOpO1N528ENylP9tJi
         tNhomXSFDXgffx2kRrQl8WTs0lN7J09AJ3CmPCzumuc6EtUPjV/25w84Q2Zf5dvdlx
         h1Uvue3jeewKX1Jiou4NM88OLBRXclO5oxy5PlzdRxK/Ir4XH2v0+FqWYIhXNXQW2E
         VZg2irPi48Q1g==
Received: by mail-ot1-f47.google.com with SMTP id h20-20020a056830165400b00638ac7ddba5so4555239otr.4;
        Sun, 04 Sep 2022 04:55:31 -0700 (PDT)
X-Gm-Message-State: ACgBeo2jpo3uVDIlyetefXkCx+mydUP0v0KWvuG5FUY0brjarSdT69XP
        sxsRdHfrBXivj9aAyrDSzPLOUrwAMEz4Z7zW/os=
X-Google-Smtp-Source: AA6agR7E1nluqRw4qZiINjWPmeHGKzpp8l4SPUsHad64bOi4rRgWKW/vXFNrLzwvjkyVobbL7FJ39mxX8btwfro68eo=
X-Received: by 2002:a05:6830:3482:b0:638:92b7:f09b with SMTP id
 c2-20020a056830348200b0063892b7f09bmr17459110otu.140.1662292530673; Sun, 04
 Sep 2022 04:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220904072637.8619-1-guoren@kernel.org> <20220904072637.8619-6-guoren@kernel.org>
 <98efc4d8-f846-1ff1-2635-d18b7fca4ac8@microchip.com> <CAJF2gTQn0PpjERzKoBpx6npUs+gZmBNeRReNgeRP7RPod2WssA@mail.gmail.com>
 <8551463c-376c-8c64-6bf3-31dd5d9133d8@microchip.com>
In-Reply-To: <8551463c-376c-8c64-6bf3-31dd5d9133d8@microchip.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 4 Sep 2022 19:55:18 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQuJDev3fBjVvycDvwnhUBgaHzkh_sp9=BJefmr=KfqXQ@mail.gmail.com>
Message-ID: <CAJF2gTQuJDev3fBjVvycDvwnhUBgaHzkh_sp9=BJefmr=KfqXQ@mail.gmail.com>
Subject: Re: [PATCH V2 5/6] riscv: elf_kexec: Fixup compile warning
To:     Conor.Dooley@microchip.com
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        guoren@linux.alibaba.com, lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 4, 2022 at 7:13 PM <Conor.Dooley@microchip.com> wrote:
>
> On 04/09/2022 11:56, Guo Ren wrote:
> > On Sun, Sep 4, 2022 at 6:36 PM <Conor.Dooley@microchip.com> wrote:
> >>
> >> On 04/09/2022 08:26, guoren@kernel.org wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>
> >>> From: Guo Ren <guoren@linux.alibaba.com>
> >>>
> >>> COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1
> >>> O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/
> >>>
> >>> ../arch/riscv/kernel/elf_kexec.c: In function 'elf_kexec_load':
> >>> ../arch/riscv/kernel/elf_kexec.c:185:23: warning: variable
> >>> 'kernel_start' set but not used [-Wunused-but-set-variable]
> >>>   185 |         unsigned long kernel_start;
> >>>       |                       ^~~~~~~~~~~~
> >>>
> >>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> >>> Signed-off-by: Guo Ren <guoren@kernel.org>
> >>> Reported-by: kernel test robot <lkp@intel.com>
> >>
> >> Is this then a
> >> Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
> >> ?
> >>
> >> Could you also add something like:
> >> "If CONFIG_CRYTPO is not enabled, ...." to explain why this
> >> may be unused?
> >>
> >>> ---
> >>>  arch/riscv/kernel/elf_kexec.c | 4 ++++
> >>>  1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
> >>> index 0cb94992c15b..bba3723a0914 100644
> >>> --- a/arch/riscv/kernel/elf_kexec.c
> >>> +++ b/arch/riscv/kernel/elf_kexec.c
> >>> @@ -182,7 +182,9 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
> >>>         unsigned long new_kernel_pbase = 0UL;
> >>>         unsigned long initrd_pbase = 0UL;
> >>>         unsigned long headers_sz;
> >>> +#ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY
> >>>         unsigned long kernel_start;
> >>> +#endif /* CONFIG_ARCH_HAS_KEXEC_PURGATORY */
> >>>         void *fdt, *headers;
> >>>         struct elfhdr ehdr;
> >>>         struct kexec_buf kbuf;
> >>> @@ -197,7 +199,9 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
> >>>                              &old_kernel_pbase, &new_kernel_pbase);
> >>>         if (ret)
> >>>                 goto out;
> >>> +#ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY
> >>>         kernel_start = image->start;
> >>> +#endif /* CONFIG_ARCH_HAS_KEXEC_PURGATORY */
> >>
> >> Instead of adding more #ifdefs to the file, could we instead just drop the
> >> kernel_start variable? For the sake of compilation coverage, we could then
> >> also do the following (build-tested only):
> > Em... I prefer:
>
> Uh, that works for me. The below diff is:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Thx, your idea is also awesome which let me know the benefit of
IS_ENABLED() than ifdef.

>
> >
> > diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
> > index 0cb94992c15b..4b9264340b78 100644
> > --- a/arch/riscv/kernel/elf_kexec.c
> > +++ b/arch/riscv/kernel/elf_kexec.c
> > @@ -198,7 +198,7 @@ static void *elf_kexec_load(struct kimage *image,
> > char *kernel_buf,
> >         if (ret)
> >                 goto out;
> >         kernel_start = image->start;
> > -       pr_notice("The entry point of kernel at 0x%lx\n", image->start);
> > +       pr_notice("The entry point of kernel at 0x%lx\n", kernel_start);
> >
> >         /* Add the kernel binary to the image */
> >         ret = riscv_kexec_elf_load(image, &ehdr, &elf_info,
> >
> >
> >>
>
> Feel free to include this patch in your v3 then:
> >> -- >8 --
> >> From: Conor Dooley <conor.dooley@microchip.com>
> >> Date: Sun, 4 Sep 2022 11:27:07 +0100
> >> Subject: [PATCH] riscv: elf_kexec: replace ifdef with IS_ENABLED()
> >>
> >> IS_ENABLED() gives better compile time coverage than #ifdef.
> >> Replace the ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY in elf_kexec_load()
> >> since none of the code it guards uses a symbol that's missing if it
> >> is not set.
> >>
> >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >> ---
> >>  arch/riscv/kernel/elf_kexec.c | 28 ++++++++++++++--------------
> >>  1 file changed, 14 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
> >> index 0cb94992c15b..29cbf655c474 100644
> >> --- a/arch/riscv/kernel/elf_kexec.c
> >> +++ b/arch/riscv/kernel/elf_kexec.c
> >> @@ -248,21 +248,21 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
> >>                 cmdline = modified_cmdline;
> >>         }
> >>
> >> -#ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY
> >> -       /* Add purgatory to the image */
> >> -       kbuf.top_down = true;
> >> -       kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> >> -       ret = kexec_load_purgatory(image, &kbuf);
> >> -       if (ret) {
> >> -               pr_err("Error loading purgatory ret=%d\n", ret);
> >> -               goto out;
> >> +       if (IS_ENABLED(CONFIG_ARCH_HAS_KEXEC_PURGATORY)) {
> >> +               /* Add purgatory to the image */
> >> +               kbuf.top_down = true;
> >> +               kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> >> +               ret = kexec_load_purgatory(image, &kbuf);
> >> +               if (ret) {
> >> +                       pr_err("Error loading purgatory ret=%d\n", ret);
> >> +                       goto out;
> >> +               }
> >> +               ret = kexec_purgatory_get_set_symbol(image, "riscv_kernel_entry",
> >> +                                                    &kernel_start,
> >> +                                                    sizeof(kernel_start), 0);
> >> +               if (ret)
> >> +                       pr_err("Error update purgatory ret=%d\n", ret);
> >>         }
> >> -       ret = kexec_purgatory_get_set_symbol(image, "riscv_kernel_entry",
> >> -                                            &kernel_start,
> >> -                                            sizeof(kernel_start), 0);
> >> -       if (ret)
> >> -               pr_err("Error update purgatory ret=%d\n", ret);
> >> -#endif /* CONFIG_ARCH_HAS_KEXEC_PURGATORY */
> >>
> >>         /* Add the initrd to the image */
> >>         if (initrd != NULL) {
> >> --
> >> 2.37.1
> >>
> >
> >



-- 
Best Regards
 Guo Ren
