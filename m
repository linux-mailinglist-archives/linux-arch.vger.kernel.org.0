Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11231DEE82
	for <lists+linux-arch@lfdr.de>; Fri, 22 May 2020 19:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbgEVRpl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 May 2020 13:45:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbgEVRpl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 May 2020 13:45:41 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F88220738;
        Fri, 22 May 2020 17:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590169540;
        bh=HnkRVWiR8hMQlze8/0Lt2vEZ/kFWm+ECVepsC/iwB/I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QHZuNFYt/X65UhTVIVQIRysFvy211kKktmaSSQ019cEbdRxMP/A4mnF1fwBFATER7
         W6I2lKHvbb4vf71cou0J9nYAwc2DolcBwZkzC62z7zLVIvyClDrDihBysgb0yP+GOW
         H+I5UPS359gaQnGUw7mSZjQAUm1sLQbeSR3BI0wY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5C5E73522E41; Fri, 22 May 2020 10:45:40 -0700 (PDT)
Date:   Fri, 22 May 2020 10:45:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>, parri.andrea@gmail.com,
        will@kernel.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        andriin@fb.com
Subject: Re: Some -serious- BPF-related litmus tests
Message-ID: <20200522174540.GK2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200522003850.GA32698@paulmck-ThinkPad-P72>
 <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522105659.GH2869@paulmck-ThinkPad-P72>
 <20200522143609.GC32434@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522143609.GC32434@rowland.harvard.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 22, 2020 at 10:36:09AM -0400, Alan Stern wrote:
> On Fri, May 22, 2020 at 03:56:59AM -0700, Paul E. McKenney wrote:
> > On Fri, May 22, 2020 at 11:44:07AM +0200, Peter Zijlstra wrote:
> > > On Thu, May 21, 2020 at 05:38:50PM -0700, Paul E. McKenney wrote:
> > > > Hello!
> > > > 
> > > > Just wanted to call your attention to some pretty cool and pretty serious
> > > > litmus tests that Andrii did as part of his BPF ring-buffer work:
> > > > 
> > > > https://lore.kernel.org/bpf/20200517195727.279322-3-andriin@fb.com/
> > > > 
> > > > Thoughts?
> > > 
> > > I find:
> > > 
> > > 	smp_wmb()
> > > 	smp_store_release()
> > > 
> > > a _very_ weird construct. What is that supposed to even do?
> > 
> > Indeed, and I asked about that in my review of the patch containing the
> > code.  It -could- make sense if there is a prior read and a later store:
> > 
> > 	r1 = READ_ONCE(a);
> > 	WRITE_ONCE(b, 1);
> > 	smp_wmb();
> > 	smp_store_release(&c, 1);
> > 	WRITE_ONCE(d, 1);
> > 
> > So a->c and b->c is smp_store_release() and b->d is smp_wmb().  But if
> > there were only stores, the smp_wmb() would suffice.  And if there wasn't
> > the trailing store, smp_store_release() would suffice.
> 
> But that wasn't the context in the litmus test.  The context was:
> 
> 	smp_wmb();
> 	smp_store_release();
> 	spin_unlock();
> 	smp_store_release();
> 
> That certainly looks like a lot more ordering than is really needed.

I suspect that you are right.  I asked him if there were other accesses
in my response to his ringbuffer (as opposed to litmus-test) patch:

https://lore.kernel.org/bpf/20200522002502.GF2869@paulmck-ThinkPad-P72/

If there are other accesses requiring both, the litmus tests might need
to be updated.

							Thanx, Paul
