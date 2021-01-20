Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86D72FCAE6
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 07:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbhATF7d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jan 2021 00:59:33 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:25119 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbhATF72 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jan 2021 00:59:28 -0500
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 10K5wQ4S006914;
        Wed, 20 Jan 2021 14:58:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 10K5wQ4S006914
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1611122306;
        bh=KzN9Ryj1GGQwDPkR8jROwhO9v+XE5tP9xjOAU8GcS3k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ulTaCuOn3vyEdn8KBGk2hvq70GLGLoXtnNsxxxvyqmAvlu5CNXtWUYfTNALZFfhye
         eIsnTRMDLEAJWKdBjCAOwKrHNJDixKF/PKTpgqYNS5xJnnSoDAqaB7iD9+inMbeCdN
         b6TH+2+QP5SoDju+EvQAMIrF0V4B0S6x9VwR4590wt8sZx+O/ilrvu9tXNGST1u+7U
         i73M37VLmsOFgI5Oea7Kl57hfjCVaAkA7i9B3Sw3vvZsNvPVLvmDPB2jZfDm3B2HR6
         uAmDqleWyWP9+0xTtN2KAyQ2vr/EpMKvUSVxI1Dw2y6zRXM4oB3ZHSSi/OQSrVz3NW
         hny0IRyLI+4sg==
X-Nifty-SrcIP: [209.85.214.169]
Received: by mail-pl1-f169.google.com with SMTP id y8so11923548plp.8;
        Tue, 19 Jan 2021 21:58:26 -0800 (PST)
X-Gm-Message-State: AOAM533ElGezaX44EjPfAqW0jQdiWgxv5MPqNKKWAnc2A4EEWqnOMjv4
        wxwHM24Ao9hk+nQXqbTQcPVrC8I8ZsDy7DbtzQs=
X-Google-Smtp-Source: ABdhPJy1nJc2rsdYYrJ/8DDEr5wBNawlXcexc+8QcUbO6t9Bql1qctYGmnWNQ1z4azFlQe4RrWaXegHEImZuO0KlNlw=
X-Received: by 2002:a17:90b:1b50:: with SMTP id nv16mr3678277pjb.153.1611122305635;
 Tue, 19 Jan 2021 21:58:25 -0800 (PST)
MIME-Version: 1.0
References: <20210115210616.404156-1-ndesaulniers@google.com>
 <20210115210616.404156-2-ndesaulniers@google.com> <CA+icZUVtodEz=E+TG0Pt_OUDgW5-0x2WzVOhzQDbyuVR1igU6Q@mail.gmail.com>
 <CAKwvOd==3r8HNe8P5SuoumRtQ3w7iZkGhhVNhAEyh=rSFDNtKw@mail.gmail.com> <CAK7LNATAAZ_LH_q8x9A7FwBy=kqMd8Z0rVm-wuC1QqxpgsnBQg@mail.gmail.com>
In-Reply-To: <CAK7LNATAAZ_LH_q8x9A7FwBy=kqMd8Z0rVm-wuC1QqxpgsnBQg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 20 Jan 2021 14:57:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQW70HzjQqbwHui7PiNBbEtHEpgv+v7xDEgpFArNaFTng@mail.gmail.com>
Message-ID: <CAK7LNAQW70HzjQqbwHui7PiNBbEtHEpgv+v7xDEgpFArNaFTng@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] Remove $(cc-option,-gdwarf-4) dependency from CONFIG_DEBUG_INFO_DWARF4
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 16, 2021 at 8:54 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Sat, Jan 16, 2021 at 6:51 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Fri, Jan 15, 2021 at 1:48 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > On Fri, Jan 15, 2021 at 10:06 PM Nick Desaulniers
> > > <ndesaulniers@google.com> wrote:
> > > >
> > > > From: Masahiro Yamada <masahiroy@kernel.org>
> > > >
> > > > The -gdwarf-4 flag is supported by GCC 4.5+, and also by Clang.
> > > >
> > > > You can see it at https://godbolt.org/z/6ed1oW
> > > >
> > > >   For gcc 4.5.3 pane,    line 37:    .value 0x4
> > > >   For clang 10.0.1 pane, line 117:   .short 4
> > > >
> > > > Given Documentation/process/changes.rst stating GCC 4.9 is the minimal
> > > > version, this cc-option is unneeded.
> > > >
> > > > Note
> > > > ----
> > > >
> > > > CONFIG_DEBUG_INFO_DWARF4 controls the DWARF version only for C files.
> > > >
> > > > As you can see in the top Makefile, -gdwarf-4 is only passed to CFLAGS.
> > > >
> > > >   ifdef CONFIG_DEBUG_INFO_DWARF4
> > > >   DEBUG_CFLAGS    += -gdwarf-4
> > > >   endif
> > > >
> > > > This flag is used when compiling *.c files.
> > > >
> > > > On the other hand, the assembler is always given -gdwarf-2.
> > > >
> > > >   KBUILD_AFLAGS   += -Wa,-gdwarf-2
> > > >
> > > > Hence, the debug info that comes from *.S files is always DWARF v2.
> > > > This is simply because GAS supported only -gdwarf-2 for a long time.
> > > >
> > > > Recently, GAS gained the support for --dwarf-[3|4|5] options. [1]
> > > > And, also we have Clang integrated assembler. So, the debug info
> > > > for *.S files might be improved if we want.
> > > >
> > > > In my understanding, the current code is intentional, not a bug.
> > > >
> > > > [1] https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=31bf18645d98b4d3d7357353be840e320649a67d
> > > >
> > > > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > >
> > > Subject misses a "kbuild:" label like in all other patches.
> > > You have:
> > > "Remove $(cc-option,-gdwarf-4) dependency from CONFIG_DEBUG_INFO_DWARF4"
> >
> > Ack, I wonder how that happened? Ah well, will fix in v6; thanks for
> > the feedback.
>
>
>
> I will apply this in my tree,
> adding "kbuild:" and fixing the typo pointed out by Fangrui.
>
> You do not need to resend this one.
>



Applied to linux-kbuild.


>
>
>
>
>
>
> > >
> > > - Sedat -
> > >
> > > > ---
> > > >  lib/Kconfig.debug | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > >
> > > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > > index 78361f0abe3a..dd7d8d35b2a5 100644
> > > > --- a/lib/Kconfig.debug
> > > > +++ b/lib/Kconfig.debug
> > > > @@ -258,7 +258,6 @@ config DEBUG_INFO_SPLIT
> > > >
> > > >  config DEBUG_INFO_DWARF4
> > > >         bool "Generate dwarf4 debuginfo"
> > > > -       depends on $(cc-option,-gdwarf-4)
> > > >         help
> > > >           Generate dwarf4 debug info. This requires recent versions
> > > >           of gcc and gdb. It makes the debug information larger.
> > > > --
> > > > 2.30.0.284.gd98b1dd5eaa7-goog
> > > >
> >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
>
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
