Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FCE308FD4
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 23:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhA2WKX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 17:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbhA2WKW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 17:10:22 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666E8C061574
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 14:09:42 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b17so6091743plz.6
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 14:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dxu0N507rWvhGn5VAco/2PLnGADnFVNDKuKqlZF+C0k=;
        b=llLgOsmddmk9EDYpzXYBxUx0su52vLPGujp7IcTWrNTstMsQoeGkKDnJ0wJ/qrtGXE
         ji5tRdt4tU5KXkDu+I4UHqsIMUbfN2PLXA1LmCJA5s3Zm8DMJHgG4aiErCh+fWU9L8js
         wuBj151/CNHUyfj+9ktwIIxQlSdg0KzOCcWZxD7zJKvE9ov4jRe/7ibU9uAuEZr5MgVs
         EzA69g/Bt1rvgIxjdphFyDe+GMrGVu70A71JW3eDl1Mmzb+jGWZsm3BRQjBtLaQgOy0V
         hJk5KEFAXDPb4bWbuH0sLTJacOLiPucHlv4WSwml4LvISGQUmudD+F+qRmOY0hf6EoXr
         mO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dxu0N507rWvhGn5VAco/2PLnGADnFVNDKuKqlZF+C0k=;
        b=T8D3a+hNVOpZYft8cVhjCiWm8Y5GjHNDv/eh4QEM4q3ZRYEze2sIaVDJWHnQLxeBfI
         RvUilg8+JHyRRpN+qxx2kHbIOXGRddC8lZbWkfy2o47Xl+dsZZsyJOUY0pbJ88d0wZbD
         3itAWUo5HlxMKkO8u94XdwAmxFtd8SsiJQ23rv5yARPJlvkGhN33hin1Zo9ji/WsPC1o
         BWsvgqG+Ldl0NQcbQ1h1IlrDLVsfQ1cALkIUF8WGvCxRxj1aLFEcYAVqUoHrIRAnt2oQ
         MWCl/SADDwFuY9XV1OEaPDnK8YdyJmmV7EkD5/D0kvNhk8tnyMvWOTRHM9sp0qN5mT0K
         URHw==
X-Gm-Message-State: AOAM5321nK2SZ3JwTVpb+CMCJVeI2Fm8tcz2OMV8HvYfmmG93L2viY/A
        ihpGGGr5SCR/2//xmIQ81FNZfAiCSHWZgtQGpkijj48Ff5U=
X-Google-Smtp-Source: ABdhPJx4/DsL32wDxV8jOisct2yup+QBfCRlEZo+UWVh7jtFVUsPojkt3k8mP+aBDYLQBMBPUf7XQXOW2SVDiDCHz+A=
X-Received: by 2002:a17:902:9f87:b029:de:9e09:ee94 with SMTP id
 g7-20020a1709029f87b02900de9e09ee94mr6216436plq.29.1611958181793; Fri, 29 Jan
 2021 14:09:41 -0800 (PST)
MIME-Version: 1.0
References: <20210129194318.2125748-1-ndesaulniers@google.com>
 <20210129194318.2125748-3-ndesaulniers@google.com> <CA+icZUX4q-JhCo+UZ9T3FhbC_gso-oaB0OR9KdH5iEpoGZyqVw@mail.gmail.com>
 <CAKwvOdnj1Np62+eOiTOCRXSW6GLSv4hmvtWaz=0aTZEEot_dhw@mail.gmail.com>
 <CA+icZUWsyjDY58ZZ0MAVfWqBJ8FUSpM6=_5aqPcRTfX2W8Y-+Q@mail.gmail.com>
 <CAKwvOd=mHvEtto37rzFMfsFYe2e-Cp2MAiyRYxHWPdc-HbT8EA@mail.gmail.com>
 <CA+icZUWxK9fdV8PNGqbQrOFmSZ2Ts4nNqfVMMNUh5u79Ld7hjA@mail.gmail.com> <CA+icZUUo6URpxHh6_Tppv9_Z1dyhGDB2OqSCY3yRw72aA0EbMQ@mail.gmail.com>
