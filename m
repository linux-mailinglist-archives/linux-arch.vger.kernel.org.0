Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0734283B9B
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 17:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgJEPt1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Oct 2020 11:49:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgJEPt1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 5 Oct 2020 11:49:27 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E778E20639;
        Mon,  5 Oct 2020 15:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601912966;
        bh=Zy4P3SidGYOFwyXdIOB7Da8tjGHn39EZ/UTZpf4p2Jk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bfDTt+uXz5X/ckwrCAM7lYPL8v8IvwRbYOR6QgVukMcbu2xUD77mNnWUZockUb4oU
         PbkONv9MOALDk6XlSgp9RodG4LLRGc/2bPzFhD2Q7B2JWeDHQqgKjD6+8VkIjqBP1G
         RsVFmh1NAzf7aZhQ9T5Tpwn0OJLbi8R+DmH9mP/0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B3D6B352301E; Mon,  5 Oct 2020 08:49:25 -0700 (PDT)
Date:   Mon, 5 Oct 2020 08:49:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>, parri.andrea@gmail.com,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: Litmus test for question from Al Viro
Message-ID: <20201005154925.GY29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201001213048.GF29330@paulmck-ThinkPad-P72>
 <20201003132212.GB318272@rowland.harvard.edu>
 <20201004233146.GP29330@paulmck-ThinkPad-P72>
 <20201005023846.GA359428@rowland.harvard.edu>
 <20201005082002.GA23216@willie-the-truck>
 <20201005091247.GA23575@willie-the-truck>
 <20201005142351.GB376584@rowland.harvard.edu>
 <20201005151313.GA23892@willie-the-truck>
 <20201005151639.GE376584@rowland.harvard.edu>
 <20201005153519.GJ2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005153519.GJ2628@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 05, 2020 at 05:35:19PM +0200, Peter Zijlstra wrote:
> On Mon, Oct 05, 2020 at 11:16:39AM -0400, Alan Stern wrote:
> > On Mon, Oct 05, 2020 at 04:13:13PM +0100, Will Deacon wrote:
> > > > The failure to recognize the dependency in P0 should be considered a 
> > > > combined limitation of the memory model and herd7.  It's not a simple 
> > > > mistake that can be fixed by a small rewrite of herd7; rather it's a 
> > > > deliberate choice we made based on herd7's inherent design.  We 
> > > > explicitly said that control dependencies extend only to the code in the 
> > > > branches of an "if" statement; anything beyond the end of the statement 
> > > > is not considered to be dependent.
> > > 
> > > Interesting. How does this interact with loops that are conditionally broken
> > > out of, e.g.  a relaxed cmpxchg() loop or an smp_cond_load_relaxed() call
> > > prior to a WRITE_ONCE()?
> > 
> > Heh --  We finesse this issue by not supporting loops at all!  :-)
> 
> Right, so something like:
> 
> 	smp_cond_load_relaxed(x, !VAL);
> 	WRITE_ONCE(*y, 1);
> 
> Would be modeled like:
> 
> 	r1 = READ_ONCE(*x);
> 	if (!r1)
> 		WRITE_ONCE(*y, 1);
> 
> with an r1==0 constraint in the condition I suppose ?

Yes, you got it!

However, it is more efficient to use the "filter" clause to tell herd7
about executions that are to be discarded.

							Thanx, Paul
