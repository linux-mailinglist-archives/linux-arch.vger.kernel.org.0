Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA1B30FDB9
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 21:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239869AbhBDUFz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 15:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239833AbhBDUFo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 15:05:44 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5245DC061788
        for <linux-arch@vger.kernel.org>; Thu,  4 Feb 2021 12:05:04 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id fa16so1892585pjb.1
        for <linux-arch@vger.kernel.org>; Thu, 04 Feb 2021 12:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O8yTv9yXpLpwpmF6h6vJLjNPBqLU4fLmK2RwFD/j9hc=;
        b=KitKv59S0KZUVykZ6ItTKBrIPA93df0eb38/9t4KUTgKq2uh7behhmwlQVq8qfnJSe
         sjX0Q7FVpceYLH8jY8jMexr3/MRkR+ZpXmPfWn7xr/okoGAjNJ3F7qBnHkH/v3/jpMJA
         ILJUujFRQUun1191Q8JTDOst7DFbvAp4ijkK+WgvcFzTrg9nD+gVU7xLfeyLbXovNF1A
         D9wx5Gy9BqcYOR+f5CHDDjq53WflJalYd6p0KVsotSm954Bf+9EpWosWGcJDXFgjrW8J
         L3u5U86qLj2M4UPNDF2lHcni4iom+j8Uyu5y6PnOSDo1y9dJjzW2oPUc18ATk7WMRwY6
         9jGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O8yTv9yXpLpwpmF6h6vJLjNPBqLU4fLmK2RwFD/j9hc=;
        b=rDLgTphpKHimP5ayvD5iSdvkAMtVJnPxZUPogYDi+yiTMh7mAo/6HPoxrpjp5pnmQD
         XlpmTPwUaelXlxKVUlSHsbzJcj7TJePWv7t9wOqTFMpYAYEVT1Hj/kGd/tUEq90+Jw2Q
         ulb6Qed1C7JAc9ZbRWUNy8DCNNwqRhiTTsSS3B0gDqfMkYjmik1nbVQ42TCP4thksVAs
         UV0epjAZQebid8OqL+nWVQ6al+RPJuQ9FizmsTGjLfYYtfVYOai4aTA1FO9SyGJY3TX9
         zTAkRZi5E16dooNc88vS8c4jxBSUfHuMn5nvmgvb2ROnh7kGCVFvLs5cATce/9Fj9eJg
         rKHA==
X-Gm-Message-State: AOAM530UFcSnuTvUlnEEc6mwqjVr/Sj0lgqkryo69gUM9jHCrXLFIteb
        ergxokPKP5mj80iE61YYOyNPitbVoxFVZxGNfUsd6A==
X-Google-Smtp-Source: ABdhPJymonr564jWd60HeZPzi21O7agS59fEjGXM1aY4oS+3LPBPNbmofim316VEKfxahSGaLOFhWZ9LbIytWGjWiWc=
X-Received: by 2002:a17:90a:bf10:: with SMTP id c16mr595707pjs.101.1612469103596;
 Thu, 04 Feb 2021 12:05:03 -0800 (PST)
MIME-Version: 1.0
References: <20210130004401.2528717-1-ndesaulniers@google.com>
 <20210130004401.2528717-2-ndesaulniers@google.com> <20210204103946.GA14802@wildebeest.org>
 <CAKwvOdm0O8m_+mxy7Z91Lu=Hzf6-DyCdAjMOsCRiMmNis4Pd2A@mail.gmail.com> <20fdd20fe067dba00b349407c4a0128c97c1a707.camel@klomp.org>
In-Reply-To: <20fdd20fe067dba00b349407c4a0128c97c1a707.camel@klomp.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 4 Feb 2021 12:04:51 -0800
Message-ID: <CAKwvOdmT4t==akMN7eHWgD_XdpN--PLpUj8vgujGJ4TpREvteQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] Kbuild: make DWARF version a choice
To:     Mark Wielaard <mark@klomp.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
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
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 4, 2021 at 11:56 AM Mark Wielaard <mark@klomp.org> wrote:
>
> On Thu, 2021-02-04 at 11:18 -0800, Nick Desaulniers wrote:
> > On Thu, Feb 4, 2021 at 2:41 AM Mark Wielaard <mark@klomp.org> wrote:
> > > On Fri, Jan 29, 2021 at 04:44:00PM -0800, Nick Desaulniers wrote:
> > > > Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice which is
> > > > the default. Does so in a way that's forward compatible with existing
> > > > configs, and makes adding future versions more straightforward.
> > > >
> > > > GCC since ~4.8 has defaulted to this DWARF version implicitly.
> > >
> > > And since GCC 11 it defaults to DWARF version 5.
> > >
> > > It would be better to set the default to the DWARF version that the
> > > compiler generates. So if the user doesn't select any version then it
> > > should default to just -g (or -gdwarf).
> >
> > I disagree.
> >
> > https://lore.kernel.org/lkml/CAKwvOdk0zxewEOaFuqK0aSMz3vKNzDOgmez=-Dae4+bodsSg5w@mail.gmail.com/
> > """
> > I agree that this patch takes away the compiler vendor's choice as to
> > what the implicit default choice is for dwarf version for the kernel.
> > (We, the Linux kernel, do so already for implicit default -std=gnuc*
> > as well). ...
> > But I'm
> > going to suggest we follow the Zen of Python: explicit is better than
> > implicit.
> > """
> > We have a number of in tree and out of tree DWARF consumers that
> > aren't ready for DWARF v5.  Kernel developers need a way to disable
> > DWARF v5 until their dependencies are deployed or more widely
> > available.
>
> I agree with Jakub. Now that GCC has defaulted to DWARF5 all the tools
> have adopted to the new default version. And DWARF5 has been out for

"all of the tools" ?

> more than 4 years already. It isn't unreasonable to assume that people
> using GCC11 will also be using the rest of the toolchain that has moved
> on. Which DWARF consumers are you concerned about not being ready for
> GCC defaulting to DWARF5 once GCC11 is released?

Folks who don't have top of tree pahole or binutils are the two that
come to mind.  I don't have specifics on out of tree consumers, but
some Aarch64 extensions which had some changes to DWARF for ARMv8.3
PAC support broke some debuggers.

I don't doubt a lot of work has gone into fixing many downstream
projects and then when building everything from ToT that there are no
issues with DWARF v5.  The issue is getting upgrades into developers
hands, and what to default to until then.
-- 
Thanks,
~Nick Desaulniers
