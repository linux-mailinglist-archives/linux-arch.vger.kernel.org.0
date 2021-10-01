Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C5A41F7C8
	for <lists+linux-arch@lfdr.de>; Sat,  2 Oct 2021 00:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355862AbhJAWzP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 18:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230433AbhJAWzO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 1 Oct 2021 18:55:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BA4761246;
        Fri,  1 Oct 2021 22:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633128810;
        bh=hwwRiiFVSWnkgHurMzBivt2JjCVQgMPgonw/bt+T2FM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VXFOVqDdUneCm69Jgcy3yqEOQLDK1GQk5Mazsme+/KD2pLz4AeiUGpYAT4Vjp/RDn
         6G0egNJna7QeGba0IpWJt7fu6cnaYPH+VnOX6Ic7xSV5T6kjE+feQ2GsycaYEjvBtk
         iT4rUVIkuK1XMpkhd/Bgi7kmKzABb8z+6aqVf6Mo/PVgotsnIZNlPu6Fu+x25iIZjd
         mi09E8kh1CoqMh4fBWtuF7Ju7ZUPqlQbvxSdY6lheMDxQ9Z5uQ5vtn/qGv1q5LNQap
         x3iLvpgtuJfd5yEQkCaN6yMGCh5ZNH9/GxabSzGU/mHgXrpKZVNtv4y7/uL9mlHlOX
         8cbleAHvLTeXA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E39695C12B1; Fri,  1 Oct 2021 15:53:29 -0700 (PDT)
Date:   Fri, 1 Oct 2021 15:53:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        j alglave <j.alglave@ucl.ac.uk>,
        luc maranget <luc.maranget@inria.fr>,
        akiyks <akiyks@gmail.com>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
Message-ID: <20211001225329.GN880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com>
 <20210929214703.GG22689@gate.crashing.org>
 <20210929235700.GF880162@paulmck-ThinkPad-P17-Gen-1>
 <971151132.46974.1633102138685.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <971151132.46974.1633102138685.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 01, 2021 at 11:28:58AM -0400, Mathieu Desnoyers wrote:
