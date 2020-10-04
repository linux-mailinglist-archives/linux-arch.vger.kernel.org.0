Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC47282E3A
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 01:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgJDXM0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Oct 2020 19:12:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgJDXM0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 4 Oct 2020 19:12:26 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69A44206A1;
        Sun,  4 Oct 2020 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601853145;
        bh=YaguZ0Ntz4su+NloBWd1kSkvkKlu/WaU+GeUucRj+nI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eo8oZsvONeqe0ZQ+hnTQn1EcU15L4OSZHSitcVwYs0R7Yaq7vA/dL7bYuy7rCXgTJ
         Os6oH3Les3UgZ2yK8Pn6P1Dr3D/6cXoDpiKKZb0izoigo7pSoViL7+KMFzc/cVJcK8
         UeSH7I6WyWiCf4UGm4avzH5yCAHZZvF4MWq+/dDc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 338BB35225F2; Sun,  4 Oct 2020 16:12:25 -0700 (PDT)
Date:   Sun, 4 Oct 2020 16:12:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     joel@joelfernandes.org
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Akira Yokosawa <akiyks@gmail.com>, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, dlustig@nvidia.com, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] tools: memory-model: Document that the LKMM can easily
 miss control dependencies
Message-ID: <20201004231225.GN29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <20201001213048.GF29330@paulmck-ThinkPad-P72>
 <20201003132212.GB318272@rowland.harvard.edu>
 <045c643f-6a70-dfdf-2b1e-f369a667f709@gmail.com>
 <20201003171338.GA323226@rowland.harvard.edu>
 <20201004014022.GA332600@rowland.harvard.edu>
 <20201004210747.GA4078883@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201004210747.GA4078883@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Oct 04, 2020 at 05:07:47PM -0400, joel@joelfernandes.org wrote:
> On Sat, Oct 03, 2020 at 09:40:22PM -0400, Alan Stern wrote:
> > Add a small section to the litmus-tests.txt documentation file for
> > the Linux Kernel Memory Model explaining that the memory model often
> > fails to recognize certain control dependencies.
> > 
> > Suggested-by: Akira Yokosawa <akiyks@gmail.com>
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Good addition!  Applied, and thank you all!!!

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> > 
> > ---
> > 
> >  tools/memory-model/Documentation/litmus-tests.txt |   17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > Index: usb-devel/tools/memory-model/Documentation/litmus-tests.txt
> > ===================================================================
> > --- usb-devel.orig/tools/memory-model/Documentation/litmus-tests.txt
> > +++ usb-devel/tools/memory-model/Documentation/litmus-tests.txt
> > @@ -946,6 +946,23 @@ Limitations of the Linux-kernel memory m
> >  	carrying a dependency, then the compiler can break that dependency
> >  	by substituting a constant of that value.
> >  
> > +	Conversely, LKMM sometimes doesn't recognize that a particular
> > +	optimization is not allowed, and as a result, thinks that a
> > +	dependency is not present (because the optimization would break it).
> > +	The memory model misses some pretty obvious control dependencies
> > +	because of this limitation.  A simple example is:
> > +
> > +		r1 = READ_ONCE(x);
> > +		if (r1 == 0)
> > +			smp_mb();
> > +		WRITE_ONCE(y, 1);
> > +
> > +	There is a control dependency from the READ_ONCE to the WRITE_ONCE,
> > +	even when r1 is nonzero, but LKMM doesn't realize this and thinks
> > +	that the write may execute before the read if r1 != 0.  (Yes, that
> > +	doesn't make sense if you think about it, but the memory model's
> > +	intelligence is limited.)
> > +
> >  2.	Multiple access sizes for a single variable are not supported,
> >  	and neither are misaligned or partially overlapping accesses.
> >  
