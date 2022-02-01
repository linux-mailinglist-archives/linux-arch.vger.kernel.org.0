Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317144A6519
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 20:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiBATkn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Feb 2022 14:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiBATkn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Feb 2022 14:40:43 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D974C061714
        for <linux-arch@vger.kernel.org>; Tue,  1 Feb 2022 11:40:43 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id t14so25596300ljh.8
        for <linux-arch@vger.kernel.org>; Tue, 01 Feb 2022 11:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=viucZbK8l9pSnGBF7R0+9cNuVMcUg5GbbuZi2PaAsjI=;
        b=IVC9fn3GWpLYK/Rr97SW4s+kSIHFCtH/RrxNoL6iSNbu/TAdF8FBA2Pv04ZiMXYRcK
         htp9lfu6QnZMfkwhhJaCNhvgBVtxRdYNqTrsbecSyvx6gVFWqkuUdtzHgqpB3z5A/dx4
         0fmwMuSVKgRoVEf+U3GYxV1AXUxkeBsqfosZjyyl4iwLkoGFMKszaKQvTEMVtqs3BitM
         GAAYhr6rvzFZloNse/nRDHNebWH7pklycGbuJ7Y81A3vyOH24HkC9WjlAGF3mDeH36r/
         eYARvwrXxnEaBqmriI5TIkRHotAjFykXOZ3R1iTABJEhUzFcPWCBn2IUhA2ZYGI3l6JX
         He7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=viucZbK8l9pSnGBF7R0+9cNuVMcUg5GbbuZi2PaAsjI=;
        b=HmG05B5GqYKoHGU5yHD69zUoZL64XYYkWOZeFcn3xXzC/bj3rp51cakYZV7IATJHxz
         TLGL9MdIjQXsJICQOZ9Znfs2L/jQxPxGdnu9IO/iI1aHLFuY0HStiEYHZAZDllN3gmPA
         dOXnfES5l4E6o8IGwDEpzHnI/I0EZfZmZETFx0Qw4HLel2loxJWC16duY++xrsXyWxl6
         NjHCQJ2FV/znrNUgyV+BFgLSOBZ5LfCsor/9PHNUsWCoy/YAEfO0d8mwUZya+M2Crx0L
         qLxYx6ZzkGdpO8Hc4EI2FwPZGr44g0DYArXaFLciqZ6v0B5TJhncbrNXBILFOgVeQJov
         IcKw==
X-Gm-Message-State: AOAM533woXVJADXZC4eMoqAN5JggAeFDTfzrLZDzclGOxf0cJwMqQEC4
        Vk2j9py2LQqM/XgEiDI1cr9NMp8sBUY/rLxABhXyxw==
X-Google-Smtp-Source: ABdhPJwld6fjrnB+EsA02oB0FtfaKr2/cC0LclWTpHjlbogelMMUiOM7Hm10j7grhMBdBzybwXYddNl+yOZS3nqYn3g=
X-Received: by 2002:a2e:7c0c:: with SMTP id x12mr17547887ljc.526.1643744441192;
 Tue, 01 Feb 2022 11:40:41 -0800 (PST)
MIME-Version: 1.0
References: <20220131225250.409564-1-ndesaulniers@google.com> <CAMj1kXHz9psgjP7qQpusLOOL5Nm7TO+LauD_-mK=Fxe_g7mmsQ@mail.gmail.com>
In-Reply-To: <CAMj1kXHz9psgjP7qQpusLOOL5Nm7TO+LauD_-mK=Fxe_g7mmsQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Feb 2022 11:40:29 -0800
Message-ID: <CAKwvOdnkGfeBBE2NW_FKSzmZSjCJXc2801qvvOuyu+JL+m+VZQ@mail.gmail.com>
Subject: Re: [PATCH] docs/memory-barriers.txt: volatile is not a barrier() substitute
To:     Ard Biesheuvel <ardb@kernel.org>
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

On Tue, Feb 1, 2022 at 1:32 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 31 Jan 2022 at 23:53, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > Add text to memory-barriers.txt and deprecated.rst to denote that
> > volatile-qualifying an asm statement is not a substitute for either a
> > compiler barrier (``barrier();``) or a clobber list.
> >
> > This way we can point to this in code that strengthens existing
> > volatile-qualified asm statements to use a compiler barrier.
> >
> > Suggested-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> > Example: https://godbolt.org/z/8PW549zz9
> >
> >  Documentation/memory-barriers.txt    | 24 ++++++++++++++++++++++++
> >  Documentation/process/deprecated.rst | 17 +++++++++++++++++
> >  2 files changed, 41 insertions(+)
> >
> > diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> > index b12df9137e1c..f3908c0812da 100644
> > --- a/Documentation/memory-barriers.txt
> > +++ b/Documentation/memory-barriers.txt
> > @@ -1726,6 +1726,30 @@ of optimizations:
> >       respect the order in which the READ_ONCE()s and WRITE_ONCE()s occur,
> >       though the CPU of course need not do so.
> >
> > + (*) Similarly, the compiler is within its rights to reorder instructions
>
> Similar to what? Was this intended to be the second bullet point
> rather than the first?

Similar to the previous bullet point. This isn't the first use of
`Similarly, ` in this document.

>
> > +     around an asm statement so long as clobbers are not violated. For example,
> > +
> > +       asm volatile ("");
> > +       flag = true;
> > +
> > +     May be modified by the compiler to:
> > +
> > +       flag = true;
> > +       asm volatile ("");
> > +
> > +     Marking an asm statement as volatile is not a substitute for barrier(),
> > +     and is implicit for asm goto statements and asm statements that do not
> > +     have outputs (like the above example). Prefer either:
> > +
> > +       asm ("":::"memory");
> > +       flag = true;
> > +
> > +     Or:
> > +
> > +       asm ("");
> > +       barrier();
> > +       flag = true;
> > +
>
> I would expect the memory clobber to only hazard against the
> assignment of flag if it results in a store, but looking at your
> Godbolt example, this appears to apply even if flag is kept in a
> register.
>
> Is that behavior documented/codified anywhere? Or are we relying on
> compiler implementation details here?

https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Volatile
"Note that the compiler can move even volatile asm instructions
relative to other code, including across jump instructions."

>
>
> >   (*) The compiler is within its rights to invent stores to a variable,
> >       as in the following example:
> >
> > diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
> > index 388cb19f5dbb..432816e2f79e 100644
> > --- a/Documentation/process/deprecated.rst
> > +++ b/Documentation/process/deprecated.rst
> > @@ -329,3 +329,20 @@ struct_size() and flex_array_size() helpers::
> >          instance->count = count;
> >
> >          memcpy(instance->items, source, flex_array_size(instance, items, instance->count));
> > +
> > +Volatile Qualified asm Statements
> > +=================================
> > +
> > +According to `the GCC docs on inline asm
> > +https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Volatile`_:
> > +
> > +  asm statements that have no output operands and asm goto statements,
> > +  are implicitly volatile.
> > +
> > +For many uses of asm statements, that means adding a volatile qualifier won't
> > +hurt (making the implicit explicit), but it will not strengthen the semantics
> > +for such cases where it would have been implied. Care should be taken not to
> > +confuse ``volatile`` with the kernel's ``barrier()`` macro or an explicit
> > +clobber list. See [memory-barriers]_ for more info on ``barrier()``.
> > +
> > +.. [memory-barriers] Documentation/memory-barriers.txt
> > --
> > 2.35.0.rc2.247.g8bbb082509-goog
> >



-- 
Thanks,
~Nick Desaulniers
