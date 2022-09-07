Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8AD5AF931
	for <lists+linux-arch@lfdr.de>; Wed,  7 Sep 2022 02:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiIGAyq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Sep 2022 20:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIGAyp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Sep 2022 20:54:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A561AF3B;
        Tue,  6 Sep 2022 17:54:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD8F46173D;
        Wed,  7 Sep 2022 00:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4594EC43140;
        Wed,  7 Sep 2022 00:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662512083;
        bh=SC+Hs3+8sgeFMw3h38n6zDv3JRNaTxvHlzp08pJv7mw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AfZvJftkz58+dYoPlKIQOYui2EE3NLEiNMsVUyVOPDcFLx1A1GJJELEc0j/IcxGlN
         KKEeN6x3epysvSiXwdvBb1aKlQ6TuCvUXkZvc2sLdzJxgZW2wOMk/63fFsj1f0UfL2
         14zHXHsyG7FDi6P/Zbgjm89CJSyLF/siXjw5MakqzgzYJGXithg7iZDldK8UtkmyT6
         hTTgfB8BFJXycJByF4ZoT2sJX6Wco3Oz1b5YMUCi/XhLfWwjfB5OBeJnRYfAg70J8U
         S4IqUF9JusZAWX8+12jwOc81IBLinPiqv8W6EyFe48OOjJiOGzKQg/u2O/0dyG3my5
         R3fVakzz8MHZw==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-127ba06d03fso8835724fac.3;
        Tue, 06 Sep 2022 17:54:43 -0700 (PDT)
X-Gm-Message-State: ACgBeo05Z4r5NT+iK8wg8APvgjqI/KSCRq4XXL8gL+UlNpPo3pTCmm+n
        9ouSsdls9BwfBDie8kllZRPoo9S7eMjrpw3bIUQ=
X-Google-Smtp-Source: AA6agR4GBRHPDj2s0R+HEZdjbGd7h5e0le/7MDXnl/o9xnctQ79UtwCwp+ud8cbAQ+FdUTgmKxCCYwPP5FsrSQfTMmk=
X-Received: by 2002:a05:6870:c596:b0:101:6409:ae62 with SMTP id
 ba22-20020a056870c59600b001016409ae62mr12942331oab.112.1662512082262; Tue, 06
 Sep 2022 17:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220906035423.634617-1-guoren@kernel.org> <8db7caea-a1a0-25a3-ade0-2f1714d709c8@microchip.com>
In-Reply-To: <8db7caea-a1a0-25a3-ade0-2f1714d709c8@microchip.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 7 Sep 2022 08:54:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ29bn=hgubC+YU1qSw_L3W2kAt3Yi4_EknrNCkR-dRFg@mail.gmail.com>
Message-ID: <CAJF2gTQ29bn=hgubC+YU1qSw_L3W2kAt3Yi4_EknrNCkR-dRFg@mail.gmail.com>
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

