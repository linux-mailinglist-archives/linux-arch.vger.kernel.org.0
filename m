Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95B725E23E
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 21:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgIDT4G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Sep 2020 15:56:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbgIDT4G (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Sep 2020 15:56:06 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F03B2083B;
        Fri,  4 Sep 2020 19:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599249365;
        bh=D4kFDskR2ElmqDONFLDmYkjYcsGM3HgMJlmgJ2Hk2os=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GVNbppvPylM/JYV+oLaU2WMwU9hQOA3jr5egtZDtmQ1P2XNzfQMo4wm1aNRTAx4zM
         aber8bq/koscWhNvasHbHTF4c9HebD/7bmDXuLvQLgkdJjVZ6e63aNQdtS75PxHS/B
         UrP6QRxOe8I0TWG9APmujlTctI3w7THGyoTajc9Q=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E4083352162B; Fri,  4 Sep 2020 12:56:04 -0700 (PDT)
Date:   Fri, 4 Sep 2020 12:56:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH kcsan 6/9] tools/memory-model: Expand the cheatsheet.txt
 notion of relaxed
Message-ID: <20200904195604.GK29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200831182012.GA1965@paulmck-ThinkPad-P72>
 <20200831182037.2034-6-paulmck@kernel.org>
 <20200902035448.GC49492@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200902101412.GC1362448@hirez.programming.kicks-ass.net>
 <20200902123715.GD49492@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200903233037.GW29330@paulmck-ThinkPad-P72>
 <20200904005921.GA7503@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200904023955.GX29330@paulmck-ThinkPad-P72>
 <20200904024717.GC7503@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904024717.GC7503@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 04, 2020 at 10:47:17AM +0800, Boqun Feng wrote:
> On Thu, Sep 03, 2020 at 07:39:55PM -0700, Paul E. McKenney wrote:
> > On Fri, Sep 04, 2020 at 08:59:21AM +0800, Boqun Feng wrote:
> > > On Thu, Sep 03, 2020 at 04:30:37PM -0700, Paul E. McKenney wrote:
> > 
> > [ . . . ]
> > 
> > > > How about like this, adding "Relaxed" to the WRITE_ONCE() and READ_ONCE()
> > > > rows and "RMW" to the "Relaxed operation" row?
> > > > 
> > > 
> > > Much better now, thanks! However ...
> > > 
> > > > The file contents are followed by a diff against the previous version.
> > > > 
> > > > 							Thanx, Paul
> > > > 
> > > > ------------------------------------------------------------------------
> > 
> > [ . . . ]
> > 
> > > > Key:	Relaxed:  A relaxed operation is either a *_relaxed() RMW
> > > > 		  operation, an unsuccessful RMW operation, READ_ONCE(),
> > > > 		  WRITE_ONCE(), or one of the atomic_read() and
> > > > 		  atomic_set() family of operations.
> > > 
> > > And:
> > > 		  a RMW operation that doesn't return any value (e.g
> > > 		  atomic_inc()), IOW it's a void Relaxed operation.
> > 
> > Good point!  Please see below.
> > 
> 
> Looks good to me ;-)
> 
> 
> Acked-by: Boqun Feng <boqun.feng@gmail.com>

Applied, thank you!

							Thanx, Paul

> Regards,
> Boqun
> 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> >                                   Prior Operation     Subsequent Operation
> >                                   ---------------  ---------------------------
> >                                C  Self  R  W  RMW  Self  R  W  DR  DW  RMW  SV
> >                               --  ----  -  -  ---  ----  -  -  --  --  ---  --
> > 
> > Relaxed store                        Y                                       Y
> > Relaxed load                         Y                          Y   Y        Y
> > Relaxed RMW operation                Y                          Y   Y        Y
> > rcu_dereference()                    Y                          Y   Y        Y
> > Successful *_acquire()               R                   Y  Y   Y   Y    Y   Y
> > Successful *_release()         C        Y  Y    Y     W                      Y
> > smp_rmb()                               Y       R        Y      Y        R
> > smp_wmb()                                  Y    W           Y       Y    W
> > smp_mb() & synchronize_rcu()  CP        Y  Y    Y        Y  Y   Y   Y    Y
> > Successful full non-void RMW  CP     Y  Y  Y    Y     Y  Y  Y   Y   Y    Y   Y
> > smp_mb__before_atomic()       CP        Y  Y    Y        a  a   a   a    Y
> > smp_mb__after_atomic()        CP        a  a    Y        Y  Y   Y   Y    Y
> > 
> > 
> > Key:	Relaxed:  A relaxed operation is either READ_ONCE(), WRITE_ONCE(),
> > 		  a *_relaxed() RMW operation, an unsuccessful RMW
> > 		  operation, a non-value-returning RMW operation such
> > 		  as atomic_inc(), or one of the atomic*_read() and
> > 		  atomic*_set() family of operations.
> > 	C:	  Ordering is cumulative
> > 	P:	  Ordering propagates
> > 	R:	  Read, for example, READ_ONCE(), or read portion of RMW
> > 	W:	  Write, for example, WRITE_ONCE(), or write portion of RMW
> > 	Y:	  Provides ordering
> > 	a:	  Provides ordering given intervening RMW atomic operation
> > 	DR:	  Dependent read (address dependency)
> > 	DW:	  Dependent write (address, data, or control dependency)
> > 	RMW:	  Atomic read-modify-write operation
> > 	SELF:	  Orders self, as opposed to accesses before and/or after
> > 	SV:	  Orders later accesses to the same variable
> > 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
> > index 4146b8d..99d0087 100644
> > --- a/tools/memory-model/Documentation/cheatsheet.txt
> > +++ b/tools/memory-model/Documentation/cheatsheet.txt
> > @@ -17,10 +17,11 @@ smp_mb__before_atomic()       CP        Y  Y    Y        a  a   a   a    Y
> >  smp_mb__after_atomic()        CP        a  a    Y        Y  Y   Y   Y    Y
> >  
> >  
> > -Key:	Relaxed:  A relaxed operation is either a *_relaxed() RMW
> > -		  operation, an unsuccessful RMW operation, READ_ONCE(),
> > -		  WRITE_ONCE(), or one of the atomic_read() and
> > -		  atomic_set() family of operations.
> > +Key:	Relaxed:  A relaxed operation is either READ_ONCE(), WRITE_ONCE(),
> > +		  a *_relaxed() RMW operation, an unsuccessful RMW
> > +		  operation, a non-value-returning RMW operation such
> > +		  as atomic_inc(), or one of the atomic*_read() and
> > +		  atomic*_set() family of operations.
> >  	C:	  Ordering is cumulative
> >  	P:	  Ordering propagates
> >  	R:	  Read, for example, READ_ONCE(), or read portion of RMW
