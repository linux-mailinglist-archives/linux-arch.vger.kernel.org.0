Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38FC6283BB5
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 17:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgJEPyn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Oct 2020 11:54:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbgJEPym (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 5 Oct 2020 11:54:42 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48AF220639;
        Mon,  5 Oct 2020 15:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601913282;
        bh=p24Rm1HAMyOkdLPAJpi17RWY/e0CuocuAtkip4KtBYc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=S5BEKmenv8LCIi1t6sLpFvbCf0UHuCS+11JyhTz1JyXUfpIwnUefOIKirDd1TdAdr
         VQ+ni9/SCZrdrxlc4fKWEhpJuhJxcUyxuRBv6cX5K798aOwRQlSo+9gmsu2RxFxHN9
         XWROvrOYEl8AzQuUMFPHmje2ZUlmYffZJ5MlL5Hw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0CAD7352301E; Mon,  5 Oct 2020 08:54:42 -0700 (PDT)
Date:   Mon, 5 Oct 2020 08:54:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Luc Maranget <luc.maranget@inria.fr>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Akira Yokosawa <akiyks@gmail.com>, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        dlustig@nvidia.com, joel@joelfernandes.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: Bug in herd7 [Was: Re: Litmus test for question from Al Viro]
Message-ID: <20201005155441.GZ29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <20201001213048.GF29330@paulmck-ThinkPad-P72>
 <20201003132212.GB318272@rowland.harvard.edu>
 <045c643f-6a70-dfdf-2b1e-f369a667f709@gmail.com>
 <20201003171338.GA323226@rowland.harvard.edu>
 <20201005151557.4bcxumreoekgwmsa@yquem.inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005151557.4bcxumreoekgwmsa@yquem.inria.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 05, 2020 at 05:15:57PM +0200, Luc Maranget wrote:
> > On Sun, Oct 04, 2020 at 12:16:31AM +0900, Akira Yokosawa wrote:
> > > Hi Alan,
> > > 
> > > Just a minor nit in the litmus test.
> > > 
> > > On Sat, 3 Oct 2020 09:22:12 -0400, Alan Stern wrote:
> > > > To expand on my statement about the LKMM's weakness regarding control 
> > > > constructs, here is a litmus test to illustrate the issue.  You might 
> > > > want to add this to one of the archives.
> > > > 
> > > > Alan
> > > > 
> > > > C crypto-control-data
> > > > (*
> > > >  * LB plus crypto-control-data plus data
> > > >  *
> > > >  * Expected result: allowed
> > > >  *
> > > >  * This is an example of OOTA and we would like it to be forbidden.
> > > >  * The WRITE_ONCE in P0 is both data-dependent and (at the hardware level)
> > > >  * control-dependent on the preceding READ_ONCE.  But the dependencies are
> > > >  * hidden by the form of the conditional control construct, hence the 
> > > >  * name "crypto-control-data".  The memory model doesn't recognize them.
> > > >  *)
> > > > 
> > > > {}
> > > > 
> > > > P0(int *x, int *y)
> > > > {
> > > > 	int r1;
> > > > 
> > > > 	r1 = 1;
> > > > 	if (READ_ONCE(*x) == 0)
> > > > 		r1 = 0;
> > > > 	WRITE_ONCE(*y, r1);
> > > > }
> > > > 
> > > > P1(int *x, int *y)
> > > > {
> > > > 	WRITE_ONCE(*x, READ_ONCE(*y));
> > > 
> > > Looks like this one-liner doesn't provide data-dependency of y -> x on herd7.
> > 
> > You're right.  This is definitely a bug in herd7.
> > 
> > Luc, were you aware of this?
> 
> Hi Alan,
> 
> No I was not aware of it. Now I am, the bug is normally fixed in the master branch of herd git deposit.
> <https://github.com/herd/herdtools7/commit/0f3f8188a326d5816a82fb9970fcd209a2678859>
> 
> Thanks for the report.

Thank you very much, Luc!  I will rebuild and give it a try.

							Thanx, Paul
