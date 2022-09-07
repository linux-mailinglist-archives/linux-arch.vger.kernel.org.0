Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4A05AFA43
	for <lists+linux-arch@lfdr.de>; Wed,  7 Sep 2022 04:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIGCwg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Sep 2022 22:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiIGCwf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Sep 2022 22:52:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFF07B1FF;
        Tue,  6 Sep 2022 19:52:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDA53B81AFD;
        Wed,  7 Sep 2022 02:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62956C4347C;
        Wed,  7 Sep 2022 02:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662519151;
        bh=wgqcaiZkWE8NP1DBVD4GgPPb3+9Nw6BMXdA/+pG3KWw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JAsOmqbPLEdHftCiu95iAXHok5mmGgJpnXETTKgVZ9Wy6+f0/NN7SkIRxOzEUzJin
         dOTuvO/VArrQ5zvEs4PYy3D21vymr44aP1wMiNtsE8FSh7eHU/BeX8c0ZduuJsr0Ja
         UNvlJD5tGPMDx/pZ05aJ2dfJjCsX1GN5yyUoBoDB/iwvwCMZd+So9pLi0ohrqfx92p
         4ZKOgMCo38/ZqHsavgkDoPS7RlrcTeUML4MDOPu2wdN65puL9Bb9ukk11UiV+PQs3r
         8PtuLKae5H6VqKTVopJZsx6Kt3eTYewJF3F/W5pR+PB3vP/4rgoJn85U4VPo+G+33C
         q/ERhVQC7XTJQ==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1225219ee46so32970664fac.2;
        Tue, 06 Sep 2022 19:52:31 -0700 (PDT)
X-Gm-Message-State: ACgBeo1qNFXJyKs+6oBFwn9Z7RkNrC9eH2ZQB8LYqXYiU7gEtzsXcK9V
        4UDWgFDEbcGhMMhZ7ppqC6nC7Ydsv4mdW5B2YbI=
X-Google-Smtp-Source: AA6agR4o2x+CVUHP7OWdRqNkJSJ5xQCKxEdfB+Ewwu2cD8zAk2P2Te/dW27k40EH5nNM1daZoNzFCgrVbandNM3o9iQ=
X-Received: by 2002:a05:6870:7092:b0:11e:ff3a:d984 with SMTP id
 v18-20020a056870709200b0011eff3ad984mr12781797oae.19.1662519150455; Tue, 06
 Sep 2022 19:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220906035423.634617-1-guoren@kernel.org> <8db7caea-a1a0-25a3-ade0-2f1714d709c8@microchip.com>
 <CAJF2gTQ29bn=hgubC+YU1qSw_L3W2kAt3Yi4_EknrNCkR-dRFg@mail.gmail.com>
In-Reply-To: <CAJF2gTQ29bn=hgubC+YU1qSw_L3W2kAt3Yi4_EknrNCkR-dRFg@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 7 Sep 2022 10:52:18 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRU6xWv5z7FvYkupCfmc0_EEceeowpjemoUWSAz8OgfWg@mail.gmail.com>
Message-ID: <CAJF2gTRU6xWv5z7FvYkupCfmc0_EEceeowpjemoUWSAz8OgfWg@mail.gmail.com>
Subject: Re: [PATCH V3 0/7] riscv: Add GENERIC_ENTRY, irq stack support
To:     Conor.Dooley@microchip.com
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, bigeasy@linutronix.de,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, guoren@linux.alibaba.com
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

Hi Conor,

I've found the root cause, you are using llvm:

$ grep "bare sym" llvm -rn |grep RISCV
llvm/lib/Target/RISCV/AsmParser/RISCVAsmParser.cpp:1296: return
Error(ErrorLoc, "operand must be a bare symbol name");
llvm/lib/Target/RISCV/AsmParser/RISCVAsmParser.cpp:1304: return
Error(ErrorLoc, "operand must be a bare symbol name");

That means we could fix up Binutils with a warning at least.

Thx for pointing it out.

