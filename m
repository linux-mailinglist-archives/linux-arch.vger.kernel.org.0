Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E8E308F32
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 22:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbhA2VVE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 16:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbhA2VVD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 16:21:03 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA43C061573;
        Fri, 29 Jan 2021 13:20:23 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id p8so9817341ilg.3;
        Fri, 29 Jan 2021 13:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=/Jt06ny6ITPJGXSastjfT3IhLkcolmmMoDppTdivYms=;
        b=CyT2dKXCi2ClKsYEYgWZ1tKSBtaIL/mF8HT0XPizh5NFK6NUe4RMx98uxAs14tYtz3
         A0TOvZGOXHtZtQTfMxHvjXpMm011z882st9qXQGTKGGQuJpUgyq+V8plsWHoEyFBC2+Y
         4rGjbwBjBdM3JRNgM1sK+1W5FMt2JjY/l4eD+BGIRQaxAYjZtcXn40RqkHDTFLqBihxm
         g0anpGBO769UPrKNdQOVpL7mn+3FUfmSisVxjYWV30hWrPIzAuzsTNfkz/x0vZjifKIG
         QSq7iXGw5RGRUayFilfzKGwWQUuTJFRJRXyTvdiFBO8RuDBqqCNEZGS6N5Bn3Z8UZ8DM
         huhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=/Jt06ny6ITPJGXSastjfT3IhLkcolmmMoDppTdivYms=;
        b=oDavQa6SiRDbpAtK/M61QXozsQQafHlfDy57aIQfW8KjfSYRdXXXpePgqUDL6WE7if
         eHYbgP5lg+Tuv6zlGz/f/REZqUSAsAq9LVICmHr2xwTxwCwlEBhNTzHID8RQNspVJi0y
         PtNUgTs5+zclseuljXaYejlvN08622pwJ+hk4SIQONwA0un8Xk7BHDlHh3ff0d80oSaB
         jDdGDIb8hEPAkyQ64XlXvPeWsIrKJ3g0RGkU0aLkXY5t2i9uAI2SAn5tmaJ7W7sWmrbB
         SBCp9JLckA2f9fEUPX2L676LT2ddtQNS8E/iYqctR0nVm2ELGksSn3BmBHrYlN5Y+EYq
         8oHQ==
X-Gm-Message-State: AOAM533q5s5V2v9q44UHNLAa9qR7M9ke0jLkKa1v4BD4idvKTdk5Q+c+
        dZ1reID/s3h7qYjOHVLmHElY+uMCmmBsBogg/Q0=
X-Google-Smtp-Source: ABdhPJyNHnb+Pm3K/AnVpy6FQQkFCkfLxnclM7VPSkDuMoq78n9GBja/qto73XkaUvcgU0S5wedJsDHuWBgZOED7vSA=
X-Received: by 2002:a92:c80b:: with SMTP id v11mr4445392iln.215.1611955222408;
 Fri, 29 Jan 2021 13:20:22 -0800 (PST)
MIME-Version: 1.0
References: <20210129194318.2125748-1-ndesaulniers@google.com>
 <20210129194318.2125748-3-ndesaulniers@google.com> <CA+icZUX4q-JhCo+UZ9T3FhbC_gso-oaB0OR9KdH5iEpoGZyqVw@mail.gmail.com>
 <CAKwvOdnj1Np62+eOiTOCRXSW6GLSv4hmvtWaz=0aTZEEot_dhw@mail.gmail.com>
 <CA+icZUWsyjDY58ZZ0MAVfWqBJ8FUSpM6=_5aqPcRTfX2W8Y-+Q@mail.gmail.com>
 <CAKwvOd=mHvEtto37rzFMfsFYe2e-Cp2MAiyRYxHWPdc-HbT8EA@mail.gmail.com> <CA+icZUWxK9fdV8PNGqbQrOFmSZ2Ts4nNqfVMMNUh5u79Ld7hjA@mail.gmail.com>
In-Reply-To: <CA+icZUWxK9fdV8PNGqbQrOFmSZ2Ts4nNqfVMMNUh5u79Ld7hjA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 29 Jan 2021 22:20:10 +0100
Message-ID: <CA+icZUUo6URpxHh6_Tppv9_Z1dyhGDB2OqSCY3yRw72aA0EbMQ@mail.gmail.com>
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

