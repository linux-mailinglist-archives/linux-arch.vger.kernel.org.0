Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F7430EE44
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 09:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbhBDIXw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 03:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbhBDIXu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 03:23:50 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C398DC061573;
        Thu,  4 Feb 2021 00:23:10 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id e7so1792394ile.7;
        Thu, 04 Feb 2021 00:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=hVeXu8KDTq3DcUZSmabKugyarvvt6HgXml5jIs81yZA=;
        b=J4jdqH29EWjzwxj8O4BYgFQYMFw43/R6LpNPswF14vLt4c3Q8jaPEw83y04iCIykbf
         TuJFjxbcw82Wt906eBpQcvKDOfqQ02cd2NGOw3xUbGcLJZ0hhexBXnLf+V73MdLApygy
         bf4HcuV4buKX+ZyuCCqro6cjEHpeP692877FRRGJz8rzxgWB1sTAEezE8mec5FWHWxB4
         8uPn/2c92cRcdp9Qa9HFSViaRqi/PNj55cyYS0ZDTyL2DcGhHYXgDk0bQDXFGP0/8ERq
         +js67Si1Mk4y9PjX0HGwIAcxFVmJMiQOgogqkejgjH6CFYnCwIWdeXKsM6hKM23OAM0s
         JOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=hVeXu8KDTq3DcUZSmabKugyarvvt6HgXml5jIs81yZA=;
        b=q929B93y/d7tEI2kzSlJjLanePbTf1V2GWoqTQgbXeN/+DU9+KbZLK8x+lGJ7AgU9W
         Z8TgzG9MHDiFGMGfjr0qxVJ4RwyghTN2mC6fFmMVDPPcm/IobAY5s+HfAuU41Ru/CrGn
         NIkRNGBXK6WhlJfuitK62pP4/M5h5sUlW2fPb8GhIXXpsRh899wZPs2oE8ib/sw0us3Y
         AyEPJmQ82wsfxr3P7TCRONPG6EVCjVwHVgup0LvwuGbSKo6oEfhX0eD7SXJdX4gZ15cs
         0wsWKxSg4uhhiFNgKSdSsGqh/i8tXMg/KX8XXe4PWBKvHhiScNQWF6s+dGVu5sXyNXDe
         Pbmw==
X-Gm-Message-State: AOAM532bf4bpLAJomar3qQZZH7MEnQyxp7pTiZJLBLOr2VptDXAubnXI
        wOosPBIRGltSSXarvHSr3yB4W1yJtiQedPpq/pg=
X-Google-Smtp-Source: ABdhPJzFyrelCLssK4mjz7QTMk/Ny6rVLYMgECQwdMRSLXkif6netDe09NB4Etwlb4Wx0ckNLVQ0fdU0PA2sRzXpfXI=
X-Received: by 2002:a92:ce46:: with SMTP id a6mr6255144ilr.10.1612426989999;
 Thu, 04 Feb 2021 00:23:09 -0800 (PST)
MIME-Version: 1.0
References: <20210204064037.1281726-1-ndesaulniers@google.com>
 <CA+icZUVVcP5MSUSDM18Wab46n-20eskRE59akdwfxXKpKXDOFg@mail.gmail.com> <CAKwvOdkYkgViVfzAn1J+SoSfzWn4aYVi+O3uwHhTsV92CVEeJQ@mail.gmail.com>
In-Reply-To: <CAKwvOdkYkgViVfzAn1J+SoSfzWn4aYVi+O3uwHhTsV92CVEeJQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 4 Feb 2021 09:22:58 +0100
Message-ID: <CA+icZUVFrk4L+CUo+o3pdsOjaJPKCqnP0zmTuaOoYLg4wyHkbw@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] Kbuild: DWARF v5 support
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
        Arvind Sankar <nivedita@alum.mit.edu>,
        Chris Murphy <bugzilla@colorremedies.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 4, 2021 at 8:45 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Wed, Feb 3, 2021 at 10:58 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > I guess I need to test harder to get a Tested-by credit :-)?
>
> You're right Sedat, I'm sorry.  Your testing is invaluable; thank you
> for taking the time to help and credit is a powerful incentive.
>
> It can be difficult to know whether to carry forward tags or not when
> a patch is revised.
>
> Keeping track whether someone sent an explicit Tested By vs including
> it based on feedback that implied they tried it.  If you've tested v7
> or v8, please reply explicitly with tested by tags, or perhaps
> Masahiro can apply those for you.
>

Unfortunately, some recent patches around CBL and kbuild miss my
Tested-by's and are already queued up in the remote Git's.
Maybe, I was simply pissed off this fact when writing my response to you.

Feel free to add my...

   Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # v1-v8 with
LLVM/Clang v11.0.1+ & v12.0.0-rc1 amd64

Looking at the (git) diff v7 -> v8 - seen from the code - nothing changed.

Feel free to add the links to thread(s) and patch(es) I gave as a
feedback in my other response.

One reason for missed Tested-by's I see is I am NOT subscribed to some
mailing-list.

> It can be difficult to know what's broken if you apply too many out of
> tree patches though.
>

"Nicht verkomplifizieren."
In English: "R(e)D(u)C(e) complexity" is normally one of my life philosophies.

Fighting with... "As usual: It has to work in my development
environment - first."

Sorry, I insisted that it *has* to work in my environment.
It has no secrets - all patches I have queued up in my custom patchset
is publically available.
That does not mean all of them are or will be upstreamed.

Bonne chance with the Linux-BPF folks and send my apologies to have fooled them.
It's one of my """strength of character""" (note 3 quotes) :-).

- Sedat -
