Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B033308F24
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 22:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbhA2VOw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 16:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbhA2VOu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 16:14:50 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF12EC061573;
        Fri, 29 Jan 2021 13:14:10 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id y17so9792297ili.12;
        Fri, 29 Jan 2021 13:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Y5eleuovVYlYGhKSgobmMAxGgubqmiuAwZoAc4FZso8=;
        b=ISXN4hx2Gb+uZoyP/IDkD+TXSfBx+Sts9bwVtz1KNBTGkoy2x4WU2rrRdR2At2Cik0
         RtNRPkBvws+CnAOF+d8RP98qdDNk3HfDkStF4tONnWFOvGiV9fNJN3YCVvuWjoZGJfqD
         uviJ3cQhwc9ZVbgQjMYTV5yxwC+zETEqY6aWNpTy6a3WKY5gGm2FgSJnHND2fPhXkDzg
         vTAWRVmnej3mSFxVVG6XodJBr8aCveuQOVB92doX3C+ws7vFPgw6mQRP2AnICAatnJh7
         ZaeV3LjbSe6EgtkOKTufJpkRNazoxCD8q5DrKY983in+8lYO5YWLz366VS1G7sWOYQWP
         GAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Y5eleuovVYlYGhKSgobmMAxGgubqmiuAwZoAc4FZso8=;
        b=seLCI0bUMPpdHFyzJ/pRZBG7jKJTn24qebCI7I4GyCwR1WwPLOSkSgoklcE0VPrEVU
         laJHUoaFNQZe7zXsuAZ7yvUHxP6htgzPUd87C06wuT8jA53uFc4b3gKv1mglnrRk3Fai
         aelsZ3KMkCGHNv9B7kN1qFDT9iopg36Chs/hRtRU+Pd9Dmlmg6yjfR6O+Yrm0xkl1ixM
         lC8ddPrfRHhB127fcKATLoJuXej+IyarWt9gVyPjQkN/QjspvuofTKkhigAsjWCP50w3
         0KUCQ0EcleTL2FRYbP4KCFHmButhxaTF4qUeaHWB9tFdgGf5+83Bx265LazyFeazYhO4
         UWBw==
X-Gm-Message-State: AOAM532ioYE90U6TSQyd10uS8g7Q1ESVo6c2/y52xdbxD+elhrQvhC5t
        jgOG+xBZUiBoG9yRTzCKBAv34m+vx7VVBgeum/Y=
X-Google-Smtp-Source: ABdhPJwJ6YvdtSJmGOgGXc7eehbuIqJGc/L8RmzRBCZGMXyDZS3mYPvwZ8vCT/qVRXihwuzMdaekc319iXawi07dmkE=
X-Received: by 2002:a92:c80b:: with SMTP id v11mr4425537iln.215.1611954850115;
 Fri, 29 Jan 2021 13:14:10 -0800 (PST)
MIME-Version: 1.0
References: <20210129194318.2125748-1-ndesaulniers@google.com>
 <20210129194318.2125748-3-ndesaulniers@google.com> <CA+icZUX4q-JhCo+UZ9T3FhbC_gso-oaB0OR9KdH5iEpoGZyqVw@mail.gmail.com>
 <CAKwvOdnj1Np62+eOiTOCRXSW6GLSv4hmvtWaz=0aTZEEot_dhw@mail.gmail.com>
 <CA+icZUWsyjDY58ZZ0MAVfWqBJ8FUSpM6=_5aqPcRTfX2W8Y-+Q@mail.gmail.com> <CAKwvOd=mHvEtto37rzFMfsFYe2e-Cp2MAiyRYxHWPdc-HbT8EA@mail.gmail.com>
In-Reply-To: <CAKwvOd=mHvEtto37rzFMfsFYe2e-Cp2MAiyRYxHWPdc-HbT8EA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 29 Jan 2021 22:13:58 +0100
Message-ID: <CA+icZUWxK9fdV8PNGqbQrOFmSZ2Ts4nNqfVMMNUh5u79Ld7hjA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] Kbuild: implement support for DWARF v5
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
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
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 29, 2021 at 10:09 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Jan 29, 2021 at 12:55 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Fri, Jan 29, 2021 at 9:48 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Fri, Jan 29, 2021 at 12:41 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > >
> > > > On Fri, Jan 29, 2021 at 8:43 PM Nick Desaulniers
> > > > <ndesaulniers@google.com> wrote:
> > > > >
> > > > > diff --git a/Makefile b/Makefile
> > > > > index 20141cd9319e..bed8b3b180b8 100644
> > > > > --- a/Makefile
> > > > > +++ b/Makefile
> > > > > @@ -832,8 +832,20 @@ endif
> > > > >
> > > > >  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
> > > > >  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
> > > > > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
> > > > >  DEBUG_CFLAGS   += -gdwarf-$(dwarf-version-y)
> > > > >
> > > > > +# If using clang without the integrated assembler, we need to explicitly tell
> > > > > +# GAS that we will be feeding it DWARF v5 assembler directives. Kconfig should
> > > > > +# detect whether the version of GAS supports DWARF v5.
> > > > > +ifdef CONFIG_CC_IS_CLANG
> > > > > +ifneq ($(LLVM_IAS),1)
> > > > > +ifeq ($(dwarf-version-y),5)
> > > > > +DEBUG_CFLAGS   += -Wa,-gdwarf-5
> > > >
> > > > I noticed double "-g -gdwarf-5 -g -gdwarf-5" (a different issue) and
> > > > that's why I looked again into the top-level Makefile.
> > >
> > > That's...unexpected.  I don't see where that could be coming from.
> > > Can you tell me please what is the precise command line invocation of
> > > make and which source file you observed this on so that I can
> > > reproduce?
> > >
> >
> > That's everywhere...
> >
> > $ zstdgrep --color '\-g -gdwarf-5 -g -gdwarf-5'
> > build-log_5.11.0-rc5-8-amd64-clang12-lto.txt.zst
> > | wc -l
> > 29529
>
> I'm not able to reproduce.
>
> $ make LLVM=1 -j72 V=1 2>&1 | grep dwarf
> ...
> clang ... -g -gdwarf-5 -Wa,-gdwarf-5 ...
> ...
>
> $ make LLVM=1 LLVM_IAS=1 -j72 V=1 2>&1 | grep dwarf
> ...
> clang ... -g -gdwarf-5 ...
> ...
>

Hmm...

I do not see in my current build "-Wa,-gdwarf-5" is passed with v6.

$ grep '\-Wa,-gdwarf-5' build-log_5.11.0-rc5-10-amd64-clang12-lto-pgo.txt
[ empty ]


- Sedat




> Can you tell me please what is the precise command line invocation of
> make and which source file you observed this on so that I can
> reproduce?
> --
> Thanks,
> ~Nick Desaulniers
