Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14E229537A
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 22:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438961AbgJUUcZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 16:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410384AbgJUUcZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Oct 2020 16:32:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C5FC0613CF
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2020 13:32:21 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 10so2182792pfp.5
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2020 13:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZlQ9VQDQ1Y9MZKtPS8PBXAKEQPFLhfcQu+fvrtVUj70=;
        b=Emippq77DbvWgKUDGkyBMfhRMm1aDnbYDXtMujdgf+mu86LHMe+9Tlr+o7S+4ixM11
         j/yvPBB4uvdF3zfF9C70EW8ygMoDOjnFoe2zerU36e4d5nRZYzQNJaDi6Y8z2uj2hJI4
         PhL0lcNF0rL3NTBTeqlT4jza+R/TkvHn6SUxthmepS0xajOLKrIek6s/xEhdCSlnsUWq
         EB2HsmKjK+IijnLdv9z2G3jWa7jN2T+KNvWypDG/8+fSUCRMnmoeAbpovfiF5c3RE2Tp
         TSrAhiFsocuyPdjHtu1LoF4xT23mVI0v2BV+TXGqD6p3EAPx9VgvgCEWBgc6gVnfr2hK
         nnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZlQ9VQDQ1Y9MZKtPS8PBXAKEQPFLhfcQu+fvrtVUj70=;
        b=EKJrW/ONW/PWqKLC0mobzaBPCikXHo6hq0yVHlBQ/yrSUIx4MrX5EM+5jmaNm+CAXv
         JWmpFdbjV0Ns5VrdFJ6/Jdl4zjrxfdBJIJ9CynAHHZsqX/sQOhA1AzawhtV88Vzi//4O
         4GLloSP7elYKHyOvmN808oNmqESjBTZoUG2rqpsAneFEPk7fHkXTYDewBul2hC5vga1h
         mYzxA+vC72rOkFu5gSzk1ZJrvpAcxnUa3pQSosuo06PMviZnJypg+VrCevMATifRy2kk
         3k9HdvrBJPs5FiUY+HizYRJ/+h7IJULfBWR4g8zRZDgjJSqJ8BH/DlB0fPN7QIckmSNB
         ewUg==
X-Gm-Message-State: AOAM531r5nD7hl2P7XPggfooxw+svk1sLzBqN6HdhphYEvRB2HqZjfrD
        afIyD1dvOUcuKoP6PvJMmEAZSawt+bslgKav0tuJVQ==
X-Google-Smtp-Source: ABdhPJwTZeJbnyRrvOsPWPMlSftQ+6gOEwM0ZlDr6yLu5e3FduIZ9zveOSWxefoq/MJY6RC0CdpUpNBwkVy8EyeVYXk=
X-Received: by 2002:a65:4485:: with SMTP id l5mr4905625pgq.121.1603312340655;
 Wed, 21 Oct 2020 13:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201005025720.2599682-1-keescook@chromium.org>
 <202010141603.49EA0CE@keescook> <CAFP8O3LvTkqUK3rp9Q17fmyN+xApZXA8Cs=MNvxrZ3SDCDRX3A@mail.gmail.com>
 <202010211304.60EF97AF2@keescook>
In-Reply-To: <202010211304.60EF97AF2@keescook>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Wed, 21 Oct 2020 13:32:09 -0700
Message-ID: <CAFP8O3KzCbFQarDCBbwsV_saQ2stpy69-a1zBY0Jf2u9PnzzKQ@mail.gmail.com>
Subject: Re: [PATCH v2] vmlinux.lds.h: Keep .ctors.* with .ctors
To:     Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 1:09 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Oct 14, 2020 at 09:53:39PM -0700, F=C4=81ng-ru=C3=AC S=C3=B2ng wr=
ote:
> > On Wed, Oct 14, 2020 at 4:04 PM Kees Cook <keescook@chromium.org> wrote=
:
> > > > index 5430febd34be..b83c00c63997 100644
> > > > --- a/include/asm-generic/vmlinux.lds.h
> > > > +++ b/include/asm-generic/vmlinux.lds.h
> > > > @@ -684,6 +684,7 @@
> > > >  #ifdef CONFIG_CONSTRUCTORS
> > > >  #define KERNEL_CTORS()       . =3D ALIGN(8);                      =
\
> > > >                       __ctors_start =3D .;                 \
> > > > +                     KEEP(*(SORT(.ctors.*)))            \
> > > >                       KEEP(*(.ctors))                    \
> > > >                       KEEP(*(SORT(.init_array.*)))       \
> > > >                       KEEP(*(.init_array))               \
> > > > --
> > > > 2.25.1
> >
> > I think it would be great to figure out why these .ctors.* .dtors.* are=
 generated.
>
> I haven't had the time to investigate. This patch keeps sfr's builds
> from regressing, so we need at least this first.

We need to know under what circumstances .ctors.* are generated.
For Clang>=3D10.0.1, for all *-linux triples, .init_array/.finit_array
are used by default.
There is a toggle -fno-use-init-array (not in GCC) to switch back to
.ctors/.dtors

Modern GCC also uses .init_array. The minimum requirement is now GCC
4.9 and thus I wonder whether the .ctors configuration is still
supported.
If it is (maybe because glibc version which is not specified on
https://www.kernel.org/doc/html/latest/process/changes.html ), we
should use
some #if to highlight that.

> > ~GCC 4.7 switched to default to .init_array/.fini_array if libc
> > supports it. I have some refactoring in this area of Clang as well
> > (e.g. https://reviews.llvm.org/D71393)
> >
> > And I am not sure SORT(.init_array.*) or SORT(.ctors.*) will work. The
> > correct construct is SORT_BY_INIT_PRIORITY(.init_array.*)
>
> The kernel doesn't seem to use the init_priority attribute at all. Are
> you saying the cause of the .ctors.* names are a result of some internal
> use of init_priority by the compiler here?
>

If no priority is intended, consider deleting SORT to avoid confusion?
