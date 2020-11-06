Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680812A9E51
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 20:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgKFT7O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 14:59:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:46666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbgKFT7N (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Nov 2020 14:59:13 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD9CF2072E;
        Fri,  6 Nov 2020 19:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604692752;
        bh=9mX9TvEO8rw24AB+IUBS/bq7dIXKxdoLl+nP5eU+nZI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=foJOOv/3lMxXk+DmEKgp2fKE3zd4I3NEK/ih6koyTwEV67pj70ZDYPh0uhQ+3V8Fj
         ajX67ekBjmRI0TUhBgU5ZNUIjIZjUpxE1XRDVwxudXShVaoSWouATMBCSmu7gUfLt0
         KSKcZOxtrZWRr1vjy32pG2nIO8pL7Ory+LkVzwHU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4DE36352131F; Fri,  6 Nov 2020 11:59:12 -0800 (PST)
Date:   Fri, 6 Nov 2020 11:59:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH memory-model 5/8] tools/memory-model: Add a glossary of
 LKMM terms
Message-ID: <20201106195912.GA3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201105215953.GA15309@paulmck-ThinkPad-P72>
 <20201105220017.15410-5-paulmck@kernel.org>
 <20201106165930.GC47039@rowland.harvard.edu>
 <20201106180445.GX3249@paulmck-ThinkPad-P72>
 <20201106192351.GA53131@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106192351.GA53131@rowland.harvard.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 06, 2020 at 02:23:51PM -0500, Alan Stern wrote:
> On Fri, Nov 06, 2020 at 10:04:46AM -0800, Paul E. McKenney wrote:
> > On Fri, Nov 06, 2020 at 11:59:30AM -0500, Alan Stern wrote:
> > > > +	 See also "Control Dependency".
> > > 
> > > There should also be an entry for "Data Dependency", linked from here
> > > and from Control Dependency.
> > > 
> > > > +Marked Access:  An access to a variable that uses an special function or
> > > > +	macro such as "r1 = READ_ONCE()" or "smp_store_release(&a, 1)".
> > > 
> > > How about "r1 = READ_ONCE(x)"?
> > 
> > Good catches!  I am planning to squash the commit below into the
> > original.  Does that cover it?
> 
> No, because you didn't add a glossary entry for "Data Dependency" and 
> there's no link from "Control Dependency" to "Data Dependency".

Sigh.  I was thinking "entry in the list", and didn't even thing to
check for an entry in the glossary as a whole.  With the patch below
(on top of the one sent earlier), are we good?

							Thanx, Paul

------------------------------------------------------------------------

commit 5a49c32551e83d30e304d6c3fbb660737ba2654e
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Fri Nov 6 11:57:25 2020 -0800

    fixup! tools/memory-model: Add a glossary of LKMM terms
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/memory-model/Documentation/glossary.txt b/tools/memory-model/Documentation/glossary.txt
index 471bf13..b2da636 100644
--- a/tools/memory-model/Documentation/glossary.txt
+++ b/tools/memory-model/Documentation/glossary.txt
@@ -64,7 +64,7 @@ Control Dependency:  When a later store's execution depends on a test
 	 fragile, and can be easily destroyed by optimizing compilers.
 	 Please see control-dependencies.txt for more information.
 
-	 See also "Address Dependency".
+	 See also "Address Dependency" and "Data Dependency".
 
 Cycle:	Memory-barrier pairing is restricted to a pair of CPUs, as the
 	name suggests.	And in a great many cases, a pair of CPUs is all
@@ -85,6 +85,23 @@ Cycle:	Memory-barrier pairing is restricted to a pair of CPUs, as the
 
 	See also "Pairing".
 
+Data Dependency:  When the data written by a later store is computed based
+	on the value returned by an earlier load, a "data dependency"
+	extends from that load to that later store.  For example:
+
+	 1 r1 = READ_ONCE(x);
+	 2 WRITE_ONCE(y, r1 + 1);
+
+	In this case, the data dependency extends from the READ_ONCE()
+	on line 1 to the WRITE_ONCE() on line 2.  Data dependencies are
+	fragile and can be easily destroyed by optimizing compilers.
+	Because optimizing compilers put a great deal of effort into
+	working out what values integer variables might have, this is
+	especially true in cases where the dependency is carried through
+	an integer.
+
+	See also "Address Dependency" and "Control Dependency".
+
 From-Reads (fr):  When one CPU's store to a given variable happened
 	too late to affect the value returned by another CPU's
 	load from that same variable, there is said to be a from-reads
