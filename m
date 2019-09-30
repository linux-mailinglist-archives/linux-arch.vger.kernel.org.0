Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7D2AC2927
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2019 23:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbfI3VuY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Sep 2019 17:50:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40645 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731050AbfI3VuY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Sep 2019 17:50:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id d26so2642006pgl.7
        for <linux-arch@vger.kernel.org>; Mon, 30 Sep 2019 14:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZqLTazAKZGG4KJ4iEi3hzNpvjFqh7JVEXlZWdade0A=;
        b=cB206ZEgRonZzA9R7W2bEe12czYrZkepf8raUEl93I/yZxZo1Jw4kmluZnhffkw2Hz
         2oWyvjF4bnDyf0vqh1F8HJVYGhy8Epba0CrVSh/jRVoeUIruGvrCZ/L/NkRcOMbkOGxy
         eKN0/SNwe6z/DHIETMseeHvpzVHHytSXAC0SZ1VsLCe5z3KScHSwF8KLFlJOsNIm2kpr
         y4Oy5htt/7JyyD/fxIuLtQGeiwyWMCae4sEidLkAVFrl9h1lHYKOkLJuqyzvRiVnhXds
         6wyQzqOa+tdH84XBUzDUjVdNjVujBquh4Mi3uPIR/FNF1bEpGA7yp0j5OAtRvAG6zwfW
         ZcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZqLTazAKZGG4KJ4iEi3hzNpvjFqh7JVEXlZWdade0A=;
        b=m26oGlrk2PxEy4PEh8bd6+Nui15yStcJB3u7//BBYzgMz2U4SPQhP1fyRi9xb3Bv3N
         RPI+8LReo0ni+poQdoBxgMdKj25dYjKGbfAZedPy0xN5m6Nu7arp5hoBliq5sYjrctLn
         iw97qP7Fsx23z2czJESFUWwAZY/S8q9JXd0gbVsAtzZarg9j2qQvqjerhhwSMMkbw8mC
         F5YipcUZTCNGE/F75i7sP4+wr4sb3U8EYwG08z+G2dCzFc8p1EcKVzZOfj/Nm7+/+6c4
         ZbBaKrz6EalLz8rOmyg8Tl+BENSYjFj83ThK0UtpfYDXTXWzoY7/W+IVqSDHfvpfk2nX
         7I5w==
X-Gm-Message-State: APjAAAWoG8ts66UefJTDoajPPaYP0wYGCheRPJbpVJfBTXhe+33w2KcA
        niqExsXCdtwY6BaCPxW13Yix+auBeuhV4eieTvSl4A==
X-Google-Smtp-Source: APXvYqykUm+JhH2ruszuTpI5/UozDNlYHvGqwkze/rZd2c2RIbBqYiB9CeN8PakIgx77lmzWQlcfqx0be21lC06BIac=
X-Received: by 2002:a17:90a:154f:: with SMTP id y15mr645274pja.73.1569880222086;
 Mon, 30 Sep 2019 14:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190830034304.24259-1-yamada.masahiro@socionext.com>
 <f5c221f5749e5768c9f0d909175a14910d349456.camel@suse.de> <CAKwvOdk=tr5nqq1CdZnUvRskaVqsUCP0SEciSGonzY5ayXsMXw@mail.gmail.com>
 <CAHk-=wiTy7hrA=LkmApBE9PQtri8qYsSOrf2zbms_crfjgR=Hw@mail.gmail.com>
 <20190930112636.vx2qxo4hdysvxibl@willie-the-truck> <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck>
In-Reply-To: <20190930121803.n34i63scet2ec7ll@willie-the-truck>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 30 Sep 2019 14:50:10 -0700
Message-ID: <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
To:     Will Deacon <will@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
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

On Mon, Sep 30, 2019 at 5:18 AM Will Deacon <will@kernel.org> wrote:
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
> variables to go wrong. I agree that the ARM code looks dodgy with
> that call to uaccess_save_and_enable(), but there are __asmeq macros
> in there to try to catch that, so it's still very fishy.
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

So __attribute__((always_inline)) doesn't guarantee that code will be
inlined.  For instance in LLVM's inliner, it asks/answers "should I
inline" and "can I inline."  "Should" has to do with a cost model, and
is very heuristic-y.  "Can" has more to do with the transforms, and
whether they're all implemented and safe.  If you if you say
__attribute__((always_inline)), the answer to "can I inline this" can
still be *no*.  The only way to guarantee inlining is via the C
preprocessor.  The only way to prevent inlining is via
__attribute__((no_inline)).  inline and __attribute__((always_inline))
are a heuristic laden mess and should not be relied upon.  I would
also look closely at code that *requires* inlining or the lack there
of to be correct.  That the kernel no longer compiles at -O0 is not a
good thing IMO, and hurts developers that want a short
compile/execute/debug cycle.

In this case, if there's a known codegen bug in a particular compiler
or certain versions of it, I recommend the use of either the C
preprocessor or __attribute__((no_inline)) to get the desired behavior
localized to the function in question, and for us to proceed with
Masahiro's cleanup.

The comment above the use of CONFIG_OPTIMIZE_INLINING in
include/linux/compiler_types.h says:
  * Force always-inline if the user requests it so via the .config.
Which makes me grimace (__attribute__((always_inline)) doesn't *force*
anything as per above), and the idea that forcing things marked inline
to also be __attribute__((always_inline)) is an "optimization" (re:
the name of the config; CONFIG_OPTIMIZE_INLINING) is also highly
suspect.  Aggressive inlining leads to image size bloat, instruction
cache and register pressure; it is not exclusively an optimization.

>
> > The problems are fixable by writing correct code.
>
> Right, in the compiler ;)
>
> > I think we discussed this already.
>
> We did?
>
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



-- 
Thanks,
~Nick Desaulniers
