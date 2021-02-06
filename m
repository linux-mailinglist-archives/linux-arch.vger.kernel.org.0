Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEEC311D1B
	for <lists+linux-arch@lfdr.de>; Sat,  6 Feb 2021 13:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhBFM33 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 6 Feb 2021 07:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhBFM31 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 6 Feb 2021 07:29:27 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABA7C06174A;
        Sat,  6 Feb 2021 04:28:46 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id q5so8379062ilc.10;
        Sat, 06 Feb 2021 04:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=JBajd064PpTu/1CDE1Jdo8Su+QtGYLF6dTi4RlKWEEA=;
        b=T2sqHXGgX7Un6Xv1/xkyr0Z5Q2LG50+DE94tSzxDfsN6B9vFdJsZygo10nHcvwpajE
         M9InJ/bdjdgV/SRdRbT6bC5Wa2qr3qR/TOOJvviRRQmcb/PcdKkoVyoUJ/NzU6B+u58B
         QVQ0kHD3igiBljW+ntK26oySyqZo+8bNM94vCifIqIOFrjxbV84kAKE47g3/ONkthzSk
         nYayJ1GMdxYAn+gfMzr5gsWDJfIEIFfYEyzuAgLPth/jD4rJ+wfUVoBlb5ASJHbra1E+
         9GfUlKh1j/xwls7XQKY+WgfPIkwUuhsCQBvdNGEUTM3EuTbEhtT1h4Vq5lK/TehpaiQK
         81ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=JBajd064PpTu/1CDE1Jdo8Su+QtGYLF6dTi4RlKWEEA=;
        b=Z/HoONdiBSBLJmT3ghQgQP8a1nVZMouZcRZgOt1d+j0BW9lrG74s/gQAwZ6e7dQMD6
         OpO+3E69OWCqmTpHKuMo+YwQVsoWsn1/bz8qAtdZgVRb4ylCujkty/MxhaHjOUOtnrma
         Bw0gseY5F6D1FYhi/53K35J2BM2Hokwu/z0mbvIAkthwBgsbECXfg4DjrbetWdZEQq3o
         7Tz3+NK7cR7UAQmifyVVPMUrU+EbJ6hgoksmz+5HLqtFnFw3i4Yti/BYvXGkWqA0UK0W
         LeZZhBzPoXSAovB9QcHbzzfQoOZNPXn5c8fkpC+11ZGv1OT1HRBpkbWkVhxpTRtqwPav
         muVg==
X-Gm-Message-State: AOAM533mSD8fZylY0jKzzEq4uROFffg4I/H8zyFidtuNK9Fjcn9m4kO5
        oHIIOUt9N2zpPsum05SGHK3hVi1Zz0983dLiN2c=
X-Google-Smtp-Source: ABdhPJxkWEspd89Az+lzNCSx6GqZMqO0HD/bsY8trAsiOXaBDuMeY1Kw/42fxWVr0akJiCVy7UEaDt9MwXXerqWRiHU=
X-Received: by 2002:a92:ce46:: with SMTP id a6mr8328535ilr.10.1612614525862;
 Sat, 06 Feb 2021 04:28:45 -0800 (PST)
MIME-Version: 1.0
References: <20210205202220.2748551-1-ndesaulniers@google.com>
 <CA+icZUW3sg_PkbmKSFMs6EqwQV7=hvKuAgZSsbg=Qr6gTs7RbQ@mail.gmail.com> <CAK7LNAT8rjo=MdLqpjRXR2fnJ8XSeoA=uD633Pj1ENs5JOciXQ@mail.gmail.com>
In-Reply-To: <CAK7LNAT8rjo=MdLqpjRXR2fnJ8XSeoA=uD633Pj1ENs5JOciXQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 6 Feb 2021 13:28:34 +0100
Message-ID: <CA+icZUXcAGhqLTmWsQLnvH=7meZ4N0k3zDcwv7vMGCSsp4TxDg@mail.gmail.com>
Subject: Re: [PATCH v9 0/3] Kbuild: DWARF v5 support
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Chris Murphy <bugzilla@colorremedies.com>,
        Mark Wielaard <mark@klomp.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 6, 2021 at 1:05 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Sat, Feb 6, 2021 at 6:00 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Fri, Feb 5, 2021 at 9:22 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > DWARF v5 is the latest standard of the DWARF debug info format.
> > >
> > > DWARF5 wins significantly in terms of size and especially so when mixed
> > > with compression (CONFIG_DEBUG_INFO_COMPRESSED).
> > >
> > > Link: http://www.dwarfstd.org/doc/DWARF5.pdf
> > >
> > > Patch 1 places the DWARF v5 sections explicitly in the kernel linker
> > > script.
> > > Patch 2 modifies Kconfig for DEBUG_INFO_DWARF4 to be used as a fallback.
> > > Patch 3 adds an explicit Kconfig for DWARF v5 for clang and older GCC
> > > where the implicit default DWARF version is not 5.
> > >
> > > Changes from v8:
> > > * Separate out the linker script changes (from v7 0002). Put those
> > >   first. Carry Reviewed by and tested by tags.  Least contentious part
> > >   of the series. Tagged for stable; otherwise users upgrading to GCC 11
> > >   may find orphan section warnings from the implicit default DWARF
> > >   version changing and generating the new debug info sections.
> > > * Add CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT in 0002, make it the
> > >   default rather than CONFIG_DEBUG_INFO_DWARF4, as per Mark, Jakub,
> > >   Arvind.
> > > * Drop reviewed by and tested by tags for 0002 and 0003; sorry
> > >   reviewers/testers, but I view that as a big change. I will buy you
> > >   beers if you're fatigued, AND for the help so far. I appreciate you.
> >
> > All 3 patches NACKed - I drink no beer.
>
> LoL.
> Other than beer, I am fine with v9.
>
> Personally, I thought v8 (no CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT)
> was good too, but I do not have a strong opinion about
> leaving the compiler's freedom to choose the dwarf version.
>
> Unless somebody has an objection, I will pick up v9 for the next MW.
>
>
> Meanwhile, if you want to give reviewed-by / tested-by
> please do so.
>

Fine with me.

I have no opinion towards distro-handling of toolchain-default(s).

Feel free to add my:
Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM/Clang v12.0.0-rc1 x86-64

Thanks to all involved people - I enjoyed the evolution of this patchset.

- Sedat -

P.S.: /me drinking right now an Earl Grey tea - drink whatever you prefer :-).
