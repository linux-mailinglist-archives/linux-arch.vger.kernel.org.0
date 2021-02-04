Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454E130EC62
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 07:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhBDGQx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 01:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhBDGQw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 01:16:52 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DE9C0613D6
        for <linux-arch@vger.kernel.org>; Wed,  3 Feb 2021 22:16:12 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m12so1103694pjs.4
        for <linux-arch@vger.kernel.org>; Wed, 03 Feb 2021 22:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=di4/vrEwMGMptUjaosgJOlqFm8Mgh4qA8yfsVQbfl2E=;
        b=rQhP2RFpcACY1T51YL36IYgw+bupVCBeE/H3FN65jzK8OQr58VpTE1cuvZfj3mUHpR
         4yg8DwXuY2T4X6k92CTY47xYpQXOeyU0b1lwLWHn4qr8/BFfRqGSYZOFvQ3rqHZ8M/DF
         JXYH+CihKBX+nM3UYLQRaV6e5yjCpprvQPRBczkPSr/J8HMISuJDwdBBt1J5ta3ZUzrA
         0x9tvBToknGaRwF5bHfo9/tDphs7k6BXKgr4QCaNaBY2qUcDepL5/pNVK5xG54ua7W08
         kVBnD3zlDo1hdrIbEi4PJH5Z214wS/huJzSbHCN3pbHab23GmKAZrsLFIJLpgWPcWnlV
         HrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=di4/vrEwMGMptUjaosgJOlqFm8Mgh4qA8yfsVQbfl2E=;
        b=S0+655doUeUaUq+FV9KirWQiNMmgwJa5xTQiiL+lqEgQERr26TZBgxkts6B30ypdf8
         iiC1cn1hJzhJk/Fwqag8ezx1DzeBTQc8ySOtxib0TYhqkq1+L2vk6xOTHKc100zItsxn
         BFS9lzeQGnpHgChsQh5711UjfredJRgBEapGdGUqFiDu73i9hmixLC8q/tGLQr7wb5ss
         IYB+2/RcplZ6HY7JYUAo/VcIT3fG5iux4DDNewb9BsQo8EcZETh9mtWke1TXgGYbI6OF
         oXoAo4VceiB9ZrwiQgX8Yj2FkbPioMBOFYT+1uunsTh4Yqw/MBlW4r1kOrsDibO/Th5o
         NTfQ==
X-Gm-Message-State: AOAM533pSrM8yBvUmUOMYMF4idffSSh6EiQJn31N6e7Ktoj2KMkIbTA3
        GYCsGkHAuebRJhgqC1ji0yW54GVPrwMV/2xIXZfS0w==
X-Google-Smtp-Source: ABdhPJzImdhsi8EnklTbWdz9vhMkRc7BUoTgyugH+VtVGXN33gVSlYRqsMyMJZ2jqTeyQpCwrmdF+9L16BED3qelaQY=
X-Received: by 2002:a17:90a:db05:: with SMTP id g5mr7120354pjv.32.1612419371984;
 Wed, 03 Feb 2021 22:16:11 -0800 (PST)
MIME-Version: 1.0
References: <20210130004401.2528717-1-ndesaulniers@google.com>
 <20210130004401.2528717-2-ndesaulniers@google.com> <20210130015222.GC2709570@localhost>
 <CAK7LNARfu-wqW9hfnoeeahiNPbwt4xhoWdxXtK8qjVfEi=7OOg@mail.gmail.com>
 <CAKwvOd=YVDS8tjnN6kFqe2FAhfSzVg870VsSvkNuvVZ7X6BrVg@mail.gmail.com> <CAK7LNARWpPBpT7MXeUBYO3SNcB1UtTNrTcVeFW1QXRMfBrOZHQ@mail.gmail.com>
In-Reply-To: <CAK7LNARWpPBpT7MXeUBYO3SNcB1UtTNrTcVeFW1QXRMfBrOZHQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 3 Feb 2021 22:15:59 -0800
Message-ID: <CAKwvOdmb8i=-AxnW5SB8h1KWbP7Ku24z7btaqy+DmRxRyYCsrA@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] Kbuild: make DWARF version a choice
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
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

On Wed, Feb 3, 2021 at 4:30 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Thu, Feb 4, 2021 at 8:16 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Wed, Feb 3, 2021 at 2:24 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > On Sat, Jan 30, 2021 at 10:52 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > > >
> > > > On Fri, Jan 29, 2021 at 04:44:00PM -0800, Nick Desaulniers wrote:
> > > > > Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice which is
> > > > > the default. Does so in a way that's forward compatible with existing
> > > > > configs, and makes adding future versions more straightforward.
> > > > >
> > > > > GCC since ~4.8 has defaulted to this DWARF version implicitly.
> > > > >
> > > > > Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > > > Suggested-by: Fangrui Song <maskray@google.com>
> > > > > Suggested-by: Nathan Chancellor <nathan@kernel.org>
> > > > > Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > >
> > > > One comment below:
> > > >
> > > > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > > >
> > > > > ---
> > > > >  Makefile          |  5 ++---
> > > > >  lib/Kconfig.debug | 16 +++++++++++-----
> > > > >  2 files changed, 13 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/Makefile b/Makefile
> > > > > index 95ab9856f357..d2b4980807e0 100644
> > > > > --- a/Makefile
> > > > > +++ b/Makefile
> > > > > @@ -830,9 +830,8 @@ ifneq ($(LLVM_IAS),1)
> > > > >  KBUILD_AFLAGS        += -Wa,-gdwarf-2
> > > >
> > > > It is probably worth a comment somewhere that assembly files will still
> > > > have DWARF v2.
> > >
> > > I agree.
> > > Please noting the reason will be helpful.
> >
> > Via a comment in the source, or in the commit message?
> >
> > >
> > > Could you summarize Jakub's comment in short?
> > > https://patchwork.kernel.org/project/linux-kbuild/patch/20201022012106.1875129-1-ndesaulniers@google.com/#23727667
> >
> > Via a comment in the source, or in the commit message?
>
>
> Both in the source if you can summarize it in three lines or so.
>
>
> If you need to add more detailed explanation,
> please provide it in the commit log.

This information is mostly in the commit log of patch 2.  I will
reword it with additional info from the link you sent, but I find that
such minutiae is resulting in diminishing returns on subsequent
respins of the patch series.  I implore you to reword v8 (which I will
send) as you see fit when applying the series.
-- 
Thanks,
~Nick Desaulniers
