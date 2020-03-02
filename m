Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B32F17643E
	for <lists+linux-arch@lfdr.de>; Mon,  2 Mar 2020 20:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgCBTtJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Mar 2020 14:49:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:59874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgCBTtJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 2 Mar 2020 14:49:09 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C30124673;
        Mon,  2 Mar 2020 19:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583178548;
        bh=HlCsa0ArCLwoI7Xxr8z/Vi/VuN17RXrK58YUl9Bgh9U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BrzLSRNSfBt1E6Ul1HsC7e8jtgX1OqlBxw0epbcK6jUpgb4fd409QFJFGsjR/p2k6
         2F6a6dLBBU/DOYEHQLH5AriAz6MzIo4ZFtaWVwNB9TFjYkfBydgvbJ6eVVX6wbRNnJ
         oA27nygDXpkRjFW4/4b92C5A0YfKM+qu1cI1TfAQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E4C7535226C8; Mon,  2 Mar 2020 11:49:07 -0800 (PST)
Date:   Mon, 2 Mar 2020 11:49:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, stern@rowland.harvard.edu,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3] tools/memory-model/Documentation: Fix "conflict"
 definition
Message-ID: <20200302194907.GM2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200302172101.157917-1-elver@google.com>
 <20200302185216.GA5320@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302185216.GA5320@andrea>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 02, 2020 at 07:52:16PM +0100, Andrea Parri wrote:
> On Mon, Mar 02, 2020 at 06:21:01PM +0100, Marco Elver wrote:
> > The definition of "conflict" should not include the type of access nor
> > whether the accesses are concurrent or not, which this patch addresses.
> > The definition of "data race" remains unchanged.
> > 
> > The definition of "conflict" as we know it and is cited by various
> > papers on memory consistency models appeared in [1]: "Two accesses to
> > the same variable conflict if at least one is a write; two operations
> > conflict if they execute conflicting accesses."
> > 
> > The LKMM as well as the C11 memory model are adaptations of
> > data-race-free, which are based on the work in [2]. Necessarily, we need
> > both conflicting data operations (plain) and synchronization operations
> > (marked). For example, C11's definition is based on [3], which defines a
> > "data race" as: "Two memory operations conflict if they access the same
> > memory location, and at least one of them is a store, atomic store, or
> > atomic read-modify-write operation. In a sequentially consistent
> > execution, two memory operations from different threads form a type 1
> > data race if they conflict, at least one of them is a data operation,
> > and they are adjacent in <T (i.e., they may be executed concurrently)."
> > 
> > [1] D. Shasha, M. Snir, "Efficient and Correct Execution of Parallel
> >     Programs that Share Memory", 1988.
> > 	URL: http://snir.cs.illinois.edu/listed/J21.pdf
> > 
> > [2] S. Adve, "Designing Memory Consistency Models for Shared-Memory
> >     Multiprocessors", 1993.
> > 	URL: http://sadve.cs.illinois.edu/Publications/thesis.pdf
> > 
> > [3] H.-J. Boehm, S. Adve, "Foundations of the C++ Concurrency Memory
> >     Model", 2008.
> > 	URL: https://www.hpl.hp.com/techreports/2008/HPL-2008-56.pdf
> > 
> > Signed-off-by: Marco Elver <elver@google.com>
> > Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> LGTM:
> 
> Acked-by: Andrea Parri <parri.andrea@gmail.com>

Applied, and thank you as well!

							Thanx, Paul

