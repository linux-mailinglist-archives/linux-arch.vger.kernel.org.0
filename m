Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF563119C8
	for <lists+linux-arch@lfdr.de>; Sat,  6 Feb 2021 04:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhBFDTJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Feb 2021 22:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbhBFCpo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Feb 2021 21:45:44 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74628C08EE13
        for <linux-arch@vger.kernel.org>; Fri,  5 Feb 2021 16:03:13 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id q12so12423684lfo.12
        for <linux-arch@vger.kernel.org>; Fri, 05 Feb 2021 16:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NWPbrqSGD6rR+HAkD4dteJHXvU5H2qHvAqzNOoE/AX4=;
        b=Q9wbjEdeHc4TeNxJ/V+vcdkXrft7Hdvxxn+SIjZxu8PZsrwK5feK1ppXy1XqnE28Ro
         D4ok3CLhopKZbW5fYvBwYj1OZxnIx1dNO+j/IUzx9eM1ch5hzGzmxEydedxC76cWDlf8
         vavb1T9si/T+EQjB+UhwvM+HTrxgBeGiY4jchmvvqyRbZ7E1tkbi4bGuJI010NTymG1W
         KmVVl1eMaq4TdUrh/rsBFGcVys2kY3z/YQiM0T97plSvPSfTXUzx6jFYonOe57z75kmY
         mapTq2Rquh3dM65g/II/UgJxQnA238NhsBg8vg+nUry3YhUuPw3/eRvpW50is8E+69vI
         Ey4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NWPbrqSGD6rR+HAkD4dteJHXvU5H2qHvAqzNOoE/AX4=;
        b=FT9u5PjXLsY8X9JbvAe7tbnkSHaSzP1urfgX0Id1faAXkUuu8vrh7OOlZDZi329lWT
         ZPXC2UeATPiKkhr1vkhGYdGqP3VqSqcuCQ1KhJM7xBJiKZUmDfqIkzJBWHvLp3x3UsWW
         0AvE36nRqD3lG2ROkPviw8YyjaLP2KLAVDaja4fiuy27NxW/ZpN5ouxJwuIf6ikiW5ly
         2XVAk454EIJdkAmeTAyOzaaIqgofdGVZnjloUrfrKgApG2u3gb0VBbqKFmn1Mzbj36S6
         NLYamvblntUt52bMY2JHsUuUt2sxuEC85IACHOrDCZGadvjE9un2dU4rS+n3lzTEWXl2
         B6Lw==
X-Gm-Message-State: AOAM5301Wn6epEcC/5suf+zfUJfDN5etETp5JF4i1ssmKdmNkZayi1B/
        hLpXjbG0+mfSHhoKIyiW4qX6lw/ZXn7ARDA8SvJCEQ==
X-Google-Smtp-Source: ABdhPJwFLIr/GH5BZQINZQllHE4paJG7suSjTbzOFq6WfqnMVkh1s9cjISJEvl7WKkrsrv8vLH+/5AkJ3PEobamJQ4I=
X-Received: by 2002:a2e:7d11:: with SMTP id y17mr4129417ljc.116.1612569791666;
 Fri, 05 Feb 2021 16:03:11 -0800 (PST)
MIME-Version: 1.0
References: <20210205202220.2748551-1-ndesaulniers@google.com>
 <20210205202220.2748551-2-ndesaulniers@google.com> <20210205160034.a0e0ba06752bef03e60f91f8@linux-foundation.org>
In-Reply-To: <20210205160034.a0e0ba06752bef03e60f91f8@linux-foundation.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 Feb 2021 16:02:58 -0800
Message-ID: <CAKwvOdmkx=+MGkc5uCB=0TssnHNQXb0E+x=CqbGs6gGZc5GH7Q@mail.gmail.com>
Subject: Re: [PATCH v9 1/3] vmlinux.lds.h: add DWARF v5 sections
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
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
        Chris Murphy <bugzilla@colorremedies.com>,
        Mark Wielaard <mark@klomp.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 5, 2021 at 4:00 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri,  5 Feb 2021 12:22:18 -0800 Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> > We expect toolchains to produce these new debug info sections as part of
> > DWARF v5. Add explicit placements to prevent the linker warnings from
> > --orphan-section=warn.
> >
> > Compilers may produce such sections with explicit -gdwarf-5, or based on
> > the implicit default version of DWARF when -g is used via DEBUG_INFO.
> > This implicit default changes over time, and has changed to DWARF v5
> > with GCC 11.
> >
> > .debug_sup was mentioned in review, but without compilers producing it
> > today, let's wait to add it until it becomes necessary.
> >
>
> There isn't anything in this changelog which explains why a -stable
> backport was requested?  Or is there?  Irritating linker warnings?
> More than that?

Users adopting GCC 11 will start to see warnings from the linker due
to --orphan-section=warn when building the branches of the stable
tree.  Stable has IME accepted patches for permitting newer toolchains
to continue to compile warning free.
-- 
Thanks,
~Nick Desaulniers
