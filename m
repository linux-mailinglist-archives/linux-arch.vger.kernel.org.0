Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E6625CE5B
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 01:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbgICXai (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 19:30:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbgICXai (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Sep 2020 19:30:38 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67CE320786;
        Thu,  3 Sep 2020 23:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599175837;
        bh=B3pK5zZnU9RKRCpV09z0d2GVM5xHL2b8XThKQbrNalY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LwWR5naI1s2ii2yNOtdTNaSVrP09eFKVIfqFTWOKhQuPyIOKvXAgGiY0Ubs+r27mO
         SZhjVj/WmadlsOw71vF7bLirPmJzrVf0TrtBc7UlojTNUeVrFAwpo6HlgQdZ8ZlQae
         4xcAN0CxGkJcgpEMws82bhehpK2iUXgyflAufPQo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4C62A3522636; Thu,  3 Sep 2020 16:30:37 -0700 (PDT)
Date:   Thu, 3 Sep 2020 16:30:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH kcsan 6/9] tools/memory-model: Expand the cheatsheet.txt
 notion of relaxed
Message-ID: <20200903233037.GW29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200831182012.GA1965@paulmck-ThinkPad-P72>
 <20200831182037.2034-6-paulmck@kernel.org>
 <20200902035448.GC49492@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200902101412.GC1362448@hirez.programming.kicks-ass.net>
 <20200902123715.GD49492@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902123715.GD49492@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 02, 2020 at 08:37:15PM +0800, Boqun Feng wrote:
> On Wed, Sep 02, 2020 at 12:14:12PM +0200, peterz@infradead.org wrote:
> > On Wed, Sep 02, 2020 at 11:54:48AM +0800, Boqun Feng wrote:
> > > On Mon, Aug 31, 2020 at 11:20:34AM -0700, paulmck@kernel.org wrote:
> > > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > > 
> > > > This commit adds a key entry enumerating the various types of relaxed
> > > > operations.
> > > > 
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > ---
> > > >  tools/memory-model/Documentation/cheatsheet.txt | 27 ++++++++++++++-----------
> > > >  1 file changed, 15 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
> > > > index 33ba98d..31b814d 100644
> > > > --- a/tools/memory-model/Documentation/cheatsheet.txt
> > > > +++ b/tools/memory-model/Documentation/cheatsheet.txt
> > > > @@ -5,7 +5,7 @@
> > > >  
> > > >  Store, e.g., WRITE_ONCE()            Y                                       Y
> > > >  Load, e.g., READ_ONCE()              Y                          Y   Y        Y
> > > > -Unsuccessful RMW operation           Y                          Y   Y        Y
> > > > +Relaxed operation                    Y                          Y   Y        Y
> > > >  rcu_dereference()                    Y                          Y   Y        Y
> > > >  Successful *_acquire()               R                   Y  Y   Y   Y    Y   Y
> > > >  Successful *_release()         C        Y  Y    Y     W                      Y
> > > > @@ -17,14 +17,17 @@ smp_mb__before_atomic()       CP        Y  Y    Y        a  a   a   a    Y
> > > >  smp_mb__after_atomic()        CP        a  a    Y        Y  Y   Y   Y    Y
> > > >  
> > > >  
> > > > -Key:	C:	Ordering is cumulative
> > > > -	P:	Ordering propagates
> > > > -	R:	Read, for example, READ_ONCE(), or read portion of RMW
> > > > -	W:	Write, for example, WRITE_ONCE(), or write portion of RMW
> > > > -	Y:	Provides ordering
> > > > -	a:	Provides ordering given intervening RMW atomic operation
> > > > -	DR:	Dependent read (address dependency)
> > > > -	DW:	Dependent write (address, data, or control dependency)
> > > > -	RMW:	Atomic read-modify-write operation
> > > > -	SELF:	Orders self, as opposed to accesses before and/or after
> > > > -	SV:	Orders later accesses to the same variable
> > > > +Key:	Relaxed:  A relaxed operation is either a *_relaxed() RMW
> > > > +		  operation, an unsuccessful RMW operation, or one of
> > > > +		  the atomic_read() and atomic_set() family of operations.
> > > 
> > > To be accurate, atomic_set() doesn't return any value, so it cannot be
> > > ordered against DR and DW ;-)
> > 
> > Surely DW is valid for any store.
> > 
> 
> IIUC, the DW colomn stands for whether the corresponding operation (in
> this case, it's atomic_set()) is ordered any write that depends on this
> operation. I don't think there is a write->write dependency, so DW for
> atomic_set() should not be Y, just as the DW for WRITE_ONCE().
> 
> > > I think we can split the Relaxed family into two groups:
> > > 
> > > void Relaxed: atomic_set() or atomic RMW operations that don't return
> > >               any value (e.g atomic_inc())
> > > 
> > > non-void Relaxed: a *_relaxed() RMW operation, an unsuccessful RMW
> > >                   operation, or atomic_read().
> > > 
> > > And "void Relaxed" is similar to WRITE_ONCE(), only has "Self" and "SV"
> > > equal "Y", while "non-void Relaxed" plays the same rule as "Relaxed"
> > > in this patch.
> > > 
> > > Thoughts?
> > 
> > I get confused by the mention of all this atomic_read() atomic_set()
> > crud in the first place, why are they called out specifically from any
> > other regular load/store ?
> 
> Agreed. Probably we should fold those two operations into "Load" and
> "Store" cases.

All good points.

How about like this, adding "Relaxed" to the WRITE_ONCE() and READ_ONCE()
rows and "RMW" to the "Relaxed operation" row?

The file contents are followed by a diff against the previous version.

							Thanx, Paul

------------------------------------------------------------------------

                                  Prior Operation     Subsequent Operation
                                  ---------------  ---------------------------
                               C  Self  R  W  RMW  Self  R  W  DR  DW  RMW  SV
                              --  ----  -  -  ---  ----  -  -  --  --  ---  --

Relaxed store                        Y                                       Y
Relaxed load                         Y                          Y   Y        Y
Relaxed RMW operation                Y                          Y   Y        Y
rcu_dereference()                    Y                          Y   Y        Y
Successful *_acquire()               R                   Y  Y   Y   Y    Y   Y
Successful *_release()         C        Y  Y    Y     W                      Y
smp_rmb()                               Y       R        Y      Y        R
smp_wmb()                                  Y    W           Y       Y    W
smp_mb() & synchronize_rcu()  CP        Y  Y    Y        Y  Y   Y   Y    Y
Successful full non-void RMW  CP     Y  Y  Y    Y     Y  Y  Y   Y   Y    Y   Y
smp_mb__before_atomic()       CP        Y  Y    Y        a  a   a   a    Y
smp_mb__after_atomic()        CP        a  a    Y        Y  Y   Y   Y    Y


Key:	Relaxed:  A relaxed operation is either a *_relaxed() RMW
		  operation, an unsuccessful RMW operation, READ_ONCE(),
		  WRITE_ONCE(), or one of the atomic_read() and
		  atomic_set() family of operations.
	C:	  Ordering is cumulative
	P:	  Ordering propagates
	R:	  Read, for example, READ_ONCE(), or read portion of RMW
	W:	  Write, for example, WRITE_ONCE(), or write portion of RMW
	Y:	  Provides ordering
	a:	  Provides ordering given intervening RMW atomic operation
	DR:	  Dependent read (address dependency)
	DW:	  Dependent write (address, data, or control dependency)
	RMW:	  Atomic read-modify-write operation
	SELF:	  Orders self, as opposed to accesses before and/or after
	SV:	  Orders later accesses to the same variable

------------------------------------------------------------------------

diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
index 31b814d..4146b8d 100644
--- a/tools/memory-model/Documentation/cheatsheet.txt
+++ b/tools/memory-model/Documentation/cheatsheet.txt
@@ -3,9 +3,9 @@
                                C  Self  R  W  RMW  Self  R  W  DR  DW  RMW  SV
                               --  ----  -  -  ---  ----  -  -  --  --  ---  --
 
-Store, e.g., WRITE_ONCE()            Y                                       Y
-Load, e.g., READ_ONCE()              Y                          Y   Y        Y
-Relaxed operation                    Y                          Y   Y        Y
+Relaxed store                        Y                                       Y
+Relaxed load                         Y                          Y   Y        Y
+Relaxed RMW operation                Y                          Y   Y        Y
 rcu_dereference()                    Y                          Y   Y        Y
 Successful *_acquire()               R                   Y  Y   Y   Y    Y   Y
 Successful *_release()         C        Y  Y    Y     W                      Y
@@ -18,8 +18,9 @@ smp_mb__after_atomic()        CP        a  a    Y        Y  Y   Y   Y    Y
 
 
 Key:	Relaxed:  A relaxed operation is either a *_relaxed() RMW
-		  operation, an unsuccessful RMW operation, or one of
-		  the atomic_read() and atomic_set() family of operations.
+		  operation, an unsuccessful RMW operation, READ_ONCE(),
+		  WRITE_ONCE(), or one of the atomic_read() and
+		  atomic_set() family of operations.
 	C:	  Ordering is cumulative
 	P:	  Ordering propagates
 	R:	  Read, for example, READ_ONCE(), or read portion of RMW
