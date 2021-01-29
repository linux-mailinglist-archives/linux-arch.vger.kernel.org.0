Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B225309007
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 23:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhA2WYi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 17:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbhA2WYi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 17:24:38 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080D8C061574;
        Fri, 29 Jan 2021 14:23:58 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id p15so9216643ilq.8;
        Fri, 29 Jan 2021 14:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=3fPW1TUgX2/1fVYL/M0nnkRdL6ejuKJqJV1Pkxb+xdw=;
        b=EjnZUgc6dqPQ2FnREpTyCQEdlKeNoAp0j/485YdekbxaAVPWonwqxw6j9E53R2KLTI
         DirijfTvAIYldQgddLyFvPD1of7SdZ5nltEW79Rfq4qzioXwYoc6srsMjOVyrLNyP2eE
         p/i4nU8Kwfb+MZvgbW9Cqg8TXVRtjtRJ+ztMozZiMgS8329dWDGnb3pgO3NVmBpD8w9Z
         VVEc4FRaPaWiq1y3ZlmoD5LggQOzYh6DCwJm+h+mhBuKwAm9iymHFED9fYoXPChTiQ8F
         uZdr/oTUghNmI+s9M7Z0x5Gc9vrdI3dZb8ksQLdcXzxV/4Ov0vh/f5WvzpPUc8C1o9Pr
         cuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=3fPW1TUgX2/1fVYL/M0nnkRdL6ejuKJqJV1Pkxb+xdw=;
        b=haHYIXgUHzCV4B2g1TcmzVevypTewg41NsaSKGw3um100UTzqF4XAgswXBHBPDLQuf
         cKr5iIrm/sKYbV9TFBMYFEl4IIvBanY348NZOkfZFSLPaO8NG7dOV1r1QUmV0/2pp2ep
         cQw4JKRTkA0qxj/U2bDtW9VRn7iWYn0VhOrzqu+iSfdq5sQmNI3oQ64U+s5QkOv7Zwcd
         8G4S0sSThJbKtvnqXQqNYky7VCm+l4LKpx1ajbfa5BiyFeO1UYsCVCHz5bByjVp9mYvx
         3bo+WL1klAJrEEcTMXMFoa7Ot47BmutsUojt1tvTlFFr32hDuNim9q37uvOiqHx/iX2L
         42qA==
X-Gm-Message-State: AOAM533f/DsiOUzw1VUCMXsbi6+4WU+JYqkY0HOikJrnZ45t6dyNXSL9
        Zlq+NQojfcFGbs/dpLy0QRUzjNnzWYRI8gWI45g=
X-Google-Smtp-Source: ABdhPJzDHl+mX/B5IsxZx+xDMsyd7J5vKKZ1flMp80CRR5J2YC398xHB9YS+YusD6Ywn0oMsmOqCkxUnSkOMwggjonk=
X-Received: by 2002:a92:c80b:: with SMTP id v11mr4625280iln.215.1611959037474;
 Fri, 29 Jan 2021 14:23:57 -0800 (PST)
MIME-Version: 1.0
References: <20210129194318.2125748-1-ndesaulniers@google.com>
 <20210129194318.2125748-3-ndesaulniers@google.com> <CA+icZUX4q-JhCo+UZ9T3FhbC_gso-oaB0OR9KdH5iEpoGZyqVw@mail.gmail.com>
 <CAKwvOdnj1Np62+eOiTOCRXSW6GLSv4hmvtWaz=0aTZEEot_dhw@mail.gmail.com>
 <CA+icZUWsyjDY58ZZ0MAVfWqBJ8FUSpM6=_5aqPcRTfX2W8Y-+Q@mail.gmail.com>
 <CAKwvOd=mHvEtto37rzFMfsFYe2e-Cp2MAiyRYxHWPdc-HbT8EA@mail.gmail.com>
 <CA+icZUWxK9fdV8PNGqbQrOFmSZ2Ts4nNqfVMMNUh5u79Ld7hjA@mail.gmail.com>
 <CA+icZUUo6URpxHh6_Tppv9_Z1dyhGDB2OqSCY3yRw72aA0EbMQ@mail.gmail.com>
 <CAKwvOdmWx0reabY-S3nXfTZuhs-_SP7pbb0uHyGeaNSQnm8eRQ@mail.gmail.com>
 <CA+icZUWsncyKvxPZ5g=a3ssWy=cYahsU6hprM3n=jFUmnjPC6w@mail.gmail.com> <CAKwvOdk4kG-_c3inNj9ry_xUU9SQE-2AqQp40YL_V=6SHU6E=Q@mail.gmail.com>
In-Reply-To: <CAKwvOdk4kG-_c3inNj9ry_xUU9SQE-2AqQp40YL_V=6SHU6E=Q@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 29 Jan 2021 23:23:46 +0100
Message-ID: <CA+icZUX576Rt7HJ4hvrwRTCC2pTmoH-Yu-haU+MDb8B6yADAYA@mail.gmail.com>
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

