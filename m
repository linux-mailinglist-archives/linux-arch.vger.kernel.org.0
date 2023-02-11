Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EE269339F
	for <lists+linux-arch@lfdr.de>; Sat, 11 Feb 2023 21:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjBKUT2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 Feb 2023 15:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBKUT2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Feb 2023 15:19:28 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D862F193D7
        for <linux-arch@vger.kernel.org>; Sat, 11 Feb 2023 12:19:26 -0800 (PST)
Received: (qmail 856436 invoked by uid 1000); 11 Feb 2023 15:19:25 -0500
Date:   Sat, 11 Feb 2023 15:19:25 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: Current LKMM patch disposition
Message-ID: <Y+f4TYZ9BPlt8y8B@rowland.harvard.edu>
References: <20230204004843.GA2677518@paulmck-ThinkPad-P17-Gen-1>
 <Y920w4QRLtC6kd+x@rowland.harvard.edu>
 <20230204014941.GS2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y95yhJgNq8lMXPdF@rowland.harvard.edu>
 <20230204222411.GC2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9+41ctA54pjm/KG@google.com>
 <Y+FJSzUoGTgReLPB@rowland.harvard.edu>
 <Y+fN2fvUjGDWBYrv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+fN2fvUjGDWBYrv@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 11, 2023 at 05:18:17PM +0000, Joel Fernandes wrote:
> I am happy to make changes to explanation.txt (I am assuming that's the file
> you mentioned), but I was wondering what you thought of the following change.
> If the formulas are split up, that itself could be some documentation as
> well. I did add a small paragraph on the top of the formulas as well though.
> 
> Some light testing shows it works with the cross-CPU litmus test (could still
> have bugs though and needs more testing).
> 
> Let me know how you feel about it, and if I should submit something along
> these lines along with your suggestion to edit the explanation.txt. Thanks!
> 
> diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
> index ce068700939c..1390d1b8ceee 100644
> --- a/tools/memory-model/linux-kernel.bell
> +++ b/tools/memory-model/linux-kernel.bell
> @@ -57,9 +57,28 @@ let rcu-rscs = let rec
>  flag ~empty Rcu-lock \ domain(rcu-rscs) as unmatched-rcu-lock
>  flag ~empty Rcu-unlock \ range(rcu-rscs) as unmatched-rcu-unlock
>  
> -(* Compute matching pairs of nested Srcu-lock and Srcu-unlock *)
> -let carry-srcu-data = (data ; [~ Srcu-unlock] ; rf)*
> -let srcu-rscs = ([Srcu-lock] ; carry-srcu-data ; data ; [Srcu-unlock]) & loc
> +(* SRCU read-side section modeling
> + * Compute matching pairs of nested Srcu-lock and Srcu-unlock:
> + * Each SRCU read-side critical section is treated as independent, of other
> + * overlapping SRCU read-side critical sections even when on the same domain.
> + * For this, each Srcu-lock and Srcu-unlock pair is treated as loads and
> + * stores, with the data-dependency flow also treated as independent to prevent
> + * fusing. *)

Even that is more than I would put in the source file.  Basically, the 
memory model is so complex that trying to document it in comments is 
hopeless.  The comments would have to be many times longer than the 
actual code -- as is the case here with just this little part of the 
model.  That's the main reason why I made explanation.txt a completely 
separate file.

> +
> +(* Data dependency between lock and idx store *)
> +let srcu-lock-to-store-idx = ([Srcu-lock]; data)
> +
> +(* Data dependency between idx load and unlock *)
> +let srcu-load-idx-to-unlock = (data; [Srcu-unlock])
> +
> +(* Read-from dependency between idx store on one CPU and load on same/another.
> + * This is required to model the splitting of critical section across CPUs. *)
> +let srcu-store-to-load-idx = (rf ; srcu-load-idx-to-unlock)
> +
> +(* SRCU data dependency flow. Exclude the Srcu-unlock to not transcend back to back rscs *)
> +let carry-srcu-data = (srcu-lock-to-store-idx ; [~ Srcu-unlock] ; srcu-store-to-load-idx)*
> +
> +let srcu-rscs = ([Srcu-lock] ; carry-srcu-data ; [Srcu-unlock]) & loc

That doesn't look right at all.  Does it work with the following?

P0(struct srcu_struct *lock)
{
	int r1;

	r1 = srcu_read_lock(lock);
	srcu_read_unlock(lock, r1);
}

or

P0(struct srcu_struct *lock, int *x, int *y)
{
	*x = srcu_read_lock(lock);
	*y = *x;
	srcu_read_unlock(lock, *y);
}

The idea is that the value returned by srcu_read_lock() can be stored to 
and loaded from a sequence (possibly of length 0) of variables, and the 
final load gets fed to srcu_read_unlock().  That's what the original 
version of the code expresses.

I'm not sure that breaking this relation up into pieces will make it any 
easier to understand.

Alan
