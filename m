Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC1A283957
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 17:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgJEPQA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Oct 2020 11:16:00 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:59540 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726784AbgJEPQA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Oct 2020 11:16:00 -0400
From:   Luc Maranget <luc.maranget@inria.fr>
X-IronPort-AV: E=Sophos;i="5.77,338,1596492000"; 
   d="scan'208";a="471039281"
Received: from yquem.paris.inria.fr (HELO yquem.inria.fr) ([128.93.101.33])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Oct 2020 17:15:57 +0200
Received: by yquem.inria.fr (Postfix, from userid 18041)
        id D9085E1E95; Mon,  5 Oct 2020 17:15:57 +0200 (CEST)
Date:   Mon, 5 Oct 2020 17:15:57 +0200
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, dlustig@nvidia.com, joel@joelfernandes.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: Bug in herd7 [Was: Re: Litmus test for question from Al Viro]
Message-ID: <20201005151557.4bcxumreoekgwmsa@yquem.inria.fr>
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <20201001213048.GF29330@paulmck-ThinkPad-P72>
 <20201003132212.GB318272@rowland.harvard.edu>
 <045c643f-6a70-dfdf-2b1e-f369a667f709@gmail.com>
 <20201003171338.GA323226@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201003171338.GA323226@rowland.harvard.edu>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> On Sun, Oct 04, 2020 at 12:16:31AM +0900, Akira Yokosawa wrote:
> > Hi Alan,
> > 
> > Just a minor nit in the litmus test.
> > 
> > On Sat, 3 Oct 2020 09:22:12 -0400, Alan Stern wrote:
> > > To expand on my statement about the LKMM's weakness regarding control 
> > > constructs, here is a litmus test to illustrate the issue.  You might 
> > > want to add this to one of the archives.
> > > 
> > > Alan
> > > 
> > > C crypto-control-data
> > > (*
> > >  * LB plus crypto-control-data plus data
> > >  *
> > >  * Expected result: allowed
> > >  *
> > >  * This is an example of OOTA and we would like it to be forbidden.
> > >  * The WRITE_ONCE in P0 is both data-dependent and (at the hardware level)
> > >  * control-dependent on the preceding READ_ONCE.  But the dependencies are
> > >  * hidden by the form of the conditional control construct, hence the 
> > >  * name "crypto-control-data".  The memory model doesn't recognize them.
> > >  *)
> > > 
> > > {}
> > > 
> > > P0(int *x, int *y)
> > > {
> > > 	int r1;
> > > 
> > > 	r1 = 1;
> > > 	if (READ_ONCE(*x) == 0)
> > > 		r1 = 0;
> > > 	WRITE_ONCE(*y, r1);
> > > }
> > > 
> > > P1(int *x, int *y)
> > > {
> > > 	WRITE_ONCE(*x, READ_ONCE(*y));
> > 
> > Looks like this one-liner doesn't provide data-dependency of y -> x on herd7.
> 
> You're right.  This is definitely a bug in herd7.
> 
> Luc, were you aware of this?

Hi Alan,

No I was not aware of it. Now I am, the bug is normally fixed in the master branch of herd git deposit.
<https://github.com/herd/herdtools7/commit/0f3f8188a326d5816a82fb9970fcd209a2678859>

Thanks for the report.

--Luc
