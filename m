Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5765C30D477
	for <lists+linux-arch@lfdr.de>; Wed,  3 Feb 2021 08:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhBCH6E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 02:58:04 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:42800 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbhBCH6D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2021 02:58:03 -0500
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 1137upih029648;
        Wed, 3 Feb 2021 16:56:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 1137upih029648
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1612339012;
        bh=N/D47fbOBRad6M/ZDk/32EhFpPJEKVijkKmIa+v6ag4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ym+O+5PBZd3TiH1J/boWvO7Ah+7Zw1dd+m1WCL2PLHVOaxj/kaJk3luE8wzSc0v/N
         +XxXE+Gh0CJEVQJRH6Qvsk1KW8y2eh7/eDdidHLTzWfpwJlRsBfQjrrMY3rbCKE9Zd
         IRPd3yBPcTztb7e9utJY55XNhkr7amSnGFGhyYEr0/LLpC4O3h4gWnBTihyISJgned
         AWiRpyPzcrPBdwyKOQQQz6B0TQMJpA+KcjyJ/IKjHKQHqL7dyYDiA2ysOSOXQFuh8s
         0d4smHg9jSwOG5iaccwYqCC4Rzx7nCy3qNkOZaEgjaCQdrQGBdAT/KORwm/fYBChgm
         4I4j4UzVqhoVw==
X-Nifty-SrcIP: [209.85.210.177]
Received: by mail-pf1-f177.google.com with SMTP id y205so16126796pfc.5;
        Tue, 02 Feb 2021 23:56:51 -0800 (PST)
X-Gm-Message-State: AOAM530Z2BKO8ZRYlvEeNCG7eEePvh7wA50jiFjx8Rln4zi9VMjhEaWY
        ayv63Ah1TkKSpv5ccRyARU/kV8ripkAwVd+DyGc=
X-Google-Smtp-Source: ABdhPJwocduLKpxLPGkPF7gvS0SZMMyZYVYiwpkUTAOZSWGMy/U578SIQChgZdM6kmhVK8/Dc+NmFTmNbOS5nDC1rGc=
X-Received: by 2002:a63:ff09:: with SMTP id k9mr2382791pgi.175.1612339010996;
 Tue, 02 Feb 2021 23:56:50 -0800 (PST)
MIME-Version: 1.0
References: <20210129194318.2125748-1-ndesaulniers@google.com>
 <20210129194318.2125748-3-ndesaulniers@google.com> <CA+icZUX4q-JhCo+UZ9T3FhbC_gso-oaB0OR9KdH5iEpoGZyqVw@mail.gmail.com>
 <CAKwvOdnj1Np62+eOiTOCRXSW6GLSv4hmvtWaz=0aTZEEot_dhw@mail.gmail.com>
 <CA+icZUWsyjDY58ZZ0MAVfWqBJ8FUSpM6=_5aqPcRTfX2W8Y-+Q@mail.gmail.com>
 <CAKwvOd=mHvEtto37rzFMfsFYe2e-Cp2MAiyRYxHWPdc-HbT8EA@mail.gmail.com>
 <CA+icZUWxK9fdV8PNGqbQrOFmSZ2Ts4nNqfVMMNUh5u79Ld7hjA@mail.gmail.com>
 <CA+icZUUo6URpxHh6_Tppv9_Z1dyhGDB2OqSCY3yRw72aA0EbMQ@mail.gmail.com>
 <CAKwvOdmWx0reabY-S3nXfTZuhs-_SP7pbb0uHyGeaNSQnm8eRQ@mail.gmail.com>
 <CA+icZUWsncyKvxPZ5g=a3ssWy=cYahsU6hprM3n=jFUmnjPC6w@mail.gmail.com>
 <CAKwvOdk4kG-_c3inNj9ry_xUU9SQE-2AqQp40YL_V=6SHU6E=Q@mail.gmail.com>
 <CA+icZUX576Rt7HJ4hvrwRTCC2pTmoH-Yu-haU+MDb8B6yADAYA@mail.gmail.com>
 <CAKwvOdmq=L_ob-WpNBE-fSc3oYXT10ZvttfiXiZw3+SxaWWy-A@mail.gmail.com> <CA+icZUXMxM4CuNa0P+JFJO7LSj6QvJneArYXpqLRJrzqJMYj6g@mail.gmail.com>
