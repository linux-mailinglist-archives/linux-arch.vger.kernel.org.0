Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C48C285072
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 19:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgJFRF0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Oct 2020 13:05:26 -0400
Received: from netrider.rowland.org ([192.131.102.5]:32787 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725925AbgJFRF0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Oct 2020 13:05:26 -0400
Received: (qmail 424304 invoked by uid 1000); 6 Oct 2020 13:05:25 -0400
Date:   Tue, 6 Oct 2020 13:05:25 -0400
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
Message-ID: <20201006170525.GA423499@rowland.harvard.edu>
References: <20201003132212.GB318272@rowland.harvard.edu>
 <045c643f-6a70-dfdf-2b1e-f369a667f709@gmail.com>
 <20201003171338.GA323226@rowland.harvard.edu>
 <20201005151557.4bcxumreoekgwmsa@yquem.inria.fr>
 <20201005155310.GH376584@rowland.harvard.edu>
 <20201005165223.GB29330@paulmck-ThinkPad-P72>
 <20201005181949.GA387079@rowland.harvard.edu>
 <20201005191801.GF29330@paulmck-ThinkPad-P72>
 <20201005194834.GB389867@rowland.harvard.edu>
 <20201006163954.GM29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006163954.GM29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 06, 2020 at 09:39:54AM -0700, Paul E. McKenney wrote:
> On Mon, Oct 05, 2020 at 03:48:34PM -0400, Alan Stern wrote:
> > On Mon, Oct 05, 2020 at 12:18:01PM -0700, Paul E. McKenney wrote:
> > > Aside from naming and comment, how about my adding the following?
> > > 
> > > 							Thanx, Paul
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > C crypto-control-data-1
> > 
> > Let's call it something more along the lines of 
> > dependencies-in-nested-expressions.  Maybe you can think of something a 
> > little more succinct, but that's the general idea of the test.
> > 
> > > (*
> > >  * LB plus crypto-mb-data plus data.
> > 
> > The actual pattern is LB+mb+data.
> > 
> > >  *
> > >  * Result: Never
> > >  *
> > >  * This is an example of OOTA and we would like it to be forbidden.
> > >  * If you want herd7 to get the right answer, you must use herdtools
> > >  * 0f3f8188a326 (" [herd] Fix dependency definition") or later.
> > 
> > Versions of herd7 prior to commit 0f3f8188a326 ("[herd] Fix dependency 
> > definition") recognize data dependencies only when they flow through an 
> > intermediate local variable.  Since the dependency in P1 doesn't, those
> > versions get the wrong answer for this test.
> > 
> > >  *)
> > > 
> > > {}
> > > 
> > > P0(int *x, int *y)
> > > {
> > > 	int r1;
> > > 
> > > 	r1 = READ_ONCE(*x);
> > > 	smp_mb();
> > > 	WRITE_ONCE(*y, r1);
> > > }
> > > 
> > > P1(int *x, int *y)
> > > {
> > > 	int r2;
> > 
> > No need for r2.
> 
> Thank you for looking this over!
> 
> Like this, then?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 51898676302d8ebc93856209f7c587f1ac0fdd11
> Author: Alan Stern <stern@rowland.harvard.edu>
> Date:   Tue Oct 6 09:38:37 2020 -0700
> 
>     manual/kernel: Add LB+mb+data litmus test
>     
>     Versions of herd7 prior to commit 0f3f8188a326 ("[herd] Fix dependency
>     definition") recognize data dependencies only when they flow through an
>     intermediate local variable.  Since the dependency in P1 doesn't, those
>     versions get the wrong answer for this test.

Shouldn't the commit message be different from the actual contents of 
the update?  It's supposed to explain why the update was made, not just 
say what it does.  How about this:

Test whether herd7 can detect a data dependency when there is no 
intermediate local variable, as in WRITE_ONCE(*x, READ_ONCE(*y)).  
Commit 0f3f8188a326 fixed an oversight which caused such dependencies 
to be missed.

>     Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/manual/kernel/C-LB+mb+data.litmus b/manual/kernel/C-LB+mb+data.litmus
> new file mode 100644
> index 0000000..673eec9
> --- /dev/null
> +++ b/manual/kernel/C-LB+mb+data.litmus
> @@ -0,0 +1,29 @@
> +C LB+mb+data.litmus

Do you normally put ".litmus" at the end of test names?  I leave it out, 
including it only in the filename.

> +(*
> + * LB plus crypto-mb-data plus data.

As I said earlier, the actual pattern is LB+mb+data.  There's nothing 
"crypto" about this litmus test (for example, no control dependencies).

Besides, it hardly seems worthwhile making the first comment line a 
repeat of the test name immediately above it.  Just leave it out.

> + *
> + * Result: Never
> + *
> + * Versions of herd7 prior to commit 0f3f8188a326 ("[herd] Fix dependency
> + * definition") recognize data dependencies only when they flow through
> + * an intermediate local variable.  Since the dependency in P1 doesn't,
> + * those versions get the wrong answer for this test.
> + *)
> +
> +{}
> +
> +P0(int *x, int *y)
> +{
> +	int r1;
> +
> +	r1 = READ_ONCE(*x);
> +	smp_mb();
> +	WRITE_ONCE(*y, r1);
> +}
> +
> +P1(int *x, int *y)
> +{
> +	WRITE_ONCE(*x, READ_ONCE(*y));
> +}
> +
> +exists (0:r1=1)

Otherwise okay.

Alan
