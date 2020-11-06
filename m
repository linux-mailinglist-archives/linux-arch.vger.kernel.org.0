Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F972A9B88
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 19:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgKFSEr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 13:04:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:33736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727155AbgKFSEr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Nov 2020 13:04:47 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52BA4206FA;
        Fri,  6 Nov 2020 18:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604685886;
        bh=h164DUbrltXAvgsRUwKtqAsftPyhoc7Fn/OhofvTlRk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RA/8yJFvpnF0eIgV4Z5w4qpsGAfEKjHOGJXjICr6o+QHlDkMe7yG/Kn0rPv9OO0rh
         YCKzVzwRmPzqc3N9MLrrA7CQbq5aA0KVjcdMxeYTNjkafGr6i41xy78gXDGPzheqI6
         bnf/EtHZkOLnvHV3aF20JZDM3krTPAdsTO/pX3LY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0A6E1352097B; Fri,  6 Nov 2020 10:04:46 -0800 (PST)
Date:   Fri, 6 Nov 2020 10:04:46 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH memory-model 5/8] tools/memory-model: Add a glossary of
 LKMM terms
Message-ID: <20201106180445.GX3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201105215953.GA15309@paulmck-ThinkPad-P72>
 <20201105220017.15410-5-paulmck@kernel.org>
 <20201106165930.GC47039@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106165930.GC47039@rowland.harvard.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 06, 2020 at 11:59:30AM -0500, Alan Stern wrote:
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
> 
> There should also be an entry for "Data Dependency", linked from here
> and from Control Dependency.
> 
> > +Marked Access:  An access to a variable that uses an special function or
> > +	macro such as "r1 = READ_ONCE()" or "smp_store_release(&a, 1)".
> 
> How about "r1 = READ_ONCE(x)"?

Good catches!  I am planning to squash the commit below into the
original.  Does that cover it?

							Thanx, Paul

------------------------------------------------------------------------

commit 27c694f5a049d3edac1f258b888d02650cec936a
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Fri Nov 6 10:02:41 2020 -0800

    squash! tools/memory-model: Add a glossary of LKMM terms
    
    [ paulmck: Apply Alan Stern feedback. ]
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/memory-model/Documentation/glossary.txt b/tools/memory-model/Documentation/glossary.txt
index 383151b..471bf13 100644
--- a/tools/memory-model/Documentation/glossary.txt
+++ b/tools/memory-model/Documentation/glossary.txt
@@ -22,7 +22,7 @@ Address Dependency:  When the address of a later memory access is computed
 	 dependencies.	Please see Documentation/RCU/rcu_dereference.txt
 	 for more information.
 
-	 See also "Control Dependency".
+	 See also "Control Dependency" and "Data Dependency".
 
 Acquire:  With respect to a lock, acquiring that lock, for example,
 	using spin_lock().  With respect to a non-lock shared variable,
@@ -109,7 +109,7 @@ Happens-Before (hb): A relation between two accesses in which LKMM
 	section of explanation.txt.
 
 Marked Access:  An access to a variable that uses an special function or
-	macro such as "r1 = READ_ONCE()" or "smp_store_release(&a, 1)".
+	macro such as "r1 = READ_ONCE(x)" or "smp_store_release(&a, 1)".
 
 	See also "Unmarked Access".
 