> ----- On Sep 29, 2021, at 7:57 PM, paulmck paulmck@kernel.org wrote:
> 
> > On Wed, Sep 29, 2021 at 04:47:03PM -0500, Segher Boessenkool wrote:
> >> Hi!
> >> 
> >> On Tue, Sep 28, 2021 at 05:15:07PM -0400, Mathieu Desnoyers wrote:
> >> > C99 describes that accessing volatile objects are side-effects, and that
> >> > "at certain specified points in the execution sequence called sequence
> >> > points, all side effects of previous evaluations shall be complete
> >> > and no side effects of subsequent evaluations shall have taken
> >> > place". [2]
> >> 
> >> But note that the kernel explicitly uses C89 (with GNU extensions).
> >> Side effects are largely equal there though.
> >> 
> >> Also note that there may no place in the generated machine code that
> >> corresponds exactly to some sequence point.  Sequence points are a
> >> concept that applies to the source program and how that executes on the
> >> abstract machine.
> > 
> > Plus the "as if" rule rears its ugly head in many of these situations.
> > 
> >> > +Because ctrl_dep emits distinct asm volatile within each leg of the if
> >> > +statement, the compiler cannot transform the two writes to 'b' into a
> >> > +conditional-move (cmov) instruction, thus ensuring the presence of a
> >> > +conditional branch.  Also because the ctrl_dep emits asm volatile within
> >> > +each leg of the if statement, the compiler cannot move the write to 'c'
> >> > +before the conditional branch.
> >> 
> >> I think your reasoning here misses some things.  So many that I don't
> >> know where to start to list them, every "because" and "thus" here does
> >> not follow, and even the statements of fact are not a given.
> >> 
> >> Why do you want a conditional branch insn at all, anyway?  You really
> >> want something else as far as I can see.
> > 
> > Because at the assembly language level on some architectures, a
> > conditional branch instruction provides weak but very real and very
> > useful memory-ordering properties.  Such a branch orders all loads
> > whose return values feed into the branch condition before any stores
> > that execute after the branch does (regardless of whether or not the
> > branch was taken).  And this is all the ordering that is required for
> > the use cases that Mathieu is worried about.
> > 
> > Yes, you can use explicit memory-barrier or acquire-load instructions,
> > but those incur more overhead on some types of hardware.  The code in
> > question is on a hotpath and is thus performance-critical.
> > 
> > It would be nice to be able to somehow tell the compiler exactly
> > what the ordering constraints are ("this particular load must be
> > ordered before these particular stores") and then let it (1) figure
> > out that a conditional branch will do the trick and (2) generate the
> > code accordingly.  But last I checked, this was not going to happen any
> > time soon.  So for the time being, we have to live within the current
> > capability of the tools that are available to us.
> > 
> > Linus points out that in all the actual control-dependent code in
> > the Linux kernel, the compiler is going to be hard-pressed to fail
> > to emit the required branch.  (Or in the case of ARMv8, the required
> > conditional-move instruction.)
> > 
> > Mathieu, for his part, recently read the relevant portions of
> > memory-barriers.txt (reproduced below) and would like to simplify these
> > coding guidlines, which, speaking as the author of those guidelines,
> > would be an extremely good thing.  His patches are attempting to move
> > us in that direction.
> > 
> > Alternatives include: (1) Using acquire loads or memory barriers
> > and accepting the loss in performance, but giving the compiler much
> > less leeway, (2) Ripping all of the two-legged "if" examples from
> > memory-barriers.txt and restricting control dependencies to else-less
> > "if" statements, again giving the compiler less leeway, and (3) Your
> > ideas here.
> > 
> > Does that help, or am I missing your point?
> 
> Thanks Paul, it does help explaining the motivation for relying on
> control dependencies for some fast-path memory ordering in the kernel.
> 
> And yes, my main goal is to simplify the coding guide lines, but I have
> not found any example of bad generated code in the tree kernel at this
> point. In some cases (e.g. uses of smp_acquire__after_ctrl_dep()) it's
> mainly thanks to luck though.
> 
> There is another alternative we could list here: implement ctrl_dep_true(),
> ctrl_dep_false() and ctrl_dep(), which would respectively ensure a
> control dependency on the then leg, on the else leg, or on both legs of
> a conditional expression evaluation.
> 
> > 
> >> It is essential here that there is a READ_ONCE and the WRITE_ONCE.
> >> Those things might make it work the way you want, but as Linus says this
> >> is all way too subtle.  Can you include the *_ONCE into the primitive
> >> itself somehow?
> > 
> > Actually, if the store is not involved in a data race, the WRITE_ONCE()
> > is not needed.  And in that case, the compiler is much less able to
> > fail to provide the needed ordering.  (No, the current documentation
> > does not reflect this.)  But if there is a data race, then your point
> > is right on the mark -- that WRITE_ONCE() cannot be safely omitted.
> > 
> > But you are absolutely right that the READ_ONCE() or equivalent is not
> > at all optional.  An example of an acceptable equivalent is an atomic
> > read-modify-write operation such as atomic_xchg_relaxed().
> > 
> > The question about whether the READ_ONCE() and WRITE_ONCE() can be
> > incorporated into the macro I leave to Mathieu.  I can certainly see
> > serious benefits from this approach, at least from a compiler viewpoint.
> > I must reserve judgment on usability until I see a proposal.
> 
> [...]
> 
> After having audited thoroughly all obviously documented control dependencies
> in the kernel tree, I'm not sure that including the READ_ONCE() and WRITE_ONCE()
> with the ctrl_dep() macro is a good idea, because in some cases there is
> calculation to be done on the result of the READ_ONCE() (e.g. through
> a static inline) before handing it over to the conditional expression.
> In other cases many stores are being done after the control dependency, e.g.:
> 
> kernel/events/ring_buffer.c:__perf_output_begin()
> 
>         do {
>                 tail = READ_ONCE(rb->user_page->data_tail);
>                 offset = head = local_read(&rb->head);
>                 if (!rb->overwrite) {
>                         if (unlikely(!ring_buffer_has_space(head, tail,
>                                                             perf_data_size(rb),
>                                                             size, backward)))
>                                 goto fail;
>                 }
> 
>                 /*
>                  * The above forms a control dependency barrier separating the
>                  * @tail load above from the data stores below. Since the @tail
>                  * load is required to compute the branch to fail below.
>                  *
>                  * A, matches D; the full memory barrier userspace SHOULD issue
>                  * after reading the data and before storing the new tail
>                  * position.
>                  *
>                  * See perf_output_put_handle().
>                  */
> 
>                 if (!backward)
>                         head += size;
>                 else
>                         head -= size;
>         } while (local_cmpxchg(&rb->head, offset, head) != offset);
> 
>         if (backward) {
>                 offset = head;
>                 head = (u64)(-head);
>         }
> 
>         /*
>          * We rely on the implied barrier() by local_cmpxchg() to ensure
>          * none of the data stores below can be lifted up by the compiler.
>          */
> 
> [...]

Indeed, these things do not necessarily fit a nice simple pattern.

> Note that I suspect that this control dependency documentation could be
> improved to state that the first control dependency is with the following
> local_cmpxchg store, which itself has a control dependency (when it evaluates
> to false) with the following stores to the ring buffer. Those are not volatile
> stores, but the "memory" clobber with the local_cmpxchg should ensure that
> following stores are after the local_cmpxchg in program order.
> 
> One other thing we could do to improve things slightly would be to turn
> smp_acquire__after_ctrl_dep() into something which really is an acquire
> in all cases, which may not currently be true if the compiler finds a
> matching barrier()/smp_rmb() in the other leg after the conditional
> expression.

Tools to post-process binaries have been suggested in other venues,
but there would still need to be a way to tell the tool what the
constraints are.

							Thanx, Paul
