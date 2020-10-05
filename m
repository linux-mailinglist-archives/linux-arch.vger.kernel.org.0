Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C38A283720
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 15:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgJEN7q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Oct 2020 09:59:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJEN7q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 5 Oct 2020 09:59:46 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24CBB207BC;
        Mon,  5 Oct 2020 13:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601906386;
        bh=sRoRo8A4Y2/smESa5LnWt0wUfm835pdpnaNhpMiyvSI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Nx+/jHpZKjx8zUibPb3mTL/R6G6SJjWDpGw2qZ6LWujqbgEG1oo7vhEqPMz2Eg2Wd
         vnP69DC3k/roVTFDC8GeVqqujPsE5M22U+6LVujr5E26DOsRy6yrV4HQ4XmqfsHVb5
         NC2V1CYaJ/AN04SuCV26IWKtTT7J/W8QeS0qk3LU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E2624352301E; Mon,  5 Oct 2020 06:59:45 -0700 (PDT)
Date:   Mon, 5 Oct 2020 06:59:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: Litmus test for question from Al Viro
Message-ID: <20201005135945.GU29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <20201001213048.GF29330@paulmck-ThinkPad-P72>
 <20201003132212.GB318272@rowland.harvard.edu>
 <20201004233146.GP29330@paulmck-ThinkPad-P72>
 <5cf6b793978e4cd8ae10344336c13adb@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cf6b793978e4cd8ae10344336c13adb@AcuMS.aculab.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 05, 2020 at 08:36:51AM +0000, David Laight wrote:
> From: Paul E. McKenney
> > Sent: 05 October 2020 00:32
> ...
> >     manual/kernel: Add a litmus test with a hidden dependency
> > 
> >     This commit adds a litmus test that has a data dependency that can be
> >     hidden by control flow.  In this test, both the taken and the not-taken
> >     branches of an "if" statement must be accounted for in order to properly
> >     analyze the litmus test.  But herd7 looks only at individual executions
> >     in isolation, so fails to see the dependency.
> > 
> >     Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/manual/kernel/crypto-control-data.litmus b/manual/kernel/crypto-control-data.litmus
> > new file mode 100644
> > index 0000000..6baecf9
> > --- /dev/null
> > +++ b/manual/kernel/crypto-control-data.litmus
> > @@ -0,0 +1,31 @@
> > +C crypto-control-data
> > +(*
> > + * LB plus crypto-control-data plus data
> > + *
> > + * Result: Sometimes
> > + *
> > + * This is an example of OOTA and we would like it to be forbidden.
> > + * The WRITE_ONCE in P0 is both data-dependent and (at the hardware level)
> > + * control-dependent on the preceding READ_ONCE.  But the dependencies are
> > + * hidden by the form of the conditional control construct, hence the
> > + * name "crypto-control-data".  The memory model doesn't recognize them.
> > + *)
> > +
> > +{}
> > +
> > +P0(int *x, int *y)
> > +{
> > +	int r1;
> > +
> > +	r1 = 1;
> > +	if (READ_ONCE(*x) == 0)
> > +		r1 = 0;
> > +	WRITE_ONCE(*y, r1);
> > +}
> 
> Hmmm.... the compiler will semi-randomly transform that to/from:
> 	if (READ_ONCE(*x) == 0)
> 		r1 = 0;
> 	else
> 		r1 = 1;
> and
> 	r1 = READ_ONCE(*x) != 0;
> 
> Both of which (probably) get correctly detected as a write to *y
> that is dependant on *x - so is 'problematic' with P1() which
> does the opposite assignment.
> 
> Which does rather imply that hurd is a bit broken.

I agree that herd7 does not match all compilers, but the intent was
always to approximate them.  There has been some research work towards
the goal of accurately modeling all possible compiler optimizations,
and it gets extremely complex, and thus computationally infeasible,
very quickly.  And we do need herd7 to stay strictly in the realm of
the computationally feasible.

Hence, any use of control dependencies should follow up with something
like klitmus7 (as Joel Fernandes did earlier in this thread) or KCSAN.
These tools have their own limitations, for example, using a specific
compiler rather than saying something about all possible compilers, but
they do reflect what a specific real toolchain actually does.  They are
also execution based, so have only some probability of finding problems.
In contrast, herd7 does the moral equivalent of a full state-space search.

It would be nice to be able to say that we have one tools that does
everything, but that might be a long way down the road.

							Thanx, Paul
