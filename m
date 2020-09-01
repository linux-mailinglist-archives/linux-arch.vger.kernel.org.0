Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEDB0259FA2
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 22:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgIAULN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 16:11:13 -0400
Received: from netrider.rowland.org ([192.131.102.5]:39835 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728224AbgIAULL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 16:11:11 -0400
Received: (qmail 600595 invoked by uid 1000); 1 Sep 2020 16:11:10 -0400
Date:   Tue, 1 Sep 2020 16:11:10 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH kcsan 9/9] tools/memory-model:  Document locking corner
 cases
Message-ID: <20200901201110.GB599114@rowland.harvard.edu>
References: <20200831182012.GA1965@paulmck-ThinkPad-P72>
 <20200831182037.2034-9-paulmck@kernel.org>
 <20200831201701.GB558270@rowland.harvard.edu>
 <20200831214738.GE2855@paulmck-ThinkPad-P72>
 <20200901014504.GB571008@rowland.harvard.edu>
 <20200901170421.GF29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901170421.GF29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 01, 2020 at 10:04:21AM -0700, Paul E. McKenney wrote:
> On Mon, Aug 31, 2020 at 09:45:04PM -0400, Alan Stern wrote:

> > The question is, what are you trying to accomplish in this section?  Are 
> > you trying to demonstrate that it isn't safe to allow arbitrary code to 
> > leak into a critical section?  If so then you don't need to present an 
> > LKMM litmus test to make the point; the example I gave here will do 
> > quite as well.  Perhaps even better, since it doesn't drag in all sorts 
> > of extraneous concepts like limitations of litmus tests or how to 
> > emulate a spin loop.
> > 
> > On the other hand, if your goal is to show how to construct a litmus 
> > test that will model a particular C language test case (such as the one 
> > I gave), then the text does a reasonable job -- although I do think it 
> > could be clarified somewhat.  For instance, it wouldn't hurt to include 
> > the real C code before giving the corresponding litmus test, so that the 
> > reader will have a clear idea of what you're trying to model.
> 
> Makes sense.  I can apply this at some point, but I would welcome a patch
> from you, which I would be happy to fold in with your Codeveloped-by.

I don't have time to work on these documents now.  Maybe later on.  They 
do need some serious editing.  (You could try reading through them 
carefully yourself; I'm sure you'd find a lot of things to fix up.)

Incidentally, your patch bomb from yesterday was the first time I had 
seen these things (except for the litmus-test format document).

> > Just what you want to achieve here is not clear from the context.
> 
> People who have internalized the "roach motel" model of locking
> (https://www.cs.umd.edu/~pugh/java/memoryModel/BidirectionalMemoryBarrier.html)
> need their internalization adjusted.

Shucks, if you only want to show that letting arbitrary code (i.e., 
branches) migrate into a critical section is unsafe, all you need is 
this uniprocessor example:

	P0(int *sl)
	{
		goto Skip;
		spin_lock(sl);
		spin_unlock(sl);
	Skip:
		spin_lock(sl);
		spin_unlock(sl);
	}

This does nothing but runs fine.  Letting the branch move into the first 
critical section gives:

	P0(int *sl)
	{
		spin_lock(sl);
		goto Skip;
		spin_unlock(sl);
	Skip:
		spin_lock(sl);
		spin_unlock(sl);
	}

which self-deadlocks 100% of the time.  You don't need to know anything 
about memory models or concurrency to understand this.

On the other hand, if you want to show that letting memory accesses leak 
into a critical section is unsafe then you need a different example: 
spin loops won't do it.

> > Besides, the example is in any case a straw man.  The text starts out 
> > saying "It is tempting to allow memory-reference instructions to be 
> > pulled into a critical section", but then the example pulls an entire 
> > spin loop inside -- not just the memory references but also the 
> > conditional branch instruction at the bottom of the loop!  I can't 
> > imagine anyone would think it was safe to allow branches to leak into a 
> > critical section, particularly when doing so would break a control 
> > dependency (as it does here).
> 
> Most people outside of a few within the Linux kernel community and within
> the various hardware memory-ordering communities don't know that control
> dependencies even exist, so could not be expected to see any danger
> in rather thoroughly folding, spindling, or otherwise mutilating them,
> let alone pulling them into a lock-based critical section.  And many in
> the various toolchain communities see dependencies of any sort as an
> impediment to performance that should be broken wherever and whenever
> possible.
> 
> That said, a less prejudicial introduction to this example might be good.
> What did you have in mind?

Again, it depends on what example is intended to accomplish (which you 
still haven't said explicitly).  Whatever it is, I don't think the 
current text is a good way to do it.

Alan