On Wed, Sep 7, 2022 at 1:42 AM <Conor.Dooley@microchip.com> wrote:
>
> On 06/09/2022 04:54, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The patches convert riscv to use the generic entry infrastructure from
> > kernel/entry/*. Add independent irq stacks (IRQ_STACKS) for percpu to
> > prevent kernel stack overflows. Add the HAVE_SOFTIRQ_ON_OWN_STACK
> > feature for the IRQ_STACKS config. You can try it directly with [1].
>
> Hey Guo Ren,
> I applied this patchset to v6.0-rc4 & ran into a build error:
> /stuff/linux/arch/riscv/kernel/entry.S:347:9: error: operand must be a ba=
re symbol name
>  la a3, ((1 << (12)) << (2 + 0))
Yes, please try:
-       la      a3, IRQ_STACK_SIZE
+       li      a3, IRQ_STACK_SIZE

la is for the symbol, not immediate. But why does my toolchain not
report the error?

=E2=9E=9C  linux git:(generic_entry_v3) make ARCH=3Driscv
CROSS_COMPILE=3Driscv64-unknown-linux-gnu- EXTRA_CFLAGS+=3D-g
O=3D../build-riscv/ -kj62 all -kj
=E2=9E=9C  linux git:(generic_entry_v3) riscv64-unknown-linux-gnu-gcc -v
Using built-in specs.
COLLECT_GCC=3Driscv64-unknown-linux-gnu-gcc
COLLECT_LTO_WRAPPER=3D/opt/riscv/libexec/gcc/riscv64-unknown-linux-gnu/11.1=
.0/lto-wrapper
Target: riscv64-unknown-linux-gnu
Configured with:
/home/guoren/source/riscv-gnu-toolchain/riscv-gcc/configure
--target=3Driscv64-unknown-linux-gnu --prefix=3D/opt/riscv
--with-sysroot=3D/opt/riscv/sysroot --with-pkgversion=3Dg5964b5cd7272
--with-system-zlib --enable-shared --enable-tls
--enable-languages=3Dc,c++,fortran --disable-libmudflap --disable-libssp
--disable-libquadmath --disable-libsanitizer --disable-nls
--disable-bootstrap --src=3D.././riscv-gcc --enable-multilib
--with-abi=3Dlp64d --with-arch=3Drv64imafdc --with-tune=3Drocket
--with-isa-spec=3D2.2 'CFLAGS_FOR_TARGET=3D-O2   -mcmodel=3Dmedlow'
'CXXFLAGS_FOR_TARGET=3D-O2   -mcmodel=3Dmedlow'
Thread model: posix
Supported LTO compression algorithms: zlib
gcc version 11.1.0 (g5964b5cd7272)



>         ^
>   CC      arch/riscv/kernel/process.o
> make[5]: *** [/stuff/linux/scripts/Makefile.build:322: arch/riscv/kernel/=
entry.o] Error 1
> make[5]: *** Waiting for unfinished jobs....
>
> Thanks,
> Conor.
> >
> > [1] https://github.com/guoren83/linux/tree/generic_entry_v3
> >
> > V3:
> >  - Fixup CONFIG_COMPAT=3Dn compile error
> >  - Add THREAD_SIZE_ORDER config
> >  - Optimize elf_kexec.c warning fixup
> >  - Add static to irq_stack_ptr definition
> >
> > V2:
> >  Link: https://lore.kernel.org/linux-riscv/20220904072637.8619-1-guoren=
@kernel.org/
> >  - Fixup compile error by include "riscv: ptrace: Remove duplicate
> >    operation"
> >  - Fixup compile warning
> >    Reported-by: kernel test robot <lkp@intel.com>
> >  - Add test repo link in cover letter
> >
> > V1:
> >  Link: https://lore.kernel.org/linux-riscv/20220903163808.1954131-1-guo=
ren@kernel.org/
> >
> > Guo Ren (7):
> >   riscv: elf_kexec: Fixup compile warning
> >   riscv: compat_syscall_table: Fixup compile warning
> >   riscv: ptrace: Remove duplicate operation
> >   riscv: convert to generic entry
> >   riscv: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
> >   riscv: Support HAVE_SOFTIRQ_ON_OWN_STACK
> >   riscv: Add config of thread stack size
> >
> >  arch/riscv/Kconfig                    |  19 ++
> >  arch/riscv/include/asm/csr.h          |   1 -
> >  arch/riscv/include/asm/entry-common.h |   8 +
> >  arch/riscv/include/asm/irq.h          |   3 +
> >  arch/riscv/include/asm/ptrace.h       |  10 +-
> >  arch/riscv/include/asm/stacktrace.h   |   5 +
> >  arch/riscv/include/asm/syscall.h      |   6 +
> >  arch/riscv/include/asm/thread_info.h  |  19 +-
> >  arch/riscv/include/asm/vmap_stack.h   |  28 +++
> >  arch/riscv/kernel/Makefile            |   1 +
> >  arch/riscv/kernel/elf_kexec.c         |   2 +-
> >  arch/riscv/kernel/entry.S             | 255 +++++---------------------
> >  arch/riscv/kernel/irq.c               |  75 ++++++++
> >  arch/riscv/kernel/ptrace.c            |  41 -----
> >  arch/riscv/kernel/signal.c            |  21 +--
> >  arch/riscv/kernel/sys_riscv.c         |  27 +++
> >  arch/riscv/kernel/traps.c             |  11 ++
> >  arch/riscv/mm/fault.c                 |  12 +-
> >  18 files changed, 259 insertions(+), 285 deletions(-)
> >  create mode 100644 arch/riscv/include/asm/entry-common.h
> >  create mode 100644 arch/riscv/include/asm/vmap_stack.h
> >



--=20
Best Regards
 Guo Ren
