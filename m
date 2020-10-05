Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2022831C5
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 10:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgJEIUK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Oct 2020 04:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgJEIUJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 5 Oct 2020 04:20:09 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D7142075A;
        Mon,  5 Oct 2020 08:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601886009;
        bh=a6m4Vgw8XbmSh9LXZ+VfNeL4cVShtjQyaGRZrfHilhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1u9JuD93Gti/Wj9WmMCkK1I5DynXywWoeymlZnmS3QtvSYAOHKp77ZAR+Lvx1TEqI
         CFA+5p2rl3Mo5KfjljtwtcnEnFHYFndesdQK8ElTumaeDnHL7noZFb0Qy1AsH3qohB
         UNciyCmUIkp4yzcFA2p0/pX2YGkzrg7niKNvGeVE=
Date:   Mon, 5 Oct 2020 09:20:03 +0100
From:   Will Deacon <will@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, parri.andrea@gmail.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: Litmus test for question from Al Viro
Message-ID: <20201005082002.GA23216@willie-the-truck>
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <20201001213048.GF29330@paulmck-ThinkPad-P72>
 <20201003132212.GB318272@rowland.harvard.edu>
 <20201004233146.GP29330@paulmck-ThinkPad-P72>
 <20201005023846.GA359428@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005023846.GA359428@rowland.harvard.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Oct 04, 2020 at 10:38:46PM -0400, Alan Stern wrote:
> On Sun, Oct 04, 2020 at 04:31:46PM -0700, Paul E. McKenney wrote:
> > Nice simple example!  How about like this?
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit c964f404eabe4d8ce294e59dda713d8c19d340cf
> > Author: Alan Stern <stern@rowland.harvard.edu>
> > Date:   Sun Oct 4 16:27:03 2020 -0700
> > 
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
> > +
> > +P1(int *x, int *y)
> > +{
> > +	WRITE_ONCE(*x, READ_ONCE(*y));
> > +}
> > +
> > +exists (0:r1=1)
> 
> Considering the bug in herd7 pointed out by Akira, we should rewrite P1 as:
> 
> P1(int *x, int *y)
> {
> 	int r2;
> 
> 	r = READ_ONCE(*y);

(r2?)

> 	WRITE_ONCE(*x, r2);
> }
> 
> Other than that, this is fine.

But yes, module the typo, I agree that this rewrite is much better than the
proposal above. The definition of control dependencies on arm64 (per the Arm
ARM [1]) isn't entirely clear that it provides order if the WRITE is
executed on both paths of the branch, and I believe there are ongoing
efforts to try to tighten that up. I'd rather keep _that_ topic separate
from the "bug in herd" topic to avoid extra confusion.

Will

[1] https://developer.arm.com/documentation/ddi0487/fc/