On Fri, Jan 29, 2021 at 11:21 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Jan 29, 2021 at 2:11 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Fri, Jan 29, 2021 at 11:09 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Fri, Jan 29, 2021 at 1:20 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > >
> > > > On Fri, Jan 29, 2021 at 10:13 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > >
> > > > > On Fri, Jan 29, 2021 at 10:09 PM Nick Desaulniers
> > > > > <ndesaulniers@google.com> wrote:
> > > > > >
> > > > > > On Fri, Jan 29, 2021 at 12:55 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > > > >
> > > > > > > On Fri, Jan 29, 2021 at 9:48 PM Nick Desaulniers
> > > > > > > <ndesaulniers@google.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, Jan 29, 2021 at 12:41 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Jan 29, 2021 at 8:43 PM Nick Desaulniers
> > > > > > > > > <ndesaulniers@google.com> wrote:
> > > > > > > > > >
> > > > > > > > > > diff --git a/Makefile b/Makefile
> > > > > > > > > > index 20141cd9319e..bed8b3b180b8 100644
> > > > > > > > > > --- a/Makefile
> > > > > > > > > > +++ b/Makefile
> > > > > > > > > > @@ -832,8 +832,20 @@ endif
> > > > > > > > > >
> > > > > > > > > >  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
> > > > > > > > > >  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
> > > > > > > > > > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
> > > > > > > > > >  DEBUG_CFLAGS   += -gdwarf-$(dwarf-version-y)
> > > > > > > > > >
> > > > > > > > > > +# If using clang without the integrated assembler, we need to explicitly tell
> > > > > > > > > > +# GAS that we will be feeding it DWARF v5 assembler directives. Kconfig should
> > > > > > > > > > +# detect whether the version of GAS supports DWARF v5.
> > > > > > > > > > +ifdef CONFIG_CC_IS_CLANG
> > > > > > > > > > +ifneq ($(LLVM_IAS),1)
> > > > > > > > > > +ifeq ($(dwarf-version-y),5)
> > > > > > > > > > +DEBUG_CFLAGS   += -Wa,-gdwarf-5
> > > > > > > > >
> > > > > > > > > I noticed double "-g -gdwarf-5 -g -gdwarf-5" (a different issue) and
> > > > > > > > > that's why I looked again into the top-level Makefile.
> > > > > > > >
> > > > > > > > That's...unexpected.  I don't see where that could be coming from.
> > > > > > > > Can you tell me please what is the precise command line invocation of
> > > > > > > > make and which source file you observed this on so that I can
> > > > > > > > reproduce?
> > > > > > > >
> > > > > > >
> > > > > > > That's everywhere...
> > > > > > >
> > > > > > > $ zstdgrep --color '\-g -gdwarf-5 -g -gdwarf-5'
> > > > > > > build-log_5.11.0-rc5-8-amd64-clang12-lto.txt.zst
> > > > > > > | wc -l
> > > > > > > 29529
> > > > > >
> > > > > > I'm not able to reproduce.
> > > > > >
> > > > > > $ make LLVM=1 -j72 V=1 2>&1 | grep dwarf
> > > > > > ...
> > > > > > clang ... -g -gdwarf-5 -Wa,-gdwarf-5 ...
> > > > > > ...
> > > > > >
> > > > > > $ make LLVM=1 LLVM_IAS=1 -j72 V=1 2>&1 | grep dwarf
> > > > > > ...
> > > > > > clang ... -g -gdwarf-5 ...
> > > > > > ...
> > > > > >
> > > > >
> > > > > Hmm...
> > > > >
> > > > > I do not see in my current build "-Wa,-gdwarf-5" is passed with v6.
> > > > >
> > > > > $ grep '\-Wa,-gdwarf-5' build-log_5.11.0-rc5-10-amd64-clang12-lto-pgo.txt
> > > > > [ empty ]
> > > > >
> > > >
> > > > That's the diff v5 -> v6...
> > > >
> > > > There is no more a dwarf-aflag / KBUILD_AFLAGS += $(dwarf-aflag) used.
> > >
> > > Yep; not sure that's relevant though to duplicate flags?
> > >
> > > > > > Can you tell me please what is the precise command line invocation of
> > > > > > make and which source file you observed this on so that I can
> > > > > > reproduce?
> > >
> > > If you don't send me your invocation of `make`, I cannot help you.
> > >
> >
> > /usr/bin/perf_5.10 stat make V=1 -j4 LLVM=1 LLVM_IAS=1
> > PAHOLE=/opt/pahole/bin/pahole LOCALVERSION=-10-amd64-clang12
> > -lto-pgo KBUILD_VERBOSE=1 KBUILD_BUILD_HOST=iniza
> > KBUILD_BUILD_USER=sedat.dilek@gmail.com
> > KBUILD_BUILD_TIMESTAMP=2021-01-29 bindeb-pkg
> > KDEB_PKGVERSION=5.11.0~rc5-10~bullseye+dileks1
>
> $ make LLVM=1 LLVM_IAS=1 -j72 defconfig
> $ make LLVM=1 LLVM_IAS=1 -j72 menuconfig
> <enable CONFIG_DEBUG_INFO and CONFIG_DEBUG_INFO_DWARF5>
> $ make LLVM=1 LLVM_IAS=1 -j72 V=1 &> log.txt
> $ grep '\-g -gdwarf-5 -g -gdwarf-5' log.txt | wc -l
> 0
> $ grep '\-g -gdwarf-5' log.txt | wc -l
> 2517
>
> Do have the patch applied twice, perhaps?
>
> Is your compiler haunted, or is mine? (haha! they both are; false
> dichotomy; they are one in the same).  Is zstdgrep haunted, or is GNU
> grep haunted? :P
>

Switched to my v6 local Git branch and invoked above make line I gave you.
I still see that double.
Looks like I need some "undrunken" switch.

- Sedat -