On Fri, Jan 29, 2021 at 10:13 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Jan 29, 2021 at 10:09 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Fri, Jan 29, 2021 at 12:55 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > On Fri, Jan 29, 2021 at 9:48 PM Nick Desaulniers
> > > <ndesaulniers@google.com> wrote:
> > > >
> > > > On Fri, Jan 29, 2021 at 12:41 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > >
> > > > > On Fri, Jan 29, 2021 at 8:43 PM Nick Desaulniers
> > > > > <ndesaulniers@google.com> wrote:
> > > > > >
> > > > > > diff --git a/Makefile b/Makefile
> > > > > > index 20141cd9319e..bed8b3b180b8 100644
> > > > > > --- a/Makefile
> > > > > > +++ b/Makefile
> > > > > > @@ -832,8 +832,20 @@ endif
> > > > > >
> > > > > >  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
> > > > > >  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
> > > > > > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
> > > > > >  DEBUG_CFLAGS   += -gdwarf-$(dwarf-version-y)
> > > > > >
> > > > > > +# If using clang without the integrated assembler, we need to explicitly tell
> > > > > > +# GAS that we will be feeding it DWARF v5 assembler directives. Kconfig should
> > > > > > +# detect whether the version of GAS supports DWARF v5.
> > > > > > +ifdef CONFIG_CC_IS_CLANG
> > > > > > +ifneq ($(LLVM_IAS),1)
> > > > > > +ifeq ($(dwarf-version-y),5)
> > > > > > +DEBUG_CFLAGS   += -Wa,-gdwarf-5
> > > > >
> > > > > I noticed double "-g -gdwarf-5 -g -gdwarf-5" (a different issue) and
> > > > > that's why I looked again into the top-level Makefile.
> > > >
> > > > That's...unexpected.  I don't see where that could be coming from.
> > > > Can you tell me please what is the precise command line invocation of
> > > > make and which source file you observed this on so that I can
> > > > reproduce?
> > > >
> > >
> > > That's everywhere...
> > >
> > > $ zstdgrep --color '\-g -gdwarf-5 -g -gdwarf-5'
> > > build-log_5.11.0-rc5-8-amd64-clang12-lto.txt.zst
> > > | wc -l
> > > 29529
> >
> > I'm not able to reproduce.
> >
> > $ make LLVM=1 -j72 V=1 2>&1 | grep dwarf
> > ...
> > clang ... -g -gdwarf-5 -Wa,-gdwarf-5 ...
> > ...
> >
> > $ make LLVM=1 LLVM_IAS=1 -j72 V=1 2>&1 | grep dwarf
> > ...
> > clang ... -g -gdwarf-5 ...
> > ...
> >
>
> Hmm...
>
> I do not see in my current build "-Wa,-gdwarf-5" is passed with v6.
>
> $ grep '\-Wa,-gdwarf-5' build-log_5.11.0-rc5-10-amd64-clang12-lto-pgo.txt
> [ empty ]
>

That's the diff v5 -> v6...

[ Makefile ]

@@ -826,16 +829,23 @@ else
 DEBUG_CFLAGS += -g
 endif

+ifneq ($(LLVM_IAS),1)
+KBUILD_AFLAGS += -Wa,-gdwarf-2
+endif
+
 dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
 dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
 dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
 DEBUG_CFLAGS += -gdwarf-$(dwarf-version-y)
-# Binutils 2.35+ required for -gdwarf-4+ support.
-dwarf-aflag := $(call as-option,-Wa$(comma)-gdwarf-$(dwarf-version-y))
-KBUILD_AFLAGS += $(dwarf-aflag)
+
+# If using clang without the integrated assembler, we need to explicitly tell
+# GAS that we will be feeding it DWARF v5 assembler directives. Kconfig should
+# detect whether the version of GAS supports DWARF v5.
 ifdef CONFIG_CC_IS_CLANG
 ifneq ($(LLVM_IAS),1)
-DEBUG_CFLAGS += $(dwarf-aflag)
+ifeq ($(dwarf-version-y),5)
+DEBUG_CFLAGS += -Wa,-gdwarf-5
+endif
 endif
 endif

There is no more a dwarf-aflag / KBUILD_AFLAGS += $(dwarf-aflag) used.

- Sedat -

>
> - Sedat
>
>
>
>
> > Can you tell me please what is the precise command line invocation of
> > make and which source file you observed this on so that I can
> > reproduce?
> > --
> > Thanks,
> > ~Nick Desaulniers
