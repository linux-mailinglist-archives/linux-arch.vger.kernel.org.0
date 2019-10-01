Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 733D5C3A94
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2019 18:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfJAQck (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Oct 2019 12:32:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45900 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfJAQci (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Oct 2019 12:32:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id y72so8363367pfb.12
        for <linux-arch@vger.kernel.org>; Tue, 01 Oct 2019 09:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mLm3V78Nb0tq/zcNx2mEABQ569cNGACMXUe9AHxZPCM=;
        b=KfJfkHUPequyd3hiy6z2aKGGX/2G6xIjF3IGbgcrndrvKmDDvI76B+oMbXDdMdg517
         7edd6KGmmYrM2HwZ/3YzIKefoAxO253iSyU+LYLxXm3AaLtv/VZCRLbZoH8NQxeXa6pv
         J0isUOh100Oj3CFe+3gjGZgQzfQ+3KP9bcY2FZnKxR20621nZ3qfGIspGrq/3cvA6dip
         s3Vy3cGduEnepXlDYeBqVwIitR4pPBFGO+ohkowH5zGuez/DXehdcPAopmI7/uq9EPZA
         QebtST4zNTHcOYeuaFZTLQQuomMjnd+MgBL+uQoNJ7pCZ/taZ8X6TnOtsvs1qN7CIe7P
         w/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLm3V78Nb0tq/zcNx2mEABQ569cNGACMXUe9AHxZPCM=;
        b=ANEeB4/09mbDERU5oArI6KfVw99RaBn9KbBacfufqLZuSm+OjfsEgvx/qsDeevcXm3
         GEFMj1QzqEjXtbl++GUImqhkHaBioCn843qHd2ceK8u6pp+/8ABezlf6Xo9mdc2JSpGB
         V5f0r2+FQu04tZV0NZ+V5ysL4DhcevCagsvEJHcMvILFPGDKv3B53B86ajFH0x+5JQW0
         yIf5XSDLL3onz1ng6RgHkIfVlE49Mf7VHbm0q3MxuvN8LUdp0DZ8DYOVtH6Vrat9K3LM
         P1FopqT5bKARE5WB/2Sd9B2svFp1YIa+eEv50e96WXnbeTGNwLympqr/F8Y/T68xMUFQ
         xvtA==
X-Gm-Message-State: APjAAAXTm/Nk1Y8YUJ/j4SGrOIh02qN8mfJoJwoYiJH5zAeggXCL9RHh
        WRRKAsnCqMSBrVgH9+sb5LL8Ga3NZXypouItys6aYg==
X-Google-Smtp-Source: APXvYqxM+Y+20EHpLWfowfTRI98iZfd4uSIoBLzJYFhy1Zn7Y/nYzmkfx/vq5P/+m6teNiozD6Sg0C1nlHzdmJV2m20=
X-Received: by 2002:a17:90a:154f:: with SMTP id y15mr741498pja.73.1569947556644;
 Tue, 01 Oct 2019 09:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190830034304.24259-1-yamada.masahiro@socionext.com>
 <f5c221f5749e5768c9f0d909175a14910d349456.camel@suse.de> <CAKwvOdk=tr5nqq1CdZnUvRskaVqsUCP0SEciSGonzY5ayXsMXw@mail.gmail.com>
 <CAHk-=wiTy7hrA=LkmApBE9PQtri8qYsSOrf2zbms_crfjgR=Hw@mail.gmail.com>
 <20190930112636.vx2qxo4hdysvxibl@willie-the-truck> <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck> <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck>
In-Reply-To: <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Oct 2019 09:32:25 -0700
Message-ID: <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
To:     Will Deacon <will@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Stefan Wahren <wahrenst@gmx.net>,
        Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 1, 2019 at 2:28 AM Will Deacon <will@kernel.org> wrote:
>
> Hi Nick,
>
> On Mon, Sep 30, 2019 at 02:50:10PM -0700, Nick Desaulniers wrote:
> > So __attribute__((always_inline)) doesn't guarantee that code will be
> > inlined.  For instance in LLVM's inliner, it asks/answers "should I
> > inline" and "can I inline."  "Should" has to do with a cost model, and
> > is very heuristic-y.  "Can" has more to do with the transforms, and
> > whether they're all implemented and safe.  If you if you say
> > __attribute__((always_inline)), the answer to "can I inline this" can
> > still be *no*.  The only way to guarantee inlining is via the C
> > preprocessor.  The only way to prevent inlining is via
> > __attribute__((no_inline)).  inline and __attribute__((always_inline))
> > are a heuristic laden mess and should not be relied upon.  I would
> > also look closely at code that *requires* inlining or the lack there
> > of to be correct.  That the kernel no longer compiles at -O0 is not a
> > good thing IMO, and hurts developers that want a short
> > compile/execute/debug cycle.
> >
> > In this case, if there's a known codegen bug in a particular compiler
> > or certain versions of it, I recommend the use of either the C
> > preprocessor or __attribute__((no_inline)) to get the desired behavior
> > localized to the function in question, and for us to proceed with
> > Masahiro's cleanup.
>
> Hmm, I don't see how that would help. The problem occurs when things
> are moved out of line by the compiler (see below).

It's being moved out of line because __attribute__((always_inline)) or
just inline provide no guarantees that outlining does not occur.  It
would help to make functions that need to be inlined macros, because
the C preprocessor doesn't have that issue.

>
> > The comment above the use of CONFIG_OPTIMIZE_INLINING in
> > include/linux/compiler_types.h says:
> >   * Force always-inline if the user requests it so via the .config.
> > Which makes me grimace (__attribute__((always_inline)) doesn't *force*
> > anything as per above), and the idea that forcing things marked inline
> > to also be __attribute__((always_inline)) is an "optimization" (re:
> > the name of the config; CONFIG_OPTIMIZE_INLINING) is also highly
> > suspect.  Aggressive inlining leads to image size bloat, instruction
> > cache and register pressure; it is not exclusively an optimization.
>
> Agreed on all of this, but the fact remains that GCC has been shown to
> *miscompile* the arm64 kernel with CONFIG_OPTIMIZE_INLINING=y. Please,
> look at this thread:
>
>         https://www.spinics.net/lists/arm-kernel/msg730329.html
>         https://www.spinics.net/lists/arm-kernel/msg730512.html
>
> GCC decides to pull an atomic operation out-of-line and, in doing so,

If the function is incorrect unless inlined, use a macro.

> gets the register allocations subtly wrong when passing a 'register'
> variable into an inline asm. I would like to avoid this sort of thing
> happening, since it can result in really nasty bugs that manifest at
> runtime and are extremely difficult to debug, which is why I would much
> prefer not to have this option on by default for arm64. I sent a patch
> already:
>
>         https://lkml.kernel.org/r/20190930114540.27498-1-will@kernel.org
>
> and I'm happy to spin a v2 which depends on !CC_IS_CLANG as well.

For small things like whether we mark a function always_inline or not,
I think it's simpler to just keep the code consistent between
compilers, even if it's to work around a bug in one compiler.  A
comment in the code would be sufficient.

>
> Reducing the instruction cache footprint is great, but not if the
> resulting code is broken!

You don't have to convince compiler folks about correctness. ;)
Correctness trumps all, especially performance.
-- 
Thanks,
~Nick Desaulniers
