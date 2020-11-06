Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07D22A9B5A
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 19:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgKFSBE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 13:01:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:59926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726928AbgKFSBE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Nov 2020 13:01:04 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 547CD22203;
        Fri,  6 Nov 2020 18:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604685663;
        bh=n0G3p7BdaYGi7erIwcoYQVmv5Pz5mY0X6E1tXQdb+NM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hKCqVMMnFfQyPhK91qB7SOEBYTuH0POMMTOg3wrnBiH7dcFn9XkDSt9C0DPaQuCRJ
         ofNE+YAvPXUnFpbMfojJBff1WZrBtM02CkyBOqfE4qRuEQyAolfj2PH8vXjwgLBBKs
         jrKY4CkEgNKQo8NNyGU/d6rEbEfYLa24YxCmOUx0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A80F6352097B; Fri,  6 Nov 2020 10:01:02 -0800 (PST)
Date:   Fri, 6 Nov 2020 10:01:02 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH memory-model 5/8] tools/memory-model: Add a glossary of
 LKMM terms
Message-ID: <20201106180102.GW3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201105215953.GA15309@paulmck-ThinkPad-P72>
 <20201105220017.15410-5-paulmck@kernel.org>
 <20201106014722.GB3025@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106014722.GB3025@boqun-archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 06, 2020 at 09:47:22AM +0800, Boqun Feng wrote:
> On Thu, Nov 05, 2020 at 02:00:14PM -0800, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  tools/memory-model/Documentation/glossary.txt | 155 ++++++++++++++++++++++++++
> >  1 file changed, 155 insertions(+)
> >  create mode 100644 tools/memory-model/Documentation/glossary.txt
> > 
> > diff --git a/tools/memory-model/Documentation/glossary.txt b/tools/memory-model/Documentation/glossary.txt
> > new file mode 100644
> > index 0000000..036fa28
> > --- /dev/null
> > +++ b/tools/memory-model/Documentation/glossary.txt
> > @@ -0,0 +1,155 @@
> > +This document contains brief definitions of LKMM-related terms.  Like most
> > +glossaries, it is not intended to be read front to back (except perhaps
> > +as a way of confirming a diagnosis of OCD), but rather to be searched
> > +for specific terms.
> > +
> > +
> > +Address Dependency:  When the address of a later memory access is computed
> > +	based on the value returned by an earlier load, an "address
> > +	dependency" extends from that load extending to the later access.
> > +	Address dependencies are quite common in RCU read-side critical
> > +	sections:
> > +
> > +	 1 rcu_read_lock();
> > +	 2 p = rcu_dereference(gp);
> > +	 3 do_something(p->a);
> > +	 4 rcu_read_unlock();
> > +
> > +	 In this case, because the address of "p->a" on line 3 is computed
> > +	 from the value returned by the rcu_dereference() on line 2, the
> > +	 address dependency extends from that rcu_dereference() to that
> > +	 "p->a".  In rare cases, optimizing compilers can destroy address
> > +	 dependencies.	Please see Documentation/RCU/rcu_dereference.txt
> > +	 for more information.
> > +
> > +	 See also "Control Dependency".
> > +
> > +Acquire:  With respect to a lock, acquiring that lock, for example,
> > +	using spin_lock().  With respect to a non-lock shared variable,
> > +	a special operation that includes a load and which orders that
> > +	load before later memory references running on that same CPU.
> > +	An example special acquire operation is smp_load_acquire(),
> > +	but atomic_read_acquire() and atomic_xchg_acquire() also include
> > +	acquire loads.
> > +
> > +	When an acquire load returns the value stored by a release store
> > +	to that same variable, then all operations preceding that store
> 
> Change this to:
> 
> 	When an acquire load reads-from a release store
> 
> , and put a reference to "Reads-from"? I think this makes the document
> more consistent in that it makes clear "an acquire load returns the
> value stored by a release store to the same variable" is not a special
> case, it's simple a "Reads-from".
> 
> > +	happen before any operations following that load acquire.
> 
> Add a reference to the definition of "happen before" in explanation.txt?

How about as shown below?  I currently am carrying this as a separate
commit, but I might merge it into this one later on.

							Thanx, Paul

------------------------------------------------------------------------

commit 774a52cd3d80d6b657ae6c14c10bd9fc437068f3
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Fri Nov 6 09:58:01 2020 -0800

    tools/memory-model: Tie acquire loads to reads-from
    
    This commit explicitly makes the connection between acquire loads and
    the reads-from relation.  It also adds an entry for happens-before,
    and refers to the corresponding section of explanation.txt.
    
    Reported-by: Boqun Feng <boqun.feng@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/memory-model/Documentation/glossary.txt b/tools/memory-model/Documentation/glossary.txt
index 3924aca..383151b 100644
--- a/tools/memory-model/Documentation/glossary.txt
+++ b/tools/memory-model/Documentation/glossary.txt
@@ -33,10 +33,11 @@ Acquire:  With respect to a lock, acquiring that lock, for example,
 	acquire loads.
 
 	When an acquire load returns the value stored by a release store
-	to that same variable, then all operations preceding that store
-	happen before any operations following that load acquire.
+	to that same variable, (in other words, the acquire load "reads
+	from" the release store), then all operations preceding that
+	store "happen before" any operations following that load acquire.
 
-	See also "Relaxed" and "Release".
+	See also "Happens-Before", "Reads-From", "Relaxed", and "Release".
 
 Coherence (co):  When one CPU's store to a given variable overwrites
 	either the value from another CPU's store or some later value,
@@ -102,6 +103,11 @@ Fully Ordered:  An operation such as smp_mb() that orders all of
 	that orders all of its CPU's prior accesses, itself, and
 	all of its CPU's subsequent accesses.
 
+Happens-Before (hb): A relation between two accesses in which LKMM
+	guarantees the first access precedes the second.  For more
+	detail, please see the "THE HAPPENS-BEFORE RELATION: hb"
+	section of explanation.txt.
+
 Marked Access:  An access to a variable that uses an special function or
 	macro such as "r1 = READ_ONCE()" or "smp_store_release(&a, 1)".
 
