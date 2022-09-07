Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F405AFD10
	for <lists+linux-arch@lfdr.de>; Wed,  7 Sep 2022 09:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiIGHGU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Sep 2022 03:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIGHGT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Sep 2022 03:06:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCFF83BEE;
        Wed,  7 Sep 2022 00:06:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63558B81B72;
        Wed,  7 Sep 2022 07:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195B0C433B5;
        Wed,  7 Sep 2022 07:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662534375;
        bh=MTlgsU9SS8HzkvTx7GZdrV3UvG/7Yhzfy3rKEmcPDKQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AfFsZT5u5N9g0z+tUHyRuKoPP7U4OULYkInl6z8H4VUW5+B9gI1T3Eydf4PtP6UNi
         XHENG3/KM+J2Klo9pOuyB4F2APfOC/j1h1ejjtLmn22gZGgUtCxvqVu7NtWJc/fdsl
         Iha+70ECJx+wuj/JPSMW9Dk9ZOmF8Ez8McSn3tQZ61EhehL7h2bTYzbm6AxTW37dX4
         Z2ec4kVogrLn95iVYs7MDSwUJcRwptOgdJp2thyVftDULQIH4U3JyviydJuzjUxpNY
         7tY2qF1SMn+VaCF6Or6K/x46DdGjP6ff3HGGCUi3CdiBbfX79PUpgo7YcQH4nt5M7O
         +tr/GKjfd3Mjg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-127a3a39131so13064959fac.13;
        Wed, 07 Sep 2022 00:06:15 -0700 (PDT)
X-Gm-Message-State: ACgBeo3KS2S+zVA1is6iwk30v1rTp9dAnaqndORZ5PQZJGMGimLNvKwh
        Cqq542NkJuCmIrTZ51Qv/dNqVBTFUwcUiEcpL5Y=
X-Google-Smtp-Source: AA6agR57QLi6v/xhafsfnRmo52MCCxh+hujgl+DJVhXWpBVTUYMh5PIODVpRExxEX3s4DQR4scrmYy/XZaxy9d7aeYw=
X-Received: by 2002:a05:6870:7092:b0:11e:ff3a:d984 with SMTP id
 v18-20020a056870709200b0011eff3ad984mr13118224oae.19.1662534374178; Wed, 07
 Sep 2022 00:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220906035423.634617-1-guoren@kernel.org> <8db7caea-a1a0-25a3-ade0-2f1714d709c8@microchip.com>
 <CAJF2gTQ29bn=hgubC+YU1qSw_L3W2kAt3Yi4_EknrNCkR-dRFg@mail.gmail.com>
 <CAJF2gTRU6xWv5z7FvYkupCfmc0_EEceeowpjemoUWSAz8OgfWg@mail.gmail.com> <fb17255a-62ea-54c0-96a0-c19072c25ad5@microchip.com>
In-Reply-To: <fb17255a-62ea-54c0-96a0-c19072c25ad5@microchip.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 7 Sep 2022 15:06:01 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS0Oe7AHcNf1+uGHX=S0bZoKHX2nS-+O72tjjrjq4wScA@mail.gmail.com>
Message-ID: <CAJF2gTS0Oe7AHcNf1+uGHX=S0bZoKHX2nS-+O72tjjrjq4wScA@mail.gmail.com>
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

On Wed, Sep 7, 2022 at 2:23 PM <Conor.Dooley@microchip.com> wrote:
>
> On 07/09/2022 03:52, Guo Ren wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >
> > Hi Conor,
> >
> > I've found the root cause, you are using llvm:
>
> Yup, probably should have specified - sorry. I didn't realise that
It's my typo bug. You reminded me of using clang.

