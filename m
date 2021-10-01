Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBAE41F5A2
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 21:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354553AbhJATRk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 15:17:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:51183 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231897AbhJATRk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 1 Oct 2021 15:17:40 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 191JAITO005201;
        Fri, 1 Oct 2021 14:10:19 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 191JAGtK005177;
        Fri, 1 Oct 2021 14:10:16 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 1 Oct 2021 14:10:08 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        will@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stern@rowland.harvard.edu, parri.andrea@gmail.com,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        linux-toolchains@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
Message-ID: <20211001191008.GA16711@gate.crashing.org>
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com> <20210929214703.GG22689@gate.crashing.org> <20210929235700.GF880162@paulmck-ThinkPad-P17-Gen-1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929235700.GF880162@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Paul,

On Wed, Sep 29, 2021 at 04:57:00PM -0700, Paul E. McKenney wrote:
> On Wed, Sep 29, 2021 at 04:47:03PM -0500, Segher Boessenkool wrote:
> > On Tue, Sep 28, 2021 at 05:15:07PM -0400, Mathieu Desnoyers wrote:
> > > C99 describes that accessing volatile objects are side-effects, and that
> > > "at certain specified points in the execution sequence called sequence
> > > points, all side effects of previous evaluations shall be complete
> > > and no side effects of subsequent evaluations shall have taken
> > > place". [2]
> > 
> > But note that the kernel explicitly uses C89 (with GNU extensions).
> > Side effects are largely equal there though.
> > 
> > Also note that there may no place in the generated machine code that
> > corresponds exactly to some sequence point.  Sequence points are a
> > concept that applies to the source program and how that executes on the
> > abstract machine.
> 
> Plus the "as if" rule rears its ugly head in many of these situations.

Do you mean 5.1.2.3 (especially /4 and /6) here, or something more?

People are easily fooled into thinking that your C code somehow
corresponds directly to the generated machine code.  Partly that is
because very old compilers did work that way (they did for every
language, not just C, certainly for all imperative languages -- but
people do think C is a one-to-one translation, more than for other
languages).

> > > +Because ctrl_dep emits distinct asm volatile within each leg of the if
> > > +statement, the compiler cannot transform the two writes to 'b' into a
> > > +conditional-move (cmov) instruction, thus ensuring the presence of a
> > > +conditional branch.  Also because the ctrl_dep emits asm volatile within
> > > +each leg of the if statement, the compiler cannot move the write to 'c'
> > > +before the conditional branch.
> > 
> > I think your reasoning here misses some things.  So many that I don't
> > know where to start to list them, every "because" and "thus" here does
> > not follow, and even the statements of fact are not a given.
> > 
> > Why do you want a conditional branch insn at all, anyway?  You really
> > want something else as far as I can see.
> 
> Because at the assembly language level on some architectures, a
> conditional branch instruction provides weak but very real and very
> useful memory-ordering properties.

On some archs, yes.  So what you really want is that effect, not a
conditional branch itself, right?

> Such a branch orders all loads
> whose return values feed into the branch condition before any stores
> that execute after the branch does (regardless of whether or not the
> branch was taken).  And this is all the ordering that is required for
> the use cases that Mathieu is worried about.

Okay.  So you want to order some set of loads A before some stores B,
with a conditional expression C, where A dominates C, and C dominates B.

Is that exactly what is wanted here?  (You can also take B to be all
stores dominated by C, which may be the only case we care about).

> Yes, you can use explicit memory-barrier or acquire-load instructions,
> but those incur more overhead on some types of hardware.  The code in
> question is on a hotpath and is thus performance-critical.

Yes.

> It would be nice to be able to somehow tell the compiler exactly
> what the ordering constraints are ("this particular load must be
> ordered before these particular stores") and then let it (1) figure
> out that a conditional branch will do the trick and (2) generate the
> code accordingly.  But last I checked, this was not going to happen any
> time soon.  So for the time being, we have to live within the current
> capability of the tools that are available to us.

But a conditional branch is not enough for all architectures (most
architectures even!), and for all implementations of the architectures.

> Linus points out that in all the actual control-dependent code in
> the Linux kernel, the compiler is going to be hard-pressed to fail
> to emit the required branch.  (Or in the case of ARMv8, the required
> conditional-move instruction.)

Yes.  But as a compiler person I read all "the compiler is hard-pressed
to do X" as "the compiler will certainly do X in some cases, maybe once
in a million only, but still; and the compiler is perfectly free to do
so, and that may even be a good decision as well".

Wishy-washy code is fine in some places, if you cannot do better, and
you can verify the machine code generated executes as wanted.  This is
not really feasible for a more generic building block that is used in
many disparate places.

> Mathieu, for his part, recently read the relevant portions of
> memory-barriers.txt (reproduced below) and would like to simplify these
> coding guidlines, which, speaking as the author of those guidelines,
> would be an extremely good thing.  His patches are attempting to move
> us in that direction.

Yes.

In general, rules and guidelines should make it easy to use some
feature, and hard to make mistakes in how you use it.  Ideally the
design lf the feature gets you 90% there already.

> Alternatives include: (1) Using acquire loads or memory barriers
> and accepting the loss in performance, but giving the compiler much
> less leeway,

Yes, that is very expensive.  So expensive that it isn't an option for
any case where you would think about using a control dependency, imo.

> (2) Ripping all of the two-legged "if" examples from
> memory-barriers.txt and restricting control dependencies to else-less
> "if" statements, again giving the compiler less leeway, and (3) Your
> ideas here.

In my opinion we should not define this barrier in terms of "if" (and/or
"else") at all.

> Does that help, or am I missing your point?

See just above.

Your comments help reduce impedance mismatch, thanks :-)

