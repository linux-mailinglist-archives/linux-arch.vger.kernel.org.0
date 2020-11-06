Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966572A9EA4
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 21:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgKFUka (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 15:40:30 -0500
Received: from netrider.rowland.org ([192.131.102.5]:54119 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728413AbgKFUka (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Nov 2020 15:40:30 -0500
Received: (qmail 55677 invoked by uid 1000); 6 Nov 2020 15:40:08 -0500
Date:   Fri, 6 Nov 2020 15:40:08 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH memory-model 5/8] tools/memory-model: Add a glossary of
 LKMM terms
Message-ID: <20201106204008.GA55521@rowland.harvard.edu>
References: <20201105215953.GA15309@paulmck-ThinkPad-P72>
 <20201105220017.15410-5-paulmck@kernel.org>
 <20201106165930.GC47039@rowland.harvard.edu>
 <20201106180445.GX3249@paulmck-ThinkPad-P72>
 <20201106192351.GA53131@rowland.harvard.edu>
 <20201106195912.GA3249@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106195912.GA3249@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 06, 2020 at 11:59:12AM -0800, Paul E. McKenney wrote:
> On Fri, Nov 06, 2020 at 02:23:51PM -0500, Alan Stern wrote:
> > On Fri, Nov 06, 2020 at 10:04:46AM -0800, Paul E. McKenney wrote:
> > > On Fri, Nov 06, 2020 at 11:59:30AM -0500, Alan Stern wrote:
> > > > > +	 See also "Control Dependency".
> > > > 
> > > > There should also be an entry for "Data Dependency", linked from here
> > > > and from Control Dependency.
> > > > 
> > > > > +Marked Access:  An access to a variable that uses an special function or
> > > > > +	macro such as "r1 = READ_ONCE()" or "smp_store_release(&a, 1)".
> > > > 
> > > > How about "r1 = READ_ONCE(x)"?
> > > 
> > > Good catches!  I am planning to squash the commit below into the
> > > original.  Does that cover it?
> > 
> > No, because you didn't add a glossary entry for "Data Dependency" and 
> > there's no link from "Control Dependency" to "Data Dependency".
> 
> Sigh.  I was thinking "entry in the list", and didn't even thing to
> check for an entry in the glossary as a whole.  With the patch below
> (on top of the one sent earlier), are we good?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 5a49c32551e83d30e304d6c3fbb660737ba2654e
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Fri Nov 6 11:57:25 2020 -0800
> 
>     fixup! tools/memory-model: Add a glossary of LKMM terms
>     
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/tools/memory-model/Documentation/glossary.txt b/tools/memory-model/Documentation/glossary.txt
> index 471bf13..b2da636 100644
> --- a/tools/memory-model/Documentation/glossary.txt
> +++ b/tools/memory-model/Documentation/glossary.txt
> @@ -64,7 +64,7 @@ Control Dependency:  When a later store's execution depends on a test
>  	 fragile, and can be easily destroyed by optimizing compilers.
>  	 Please see control-dependencies.txt for more information.
>  
> -	 See also "Address Dependency".
> +	 See also "Address Dependency" and "Data Dependency".
>  
>  Cycle:	Memory-barrier pairing is restricted to a pair of CPUs, as the
>  	name suggests.	And in a great many cases, a pair of CPUs is all
> @@ -85,6 +85,23 @@ Cycle:	Memory-barrier pairing is restricted to a pair of CPUs, as the
>  
>  	See also "Pairing".
>  
> +Data Dependency:  When the data written by a later store is computed based
> +	on the value returned by an earlier load, a "data dependency"
> +	extends from that load to that later store.  For example:
> +
> +	 1 r1 = READ_ONCE(x);
> +	 2 WRITE_ONCE(y, r1 + 1);
> +
> +	In this case, the data dependency extends from the READ_ONCE()
> +	on line 1 to the WRITE_ONCE() on line 2.  Data dependencies are
> +	fragile and can be easily destroyed by optimizing compilers.
> +	Because optimizing compilers put a great deal of effort into
> +	working out what values integer variables might have, this is
> +	especially true in cases where the dependency is carried through
> +	an integer.
> +
> +	See also "Address Dependency" and "Control Dependency".
> +
>  From-Reads (fr):  When one CPU's store to a given variable happened
>  	too late to affect the value returned by another CPU's
>  	load from that same variable, there is said to be a from-reads

Yes, this is better.

Is it really true that data dependencies are so easily destroyed?  I 
would expect that a true "semantic" dependency (i.e., one where the 
value written really does vary according to the value read) would be 
rather hard to second guess.

Alan
