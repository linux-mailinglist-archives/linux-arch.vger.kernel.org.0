Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C11AAC42C2
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2019 23:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfJAVdH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Oct 2019 17:33:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44485 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbfJAVdH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Oct 2019 17:33:07 -0400
Received: by mail-pl1-f195.google.com with SMTP id q15so6157908pll.11
        for <linux-arch@vger.kernel.org>; Tue, 01 Oct 2019 14:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z4e1NN6nu4ZaQSr4QU7LcV+N896S8TJHxo2z5wLZZe4=;
        b=Pr4ab6DTLcpPoAFbMcSjaTUTYVYp1LDm5BAlOJU2YvcEMt0bTipepUjaxG5lMpoUOp
         lFCI5o5vkaajGiotvJdJXz2y9Ieao3sEzHy2wrSWu+nNxZvJJ6LJkgjjBaRWx1ZT5bm8
         4QIcAuuFL/pw3oFZX1nVHUqhVjcBSxdbNKnvKd0GP0sevjFa63alN7etTzG5F5Qf0DHu
         io4j6lgazyqxmgA7U+/15haF4Am+flXl911MfAe8UdtLZyRvu9CPEb5xVZ0ISAJuLnPl
         J06OuplsJbzdojcrSa/kZx9aEFGxQ/dSE+ZxmHLg1xK7+2xExXqNg6VNQjOmO/SYhZPl
         dw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z4e1NN6nu4ZaQSr4QU7LcV+N896S8TJHxo2z5wLZZe4=;
        b=ZNtyMq/b/C39Rp4WZ9c4oJijgtNPLFSXJiyKZttoeZ0Yo+u4VR9ELUYyWcKBVP3Psx
         XEl4/zQ2hA6U3XMXxlwIMf68r8OR5XkRhSp8S7neHdRNqxExMnm8mWhtAnmvOl4DfJh6
         7/UWYtOyKXYeedj5B92mMaXXJ47hTx+vR61U8qFEK+KUywr0UYQ3RdR/5zp86Dv6eKjx
         iV0VVJui+vIysFp1mFGa8JZb3my0dMJeULNfpYAch4UZUUuXZ0lnmULDSV1VNgyeO5aH
         zp8NqIA2VlvqYwLyaVpwaYKb4elmzBud8bjMXX7w+rqWcBpuPCOOOkeQQhbIrSnuIixo
         VVFw==
X-Gm-Message-State: APjAAAX4Te0YjpyRVOefn+Mv1Hxbti2X/2CA/Di4mUfmuwEIvsv92ee5
        ftgc6aa3sl+LbdocZhQnR+qmdYn9tt4Iw/B072p3GA==
X-Google-Smtp-Source: APXvYqyxozJxVm+qJ2C11b5+NXCGyt7TX/8uK7rOEwCENn8WK5blF8+KGJMCObW2H0xWVEXihaTyEWNZTLWX6ufwZ2Q=
X-Received: by 2002:a17:902:7c08:: with SMTP id x8mr11776916pll.119.1569965585922;
 Tue, 01 Oct 2019 14:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck> <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck> <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk> <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
 <20191001181438.GL25745@shell.armlinux.org.uk> <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
 <20191001205938.GM25745@shell.armlinux.org.uk> <20191001212608.GN25745@shell.armlinux.org.uk>
In-Reply-To: <20191001212608.GN25745@shell.armlinux.org.uk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Oct 2019 14:32:54 -0700
Message-ID: <CAKwvOdmkmdM14BNurK3WwyG3Qc5wOFeajMtQ1D+na9mLfkim+w@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Will Deacon <will@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Kees Cook <keescook@google.com>, Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 1, 2019 at 2:26 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Tue, Oct 01, 2019 at 09:59:38PM +0100, Russell King - ARM Linux admin =
wrote:
> > On Tue, Oct 01, 2019 at 01:21:44PM -0700, Nick Desaulniers wrote:
> > > On Tue, Oct 1, 2019 at 11:14 AM Russell King - ARM Linux admin
> > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > The whole "let's make inline not really mean inline" is nothing mor=
e
> > > > than a band-aid to the overuse (and abuse) of "inline".
> > >
> > > Let's triple check the ISO C11 draft spec just to be sure:
> > > =C2=A7 6.7.4.6: A function declared with an inline function specifier=
 is an
