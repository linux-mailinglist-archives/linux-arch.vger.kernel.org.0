Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72E8283E21
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 20:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgJESTu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Oct 2020 14:19:50 -0400
Received: from netrider.rowland.org ([192.131.102.5]:35515 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727067AbgJESTu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Oct 2020 14:19:50 -0400
Received: (qmail 387611 invoked by uid 1000); 5 Oct 2020 14:19:49 -0400
Date:   Mon, 5 Oct 2020 14:19:49 -0400
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
Message-ID: <20201005181949.GA387079@rowland.harvard.edu>
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <20201001213048.GF29330@paulmck-ThinkPad-P72>
 <20201003132212.GB318272@rowland.harvard.edu>
 <045c643f-6a70-dfdf-2b1e-f369a667f709@gmail.com>
 <20201003171338.GA323226@rowland.harvard.edu>
 <20201005151557.4bcxumreoekgwmsa@yquem.inria.fr>
 <20201005155310.GH376584@rowland.harvard.edu>
 <20201005165223.GB29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005165223.GB29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 05, 2020 at 09:52:23AM -0700, Paul E. McKenney wrote:
> On Mon, Oct 05, 2020 at 11:53:10AM -0400, Alan Stern wrote:
> > I tested the new commit -- it does indeed fix the problem.
> 
> Beat me to it, very good!  ;-)
> 
> But were you using the crypto-control-data litmus test?

I was not.  The test I used was what you get by starting from the 
version of crypto-control-data that had the one-liner in P1, and then 
replacing P0 with:

P0(int *x, int *y)
{
	int r1;

	r1 = READ_ONCE(*x);
	smp_mb();
	WRITE_ONCE(*y, 1);
}

Without the new commit this test is allowed; with the new commit it 
isn't (as we would expect).  Also, the graphical output from herd7 shows 
the data dependency in P1 with the commit, and doesn't show it without 
the commit.

>  That one still
> gets me Sometimes:
> 
> $ herd7 -version
> 7.56+02~dev, Rev: 0f3f8188a326d5816a82fb9970fcd209a2678859
> $ herd7 -conf linux-kernel.cfg ~/paper/scalability/LWNLinuxMM/litmus/manual/kernel/crypto-control-data.litmus
> Test crypto-control-data Allowed
> States 2
> 0:r1=0;
> 0:r1=1;
> Ok
> Witnesses
> Positive: 1 Negative: 4
> Condition exists (0:r1=1)
> Observation crypto-control-data Sometimes 1 4
> Time crypto-control-data 0.00
> Hash=10898119bac87e11f31dc22bbb7efe17
> 
> Or did I mess something up?

You didn't mess up anything.  That's the whole point of this litmus 
test: It should be forbidden because it is an example of OOTA, but LKMM 
allows it.  Even with Luc's new commit.

Alan
