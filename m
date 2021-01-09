Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A0A2F0251
	for <lists+linux-arch@lfdr.de>; Sat,  9 Jan 2021 18:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbhAIRe2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 Jan 2021 12:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbhAIRe2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 9 Jan 2021 12:34:28 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03FDC06179F;
        Sat,  9 Jan 2021 09:33:47 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e7so13764376ile.7;
        Sat, 09 Jan 2021 09:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=NikId7Xj7bWOh+hLaIn+ZZMlijXDi8nElT+l6OdToWY=;
        b=g/pQdtKnuFESOOqddx88eblRnszCnOfblr9FrlAOcVMiw7QPdJqBkMMrQ8qQv9pejD
         Ny2QqfbXSFy15cuqaGq979m/4cqR8/p9VV4Cuvi9Gve2mhoptlZVOPLFeaYRm9zI89SV
         +55oFqz636EU/Ok+b+qFnjxTAKDjuWyUWV7m7LPzGH9djYzDFb2Qb/PsVddrPMgbVPDN
         OrCQxG97wM8LYRaXgfKklCI33p8jWUdT6RGI260XhXB85Yt+7M7k/i+uGfRPxpcOpCIC
         pA5zReSdT48tC7O9yfnxIhsS+NqdW8Ux/y6F0q7ZlOhNU+h9ZOmHlkhfKUPMM+XFueIr
         M4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=NikId7Xj7bWOh+hLaIn+ZZMlijXDi8nElT+l6OdToWY=;
        b=eBV+4t/j30uMVQizE6i8Uw5ah+pQWKVmrtCuCs78vrUHzjcJyrNZHhIVMXE4fAxRGe
         E1Mvwr8tzbd2sjPaTiEcDKuqOYqSAUFzPLz4qqNdUKtvQ2MiowprgKwoIPN369yLOkK0
         bJ1CqKfuOz+PUTj4eM8wREmE3edH9HgeziimHa9qceQ5EVAw4ncdvChXHsfT08EheUgt
         gL6tubO99YD2Ega0JUr23Vs1xf094bzwTc7uqAQeHoi1z1rs76mpZuNstizJ7DDPA/CN
         PWwMO9TA92yduxVAMe87T7TBHL/d31GtdGgHoWhTJw2MqxTm07x7TZc0O/uhdpKSe8j5
         1GhA==
X-Gm-Message-State: AOAM533L3sIBcShqYObQpkpovThGMGR4q76mzNDuB+aPKkZjEo5Pgpvw
        zyhsVZ+dxE6l65yUXzrAlI8NezVBW2mxubm+TzM=
X-Google-Smtp-Source: ABdhPJx1ffrLsMiWlEmhD/YwfQk9GM6w4n9rJLKldS7um9a/rbcv+zWLw4Px08XWbgZ5NbTJHYMzeaP0UJYTrFD6Q3s=
X-Received: by 2002:a05:6e02:1a43:: with SMTP id u3mr9156005ilv.209.1610213627012;
 Sat, 09 Jan 2021 09:33:47 -0800 (PST)
MIME-Version: 1.0
References: <20201211184633.3213045-1-samitolvanen@google.com>
 <CA+icZUWYxO1hHW-_vrJid7EstqQRYQphjO3Xn6pj6qfEYEONbA@mail.gmail.com>
 <20210109153646.zrmglpvr27f5zd7m@treble> <CA+icZUUiucbsQZtJKYdD7Y7Cq8hJZdBwsF0U0BFbaBtnLY3Nsw@mail.gmail.com>
 <20210109160709.kqqpf64klflajarl@treble> <CA+icZUU=sS2xfzo9qTUTPQ0prbbQcj29tpDt1qK5cYZxarXuxg@mail.gmail.com>
 <20210109163256.3sv3wbgrshbj72ik@treble> <CA+icZUUszOHkJ8Acx2mDowg3StZw9EureDQ7YYkJkcAnpLBA+g@mail.gmail.com>
 <20210109170353.litivfvc4zotnimv@treble> <20210109170558.meufvgwrjtqo5v3i@treble>
In-Reply-To: <20210109170558.meufvgwrjtqo5v3i@treble>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 9 Jan 2021 18:33:36 +0100
Message-ID: <CA+icZUVEyCJK4ja_d=45t35=uRoXSDutcqEXBtKbChoP3MozrQ@mail.gmail.com>
Subject: Re: [PATCH v9 00/16] Add support for Clang LTO
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 9, 2021 at 6:06 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Sat, Jan 09, 2021 at 11:03:57AM -0600, Josh Poimboeuf wrote:
> > On Sat, Jan 09, 2021 at 05:45:47PM +0100, Sedat Dilek wrote:
> > > I tried merging with clang-cfi Git which is based on Linux v5.11-rc2+
> > > with a lot of merge conflicts.
> > >
> > > Did you try on top of cfi-10 Git tag which is based on Linux v5.10?
> > >
> > > Whatever you successfully did... Can you give me a step-by-step instruction?
> >
> > Oops, my bad.  My last three commits (which I just added) do conflict.
> > Sorry for the confusion.
> >
> > Just drop my last three commits:
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-vmlinux
> > git checkout -B tmp FETCH_HEAD
> > git reset --hard HEAD~~~
> > git fetch https://github.com/samitolvanen/linux clang-lto
> > git rebase --onto FETCH_HEAD 79881bfc57be
>
> Last one should be:
>
> git rebase --onto FETCH_HEAD 2c85ebc57b3e
>

OK, that worked fine.

So commit 2c85ebc57b3e is v5.10 Git tag in upstream.

So, I substituted:

git rebase --onto FETCH_HEAD v5.10

Thanks.

- Sedat -
