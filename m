Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F110430903B
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 23:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhA2WnH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 17:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbhA2WnF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 17:43:05 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76411C061573;
        Fri, 29 Jan 2021 14:42:25 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id q5so9966250ilc.10;
        Fri, 29 Jan 2021 14:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=dfELtoaA8bJe8gY3p6rcM2hsQagvy8a4lKjq9ZDDe0Y=;
        b=ZWdBUn0L8q974/jQtHoTjF2FOnB9H2ea+Of79l4Cwc+L48t3CFKo+yBwNQjlQdOAp4
         7kwTpZojbfSFKHDQYnk/Eh/dNz8V1QlDQZs7AY7fqSx0VyRgjCPsMfk5U0MdzvitMaRP
         Iec1fx9A0RtJv++nfsnRZRo/ctFD5BQlW+6FTlmD9o1GZcKrNalod3dT6m1e5MMmeO3+
         6tiP0oQQZyGQyDfL9hh4NUwF/uJEFMkd1EwJF6qqhk0dETqoS8t8fEt6pNWeydmhii7d
         p0dd4RFqHUWLfwXUQYrROs3vPlC0v4rC8UBW/pQXCzbgIPvag2jGQLy+kyzDuEQXBHsT
         5HWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=dfELtoaA8bJe8gY3p6rcM2hsQagvy8a4lKjq9ZDDe0Y=;
        b=IeWtBA856CWsK6t/2uaforQvFPAc0FynUJ8ouWXSvqHP6+CBsgtGAR6er9Yg32N4yy
         LzBHGCwRuzIEyx2aFsAwSD/1rkeAOVikKJcCAWEWbabDfI90F/1/9Ltpr2GHykVYxCLk
         vHoXroI7ErHyY85GbLWBBc0+pDlemUsD5GsnE45Pdd4g3+1NB4WvWA2won9Jd+wpVYj8
         9dZJfOoQ8eL26wMwbWo08ha5wXSG3EHF6EDhHTlnME46PAgqFpCZSARczpAjnx7lXW5r
         ketJQnoiPxMKlaqsq6anFC3ejWrjpcc4UBtFdzWuyrhzJJdUbMD/6pOqj1aZSgZ5oIBw
         eVvA==
X-Gm-Message-State: AOAM531dAhKNH35b0z9yAtMlyuhS/AJGVmZqxekWeM7ZUPmVNx0ukr4M
        /yytK79qlApLaOeX2udEihnAm9uFl9D2dLoJ10w=
X-Google-Smtp-Source: ABdhPJw8ZFwX9lpZyuCNKTyghsn0YtjIV+68LNJUYEJSSClDTHmrgKCqpYI4iUkFxEQ8W0YsUm1Fg+hV37WolQ5pM+E=
X-Received: by 2002:a92:c80b:: with SMTP id v11mr4673883iln.215.1611960144907;
 Fri, 29 Jan 2021 14:42:24 -0800 (PST)
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
 <CA+icZUX576Rt7HJ4hvrwRTCC2pTmoH-Yu-haU+MDb8B6yADAYA@mail.gmail.com> <CAKwvOdmq=L_ob-WpNBE-fSc3oYXT10ZvttfiXiZw3+SxaWWy-A@mail.gmail.com>
In-Reply-To: <CAKwvOdmq=L_ob-WpNBE-fSc3oYXT10ZvttfiXiZw3+SxaWWy-A@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 29 Jan 2021 23:42:13 +0100
Message-ID: <CA+icZUXMxM4CuNa0P+JFJO7LSj6QvJneArYXpqLRJrzqJMYj6g@mail.gmail.com>
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

On Fri, Jan 29, 2021 at 11:31 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Jan 29, 2021 at 2:23 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Fri, Jan 29, 2021 at 11:21 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Fri, Jan 29, 2021 at 2:11 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > >
> > > > On Fri, Jan 29, 2021 at 11:09 PM Nick Desaulniers
> > > > <ndesaulniers@google.com> wrote:
> > > > >
> > > > > On Fri, Jan 29, 2021 at 1:20 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Jan 29, 2021 at 10:13 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > > > >
> > > > > > > On Fri, Jan 29, 2021 at 10:09 PM Nick Desaulniers
> > > > > > > <ndesaulniers@google.com> wrote:
> > > > > > > >
> > > > > > > > Can you tell me please what is the precise command line invocation of
> > > > > > > > make and which source file you observed this on so that I can
> > > > > > > > reproduce?
> > > > >
> > > > > If you don't send me your invocation of `make`, I cannot help you.
> > > > >
> > > >
> > > > /usr/bin/perf_5.10 stat make V=1 -j4 LLVM=1 LLVM_IAS=1
> > > > PAHOLE=/opt/pahole/bin/pahole LOCALVERSION=-10-amd64-clang12
> > > > -lto-pgo KBUILD_VERBOSE=1 KBUILD_BUILD_HOST=iniza
> > > > KBUILD_BUILD_USER=sedat.dilek@gmail.com
> > > > KBUILD_BUILD_TIMESTAMP=2021-01-29 bindeb-pkg
> > > > KDEB_PKGVERSION=5.11.0~rc5-10~bullseye+dileks1
> > >
> > > $ make LLVM=1 LLVM_IAS=1 -j72 defconfig
> > > $ make LLVM=1 LLVM_IAS=1 -j72 menuconfig
> > > <enable CONFIG_DEBUG_INFO and CONFIG_DEBUG_INFO_DWARF5>
> > > $ make LLVM=1 LLVM_IAS=1 -j72 V=1 &> log.txt
> > > $ grep '\-g -gdwarf-5 -g -gdwarf-5' log.txt | wc -l
> > > 0
> > > $ grep '\-g -gdwarf-5' log.txt | wc -l
> > > 2517
> > >
> > > Do have the patch applied twice, perhaps?
> > >
> >
> > Switched to my v6 local Git branch and invoked above make line I gave you.
> > I still see that double.
> > Looks like I need some "undrunken" switch.
>
> Can you follow my steps precisely to see whether it's your .config?
> Perhaps there is a config that duplicates DEBUG_CFLAGS that is not set
> in the defconfig?  If so, it's still harmless to specify the same
> commands twice, and likely isn't introduced by this patch set if so;
> so I'm not sure how much more effort is worth pursuing.
>

If I follow your steps of make I do not see it "double" (in my local
v6 Git branch).

Looks like this is coming from my build-script.

I checked if I have some double dwarf(-5) patches double - Nope.

- Sedat -
