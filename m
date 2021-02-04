Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BB230E883
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 01:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbhBDAbJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 19:31:09 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:17145 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbhBDAbI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2021 19:31:08 -0500
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 1140U0Jj024805;
        Thu, 4 Feb 2021 09:30:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 1140U0Jj024805
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1612398600;
        bh=zhHO6YOqvfd2e0VJ7LUzPQqH8P+nIIHnnTyC4WEwfZE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s9YgvvsAdo4MYL2cfptpkytEVQdCvVT1bxQtHtBYp6ws736lnEZFTPTLJDuGVIIze
         SdbHBluApWRlhJ4Q9JLPznvBvwf9vJX14u+SlwcA717ANZtYqR898SvaA911/Pxvsf
         lVEEZfshANvsiCd86NlMYPr2j4G/ONL7hYRFSUG0VD70MEzAbZkSKi8NHydHb23SW+
         He7wEJJpa7958/lfo5s8VcIxdHRsTt5XAJzhmjpWQ3mFiZASYeQSkueYIW06vywvCz
         l64JODS/pdakpzXa8LHtuLnoCbgf0BMO2sCro/949ilDKl9aDlwK+eL7m+N7buOufE
         n1dl4ekZLbV5w==
X-Nifty-SrcIP: [209.85.215.173]
Received: by mail-pg1-f173.google.com with SMTP id s23so899176pgh.11;
        Wed, 03 Feb 2021 16:30:00 -0800 (PST)
X-Gm-Message-State: AOAM533DdMlNHmnBV3G81zFE8sc2ht6bJjOfR2wJC7PEcVakXpI5zLjf
        Q60490zitgNcjPrE1sHhwOX3qF7leUrMiVflFHo=
X-Google-Smtp-Source: ABdhPJzm1BiOfNz/pyberi6JyhtEIkNALKOgJACSZF025IEv8c7MPb7agCCLLUQ4hVo5kT/pkzBKfV7d0joPIW668oA=
X-Received: by 2002:a62:2f07:0:b029:1bb:5f75:f985 with SMTP id
 v7-20020a622f070000b02901bb5f75f985mr5322944pfv.76.1612398599530; Wed, 03 Feb
 2021 16:29:59 -0800 (PST)
MIME-Version: 1.0
References: <20210130004401.2528717-1-ndesaulniers@google.com>
 <20210130004401.2528717-2-ndesaulniers@google.com> <20210130015222.GC2709570@localhost>
 <CAK7LNARfu-wqW9hfnoeeahiNPbwt4xhoWdxXtK8qjVfEi=7OOg@mail.gmail.com> <CAKwvOd=YVDS8tjnN6kFqe2FAhfSzVg870VsSvkNuvVZ7X6BrVg@mail.gmail.com>
In-Reply-To: <CAKwvOd=YVDS8tjnN6kFqe2FAhfSzVg870VsSvkNuvVZ7X6BrVg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 4 Feb 2021 09:29:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNARWpPBpT7MXeUBYO3SNcB1UtTNrTcVeFW1QXRMfBrOZHQ@mail.gmail.com>
Message-ID: <CAK7LNARWpPBpT7MXeUBYO3SNcB1UtTNrTcVeFW1QXRMfBrOZHQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] Kbuild: make DWARF version a choice
To:     Nick Desaulniers <ndesaulniers@google.com>
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
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 4, 2021 at 8:16 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Wed, Feb 3, 2021 at 2:24 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Sat, Jan 30, 2021 at 10:52 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > On Fri, Jan 29, 2021 at 04:44:00PM -0800, Nick Desaulniers wrote:
> > > > Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice which is
> > > > the default. Does so in a way that's forward compatible with existing
> > > > configs, and makes adding future versions more straightforward.
> > > >
> > > > GCC since ~4.8 has defaulted to this DWARF version implicitly.
> > > >
> > > > Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > > Suggested-by: Fangrui Song <maskray@google.com>
> > > > Suggested-by: Nathan Chancellor <nathan@kernel.org>
> > > > Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > >
> > > One comment below:
> > >
> > > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > >
> > > > ---
> > > >  Makefile          |  5 ++---
> > > >  lib/Kconfig.debug | 16 +++++++++++-----
> > > >  2 files changed, 13 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/Makefile b/Makefile
> > > > index 95ab9856f357..d2b4980807e0 100644
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -830,9 +830,8 @@ ifneq ($(LLVM_IAS),1)
> > > >  KBUILD_AFLAGS        += -Wa,-gdwarf-2
> > >
> > > It is probably worth a comment somewhere that assembly files will still
> > > have DWARF v2.
> >
> > I agree.
> > Please noting the reason will be helpful.
>
> Via a comment in the source, or in the commit message?
>
> >
> > Could you summarize Jakub's comment in short?
> > https://patchwork.kernel.org/project/linux-kbuild/patch/20201022012106.1875129-1-ndesaulniers@google.com/#23727667
>
> Via a comment in the source, or in the commit message?


Both in the source if you can summarize it in three lines or so.


If you need to add more detailed explanation,
please provide it in the commit log.




> >
> > With this patch set applied, it is very explicit.
> >
> > Only the format type, but also the version.
> >
> > The compiler will be given either
> > -gdwarf-4 or -gdwarf-5,
> > making the -g option redundant, I think.
>
> Can I provide that as a separate patch?  I don't want any breakage
> from that to delay DWARF v5 support further.  If so, should it be the
> first patch or last?


OK.

At the last to be safe?

I am fine with doing a clean-up work later.






> --
> Thanks,
> ~Nick Desaulniers



--
Best Regards
Masahiro Yamada
