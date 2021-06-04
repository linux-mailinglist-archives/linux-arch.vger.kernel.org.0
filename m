Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67DB39BC42
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 17:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhFDPxe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 11:53:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:35730 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhFDPxe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 11:53:34 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 154FlJPc021199;
        Fri, 4 Jun 2021 10:47:19 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 154FlIM5021198;
        Fri, 4 Jun 2021 10:47:18 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 4 Jun 2021 10:47:18 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        paulmck@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, linux-kernel@vger.kernel.org,
        linux-toolchains@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210604154718.GE18427@gate.crashing.org>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net> <20210604104359.GE2318@willie-the-truck> <YLoPJDzlTsvpjFWt@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLoPJDzlTsvpjFWt@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 01:31:48PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 04, 2021 at 11:44:00AM +0100, Will Deacon wrote:
> > > +{
> > > +	asm_volatile_goto("cbnz %0, %l[l_yes]"
> > > +			  : : "r" (cond) : "cc", "memory" : l_yes);
> > > +	return 0;
> > > +l_yes:
> > > +	return 1;
> > > +}
> > 
> > nit: you don't need the "cc" clobber here.
> 
> Yeah I know, "cc" is implied.

It isn't needed at all here.  cbnz does not write to the condition
register.  Neither does it change or access memory, but the "memory"
clobber is to force a false dependency.  Writing "cc" as well looks a
bit confusing, given that.


Segher
