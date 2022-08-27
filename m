Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C205A38A2
	for <lists+linux-arch@lfdr.de>; Sat, 27 Aug 2022 18:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiH0QFg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Aug 2022 12:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiH0QFf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Aug 2022 12:05:35 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1B8FF1ADB8
        for <linux-arch@vger.kernel.org>; Sat, 27 Aug 2022 09:05:34 -0700 (PDT)
Received: (qmail 70715 invoked by uid 1000); 27 Aug 2022 12:05:33 -0400
Date:   Sat, 27 Aug 2022 12:05:33 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, parri.andrea@gmail.com,
        will@kernel.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: "Verifying and Optimizing Compact NUMA-Aware Locks on Weak
 Memory Models"
Message-ID: <YwpAzTwSRCK5kdLN@rowland.harvard.edu>
References: <20220826124812.GA3007435@paulmck-ThinkPad-P17-Gen-1>
 <YwjzfASTcODOXP1f@worktop.programming.kicks-ass.net>
 <Ywj+j2kC+5xb6DmO@rowland.harvard.edu>
 <YwlbpPHzp8tj0Gn0@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwlbpPHzp8tj0Gn0@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 27, 2022 at 01:47:48AM +0200, Peter Zijlstra wrote:
> On Fri, Aug 26, 2022 at 01:10:39PM -0400, Alan Stern wrote:
> 
> > >  - some babbling about a missing propagation -- ISTR Linux if stuffed
> > >    full of them, specifically we require stores to auto propagate
> > >    without help from barriers
> > 
> > Not a missing propagation; a late one.
> > 
> > Don't understand what you mean by "auto propagate without help from 
> > barriers".
> 
> Linux hard relies on:
> 
> 	CPU0				CPU1
> 
> 	WRITE_ONCE(foo, 1);		while (!READ_ONCE(foo));
> 
> making forward progress.

Indeed yes.  As far as I can tell, this requirement is not explicitly 
mentioned in the LKMM, although it certainly is implicit.  I can't even 
think of a way to express it in a form Herd could verify.

> There were a few 'funny' uarchs that were broken, see for example commit
> a30718868915f.

Ha!  That commit should be a lesson in something, although I'm not sure 
what.  :-)

Alan
