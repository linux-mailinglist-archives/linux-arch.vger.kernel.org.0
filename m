Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288261DE918
	for <lists+linux-arch@lfdr.de>; Fri, 22 May 2020 16:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbgEVOgL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 May 2020 10:36:11 -0400
Received: from netrider.rowland.org ([192.131.102.5]:46233 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729888AbgEVOgK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 May 2020 10:36:10 -0400
Received: (qmail 1718 invoked by uid 1000); 22 May 2020 10:36:09 -0400
Date:   Fri, 22 May 2020 10:36:09 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, parri.andrea@gmail.com,
        will@kernel.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        andriin@fb.com
Subject: Re: Some -serious- BPF-related litmus tests
Message-ID: <20200522143609.GC32434@rowland.harvard.edu>
References: <20200522003850.GA32698@paulmck-ThinkPad-P72>
 <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522105659.GH2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522105659.GH2869@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 22, 2020 at 03:56:59AM -0700, Paul E. McKenney wrote:
> On Fri, May 22, 2020 at 11:44:07AM +0200, Peter Zijlstra wrote:
> > On Thu, May 21, 2020 at 05:38:50PM -0700, Paul E. McKenney wrote:
> > > Hello!
> > > 
> > > Just wanted to call your attention to some pretty cool and pretty serious
> > > litmus tests that Andrii did as part of his BPF ring-buffer work:
> > > 
> > > https://lore.kernel.org/bpf/20200517195727.279322-3-andriin@fb.com/
> > > 
> > > Thoughts?
> > 
> > I find:
> > 
> > 	smp_wmb()
> > 	smp_store_release()
> > 
> > a _very_ weird construct. What is that supposed to even do?
> 
> Indeed, and I asked about that in my review of the patch containing the
> code.  It -could- make sense if there is a prior read and a later store:
> 
> 	r1 = READ_ONCE(a);
> 	WRITE_ONCE(b, 1);
> 	smp_wmb();
> 	smp_store_release(&c, 1);
> 	WRITE_ONCE(d, 1);
> 
> So a->c and b->c is smp_store_release() and b->d is smp_wmb().  But if
> there were only stores, the smp_wmb() would suffice.  And if there wasn't
> the trailing store, smp_store_release() would suffice.

But that wasn't the context in the litmus test.  The context was:

	smp_wmb();
	smp_store_release();
	spin_unlock();
	smp_store_release();

That certainly looks like a lot more ordering than is really needed.

Alan
