Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB83C39BC44
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 17:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhFDPxm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 11:53:42 -0400
Received: from netrider.rowland.org ([192.131.102.5]:41351 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231286AbhFDPxl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 11:53:41 -0400
Received: (qmail 1683583 invoked by uid 1000); 4 Jun 2021 11:51:54 -0400
Date:   Fri, 4 Jun 2021 11:51:54 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        paulmck@kernel.org, parri.andrea@gmail.com, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210604155154.GG1676809@rowland.harvard.edu>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
 <20210604104359.GE2318@willie-the-truck>
 <YLoPJDzlTsvpjFWt@hirez.programming.kicks-ass.net>
 <20210604134422.GA2793@willie-the-truck>
 <YLoxAOua/qsZXNmY@hirez.programming.kicks-ass.net>
 <20210604151356.GC2793@willie-the-truck>
 <YLpFHE5Cr45rWTUV@hirez.programming.kicks-ass.net>
 <YLpJ5K6O52o1cAVT@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLpJ5K6O52o1cAVT@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 05:42:28PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 04, 2021 at 05:22:04PM +0200, Peter Zijlstra wrote:
> > On Fri, Jun 04, 2021 at 04:13:57PM +0100, Will Deacon wrote:
> > 
> > > In fact, maybe it's actually necessary to bundle the load and branch
> > > together. I looked at some of the examples of compilers breaking control
> > > dependencies from memory-barriers.txt and the "boolean short-circuit"
> > > example seems to defeat volatile_if:
> > > 
> > > void foo(int *x, int *y)
> > > {
> > >         volatile_if (READ_ONCE(*x) || 1 > 0)
> > >                 WRITE_ONCE(*y, 42);
> > > }  
> > 
> > Yeah, I'm not too bothered about this. Broken is broken.
> > 
> > If this were a compiler feature, the above would be a compile error. But
> > alas, we're not there yet :/ and the best we get to say at this point
> > is: don't do that then.
> 
> Ha! Fixed it for you:
> 
> #define volatile_if(cond) if (({ bool __t = (cond); BUILD_BUG_ON(__builtin_constant_p(__t)); volatile_cond(__t); }))

That won't help with more complicated examples, such as:

	volatile_if (READ_ONCE(*x) * 0 + READ_ONCE(*y))

Alan
