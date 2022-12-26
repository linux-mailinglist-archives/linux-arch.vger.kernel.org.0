Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D82C6564BE
	for <lists+linux-arch@lfdr.de>; Mon, 26 Dec 2022 20:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiLZTHk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Dec 2022 14:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLZTHj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Dec 2022 14:07:39 -0500
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA4C3B6;
        Mon, 26 Dec 2022 11:07:37 -0800 (PST)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 2BQJ7CUZ012207;
        Tue, 27 Dec 2022 04:07:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 2BQJ7CUZ012207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1672081633;
        bh=BGEpCmLTIZ8IdDvA0l97jvp8CWcFnqNFjDavlxwENHI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E+Jw1F9YF0w+T0Ut7LmyMIAwv3vqX4Gn39iYGEHAUctCwDukHM4SJA+61CQ5gOnQm
         gyEnt7VfRGDIfSZpk78PDeIqcIdYLWVzAa2NY7tDPCtrRE54BmzeCsITTZLUO2gOAR
         f1pwjdx6+4p6NnuWespI2H/PPxbtP4tUgYSQm1IdYOh4OvoScm+O8ZHGXy0vGXH4d5
         z797DrnaSoYNdpqLsNQpQQUXEycfRhmf96pKzxQ7G+IK7ihV12w+GvLDRkkU292EqJ
         pOnb0Zk7WuSK/gG6kKpjgRiQ7n74Ye9afcxV51t1AqJfmSY2cgBGVNwLUQg8YJw2K/
         eeTVOKPk6m3ww==
X-Nifty-SrcIP: [209.85.160.46]
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1322d768ba7so13330294fac.5;
        Mon, 26 Dec 2022 11:07:13 -0800 (PST)
X-Gm-Message-State: AFqh2krdOt1CbsqFC4JrJXeLMxjYucoa+wWw20zWXGXhZXu0lqo8UDfL
        Gsn3kELPHHNmGmj9/8vYRD22tYr7xYdO/4ILL1g=
X-Google-Smtp-Source: AMrXdXtb+G74UBoe1J+E92V/UHJUv95HCjRCrShIRjn2U2NRwyvDEFfn2QswXyN20yq39frWLv5acIsP+FH7XSO6RLc=
X-Received: by 2002:a05:6871:4193:b0:144:d060:72e with SMTP id
 lc19-20020a056871419300b00144d060072emr1260608oab.287.1672081632141; Mon, 26
 Dec 2022 11:07:12 -0800 (PST)
MIME-Version: 1.0
References: <20221224192751.810363-1-masahiroy@kernel.org> <Y6hptEk8FmISixLS@spud>
In-Reply-To: <Y6hptEk8FmISixLS@spud>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 27 Dec 2022 04:06:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT39aZEw=0209ovYZ2kxtOaA2a51=XD9=LqYHjkTOEK4g@mail.gmail.com>
Message-ID: <CAK7LNAT39aZEw=0209ovYZ2kxtOaA2a51=XD9=LqYHjkTOEK4g@mail.gmail.com>
Subject: Re: [PATCH] arch: fix broken BuildID for arm64 and riscv
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Dennis Gilmore <dennis@ausil.us>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 26, 2022 at 12:18 AM Conor Dooley <conor@kernel.org> wrote:
>
> On Sun, Dec 25, 2022 at 04:27:51AM +0900, Masahiro Yamada wrote:
> > Dennis Gilmore reports that the BuildID is missing in the arm64 vmlinux
> > since commit 994b7ac1697b ("arm64: remove special treatment for the
> > link order of head.o").
> >
> > The issue is that the type of .notes section, which contains the BuildID,
> > changed from NOTES to PROGBITS.
> >
> > Ard Biesheuvel figured out that whichever object gets linked first gets
> > to decide the type of a section, and the PROGBITS type is the result of
> > the compiler emitting .note.GNU-stack as PROGBITS rather than NOTE.
> >
> > While Ard provided a fix for arm64, I want to fix this globally because
> > the same issue is happening on riscv since commit 2348e6bf4421 ("riscv:
> > remove special treatment for the link order of head.o"). This problem
> > will happen in general for other architectures if they start to drop
> > unneeded entries from scripts/head-object-list.txt.
> >
> > Discard .note.GNU-stack in include/asm-generic/vmlinux.lds.h.
> >
> > riscv needs to change its linker script so that DISCARDS comes before
> > the .notes section.
>
> Hey Mashiro,
>
> No idea why I decided to look at patchwork today, but this seems to
> break the build on RISC-V, there's a whole load of the following in the
> output:
> `.LPFE4' referenced in section `__patchable_function_entries' of kernel/trace/trace_selftest_dynamic.o: defined in discarded section `.text.exit' of kernel/trace/trace_selftest_dynamic.o
>
> I assume that's what's doing it, but given the day that's in it - I
> haven't looked into this any further, nor gone and fished the logs out of
> the builder.


arch/riscv/kernel/vmlinux.lds.S clearly says:
/* we have to discard exit text and such at runtime, not link time */

riscv already relies on the linker not discarding EXIT_{TEXT,DATA}
so riscv should define RUNTIME_DISCARD_EXIT like x86, arm64.


Anyway, I came up with a simpler patch, so I do not need to
touch around arch linker scripts.


I sent v2.
https://lore.kernel.org/lkml/20221226184537.744960-1-masahiroy@kernel.org/T/#u



Thanks for the report.




>
> Thanks,
> Conor.
>
> >
> > Link: https://lore.kernel.org/lkml/CAABkxwuQoz1CTbyb57n0ZX65eSYiTonFCU8-LCQc=74D=xE=rA@mail.gmail.com/
> > Fixes: 994b7ac1697b ("arm64: remove special treatment for the link order of head.o")
> > Fixes: 2348e6bf4421 ("riscv: remove special treatment for the link order of head.o")
> > Reported-by: Dennis Gilmore <dennis@ausil.us>
> > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  arch/riscv/kernel/vmlinux.lds.S   | 4 ++--
> >  include/asm-generic/vmlinux.lds.h | 1 +
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> > index 4e6c88aa4d87..1865a258e560 100644
> > --- a/arch/riscv/kernel/vmlinux.lds.S
> > +++ b/arch/riscv/kernel/vmlinux.lds.S
> > @@ -31,6 +31,8 @@ PECOFF_FILE_ALIGNMENT = 0x200;
> >
> >  SECTIONS
> >  {
> > +     DISCARDS
> > +
> >       /* Beginning of code and text segment */
> >       . = LOAD_OFFSET;
> >       _start = .;
> > @@ -141,7 +143,5 @@ SECTIONS
> >       STABS_DEBUG
> >       DWARF_DEBUG
> >       ELF_DETAILS
> > -
> > -     DISCARDS
> >  }
> >  #endif /* CONFIG_XIP_KERNEL */
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index a94219e9916f..2993b790fe98 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -1007,6 +1007,7 @@
> >       *(.modinfo)                                                     \
> >       /* ld.bfd warns about .gnu.version* even when not emitted */    \
> >       *(.gnu.version*)                                                \
> > +     *(.note.GNU-stack)      /* emitted as PROGBITS */
> >
> >  #define DISCARDS                                                     \
> >       /DISCARD/ : {                                                   \
> > --
> > 2.34.1
> >



-- 
Best Regards
Masahiro Yamada
