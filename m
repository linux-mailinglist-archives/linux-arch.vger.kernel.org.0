Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9CC283FDB
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 21:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgJETsg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Oct 2020 15:48:36 -0400
Received: from netrider.rowland.org ([192.131.102.5]:43373 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729477AbgJETsf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Oct 2020 15:48:35 -0400
Received: (qmail 391029 invoked by uid 1000); 5 Oct 2020 15:48:34 -0400
Date:   Mon, 5 Oct 2020 15:48:34 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        dlustig@nvidia.com, joel@joelfernandes.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: Bug in herd7 [Was: Re: Litmus test for question from Al Viro]
Message-ID: <20201005194834.GB389867@rowland.harvard.edu>
References: <20201001161529.GA251468@rowland.harvard.edu>
 <20201001213048.GF29330@paulmck-ThinkPad-P72>
 <20201003132212.GB318272@rowland.harvard.edu>
 <045c643f-6a70-dfdf-2b1e-f369a667f709@gmail.com>
 <20201003171338.GA323226@rowland.harvard.edu>
 <20201005151557.4bcxumreoekgwmsa@yquem.inria.fr>
 <20201005155310.GH376584@rowland.harvard.edu>
 <20201005165223.GB29330@paulmck-ThinkPad-P72>
 <20201005181949.GA387079@rowland.harvard.edu>
 <20201005191801.GF29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005191801.GF29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 05, 2020 at 12:18:01PM -0700, Paul E. McKenney wrote:
> Aside from naming and comment, how about my adding the following?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> C crypto-control-data-1

Let's call it something more along the lines of 
dependencies-in-nested-expressions.  Maybe you can think of something a 
little more succinct, but that's the general idea of the test.

> (*
>  * LB plus crypto-mb-data plus data.

The actual pattern is LB+mb+data.

>  *
>  * Result: Never
>  *
>  * This is an example of OOTA and we would like it to be forbidden.
>  * If you want herd7 to get the right answer, you must use herdtools
>  * 0f3f8188a326 (" [herd] Fix dependency definition") or later.

Versions of herd7 prior to commit 0f3f8188a326 ("[herd] Fix dependency 
definition") recognize data dependencies only when they flow through an 
intermediate local variable.  Since the dependency in P1 doesn't, those
versions get the wrong answer for this test.

>  *)
> 
> {}
> 
> P0(int *x, int *y)
> {
> 	int r1;
> 
> 	r1 = READ_ONCE(*x);
> 	smp_mb();
> 	WRITE_ONCE(*y, r1);
> }
> 
> P1(int *x, int *y)
> {
> 	int r2;

No need for r2.

> 
> 	WRITE_ONCE(*x, READ_ONCE(*y));
> }
> 
> exists (0:r1=1)

Alan
