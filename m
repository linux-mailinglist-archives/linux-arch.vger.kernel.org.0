Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48953D417F
	for <lists+linux-arch@lfdr.de>; Fri, 23 Jul 2021 22:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhGWTri (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Jul 2021 15:47:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhGWTri (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Jul 2021 15:47:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B90E60E94;
        Fri, 23 Jul 2021 20:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627072091;
        bh=oikyN+p4IRyE0L4SEjaNmzX3ZjbYgNMoIEpW+F4Yexk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AhlUrrG4qK0eAwXvQSfZoLjKNZzvbHjMTZJ/qPojYC+jkO/UKDQQ3Aw4cLWOGnHYg
         yE+TKyWn3lkswgVf7NQNcsh2wGz7c+xHKyYe/UNADDuqeYbSXHebZiPfOQH6osrmrt
         klDgxwLfBtFzP8JkR+klaMSwVFayNG1qityarIl9Ut9d9sKfXb7VuZFX4hpRb6ckzk
         iOklu3D7ifYwho3wbT9t6qCDY/5oKufA/d0vTD9jSh0mG+JeTiyXqmzjvba3bh/OmG
         O3znNSQGmB+nkI5XYd+xdaQeH7tniYINXo864QL0FN3iiYADutOL+JmwWG9t9sei/y
         27rRqXO9C0gvw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5C78A5C068F; Fri, 23 Jul 2021 13:28:11 -0700 (PDT)
Date:   Fri, 23 Jul 2021 13:28:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH memory-model 2/4] tools/memory-model: Add example for
 heuristic lockless reads
Message-ID: <20210723202811.GK4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
 <20210721211003.869892-2-paulmck@kernel.org>
 <20210723020846.GA26397@rowland.harvard.edu>
 <20210723162431.GF4397@paulmck-ThinkPad-P17-Gen-1>
 <20210723165947.GA46562@rowland.harvard.edu>
 <20210723173010.GI4397@paulmck-ThinkPad-P17-Gen-1>
 <20210723181138.GA48833@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723181138.GA48833@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 23, 2021 at 02:11:38PM -0400, Alan Stern wrote:
> On Fri, Jul 23, 2021 at 10:30:10AM -0700, Paul E. McKenney wrote:
> > On Fri, Jul 23, 2021 at 12:59:47PM -0400, Alan Stern wrote:
> > > On Fri, Jul 23, 2021 at 09:24:31AM -0700, Paul E. McKenney wrote:
> > > > On Thu, Jul 22, 2021 at 10:08:46PM -0400, Alan Stern wrote:
> > > 
> > > > > > +	void do_something_locked(struct foo *fp)
> > > > > > +	{
> > > > > > +		bool gf = true;
> > > > > > +
> > > > > > +		/* IMPORTANT: Heuristic plus spin_lock()! */
> > > > > > +		if (!data_race(global_flag)) {
> > > > > > +			spin_lock(&fp->f_lock);
> > > > > > +			if (!smp_load_acquire(&global_flag)) {
> > > 
> > > > > > +	void begin_global(void)
> > > > > > +	{
> > > > > > +		int i;
> > > > > > +
> > > > > > +		spin_lock(&global_lock);
> > > > > > +		WRITE_ONCE(global_flag, true);
> > > > > 
> > > > > Why does this need to be WRITE_ONCE?  It still races with the first read 
> > > > > of global_flag above.
> > > > 
> > > > But also with the smp_load_acquire() of global_flag, right?
> > > 
> > > What I'm curious about is why, given these two races, you notate one of 
> > > them by changing a normal write to WRITE_ONCE and you notate the other 
> > > by changing a normal read to a data_race() read.  Why not handle them 
> > > both the same way?
> > 
> > Because the code can tolerate the first read returning complete nonsense,
> > but needs the value from the second read to be exact at that point in
> > time.
> 
> In other words, if the second read races with the WRITE_ONCE, it needs to 
> get either the value before the write or the value after the write; 
> nothing else will do because it isn't a heuristic here.  Fair point.
> 
> >  (If the value changes immediately after being read, the fact that
> > ->f_lock is held prevents begin_global() from completing.)
> 
> This seems like something worth explaining in the document.  That 
> "IMPORTANT" comment doesn't really get the full point across.

How about this comment instead?

	/* This works even if data_race() returns nonsense. */

							Thanx, Paul
