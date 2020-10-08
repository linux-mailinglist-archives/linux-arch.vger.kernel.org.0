Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D3C28758E
	for <lists+linux-arch@lfdr.de>; Thu,  8 Oct 2020 16:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbgJHOBu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Oct 2020 10:01:50 -0400
Received: from netrider.rowland.org ([192.131.102.5]:33159 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729588AbgJHOBu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Oct 2020 10:01:50 -0400
Received: (qmail 495655 invoked by uid 1000); 8 Oct 2020 10:01:48 -0400
Date:   Thu, 8 Oct 2020 10:01:48 -0400
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
Message-ID: <20201008140148.GA495091@rowland.harvard.edu>
References: <20201005181949.GA387079@rowland.harvard.edu>
 <20201005191801.GF29330@paulmck-ThinkPad-P72>
 <20201005194834.GB389867@rowland.harvard.edu>
 <20201006163954.GM29330@paulmck-ThinkPad-P72>
 <20201006170525.GA423499@rowland.harvard.edu>
 <20201007175040.GQ29330@paulmck-ThinkPad-P72>
 <20201007194050.GC468921@rowland.harvard.edu>
 <20201007223851.GV29330@paulmck-ThinkPad-P72>
 <20201008022537.GA480405@rowland.harvard.edu>
 <20201008025025.GX29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008025025.GX29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 07, 2020 at 07:50:25PM -0700, Paul E. McKenney wrote:
> There are some distractions at the moment.
> 
> Please see below.  If this is not exactly correct, I will use "git rm"
> and let you submit the patch as you wish.
> 
> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit dc0119c24b64f9d541b94ba5d17eec0cbc265bfa
> Author: Alan Stern <stern@rowland.harvard.edu>
> Date:   Tue Oct 6 09:38:37 2020 -0700
> 
>     manual/kernel: Add LB data dependency test with no intermediate variable
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
> index 0000000..e9e24e0
> --- /dev/null
> +++ b/manual/kernel/C-LB+mb+data.litmus
> @@ -0,0 +1,27 @@
> +C LB+mb+data
> +(*
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

Okay, that's exactly what it should be.  :-)

Alan