> > It is essential here that there is a READ_ONCE and the WRITE_ONCE.
> > Those things might make it work the way you want, but as Linus says this
> > is all way too subtle.  Can you include the *_ONCE into the primitive
> > itself somehow?
> 
> Actually, if the store is not involved in a data race, the WRITE_ONCE()
> is not needed.

True.

> And in that case, the compiler is much less able to
> fail to provide the needed ordering.

GCC will always do stores only where the source code said it should.
This is needed to make anything asynchronous (threads, signals) work.

> (No, the current documentation
> does not reflect this.)  But if there is a data race, then your point
> is right on the mark -- that WRITE_ONCE() cannot be safely omitted.

But the store you care about might not be right there, it may be in some
called function for example, so haing the WRITE_ONCE as part of the
macro is maybe not a good idea.

> But you are absolutely right that the READ_ONCE() or equivalent is not
> at all optional.  An example of an acceptable equivalent is an atomic
> read-modify-write operation such as atomic_xchg_relaxed().
> 
> The question about whether the READ_ONCE() and WRITE_ONCE() can be
> incorporated into the macro I leave to Mathieu.  I can certainly see
> serious benefits from this approach, at least from a compiler viewpoint.
> I must reserve judgment on usability until I see a proposal.

Yeah.  And easy of use (and that means *correct* use) is key.

> However, stores are not speculated.  This means that ordering -is- provided
> for load-store control dependencies, as in the following example:
> 
> 	q = READ_ONCE(a);
> 	if (q) {
> 		WRITE_ONCE(b, 1);
> 	}

Yes, and you do not need a conditional branch (in the generated machine
code) to have such a dependency -- if the READ_ONCE itself is part of
the condition (it is a read of a volatile object after all).

> Control dependencies pair normally with other types of barriers.
> That said, please note that neither READ_ONCE() nor WRITE_ONCE()
> are optional! Without the READ_ONCE(), the compiler might combine the
> load from 'a' with other loads from 'a'.  Without the WRITE_ONCE(),
> the compiler might combine the store to 'b' with other stores to 'b'.

This part only shows some things that could go wrong.  It also assumes
things that aren't true in general, like, the compiler cannot combine
a WRITE_ONCE with another store.

> Either can result in highly counterintuitive effects on ordering.

Yes, and part of that is that the expectations are wrong, are based on
fundamental untruths.

> Worse yet, if the compiler is able to prove (say) that the value of
> variable 'a' is always non-zero, it would be well within its rights
> to optimize the original example by eliminating the "if" statement
> as follows:
> 
> 	q = a;
> 	b = 1;  /* BUG: Compiler and CPU can both reorder!!! */
> 
> So don't leave out the READ_ONCE().

If you do have the READ_ONCE, the compiler has to do the read -- but if
the compiler still knows "a" contains a non-zero value (yes, this can
still happen, if a zero would lead to undefined behaviour for example),
you do not get the dependency between the read and write you may want.

If you *do* want that dependency.  Often that WRITE_ONCE is all you want
in such a case.

[ snip a lot ]

> More generally, although READ_ONCE() does force
> the compiler to actually emit code for a given load, it does not force
> the compiler to use the results.

Exactly.  And it does tell the compiler the result could be anything
(because it is a read of volatile memory), but other things in the
program, or caused by compiler transforms, can change this.

If your program says

	X;

somewhere, the compiler is perfectly within its right to change that to

	if (q)
		X;
	else
		X;

and then optimise the two occurences of X separately.  Now if X contains
some conditional based on "q" itself (which btw makes such a compiler
transform more likely!), things you may not want or expect can happen.

Lastly:

>   (*) Compilers do not understand control dependencies.  It is therefore
>       your job to ensure that they do not break your code.

Compilers understand you want exactly what you wrote.  If you write
something other than what you want, you only will get what you want by
pure luck.


Segher
