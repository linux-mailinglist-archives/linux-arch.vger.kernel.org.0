Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B968432B03
	for <lists+linux-arch@lfdr.de>; Tue, 19 Oct 2021 02:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhJSAJl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Oct 2021 20:09:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhJSAJl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 Oct 2021 20:09:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A7BD61207;
        Tue, 19 Oct 2021 00:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634602049;
        bh=7igL9zIZY1pOYFc1oWYSFnoGWVw6qC1oztzuQofgFYk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aAoWUwMw6PYSdQ5FUPCve4kJ6rXbYTvUCgkBAiuiL0zqR2PjuwOIOTh8WzQkCBX38
         RQq7b1KBBPQocd567Vos4IvCRwHEjLl5yfmHMUFqyUl18aR6SFASF3cOVLHRhoynjQ
         lQNcmk3Yhr4UfpqdvgapOTFhGg+XqrLcZRb565zmvG7cmwjjehObmPBtZAAnHHXfRM
         4V9k/qDgixgwHhY3syGM4xYnCZqE8l+LwhClUa2GAJJt6rbk3zYZFYj2QtsIkIApD7
         4ImcTO2jTtBALsZNDOH7I0VWnzQ1yqRKLLgYCijvd8EKtxlwA8fYe/Yg7gv1Sqj6Ge
         09DdqC/UHiwJg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 179085C1044; Mon, 18 Oct 2021 17:07:29 -0700 (PDT)
Date:   Mon, 18 Oct 2021 17:07:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: Another possible use for LKMM, or a subset (strengthening)
 thereof
Message-ID: <20211019000729.GY880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211007205621.GA584182@paulmck-ThinkPad-P17-Gen-1>
 <20211018225313.GA855976@paulmck-ThinkPad-P17-Gen-1>
 <YW4Jsw2y4BWTH5YS@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW4Jsw2y4BWTH5YS@boqun-archlinux>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 19, 2021 at 07:56:35AM +0800, Boqun Feng wrote:
> Hi Paul,
> 
> On Mon, Oct 18, 2021 at 03:53:13PM -0700, Paul E. McKenney wrote:
> > On Thu, Oct 07, 2021 at 01:56:21PM -0700, Paul E. McKenney wrote:
> > > Hello!
> > > 
> > > On the perhaps unlikely chance that this is new news of interest...
> > > 
> > > I have finally prototyped the full "So You Want to Rust the Linux
> > > Kernel?" series (as in marked "under construction").
> > > 
> > > https://paulmck.livejournal.com/62436.html
> > 
> > And this blog series is now proclaimed to be feature complete.
> > 
> > Recommendations (both short- and long-term) may be found in the last post,
> > "TL;DR: Memory-Model Recommendations for Rusting the Linux Kernel",
> > at https://paulmck.livejournal.com/65341.html.
> 
> Thanks for putting this together! For the short-term recommendations, I
> think one practical goal would be having the equivalent (or stronger)
> litmus tests in Rust for the ones in tools/memory-model/litmus-tests.
> The translation of litmus tests may be trivial, but it at least ensure
> us that Rust can support the existing patterns widely used in Linux
> kernel. Of course, the Rust litmus tests don't have to be able to run
> with herd, we just need some code snippest to check our understanding of
> Rust memory model. ;-)

It would be very helpful for klitmus to be able to check Rust-code memory
ordering, now that you mention it!  This would be useful (for example)
to test the Rust wrappers on weakly ordered systems, such as ARM's.

> Besides, it's interesting to how things react with each if one function
> in the litmus test is in Rust and the other is in C ;-) Maybe this is a
> long-term goal.
> 
> Thoughts?

These issues are quite important.  How do you feel that they should be
tracked?

							Thanx, Paul
