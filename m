Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C86E7CB51D
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2019 09:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbfJDHiM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Oct 2019 03:38:12 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42955 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfJDHiL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Oct 2019 03:38:11 -0400
Received: by mail-oi1-f194.google.com with SMTP id i185so4946289oif.9;
        Fri, 04 Oct 2019 00:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wuBYLzr0+BbgtiiM2Gze6MIPys+898SIQq1AttIPKCY=;
        b=MRd+mGq6ewOTqas5XkvNr1BCOYEjisAhar1cYKA4se1ReDOqYlEWlyH0ChuPqHM+hq
         GhHPMNBEJS7YdFWf1lgmT1s5X9enwNsS3QpSy1qDRPukBh9JVmZE9hpRL0pFT94mVxka
         6OKSuobmi8k87mS/Whe8Q/vTNgB0NTIsofT6C13QCR1rJjoonm4rYQkmDQ8EefSrWixk
         btu7mFcS0xgpi7m940vaGkXkh/7389Bjp/1UlH/SZ7jjsAHHDTGdSyXw0A/5/m2akaAr
         cMIH9mpGoNdzOgZJWU25/YWNtSyN5fH8PH9Lb4tMBw/zTobIQ5ADk/VjrwXWlSDzJPPn
         UMtw==
X-Gm-Message-State: APjAAAWm4d5f0g7lQubuCckHy3uiyAxvRq/R6hZp2iDtC4LYkALmlXzb
        iiYbgVOWsAb31oSmitGLr7OeW2l7JyRF63m/Ju8=
X-Google-Smtp-Source: APXvYqybMp0FEaj/6VXjwoYCvpMKCiGU8vlst863nqQsjUgRkUUJ447YScwV2QQfyq+eaouIIcUkpzJdvKbTdXF75Wg=
X-Received: by 2002:aca:b654:: with SMTP id g81mr5758145oif.153.1570174690802;
 Fri, 04 Oct 2019 00:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190930112636.vx2qxo4hdysvxibl@willie-the-truck>
 <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck> <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck> <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck> <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk> <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
 <20191001181438.GL25745@shell.armlinux.org.uk> <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
 <CAMuHMdWPhE1nNkmL1nj3vpQhB7fP3uDs2i_ZVi0Gf9qij4W2CA@mail.gmail.com>
 <CAHk-=wgFODvdFBHzgVf3JjoBz0z6LZhOm8xvMntsvOr66ASmZQ@mail.gmail.com>
 <CAK7LNARM2jVSdgCDJWDbvVxYLiUR_CFgTPg0nxzbCszSKcx+pg@mail.gmail.com>
 <CAHk-=wiMm3rN15WmiAqMHjC-pakL_b8qgWsPPri0+YLFORT-ZA@mail.gmail.com>
 <CAK7LNATSoOD0g=Aarui6Y26E_YB035NsaPpHxqtBNyw0K0UXVw@mail.gmail.com>
 <CAHk-=wj9Dbom1x7qDfrXgNbjdFa_84bAUMdGigs4sELQQW28wg@mail.gmail.com> <CANiq72k39jKJVDkQVk=OP8zdYEAiLMadnSxDYLFY1gwpKmuo_Q@mail.gmail.com>
In-Reply-To: <CANiq72k39jKJVDkQVk=OP8zdYEAiLMadnSxDYLFY1gwpKmuo_Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Oct 2019 09:37:59 +0200
Message-ID: <CAMuHMdWbv34O6=kR_3UOxvZ4WBmzaPmbGpux+gZCaQo+XLs58A@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Kees Cook <keescook@google.com>, Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Miguel,

On Thu, Oct 3, 2019 at 10:21 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Thu, Oct 3, 2019 at 7:29 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Thu, Oct 3, 2019 at 10:24 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > >
> > > I just want to annotate __always_inline for the case
> > > "2. code that if not inlined is somehow not correct."
> >
> > Oh, I support that entirely - if only for documentation.
> >
> > But I do *not* support the dismissal of the architecture maintainers
> > concerns about "does it work?" and apparently known compiler bugs.
> >
> > > Again, not saying "use a macro".
> >
> > Other people did, though.
> >
> > And there seemed to be little balancing of the pain vs the gain. The
> > gain really isn't that obvious. If the code shrinks by a couple of kB,
> > is that good or bad? Maybe it is smaller, but is it _better_?
>
> I think both positions that people have shown are important to take
> into account.
>
> We should minimize our usage of macros wherever possible and certainly
> not write new ones when another solution is available. But we should
> *also* minimize our dependence on code that "must-be-inlined" to work
> as much as possible.
>
> In particular, I think we should allow to use __always_inline only if
> it doesn't work otherwise, as an alternative before trying the next
> worst solution (macros). And avoid using only "inline" when we
> actually require inlining, of course.
>
> And the reasoning for each usage of __always_inline should have a
> comment (be it "bad codegen", "performance tanks without it",
> "compiler X <= 4.2 refuses to compile"...). Which is also useful for
> compiler folks to grep for cases to improve/fix in their compiler!

First, we had "inline" and normal functions, where "inline" was used to
make sure a function was inlined (e.g. because it contained code paths
that were intended to be optimized away[*]).
Then, the compiler started not honoring the "inline" keyword, so we got
"always_inline", "inline", and normal functions.  With a hack to #define
"inline" to "always_inline" for some compiler versions.

What's next? There should be a way for the programmer to indicate a
function must be inlined.

[*] Some unused  code paths may contain references to symbols that may
    not exist for the current configuration, or not exist at all.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
