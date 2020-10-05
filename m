Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87BD5283F6E
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 21:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgJETSC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Oct 2020 15:18:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgJETSC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 5 Oct 2020 15:18:02 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3202207BC;
        Mon,  5 Oct 2020 19:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601925482;
        bh=IcC9o9ngStTEJMrfG0NT9+M7gPC+tGiHzkcWMzeEH04=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eTPy7ux9+kBD5aIrq0LxKtk8NbctDnlPPjb/PNEGek2TFJaE/arGQ69695aoMfMPD
         edVEP2EDFp7C03t9Y2IcGekgWXTVRJEL9qc3iqDWBosRSdjodDBnDz3gPHYrjbVPdA
         VTHaCaCcJo76aNP7XscZIUS6sptyrdGN5VGOhdas=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BE8AE3523039; Mon,  5 Oct 2020 12:18:01 -0700 (PDT)
Date:   Mon, 5 Oct 2020 12:18:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        dlustig@nvidia.com, joel@joelfernandes.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: Bug in herd7 [Was: Re: Litmus test for question from Al Viro]
Message-ID: <20201005191801.GF29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <20201001213048.GF29330@paulmck-ThinkPad-P72>
 <20201003132212.GB318272@rowland.harvard.edu>
 <045c643f-6a70-dfdf-2b1e-f369a667f709@gmail.com>
 <20201003171338.GA323226@rowland.harvard.edu>
 <20201005151557.4bcxumreoekgwmsa@yquem.inria.fr>
 <20201005155310.GH376584@rowland.harvard.edu>
 <20201005165223.GB29330@paulmck-ThinkPad-P72>
 <20201005181949.GA387079@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005181949.GA387079@rowland.harvard.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 05, 2020 at 02:19:49PM -0400, Alan Stern wrote:
> On Mon, Oct 05, 2020 at 09:52:23AM -0700, Paul E. McKenney wrote:
> > On Mon, Oct 05, 2020 at 11:53:10AM -0400, Alan Stern wrote:
> > > I tested the new commit -- it does indeed fix the problem.
> > 
> > Beat me to it, very good!  ;-)
> > 
> > But were you using the crypto-control-data litmus test?
> 
> I was not.  The test I used was what you get by starting from the 
> version of crypto-control-data that had the one-liner in P1, and then 
> replacing P0 with:
> 
> P0(int *x, int *y)
> {
> 	int r1;
> 
> 	r1 = READ_ONCE(*x);
> 	smp_mb();
> 	WRITE_ONCE(*y, 1);
> }
> 
> Without the new commit this test is allowed; with the new commit it 
> isn't (as we would expect).  Also, the graphical output from herd7 shows 
> the data dependency in P1 with the commit, and doesn't show it without 
> the commit.
> 
> >  That one still
> > gets me Sometimes:
> > 
> > $ herd7 -version
> > 7.56+02~dev, Rev: 0f3f8188a326d5816a82fb9970fcd209a2678859
> > $ herd7 -conf linux-kernel.cfg ~/paper/scalability/LWNLinuxMM/litmus/manual/kernel/crypto-control-data.litmus
> > Test crypto-control-data Allowed
> > States 2
> > 0:r1=0;
> > 0:r1=1;
> > Ok
> > Witnesses
> > Positive: 1 Negative: 4
> > Condition exists (0:r1=1)
> > Observation crypto-control-data Sometimes 1 4
> > Time crypto-control-data 0.00
> > Hash=10898119bac87e11f31dc22bbb7efe17
> > 
> > Or did I mess something up?
> 
> You didn't mess up anything.  That's the whole point of this litmus 
> test: It should be forbidden because it is an example of OOTA, but LKMM 
> allows it.  Even with Luc's new commit.

OK, got it.

Aside from naming and comment, how about my adding the following?

							Thanx, Paul

------------------------------------------------------------------------

C crypto-control-data-1
(*
 * LB plus crypto-mb-data plus data.
 *
 * Result: Never
 *
 * This is an example of OOTA and we would like it to be forbidden.
 * If you want herd7 to get the right answer, you must use herdtools
 * 0f3f8188a326 (" [herd] Fix dependency definition") or later.
 *)

{}

P0(int *x, int *y)
{
	int r1;

	r1 = READ_ONCE(*x);
	smp_mb();
	WRITE_ONCE(*y, r1);
}

P1(int *x, int *y)
{
	int r2;

	WRITE_ONCE(*x, READ_ONCE(*y));
}

exists (0:r1=1)
