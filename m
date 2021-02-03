Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31EB930E609
	for <lists+linux-arch@lfdr.de>; Wed,  3 Feb 2021 23:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhBCW1Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 17:27:25 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:23878 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbhBCW1Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2021 17:27:24 -0500
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 113MQSAm031538;
        Thu, 4 Feb 2021 07:26:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 113MQSAm031538
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1612391189;
        bh=KNoRa1M7aXZ9EARkAVysyDE3B2jC5KmUmnY6dfCesYk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zNjACUlIg12bIAcccjitZDjF/RWIcEO8Uvh+D1ulpAfG8sdz2bOtkL5J4zdMTBJeE
         +dzWdBEpazYwVuuI62uCDQTzbz4aTESv4AWeiE8U8ETh63hHW1u8oxurX4jo0S6LFm
         ajEweivWOf3pq/wQggyDwZMdI9OzHAY4A5ZwDZNha+49PbUKAhwB5ncNo4AsunNvLU
         AO6UTgwt6cIeRcW383vGwJg93wYxRtbq/1S4rqEC/9+3pKvR8pmg3hDSF6O88SRqPh
         Nqo8TR9LpbI2pWoNVtoDK3L/ZwTH6Cd1REWYr9zdplSwmfnUunO4SgNeSA/Z48YlM7
         B34Soo9KQaiNA==
X-Nifty-SrcIP: [209.85.210.174]
Received: by mail-pf1-f174.google.com with SMTP id i63so759403pfg.7;
        Wed, 03 Feb 2021 14:26:29 -0800 (PST)
X-Gm-Message-State: AOAM530G1rG8T+GLpUlGCvmWZUYpLQUFSWpigvkEXZMWrRQ+nlzE0WAM
        IxS4JBfKWmxtK/zjb8WeHDIt2xyzBjBUaxHBWKQ=
X-Google-Smtp-Source: ABdhPJyi84leWrAFywSMqa/nad53Bjx45iXZhe6UpJpbvm4KbVLlT1HGear2Xvu+T/QoIiD6NCj6JKX7xNIq79mEO4w=
X-Received: by 2002:aa7:8f13:0:b029:1bd:f965:66d8 with SMTP id
 x19-20020aa78f130000b02901bdf96566d8mr4811312pfr.80.1612391188381; Wed, 03
 Feb 2021 14:26:28 -0800 (PST)
MIME-Version: 1.0
References: <20210130004401.2528717-1-ndesaulniers@google.com>
 <20210130004401.2528717-2-ndesaulniers@google.com> <20210130015222.GC2709570@localhost>
 <CAK7LNARfu-wqW9hfnoeeahiNPbwt4xhoWdxXtK8qjVfEi=7OOg@mail.gmail.com>
In-Reply-To: <CAK7LNARfu-wqW9hfnoeeahiNPbwt4xhoWdxXtK8qjVfEi=7OOg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 4 Feb 2021 07:25:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT1xrU3t6xV2qHEO=J4Q3NV=ap4b=c129JD3MWsptEy9g@mail.gmail.com>
Message-ID: <CAK7LNAT1xrU3t6xV2qHEO=J4Q3NV=ap4b=c129JD3MWsptEy9g@mail.gmail.com>
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

On Thu, Feb 4, 2021 at 7:23 AM Masahiro Yamada <masahiroy@kernel.org> wrote=
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
>
> Could you summarize Jakub's comment in short?
> https://patchwork.kernel.org/project/linux-kbuild/patch/20201022012106.18=
75129-1-ndesaulniers@google.com/#23727667
>
>
>
>
>
>
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


I mean:

Not only the format type, but also the version
is explicit.




> The compiler will be given either
> -gdwarf-4 or -gdwarf-5,
> making the -g option redundant, I think.
>
>
>
>
>
>
--=20
Best Regards
Masahiro Yamada
