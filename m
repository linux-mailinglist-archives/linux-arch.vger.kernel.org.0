Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC189259B97
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 19:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgIARE0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 13:04:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbgIAREY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Sep 2020 13:04:24 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6018E206FA;
        Tue,  1 Sep 2020 17:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598979861;
        bh=LM0ZlQMq+116FxcurgkDhzTV7jHjOc0VMnH67syAMUQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Z112+wpOmHZYDF5q2YSpWCIrvYLUOuuPlvm2AUn1IFORq7sAlh9G0pNLthwMK0910
         gL4m4deu8dWoMmcLR8/W/O4Bih0lEGbIUJn/kzR0yKkn9JiaLira3RW0tStd8P0thD
         Q9oawRnaRslbUECyBzZfs32mFe4m9aEoX26mHscg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 332C835226A5; Tue,  1 Sep 2020 10:04:21 -0700 (PDT)
Date:   Tue, 1 Sep 2020 10:04:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH kcsan 9/9] tools/memory-model:  Document locking corner
 cases
Message-ID: <20200901170421.GF29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200831182012.GA1965@paulmck-ThinkPad-P72>
 <20200831182037.2034-9-paulmck@kernel.org>
 <20200831201701.GB558270@rowland.harvard.edu>
 <20200831214738.GE2855@paulmck-ThinkPad-P72>
 <20200901014504.GB571008@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901014504.GB571008@rowland.harvard.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 31, 2020 at 09:45:04PM -0400, Alan Stern wrote:
> On Mon, Aug 31, 2020 at 02:47:38PM -0700, Paul E. McKenney wrote:
> > On Mon, Aug 31, 2020 at 04:17:01PM -0400, Alan Stern wrote:
> 
> > > Is this discussion perhaps overkill?
> > > 
> > > Let's put it this way: Suppose we have the following code:
> > > 
> > > 	P0(int *x, int *lck)
> > > 	{
> > > 		spin_lock(lck);
> > > 		WRITE_ONCE(*x, 1);
> > > 		do_something();
> > > 		spin_unlock(lck);
> > > 	}
> > > 
> > > 	P1(int *x, int *lck)
> > > 	{
> > > 		while (READ_ONCE(*x) == 0)
> > > 			;
> > > 		spin_lock(lck);
> > > 		do_something_else();
> > > 		spin_unlock(lck);
> > > 	}
> > > 
> > > It's obvious that this test won't deadlock.  But if P1 is changed to:
> > > 
> > > 	P1(int *x, int *lck)
> > > 	{
> > > 		spin_lock(lck);
> > > 		while (READ_ONCE(*x) == 0)
> > > 			;
> > > 		do_something_else();
> > > 		spin_unlock(lck);
> > > 	}
> > > 
> > > then it's equally obvious that the test can deadlock.  No need for
> > > fancy memory models or litmus tests or anything else.
> > 
> > For people like you and me, who have been thinking about memory ordering
> > for longer than either of us care to admit, this level of exposition is
> > most definitely -way- overkill!!!
> > 
> > But I have had people be very happy and grateful that I explained this to
> > them at this level of detail.  Yes, I started parallel programming before
> > some of them were born, but they are definitely within our target audience
> > for this particular document.  And it is not just Linux kernel hackers
> > who need this level of detail.  A roughly similar transactional-memory
> > scenario proved to be so non-obvious to any number of noted researchers
> > that Blundell, Lewis, and Martin needed to feature it in this paper:
> > https://ieeexplore.ieee.org/abstract/document/4069174
> > (Alternative source: https://repository.upenn.edu/cgi/viewcontent.cgi?article=1344&context=cis_papers)
> > 
> > Please note that I am -not- advocating making (say) explanation.txt or
> > recipes.txt more newbie-accessible than they already are.  After all,
> > the point of the README file in that same directory is to direct people
> > to the documentation files that are the best fit for them, and both
> > explanation.txt and recipes.txt contain advanced material, and thus
> > require similarly advanced prerequisites.
> > 
> > Seem reasonable, or am I missing your point?
> 
> The question is, what are you trying to accomplish in this section?  Are 
> you trying to demonstrate that it isn't safe to allow arbitrary code to 
> leak into a critical section?  If so then you don't need to present an 
> LKMM litmus test to make the point; the example I gave here will do 
> quite as well.  Perhaps even better, since it doesn't drag in all sorts 
> of extraneous concepts like limitations of litmus tests or how to 
> emulate a spin loop.
> 
> On the other hand, if your goal is to show how to construct a litmus 
> test that will model a particular C language test case (such as the one 
> I gave), then the text does a reasonable job -- although I do think it 
> could be clarified somewhat.  For instance, it wouldn't hurt to include 
> the real C code before giving the corresponding litmus test, so that the 
> reader will have a clear idea of what you're trying to model.

Makes sense.  I can apply this at some point, but I would welcome a patch
from you, which I would be happy to fold in with your Codeveloped-by.

> Just what you want to achieve here is not clear from the context.

People who have internalized the "roach motel" model of locking
(https://www.cs.umd.edu/~pugh/java/memoryModel/BidirectionalMemoryBarrier.html)
need their internalization adjusted.

> Besides, the example is in any case a straw man.  The text starts out 
> saying "It is tempting to allow memory-reference instructions to be 
> pulled into a critical section", but then the example pulls an entire 
> spin loop inside -- not just the memory references but also the 
> conditional branch instruction at the bottom of the loop!  I can't 
> imagine anyone would think it was safe to allow branches to leak into a 
> critical section, particularly when doing so would break a control 
> dependency (as it does here).

Most people outside of a few within the Linux kernel community and within
the various hardware memory-ordering communities don't know that control
dependencies even exist, so could not be expected to see any danger
in rather thoroughly folding, spindling, or otherwise mutilating them,
let alone pulling them into a lock-based critical section.  And many in
the various toolchain communities see dependencies of any sort as an
impediment to performance that should be broken wherever and whenever
possible.

That said, a less prejudicial introduction to this example might be good.
What did you have in mind?

							Thanx, Paul