In-Reply-To: <CA+icZUXMxM4CuNa0P+JFJO7LSj6QvJneArYXpqLRJrzqJMYj6g@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 3 Feb 2021 16:56:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR0jHV9gdCT7-e0njtEjxpuADkAttYAxOT6N-sNUiuV+w@mail.gmail.com>
Message-ID: <CAK7LNAR0jHV9gdCT7-e0njtEjxpuADkAttYAxOT6N-sNUiuV+w@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] Kbuild: implement support for DWARF v5
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
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

On Sat, Jan 30, 2021 at 7:42 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Jan 29, 2021 at 11:31 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Fri, Jan 29, 2021 at 2:23 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > On Fri, Jan 29, 2021 at 11:21 PM Nick Desaulniers
> > > <ndesaulniers@google.com> wrote:
> > > >
> > > > On Fri, Jan 29, 2021 at 2:11 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > >
> > > > > On Fri, Jan 29, 2021 at 11:09 PM Nick Desaulniers
> > > > > <ndesaulniers@google.com> wrote:
> > > > > >
> > > > > > On Fri, Jan 29, 2021 at 1:20 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > > > >
> > > > > > > On Fri, Jan 29, 2021 at 10:13 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, Jan 29, 2021 at 10:09 PM Nick Desaulniers
> > > > > > > > <ndesaulniers@google.com> wrote:
> > > > > > > > >
> > > > > > > > > Can you tell me please what is the precise command line invocation of
> > > > > > > > > make and which source file you observed this on so that I can
> > > > > > > > > reproduce?
> > > > > >
> > > > > > If you don't send me your invocation of `make`, I cannot help you.
> > > > > >
> > > > >
> > > > > /usr/bin/perf_5.10 stat make V=1 -j4 LLVM=1 LLVM_IAS=1
> > > > > PAHOLE=/opt/pahole/bin/pahole LOCALVERSION=-10-amd64-clang12
> > > > > -lto-pgo KBUILD_VERBOSE=1 KBUILD_BUILD_HOST=iniza
> > > > > KBUILD_BUILD_USER=sedat.dilek@gmail.com
> > > > > KBUILD_BUILD_TIMESTAMP=2021-01-29 bindeb-pkg
> > > > > KDEB_PKGVERSION=5.11.0~rc5-10~bullseye+dileks1
> > > >
> > > > $ make LLVM=1 LLVM_IAS=1 -j72 defconfig
> > > > $ make LLVM=1 LLVM_IAS=1 -j72 menuconfig
> > > > <enable CONFIG_DEBUG_INFO and CONFIG_DEBUG_INFO_DWARF5>
> > > > $ make LLVM=1 LLVM_IAS=1 -j72 V=1 &> log.txt
> > > > $ grep '\-g -gdwarf-5 -g -gdwarf-5' log.txt | wc -l
> > > > 0
> > > > $ grep '\-g -gdwarf-5' log.txt | wc -l
> > > > 2517
> > > >
> > > > Do have the patch applied twice, perhaps?
> > > >
> > >
> > > Switched to my v6 local Git branch and invoked above make line I gave you.
> > > I still see that double.
> > > Looks like I need some "undrunken" switch.
> >
> > Can you follow my steps precisely to see whether it's your .config?
> > Perhaps there is a config that duplicates DEBUG_CFLAGS that is not set
> > in the defconfig?  If so, it's still harmless to specify the same
> > commands twice, and likely isn't introduced by this patch set if so;
> > so I'm not sure how much more effort is worth pursuing.
> >
>
> If I follow your steps of make I do not see it "double" (in my local
> v6 Git branch).
>
> Looks like this is coming from my build-script.
>
> I checked if I have some double dwarf(-5) patches double - Nope.


Sorry for the late reply.

I do not know which command you input,
but this happens for deb-pkg builds for example.

Please try this patch:
https://lore.kernel.org/patchwork/patch/1374926/








--
Best Regards
Masahiro Yamada
