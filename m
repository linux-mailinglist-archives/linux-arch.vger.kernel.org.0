Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE6930EC52
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 07:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhBDGJE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 01:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbhBDGI6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 01:08:58 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80DDC061786
        for <linux-arch@vger.kernel.org>; Wed,  3 Feb 2021 22:08:18 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id 8so1177362plc.10
        for <linux-arch@vger.kernel.org>; Wed, 03 Feb 2021 22:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EFWVBuY0De+XPIimdUvHgr/6vnHHJFFofML5VvndojY=;
        b=NY6v3PaHV/Ef3WPhgaQfSpXZienkPA++dpFxCVWUrn7B4Cdo9/P3gTpD5E56cZj6BC
         dRs67THC7c64548c3Zp/rIvG2jMFC5eSuxuhlR8/DZXnS4XF1Kwy1y6KJm4OFdLbkI4/
         bsJ3bfRAJB9MSM748AM4SS/gpbRPZzFQzhCi1ae2LnuAUMd6JhsGhFWEWSf7FTnJSLLv
         pqD2mLzWDu6TC13OETXNbNcXaVr52pyxjm7s1ls7JelGUx/Bm6gluGLnPvUGS/hnSdMO
         UnqqKkk3vuKCPg/7FqWcILjz+oQVUmYi0MCl9L/ohesfaBt2/vFx573ZrrKjtXtaGP/E
         QnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EFWVBuY0De+XPIimdUvHgr/6vnHHJFFofML5VvndojY=;
        b=YdHuDVOqdZo1zqBs3T8sVTVdsEIrTeHp5SR0I2kuNAsLfztMd3FZddxrhAnpBUxQB/
         NIGV8HUNBs9Uc+1vXIXINpLKexhRvcdYTkAioIF230SuHWf9oRaRfn95D9iBkqI0ZxR7
         TFg17HxGgthwasjjBPzoUmtx04cPp0iYwfzEHsMNhkmL3gdjXwLblzoroPZcnKiqqwrG
         ScDmR6BGffV9ICxbJWvuEh+J0LdR3sYWjK23+7nk/1Iq8GJTD6NnoRtA3Clv8pdomafK
         DwMeOZ+gUkVdVX2k2QSPDwaslPTXzuBIsma94mZs72bUowaV+n78oSlyc2Owi4KUuxNA
         qIEw==
X-Gm-Message-State: AOAM531ZpQfrWyh1HKz8KhHYJ/e2qiSBqUYe3+NpSdiV749pm7JK8vqp
        uEoSiu0+FfWG0TpktAQmmCC8LX2z/Js1sjAbLrtU5THqneg6Zg==
X-Google-Smtp-Source: ABdhPJyU9wGbyKTuPkLDyoLh3JPW4Wc5uYRi8E2TIcRWVJVrcWtjNv2GVJGRjLEtVvA1dPOGigDhbu6WC3Jr1/Vp8l4=
X-Received: by 2002:a17:902:ed94:b029:de:8844:a650 with SMTP id
 e20-20020a170902ed94b02900de8844a650mr6790066plj.56.1612418897835; Wed, 03
 Feb 2021 22:08:17 -0800 (PST)
MIME-Version: 1.0
References: <20210130004401.2528717-1-ndesaulniers@google.com>
 <20210130004401.2528717-2-ndesaulniers@google.com> <20210130015222.GC2709570@localhost>
 <CAK7LNARfu-wqW9hfnoeeahiNPbwt4xhoWdxXtK8qjVfEi=7OOg@mail.gmail.com> <20210204033210.ie2a5zuumtlb4jth@google.com>
In-Reply-To: <20210204033210.ie2a5zuumtlb4jth@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 3 Feb 2021 22:08:05 -0800
Message-ID: <CAKwvOdmCt0ueauZ98VwgY7bx_bY8KOwXz6q-aexVQ6JCPaW7GA@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] Kbuild: make DWARF version a choice
To:     Fangrui Song <maskray@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
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

