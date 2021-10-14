Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8616F42E31B
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 23:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhJNVMF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 17:12:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230314AbhJNVMF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Oct 2021 17:12:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB03C610A0;
        Thu, 14 Oct 2021 21:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634245799;
        bh=4TYiyp4sVKUskNtzVyTQ21gmDtCxwEMzXP/fy+9w4VU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=saRPFvZyUX8osI9aDVpT1HWcp+O69VRT+9TTbndX2ttphpDwHsY091dNrI6USNSLa
         onbLmrUJhpOXG55N3GNFTn94HZoW48gP+//eG6pQN9sl+LUIXUILq+Agf052RPBFgB
         cAXdLAyoYcwRfZ5KCgZZKIw7f3b6JVHlmvvFt+H/E1T6XISRkWTZpP3XE8aMDGg7e7
         HN3XJ9skYETzs4R4gWAN3lhiH4C3eJFD7seztDVDbXhSdAIrtgpqJwdL9HCMCqwSQU
         Mp/W31JzwHxKF1nIZUrCbyS9eJL7IRQoy+96nJ93SREmq8hZxUl+u/LZf1CrHnOdFn
         cL7nEqBhIKAOw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7831A5C0A6E; Thu, 14 Oct 2021 14:09:59 -0700 (PDT)
Date:   Thu, 14 Oct 2021 14:09:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        j alglave <j.alglave@ucl.ac.uk>,
        luc maranget <luc.maranget@inria.fr>,
        akiyks <akiyks@gmail.com>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
Message-ID: <20211014210959.GJ880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <87lf3f7eh6.fsf@oldenburg.str.redhat.com>
 <20210929174146.GF22689@gate.crashing.org>
 <2088260319.47978.1633104808220.JavaMail.zimbra@efficios.com>
 <871r54ww2k.fsf@oldenburg.str.redhat.com>
 <CAHk-=wgexLqNnngLPts=wXrRcoP_XHO03iPJbsAg8HYuJbbAvw@mail.gmail.com>
 <87y271yo4l.fsf@mid.deneb.enyo.de>
 <20211014000104.GX880162@paulmck-ThinkPad-P17-Gen-1>
 <87lf2v61k7.fsf@mid.deneb.enyo.de>
 <20211014162311.GD880162@paulmck-ThinkPad-P17-Gen-1>
 <87o87r4gfp.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o87r4gfp.fsf@mid.deneb.enyo.de>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 14, 2021 at 08:19:54PM +0200, Florian Weimer wrote:
> * Paul E. McKenney:
> 
> >> > Yes, I know, we for sure have conflicting constraints on "reasonable"
> >> > on copy on this email.  What else is new?  ;-)
> >> >
> >> > I could imagine a tag of some sort on the load and store, linking the
> >> > operations that needed to be ordered.  You would also want that same
> >> > tag on any conditional operators along the way?  Or would the presence
> >> > of the tags on the load and store suffice?
> >> 
> >> If the load is assigned to a local variable whose address is not taken
> >> and which is only assigned this once, it could be used to label the
> >> store.  Then the compiler checks if all paths from the load to the
> >> store feature a condition that depends on the local variable (where
> >> qualifying conditions probably depend on the architecture).  If it
> >> can't prove that is the case, it emits a fake no-op condition that
> >> triggers the hardware barrier.  This formulation has the advantage
> >> that it does not add side effects to operators like <.  It even
> >> generalizes to different barrier-implying instructions besides
> >> conditional branches.
> >
> > So something like this?
> >
> > 	tagvar = READ_ONCE(a);
> > 	if (tagvar)
> > 		WRITE_ONCE_COND(b, 1, tagvar);
> 
> Yes, something like that.  The syntax only makes sense if tagvar is
> assigned only once (statically).
> 
> > (This seems to me to be an eminently reasonable syntax.)
> >
> > Or did I miss a turn in there somewhere?
> 
> The important bit is that the compiler emits the extra condition when
> necessary, and the information in the snippet above seems to provide
> enough information to optimize it away in principle, when it's safe.
> This assumes that we can actually come up with a concrete model what
> triggers the hardware barrier, of course.  For example, if tagvar is
> spilled to the stack, is it still possible to apply an effective
> condition to it after it is loaded from the stack?  If not, then the
> compiler would have to put in a barrier before spilling tagvar if it
> is used in any WRITE_ONCE_COND statement.

In all the weakly ordered architectures I am aware of, spilling to
the stack and reloading preserves the ordering.  The ordering from
the initial load to the spill is an assembly-language data dependency,
the ordering from the spill to the reload is single-variable SC, and
the ordering beyond that is the original control dependency.

						Thanx, Paul
