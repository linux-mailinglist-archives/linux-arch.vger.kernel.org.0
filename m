Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFC99C306D
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2019 11:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbfJAJkX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Oct 2019 05:40:23 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:16399 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfJAJkX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Oct 2019 05:40:23 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x919eCmr022885;
        Tue, 1 Oct 2019 18:40:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x919eCmr022885
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569922813;
        bh=3V7aaYqhxC5BWbE2V8bCYYqxY61b5KQqAWJ0GbYioNA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vEt6vx8vIiQic53N8LCpChPBKKv5IuD8NQ3zcaLelBpc4Xx0eQns8R18kxyNYLZFd
         gS0oNQhqjIyWvytM4eIbTESY1A/9nJ89GneqpeVi8MSgWTsnkRMzONhbVv6DT9kYU5
         7dr5pJxeEcyj4/UY4eYhbcn52rOI471oWQAKivQiIanUjDnV7ou4JYLMhkiV5NR5Wu
         LJTJkoyP5lmtq9wUNlgwJkZq1ZvA/zJP9fsxFjxax0lAEhYb1kvr0hTvPkk25gLlDN
         y/j2qQfrBgj4pUqVdJZsBtmS/aZrlcmpFj9txRGAEgf1OPWwxb8EdoHZzB86qXFwNr
         vEjnc/eKFb9lg==
X-Nifty-SrcIP: [209.85.222.175]
Received: by mail-qk1-f175.google.com with SMTP id 4so10538038qki.6;
        Tue, 01 Oct 2019 02:40:12 -0700 (PDT)
X-Gm-Message-State: APjAAAWMsojs4df0obyqQtXM8MwSqcH+amvxt4c1Jq58PQ6BzVIis4YU
        hqjwRAdewcfRPCJgdVM5DSXlU2pVMMF+IhsSVnM=
X-Google-Smtp-Source: APXvYqx3747F01iyltNZuVgBlzwxxAtNyoutc/XTgXJGchEeXxcvnVor2dyKR5qbk7oXmxJz9xqYgnSl10uif+pM/lQ=
X-Received: by 2002:a05:620a:7da:: with SMTP id 26mr4584394qkb.119.1569922811597;
 Tue, 01 Oct 2019 02:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190830034304.24259-1-yamada.masahiro@socionext.com>
 <f5c221f5749e5768c9f0d909175a14910d349456.camel@suse.de> <CAKwvOdk=tr5nqq1CdZnUvRskaVqsUCP0SEciSGonzY5ayXsMXw@mail.gmail.com>
 <CAHk-=wiTy7hrA=LkmApBE9PQtri8qYsSOrf2zbms_crfjgR=Hw@mail.gmail.com>
 <20190930112636.vx2qxo4hdysvxibl@willie-the-truck> <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck>
In-Reply-To: <20190930121803.n34i63scet2ec7ll@willie-the-truck>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 1 Oct 2019 18:39:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT8vx=vEwaj2=JYHzCYa_J68-TSmjN+sHZeaQYyWV95yw@mail.gmail.com>
Message-ID: <CAK7LNAT8vx=vEwaj2=JYHzCYa_J68-TSmjN+sHZeaQYyWV95yw@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
To:     Will Deacon <will@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
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

Hi Will,

On Mon, Sep 30, 2019 at 9:18 PM Will Deacon <will@kernel.org> wrote:
>
> On Mon, Sep 30, 2019 at 09:05:11PM +0900, Masahiro Yamada wrote:
> > On Mon, Sep 30, 2019 at 8:26 PM Will Deacon <will@kernel.org> wrote:
> > > On Fri, Sep 27, 2019 at 03:38:44PM -0700, Linus Torvalds wrote:
> > > > Soem of that code is pretty subtle. They have fixed register usage
> > > > (but the asm macros actually check them). And the inline asms clobber
> > > > the link register, but they do seem to clearly _state_ that they
> > > > clobber it, so who knows.
> > > >
> > > > Just based on the EFAULT, I'd _guess_ that it's some interaction with
> > > > the domain access control register (so that get/set_domain() thing).
> > > > But I'm not even sure that code is enabled for the Rpi2, so who
> > > > knows..
> > >
> > > FWIW, we've run into issues with CONFIG_OPTIMIZE_INLINING and local
> > > variables marked as 'register' where GCC would do crazy things and end
> > > up corrupting data, so I suspect the use of fixed registers in the arm
> > > uaccess functions is hitting something similar:
> > >
> > > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91111
> >
> > No. Not similar at all.
>
> They're similar in that enabling CONFIG_OPTIMIZE_INLINING causes register
> variables to go wrong.

You are just looking at the result, not the cause.


> I agree that the ARM code looks dodgy with
> that call to uaccess_save_and_enable(), but there are __asmeq macros
> in there to try to catch that, so it's still very fishy.

I am totally fine with double-checking
the output from the compiler.


>
> > I fixed it already. See
> > https://lore.kernel.org/patchwork/patch/1132459/
>
> You fixed the specific case above for 32-bit ARM, but the arm64 case
> is due to a compiler bug. As it happens, we've reworked our atomics
> in 5.4 so that particular issue no longer triggers, but the fact remains
> that GCC has been shown to screw up explicit register allocation for
> perfectly legitimate code when giving the flexibility to move code out
> of line.
>
> > The problems are fixable by writing correct code.
>
> Right, in the compiler ;)

Not always.

You showed a compiler bug case for arm64.
The 32bit ARM is not the case.


>
> > I think we discussed this already.
>
> We did?


https://www.spinics.net/lists/arm-kernel/msg754567.html

This is a bug in the kernel code.



> > - There is nothing arch-specific in CONFIG_OPTIMIZE_INLINING
>
> Apart from the bugs... and even then, that's just based on reports.
>
> > - 'inline' is just a hint. It does not guarantee function inlining.
> >   This is standard.
> >
> > - The kernel macrofies 'inline' to add __attribute__((__always_inline__))
> >   This terrible hack must end.
>
> I'm all for getting rid of hacks, but not at the cost of correctness.
>
> > -  __attribute__((__always_inline__)) takes aways compiler's freedom,
> >    and prevents it from optimizing the code for -O2, -Os, or whatever.
>
> s/whatever/miscompiling the code/
>
> If it helps, here is more information about the arm64 failure which
> triggered the GCC bugzilla:
>
> https://www.spinics.net/lists/arm-kernel/msg730329.html
>
> Will

You put multiple references here and there,
but they are all about arch_atomic64_dec_if_positive().


--
Best Regards
Masahiro Yamada
