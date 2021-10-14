Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F3242DEFB
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 18:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbhJNQQj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 12:16:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233058AbhJNQQf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Oct 2021 12:16:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 695F46101E;
        Thu, 14 Oct 2021 16:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634228070;
        bh=qo6tZ2DoMx9mlcGHtKEdoGaRYAsljJlY+m6yn8oabWw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=umYUGmF0sP/nDt7cBsKHYXC8xWq3hFpctWQfZunc5Se9Axdiq5N4K4KBSyB4aPVqZ
         2J5cypRkg4mGfTkWixJ4NaWbm8rywHuuQm+t7cgr0cQKh3aZUG6eGtHtsK+TAQTIbx
         u2qOz5+jKwU2+puRmZRdUmTxR7CWY8iG3GBnf+iW1SntJ7ucldhffdfZwZRBWgA/X+
         35aqMZPtqJTdLJ5C/lo1AhrzxiOl5DTSUYtlnU00pGCbNU1lfYdl/NFEjS/ER/26Z1
         pcrTfYsZ5fjHJkz8bee/Vd5dWXY4lV4Uyx6uurTc7cqqvO1oCqxp82nY7KKBNbeX2D
         L9OYZJpHUfyUA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3013A5C04CF; Thu, 14 Oct 2021 09:14:30 -0700 (PDT)
Date:   Thu, 14 Oct 2021 09:14:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
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
Message-ID: <20211014161430.GC880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com>
 <87lf3f7eh6.fsf@oldenburg.str.redhat.com>
 <20210929174146.GF22689@gate.crashing.org>
 <2088260319.47978.1633104808220.JavaMail.zimbra@efficios.com>
 <871r54ww2k.fsf@oldenburg.str.redhat.com>
 <CAHk-=wgexLqNnngLPts=wXrRcoP_XHO03iPJbsAg8HYuJbbAvw@mail.gmail.com>
 <87y271yo4l.fsf@mid.deneb.enyo.de>
 <20211014000104.GX880162@paulmck-ThinkPad-P17-Gen-1>
 <20211014021431.GA910341@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014021431.GA910341@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 13, 2021 at 10:14:31PM -0400, Alan Stern wrote:
> On Wed, Oct 13, 2021 at 05:01:04PM -0700, Paul E. McKenney wrote:
> > On Sun, Oct 10, 2021 at 04:02:02PM +0200, Florian Weimer wrote:
> > > * Linus Torvalds:
> > > 
> > > > On Fri, Oct 1, 2021 at 9:26 AM Florian Weimer <fweimer@redhat.com> wrote:
> > > >>
> > > >> Will any conditional branch do, or is it necessary that it depends in
> > > >> some way on the data read?
> > > >
> > > > The condition needs to be dependent on the read.
> > > >
> > > > (Easy way to see it: if the read isn't related to the conditional or
> > > > write data/address, the read could just be delayed to after the
> > > > condition and the store had been done).
> > > 
> > > That entirely depends on how the hardware is specified to work.  And
> > > the hardware could recognize certain patterns as always producing the
> > > same condition codes, e.g., AND with zero.  Do such tests still count?
> > > It depends on what the specification says.
> > > 
> > > What I really dislike about this: Operators like & and < now have side
> > > effects, and is no longer possible to reason about arithmetic
> > > expressions in isolation.
> > 
> > Is there a reasonable syntax that might help with these issues?
> > 
> > Yes, I know, we for sure have conflicting constraints on "reasonable"
> > on copy on this email.  What else is new?  ;-)
> > 
> > I could imagine a tag of some sort on the load and store, linking the
> > operations that needed to be ordered.  You would also want that same
> > tag on any conditional operators along the way?  Or would the presence
> > of the tags on the load and store suffice?
> 
> Here's a easy cop-out.  Imagine a version of READ_ONCE that is 
> equivalent to:
> 
> 	a normal READ_ONCE on TSO architectures,
> 
> 	a load-acquire on more weakly ordered architectures.
> 
> Call it READ_ONCE_FOR_COND, for the sake of argument.  Then as long as 
> people are careful to use READ_ONCE_FOR_COND when loading the values 
> that a conditional expression depends on, and WRITE_ONCE for the 
> important stores in the branches of the "if" statement, all 
> architectures will have the desired ordering.  (In fact, if there are 
> multiple loads involved in the condition then only the last one has to 
> be READ_ONCE_FOR_COND; the others can just be READ_ONCE.)
> 
> Of course, this is not optimal on non-TSO archictecture.  That's why I 
> called it a cop-out.  But at least it is simple and easy.

That is the ARMv8 approach in CONFIG_LTO=y kernels.  ;-)

							Thanx, Paul
