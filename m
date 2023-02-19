Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4619169C15D
	for <lists+linux-arch@lfdr.de>; Sun, 19 Feb 2023 17:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjBSQsm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Feb 2023 11:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjBSQsl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Feb 2023 11:48:41 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2E40BDBC5
        for <linux-arch@vger.kernel.org>; Sun, 19 Feb 2023 08:48:39 -0800 (PST)
Received: (qmail 1111259 invoked by uid 1000); 19 Feb 2023 11:48:37 -0500
Date:   Sun, 19 Feb 2023 11:48:37 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Joel Fernandes \(Google\)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] tools/memory-model: Add details about SRCU read-side
 critical sections
Message-ID: <Y/JS5SYKPeeDQErL@rowland.harvard.edu>
References: <20230213015506.778246-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213015506.778246-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 13, 2023 at 01:55:06AM +0000, Joel Fernandes (Google) wrote:
> Add details about SRCU read-side critical sections and how they are
> modeled.
> 
> Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> Cc: Luc Maranget <luc.maranget@inria.fr>
> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> ---
>  .../Documentation/explanation.txt             | 55 ++++++++++++++++++-
>  1 file changed, 52 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> index 8e7085238470..5f486d39fe10 100644
> --- a/tools/memory-model/Documentation/explanation.txt
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -28,9 +28,10 @@ Explanation of the Linux-Kernel Memory Consistency Model
>    20. THE HAPPENS-BEFORE RELATION: hb
>    21. THE PROPAGATES-BEFORE RELATION: pb
>    22. RCU RELATIONS: rcu-link, rcu-gp, rcu-rscsi, rcu-order, rcu-fence, and rb
> -  23. LOCKING
> -  24. PLAIN ACCESSES AND DATA RACES
> -  25. ODDS AND ENDS
> +  23. SRCU READ-SIDE CRITICAL SECTIONS
> +  24. LOCKING
> +  25. PLAIN ACCESSES AND DATA RACES
> +  26. ODDS AND ENDS
>  
>  
>  
> @@ -1858,6 +1859,54 @@ links having the same SRCU domain with proper nesting); the details
>  are relatively unimportant.
>  
>  
> +SRCU READ-SIDE CRITICAL SECTIONS
> +--------------------------------
> +An SRCU read-side section is modeled with the srcu-rscs relation and
> +is different from rcu-rscs in the following respects:
> +
> +1. SRCU read-side sections are associated with a specific domain and
> +are independent of ones in different domains. Each domain has their
> +own independent grace-periods.
> +
> +2. Partitially overlapping SRCU read-side sections cannot fuse. It is
> +possible that among 2 partitally overlapping readers, the one that
> +starts earlier, starts before a GP started and the later reader starts
> +after the same GP started. These 2 readers are to be treated as
> +different srcu-rscs even for the same SRCU domain.
> +
> +3. The srcu_down_read() and srcu_up_read() primitives permit an SRCU
> +read-side lock to be acquired on one CPU and released another. While
> +this is also true about preemptible RCU, the LKMM does not model
> +preemption.  So unlike SRCU, RCU readers are still modeled and
> +expected to be locked and unlocked on the same CPU in litmus tests.
> +
> +To make it easy to model SRCU readers in LKMM with the above 3
> +properties, an SRCU lock operation is modeled as a load annotated with
> +'srcu-lock' and an SRCU unlock operation is modeled as a store
> +annotated with 'srcu-unlock'. This load and store takes the memory
> +address of an srcu_struct as an input, and the value returned is the
> +SRCU index (value). Thus LKMM creates a data-dependency between them
> +by virtue of the load and store memory accesses before performed on
> +the same srcu_struct:  R[srcu-lock] ->data W[srcu-unlock].
> +This data dependency becomes: R[srcu-lock] ->srcu-rscs W[srcu-unlock].
> +
> +It is also possible that the data loaded from the R[srcu-lock] is
> +stored back into a memory location, and loaded on the same or even
> +another CPU, before doing an unlock.
> +This becomes:
> +  R[srcu-lock] ->data W[once] ->rf R[once] ->data W[srcu-unlock]
> +
> +The model also treats this chaining of ->data and ->rf relations as:
> +  R[srcu-lock] ->srcu-rscs W[srcu-unlock] by the model.
> +
> +Care must be taken that:
> +  R[srcu-lock] ->data W[srcu-unlock] ->rf R[srcu-lock] is not
> +considered as a part of the above ->data and ->rf chain, which happens
> +because of one reader unlocking and another locking right after it.
> +The model excludes these ->rf relations when building the ->srcu-rscs
> +relation.
> +
> +
>  LOCKING
>  -------
>  

