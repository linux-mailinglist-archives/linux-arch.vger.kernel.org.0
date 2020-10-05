Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E85283726
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 16:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgJEOBC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Oct 2020 10:01:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgJEOBB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 5 Oct 2020 10:01:01 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C60F62078A;
        Mon,  5 Oct 2020 14:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601906460;
        bh=303IAqAZmgMLDeLA/dlFNB4ExGOrJkoQVk+/b9+BXBw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=o6it/NWSTo6z4wb4/mP8gM3PFyWHnaAkGLX8cOA4hvH2FoPaPKv7bgPBI6SFvQvsy
         CdDYrK9ywd6p9moEsGfWaIEQ9BP/Z3gJPjFxobKt6mLLzUku49vkCS7xOz/Lje1My9
         jhM+EMECLOtxy0zXC/L9EMlqWIVhPEuUD2k3sQYM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8AB5F352301E; Mon,  5 Oct 2020 07:01:00 -0700 (PDT)
Date:   Mon, 5 Oct 2020 07:01:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: Litmus test for question from Al Viro
Message-ID: <20201005140100.GV29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <20201001213048.GF29330@paulmck-ThinkPad-P72>
 <20201003132212.GB318272@rowland.harvard.edu>
 <20201004233146.GP29330@paulmck-ThinkPad-P72>
 <20201005023846.GA359428@rowland.harvard.edu>
 <20201005082002.GA23216@willie-the-truck>
 <20201005091247.GA23575@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005091247.GA23575@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 05, 2020 at 10:12:48AM +0100, Will Deacon wrote:
> On Mon, Oct 05, 2020 at 09:20:03AM +0100, Will Deacon wrote:
> > On Sun, Oct 04, 2020 at 10:38:46PM -0400, Alan Stern wrote:
> > > On Sun, Oct 04, 2020 at 04:31:46PM -0700, Paul E. McKenney wrote:
> > > > Nice simple example!  How about like this?
> > > > 
> > > > 							Thanx, Paul
> > > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > commit c964f404eabe4d8ce294e59dda713d8c19d340cf
> > > > Author: Alan Stern <stern@rowland.harvard.edu>
> > > > Date:   Sun Oct 4 16:27:03 2020 -0700
> > > > 
> > > >     manual/kernel: Add a litmus test with a hidden dependency
> > > >     
> > > >     This commit adds a litmus test that has a data dependency that can be
> > > >     hidden by control flow.  In this test, both the taken and the not-taken
> > > >     branches of an "if" statement must be accounted for in order to properly
> > > >     analyze the litmus test.  But herd7 looks only at individual executions
> > > >     in isolation, so fails to see the dependency.
> > > >     
> > > >     Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > 
> > > > diff --git a/manual/kernel/crypto-control-data.litmus b/manual/kernel/crypto-control-data.litmus
> > > > new file mode 100644
> > > > index 0000000..6baecf9
> > > > --- /dev/null
> > > > +++ b/manual/kernel/crypto-control-data.litmus
> > > > @@ -0,0 +1,31 @@
> > > > +C crypto-control-data
> > > > +(*
> > > > + * LB plus crypto-control-data plus data
> > > > + *
> > > > + * Result: Sometimes
> > > > + *
> > > > + * This is an example of OOTA and we would like it to be forbidden.
> > > > + * The WRITE_ONCE in P0 is both data-dependent and (at the hardware level)
> > > > + * control-dependent on the preceding READ_ONCE.  But the dependencies are
> > > > + * hidden by the form of the conditional control construct, hence the 
> > > > + * name "crypto-control-data".  The memory model doesn't recognize them.
> > > > + *)
> > > > +
> > > > +{}
> > > > +
> > > > +P0(int *x, int *y)
> > > > +{
> > > > +	int r1;
> > > > +
> > > > +	r1 = 1;
> > > > +	if (READ_ONCE(*x) == 0)
> > > > +		r1 = 0;
> > > > +	WRITE_ONCE(*y, r1);
> > > > +}
> > > > +
> > > > +P1(int *x, int *y)
> > > > +{
> > > > +	WRITE_ONCE(*x, READ_ONCE(*y));
> > > > +}
> > > > +
> > > > +exists (0:r1=1)
> > > 
> > > Considering the bug in herd7 pointed out by Akira, we should rewrite P1 as:
> > > 
> > > P1(int *x, int *y)
> > > {
> > > 	int r2;
> > > 
> > > 	r = READ_ONCE(*y);
> > 
> > (r2?)
> > 
> > > 	WRITE_ONCE(*x, r2);
> > > }
> > > 
> > > Other than that, this is fine.
> > 
> > But yes, module the typo, I agree that this rewrite is much better than the
> > proposal above. The definition of control dependencies on arm64 (per the Arm
> > ARM [1]) isn't entirely clear that it provides order if the WRITE is
> > executed on both paths of the branch, and I believe there are ongoing
> > efforts to try to tighten that up. I'd rather keep _that_ topic separate
> > from the "bug in herd" topic to avoid extra confusion.
> 
> Ah, now I see that you're changing P1 here, not P0. So I'm now nervous
> about claiming that this is a bug in herd without input from Jade or Luc,
> as it does unfortunately tie into the definition of control dependencies
> and it could be a deliberate choice.
> 
> Jade, Luc: apparently herd doesn't emit a control dependency edge from
> the READ_ONCE() to the WRITE_ONCE() in the following:
> 
> 
>   P0(int *x, int *y)
>   {
> 	int r1;
> 
> 	r1 = 1;
> 	if (READ_ONCE(*x) == 0)
> 		r1 = 0;
> 	WRITE_ONCE(*y, r1);
>   }
> 
> 
> Is that deliberate?
> 
> Setting the arm64 architecture aside for one moment, I think the Linux
> memory model would very much like the control dependency to exist in this
> case. Documenting the unexpected outcome is one thing, but I think it would
> be much better to do it in a way where users can reason about whether or not
> they're falling into this trap rather than warning them that the results may
> be unreliable, which is not likely to build confidence in the tool.

It was in fact a deliberate choice.  Exact modeling of what compilers can
and cannot do gets extremely computationally intensive very quickly given
the current state of the art.

							Thanx, Paul