In-Reply-To: <CA+icZUUo6URpxHh6_Tppv9_Z1dyhGDB2OqSCY3yRw72aA0EbMQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 29 Jan 2021 14:09:31 -0800
Message-ID: <CAKwvOdmWx0reabY-S3nXfTZuhs-_SP7pbb0uHyGeaNSQnm8eRQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] Kbuild: implement support for DWARF v5
To:     Sedat Dilek <sedat.dilek@gmail.com>
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

On Fri, Jan 29, 2021 at 1:20 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Jan 29, 2021 at 10:13 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Fri, Jan 29, 2021 at 10:09 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Fri, Jan 29, 2021 at 12:55 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > >
> > > > On Fri, Jan 29, 2021 at 9:48 PM Nick Desaulniers
> > > > <ndesaulniers@google.com> wrote:
> > > > >
> > > > > On Fri, Jan 29, 2021 at 12:41 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Jan 29, 2021 at 8:43 PM Nick Desaulniers
> > > > > > <ndesaulniers@google.com> wrote:
> > > > > > >
> > > > > > > diff --git a/Makefile b/Makefile
> > > > > > > index 20141cd9319e..bed8b3b180b8 100644
> > > > > > > --- a/Makefile
> > > > > > > +++ b/Makefile
> > > > > > > @@ -832,8 +832,20 @@ endif
> > > > > > >
> > > > > > >  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
> > > > > > >  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
> > > > > > > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
> > > > > > >  DEBUG_CFLAGS   += -gdwarf-$(dwarf-version-y)
> > > > > > >
> > > > > > > +# If using clang without the integrated assembler, we need to explicitly tell
> > > > > > > +# GAS that we will be feeding it DWARF v5 assembler directives. Kconfig should
> > > > > > > +# detect whether the version of GAS supports DWARF v5.
> > > > > > > +ifdef CONFIG_CC_IS_CLANG
> > > > > > > +ifneq ($(LLVM_IAS),1)
> > > > > > > +ifeq ($(dwarf-version-y),5)
> > > > > > > +DEBUG_CFLAGS   += -Wa,-gdwarf-5
> > > > > >
> > > > > > I noticed double "-g -gdwarf-5 -g -gdwarf-5" (a different issue) and
> > > > > > that's why I looked again into the top-level Makefile.
> > > > >
> > > > > That's...unexpected.  I don't see where that could be coming from.
> > > > > Can you tell me please what is the precise command line invocation of
> > > > > make and which source file you observed this on so that I can
> > > > > reproduce?
> > > > >
> > > >
> > > > That's everywhere...
> > > >
> > > > $ zstdgrep --color '\-g -gdwarf-5 -g -gdwarf-5'
> > > > build-log_5.11.0-rc5-8-amd64-clang12-lto.txt.zst
> > > > | wc -l
> > > > 29529
> > >
> > > I'm not able to reproduce.
> > >
> > > $ make LLVM=1 -j72 V=1 2>&1 | grep dwarf
> > > ...
> > > clang ... -g -gdwarf-5 -Wa,-gdwarf-5 ...
> > > ...
> > >
> > > $ make LLVM=1 LLVM_IAS=1 -j72 V=1 2>&1 | grep dwarf
> > > ...
> > > clang ... -g -gdwarf-5 ...
> > > ...
> > >
> >
> > Hmm...
> >
> > I do not see in my current build "-Wa,-gdwarf-5" is passed with v6.
> >
> > $ grep '\-Wa,-gdwarf-5' build-log_5.11.0-rc5-10-amd64-clang12-lto-pgo.txt
> > [ empty ]
> >
>
> That's the diff v5 -> v6...
>
> There is no more a dwarf-aflag / KBUILD_AFLAGS += $(dwarf-aflag) used.

Yep; not sure that's relevant though to duplicate flags?

> > > Can you tell me please what is the precise command line invocation of
> > > make and which source file you observed this on so that I can
> > > reproduce?

If you don't send me your invocation of `make`, I cannot help you.
-- 
Thanks,
~Nick Desaulniers
