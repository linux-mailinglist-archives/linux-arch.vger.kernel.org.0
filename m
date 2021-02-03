Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3851630E601
	for <lists+linux-arch@lfdr.de>; Wed,  3 Feb 2021 23:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhBCWZa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 17:25:30 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:54585 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbhBCWZ2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2021 17:25:28 -0500
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 113MOWdn014773;
        Thu, 4 Feb 2021 07:24:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 113MOWdn014773
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1612391072;
        bh=7StsCQYSqe5ypDFwjKpWmsgvnkeOuX5ZUBEjM+qdas0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ew1HoxSTI+m24Y3qqgcEHhVOpcw0za5aRF0vp4OnOxfCbVk+5Fqk/uZYzqLB58tVU
         ZcNW8NrdAufXavlq7jslAIJTFRVPPJiF9hTBrQfIRTAPN6vndIy3ddVXOF8eE3mBDc
         aIR+ozo1Mth6LkMZjXwNDsZhicJjTyoULl5+PqUqr/BYByPe7aktP8lPAcyg+4WtN8
         kauN27E9T+9WtNdfM6zc0reDuKVwrppqykzhAzraUSUbPFwTU02zYK0dlj/+/pRrrF
         Iz3adJnajbZG+wThTonddss+YE6o42j/Kb0RYqTiWsotI6U80Wt6Iu8O2pEj5pPxX3
         Z1jFgCMwQ7BUQ==
X-Nifty-SrcIP: [209.85.216.42]
Received: by mail-pj1-f42.google.com with SMTP id nm1so517108pjb.3;
        Wed, 03 Feb 2021 14:24:32 -0800 (PST)
X-Gm-Message-State: AOAM532KbSCDoD5Vu8sBfR6ZNvGpKi6Hubkxu9Nuc9gFswng5VJDNULf
        +KpzuU5M84YIi0RW4u8jcEGTWUClyOxaflw5TJI=
X-Google-Smtp-Source: ABdhPJyEhNcGRvxcG329KNeD69y60w/X08l+HJyZ0iJ2piB0eBCAxbHae1jvD4uRoA4QYlkTohgLPrklS0MqfvNwIKM=
X-Received: by 2002:a17:903:248e:b029:de:b329:ffaa with SMTP id
 p14-20020a170903248eb02900deb329ffaamr5138511plw.71.1612391071565; Wed, 03
 Feb 2021 14:24:31 -0800 (PST)
MIME-Version: 1.0
References: <20210130004401.2528717-1-ndesaulniers@google.com>
 <20210130004401.2528717-2-ndesaulniers@google.com> <20210130015222.GC2709570@localhost>
In-Reply-To: <20210130015222.GC2709570@localhost>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 4 Feb 2021 07:23:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNARfu-wqW9hfnoeeahiNPbwt4xhoWdxXtK8qjVfEi=7OOg@mail.gmail.com>
Message-ID: <CAK7LNARfu-wqW9hfnoeeahiNPbwt4xhoWdxXtK8qjVfEi=7OOg@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] Kbuild: make DWARF version a choice
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 30, 2021 at 10:52 AM Nathan Chancellor <nathan@kernel.org> wrot=
e:
>
> On Fri, Jan 29, 2021 at 04:44:00PM -0800, Nick Desaulniers wrote:
> > Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice which is
> > the default. Does so in a way that's forward compatible with existing
> > configs, and makes adding future versions more straightforward.
> >
> > GCC since ~4.8 has defaulted to this DWARF version implicitly.
> >
> > Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
> > Suggested-by: Fangrui Song <maskray@google.com>
> > Suggested-by: Nathan Chancellor <nathan@kernel.org>
> > Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> One comment below:
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> > ---
> >  Makefile          |  5 ++---
> >  lib/Kconfig.debug | 16 +++++++++++-----
> >  2 files changed, 13 insertions(+), 8 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 95ab9856f357..d2b4980807e0 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -830,9 +830,8 @@ ifneq ($(LLVM_IAS),1)
> >  KBUILD_AFLAGS        +=3D -Wa,-gdwarf-2
>
> It is probably worth a comment somewhere that assembly files will still
> have DWARF v2.

I agree.
Please noting the reason will be helpful.

Could you summarize Jakub's comment in short?
https://patchwork.kernel.org/project/linux-kbuild/patch/20201022012106.1875=
129-1-ndesaulniers@google.com/#23727667






One more question.


Can we remove -g option like follows?


 ifdef CONFIG_DEBUG_INFO_SPLIT
 DEBUG_CFLAGS   +=3D -gsplit-dwarf
-else
-DEBUG_CFLAGS   +=3D -g
 endif





In the current mainline code,
-g is the only debug option
if CONFIG_DEBUG_INFO_DWARF4 is disabled.


The GCC manual says:
https://gcc.gnu.org/onlinedocs/gcc-10.2.0/gcc/Debugging-Options.html#Debugg=
ing-Options


-g

    Produce debugging information in the operating system=E2=80=99s
    native format (stabs, COFF, XCOFF, or DWARF).
    GDB can work with this debugging information.


Of course, we expect the -g option will produce
the debug info in the DWARF format.





With this patch set applied, it is very explicit.

Only the format type, but also the version.

The compiler will be given either
-gdwarf-4 or -gdwarf-5,
making the -g option redundant, I think.









>
> >  endif
> >
> > -ifdef CONFIG_DEBUG_INFO_DWARF4
> > -DEBUG_CFLAGS +=3D -gdwarf-4
> > -endif
> > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) :=3D 4
> > +DEBUG_CFLAGS +=3D -gdwarf-$(dwarf-version-y)
> >
> >  ifdef CONFIG_DEBUG_INFO_REDUCED
> >  DEBUG_CFLAGS +=3D $(call cc-option, -femit-struct-debug-baseonly) \
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index e906ea906cb7..94c1a7ed6306 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -256,13 +256,19 @@ config DEBUG_INFO_SPLIT
> >         to know about the .dwo files and include them.
> >         Incompatible with older versions of ccache.
> >
> > +choice
> > +     prompt "DWARF version"
> > +     help
> > +       Which version of DWARF debug info to emit.
> > +
> >  config DEBUG_INFO_DWARF4
> > -     bool "Generate dwarf4 debuginfo"
> > +     bool "Generate DWARF Version 4 debuginfo"
> >       help
> > -       Generate dwarf4 debug info. This requires recent versions
> > -       of gcc and gdb. It makes the debug information larger.
> > -       But it significantly improves the success of resolving
> > -       variables in gdb on optimized code.
> > +       Generate DWARF v4 debug info. This requires gcc 4.5+ and gdb 7.=
0+.
> > +       It makes the debug information larger, but it significantly
> > +       improves the success of resolving variables in gdb on optimized=
 code.
> > +
> > +endchoice # "DWARF version"
> >
> >  config DEBUG_INFO_BTF
> >       bool "Generate BTF typeinfo"
> > --
> > 2.30.0.365.g02bc693789-goog
> >



--=20
Best Regards
Masahiro Yamada
