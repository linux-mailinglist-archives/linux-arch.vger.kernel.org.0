Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0528F30E755
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 00:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbhBCX23 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 18:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbhBCX22 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2021 18:28:28 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16C1C0613ED
        for <linux-arch@vger.kernel.org>; Wed,  3 Feb 2021 15:27:47 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b17so720586plz.6
        for <linux-arch@vger.kernel.org>; Wed, 03 Feb 2021 15:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+eX+hFOL+CzxhxR9XSBHmfjn0y1EEXuMNIwlju1/yaQ=;
        b=GCIJY1mPpwom81hK+0og/pl+ty+bruNLoSFs6eBbr/UK3w1EV+KchotabN4dUoX5JV
         nqRtBEHnCYnWmTl5C4dLUFJOU+8RWIk1Enm5mSbSkKkKikUOc+ZSeaGMtY6DUjz5CvMM
         Jzk864oLOyfKp6vxnCQelH7zCrng3H0uf1S1JvGcXHo41Lfc/Pqv86EqXL54RSBXORyQ
         LZYoNQvPYaPN0WPstjOsfbUM3ONnBPr9cNWDDzHjl5ugnWPu+OCumNNfW0ZeOsJKmu2m
         o3JTzR75HY1DZWWcTSfByb5JfxcdwhkOdQZhPjfEH63BOdHWvg2/ExuSMjSJLozXfTUY
         lagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+eX+hFOL+CzxhxR9XSBHmfjn0y1EEXuMNIwlju1/yaQ=;
        b=jbqHRk9x/OPNiKHHwTLx5VFOp03Dw/Ai5ninMOF9MLo2gbKaCRF//uvbTMyuZtGLxR
         88+5qlBk3+BzwYn8XRTjA7KXQqgn17oNksgUqqDM9v9KJY3DQ9LqMWn3DO4OtHmeGoNz
         Ga7vSLOt1XxztsMs9zAe60v7Dlf/3yO02iST1z4PcuMmxwzAXAnuL+Iz+FvKXMpopI0W
         1PTjIpTX03Zd5q7xqr07s3sNLp3Ry5I4nzKKKyiwdx60AhYCuZgHC5zh1OCelEUBSSgj
         ofANg85R2Q05J1G2/rdUg+azPA3IGsy9V63Xv+ktMesGDZfXB8SWrd5Cr9E5A5GEtwS4
         4SoQ==
X-Gm-Message-State: AOAM531MY3hASALm02ObEJdiVEjTZmgjmUaYzoSvxWePL7k3r3DnPNc0
        ua5Fmkq10hXZYM6MplzTroJV+1udnOfc3BZs8tTkCw==
X-Google-Smtp-Source: ABdhPJwOowM66m5rTohXOgCIMzAFO+95LzXmMwz6a7J1M5NbrhheXFjbFn2owXNZjmbpvejVR+BC/bm9wzJF0FGlwUo=
X-Received: by 2002:a17:90a:db05:: with SMTP id g5mr5573673pjv.32.1612394867235;
 Wed, 03 Feb 2021 15:27:47 -0800 (PST)
MIME-Version: 1.0
References: <20210130004401.2528717-1-ndesaulniers@google.com>
 <20210130004401.2528717-3-ndesaulniers@google.com> <CAK7LNAQW3XtBGAg6u+86wGc0tizDyezZ_f61JjkT15QH5BtGjA@mail.gmail.com>
In-Reply-To: <CAK7LNAQW3XtBGAg6u+86wGc0tizDyezZ_f61JjkT15QH5BtGjA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 3 Feb 2021 15:27:34 -0800
Message-ID: <CAKwvOdnFQ+Y+QzHLVs-XNFtbNL8s236x6zS3QAkQ-unPvhbfEA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] Kbuild: implement support for DWARF v5
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Clifton <nickc@redhat.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
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

On Wed, Feb 3, 2021 at 3:07 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Nick, the patch set is getting simpler and simpler,
> and almost good enough to be merged.

I agree.  I think Sedat pointed out a binutils 2.35.2 release; thanks
to Nick Clifton for that.

>
>
> Please let me ask two questions below.
>
> There has been a lot of discussion, and
> I might have missed the context.
>
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -268,6 +268,24 @@ config DEBUG_INFO_DWARF4
> >           It makes the debug information larger, but it significantly
> >           improves the success of resolving variables in gdb on optimized code.
> >
> > +config DEBUG_INFO_DWARF5
> > +       bool "Generate DWARF Version 5 debuginfo"
> > +       depends on GCC_VERSION >= 50000 || CC_IS_CLANG
> > +       depends on CC_IS_GCC || $(success,$(srctree)/scripts/test_dwarf5_support.sh $(CC) $(CLANG_FLAGS))
>
> Q1.
>
> This  "CC_IS_GCC ||" was introduced by v4.
>
> GCC never outputs '.file 0', which is why
> this test is only needed for Clang, correct?

This test script is only needed when compiling with clang but without
its integrated assembler.  It checks that when clang is used as the
driver, but GAS is used as the assembler, that GAS will be able to
decode the DWARF v5 assembler additions Clang will produce without
needing an explicit -Wa,-gdwarf-5 flag passed.

Technically, it is unnecessary for `LLVM=1 LLVM_IAS=1` or `CC=clang
LLVM_IAS=1` (ie. clang+clang's integrated assembler).  But there is no
way to express AS_IS_IAS today in KConfig (similar to
CC_IS_{GCC|CLANG} or LD_IS_LLD).  I don't think that's necessary;
whether or not clang's integrated assembler is used, when using clang,
run the simple check.

> > --- /dev/null
> > +++ b/scripts/test_dwarf5_support.sh
> > @@ -0,0 +1,8 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +# Test that the assembler doesn't need -Wa,-gdwarf-5 when presented with DWARF
> > +# v5 input, such as `.file 0` and `md5 0x00`. Should be fixed in GNU binutils
> > +# 2.35.2. https://sourceware.org/bugzilla/show_bug.cgi?id=25611
>
>
> I saw the following links in v6.
>
> https://sourceware.org/bugzilla/show_bug.cgi?id=25612
> https://sourceware.org/bugzilla/show_bug.cgi?id=25614
>
> They were dropped in v7. Why?
>
> I just thought they were good to know...

While having fixes for those bugs is required, technically
https://sourceware.org/bugzilla/show_bug.cgi?id=25611 is the latest
bug which was fixed.  Testing for a fix of
https://sourceware.org/bugzilla/show_bug.cgi?id=25611 implies that
fixes for 25612 and 25614 exist due to the order they were fixed in
GAS.  Technically, you could argue that this script is quite GAS
centric; given an arbitrary "assembler" the test should check a few
things.  Realistically, I think that's overkill based on what
assemblers are in use today; we can always grow the script should we
identify other tests additional assemblers may need to pass, but until
then, I suspect YAGNI.  Maybe there's a more precise name for the
script to reflect that, but that gets close to "what color shall we
paint the bikeshed?"  Given the number of folks on the thread, plz no.
-- 
Thanks,
~Nick Desaulniers