> Thank you both,
> 
>   Andrea
> 
> 
> > ---
> > v3:
> > * Apply Alan's suggestion.
> > * s/two race candidates/race candidates/
> > 
> > v2: http://lkml.kernel.org/r/20200302141819.40270-1-elver@google.com
> > * Apply Alan's suggested version.
> >   - Move "from different CPUs (or threads)" from "conflict" to "data
> >     race" definition. Update "race candidate" accordingly.
> > * Add citations to commit message.
> > 
> > v1: http://lkml.kernel.org/r/20200228164621.87523-1-elver@google.com
> > ---
> >  .../Documentation/explanation.txt             | 83 ++++++++++---------
> >  1 file changed, 45 insertions(+), 38 deletions(-)
> > 
> > diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> > index e91a2eb19592a..993f800659c6a 100644
> > --- a/tools/memory-model/Documentation/explanation.txt
> > +++ b/tools/memory-model/Documentation/explanation.txt
> > @@ -1987,28 +1987,36 @@ outcome undefined.
> >  
> >  In technical terms, the compiler is allowed to assume that when the
> >  program executes, there will not be any data races.  A "data race"
> > -occurs when two conflicting memory accesses execute concurrently;
> > -two memory accesses "conflict" if:
> > +occurs when there are two memory accesses such that:
> >  
> > -	they access the same location,
> > +1.	they access the same location,
> >  
> > -	they occur on different CPUs (or in different threads on the
> > -	same CPU),
> > +2.	at least one of them is a store,
> >  
> > -	at least one of them is a plain access,
> > +3.	at least one of them is plain,
> >  
> > -	and at least one of them is a store.
> > +4.	they occur on different CPUs (or in different threads on the
> > +	same CPU), and
> >  
> > -The LKMM tries to determine whether a program contains two conflicting
> > -accesses which may execute concurrently; if it does then the LKMM says
> > -there is a potential data race and makes no predictions about the
> > -program's outcome.
> > +5.	they execute concurrently.
> >  
> > -Determining whether two accesses conflict is easy; you can see that
> > -all the concepts involved in the definition above are already part of
> > -the memory model.  The hard part is telling whether they may execute
> > -concurrently.  The LKMM takes a conservative attitude, assuming that
> > -accesses may be concurrent unless it can prove they cannot.
> > +In the literature, two accesses are said to "conflict" if they satisfy
> > +1 and 2 above.  We'll go a little farther and say that two accesses
> > +are "race candidates" if they satisfy 1 - 4.  Thus, whether or not two
> > +race candidates actually do race in a given execution depends on
> > +whether they are concurrent.
> > +
> > +The LKMM tries to determine whether a program contains race candidates
> > +which may execute concurrently; if it does then the LKMM says there is
> > +a potential data race and makes no predictions about the program's
> > +outcome.
> > +
> > +Determining whether two accesses are race candidates is easy; you can
> > +see that all the concepts involved in the definition above are already
> > +part of the memory model.  The hard part is telling whether they may
> > +execute concurrently.  The LKMM takes a conservative attitude,
> > +assuming that accesses may be concurrent unless it can prove they
> > +are not.
> >  
> >  If two memory accesses aren't concurrent then one must execute before
> >  the other.  Therefore the LKMM decides two accesses aren't concurrent
> > @@ -2171,8 +2179,8 @@ again, now using plain accesses for buf:
> >  	}
> >  
> >  This program does not contain a data race.  Although the U and V
> > -accesses conflict, the LKMM can prove they are not concurrent as
> > -follows:
> > +accesses are race candidates, the LKMM can prove they are not
> > +concurrent as follows:
> >  
> >  	The smp_wmb() fence in P0 is both a compiler barrier and a
> >  	cumul-fence.  It guarantees that no matter what hash of
> > @@ -2326,12 +2334,11 @@ could now perform the load of x before the load of ptr (there might be
> >  a control dependency but no address dependency at the machine level).
> >  
> >  Finally, it turns out there is a situation in which a plain write does
> > -not need to be w-post-bounded: when it is separated from the
> > -conflicting access by a fence.  At first glance this may seem
> > -impossible.  After all, to be conflicting the second access has to be
> > -on a different CPU from the first, and fences don't link events on
> > -different CPUs.  Well, normal fences don't -- but rcu-fence can!
> > -Here's an example:
> > +not need to be w-post-bounded: when it is separated from the other
> > +race-candidate access by a fence.  At first glance this may seem
> > +impossible.  After all, to be race candidates the two accesses must
> > +be on different CPUs, and fences don't link events on different CPUs.
> > +Well, normal fences don't -- but rcu-fence can!  Here's an example:
> >  
> >  	int x, y;
> >  
> > @@ -2367,7 +2374,7 @@ concurrent and there is no race, even though P1's plain store to y
> >  isn't w-post-bounded by any marked accesses.
> >  
> >  Putting all this material together yields the following picture.  For
> > -two conflicting stores W and W', where W ->co W', the LKMM says the
> > +race-candidate stores W and W', where W ->co W', the LKMM says the
> >  stores don't race if W can be linked to W' by a
> >  
> >  	w-post-bounded ; vis ; w-pre-bounded
> > @@ -2380,8 +2387,8 @@ sequence, and if W' is plain then they also have to be linked by a
> >  
> >  	w-post-bounded ; vis ; r-pre-bounded
> >  
> > -sequence.  For a conflicting load R and store W, the LKMM says the two
> > -accesses don't race if R can be linked to W by an
> > +sequence.  For race-candidate load R and store W, the LKMM says the
> > +two accesses don't race if R can be linked to W by an
> >  
> >  	r-post-bounded ; xb* ; w-pre-bounded
> >  
> > @@ -2413,20 +2420,20 @@ is, the rules governing the memory subsystem's choice of a store to
> >  satisfy a load request and its determination of where a store will
> >  fall in the coherence order):
> >  
> > -	If R and W conflict and it is possible to link R to W by one
> > -	of the xb* sequences listed above, then W ->rfe R is not
> > -	allowed (i.e., a load cannot read from a store that it
> > +	If R and W are race candidates and it is possible to link R to
> > +	W by one of the xb* sequences listed above, then W ->rfe R is
> > +	not allowed (i.e., a load cannot read from a store that it
> >  	executes before, even if one or both is plain).
> >  
> > -	If W and R conflict and it is possible to link W to R by one
> > -	of the vis sequences listed above, then R ->fre W is not
> > -	allowed (i.e., if a store is visible to a load then the load
> > -	must read from that store or one coherence-after it).
> > +	If W and R are race candidates and it is possible to link W to
> > +	R by one of the vis sequences listed above, then R ->fre W is
> > +	not allowed (i.e., if a store is visible to a load then the
> > +	load must read from that store or one coherence-after it).
> >  
> > -	If W and W' conflict and it is possible to link W to W' by one
> > -	of the vis sequences listed above, then W' ->co W is not
> > -	allowed (i.e., if one store is visible to a second then the
> > -	second must come after the first in the coherence order).
> > +	If W and W' are race candidates and it is possible to link W
> > +	to W' by one of the vis sequences listed above, then W' ->co W
> > +	is not allowed (i.e., if one store is visible to a second then
> > +	the second must come after the first in the coherence order).
> >  
> >  This is the extent to which the LKMM deals with plain accesses.
> >  Perhaps it could say more (for example, plain accesses might
> > -- 
> > 2.25.0.265.gbab2e86ba0-goog
> > 
