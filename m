Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634C7311355
	for <lists+linux-arch@lfdr.de>; Fri,  5 Feb 2021 22:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhBEVUA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Feb 2021 16:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbhBEVTH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Feb 2021 16:19:07 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87F7C0613D6
        for <linux-arch@vger.kernel.org>; Fri,  5 Feb 2021 13:18:26 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id t8so9418029ljk.10
        for <linux-arch@vger.kernel.org>; Fri, 05 Feb 2021 13:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M/mNa0cCFnCBPv9oOHupxAJvNU5NKzX9ZpjTVG00V9k=;
        b=Rtet6B6oBepuSfwX0Mt1avgYBOHHWa0CgvSO6WFeSeKf4J1sM4DcMrG5bc65K79XZ9
         nKaRKqf4tLFb9DqAqjBdbVPE1pdd7ix3IWQtmQAvk+oFRK3jkfLSnLwd7A+0E1uGVp3f
         xbuoidh/QLlOJvEzBI3DNxo12oITSdhV/7NbJzexL7yOOWW2cbQHBvCbceZSgqfwYZyD
         TxYkr5eMaDsX+I7LjX6SN5fYusfBv+D4ILY7o5uSP2GEU5GkDyureKlPfYmR6aTaxQyc
         d95Y4a5cKG0yLJppR9vT8lGXoEr6hW2yf1/7lZLh6p7jVNZMPwjZRyTtkYG5LYODQKjC
         pb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/mNa0cCFnCBPv9oOHupxAJvNU5NKzX9ZpjTVG00V9k=;
        b=NZlVCsdfRBXAs6b8nLreHZM/mY0Ixgr4hj9PO1STPYH8zqSc2BOQ1VjkO7wdQskNVt
         bDpy4XSqnYU+y9wTgModmdD+IKoyOhgCC5dTorEkvMEZZqvGBDFVM+PxRmWzF/fgQdnn
         a1qwdIuAx5pEHko6Ca3rRXe0ccQ/hQdtd1zJZPOaprZcY7D4tzBQtk18tVxNFw2ArBxn
         VEwVeGIvBZURYQAAB6eF0mNUVDgvWxWANa96wSC2G+vcgTbp2doWy/8BAVe9fABV0d+D
         DCErpLidNQW0WDyuv0zBLqSJcIKOTh3IhaRTEIbz5izeogHkdDtATgtTBa6WCWM114Fj
         o++g==
X-Gm-Message-State: AOAM532uSg1ENZUWdiKATlyaUnkFlB9pj/9cFr5QB+wKqeYAHXtiXAlr
        EpCnF1y/6L6rSPkvHJT69rl5ndEFgBGhp1NczbS2AQ==
X-Google-Smtp-Source: ABdhPJx5dPeDrLYGW00hRiU8hbhTVJoK1h7ZXHKdpr6PjoJlcg9frjh8W/xaexNoFtIzucZTyFu9xlz6J9W1fEiRPhc=
X-Received: by 2002:a2e:9cc8:: with SMTP id g8mr3809288ljj.479.1612559905021;
 Fri, 05 Feb 2021 13:18:25 -0800 (PST)
MIME-Version: 1.0
References: <20210130004401.2528717-1-ndesaulniers@google.com>
 <20210130004401.2528717-2-ndesaulniers@google.com> <20210204103946.GA14802@wildebeest.org>
 <CAKwvOdm0O8m_+mxy7Z91Lu=Hzf6-DyCdAjMOsCRiMmNis4Pd2A@mail.gmail.com>
 <20fdd20fe067dba00b349407c4a0128c97c1a707.camel@klomp.org>
 <CAKwvOdmT4t==akMN7eHWgD_XdpN--PLpUj8vgujGJ4TpREvteQ@mail.gmail.com>
 <42d2542d4b7f9836121b92d9bf349afa920bd4cd.camel@klomp.org>
 <CAKwvOdmHM8srtLaEy+L_XGzO9TBbhP3csQNAhUTH_TmeDePkDQ@mail.gmail.com> <8696ef2e86c5d8078bf2d2c74fb3cbbecbd22c83.camel@klomp.org>
In-Reply-To: <8696ef2e86c5d8078bf2d2c74fb3cbbecbd22c83.camel@klomp.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 Feb 2021 13:18:11 -0800
Message-ID: <CAKwvOd=jMykgiR+fthEVeaP1c3-N6veZhKd2LZjeJ5KaqF4PHg@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] Kbuild: make DWARF version a choice
To:     Mark Wielaard <mark@klomp.org>, Jakub Jelinek <jakub@redhat.com>,
        Nick Clifton <nickc@redhat.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 5, 2021 at 4:49 AM Mark Wielaard <mark@klomp.org> wrote:
>
> Hi Nick,
>
> On Thu, 2021-02-04 at 14:06 -0800, Nick Desaulniers wrote:
> > On Thu, Feb 4, 2021 at 12:28 PM Mark Wielaard <mark@klomp.org> wrote:
> > > I believe so yes, we did a mass-rebuild of all of Fedora a few weeks
> > > back with a GCC11 pre-release and did find some tools which weren't
> > > ready, but as far as I know all have been fixed now. I did try to

I guess I'm curious whether
https://bugzilla.redhat.com/show_bug.cgi?id=1922707 came up during the
mass rebuild of all of Fedora a few weeks ago?  Assuming the Linux
kernel was part of that test, those warnings would have been both new
and obviously related to changing the implicit default DWARF version.
It's possible it was a kernel build without debug info enabled or a
kernel version old enough to not have that linker warning enabled, I
suppose.  It might be good to check though, that way changes to GCC
that impact the kernel are caught even sooner or ASAP. New diagnostics
added every compiler release come to mind in particular.
-- 
Thanks,
~Nick Desaulniers
