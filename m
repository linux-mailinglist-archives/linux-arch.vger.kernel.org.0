Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7144841AF
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jan 2022 13:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiADMhV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 07:37:21 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:50163 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229502AbiADMhV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 Jan 2022 07:37:21 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 204CaGdq001762;
        Tue, 4 Jan 2022 13:36:16 +0100
Date:   Tue, 4 Jan 2022 13:36:16 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0000/2297] [ANNOUNCE, RFC] "Fast Kernel Headers" Tree
 -v1: Eliminate the Linux kernel's "Dependency Hell"
Message-ID: <20220104123616.GA1584@1wt.eu>
References: <YdIfz+LMewetSaEB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdIfz+LMewetSaEB@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Ingo!

First, great work! I'm particularly interested in this work because I
went through a similar process a bout 6 months ago in haproxy and saved
40-45% build time, and thought how well the same principles could apply
to the kernel if anyone had felt brave enough to engage into that. I do
appreciate how tedious a work it can be and do really sympathise with
you on this! A few comments below:

On Sun, Jan 02, 2022 at 10:57:35PM +0100, Ingo Molnar wrote:
>  - Uninlining: there's a number of unnecessary inline functions that also
>    couple otherwise unrelated headers to each other. The fast-headers tree
>    contains over 100 uninlining commits.
> 
>  - Type & API header decoupling. This is one of the most effective techniques
>    to reduce size - but it can rarely be done in a straightforward fashion,
>    and has to be prepared by various decoupling measures, such as the moving
>    of inline functions or the creation of new headers for less frequently used
>    APIs and types.

These were the main two key points I went through as well and found them
to be extremely effective. The essential build time in my case came from
the same inline functions being built hundreds of times for nothing, just
because a header file was included for just one type. I had already
decoupled types and API long ago but that didn't stand long enough for a
few files that were included everywhere. What I noticed is that ideally
we'd need to have 3 layers:
  - types alone
  - function prototypes alone, depending on the former if needed
  - inline functions, depending on the two former ones, if needed

Most code doesn't need need the inline functions, especially other headers,
and being able to only cross-include type definitions is extremely helpful.

In my case something that further improved this effectiveness was to use a
lot more incomplete types everywhere possible. There's no reason to include
foo.h just to have a definition of "struct foo" from "bar.h" if you're only
using it as a pointer in "struct bar". Just prepend "struct foo;" before
struct bar and be done with it.

This showed me how horrible typedefs are: there seems to be no way to
create incomplete definitions for them. So I had to create an even lower
level tiny include file for just the few ones I needed (mostly ints).

I hadn't found a perfect way to deal with macros. Sometimes you consider
them as inline functions and they seem to be better placed there, and
sometimes you figure they are used in type declarations and you have to
have them somewhere else. And when a macro is needed between multiple
type definitions (e.g. an array size), it becomes more delicate because
you quickly realize that a dedicated file for all such settings would
make sense, but it can complicate maintenance.

Another point I didn't feel brave enough to experiment with was to guard
include files around the #include directive in order to avoid opening
the files at all. In my case the C files are huge so such savings could
have been small. There are definitely savings to do there but this looked
too complicated to maintain. And I don't think that #pragma once would be
any effective alternative.

>  - For the 'reference' subsystem of the scheduler, I also improved build speed by
>    consolidating .c files into roughly equal size build units. Instead of 20+
>    separate .o's, there's now just 4 .o's being built. Obviously this approach
>    does not scale to the over 30,000 .c files in the kernel, but I wanted to
>    demonstrate it because optimizing at that level brings the next level of build
>    performance, and it might be feasible for a handful of other core kernel subsystems.

I tried this as well for the sake of avoiding to reprocess the same header
files multiple times but it was too difficult and I gave up. I'd be tempted
to encourage developers to write a bit less but larger files, but these can
also become a maintenance nightmare, they tend to be much slower to build
when too big, and they do parallelize less well, so a balance has to be
found, and if the headers hell is better addressed, then this becomes less
important.

I noticed that you measured the number of includes per file. I did the
same by counting the references to the include files in the preprocessed
output, but ultimately found an easier metric: the total preprocessed
size. I simply replaced "-c" with "-E" in my makefile, and ran
"find . -name '*.o' | grep '^[^#]' | xargs cat | wc" to observe the output,
since in the end, that's what is really fed to the compiler. I overall
found that metric to be a relatively accurate representation of an
expected build time. It's particularly interesting because it's much
faster to obtain than a full build and can easily show you that some
optimizations have absolutely zero effect (typically because most
includes are guarded and what's not included at some place will be at
another one).

In my project I noticed that the total preprocessed size was initially
around 50-60 times larger than the total C+H files. After optimizing it
went down to around 20 times, which is roughly in line with the build
time savings.

Just my two cents, kudos for working on this!
Willy
