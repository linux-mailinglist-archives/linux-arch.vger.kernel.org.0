Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEA042D035
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 04:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhJNCQh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Oct 2021 22:16:37 -0400
Received: from netrider.rowland.org ([192.131.102.5]:36745 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229798AbhJNCQh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Oct 2021 22:16:37 -0400
Received: (qmail 910485 invoked by uid 1000); 13 Oct 2021 22:14:31 -0400
Date:   Wed, 13 Oct 2021 22:14:31 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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
Message-ID: <20211014021431.GA910341@rowland.harvard.edu>
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com>
 <87lf3f7eh6.fsf@oldenburg.str.redhat.com>
 <20210929174146.GF22689@gate.crashing.org>
 <2088260319.47978.1633104808220.JavaMail.zimbra@efficios.com>
 <871r54ww2k.fsf@oldenburg.str.redhat.com>
 <CAHk-=wgexLqNnngLPts=wXrRcoP_XHO03iPJbsAg8HYuJbbAvw@mail.gmail.com>
 <87y271yo4l.fsf@mid.deneb.enyo.de>
 <20211014000104.GX880162@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014000104.GX880162@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 13, 2021 at 05:01:04PM -0700, Paul E. McKenney wrote:
> On Sun, Oct 10, 2021 at 04:02:02PM +0200, Florian Weimer wrote:
> > * Linus Torvalds:
> > 
> > > On Fri, Oct 1, 2021 at 9:26 AM Florian Weimer <fweimer@redhat.com> wrote:
> > >>
> > >> Will any conditional branch do, or is it necessary that it depends in
> > >> some way on the data read?
> > >
> > > The condition needs to be dependent on the read.
> > >
> > > (Easy way to see it: if the read isn't related to the conditional or
> > > write data/address, the read could just be delayed to after the
> > > condition and the store had been done).
> > 
> > That entirely depends on how the hardware is specified to work.  And
> > the hardware could recognize certain patterns as always producing the
> > same condition codes, e.g., AND with zero.  Do such tests still count?
> > It depends on what the specification says.
> > 
> > What I really dislike about this: Operators like & and < now have side
> > effects, and is no longer possible to reason about arithmetic
> > expressions in isolation.
> 
> Is there a reasonable syntax that might help with these issues?
> 
> Yes, I know, we for sure have conflicting constraints on "reasonable"
> on copy on this email.  What else is new?  ;-)
> 
> I could imagine a tag of some sort on the load and store, linking the
> operations that needed to be ordered.  You would also want that same
> tag on any conditional operators along the way?  Or would the presence
> of the tags on the load and store suffice?

Here's a easy cop-out.  Imagine a version of READ_ONCE that is 
equivalent to:

	a normal READ_ONCE on TSO architectures,

	a load-acquire on more weakly ordered architectures.

Call it READ_ONCE_FOR_COND, for the sake of argument.  Then as long as 
people are careful to use READ_ONCE_FOR_COND when loading the values 
that a conditional expression depends on, and WRITE_ONCE for the 
important stores in the branches of the "if" statement, all 
architectures will have the desired ordering.  (In fact, if there are 
multiple loads involved in the condition then only the last one has to 
be READ_ONCE_FOR_COND; the others can just be READ_ONCE.)

Of course, this is not optimal on non-TSO archictecture.  That's why I 
called it a cop-out.  But at least it is simple and easy.

Alan Stern
