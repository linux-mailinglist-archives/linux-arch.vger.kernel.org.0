Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B177339BFF0
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 20:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhFDS5O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 14:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229810AbhFDS5O (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 14:57:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD31D610E5;
        Fri,  4 Jun 2021 18:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622832926;
        bh=lbGmGUKJAoociyTvGuDvE5GguSRrHVdRC6Z9+MlresY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XZ+Bs5499Dxc3msdbIaehNSelb7F5+yU42bjrzk3Oroyge8c/YVWyqoIzFt0JffDs
         WXpcP5Ayd2dXMVhFLaCsCTK4Llpz6H4e7IiXUrnuTKB5nmhsGC5H+fwdO6CHVsw+qA
         TiE58PW1hYN5SFu2qsWE3M3pKmAl2UD5Jhz4z2E0n+ybRaiQteKvz6RI/8Cy5LCmpS
         rBTb6MDkhIy6Aj5T/Ms5txVL9WR+eJ0f+0PRToUHKHgTo/8Y3hRZpcxWhZvYeDm/Fq
         4hAe1Y1W2VH4ughfMmOBVWkvbJX4qSmsQISe7dhOpzoUBbftGGipFxnB5FQjWBrnjx
         GCMgmktzm4xEg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8CC0B5C02AB; Fri,  4 Jun 2021 11:55:26 -0700 (PDT)
Date:   Fri, 4 Jun 2021 11:55:26 -0700
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
Message-ID: <20210604185526.GW4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
 <YLoSJaOVbzKXU4/7@hirez.programming.kicks-ass.net>
 <20210604153518.GD18427@gate.crashing.org>
 <YLpQj+S3vpTLX7cc@hirez.programming.kicks-ass.net>
 <20210604164047.GH18427@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604164047.GH18427@gate.crashing.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 11:40:47AM -0500, Segher Boessenkool wrote:
> On Fri, Jun 04, 2021 at 06:10:55PM +0200, Peter Zijlstra wrote:
> > On Fri, Jun 04, 2021 at 10:35:18AM -0500, Segher Boessenkool wrote:
> > > On Fri, Jun 04, 2021 at 01:44:37PM +0200, Peter Zijlstra wrote:
> > > > On naming (sorry Paul for forgetting that in the initial mail); while I
> > > > think using the volatile qualifier for the language feature (can we haz
> > > > plz, kthxbai) makes perfect sense, Paul felt that we might use a
> > > > 'better' name for the kernel use, ctrl_dep_if() was proposed.
> > > 
> > > In standard C statements do not have qualifiers.  Unless you can
> > > convince the ISO C committee to have them on "if", you will have a very
> > > hard time convincing any serious compiler to do this.
> > 
> > While some people like talking to the Committee, I would much rather
> > explore language extensions with the compiler communities. Such
> > extensions can then make their way into the Committee once they show
> > their usefulness.
> 
> My point is that you ask compiler developers to paint themselves into a
> corner if you ask them to change such fundamental C syntax.

Once we have some experience with a language extension, the official
syntax for a standardized version of that extension can be bikeshedded.
Committees being what they are, what we use in the meantime will
definitely not be what is chosen, so there is not a whole lot of point
in worrying about the exact syntax in the meantime.  ;-)

> > If you have another proposal on how to express this; one you'd rather
> > see implemented, I'm all ears.
> 
> I would love to see something that meshes well with the rest of C.  But
> there is no 1-1 translation from C code to machine code (not in either
> direction), so anything that more or less depends on that will always
> be awkward.  If you can actually express the dependency in your source
> code that will get us 95% to where we want to be.
> 
> > Data dependencies, control dependencies and address dependencies, C
> > doesn't really like them, we rely on them. It would be awesome if we can
> > fix this.
> 
> Yes.  The problem is that C is a high-level language.  All C semantics
> are expressed on a an "as-if" level, never as "do this, then that" --
> well, of course that *is* what it says, it's an imperative language just
> like most, but that is just how you *think* about things on a conceptual
> level, there is nothing that says the machine code has to do the same
> thing in the same order as you wrote!

Which is exactly why these conversations are often difficult.  There is
a tension between pushing the as-if rule as far as possible within the
compiler on the one hand and allowing developers to write code that does
what is needed on the other.  ;-)

							Thanx, Paul