On Wed, Feb 3, 2021 at 7:32 PM Fangrui Song <maskray@google.com> wrote:
>
> On 2021-02-04, Masahiro Yamada wrote:
> >On Sat, Jan 30, 2021 at 10:52 AM Nathan Chancellor <nathan@kernel.org> w=
rote:
> >>
> >> On Fri, Jan 29, 2021 at 04:44:00PM -0800, Nick Desaulniers wrote:
> >> > Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice which i=
s
> >> > the default. Does so in a way that's forward compatible with existin=
g
> >> > configs, and makes adding future versions more straightforward.
> >> >
> >> > GCC since ~4.8 has defaulted to this DWARF version implicitly.
> >> >
> >> > Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
> >> > Suggested-by: Fangrui Song <maskray@google.com>
> >> > Suggested-by: Nathan Chancellor <nathan@kernel.org>
> >> > Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> >> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >>
> >> One comment below:
> >>
> >> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> >>
> >> > ---
> >> >  Makefile          |  5 ++---
> >> >  lib/Kconfig.debug | 16 +++++++++++-----
> >> >  2 files changed, 13 insertions(+), 8 deletions(-)
> >> >
> >> > diff --git a/Makefile b/Makefile
> >> > index 95ab9856f357..d2b4980807e0 100644
> >> > --- a/Makefile
> >> > +++ b/Makefile
> >> > @@ -830,9 +830,8 @@ ifneq ($(LLVM_IAS),1)
> >> >  KBUILD_AFLAGS        +=3D -Wa,-gdwarf-2
> >>
> >> It is probably worth a comment somewhere that assembly files will stil=
l
> >> have DWARF v2.
> >
> >I agree.
> >Please noting the reason will be helpful.
> >
> >Could you summarize Jakub's comment in short?
> >https://patchwork.kernel.org/project/linux-kbuild/patch/20201022012106.1=
875129-1-ndesaulniers@google.com/#23727667
> >
> >
> >
> >
> >
> >
> >One more question.
> >
> >
> >Can we remove -g option like follows?
> >
> >
> > ifdef CONFIG_DEBUG_INFO_SPLIT
> > DEBUG_CFLAGS   +=3D -gsplit-dwarf
> >-else
> >-DEBUG_CFLAGS   +=3D -g
> > endif
>
> GCC 11/Clang 12 -gsplit-dwarf no longer imply -g2
> (https://reviews.llvm.org/D80391). May be worth checking whether
> -gsplit-dwarf is used without a debug info enabling option.

Indeed, I also remember -g was required for
-fno-eliminate-unused-debug-types, used by libabigail.
https://reviews.llvm.org/D80242
Masahiro, respectfully, I will not touch removing -g in this series.
I suspect it will be its own can of worms.

>
> >
> >
> >
> >
> >In the current mainline code,
> >-g is the only debug option
> >if CONFIG_DEBUG_INFO_DWARF4 is disabled.
> >
> >
> >The GCC manual says:
> >https://gcc.gnu.org/onlinedocs/gcc-10.2.0/gcc/Debugging-Options.html#Deb=
ugging-Options
> >
> >
> >-g
> >
> >    Produce debugging information in the operating system=E2=80=99s
> >    native format (stabs, COFF, XCOFF, or DWARF).
> >    GDB can work with this debugging information.
> >
> >
> >Of course, we expect the -g option will produce
> >the debug info in the DWARF format.
> >
> >
> >
> >
> >
> >With this patch set applied, it is very explicit.
> >
> >Only the format type, but also the version.
> >
> >The compiler will be given either
> >-gdwarf-4 or -gdwarf-5,
> >making the -g option redundant, I think.
>
> -gdwarf-N does imply -g2 but personally I'd not suggest remove it if it
> already exists. The non-orthogonality is the reason Clang has
> -fdebug-default-version (https://reviews.llvm.org/D69822).

--=20
Thanks,
~Nick Desaulniers
