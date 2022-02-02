Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803E34A6F34
	for <lists+linux-arch@lfdr.de>; Wed,  2 Feb 2022 11:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245709AbiBBKyd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Feb 2022 05:54:33 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56748 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbiBBKyc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Feb 2022 05:54:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2CE5B83086;
        Wed,  2 Feb 2022 10:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670A5C340F0;
        Wed,  2 Feb 2022 10:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643799270;
        bh=YaErwgEV6u6M+OhsAi4SczNs7iHw2evXeDZkXFHsX+o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GAGH6R8zllkRqqOh4pWIz7UlLpi/1U+L4KaC/sWRbM0N4aednJldOaN2DgqbCldtm
         n736xh/GuOrES5kfnjVj89yWTotpiQXIjps9fnlgD9kuBGerLNt/7MzVArsIHRj6ix
         Y6zt5wf2OoHD7EREvZDwgGgYx9ldrtXkFiMJcVjQMv9X67Qb4G0mz/hXdRCbNtd20v
         euMsJ66qrMnnGIL4K+lUKSwoUXZaNywemkckZDAGXdbCcx8zYogTgQYpMog/F5WFrT
         3syGzdF+eGZME66Neb3UxeTZLfUPiTf/6nexRxcI44KBVT9Huux2Bqg+TP4CTABnPY
         VaHTHzAJCZjbg==
Received: by mail-wr1-f46.google.com with SMTP id k18so37590153wrg.11;
        Wed, 02 Feb 2022 02:54:30 -0800 (PST)
X-Gm-Message-State: AOAM530deqEq3JSyEX8EFeofHHjZXQCxTNLHqK+3a7gCfRfjRZmvbmLa
        b2X+hxxqm31pfkYvXsK7XaTvqiDE1SL0W6HmFYc=
X-Google-Smtp-Source: ABdhPJxXQnmVGiQ6++DgTKrPDzuwG95DqfKcTlxhLVOsI6p/ssls6IrzqObL5TpmOLh1hayTFyI76Fa7LUWwzVeJ0X8=
X-Received: by 2002:a05:6000:15ca:: with SMTP id y10mr24916503wry.417.1643799268703;
 Wed, 02 Feb 2022 02:54:28 -0800 (PST)
MIME-Version: 1.0
References: <20220131225250.409564-1-ndesaulniers@google.com>
 <CAMj1kXHz9psgjP7qQpusLOOL5Nm7TO+LauD_-mK=Fxe_g7mmsQ@mail.gmail.com>
 <CAKwvOdnkGfeBBE2NW_FKSzmZSjCJXc2801qvvOuyu+JL+m+VZQ@mail.gmail.com>
 <CAMj1kXFnUuWLyy5q-fAV1jwZobTCNHqhKSN3mF98frsJ4ai4Ow@mail.gmail.com> <CAKwvOdn0C4Mt=Nb-HjLQtrsJ=X6zqgMssVHT_2QeZpnjb=-HhA@mail.gmail.com>
In-Reply-To: <CAKwvOdn0C4Mt=Nb-HjLQtrsJ=X6zqgMssVHT_2QeZpnjb=-HhA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 2 Feb 2022 11:54:17 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEaQPg0MfrT3rOthscbXLg7KyymdOVLvWD6E1vvkryAtQ@mail.gmail.com>
Message-ID: <CAMj1kXEaQPg0MfrT3rOthscbXLg7KyymdOVLvWD6E1vvkryAtQ@mail.gmail.com>
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

On Wed, 2 Feb 2022 at 04:26, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Tue, Feb 1, 2022 at 2:15 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Tue, 1 Feb 2022 at 20:40, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > On Tue, Feb 1, 2022 at 1:32 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Mon, 31 Jan 2022 at 23:53, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > > >
> > > > > +     around an asm statement so long as clobbers are not violated. For example,
> > > > > +
> > > > > +       asm volatile ("");
> > > > > +       flag = true;
> > > > > +
> > > > > +     May be modified by the compiler to:
> > > > > +
> > > > > +       flag = true;
> > > > > +       asm volatile ("");
> > > > > +
> > > > > +     Marking an asm statement as volatile is not a substitute for barrier(),
> > > > > +     and is implicit for asm goto statements and asm statements that do not
> > > > > +     have outputs (like the above example). Prefer either:
> > > > > +
> > > > > +       asm ("":::"memory");
> > > > > +       flag = true;
> > > > > +
> > > > > +     Or:
> > > > > +
> > > > > +       asm ("");
> > > > > +       barrier();
> > > > > +       flag = true;
> > > > > +
> > > >
> > > > I would expect the memory clobber to only hazard against the
> > > > assignment of flag if it results in a store, but looking at your
> > > > Godbolt example, this appears to apply even if flag is kept in a
> > > > register.
> > > >
> > > > Is that behavior documented/codified anywhere? Or are we relying on
> > > > compiler implementation details here?
> > >
> > > https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Volatile
> > > "Note that the compiler can move even volatile asm instructions
> > > relative to other code, including across jump instructions."
> > >
> >
> > That doesn't really answer my question. We are documenting here that
> > asm volatile does not prevent reordering but non-volatile asm with a
> > "memory" clobber does, and even prevents reordering of instructions
> > that do not modify memory to begin with.
> >
> > Why is it justified to rely on this undocumented behavior?
>
> I see your point.  You're right, I couldn't find anywhere where such
> behavior was specified.  So the suggestion to use barrier() would rely
> on unspecified behavior and should not be suggested.
>
> Probably worth still mentioning that `volatile` qualifying an asm
> statement doesn't prevent such reordering in this document somehow,
> and perhaps that it's (currently) unspecified whether a barrier() can
> prevent re-ordering with regards to non-memory-modifying instructions.

Yes, and to correct myself here, I meant 'instructions that do not
/reference/ memory to begin with.

I suppose the problem here is that the distinction only matters for
things like objtool obsessing about whether or not instructions look
unreachable, and relying on asm volatile() to insert markers into the
object code.

So it seems we need a stronger clobber, one which avoids any kind of
reordering at the instruction level.
