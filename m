Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7675B30FC7C
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 20:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239707AbhBDTUB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 14:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239602AbhBDTTg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 14:19:36 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D310C06178B
        for <linux-arch@vger.kernel.org>; Thu,  4 Feb 2021 11:18:56 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id e9so2392815pjj.0
        for <linux-arch@vger.kernel.org>; Thu, 04 Feb 2021 11:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gpuC+d2FUOI/ZHg93wQH+r85JDI4pp/FX9Ub2W2auJA=;
        b=IeotN/9b8v5XKf4EhKYsx0kfJDGFixxFAbgIG7uuE5tnabLRIRh0tUk3+MzaseOpkO
         MGOfJLn/t0mNBWKilsOO0R1ZgJ6TjREJeV04mMuqVPU0OoeZfGS3dqy0VbE+EvvmXJgg
         ra34agXgJ5zd5/OLk3jfRChhcNS4ABtu9mHgG8ARfKSTgC/4vLvvrSay2qoLL3Gzr3Dd
         HAdmCEbXZErEAO0aPLwRJ+qLYZN2w7HXPO6aKm0qC4+1SK+wu7rNYvqDwzUbY9GsiJ51
         NPYomZ2yLP+eL9f0GUvcJMzbF+QnmE0YujcWl0QGEnpL1s/uI3nJkw08iQvzzN3jBl/q
         xS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gpuC+d2FUOI/ZHg93wQH+r85JDI4pp/FX9Ub2W2auJA=;
        b=SOphYErtk7YuoxNhznqT+wsrAZz3A50j0iMaJwtLZ/asTsgk42EMKMawF8tVsLivjC
         d1YgO6RUVbFBU4YM+Uk32yLUKbSQ9ugaPng/XXseTrddheAtby+0pve7Yeu/T3eO7+xY
         NQwqz9YwHl9nwkknHxWqewv+95//gvEYRAsuhJ7PYNQMJa+qejRNY6qtaRPZAlwzYdnd
         QmQmR8jsDUrPQzKD8H6kW42Dqs4SvCSFG0BRGHBK6yXNF9g2W4HpNjxXG1YiTpDd2cop
         aKh8BdJFxe7XlRQ8LPPq0G+RW2YGH6BhSV/zRVA40FPHLr1HC+GTm9O+9Avp2ix0e/hS
         pY/Q==
X-Gm-Message-State: AOAM532Orcky7v4eWOnS/ngBzUFmtsyYZzEYKerYYBLfIXdvmRZrHd0Z
        r7GzMgI/zrgj6qaOkWfe1QBkPUsBUbdkIqW0M99Ilg==
X-Google-Smtp-Source: ABdhPJzl7LAFaClTjRx4s2bi9MKyf3s0L375hLNeyyqodeJV4B0xlBdb5b8nigoIhDlFSEWostsGA+rxdrWqOWCmz5U=
X-Received: by 2002:a17:90a:bf10:: with SMTP id c16mr435444pjs.101.1612466335618;
 Thu, 04 Feb 2021 11:18:55 -0800 (PST)
MIME-Version: 1.0
References: <20210130004401.2528717-1-ndesaulniers@google.com>
 <20210130004401.2528717-2-ndesaulniers@google.com> <20210204103946.GA14802@wildebeest.org>
In-Reply-To: <20210204103946.GA14802@wildebeest.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 4 Feb 2021 11:18:44 -0800
Message-ID: <CAKwvOdm0O8m_+mxy7Z91Lu=Hzf6-DyCdAjMOsCRiMmNis4Pd2A@mail.gmail.com>
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

On Thu, Feb 4, 2021 at 2:41 AM Mark Wielaard <mark@klomp.org> wrote:
>
> Hi Nick,
>
> On Fri, Jan 29, 2021 at 04:44:00PM -0800, Nick Desaulniers wrote:
> > Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice which is
> > the default. Does so in a way that's forward compatible with existing
> > configs, and makes adding future versions more straightforward.
> >
> > GCC since ~4.8 has defaulted to this DWARF version implicitly.
>
> And since GCC 11 it defaults to DWARF version 5.
>
> It would be better to set the default to the DWARF version that the
> compiler generates. So if the user doesn't select any version then it
> should default to just -g (or -gdwarf).

I disagree.

https://lore.kernel.org/lkml/CAKwvOdk0zxewEOaFuqK0aSMz3vKNzDOgmez=-Dae4+bodsSg5w@mail.gmail.com/
"""
I agree that this patch takes away the compiler vendor's choice as to
what the implicit default choice is for dwarf version for the kernel.
(We, the Linux kernel, do so already for implicit default -std=gnuc*
as well). ...
But I'm
going to suggest we follow the Zen of Python: explicit is better than
implicit.
"""
We have a number of in tree and out of tree DWARF consumers that
aren't ready for DWARF v5.  Kernel developers need a way to disable
DWARF v5 until their dependencies are deployed or more widely
available.

I'm happy to consider eventually moving the default DWARF version for
the kernel to v5, and ideas for how to wean developers off of v4, but
I don't think forcing v5 on kernel developers right now is the most
delicate approach.
-- 
Thanks,
~Nick Desaulniers
