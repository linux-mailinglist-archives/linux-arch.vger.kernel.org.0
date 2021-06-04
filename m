Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796EB39C175
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 22:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhFDUma (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 16:42:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhFDUm3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 16:42:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27598613F9;
        Fri,  4 Jun 2021 20:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622839243;
        bh=KxYYmfZHvreYfegSJ6Yvy7eFkAGPX45eOume+9GyXWQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=S2frtJgwPxsoQMaengHFztep8buKaFEnvjnfyyZhpMsd7HstGhutbivJbGnbDsLLF
         vI0L4Z1ovfRuhrTF487QmKmHxYRQ8vvyVYxz2BVUtmZXCUr4MRLH9xAIP84gQa4fi/
         /62QrBDGZrJg9ovBTjaMdz67kKUHxdoC5utbwRV+okMDpeb6xXUGh+8yaS3R87z4zd
         nf+31XSlN7rDNaciCQRouITPzH0hjKqA5RpqbGSrjDVMJsMskFHApqCCZlob2H3yZW
         f3soUidC0FzWGI3/jqwB2GXNobE/zDdq3GtGDeRM9deZgAFxtXwgxNo+XlfiIRPFSk
         jUnp0e0o34lmg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E21225C02AB; Fri,  4 Jun 2021 13:40:42 -0700 (PDT)
Date:   Fri, 4 Jun 2021 13:40:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        will@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210604204042.GZ4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
 <YLoSJaOVbzKXU4/7@hirez.programming.kicks-ass.net>
 <20210604153518.GD18427@gate.crashing.org>
 <YLpQj+S3vpTLX7cc@hirez.programming.kicks-ass.net>
 <20210604164047.GH18427@gate.crashing.org>
 <20210604185526.GW4397@paulmck-ThinkPad-P17-Gen-1>
 <20210604195301.GM18427@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604195301.GM18427@gate.crashing.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 02:53:01PM -0500, Segher Boessenkool wrote:
> On Fri, Jun 04, 2021 at 11:55:26AM -0700, Paul E. McKenney wrote:
> > On Fri, Jun 04, 2021 at 11:40:47AM -0500, Segher Boessenkool wrote:
> > > My point is that you ask compiler developers to paint themselves into a
> > > corner if you ask them to change such fundamental C syntax.
> > 
> > Once we have some experience with a language extension, the official
> > syntax for a standardized version of that extension can be bikeshedded.
> > Committees being what they are, what we use in the meantime will
> > definitely not be what is chosen, so there is not a whole lot of point
> > in worrying about the exact syntax in the meantime.  ;-)
> 
> I am only saying that it is unlikely any compiler that is used in
> production will want to experiment with "volatile if".

That unfortunately matches my experience over quite a few years.  But if
something can be implemented using existing extensions, the conversations
often get easier.  Especially given many more people are now familiar
with concurrency.

> > > I would love to see something that meshes well with the rest of C.  But
> > > there is no 1-1 translation from C code to machine code (not in either
> > > direction), so anything that more or less depends on that will always
> > > be awkward.  If you can actually express the dependency in your source
> > > code that will get us 95% to where we want to be.
> 
> ^^^
> 
> > > > Data dependencies, control dependencies and address dependencies, C
> > > > doesn't really like them, we rely on them. It would be awesome if we can
> > > > fix this.
> > > 
> > > Yes.  The problem is that C is a high-level language.  All C semantics
> > > are expressed on a an "as-if" level, never as "do this, then that" --
> > > well, of course that *is* what it says, it's an imperative language just
> > > like most, but that is just how you *think* about things on a conceptual
> > > level, there is nothing that says the machine code has to do the same
> > > thing in the same order as you wrote!
> > 
> > Which is exactly why these conversations are often difficult.  There is
> > a tension between pushing the as-if rule as far as possible within the
> > compiler on the one hand and allowing developers to write code that does
> > what is needed on the other.  ;-)
> 
> There is a tension between what users expect from the compiler and what
> actually is promised.  The compiler is not pushing the as-if rule any
> further than it always has: it just becomes better at optimising over
> time.  The as-if rule is and always has been absolute.

Heh!  The fact that the compiler has become better at optimizing
over time is exactly what has been pushing the as-if rule further.

The underlying problem is that it is often impossible to write large
applications (such as the Linux kernel) completely within the confines of
the standard.  Thus, most large applications, and especially concurrent
applications, are vulnerable to either the compiler becoming better
at optimizing or compilers pushing the as-if rule, however you want to
say it.

> What is needed to get any progress is for user expectations to be
> feasible and not contradict existing requirements.  See "^^^" above.

Or additional requirements need to be accepted by the various compilation
powers that be.  Failing to acknowledge valid new user expectations is
after all an excellent path to obsolescence.

							Thanx, Paul
