Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D61B4A679E
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 23:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237249AbiBAWPz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Feb 2022 17:15:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54974 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiBAWPz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Feb 2022 17:15:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22B93B82FB9;
        Tue,  1 Feb 2022 22:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B313BC340F4;
        Tue,  1 Feb 2022 22:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643753751;
        bh=j9fLPxs1iagx6L4etF2ktFreBgCWfItK2kWeSLCYSCk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nkdDHrmwIRn2HYguSi4pW+DkBxu48GmWWyRrGpMstneLQLoVzX0is3xr4x/hZ1Bjr
         f0OKsRYXqfu3n2C6rjytpesqZGVDOcDzYTghblYzOjlIdDMncDSD2Ny3FmKPowH64U
         BFQfcWha4HmkfMPAFI90yhtGGxm58EwW35Lf16FPiCHq3l9P11sJg9TNUVNgbkA9v/
         j5LGvy1N7qVpiWdF0sRsDp2BCafgUYbJH4Kq6om6ukxpaoN7S6PSf7VYwxSAdJI9x3
         xf4JN41D4i/Ij4GuhQX7r2KYAB9rbguf8yzGhsC5EUblAviqz+CQFIe6/vWvPSuQAx
         RQBTWHYl+if9g==
Received: by mail-wr1-f44.google.com with SMTP id l25so34604837wrb.13;
        Tue, 01 Feb 2022 14:15:51 -0800 (PST)
X-Gm-Message-State: AOAM5323TqFjEN1SuimdPmsXdLc+N/0tXDj1Kx79yuX+gD1BUcj81Pr1
        Ru86kE9JlF4uSb75CjcH/sHLfWAZ017OCHeURwY=
X-Google-Smtp-Source: ABdhPJzgPe6aAtYkFuRrcOMkkoNw3wzWRiYmrDgSz2pBPUpj52vklxmCWt3eMMJS7MOAni2N89aSZPc1EcT+TZVos4I=
X-Received: by 2002:a05:6000:1c9:: with SMTP id t9mr23503888wrx.550.1643753749810;
 Tue, 01 Feb 2022 14:15:49 -0800 (PST)
MIME-Version: 1.0
References: <20220131225250.409564-1-ndesaulniers@google.com>
 <CAMj1kXHz9psgjP7qQpusLOOL5Nm7TO+LauD_-mK=Fxe_g7mmsQ@mail.gmail.com> <CAKwvOdnkGfeBBE2NW_FKSzmZSjCJXc2801qvvOuyu+JL+m+VZQ@mail.gmail.com>
In-Reply-To: <CAKwvOdnkGfeBBE2NW_FKSzmZSjCJXc2801qvvOuyu+JL+m+VZQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 1 Feb 2022 23:15:37 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFnUuWLyy5q-fAV1jwZobTCNHqhKSN3mF98frsJ4ai4Ow@mail.gmail.com>
Message-ID: <CAMj1kXFnUuWLyy5q-fAV1jwZobTCNHqhKSN3mF98frsJ4ai4Ow@mail.gmail.com>
Subject: Re: [PATCH] docs/memory-barriers.txt: volatile is not a barrier() substitute
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, llvm@lists.linux.dev,
        Kees Cook <keescook@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Len Baker <len.baker@gmx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 1 Feb 2022 at 20:40, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Tue, Feb 1, 2022 at 1:32 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Mon, 31 Jan 2022 at 23:53, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > Add text to memory-barriers.txt and deprecated.rst to denote that
> > > volatile-qualifying an asm statement is not a substitute for either a
> > > compiler barrier (``barrier();``) or a clobber list.
> > >
> > > This way we can point to this in code that strengthens existing
> > > volatile-qualified asm statements to use a compiler barrier.
> > >
> > > Suggested-by: Kees Cook <keescook@chromium.org>
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > ---
> > > Example: https://godbolt.org/z/8PW549zz9
> > >
> > >  Documentation/memory-barriers.txt    | 24 ++++++++++++++++++++++++
> > >  Documentation/process/deprecated.rst | 17 +++++++++++++++++
> > >  2 files changed, 41 insertions(+)
> > >
> > > diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> > > index b12df9137e1c..f3908c0812da 100644
> > > --- a/Documentation/memory-barriers.txt
> > > +++ b/Documentation/memory-barriers.txt
> > > @@ -1726,6 +1726,30 @@ of optimizations:
> > >       respect the order in which the READ_ONCE()s and WRITE_ONCE()s occur,
> > >       though the CPU of course need not do so.
> > >
> > > + (*) Similarly, the compiler is within its rights to reorder instructions
> >
> > Similar to what? Was this intended to be the second bullet point
> > rather than the first?
>
> Similar to the previous bullet point. This isn't the first use of
> `Similarly, ` in this document.
>

Ah right, I misread the context and thought you were inserting this
bullet point at the start. Sorry for the noise.

> >
> > > +     around an asm statement so long as clobbers are not violated. For example,
> > > +
> > > +       asm volatile ("");
> > > +       flag = true;
> > > +
> > > +     May be modified by the compiler to:
> > > +
> > > +       flag = true;
> > > +       asm volatile ("");
> > > +
> > > +     Marking an asm statement as volatile is not a substitute for barrier(),
> > > +     and is implicit for asm goto statements and asm statements that do not
> > > +     have outputs (like the above example). Prefer either:
> > > +
> > > +       asm ("":::"memory");
> > > +       flag = true;
> > > +
> > > +     Or:
> > > +
> > > +       asm ("");
> > > +       barrier();
> > > +       flag = true;
> > > +
> >
> > I would expect the memory clobber to only hazard against the
> > assignment of flag if it results in a store, but looking at your
> > Godbolt example, this appears to apply even if flag is kept in a
> > register.
> >
> > Is that behavior documented/codified anywhere? Or are we relying on
> > compiler implementation details here?
>
> https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Volatile
> "Note that the compiler can move even volatile asm instructions
> relative to other code, including across jump instructions."
>

That doesn't really answer my question. We are documenting here that
asm volatile does not prevent reordering but non-volatile asm with a
"memory" clobber does, and even prevents reordering of instructions
that do not modify memory to begin with.

Why is it justified to rely on this undocumented behavior?


> >
> >
> > >   (*) The compiler is within its rights to invent stores to a variable,
> > >       as in the following example:
> > >
> > > diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
> > > index 388cb19f5dbb..432816e2f79e 100644
> > > --- a/Documentation/process/deprecated.rst
> > > +++ b/Documentation/process/deprecated.rst
> > > @@ -329,3 +329,20 @@ struct_size() and flex_array_size() helpers::
> > >          instance->count = count;
> > >
> > >          memcpy(instance->items, source, flex_array_size(instance, items, instance->count));
> > > +
> > > +Volatile Qualified asm Statements
> > > +=================================
> > > +
> > > +According to `the GCC docs on inline asm
> > > +https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Volatile`_:
> > > +
> > > +  asm statements that have no output operands and asm goto statements,
> > > +  are implicitly volatile.
> > > +
> > > +For many uses of asm statements, that means adding a volatile qualifier won't
> > > +hurt (making the implicit explicit), but it will not strengthen the semantics
> > > +for such cases where it would have been implied. Care should be taken not to
> > > +confuse ``volatile`` with the kernel's ``barrier()`` macro or an explicit
> > > +clobber list. See [memory-barriers]_ for more info on ``barrier()``.
> > > +
> > > +.. [memory-barriers] Documentation/memory-barriers.txt
> > > --
> > > 2.35.0.rc2.247.g8bbb082509-goog
> > >
>
>
>
> --
> Thanks,
> ~Nick Desaulniers
