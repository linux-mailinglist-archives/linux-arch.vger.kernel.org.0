Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F5D30E725
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 00:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbhBCXSC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 18:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbhBCXRS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2021 18:17:18 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B95BC0613ED
        for <linux-arch@vger.kernel.org>; Wed,  3 Feb 2021 15:16:38 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id r38so779664pgk.13
        for <linux-arch@vger.kernel.org>; Wed, 03 Feb 2021 15:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wll2IwjnBP1ph+olB4IOjZDnzGBUCfeA4SIYv2XGwvY=;
        b=L805BloRtBtPlJIIokA0buZ9FzfGZwJCsIbvjlgsLGB4UVShVw05gdvo8m41brHXWy
         b9SuUS8kL1Re6gQ3Et/tLjDlqUmw9hSqsUydFnf6n+SrGOzkgydTgRA1rhjC+7GmMAjN
         Hj3qhphMEI+bsWHlBwha58ateol6XcHO/EUBdlDD09GWSQEmehAPy/rZM3sNrIAJDQvl
         ugYLw4+tsXvqaEYGAlIVlzuBC+jGMHWQsd4qSqYt72VUixNO8IDG8uHjURkLFoKBZRAg
         wQ85GiAlF5/T3Mu6AC83aUt9QNqinr56PIJLskxDJj+Hoxx8wJCZt4x94ldlfT11IMUN
         D2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wll2IwjnBP1ph+olB4IOjZDnzGBUCfeA4SIYv2XGwvY=;
        b=ouh2eY2GK7JU1ob89k099n2vWIuMXE7kQ8Y9qUYtwd8NVw2+AEi7blJDVmemhg+RzD
         dH141oyXjqk4CA5a3R9PPxr3MMnMGE9kW9qXbHQx0anFjd2+O7qjF4HvLdA82T9NZRZA
         aE3ELFE9mvqkxuncnDmU7i5+qx2SIhlF2xg0ZSIcVIBjoIyvM2x9OH0BTJZDtMKkNr2o
         ZdnS0QqoWG8/Lxl4pc00Yropj0iCJyeLONNz9/qTi5lwMmN9+wZiREs4QfFxGC6b/WjP
         HQJ0NSBP4U0Jj+ztjk2GEHEAInCyb+cNlKfeqz4aX5XP8ZuODJrbS2wUNTtyabDNLdNu
         3YKw==
X-Gm-Message-State: AOAM530fB6N0yEDcNofPQRBlgxPd1TY4fuTK6YOt0To4A1G9XtOZ6X9B
        bit6vUstqhPv3pDWulAazg6tE51tpoEwwMWj0PY2KQ==
X-Google-Smtp-Source: ABdhPJzJqfGaHJq2+ldqU34HwtWmuioZbE1mfnsdG3PMKurMneO3/jhV3Y1DFK4wKF5E7LWNv5iglwn5lhJUI7IiFvU=
X-Received: by 2002:a62:838d:0:b029:1ba:9b85:2eac with SMTP id
 h135-20020a62838d0000b02901ba9b852eacmr5312098pfe.36.1612394197279; Wed, 03
 Feb 2021 15:16:37 -0800 (PST)
MIME-Version: 1.0
References: <20210130004401.2528717-1-ndesaulniers@google.com>
 <20210130004401.2528717-2-ndesaulniers@google.com> <20210130015222.GC2709570@localhost>
 <CAK7LNARfu-wqW9hfnoeeahiNPbwt4xhoWdxXtK8qjVfEi=7OOg@mail.gmail.com>
In-Reply-To: <CAK7LNARfu-wqW9hfnoeeahiNPbwt4xhoWdxXtK8qjVfEi=7OOg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 3 Feb 2021 15:16:24 -0800
Message-ID: <CAKwvOd=YVDS8tjnN6kFqe2FAhfSzVg870VsSvkNuvVZ7X6BrVg@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] Kbuild: make DWARF version a choice
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
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

On Wed, Feb 3, 2021 at 2:24 PM Masahiro Yamada <masahiroy@kernel.org> wrote=
:
>
> On Sat, Jan 30, 2021 at 10:52 AM Nathan Chancellor <nathan@kernel.org> wr=
ote:
> >
> > On Fri, Jan 29, 2021 at 04:44:00PM -0800, Nick Desaulniers wrote:
> > > Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice which is
> > > the default. Does so in a way that's forward compatible with existing
> > > configs, and makes adding future versions more straightforward.
> > >
> > > GCC since ~4.8 has defaulted to this DWARF version implicitly.
> > >
> > > Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > Suggested-by: Fangrui Song <maskray@google.com>
> > > Suggested-by: Nathan Chancellor <nathan@kernel.org>
> > > Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > One comment below:
> >
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> >
> > > ---
> > >  Makefile          |  5 ++---
> > >  lib/Kconfig.debug | 16 +++++++++++-----
> > >  2 files changed, 13 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index 95ab9856f357..d2b4980807e0 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -830,9 +830,8 @@ ifneq ($(LLVM_IAS),1)
> > >  KBUILD_AFLAGS        +=3D -Wa,-gdwarf-2
> >
> > It is probably worth a comment somewhere that assembly files will still
> > have DWARF v2.
>
> I agree.
> Please noting the reason will be helpful.

Via a comment in the source, or in the commit message?

>
> Could you summarize Jakub's comment in short?
> https://patchwork.kernel.org/project/linux-kbuild/patch/20201022012106.18=
75129-1-ndesaulniers@google.com/#23727667

Via a comment in the source, or in the commit message?

> One more question.
>
>
> Can we remove -g option like follows?
>
>
>  ifdef CONFIG_DEBUG_INFO_SPLIT
>  DEBUG_CFLAGS   +=3D -gsplit-dwarf
> -else
> -DEBUG_CFLAGS   +=3D -g
>  endif
>
>
>
>
>
> In the current mainline code,
> -g is the only debug option
> if CONFIG_DEBUG_INFO_DWARF4 is disabled.
>
>
> The GCC manual says:
> https://gcc.gnu.org/onlinedocs/gcc-10.2.0/gcc/Debugging-Options.html#Debu=
gging-Options
>
>
> -g
>
>     Produce debugging information in the operating system=E2=80=99s
>     native format (stabs, COFF, XCOFF, or DWARF).
>     GDB can work with this debugging information.
>
>
> Of course, we expect the -g option will produce
> the debug info in the DWARF format.
>
>
>
>
>
> With this patch set applied, it is very explicit.
>
> Only the format type, but also the version.
>
> The compiler will be given either
> -gdwarf-4 or -gdwarf-5,
> making the -g option redundant, I think.

Can I provide that as a separate patch?  I don't want any breakage
from that to delay DWARF v5 support further.  If so, should it be the
first patch or last?
--=20
Thanks,
~Nick Desaulniers