On Wed, Sep 7, 2022 at 8:54 AM Guo Ren <guoren@kernel.org> wrote:
>
> On Wed, Sep 7, 2022 at 1:42 AM <Conor.Dooley@microchip.com> wrote:
> >
> > On 06/09/2022 04:54, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > The patches convert riscv to use the generic entry infrastructure fro=
m
> > > kernel/entry/*. Add independent irq stacks (IRQ_STACKS) for percpu to
> > > prevent kernel stack overflows. Add the HAVE_SOFTIRQ_ON_OWN_STACK
> > > feature for the IRQ_STACKS config. You can try it directly with [1].
> >
> > Hey Guo Ren,
> > I applied this patchset to v6.0-rc4 & ran into a build error:
> > /stuff/linux/arch/riscv/kernel/entry.S:347:9: error: operand must be a =
bare symbol name
> >  la a3, ((1 << (12)) << (2 + 0))
> Yes, please try:
> -       la      a3, IRQ_STACK_SIZE
> +       li      a3, IRQ_STACK_SIZE
>
> la is for the symbol, not immediate. But why does my toolchain not
> report the error?
>
> =E2=9E=9C  linux git:(generic_entry_v3) make ARCH=3Driscv
> CROSS_COMPILE=3Driscv64-unknown-linux-gnu- EXTRA_CFLAGS+=3D-g
> O=3D../build-riscv/ -kj62 all -kj
> =E2=9E=9C  linux git:(generic_entry_v3) riscv64-unknown-linux-gnu-gcc -v
> Using built-in specs.
> COLLECT_GCC=3Driscv64-unknown-linux-gnu-gcc
> COLLECT_LTO_WRAPPER=3D/opt/riscv/libexec/gcc/riscv64-unknown-linux-gnu/11=
.1.0/lto-wrapper
> Target: riscv64-unknown-linux-gnu
> Configured with:
> /home/guoren/source/riscv-gnu-toolchain/riscv-gcc/configure
> --target=3Driscv64-unknown-linux-gnu --prefix=3D/opt/riscv
> --with-sysroot=3D/opt/riscv/sysroot --with-pkgversion=3Dg5964b5cd7272
> --with-system-zlib --enable-shared --enable-tls
> --enable-languages=3Dc,c++,fortran --disable-libmudflap --disable-libssp
> --disable-libquadmath --disable-libsanitizer --disable-nls
> --disable-bootstrap --src=3D.././riscv-gcc --enable-multilib
> --with-abi=3Dlp64d --with-arch=3Drv64imafdc --with-tune=3Drocket
> --with-isa-spec=3D2.2 'CFLAGS_FOR_TARGET=3D-O2   -mcmodel=3Dmedlow'
> 'CXXFLAGS_FOR_TARGET=3D-O2   -mcmodel=3Dmedlow'
> Thread model: posix
> Supported LTO compression algorithms: zlib
> gcc version 11.1.0 (g5964b5cd7272)
>
>
>
> >         ^
> >   CC      arch/riscv/kernel/process.o
> > make[5]: *** [/stuff/linux/scripts/Makefile.build:322: arch/riscv/kerne=
l/entry.o] Error 1
> > make[5]: *** Waiting for unfinished jobs....
> >
> > Thanks,
> > Conor.
> > >
> > > [1] https://github.com/guoren83/linux/tree/generic_entry_v3
> > >
> > > V3:
> > >  - Fixup CONFIG_COMPAT=3Dn compile error
> > >  - Add THREAD_SIZE_ORDER config
> > >  - Optimize elf_kexec.c warning fixup
> > >  - Add static to irq_stack_ptr definition
> > >
> > > V2:
> > >  Link: https://lore.kernel.org/linux-riscv/20220904072637.8619-1-guor=
en@kernel.org/
> > >  - Fixup compile error by include "riscv: ptrace: Remove duplicate
> > >    operation"
> > >  - Fixup compile warning
> > >    Reported-by: kernel test robot <lkp@intel.com>
> > >  - Add test repo link in cover letter
> > >
> > > V1:
> > >  Link: https://lore.kernel.org/linux-riscv/20220903163808.1954131-1-g=
uoren@kernel.org/
> > >
> > > Guo Ren (7):
> > >   riscv: elf_kexec: Fixup compile warning
> > >   riscv: compat_syscall_table: Fixup compile warning
> > >   riscv: ptrace: Remove duplicate operation
> > >   riscv: convert to generic entry
> > >   riscv: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
> > >   riscv: Support HAVE_SOFTIRQ_ON_OWN_STACK
> > >   riscv: Add config of thread stack size
> > >
> > >  arch/riscv/Kconfig                    |  19 ++
> > >  arch/riscv/include/asm/csr.h          |   1 -
> > >  arch/riscv/include/asm/entry-common.h |   8 +
> > >  arch/riscv/include/asm/irq.h          |   3 +
> > >  arch/riscv/include/asm/ptrace.h       |  10 +-
> > >  arch/riscv/include/asm/stacktrace.h   |   5 +
> > >  arch/riscv/include/asm/syscall.h      |   6 +
> > >  arch/riscv/include/asm/thread_info.h  |  19 +-
> > >  arch/riscv/include/asm/vmap_stack.h   |  28 +++
> > >  arch/riscv/kernel/Makefile            |   1 +
> > >  arch/riscv/kernel/elf_kexec.c         |   2 +-
> > >  arch/riscv/kernel/entry.S             | 255 +++++-------------------=
--
> > >  arch/riscv/kernel/irq.c               |  75 ++++++++
> > >  arch/riscv/kernel/ptrace.c            |  41 -----
> > >  arch/riscv/kernel/signal.c            |  21 +--
> > >  arch/riscv/kernel/sys_riscv.c         |  27 +++
> > >  arch/riscv/kernel/traps.c             |  11 ++
> > >  arch/riscv/mm/fault.c                 |  12 +-
> > >  18 files changed, 259 insertions(+), 285 deletions(-)
> > >  create mode 100644 arch/riscv/include/asm/entry-common.h
> > >  create mode 100644 arch/riscv/include/asm/vmap_stack.h
> > >
>
>
>
> --
> Best Regards
>  Guo Ren



--=20
Best Regards
 Guo Ren
