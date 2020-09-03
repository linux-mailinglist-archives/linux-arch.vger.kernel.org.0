Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6120325CE79
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 01:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgICXpI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 19:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgICXpI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Sep 2020 19:45:08 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FDF32087C;
        Thu,  3 Sep 2020 23:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599176707;
        bh=8bAoQpSFg+HmzwgsjwergPXEI5E0On0nuQRrCU3AGoo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tPpCCIHTnrl2XtbByl+dv+buhKFVb0BO8mRXLPm7foaEhJM8BP+cuH5ZHXgS4NqJJ
         wlUqwtweHizbDSXlBib4rHW8sFHu3y1J8vgPDtnbwNdJb469wNgZ5+GPgKLIdb45e6
         0B64M7THzTnVaydxVIwutg3DIXTHkSqFPodhCgiA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 23C643522636; Thu,  3 Sep 2020 16:45:07 -0700 (PDT)
Date:   Thu, 3 Sep 2020 16:45:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH kcsan 9/9] tools/memory-model:  Document locking corner
 cases
Message-ID: <20200903234507.GA24261@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200831182012.GA1965@paulmck-ThinkPad-P72>
 <20200831182037.2034-9-paulmck@kernel.org>
 <20200831201701.GB558270@rowland.harvard.edu>
 <20200831214738.GE2855@paulmck-ThinkPad-P72>
 <20200901014504.GB571008@rowland.harvard.edu>
 <20200901170421.GF29330@paulmck-ThinkPad-P72>
 <20200901201110.GB599114@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901201110.GB599114@rowland.harvard.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 01, 2020 at 04:11:10PM -0400, Alan Stern wrote:
> On Tue, Sep 01, 2020 at 10:04:21AM -0700, Paul E. McKenney wrote:
> > On Mon, Aug 31, 2020 at 09:45:04PM -0400, Alan Stern wrote:
> 
> > > The question is, what are you trying to accomplish in this section?  Are 
> > > you trying to demonstrate that it isn't safe to allow arbitrary code to 
> > > leak into a critical section?  If so then you don't need to present an 
> > > LKMM litmus test to make the point; the example I gave here will do 
> > > quite as well.  Perhaps even better, since it doesn't drag in all sorts 
> > > of extraneous concepts like limitations of litmus tests or how to 
> > > emulate a spin loop.
> > > 
> > > On the other hand, if your goal is to show how to construct a litmus 
> > > test that will model a particular C language test case (such as the one 
> > > I gave), then the text does a reasonable job -- although I do think it 
> > > could be clarified somewhat.  For instance, it wouldn't hurt to include 
> > > the real C code before giving the corresponding litmus test, so that the 
> > > reader will have a clear idea of what you're trying to model.
> > 
> > Makes sense.  I can apply this at some point, but I would welcome a patch
> > from you, which I would be happy to fold in with your Codeveloped-by.
> 
> I don't have time to work on these documents now.  Maybe later on.  They 
> do need some serious editing.  (You could try reading through them 
> carefully yourself; I'm sure you'd find a lot of things to fix up.)
> 
> Incidentally, your patch bomb from yesterday was the first time I had 
> seen these things (except for the litmus-test format document).

The hope was to have a good version of them completed some weeks ago,
but life intervened.

My current thought is to move these three patches out of my queue for
v5.10 to try again in v5.11:

0b8c06b75ea1 ("tools/memory-model: Add a simple entry point document")
dc372dc0dc89 ("tools/memory-model: Move Documentation description to Documentation/README")
0d9aaf8df7cb ("tools/memory-model: Document categories of ordering primitives")
35dd5f6d17a0 ("tools/memory-model:  Document locking corner cases")

These would remain in my v5.10 queue:

1e44e6e82e7b ("Replace HTTP links with HTTPS ones: LKMM")
cc9628b45c9f ("tools/memory-model: Update recipes.txt prime_numbers.c path")
984f272be9d7 ("tools/memory-model: Improve litmus-test documentation")
7c22cf3b731f ("tools/memory-model: Expand the cheatsheet.txt notion of relaxed")
	(But with the updates from the other thread.)

Does that work?  If not, what would?

> > > Just what you want to achieve here is not clear from the context.
> > 
> > People who have internalized the "roach motel" model of locking
> > (https://www.cs.umd.edu/~pugh/java/memoryModel/BidirectionalMemoryBarrier.html)
> > need their internalization adjusted.
> 
> Shucks, if you only want to show that letting arbitrary code (i.e., 
> branches) migrate into a critical section is unsafe, all you need is 
> this uniprocessor example:
> 
> 	P0(int *sl)
> 	{
> 		goto Skip;
> 		spin_lock(sl);
> 		spin_unlock(sl);
> 	Skip:
> 		spin_lock(sl);
> 		spin_unlock(sl);
> 	}
> 
> This does nothing but runs fine.  Letting the branch move into the first 
> critical section gives:
> 
> 	P0(int *sl)
> 	{
> 		spin_lock(sl);
> 		goto Skip;
> 		spin_unlock(sl);
> 	Skip:
> 		spin_lock(sl);
> 		spin_unlock(sl);
> 	}
> 
> which self-deadlocks 100% of the time.  You don't need to know anything 
> about memory models or concurrency to understand this.

Although your example does an excellent job of illustrating the general
point about branches, I am not convinced that it would be seen as
demonstrating the dangers of moving an entire loop into a critical
section.

> On the other hand, if you want to show that letting memory accesses leak 
> into a critical section is unsafe then you need a different example: 
> spin loops won't do it.

I am not immediately coming up with an example that is broken by leaking
isolated memory accesses into a critical section.  I will give it some
more thought.

> > > Besides, the example is in any case a straw man.  The text starts out 
> > > saying "It is tempting to allow memory-reference instructions to be 
> > > pulled into a critical section", but then the example pulls an entire 
> > > spin loop inside -- not just the memory references but also the 
> > > conditional branch instruction at the bottom of the loop!  I can't 
> > > imagine anyone would think it was safe to allow branches to leak into a 
> > > critical section, particularly when doing so would break a control 
> > > dependency (as it does here).
> > 
> > Most people outside of a few within the Linux kernel community and within
> > the various hardware memory-ordering communities don't know that control
> > dependencies even exist, so could not be expected to see any danger
> > in rather thoroughly folding, spindling, or otherwise mutilating them,
> > let alone pulling them into a lock-based critical section.  And many in
> > the various toolchain communities see dependencies of any sort as an
> > impediment to performance that should be broken wherever and whenever
> > possible.
> > 
> > That said, a less prejudicial introduction to this example might be good.
> > What did you have in mind?
> 
> Again, it depends on what example is intended to accomplish (which you 
> still haven't said explicitly).  Whatever it is, I don't think the 
> current text is a good way to do it.

OK, as noted above, I will move this one out of the v5.10 queue into the
v5.11 queue, which should provide time to refine it, one way or another.

							Thanx, Paul
