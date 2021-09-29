Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8A341D038
	for <lists+linux-arch@lfdr.de>; Thu, 30 Sep 2021 01:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347184AbhI2X6m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Sep 2021 19:58:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347021AbhI2X6m (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Sep 2021 19:58:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BC8760EE4;
        Wed, 29 Sep 2021 23:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632959820;
        bh=u/f62+IedkJJ1rM8oM6PYSLQeoq90oK5VgySaRMYS04=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CtIxkqWtBHqoEQL1QTZ5Mt4pYlJmxf4pB1viCOsHQDqUlD1dYNoYFXBogNo/XNIbP
         HlYhq1CzBbba3d3wF/hD/wlYAJv3FXYft5+sYcL+3+2IMNFQToUfY1lsggZpMgwEAW
         RNN/OTBfR47Y0IvNjF6GCI2XCCW6N5YjRzkPfg8+CKefpbtEN2Il+9BWWt4hbdcJCB
         vVK1fJUIG3LTzw2MGc0ZEI99q+XvfMbH0C6v6ru9/xjUL7r4W3GCTLtsxtJHzHZlOf
         FYr2SRyKpweTf2w/eXYEKV9rY0rw3tFoVrpRPozDJz249TvTsDzf0mFxAF2lvIvRxv
         Y/165HehXOJZA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3037D5C1308; Wed, 29 Sep 2021 16:57:00 -0700 (PDT)
Date:   Wed, 29 Sep 2021 16:57:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        will@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stern@rowland.harvard.edu, parri.andrea@gmail.com,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        linux-toolchains@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
Message-ID: <20210929235700.GF880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com>
 <20210929214703.GG22689@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929214703.GG22689@gate.crashing.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 29, 2021 at 04:47:03PM -0500, Segher Boessenkool wrote:
> Hi!
> 
> On Tue, Sep 28, 2021 at 05:15:07PM -0400, Mathieu Desnoyers wrote:
> > C99 describes that accessing volatile objects are side-effects, and that
> > "at certain specified points in the execution sequence called sequence
> > points, all side effects of previous evaluations shall be complete
> > and no side effects of subsequent evaluations shall have taken
> > place". [2]
> 
> But note that the kernel explicitly uses C89 (with GNU extensions).
> Side effects are largely equal there though.
> 
> Also note that there may no place in the generated machine code that
> corresponds exactly to some sequence point.  Sequence points are a
> concept that applies to the source program and how that executes on the
> abstract machine.

Plus the "as if" rule rears its ugly head in many of these situations.

> > +Because ctrl_dep emits distinct asm volatile within each leg of the if
> > +statement, the compiler cannot transform the two writes to 'b' into a
> > +conditional-move (cmov) instruction, thus ensuring the presence of a
> > +conditional branch.  Also because the ctrl_dep emits asm volatile within
> > +each leg of the if statement, the compiler cannot move the write to 'c'
> > +before the conditional branch.
> 
> I think your reasoning here misses some things.  So many that I don't
> know where to start to list them, every "because" and "thus" here does
> not follow, and even the statements of fact are not a given.
> 
> Why do you want a conditional branch insn at all, anyway?  You really
> want something else as far as I can see.

Because at the assembly language level on some architectures, a
conditional branch instruction provides weak but very real and very
useful memory-ordering properties.  Such a branch orders all loads
whose return values feed into the branch condition before any stores
that execute after the branch does (regardless of whether or not the
branch was taken).  And this is all the ordering that is required for
the use cases that Mathieu is worried about.

Yes, you can use explicit memory-barrier or acquire-load instructions,
but those incur more overhead on some types of hardware.  The code in
question is on a hotpath and is thus performance-critical.

It would be nice to be able to somehow tell the compiler exactly
what the ordering constraints are ("this particular load must be
ordered before these particular stores") and then let it (1) figure
out that a conditional branch will do the trick and (2) generate the
code accordingly.  But last I checked, this was not going to happen any
time soon.  So for the time being, we have to live within the current
capability of the tools that are available to us.

Linus points out that in all the actual control-dependent code in
the Linux kernel, the compiler is going to be hard-pressed to fail
to emit the required branch.  (Or in the case of ARMv8, the required
conditional-move instruction.)

Mathieu, for his part, recently read the relevant portions of
memory-barriers.txt (reproduced below) and would like to simplify these
coding guidlines, which, speaking as the author of those guidelines,
would be an extremely good thing.  His patches are attempting to move
us in that direction.

Alternatives include: (1) Using acquire loads or memory barriers
and accepting the loss in performance, but giving the compiler much
less leeway, (2) Ripping all of the two-legged "if" examples from
memory-barriers.txt and restricting control dependencies to else-less
"if" statements, again giving the compiler less leeway, and (3) Your
ideas here.

Does that help, or am I missing your point?

> It is essential here that there is a READ_ONCE and the WRITE_ONCE.
> Those things might make it work the way you want, but as Linus says this
> is all way too subtle.  Can you include the *_ONCE into the primitive
> itself somehow?

Actually, if the store is not involved in a data race, the WRITE_ONCE()
is not needed.  And in that case, the compiler is much less able to
fail to provide the needed ordering.  (No, the current documentation
does not reflect this.)  But if there is a data race, then your point
is right on the mark -- that WRITE_ONCE() cannot be safely omitted.

But you are absolutely right that the READ_ONCE() or equivalent is not
at all optional.  An example of an acceptable equivalent is an atomic
read-modify-write operation such as atomic_xchg_relaxed().

The question about whether the READ_ONCE() and WRITE_ONCE() can be
incorporated into the macro I leave to Mathieu.  I can certainly see
serious benefits from this approach, at least from a compiler viewpoint.
I must reserve judgment on usability until I see a proposal.

							Thanx, Paul

------------------------------------------------------------------------
Relevant excerpt from memory-barriers.txt
------------------------------------------------------------------------

CONTROL DEPENDENCIES
--------------------

Control dependencies can be a bit tricky because current compilers do
not understand them.  The purpose of this section is to help you prevent
the compiler's ignorance from breaking your code.

A load-load control dependency requires a full read memory barrier, not
simply a data dependency barrier to make it work correctly.  Consider the
following bit of code:

	q = READ_ONCE(a);
	if (q) {
		<data dependency barrier>  /* BUG: No data dependency!!! */
		p = READ_ONCE(b);
	}

This will not have the desired effect because there is no actual data
dependency, but rather a control dependency that the CPU may short-circuit
by attempting to predict the outcome in advance, so that other CPUs see
the load from b as having happened before the load from a.  In such a
case what's actually required is:

	q = READ_ONCE(a);
	if (q) {
		<read barrier>
		p = READ_ONCE(b);
	}

However, stores are not speculated.  This means that ordering -is- provided
for load-store control dependencies, as in the following example:

	q = READ_ONCE(a);
	if (q) {
		WRITE_ONCE(b, 1);
	}

Control dependencies pair normally with other types of barriers.
That said, please note that neither READ_ONCE() nor WRITE_ONCE()
are optional! Without the READ_ONCE(), the compiler might combine the
load from 'a' with other loads from 'a'.  Without the WRITE_ONCE(),
the compiler might combine the store to 'b' with other stores to 'b'.
Either can result in highly counterintuitive effects on ordering.

Worse yet, if the compiler is able to prove (say) that the value of
variable 'a' is always non-zero, it would be well within its rights
to optimize the original example by eliminating the "if" statement
as follows:

	q = a;
	b = 1;  /* BUG: Compiler and CPU can both reorder!!! */

So don't leave out the READ_ONCE().

It is tempting to try to enforce ordering on identical stores on both
branches of the "if" statement as follows:

	q = READ_ONCE(a);
	if (q) {
		barrier();
		WRITE_ONCE(b, 1);
		do_something();
	} else {
		barrier();
		WRITE_ONCE(b, 1);
		do_something_else();
	}

Unfortunately, current compilers will transform this as follows at high
optimization levels:

	q = READ_ONCE(a);
	barrier();
	WRITE_ONCE(b, 1);  /* BUG: No ordering vs. load from a!!! */
	if (q) {
		/* WRITE_ONCE(b, 1); -- moved up, BUG!!! */
		do_something();
	} else {
		/* WRITE_ONCE(b, 1); -- moved up, BUG!!! */
		do_something_else();
	}

Now there is no conditional between the load from 'a' and the store to
'b', which means that the CPU is within its rights to reorder them:
The conditional is absolutely required, and must be present in the
assembly code even after all compiler optimizations have been applied.
Therefore, if you need ordering in this example, you need explicit
memory barriers, for example, smp_store_release():

	q = READ_ONCE(a);
	if (q) {
		smp_store_release(&b, 1);
		do_something();
	} else {
		smp_store_release(&b, 1);
		do_something_else();
	}

In contrast, without explicit memory barriers, two-legged-if control
ordering is guaranteed only when the stores differ, for example:

	q = READ_ONCE(a);
	if (q) {
		WRITE_ONCE(b, 1);
		do_something();
	} else {
		WRITE_ONCE(b, 2);
		do_something_else();
	}

The initial READ_ONCE() is still required to prevent the compiler from
proving the value of 'a'.

In addition, you need to be careful what you do with the local variable 'q',
otherwise the compiler might be able to guess the value and again remove
the needed conditional.  For example:

	q = READ_ONCE(a);
	if (q % MAX) {
		WRITE_ONCE(b, 1);
		do_something();
	} else {
		WRITE_ONCE(b, 2);
		do_something_else();
	}

If MAX is defined to be 1, then the compiler knows that (q % MAX) is
equal to zero, in which case the compiler is within its rights to
transform the above code into the following:

	q = READ_ONCE(a);
	WRITE_ONCE(b, 2);
	do_something_else();

Given this transformation, the CPU is not required to respect the ordering
between the load from variable 'a' and the store to variable 'b'.  It is
tempting to add a barrier(), but this does not help.  The conditional
is gone, and the barrier won't bring it back.  Therefore, if you are
relying on this ordering, you should make sure that MAX is greater than
one, perhaps as follows:

	q = READ_ONCE(a);
	BUILD_BUG_ON(MAX <= 1); /* Order load from a with store to b. */
	if (q % MAX) {
		WRITE_ONCE(b, 1);
		do_something();
	} else {
		WRITE_ONCE(b, 2);
		do_something_else();
	}

Please note once again that the stores to 'b' differ.  If they were
identical, as noted earlier, the compiler could pull this store outside
of the 'if' statement.

You must also be careful not to rely too much on boolean short-circuit
evaluation.  Consider this example:

	q = READ_ONCE(a);
	if (q || 1 > 0)
		WRITE_ONCE(b, 1);

Because the first condition cannot fault and the second condition is
always true, the compiler can transform this example as following,
defeating control dependency:

	q = READ_ONCE(a);
	WRITE_ONCE(b, 1);

This example underscores the need to ensure that the compiler cannot
out-guess your code.  More generally, although READ_ONCE() does force
the compiler to actually emit code for a given load, it does not force
the compiler to use the results.

In addition, control dependencies apply only to the then-clause and
else-clause of the if-statement in question.  In particular, it does
not necessarily apply to code following the if-statement:

	q = READ_ONCE(a);
	if (q) {
		WRITE_ONCE(b, 1);
	} else {
		WRITE_ONCE(b, 2);
	}
	WRITE_ONCE(c, 1);  /* BUG: No ordering against the read from 'a'. */

It is tempting to argue that there in fact is ordering because the
compiler cannot reorder volatile accesses and also cannot reorder
the writes to 'b' with the condition.  Unfortunately for this line
of reasoning, the compiler might compile the two writes to 'b' as
conditional-move instructions, as in this fanciful pseudo-assembly
language:

	ld r1,a
	cmp r1,$0
	cmov,ne r4,$1
	cmov,eq r4,$2
	st r4,b
	st $1,c

A weakly ordered CPU would have no dependency of any sort between the load
from 'a' and the store to 'c'.  The control dependencies would extend
only to the pair of cmov instructions and the store depending on them.
In short, control dependencies apply only to the stores in the then-clause
and else-clause of the if-statement in question (including functions
invoked by those two clauses), not to code following that if-statement.


Note well that the ordering provided by a control dependency is local
to the CPU containing it.  See the section on "Multicopy atomicity"
for more information.


In summary:

  (*) Control dependencies can order prior loads against later stores.
      However, they do -not- guarantee any other sort of ordering:
      Not prior loads against later loads, nor prior stores against
      later anything.  If you need these other forms of ordering,
      use smp_rmb(), smp_wmb(), or, in the case of prior stores and
      later loads, smp_mb().

  (*) If both legs of the "if" statement begin with identical stores to
      the same variable, then those stores must be ordered, either by
      preceding both of them with smp_mb() or by using smp_store_release()
      to carry out the stores.  Please note that it is -not- sufficient
      to use barrier() at beginning of each leg of the "if" statement
      because, as shown by the example above, optimizing compilers can
      destroy the control dependency while respecting the letter of the
      barrier() law.

  (*) Control dependencies require at least one run-time conditional
      between the prior load and the subsequent store, and this
      conditional must involve the prior load.  If the compiler is able
      to optimize the conditional away, it will have also optimized
      away the ordering.  Careful use of READ_ONCE() and WRITE_ONCE()
      can help to preserve the needed conditional.

  (*) Control dependencies require that the compiler avoid reordering the
      dependency into nonexistence.  Careful use of READ_ONCE() or
      atomic{,64}_read() can help to preserve your control dependency.
      Please see the COMPILER BARRIER section for more information.

  (*) Control dependencies apply only to the then-clause and else-clause
      of the if-statement containing the control dependency, including
      any functions that these two clauses call.  Control dependencies
      do -not- apply to code following the if-statement containing the
      control dependency.

  (*) Control dependencies pair normally with other types of barriers.

  (*) Control dependencies do -not- provide multicopy atomicity.  If you
      need all the CPUs to see a given store at the same time, use smp_mb().

  (*) Compilers do not understand control dependencies.  It is therefore
      your job to ensure that they do not break your code.
