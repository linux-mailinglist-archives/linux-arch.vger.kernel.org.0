Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2A3286872
	for <lists+linux-arch@lfdr.de>; Wed,  7 Oct 2020 21:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgJGTkv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Oct 2020 15:40:51 -0400
Received: from netrider.rowland.org ([192.131.102.5]:43061 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728186AbgJGTkv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Oct 2020 15:40:51 -0400
Received: (qmail 470110 invoked by uid 1000); 7 Oct 2020 15:40:50 -0400
Date:   Wed, 7 Oct 2020 15:40:50 -0400
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
Message-ID: <20201007194050.GC468921@rowland.harvard.edu>
References: <20201003171338.GA323226@rowland.harvard.edu>
 <20201005151557.4bcxumreoekgwmsa@yquem.inria.fr>
 <20201005155310.GH376584@rowland.harvard.edu>
 <20201005165223.GB29330@paulmck-ThinkPad-P72>
 <20201005181949.GA387079@rowland.harvard.edu>
 <20201005191801.GF29330@paulmck-ThinkPad-P72>
 <20201005194834.GB389867@rowland.harvard.edu>
 <20201006163954.GM29330@paulmck-ThinkPad-P72>
 <20201006170525.GA423499@rowland.harvard.edu>
 <20201007175040.GQ29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007175040.GQ29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 07, 2020 at 10:50:40AM -0700, Paul E. McKenney wrote:
> And here is the updated version.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit b7cd60d4b41ad56b32b36b978488f509c4f7e228
> Author: Alan Stern <stern@rowland.harvard.edu>
> Date:   Tue Oct 6 09:38:37 2020 -0700
> 
>     manual/kernel: Add LB+mb+data litmus test

Let's change this to:

      manual/kernel: Add LB data dependency test with no intermediate variable

Without that extra qualification, people reading just the title would
wonder why we need a simple LB litmus test in the archive.

>     
>     Test whether herd7 can detect a data dependency when there is no
>     intermediate local variable, as in WRITE_ONCE(*x, READ_ONCE(*y)).
>     Commit 0f3f8188a326 in herdtools fixed an oversight which caused such
>     dependencies to be missed.
>     
>     Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/manual/kernel/C-LB+mb+data.litmus b/manual/kernel/C-LB+mb+data.litmus
> new file mode 100644
> index 0000000..0cf9a7a
> --- /dev/null
> +++ b/manual/kernel/C-LB+mb+data.litmus
> @@ -0,0 +1,27 @@
> +C LB+mb+data
> +(*
> + * Result: Never
> + *
> + * Test whether herd7 can detect a data dependency when there is no
> + * intermediate local variable, as in WRITE_ONCE(*x, READ_ONCE(*y)).
> + * Commit 0f3f8188a326 in herdtools fixed an oversight which caused such
> + * dependencies to be missed.

You changed this comment!  It should have remained the way it was:

+ * Versions of herd7 prior to commit 0f3f8188a326 ("[herd] Fix dependency
+ * definition") recognize data dependencies only when they flow through
+ * an intermediate local variable.  Since the dependency in P1 doesn't,
+ * those versions get the wrong answer for this test.

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

Alan
