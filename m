Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D362F898C
	for <lists+linux-arch@lfdr.de>; Sat, 16 Jan 2021 00:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbhAOXnj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jan 2021 18:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbhAOXni (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jan 2021 18:43:38 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B91FC061757;
        Fri, 15 Jan 2021 15:42:58 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id w127so6594447ybw.8;
        Fri, 15 Jan 2021 15:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2F29hULLcdjxbbHgzXktPmVGYBC0Y8dyyq9NoQsYzh8=;
        b=ruZ8RBfUjCYDk5g71LaZonLr9SanFa+9ZvtOKwn7AVkcKasgPV+s6tLvVqkN4xmMd1
         mxfHOb5mH/1iHveJRn1Eow/yXNXr3CxEkiGbgr2+s05vXnhpb8CB0yfukPbfN6P1zVzi
         GoLB/w9SYrdM/fLqixWUiPn4a5y8JB/xD4M/8ymJFraik/8JjnSuRHw6IopKHBYS7dz8
         wnmGfHX6zNdihG/eNc20eRvzszXw/mEaFHC8W7kgc552pUHrir6rQcd3xUL94bugP3Wf
         1YvZqcAOVbk0PNJrmOT8Le0/gEt8bmGPQc4qg1STz+1SykT1Y7+5B7UptBPLywaTSp2Z
         nZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2F29hULLcdjxbbHgzXktPmVGYBC0Y8dyyq9NoQsYzh8=;
        b=qjyCPaPf2P+inCyGTO5tB9gP5WmeBGsiZ/R55ba/bqhXOF7MFyuhaGuT202Dx/k2P8
         TeDYbaSz5iMxsvXkWTjp20pJUZ+R88Q4q0T6G7d2mnEtZhP3g3Cd3lYDxUm7bEf98W4u
         JNGJXDW4kmD5RvE5+GkYHu3vtZq+9A5xLVszKvkxkK5jg/AjeyQDSTpAZWUPnWv5p0Z8
         IEepjTyJuTWNEiQ4MvKFW9xsAckJeVGSSnQW81PQm444FiEbNKh03RQfnqQhsb2viGGh
         3wpxdu07MjP/KBwOSD4OVMd3CrqAGcX5YMUACZHORaqeqDQIyjUreL6S8rsLcBwHjrDR
         RDAA==
X-Gm-Message-State: AOAM533PRr3M4QzQ061qWO+dbCCDlv9LSNVI727cURvIkxqPD4SDV5BQ
        JF7nufw9zBU2TwqrV6uEFtucnwDAA1sA06Jd+lDFAZIdtlY=
X-Google-Smtp-Source: ABdhPJyUZh6YD/vIb/sAZ0PFxW8PZ1mh3UlMjBGw67gYNpc8/5BM04oB3c6VWYOqnlM1cS4x8AsWv/3pgMdece0t0qA=
X-Received: by 2002:a25:d6d0:: with SMTP id n199mr20593271ybg.27.1610754177664;
 Fri, 15 Jan 2021 15:42:57 -0800 (PST)
MIME-Version: 1.0
References: <20210115210616.404156-1-ndesaulniers@google.com>
 <CA+icZUVp+JNq89uc_DyWC6zh5=kLtUr7eOxHizfFggnEVGJpqw@mail.gmail.com>
 <7354583d-de40-b6b9-6534-a4f4c038230f@fb.com> <CAKwvOd=5iR0JONwDb6ypD7dzzjOS3Uj0CjcyYqPF48eK4Pi90Q@mail.gmail.com>
In-Reply-To: <CAKwvOd=5iR0JONwDb6ypD7dzzjOS3Uj0CjcyYqPF48eK4Pi90Q@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 15 Jan 2021 15:42:46 -0800
Message-ID: <CAEf4BzZ7y84+oe9CD4g3r19qGup=kYnm8+f+5K4YQ=6gqTWtcQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Kbuild: DWARF v5 support
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>, Yonghong Song <yhs@fb.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 15, 2021 at 3:34 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Jan 15, 2021 at 3:24 PM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 1/15/21 1:53 PM, Sedat Dilek wrote:
> > > En plus, I encountered breakage with GCC v10.2.1 and LLVM=1 and
> > > CONFIG_DEBUG_INFO_DWARF4.
> > > So might be good to add a "depends on !DEBUG_INFO_BTF" in this combination.
>
> Can you privately send me your configs that repro? Maybe I can isolate
> it to a set of configs?

Why privately? To reproduce and fix the issue we (BPF and pahole
community) would need the config as well.


>
> >
> > I suggested not to add !DEBUG_INFO_BTF to CONFIG_DEBUG_INFO_DWARF4.
> > It is not there before and adding this may suddenly break some users.
> >
> > If certain combination of gcc/llvm does not work for
> > CONFIG_DEBUG_INFO_DWARF4 with pahole, this is a bug bpf community
> > should fix.
>
> Is there a place I should report bugs?

bpf@vger.kernel.org (BPF in general) and dwarves@vger.kernel.org
(pahole, which seems to be emitting these warnings and having problems
with DWARF5).


>
> >
> > >
> > > I had some other small nits commented in the single patches.
> > >
> > > As requested in your previous patch-series, feel free to add my:
> > >
> > > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
>
> Yeah, I'll keep it if v6 is just commit message changes.
>
> --
> Thanks,
> ~Nick Desaulniers
