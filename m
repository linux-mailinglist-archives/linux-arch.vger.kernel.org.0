Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E5939BF93
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 20:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhFDS24 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 14:28:56 -0400
Received: from netrider.rowland.org ([192.131.102.5]:33333 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229769AbhFDS2z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 14:28:55 -0400
Received: (qmail 1689146 invoked by uid 1000); 4 Jun 2021 14:27:08 -0400
Date:   Fri, 4 Jun 2021 14:27:08 -0400
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
Message-ID: <20210604182708.GB1688170@rowland.harvard.edu>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
 <20210604104359.GE2318@willie-the-truck>
 <YLoPJDzlTsvpjFWt@hirez.programming.kicks-ass.net>
 <20210604134422.GA2793@willie-the-truck>
 <YLoxAOua/qsZXNmY@hirez.programming.kicks-ass.net>
 <20210604151356.GC2793@willie-the-truck>
 <YLpFHE5Cr45rWTUV@hirez.programming.kicks-ass.net>
 <YLpJ5K6O52o1cAVT@hirez.programming.kicks-ass.net>
 <20210604155154.GG1676809@rowland.harvard.edu>
 <YLpSEM7sxSmsuc5t@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLpSEM7sxSmsuc5t@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 06:17:20PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 04, 2021 at 11:51:54AM -0400, Alan Stern wrote:
> > On Fri, Jun 04, 2021 at 05:42:28PM +0200, Peter Zijlstra wrote:
> 
> > > #define volatile_if(cond) if (({ bool __t = (cond); BUILD_BUG_ON(__builtin_constant_p(__t)); volatile_cond(__t); }))
> > 
> > That won't help with more complicated examples, such as:
> > 
> > 	volatile_if (READ_ONCE(*x) * 0 + READ_ONCE(*y))
> 
> That's effectively:
> 
> 	volatile_if (READ_ONCE(*y))
> 		WRITE_ONCE(*y, 42);

Sorry, what I meant to write was:

	volatile_if (READ_ONCE(*x) * 0 + READ_ONCE(*y))
		WRITE_ONCE(*z, 42);

where there is no ordering between *x and *z.  It's not daft, and yes, a 
macro won't be able to warn about it.

Alan

> which is a valid, but daft, LOAD->STORE order, no? A compiler might
> maybe be able to WARN on that, but that's definitely beyond what we can
> do with macros.
