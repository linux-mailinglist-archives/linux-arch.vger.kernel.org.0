Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839FA21F16C
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jul 2020 14:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgGNMgI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jul 2020 08:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgGNMgI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2020 08:36:08 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519CFC061755;
        Tue, 14 Jul 2020 05:36:08 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id e64so17063436iof.12;
        Tue, 14 Jul 2020 05:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Gb+Q70LB3bQ72JL0eSnIdekJKUYUeTWGONZ+6Nqwogo=;
        b=exjA6lvAWxUvf1Td2gq98AcVXUNkO3OPeywwuYDfsL+Z0YPJPbs2u85bRho4FdyAYG
         h1Me90Y/Xi9mrbBb8IaCwjCCtYe0iU8Kdh8gvx4lPvw3ww0BSuQCAaIggiGzNrJ/rvTH
         NUMDgXk2hTiz164UVDp0X/EMe5UZSZk9rzOG8RZLS92wGG7i2sWIFctBkIViYipOQgok
         xcfHbLR2UQt/A0WzfMGMQVUKm26Utu92kngSJt91ObuRmBmWkKww8U1+XQaxchUIoULg
         LETQQruiS74VAz/QrOz41g7p3HeSVdiEqjGWDHkLxWa7roAfEPM+hfKFIBuOgsfaV0cy
         L0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Gb+Q70LB3bQ72JL0eSnIdekJKUYUeTWGONZ+6Nqwogo=;
        b=RrEsTEE91Wa5ahkqfMec8OOktXXg9tpa7vfbpZfvPrtgaOiXTVTN3lHjYDhP+D+/gs
         PLvxwhL5vgnOmtHLDr+ij1bmS0m2FYfPO3K/LEe2xwkJx6f9D9vqLT7tPncNJE6ucaGk
         HB3gJMWAPDByjayaTvAcviDUKJF83bSJsPiO4F0W8d7LFja/nITv5inugh2s2BEFhQq+
         /JCdaoASDY5LQFFxueP+2yAe/hwam1d1m34OT3GT26a+l1oiNqUrSMNOFhH50KWxo9w3
         YIbERlv7jWfMKelNhKSOWpJZDaPV2HSJwbXRnA0MdHxE5va9F6RKoGVHcmvpHZEcKcz/
         eCZA==
X-Gm-Message-State: AOAM530+7GaOsg7gTlQ6o73+pA6GTpfoKEHHuoJrRuX9tJoKGeEwadnH
        VuJRaOLpWyxWgLg4ukGKE7IIKFyMQPO3sKMyhTuR6t7b14E=
X-Google-Smtp-Source: ABdhPJy08S8ez9XwftwQn5CP8eSR816kqqnMmTFnXtvq9GDL8Kyd4FJY0vpVR/06YozpswqRqTbLAb4BcgAV34vv4aM=
X-Received: by 2002:a5e:9309:: with SMTP id k9mr4608670iom.135.1594730166218;
 Tue, 14 Jul 2020 05:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
 <671d8923-ed43-4600-2628-33ae7cb82ccb@molgen.mpg.de> <CABCJKuedpxAqndgL=jHT22KtjnLkb1dsYaM6hQYyhqrWjkEe6A@mail.gmail.com>
 <2ac9e722-949b-aa92-3553-df1bf69bf9e5@molgen.mpg.de>
In-Reply-To: <2ac9e722-949b-aa92-3553-df1bf69bf9e5@molgen.mpg.de>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 Jul 2020 14:35:52 +0200
Message-ID: <CA+icZUXwLocrBNRL+1-koCW50Fm+f4_u3xzy-_eJSxyoW2VTfw@mail.gmail.com>
Subject: Re: [PATCH 00/22] add support for Clang LTO
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 14, 2020 at 2:16 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Sami,
>
>
> Am 13.07.20 um 01:34 schrieb Sami Tolvanen:
> > On Sat, Jul 11, 2020 at 9:32 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> >> Thank you very much for sending these changes.
> >>
> >> Do you have a branch, where your current work can be pulled from? Your
> >> branch on GitHub [1] seems 15 months old.
> >
> > The clang-lto branch is rebased regularly on top of Linus' tree.
> > GitHub just looks at the commit date of the last commit in the tree,
> > which isn't all that informative.
>
> Thank you for clearing this up, and sorry for not checking myself.
>
> >> Out of curiosity, I applied the changes, allowed the selection for i386
> >> (x86), and with Clang 1:11~++20200701093119+ffee8040534-1~exp1 from
> >> Debian experimental, it failed with `Invalid absolute R_386_32
> >> relocation: KERNEL_PAGES`:
> >
> > I haven't looked at getting this to work on i386, which is why we only
> > select ARCH_SUPPORTS_LTO for x86_64. I would expect there to be a few
> > issues to address.
> >
> >>>    arch/x86/tools/relocs vmlinux > arch/x86/boot/compressed/vmlinux.relocs;arch/x86/tools/relocs --abs-relocs vmlinux
> >>> Invalid absolute R_386_32 relocation: KERNEL_PAGES
> >
> > KERNEL_PAGES looks like a constant, so it's probably safe to ignore
> > the absolute relocation in tools/relocs.c.
>
> Thank you for pointing me to the right direction. I am happy to report,
> that with the diff below (no idea to what list to add the string), Linux
> 5.8-rc5 with the LLVM/Clang/LTO patches on top, builds and boots on the
> ASRock E350M1.
>
> ```
> diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> index 8f3bf34840cef..e91af127ed3c0 100644
> --- a/arch/x86/tools/relocs.c
> +++ b/arch/x86/tools/relocs.c
> @@ -79,6 +79,7 @@ static const char * const
> sym_regex_kernel[S_NSYMTYPES] = {
>          "__end_rodata_hpage_align|"
>   #endif
>          "__vvar_page|"
> +       "KERNEL_PAGES|"
>          "_end)$"
>   };
> ```
>

What llvm-toolchain and version did you use?

Can you post your linux-config?

Thanks.

- Sedat -
