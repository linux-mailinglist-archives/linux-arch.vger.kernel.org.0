Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6283308ED9
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 21:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbhA2Uzy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 15:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbhA2Uzw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 15:55:52 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95483C061573;
        Fri, 29 Jan 2021 12:55:12 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id h11so10703078ioh.11;
        Fri, 29 Jan 2021 12:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=RAB/7SMuviSugZyMHckwTYODLUsFbrHRwIWe2DaL/Ck=;
        b=DleAjbNiLstKJxSwB41b4bvQyMQ3GjuJu7/DKedLNAaZvIIdOFBa0ZBEZ0G7YNciQT
         +WcKLdKShVv8IEd1nSxslO5ukipNzJMoTo7IJ9EnX/HJpp4Db28R4Oc5EgYYIz+CHhgC
         2Leg5DR+NvSitCDqYTaOmIF2fIFhtqrODojsl9a9D9fJzHXj3dOFHfd4C5WJrJVG6ybD
         cm91uu/knWuJ9bkPqYNseM4UYVJEHSs3IecOqh1DptVuuSj7IGj8J/JFW0wkavu7rt+g
         dHNdMIv+Hpczq7kNSWCcvuEpgmKez3H7G7E696vuskhQQ3vAdG17++ci1OyUWsJNnA/j
         yVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=RAB/7SMuviSugZyMHckwTYODLUsFbrHRwIWe2DaL/Ck=;
        b=g10LdKkmz4aC7IyDghcW6iaeFFL44J1dXGaXvzv6wCuNbLi94BWXrdSE4wWXLDmPKQ
         8kb6SgJogJ3kxbugmsAR9wfXX/sOkk7xpjtozgXXhcpVwLYY9RIi5ZtmT1tMKpSCw/G7
         3+3vkvdd6kE0LE42rcXfSKBnaqIMIEZqvFEU3IVE1gOyu0fEifET3FG7Q3VzJqB+s/uR
         X2YW15Ih3ByLMW6CL+QOSTFPtqP97g8wmpppsKtGXjzm0uQEdKet+K2Ve5Ub9KDvHtv7
         KCfluxqoJ8R0vMKwb4ZzXRmskn9PYqp+0kNpIvBNbwfMhO6F89AeZn2UKdPJi1uJXvMY
         dZ3Q==
X-Gm-Message-State: AOAM532N2Q9BG6jQbh3r2vAYKXW7XuAOvzUZbHOpQvY7Fb4mLJUxSZ9i
        VJXBaJ9BZNRhbZcizx/CvwdnhPxXNuc3YH7bPyo=
X-Google-Smtp-Source: ABdhPJwduTJoboT9J7eNXptxk6b2H21JpzRu5DAQIIQ4yGVG+Lv4RXtJVwV5yLn3P5ENlAvqhM9NIPpR6P3lNYKzCuI=
X-Received: by 2002:a05:6638:2694:: with SMTP id o20mr5269898jat.132.1611953711975;
 Fri, 29 Jan 2021 12:55:11 -0800 (PST)
MIME-Version: 1.0
References: <20210129194318.2125748-1-ndesaulniers@google.com>
 <20210129194318.2125748-3-ndesaulniers@google.com> <CA+icZUX4q-JhCo+UZ9T3FhbC_gso-oaB0OR9KdH5iEpoGZyqVw@mail.gmail.com>
 <CAKwvOdnj1Np62+eOiTOCRXSW6GLSv4hmvtWaz=0aTZEEot_dhw@mail.gmail.com>
In-Reply-To: <CAKwvOdnj1Np62+eOiTOCRXSW6GLSv4hmvtWaz=0aTZEEot_dhw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 29 Jan 2021 21:54:58 +0100
Message-ID: <CA+icZUWsyjDY58ZZ0MAVfWqBJ8FUSpM6=_5aqPcRTfX2W8Y-+Q@mail.gmail.com>
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

On Fri, Jan 29, 2021 at 9:48 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Jan 29, 2021 at 12:41 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Fri, Jan 29, 2021 at 8:43 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > diff --git a/Makefile b/Makefile
> > > index 20141cd9319e..bed8b3b180b8 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -832,8 +832,20 @@ endif
> > >
> > >  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
> > >  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
> > > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
> > >  DEBUG_CFLAGS   += -gdwarf-$(dwarf-version-y)
> > >
> > > +# If using clang without the integrated assembler, we need to explicitly tell
> > > +# GAS that we will be feeding it DWARF v5 assembler directives. Kconfig should
> > > +# detect whether the version of GAS supports DWARF v5.
> > > +ifdef CONFIG_CC_IS_CLANG
> > > +ifneq ($(LLVM_IAS),1)
> > > +ifeq ($(dwarf-version-y),5)
> > > +DEBUG_CFLAGS   += -Wa,-gdwarf-5
> >
> > I noticed double "-g -gdwarf-5 -g -gdwarf-5" (a different issue) and
> > that's why I looked again into the top-level Makefile.
>
> That's...unexpected.  I don't see where that could be coming from.
> Can you tell me please what is the precise command line invocation of
> make and which source file you observed this on so that I can
> reproduce?
>

That's everywhere...

$ zstdgrep --color '\-g -gdwarf-5 -g -gdwarf-5'
build-log_5.11.0-rc5-8-amd64-clang12-lto.txt.zst
| wc -l
29529

> > Should this be...?
> >
> > KBUILD_AFLAGS += -Wa,-gdwarf-5
>
> No; under the set of conditions Clang is compiling .c to .S with DWARF
> v5 assembler directives. GAS will choke unless told -gdwarf-5 via
> -Wa,-gdwarf-5 for .c source files, hence it is a C flag, not an A
> flag. A flags are for .S assembler sources, not .c sources.
>

You are right. I mixed again C and A flags.

- Sedat -
