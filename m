Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C977630901F
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 23:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbhA2WcG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 17:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbhA2Wbw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 17:31:52 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC79C06174A
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 14:31:12 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id d2so1102793pjs.4
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 14:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mEuUNTLPjyCKU+1m6bFPUEO4cIWG2fR+kA7IEzmsiA0=;
        b=MXQ3szzyutAJwpx9freM5P5nZtBdbzPRo9DqX45Y+eAKATqPcrdQ8wG5Cl5YJ/rm/D
         X2E4zfRQqwpyQuRxesyxK6FL/smz/4zcdNBQ88GzDjV8VW2ci5WrKiKdTxCYWYA7+o2B
         2P9y/wRdwIglbjUpEVC3bLxRXlzvalIG8Mc58ABIuLGso/xNT1XiFDiN4Y2YQ3zPDT4b
         8+gzTn7RmCMg+xftHFBOifOW5zsiX7BLXZ42olQ1a5itnwUl2dEggiBQkgugVgGLEBgW
         1Mymw9wHEVVblcehWi40xNb3k8GqVDiLpO2ABVf9WcYBaby+4QY45RsdK9JjTPnJzOiE
         dLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mEuUNTLPjyCKU+1m6bFPUEO4cIWG2fR+kA7IEzmsiA0=;
        b=UwkOnLyo9CBiNZXHTYudLPBQmWjJE/XhtWU9a1hAmLXvHbYuBsHPDEKR0tJZl4WJWL
         bWkVcTKeASRKN5FI8PAZLTiiZfHF1DzpEcX4Ohv0fCE+jFV6KnWjx3NTC4A6GEVfWly0
         avJeJVFGvNLuhXK9JAX+8y7aRL5XQhW53ubE2eP072OkJ0UzqECMIVYT0b8tkU96rofQ
         gFHVVmyYTD97nCGDRMCtia13BmYWlDJ1ZIdaGBBBQu/Pcu/tJvfVYh2lhpaY+kO8Sb69
         NAIVTUHpYQ6ZQdcXZEDNRXB+eWPg2lx9iUQmTy54MCwjrkNBz+Qlk7tnQspn74iILb7J
         cOCw==
X-Gm-Message-State: AOAM531R2LtM7Jd6SHLNmfEiKQJ4b/WLSJRNYbAcYgdm3HHDF/sOV+kM
        cDgiUodlvgmkp1/0EOO9+AUGSVLTa391NHK2olGmCA==
X-Google-Smtp-Source: ABdhPJwZsd7PybQkVmrkiSQDc4U0xVvSfLsYOJxZuikVsd6WthzvrApfmvev2Zuw72TEGqzKpkNH/e4Nv7e7QE9S2ow=
X-Received: by 2002:a17:90a:8b82:: with SMTP id z2mr6462674pjn.25.1611959471740;
 Fri, 29 Jan 2021 14:31:11 -0800 (PST)
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
 <CAKwvOdk4kG-_c3inNj9ry_xUU9SQE-2AqQp40YL_V=6SHU6E=Q@mail.gmail.com> <CA+icZUX576Rt7HJ4hvrwRTCC2pTmoH-Yu-haU+MDb8B6yADAYA@mail.gmail.com>
In-Reply-To: <CA+icZUX576Rt7HJ4hvrwRTCC2pTmoH-Yu-haU+MDb8B6yADAYA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 29 Jan 2021 14:31:01 -0800
Message-ID: <CAKwvOdmq=L_ob-WpNBE-fSc3oYXT10ZvttfiXiZw3+SxaWWy-A@mail.gmail.com>
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

On Fri, Jan 29, 2021 at 2:23 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Jan 29, 2021 at 11:21 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Fri, Jan 29, 2021 at 2:11 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > On Fri, Jan 29, 2021 at 11:09 PM Nick Desaulniers
> > > <ndesaulniers@google.com> wrote:
> > > >
> > > > On Fri, Jan 29, 2021 at 1:20 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > >
> > > > > On Fri, Jan 29, 2021 at 10:13 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Jan 29, 2021 at 10:09 PM Nick Desaulniers
> > > > > > <ndesaulniers@google.com> wrote:
> > > > > > >
> > > > > > > Can you tell me please what is the precise command line invocation of
> > > > > > > make and which source file you observed this on so that I can
> > > > > > > reproduce?
> > > >
> > > > If you don't send me your invocation of `make`, I cannot help you.
> > > >
> > >
> > > /usr/bin/perf_5.10 stat make V=1 -j4 LLVM=1 LLVM_IAS=1
> > > PAHOLE=/opt/pahole/bin/pahole LOCALVERSION=-10-amd64-clang12
> > > -lto-pgo KBUILD_VERBOSE=1 KBUILD_BUILD_HOST=iniza
> > > KBUILD_BUILD_USER=sedat.dilek@gmail.com
> > > KBUILD_BUILD_TIMESTAMP=2021-01-29 bindeb-pkg
> > > KDEB_PKGVERSION=5.11.0~rc5-10~bullseye+dileks1
> >
> > $ make LLVM=1 LLVM_IAS=1 -j72 defconfig
> > $ make LLVM=1 LLVM_IAS=1 -j72 menuconfig
> > <enable CONFIG_DEBUG_INFO and CONFIG_DEBUG_INFO_DWARF5>
> > $ make LLVM=1 LLVM_IAS=1 -j72 V=1 &> log.txt
> > $ grep '\-g -gdwarf-5 -g -gdwarf-5' log.txt | wc -l
> > 0
> > $ grep '\-g -gdwarf-5' log.txt | wc -l
> > 2517
> >
> > Do have the patch applied twice, perhaps?
> >
>
> Switched to my v6 local Git branch and invoked above make line I gave you.
> I still see that double.
> Looks like I need some "undrunken" switch.

Can you follow my steps precisely to see whether it's your .config?
Perhaps there is a config that duplicates DEBUG_CFLAGS that is not set
in the defconfig?  If so, it's still harmless to specify the same
commands twice, and likely isn't introduced by this patch set if so;
so I'm not sure how much more effort is worth pursuing.
-- 
Thanks,
~Nick Desaulniers
