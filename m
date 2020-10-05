Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFAE2837A3
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 16:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgJEOY4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Oct 2020 10:24:56 -0400
Received: from netrider.rowland.org ([192.131.102.5]:48307 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725954AbgJEOYz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Oct 2020 10:24:55 -0400
Received: (qmail 377866 invoked by uid 1000); 5 Oct 2020 10:24:54 -0400
Date:   Mon, 5 Oct 2020 10:24:54 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: Litmus test for question from Al Viro
Message-ID: <20201005142454.GC376584@rowland.harvard.edu>
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <20201001213048.GF29330@paulmck-ThinkPad-P72>
 <20201003132212.GB318272@rowland.harvard.edu>
 <20201004233146.GP29330@paulmck-ThinkPad-P72>
 <20201005023846.GA359428@rowland.harvard.edu>
 <20201005140353.GW29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005140353.GW29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 05, 2020 at 07:03:53AM -0700, Paul E. McKenney wrote:
> Updated as suggested by Will, like this?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit adf43667b702582331d68acdf3732a6a017a182c
> Author: Alan Stern <stern@rowland.harvard.edu>
> Date:   Sun Oct 4 16:27:03 2020 -0700
> 
>     manual/kernel: Add a litmus test with a hidden dependency
>     
>     This commit adds a litmus test that has a data dependency that can be
>     hidden by control flow.  In this test, both the taken and the not-taken
>     branches of an "if" statement must be accounted for in order to properly
>     analyze the litmus test.  But herd7 looks only at individual executions
>     in isolation, so fails to see the dependency.
>     
>     Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/manual/kernel/crypto-control-data.litmus b/manual/kernel/crypto-control-data.litmus
> new file mode 100644
> index 0000000..cdcdec9
> --- /dev/null
> +++ b/manual/kernel/crypto-control-data.litmus
> @@ -0,0 +1,34 @@
> +C crypto-control-data
> +(*
> + * LB plus crypto-control-data plus data
> + *
> + * Result: Sometimes
> + *
> + * This is an example of OOTA and we would like it to be forbidden.
> + * The WRITE_ONCE in P0 is both data-dependent and (at the hardware level)
> + * control-dependent on the preceding READ_ONCE.  But the dependencies are
> + * hidden by the form of the conditional control construct, hence the 
> + * name "crypto-control-data".  The memory model doesn't recognize them.
> + *)
> +
> +{}
> +
> +P0(int *x, int *y)
> +{
> +	int r1;
> +
> +	r1 = 1;
> +	if (READ_ONCE(*x) == 0)
> +		r1 = 0;
> +	WRITE_ONCE(*y, r1);
> +}
> +
> +P1(int *x, int *y)
> +{
> +	int r2;
> +
> +	r2 = READ_ONCE(*y);
> +	WRITE_ONCE(*x, r2);
> +}
> +
> +exists (0:r1=1)

Perfect!

Alan
