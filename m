Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AA05A1BFD
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 00:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiHYWM0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Aug 2022 18:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244122AbiHYWMY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 18:12:24 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A177AB2D80;
        Thu, 25 Aug 2022 15:12:21 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 27PLvwJJ030264;
        Thu, 25 Aug 2022 16:57:58 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 27PLvtxj030255;
        Thu, 25 Aug 2022 16:57:55 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 25 Aug 2022 16:57:54 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 44/45] mm: fs: initialize fsdata passed to write_begin/write_end interface
Message-ID: <20220825215754.GI25951@gate.crashing.org>
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-45-glider@google.com> <YsNIjwTw41y0Ij0n@casper.infradead.org> <CAG_fn=VbvbYVPfdKXrYRTq7HwmvXPQUeUDWZjwe8x8W=ttq6KA@mail.gmail.com> <CAHk-=wg-LXL4ZDMveCf9M7gWWwCMDG1dHCjD7g1u_vUXsU6Bzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg-LXL4ZDMveCf9M7gWWwCMDG1dHCjD7g1u_vUXsU6Bzw@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 25, 2022 at 09:33:18AM -0700, Linus Torvalds wrote:
> On Thu, Aug 25, 2022 at 8:40 AM Alexander Potapenko <glider@google.com> wrote:
> >
> > On Mon, Jul 4, 2022 at 10:07 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > ... wait, passing an uninitialised variable to a function *which doesn't
> > > actually use it* is now UB?  What genius came up with that rule?  What
> > > purpose does it serve?
> > >
> >
> > There is a discussion at [1], with Segher pointing out a reason for
> > this rule [2] and Linus requesting that we should be warning about the
> > cases where uninitialized variables are passed by value.
> 
> I think Matthew was actually more wondering how that UB rule came to be.
> 
> Personally, I pretty much despise *all* cases of "undefined behavior",

Let me start by saying you're not alone.  But some UB *cannot* be worked
around by compilers (we cannot solve the halting problem), and some is
very expensive to work around (initialising huge structures is a
typical example).

Many (if not most) instances of undefined behaviour are unavoidable with
a language like C.  A very big part of this is separate compilation,
that is, compiling translation units separately from each other, so that
the compiler does not see all the ways that something is used when it is
compiling it.  There only is UB if something is *used*.

> but "uninitialized argument" across a function call is one of the more
> understandable ones.

Allowing this essentially never allows generating better machine code,
so there are no real arguments for ever allowing it, other than just
inertia: uninitialised everything else is allowed just fine, and only
actually *using* such data is UB.  Passing it around is not!  That is
how everything used to work (with static data, automatic data, function
parameters, the lot).

But it now is clarified that passing data to a function as function
argument is a use of that data by itself, even if the function will not
even look at it ever.

> I personally was actually surprised compilers didn't warn for "you are
> using an uninitialized value" for a function call argument, because I
> mentally consider function call arguments to *be* a use of a value.

The function call is a use of all passed arguments.

> Except when the function is inlined, and then it's all different - the
> call itself goes away, and I *expect* the compiler to DTRT and not
> "use" the argument except when it's used inside the inlined function.

> Because hey, that's literally the whole point of inlining, and it
> makes the "static checking" problem go away at least for a compiler.

But UB is defined in terms of the abstract machine (like *all* of C),
not in terms of the generated machine code.  Typically things will work
fine if they "become invisible" by inlining, but this does not make the
program a correct program ever.  Sorry :-(


Segher
