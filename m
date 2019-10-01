Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99EE8C41B6
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2019 22:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfJAUV6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Oct 2019 16:21:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36754 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfJAUV6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Oct 2019 16:21:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id y22so8893351pfr.3
        for <linux-arch@vger.kernel.org>; Tue, 01 Oct 2019 13:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O3nprpczOYxtdd8ScPY3MhrdWBir8yiSGFH+vgNdqwU=;
        b=LxyFxDLxC6BLWinXmves+Z2YK6aEpy6qut/yqGVCOSexQI9Ci9PHEqqWR7oApv/VA6
         dVM13D7WP9ceBYycuYU498kaNVL1DrhlEWIAPTbV3mNg7VhCIvIjlTOMmfeHzaCC4YFG
         LTQsWsQnmGTBbG3vsQ9oxIOzCGRJldbZPo2R45nMtWz34BXnTMqz6mAsyZvoxRQYE1Hu
         pO5tJ3U1svzF/RwAccOjxUZOsvYfUdNaiq6sskVew4U7vgGbDzk5VGMHC0OK/5NCnDRN
         KozbchRrEFc2YDL+WhAuGrJbjYRjpRj+G/Zq9y82ojBzXCLnW3dM11JgD8AAM541VXR7
         /eBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O3nprpczOYxtdd8ScPY3MhrdWBir8yiSGFH+vgNdqwU=;
        b=c4CPbo1z4MnCkBMXd/sdFKiXN0cc1tnNBpxtVKBTqr/WY75o+h1OrSDssMvl4QYqa3
         K8EDZMH6nfw6srboVDoftnEVzoXzFe4JgVpP5kpfjcI4mBbEDWYyD/10DcH1NkNmFjmV
         hn2srBVCGspFRN6je3G2mB6PsR9Q+Y4QjxA6d4G6ZaNaPwEJp9AzSiu2Mxt6oUXxvzIq
         WUIhF+RuxBEq0cUm8gV0fJPit9G9/lP9JsKwEaTzP0z6GzxkZB/B1k0ISTjc/A8IaaKJ
         DxkVNbeZ/Ln7r1maM0rJhUA9PsD1v9pf4C6JbcGDGfmV1YVyytsBoQcgdomM4+Jvvps7
         v2Qw==
X-Gm-Message-State: APjAAAWq2TTWXQ45yxOCnamv3Qa1MXuLWOCE2fO9ZBzoS0mdJcpevvO9
        B3y+F9uall2rXMIgZ0LxsfejrMdK9xn5p+k7vCL3Tg==
X-Google-Smtp-Source: APXvYqyCV5SYUmFWQFUGtDllbVt+Rao8Kq65DjTW+hovP1CgxL0tquouUsm2OgxtNjsTUrlcGBdipv3seffo86hPp3A=
X-Received: by 2002:a63:7153:: with SMTP id b19mr31503598pgn.10.1569961316418;
 Tue, 01 Oct 2019 13:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190930112636.vx2qxo4hdysvxibl@willie-the-truck>
 <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck> <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck> <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck> <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk> <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
 <20191001181438.GL25745@shell.armlinux.org.uk>
In-Reply-To: <20191001181438.GL25745@shell.armlinux.org.uk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Oct 2019 13:21:44 -0700
Message-ID: <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
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

On Tue, Oct 1, 2019 at 11:14 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Tue, Oct 01, 2019 at 11:00:11AM -0700, Nick Desaulniers wrote:
> > On Tue, Oct 1, 2019 at 10:55 AM Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Tue, Oct 01, 2019 at 10:44:43AM -0700, Nick Desaulniers wrote:
> > > > I apologize; I don't mean to be difficult.  I would just like to av=
oid
> > > > surprises when code written with the assumption that it will be
> > > > inlined is not.  It sounds like we found one issue in arm32 and one=
 in
> > > > arm64 related to outlining.  If we fix those two cases, I think we'=
re
> > > > close to proceeding with Masahiro's cleanup, which I view as a good
> > > > thing for the health of the Linux kernel codebase.
> > >
> > > Except, using the C preprocessor for this turns the arm32 code into
> > > yuck:
> > >
> > > 1. We'd need to turn get_domain() and set_domain() into multi-line
> > >    preprocessor macro definitions, using the GCC ({ }) extension
> > >    so that get_domain() can return a value.
> > >
> > > 2. uaccess_save_and_enable() and uaccess_restore() also need to
> > >    become preprocessor macro definitions too.
> > >
> > > So, we end up with multiple levels of nested preprocessor macros.
> > > When something goes wrong, the compiler warning/error message is
> > > going to be utterly _horrid_.
> >
> > That's why I preferred V1 of Masahiro's patch, that fixed the inline
> > asm not to make use of caller saved registers before calling a
> > function that might not be inlined.
>
> ... which I objected to based on the fact that this uaccess stuff is
> supposed to add protection against the kernel being fooled into
> accessing userspace when it shouldn't.  The whole intention there is
> that [sg]et_domain(), and uaccess_*() are _always_ inlined as close
> as possible to the call site of the accessor touching userspace.

Then use the C preprocessor to force the inlining.  I'm sorry it's not
as pretty as static inline functions.

>
> Moving it before the assignments mean that the compiler is then free
> to issue memory loads/stores to load up those registers, which is
> exactly what we want to avoid.
>
>
> In any case, I violently disagree with the idea that stuff we have
> in header files should be permitted not to be inlined because we
> have soo much that is marked inline.

So there's a very important subtly here.  There's:
1. code that adds `inline` cause "oh maybe it would be nice to inline
this, but if it isn't no big deal"
2. code that if not inlined is somehow not correct.
3. avoid ODR violations via `static inline`

I'll posit that "we have soo much that is marked inline [is
predominantly case 1 or 3, not case 2]."  Case 2 is a code smell, and
requires extra scrutiny.

> Having it moved out of line,
> and essentially the same function code appearing in multiple C files
> is really not an improvement over the current situation with excessive
> use of inlining.  Anyone who has looked at the code resulting from
> dma_map_single() will know exactly what I'm talking about, which is
> way in excess of the few instructions we have for the uaccess_* stuff
> here.
>
> The right approach is to move stuff out of line - and by that, I
> mean _actually_ move the damn code, so that different compilation
> units can use the same instructions, and thereby gain from the
> whole point of an instruction cache.

And be marked __attribute__((noinline)), otherwise might be inlined via LTO=
.

>
> The whole "let's make inline not really mean inline" is nothing more
> than a band-aid to the overuse (and abuse) of "inline".

Let's triple check the ISO C11 draft spec just to be sure:
=C2=A7 6.7.4.6: A function declared with an inline function specifier is an
inline function. Making a
function an inline function suggests that calls to the function be as
fast as possible.
The extent to which such suggestions are effective is
implementation-defined. 139)
139) For example, an implementation might never perform inline
substitution, or might only perform inline
substitutions to calls in the scope of an inline declaration.
=C2=A7 J.3.8 [Undefined Behavior] Hints: The extent to which suggestions
made by using the inline function specifier are effective (6.7.4).

My translation:
"Please don't assume inline means anything."

For the unspecified GNU C extension __attribute__((always_inline)), it
seems to me like it's meant more for performing inlining (an
optimization) at -O0.  Whether the compiler warns or not seems like a
nice side effect, but provides no strong guarantee otherwise.

I'm sorry that so much code may have been written with that
assumption, and I'm sorry to be the bearer of bad news, but this isn't
a recent change.  If code was written under false assumptions, it
should be rewritten. Sorry.
--=20
Thanks,
~Nick Desaulniers