> > > inline function. Making a
> > > function an inline function suggests that calls to the function be as
> > > fast as possible.
> > > The extent to which such suggestions are effective is
> > > implementation-defined. 139)
> > > 139) For example, an implementation might never perform inline
> > > substitution, or might only perform inline
> > > substitutions to calls in the scope of an inline declaration.
> > > =C2=A7 J.3.8 [Undefined Behavior] Hints: The extent to which suggesti=
ons
> > > made by using the inline function specifier are effective (6.7.4).
> > >
> > > My translation:
> > > "Please don't assume inline means anything."
> > >
> > > For the unspecified GNU C extension __attribute__((always_inline)), i=
t
> > > seems to me like it's meant more for performing inlining (an
> > > optimization) at -O0.  Whether the compiler warns or not seems like a
> > > nice side effect, but provides no strong guarantee otherwise.
> > >
> > > I'm sorry that so much code may have been written with that
> > > assumption, and I'm sorry to be the bearer of bad news, but this isn'=
t
> > > a recent change.  If code was written under false assumptions, it
> > > should be rewritten. Sorry.
> >
> > You may quote C11, but that is not relevent.  The kernel is coded to
> > gnu89 standard - see the -std=3Dgnu89 flag.
>
> There's more to this and why C11 is entirely irrelevant.  The "inline"
> you see in our headers is not the compiler keyword that you find in
> various C standards, it is a macro that gets expanded to either:
>
> #define inline inline __attribute__((__always_inline__)) __gnu_inline \
>         __maybe_unused notrace
>
> or
>
> #define inline inline                                    __gnu_inline \
>         __maybe_unused notrace
>
> __gnu_inline is defined as:
>
> #define __gnu_inline                    __attribute__((__gnu_inline__))
>
> So this attaches the gnu_inline attribute to the function:
>
> `gnu_inline'
>      This attribute should be used with a function that is also declared
>      with the `inline' keyword.  It directs GCC to treat the function
>      as if it were defined in gnu90 mode even when compiling in C99 or
>      gnu99 mode.
> ...
>      Since ISO C99 specifies a different semantics for `inline', this
>      function attribute is provided as a transition measure and as a
>      useful feature in its own right.  This attribute is available in
>      GCC 4.1.3 and later.  It is available if either of the
>      preprocessor macros `__GNUC_GNU_INLINE__' or
>      `__GNUC_STDC_INLINE__' are defined.  *Note An Inline Function is
>      As Fast As a Macro: Inline.
>
> which is quite clear that C99 semantics do not apply to _this_ inline.
> The manual goes on to explain:
>
>  GCC implements three different semantics of declaring a function
> inline.  One is available with `-std=3Dgnu89' or `-fgnu89-inline' or when
> `gnu_inline' attribute is present on all inline declarations, another
> when `-std=3Dc99', `-std=3Dc11', `-std=3Dgnu99' or `-std=3Dgnu11' (withou=
t
> `-fgnu89-inline'), and the third is used when compiling C++.

(I wrote the kernel patch for gnu_inline; it only comes into play when
`inline` appears on a function *also defined as `extern`*).

>
> I'd suggest gnu90 mode is pretty similar to gnu89 mode, and as we build
> the kernel in gnu89 mode, that is the inlining definition that is
> appropriate.
>
> When it comes to __always_inline, the GCC manual is the definitive
> reference, since we use the GCC attribute for that:
>
> #define __always_inline                 inline __attribute__((__always_in=
line__))
>
> and I've already quoted what the GCC manual says for always_inline.
>
> Arguing about what the C11 spec says about inlining when we aren't
> using C11 dialect in the kernel, but are using GCC features, does
> not move the discussion on.
>
> Thanks anyway, maybe it will become relevent in the future if we
> decide to move to C11.

It's not like the semantics of inline are better specified by an older
standard, or changed (The only real semantic change involving `inline`
between ISO C90 and ISO C99 has to do with whether `extern inline`
emits the function with external linkage as you noted).  But that's
irrelevant to the discussion.).  I quoted C11 because ctrl+f doesn't
work for the C90 ISO spec pdf.  C90 spec doesn't even have a section
on Function Specifiers.  From what I can tell, `inline` wasn't
specified until ISO C99.

GNU modes are often modifiers off of ISO C bases; gnu89 corresponds to
ISO C90.  They may permit the use of features from newer ISO C specs
and GNU C extensions without warning under -Wpedantic.  There aren't a
whole lot of semantic differences, at least that I'm aware of.

Please don't assume inline means anything.
--=20
Thanks,
~Nick Desaulniers
