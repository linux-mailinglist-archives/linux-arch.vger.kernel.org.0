Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943F83D41E8
	for <lists+linux-arch@lfdr.de>; Fri, 23 Jul 2021 23:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhGWUXQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Jul 2021 16:23:16 -0400
Received: from netrider.rowland.org ([192.131.102.5]:46345 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231600AbhGWUXP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Jul 2021 16:23:15 -0400
Received: (qmail 53715 invoked by uid 1000); 23 Jul 2021 17:03:47 -0400
Date:   Fri, 23 Jul 2021 17:03:47 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Manfred Spraul <manfred@colorfullife.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH memory-model 2/4] tools/memory-model: Add example for
 heuristic lockless reads
Message-ID: <20210723210347.GA53526@rowland.harvard.edu>
References: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
 <20210721211003.869892-2-paulmck@kernel.org>
 <20210723020846.GA26397@rowland.harvard.edu>
 <e4aa3346-ba2c-f6cc-9f3c-349e22cd6ee8@colorfullife.com>
 <20210723130554.GA38923@rowland.harvard.edu>
 <20210723163008.GG4397@paulmck-ThinkPad-P17-Gen-1>
 <20210723170820.GB46562@rowland.harvard.edu>
 <20210723203248.GL4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723203248.GL4397@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 23, 2021 at 01:28:11PM -0700, Paul E. McKenney wrote:
> On Fri, Jul 23, 2021 at 02:11:38PM -0400, Alan Stern wrote:
> > In other words, if the second read races with the WRITE_ONCE, it needs 
to
> > get either the value before the write or the value after the write;
> > nothing else will do because it isn't a heuristic here.  Fair point.
> >
> > >  (If the value changes immediately after being read, the fact that
> > > ->f_lock is held prevents begin_global() from completing.)
> >
> > This seems like something worth explaining in the document.  That
> > "IMPORTANT" comment doesn't really get the full point across.
>
> How about this comment instead?
>
>       /* This works even if data_race() returns nonsense. */

That's somewhat better.


On Fri, Jul 23, 2021 at 01:32:48PM -0700, Paul E. McKenney wrote:
> On Fri, Jul 23, 2021 at 01:08:20PM -0400, Alan Stern wrote:
> > This doesn't mention the reason for the acquire-release
> > synchronization of global_flag.  It's needed because work done between
> > begin_global() and end_global() can affect a foo structure without
> > holding its private f_lock member, and we want all such work to be
> > visible to other threads when they call do_something_locked() later.
> 
> Like this added paragraph at the end?
> 
> 	The smp_load_acquire() and smp_store_release() are required
> 	because changes to a foo structure between calls to begin_global()
> 	and end_global() are carried out without holding that structure's
> 	->f_lock.  The smp_load_acquire() and smp_store_release()
> 	ensure that the next invocation of do_something() from the call
> 	to do_something_locked() that acquires that ->f_lock will see
> 	those changes.

I'd shorten the last sentence:

	The smp_load_acquire() and smp_store_release() ensure that the
	next invocation of do_something() from do_something_locked()
	will see those changes.

Alan
