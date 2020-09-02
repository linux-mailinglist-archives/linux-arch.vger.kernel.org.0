Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C89825A934
	for <lists+linux-arch@lfdr.de>; Wed,  2 Sep 2020 12:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIBKOY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Sep 2020 06:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIBKOX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Sep 2020 06:14:23 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347EEC061244;
        Wed,  2 Sep 2020 03:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hep1LSpouBu/k92H0XCqJqwft0oDi9qnzCpccwysDdk=; b=OkuySKQMXiZ/t5tRBDPlK0aqlA
        /bozFDv5g8PAVjwIw9G7DbVGV6BxoI+C5XOZq9tpMfdYSeJjjTy4KoE65k16p1nj0ly9G4s165gyq
        mP9DYVY1l8mamqpBqjwRTE+IVx1zr/Ve8saW53Z7KwqMfO2yJNQ8lTdWKSlZkdFrcHvqUUP+CutoP
        tqTmY72+ChbZ+T19PncEL+w6LBYTbhdiskLTB+bSgwWui0soxsjny2mViiXw1BBJ+iFrjxwBrEA/S
        hc2Vvkocsefi8pSnV7jY+mufry9r4xsxqiDBTQ0doov+Tut8249VfDjlyaH7VctKm8kZ0idx9hVH6
        1m2OIlIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDPmS-0005F0-2f; Wed, 02 Sep 2020 10:14:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EEB123012DF;
        Wed,  2 Sep 2020 12:14:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D7A5223D3D749; Wed,  2 Sep 2020 12:14:12 +0200 (CEST)
Date:   Wed, 2 Sep 2020 12:14:12 +0200
From:   peterz@infradead.org
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH kcsan 6/9] tools/memory-model: Expand the cheatsheet.txt
 notion of relaxed
Message-ID: <20200902101412.GC1362448@hirez.programming.kicks-ass.net>
References: <20200831182012.GA1965@paulmck-ThinkPad-P72>
 <20200831182037.2034-6-paulmck@kernel.org>
 <20200902035448.GC49492@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902035448.GC49492@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 02, 2020 at 11:54:48AM +0800, Boqun Feng wrote:
> On Mon, Aug 31, 2020 at 11:20:34AM -0700, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > This commit adds a key entry enumerating the various types of relaxed
> > operations.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  tools/memory-model/Documentation/cheatsheet.txt | 27 ++++++++++++++-----------
> >  1 file changed, 15 insertions(+), 12 deletions(-)
> > 
> > diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
> > index 33ba98d..31b814d 100644
> > --- a/tools/memory-model/Documentation/cheatsheet.txt
> > +++ b/tools/memory-model/Documentation/cheatsheet.txt
> > @@ -5,7 +5,7 @@
> >  
> >  Store, e.g., WRITE_ONCE()            Y                                       Y
> >  Load, e.g., READ_ONCE()              Y                          Y   Y        Y
> > -Unsuccessful RMW operation           Y                          Y   Y        Y
> > +Relaxed operation                    Y                          Y   Y        Y
> >  rcu_dereference()                    Y                          Y   Y        Y
> >  Successful *_acquire()               R                   Y  Y   Y   Y    Y   Y
> >  Successful *_release()         C        Y  Y    Y     W                      Y
> > @@ -17,14 +17,17 @@ smp_mb__before_atomic()       CP        Y  Y    Y        a  a   a   a    Y
> >  smp_mb__after_atomic()        CP        a  a    Y        Y  Y   Y   Y    Y
> >  
> >  
> > -Key:	C:	Ordering is cumulative
> > -	P:	Ordering propagates
> > -	R:	Read, for example, READ_ONCE(), or read portion of RMW
> > -	W:	Write, for example, WRITE_ONCE(), or write portion of RMW
> > -	Y:	Provides ordering
> > -	a:	Provides ordering given intervening RMW atomic operation
> > -	DR:	Dependent read (address dependency)
> > -	DW:	Dependent write (address, data, or control dependency)
> > -	RMW:	Atomic read-modify-write operation
> > -	SELF:	Orders self, as opposed to accesses before and/or after
> > -	SV:	Orders later accesses to the same variable
> > +Key:	Relaxed:  A relaxed operation is either a *_relaxed() RMW
> > +		  operation, an unsuccessful RMW operation, or one of
> > +		  the atomic_read() and atomic_set() family of operations.
> 
> To be accurate, atomic_set() doesn't return any value, so it cannot be
> ordered against DR and DW ;-)

Surely DW is valid for any store.

> I think we can split the Relaxed family into two groups:
> 
> void Relaxed: atomic_set() or atomic RMW operations that don't return
>               any value (e.g atomic_inc())
> 
> non-void Relaxed: a *_relaxed() RMW operation, an unsuccessful RMW
>                   operation, or atomic_read().
> 
> And "void Relaxed" is similar to WRITE_ONCE(), only has "Self" and "SV"
> equal "Y", while "non-void Relaxed" plays the same rule as "Relaxed"
> in this patch.
> 
> Thoughts?

I get confused by the mention of all this atomic_read() atomic_set()
crud in the first place, why are they called out specifically from any
other regular load/store ?