> that was something GCC wouldn't complain about. It was an LLVM=3D1
> build with clang-15.
>
> I usually do builds with clang while testing patches as it seems
> to be lesser used.
>
> Thanks,
> Conor.
>
> >
> > $ grep "bare sym" llvm -rn |grep RISCV
> > llvm/lib/Target/RISCV/AsmParser/RISCVAsmParser.cpp:1296: return
> > Error(ErrorLoc, "operand must be a bare symbol name");
> > llvm/lib/Target/RISCV/AsmParser/RISCVAsmParser.cpp:1304: return
> > Error(ErrorLoc, "operand must be a bare symbol name");
> >
> > That means we could fix up Binutils with a warning at least.
> >
> > Thx for pointing it out.
> >
> > On Wed, Sep 7, 2022 at 8:54 AM Guo Ren <guoren@kernel.org> wrote:
> >>
> >> On Wed, Sep 7, 2022 at 1:42 AM <Conor.Dooley@microchip.com> wrote:
> >>>
> >>> On 06/09/2022 04:54, guoren@kernel.org wrote:
> >>>> From: Guo Ren <guoren@linux.alibaba.com>
> >>>>
> >>>> The patches convert riscv to use the generic entry infrastructure fr=
om
> >>>> kernel/entry/*. Add independent irq stacks (IRQ_STACKS) for percpu t=
o
> >>>> prevent kernel stack overflows. Add the HAVE_SOFTIRQ_ON_OWN_STACK
> >>>> feature for the IRQ_STACKS config. You can try it directly with [1].
> >>>
> >>> Hey Guo Ren,
> >>> I applied this patchset to v6.0-rc4 & ran into a build error:
> >>> /stuff/linux/arch/riscv/kernel/entry.S:347:9: error: operand must be =
a bare symbol name
> >>>   la a3, ((1 << (12)) << (2 + 0))
> >> Yes, please try:
> >> -       la      a3, IRQ_STACK_SIZE
> >> +       li      a3, IRQ_STACK_SIZE
> >>
> >> la is for the symbol, not immediate. But why does my toolchain not
> >> report the error?
> >>
> >> =E2=9E=9C  linux git:(generic_entry_v3) make ARCH=3Driscv
> >> CROSS_COMPILE=3Driscv64-unknown-linux-gnu- EXTRA_CFLAGS+=3D-g
> >> O=3D../build-riscv/ -kj62 all -kj
> >> =E2=9E=9C  linux git:(generic_entry_v3) riscv64-unknown-linux-gnu-gcc =
-v
> >> Using built-in specs.
> >> COLLECT_GCC=3Driscv64-unknown-linux-gnu-gcc
> >> COLLECT_LTO_WRAPPER=3D/opt/riscv/libexec/gcc/riscv64-unknown-linux-gnu=
/11.1.0/lto-wrapper
> >> Target: riscv64-unknown-linux-gnu
> >> Configured with:
> >> /home/guoren/source/riscv-gnu-toolchain/riscv-gcc/configure
> >> --target=3Driscv64-unknown-linux-gnu --prefix=3D/opt/riscv
> >> --with-sysroot=3D/opt/riscv/sysroot --with-pkgversion=3Dg5964b5cd7272
> >> --with-system-zlib --enable-shared --enable-tls
> >> --enable-languages=3Dc,c++,fortran --disable-libmudflap --disable-libs=
sp
> >> --disable-libquadmath --disable-libsanitizer --disable-nls
> >> --disable-bootstrap --src=3D.././riscv-gcc --enable-multilib
> >> --with-abi=3Dlp64d --with-arch=3Drv64imafdc --with-tune=3Drocket
> >> --with-isa-spec=3D2.2 'CFLAGS_FOR_TARGET=3D-O2   -mcmodel=3Dmedlow'
> >> 'CXXFLAGS_FOR_TARGET=3D-O2   -mcmodel=3Dmedlow'
> >> Thread model: posix
> >> Supported LTO compression algorithms: zlib
> >> gcc version 11.1.0 (g5964b5cd7272)
> >>
> >>
> >>
> >>>          ^
> >>>    CC      arch/riscv/kernel/process.o
> >>> make[5]: *** [/stuff/linux/scripts/Makefile.build:322: arch/riscv/ker=
nel/entry.o] Error 1
> >>> make[5]: *** Waiting for unfinished jobs....
> >>>
> >>> Thanks,
> >>> Conor.
> >>>>
> >>>> [1] https://github.com/guoren83/linux/tree/generic_entry_v3
> >>>>
> >>>> V3:
> >>>>   - Fixup CONFIG_COMPAT=3Dn compile error
> >>>>   - Add THREAD_SIZE_ORDER config
> >>>>   - Optimize elf_kexec.c warning fixup
> >>>>   - Add static to irq_stack_ptr definition
> >>>>
> >>>> V2:
> >>>>   Link: https://lore.kernel.org/linux-riscv/20220904072637.8619-1-gu=
oren@kernel.org/
> >>>>   - Fixup compile error by include "riscv: ptrace: Remove duplicate
> >>>>     operation"
> >>>>   - Fixup compile warning
> >>>>     Reported-by: kernel test robot <lkp@intel.com>
> >>>>   - Add test repo link in cover letter
> >>>>
> >>>> V1:
> >>>>   Link: https://lore.kernel.org/linux-riscv/20220903163808.1954131-1=
-guoren@kernel.org/
> >>>>
> >>>> Guo Ren (7):
> >>>>    riscv: elf_kexec: Fixup compile warning
> >>>>    riscv: compat_syscall_table: Fixup compile warning
> >>>>    riscv: ptrace: Remove duplicate operation
> >>>>    riscv: convert to generic entry
> >>>>    riscv: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
> >>>>    riscv: Support HAVE_SOFTIRQ_ON_OWN_STACK
> >>>>    riscv: Add config of thread stack size
> >>>>
> >>>>   arch/riscv/Kconfig                    |  19 ++
> >>>>   arch/riscv/include/asm/csr.h          |   1 -
> >>>>   arch/riscv/include/asm/entry-common.h |   8 +
> >>>>   arch/riscv/include/asm/irq.h          |   3 +
> >>>>   arch/riscv/include/asm/ptrace.h       |  10 +-
> >>>>   arch/riscv/include/asm/stacktrace.h   |   5 +
> >>>>   arch/riscv/include/asm/syscall.h      |   6 +
> >>>>   arch/riscv/include/asm/thread_info.h  |  19 +-
> >>>>   arch/riscv/include/asm/vmap_stack.h   |  28 +++
> >>>>   arch/riscv/kernel/Makefile            |   1 +
> >>>>   arch/riscv/kernel/elf_kexec.c         |   2 +-
> >>>>   arch/riscv/kernel/entry.S             | 255 +++++-----------------=
----
> >>>>   arch/riscv/kernel/irq.c               |  75 ++++++++
> >>>>   arch/riscv/kernel/ptrace.c            |  41 -----
> >>>>   arch/riscv/kernel/signal.c            |  21 +--
> >>>>   arch/riscv/kernel/sys_riscv.c         |  27 +++
> >>>>   arch/riscv/kernel/traps.c             |  11 ++
> >>>>   arch/riscv/mm/fault.c                 |  12 +-
> >>>>   18 files changed, 259 insertions(+), 285 deletions(-)
> >>>>   create mode 100644 arch/riscv/include/asm/entry-common.h
> >>>>   create mode 100644 arch/riscv/include/asm/vmap_stack.h
> >>>>
> >>
> >>
> >>
> >> --
> >> Best Regards
> >>   Guo Ren
> >
> >
> >
> > --
> > Best Regards
> >   Guo Ren
>


--=20
Best Regards
 Guo Ren
