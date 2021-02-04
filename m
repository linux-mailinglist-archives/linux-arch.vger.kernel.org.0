Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A491530E895
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 01:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbhBDAfZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 19:35:25 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:29965 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbhBDAfY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2021 19:35:24 -0500
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 1140YJ9T001787;
        Thu, 4 Feb 2021 09:34:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 1140YJ9T001787
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1612398860;
        bh=YGqVi6q3wSmO46URzjWMbuYfJm4vGpRTzcS+y7ksq/s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KybUlGs9/rM0U6OILw77xgbdbxKWyEf3qd7Hz+DY1w4vjsbdSJ6MBHRKU0cpO+ps4
         k5HtF1Iw+KP2rjDl6NWElK0YYKu754vaH0UWDmXUuq56YqI3lmRkAvpwt3J5hfvIlM
         AmGECmQT1ytFQQtxvClLm0bzl+6Fp24nhK+XfHro/2tbvgBcrEymC3qDBhJ/Qq7/3y
         3ambKjdrB4Nj3W6QBLi7CUcmFDEQCklP+JdzktZ0jTN+WDk7G+60HMoW+/owVwMtHL
         hHmKQGTAkLjeYouqlMHpDjpED5QoZqDiMFbJiBomJiV1WVMXzwFi44GtzUdcGfx63B
         o7otA9jdBujhw==
X-Nifty-SrcIP: [209.85.215.170]
Received: by mail-pg1-f170.google.com with SMTP id n10so912422pgl.10;
        Wed, 03 Feb 2021 16:34:19 -0800 (PST)
X-Gm-Message-State: AOAM532Vqw22uGLdGsosD1Us2Agtaplr+iDn8x7aEUXCenghkLSGgm+e
        XPieBps+xDeWC9bTuR5MFAT8uj/p4in5HitcaNU=
X-Google-Smtp-Source: ABdhPJz4t9naYuY+vi3PEb2skxTd/puVe252BsmS52Pl6DwHwISf7CWu1OEvd870/ktCX8PKE+PqT6VrghxOPPirMeI=
X-Received: by 2002:aa7:8602:0:b029:1bb:4dfd:92fc with SMTP id
 p2-20020aa786020000b02901bb4dfd92fcmr5544836pfn.63.1612398859091; Wed, 03 Feb
 2021 16:34:19 -0800 (PST)
MIME-Version: 1.0
References: <20210130004401.2528717-1-ndesaulniers@google.com>
 <20210130004401.2528717-3-ndesaulniers@google.com> <CAK7LNAQW3XtBGAg6u+86wGc0tizDyezZ_f61JjkT15QH5BtGjA@mail.gmail.com>
 <CAKwvOdnFQ+Y+QzHLVs-XNFtbNL8s236x6zS3QAkQ-unPvhbfEA@mail.gmail.com>
In-Reply-To: <CAKwvOdnFQ+Y+QzHLVs-XNFtbNL8s236x6zS3QAkQ-unPvhbfEA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 4 Feb 2021 09:33:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNASFBaJa-P88wNNgcESMV1YyFH0QxJXb52nauSCTfAifJA@mail.gmail.com>
Message-ID: <CAK7LNASFBaJa-P88wNNgcESMV1YyFH0QxJXb52nauSCTfAifJA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] Kbuild: implement support for DWARF v5
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nick Clifton <nickc@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 4, 2021 at 8:27 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Wed, Feb 3, 2021 at 3:07 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Nick, the patch set is getting simpler and simpler,
> > and almost good enough to be merged.
>
> I agree.  I think Sedat pointed out a binutils 2.35.2 release; thanks
> to Nick Clifton for that.
>
> >
> >
> > Please let me ask two questions below.
> >
> > There has been a lot of discussion, and
> > I might have missed the context.
> >
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -268,6 +268,24 @@ config DEBUG_INFO_DWARF4
> > >           It makes the debug information larger, but it significantly
> > >           improves the success of resolving variables in gdb on optimized code.
> > >
> > > +config DEBUG_INFO_DWARF5
> > > +       bool "Generate DWARF Version 5 debuginfo"
> > > +       depends on GCC_VERSION >= 50000 || CC_IS_CLANG
> > > +       depends on CC_IS_GCC || $(success,$(srctree)/scripts/test_dwarf5_support.sh $(CC) $(CLANG_FLAGS))
> >
> > Q1.
> >
> > This  "CC_IS_GCC ||" was introduced by v4.
> >
> > GCC never outputs '.file 0', which is why
> > this test is only needed for Clang, correct?
>
> This test script is only needed when compiling with clang but without
> its integrated assembler.  It checks that when clang is used as the
> driver, but GAS is used as the assembler, that GAS will be able to
> decode the DWARF v5 assembler additions Clang will produce without
> needing an explicit -Wa,-gdwarf-5 flag passed.
>
> Technically, it is unnecessary for `LLVM=1 LLVM_IAS=1` or `CC=clang
> LLVM_IAS=1` (ie. clang+clang's integrated assembler).  But there is no
> way to express AS_IS_IAS today in KConfig (similar to
> CC_IS_{GCC|CLANG} or LD_IS_LLD).  I don't think that's necessary;
> whether or not clang's integrated assembler is used, when using clang,
> run the simple check.
>
> > > --- /dev/null
> > > +++ b/scripts/test_dwarf5_support.sh
> > > @@ -0,0 +1,8 @@
> > > +#!/bin/sh
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +
> > > +# Test that the assembler doesn't need -Wa,-gdwarf-5 when presented with DWARF
> > > +# v5 input, such as `.file 0` and `md5 0x00`. Should be fixed in GNU binutils
> > > +# 2.35.2. https://sourceware.org/bugzilla/show_bug.cgi?id=25611
> >
> >
> > I saw the following links in v6.
> >
> > https://sourceware.org/bugzilla/show_bug.cgi?id=25612
> > https://sourceware.org/bugzilla/show_bug.cgi?id=25614
> >
> > They were dropped in v7. Why?
> >
> > I just thought they were good to know...
>
> While having fixes for those bugs is required, technically
> https://sourceware.org/bugzilla/show_bug.cgi?id=25611 is the latest
> bug which was fixed.  Testing for a fix of
> https://sourceware.org/bugzilla/show_bug.cgi?id=25611 implies that
> fixes for 25612 and 25614 exist due to the order they were fixed in
> GAS.


It is difficult to know the patch order in the binutils project.

Personally, I prefer having all the three references here.
Otherwise, it is difficult to understand why
this script is doing such complex checks.





> Technically, you could argue that this script is quite GAS
> centric; given an arbitrary "assembler" the test should check a few
> things.  Realistically, I think that's overkill based on what
> assemblers are in use today; we can always grow the script should we
> identify other tests additional assemblers may need to pass, but until
> then, I suspect YAGNI.  Maybe there's a more precise name for the
> script to reflect that, but that gets close to "what color shall we
> paint the bikeshed?"  Given the number of folks on the thread, plz no.


No argument with this regard. I agree with you.




> --
> Thanks,
> ~Nick Desaulniers



-- 
Best Regards
Masahiro Yamada