I took the liberty of rewriting your text to make it agree better with 
the style used in the rest of the document.  It ended up getting a lot 
bigger, but I think it will be more comprehensible to readers.  Here is 
the result.

Alan


--- usb-devel.orig/tools/memory-model/Documentation/explanation.txt
+++ usb-devel/tools/memory-model/Documentation/explanation.txt
@@ -28,9 +28,10 @@ Explanation of the Linux-Kernel Memory C
   20. THE HAPPENS-BEFORE RELATION: hb
   21. THE PROPAGATES-BEFORE RELATION: pb
   22. RCU RELATIONS: rcu-link, rcu-gp, rcu-rscsi, rcu-order, rcu-fence, and rb
-  23. LOCKING
-  24. PLAIN ACCESSES AND DATA RACES
-  25. ODDS AND ENDS
+  23. SRCU READ-SIDE CRITICAL SECTIONS
+  24. LOCKING
+  25. PLAIN ACCESSES AND DATA RACES
+  26. ODDS AND ENDS
 
 
 
@@ -1848,14 +1849,157 @@ section in P0 both starts before P1's gr
 before it does, and the critical section in P2 both starts after P1's
 grace period does and ends after it does.
 
-Addendum: The LKMM now supports SRCU (Sleepable Read-Copy-Update) in
-addition to normal RCU.  The ideas involved are much the same as
-above, with new relations srcu-gp and srcu-rscsi added to represent
-SRCU grace periods and read-side critical sections.  There is a
-restriction on the srcu-gp and srcu-rscsi links that can appear in an
-rcu-order sequence (the srcu-rscsi links must be paired with srcu-gp
-links having the same SRCU domain with proper nesting); the details
-are relatively unimportant.
+The LKMM supports SRCU (Sleepable Read-Copy-Update) in addition to
+normal RCU.  The ideas involved are much the same as above, with new
+relations srcu-gp and srcu-rscsi added to represent SRCU grace periods
+and read-side critical sections.  However, there are some important
+differences between RCU read-side critical sections and their SRCU
+counterparts, as described in the next section.
+
+
+SRCU READ-SIDE CRITICAL SECTIONS
+--------------------------------
+
+The LKMM models SRCU read-side critical sections with the srcu-rscsi
+relation.  They are different from RCU read-side critical sections in
+the following respects:
+
+1.	Unlike the analogous RCU primitives, synchronize_srcu(),
+	srcu_read_lock(), and srcu_read_unlock() take a pointer to a
+	struct srcu_struct as an argument.  This structure is called
+	an SRCU domain, and calls linked by srcu-rscsi must have the
+	same domain.  Read-side critical sections and grace periods
+	associated with different domains are independent of one
+	another.  The SRCU version of the RCU Guarantee applies only
+	to pairs of critical sections and grace periods having the
+	same domain.
+
+2.	srcu_read_lock() returns a value, called the index, which must
+	be passed to the matching srcu_read_unlock() call.  Unlike
+	rcu_read_lock() and rcu_read_unlock(), an srcu_read_lock()
+	call does not always have to match the next unpaired
+	srcu_read_unlock().  In fact, it is possible for two SRCU
+	read-side critical sections to overlap partially, as in the
+	following example (where s is an srcu_struct and idx1 and idx2
+	are integer variables):
+
+		idx1 = srcu_read_lock(&s);	// Start of first RSCS
+		idx2 = srcu_read_lock(&s);	// Start of second RSCS
+		srcu_read_unlock(&s, idx1);	// End of first RSCS
+		srcu_read_unlock(&s, idx2);	// End of second RSCS
+
+	The matching is determined entirely by the domain pointer and
+	index value.  By contrast, if the calls had been
+	rcu_read_lock() and rcu_read_unlock() then they would have
+	created two nested (fully overlapping) read-side critical
+	sections: an inner one and an outer one.
+
+3.	The srcu_down_read() and srcu_up_read() primitives work
+	exactly like srcu_read_lock() and srcu_read_unlock(), except
+	that matching calls don't have to execute on the same CPU.
+	Since the matching is determined by the domain pointer and
+	index value, these primitives make it possible for an SRCU
+	read-side critical section to start on one CPU and end on
+	another, so to speak.
+
+The LKMM models srcu_read_lock() as a special type of load event
+(which is appropriate, since it takes a memory location as argument
+and returns a value, just like a load does) and srcu_read_unlock() as
+a special type of store event (again appropriate, since it takes as
+arguments a memory location and a value).  These loads and stores are
+annotated as belonging to the "srcu-lock" and "srcu-unlock" event
+classes respectively.
+
+This approach allows the LKMM to tell which unlock matches a
+particular lock, by checking for the presence of a data dependency
+from the load (srcu-lock) to the store (srcu-unlock).  For example,
+given the situation outlined earlier (with statement labels added):
+
+	A: idx1 = srcu_read_lock(&s);
+	B: idx2 = srcu_read_lock(&s);
+	C: srcu_read_unlock(&s, idx1);
+	D: srcu_read_unlock(&s, idx2);
+
+then the LKMM will treat A and B as loads from s yielding the values
+in idx1 and idx2 respectively.  Similarly, it will treat C and D as
+though they stored the values idx1 and idx2 in s.  The end result is
+as if we had written:
+
+	A: idx1 = READ_ONCE(s);
+	B: idx2 = READ_ONCE(s);
+	C: WRITE_ONCE(s, idx1);
+	D: WRITE_ONCE(s, idx2);
+
+(except for the presence of the special srcu-lock and srcu-unlock
+annotations).  You can see at once that we have A ->data C and
+B ->data D.  These dependencies tells the LKMM that C is the
+srcu-unlock event matching srcu-lock event A, and D is the
+srcu-unlock event matching srcu-lock event B.
+
+This approach is admittedly a hack, and it has the potential to lead
+to problems.  For example, in:
+
+	idx1 = srcu_read_lock(&s);
+	srcu_read_unlock(&s, idx1);
+	idx2 = srcu_read_lock(&s);
+	srcu_read_unlock(&s, idx2);
+
+the LKMM will believe that idx2 must have the same value as idx1,
+since it reads from the immediately preceding store of idx1 in s.
+Fortunately this won't matter, assuming that litmus tests never do
+anything with SRCU index values other than pass them to
+srcu_read_unlock() or srcu_up_read() calls.
+
+However, sometimes it is necessary to store an index value in a
+shared variable temporarily.  In fact, this is the only way for
+srcu_down_read() to pass the index it gets to an srcu_up_read() call
+on a different CPU.  In more detail, we might have:
+
+	struct srcu_struct s;
+	int x;
+
+	P0()
+	{
+		int r0;
+
+		A: r0 = srcu_down_read(s);
+		B: WRITE_ONCE(x, r0);
+	}
+
+	P1()
+	{
+		int r1;
+
+		C: r1 = READ_ONCE(x);
+		D: srcu_up_read(s, r1);
+	}
+
+Assuming that P1 executes after P0 and does read the index value
+stored in x, we can write this (using brackets to represent event
+annotations) as:
+
+	A[srcu-lock] ->data B[once] ->rf C[once] ->data D[srcu-unlock].
+
+The LKMM defines a carries-srcu-data relation to express this
+pattern; it permits multiple instances of a
+
+	data ; rf
+
+pair (that is, a data link followed by an rf link) to occur between an
+srcu-lock event and the final data dependency leading to the matching
+srcu-unlock event.  carry-srcu-data has to be careful that none of the
+intermediate store events in this series are instances of srcu-unlock.
+Without this protection, in a sequence like the one above:
+
+	A: idx1 = srcu_read_lock(&s);
+	B: srcu_read_unlock(&s, idx1);
+	C: idx2 = srcu_read_lock(&s);
+	D: srcu_read_unlock(&s, idx2);
+
+it would appear that B was a store to a temporary variable (i.e., s)
+and C was a load from that variable, thereby allowing carry-srcu-data
+to extend a data dependency from A to D and giving the impression
+that D was the srcu-unlock event matching A's srcu-lock.
 
 
 LOCKING

