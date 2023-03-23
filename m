Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853136C7090
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 19:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjCWSwT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 14:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCWSwS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 14:52:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667E02BF20;
        Thu, 23 Mar 2023 11:52:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0237362867;
        Thu, 23 Mar 2023 18:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57668C433D2;
        Thu, 23 Mar 2023 18:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679597536;
        bh=kHhwEDR7GyCCWeGJmfO6nzeFK+DQvkES4FtrdYFa5F4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mnyQKRVtUScSkPEmJXdCYVyydQ7T1178UV/lxX9f/gTQsUNzaRpV/Da91RFD1RRCL
         lL+tZwSjUsJ9tBbl1Prmxe4Q8jRQTE/I2vyH1ygEbXSO9CH8ola0jwtKuK9wfvwuqL
         V3OTz9+xSuJ+cNKfPQTWPaMTpRgwGBpRYaCzQu4jtH8uRClr0R39DsthUYFoSa2t9Z
         ZvZZ7GIMJkGdX4rfTLBl0FVI7laVE2BVL/4Ky+v3JTg8FD3J0sLWYmUFyDEPvMKUEG
         TwUH0SRBrx8s8b2ZQCVlCYRQV3ONktFOQoRrP5Cwnr9FzMsXwKD4uiWI/q9pId3Mvz
         a8du9d3Vo/GQw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DFF021540398; Thu, 23 Mar 2023 11:52:15 -0700 (PDT)
Date:   Thu, 23 Mar 2023 11:52:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     parri.andrea@gmail.com, stern@rowland.harvard.edu, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Subject: Re: [PATCH memory-model scripts 01/31] tools/memory-model: Document
 locking corner cases
Message-ID: <cd356db2-1643-4b01-bb13-16a7f92cf980@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <4e5839bb-e980-4931-a550-3548d025a32a@paulmck-laptop>
 <20230321010549.51296-1-paulmck@kernel.org>
 <f940cb6c-4aa6-41a4-d9d7-330becd5427a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f940cb6c-4aa6-41a4-d9d7-330becd5427a@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 23, 2023 at 11:52:57AM +0900, Akira Yokosawa wrote:
> Hi Paul,
> 
> On Mon, 20 Mar 2023 18:05:19 -0700, Paul E. McKenney wrote:
> > Most Linux-kernel uses of locking are straightforward, but there are
> > corner-case uses that rely on less well-known aspects of the lock and
> > unlock primitives.  This commit therefore adds a locking.txt and litmus
> > tests in Documentation/litmus-tests/locking to explain these corner-case
> > uses.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  .../litmus-tests/locking/DCL-broken.litmus    |  55 +++
> >  .../litmus-tests/locking/DCL-fixed.litmus     |  56 +++
> >  .../litmus-tests/locking/RM-broken.litmus     |  42 +++
> >  .../litmus-tests/locking/RM-fixed.litmus      |  42 +++
> >  tools/memory-model/Documentation/locking.txt  | 320 ++++++++++++++++++
> 
> I think the documentation needs adjustment to cope with Andrea's change
> of litmus tests.
> 
> Also, coding style of code snippets taken from litmus tests look somewhat
> inconsistent with other snippets taken from MP+... litmus tests:
> 
>   - Simple function signature such as "void CPU0(void)".
>   - No declaration of local variables.
>   - Indirection level of global variables.
>   - No "locations" clause
> 
> How about applying the diff below?

Good eyes, thank you!  I will fold this in with attribution.

							Thanx, Paul

>         Thanks, Akira
> 
> -----
> diff --git a/tools/memory-model/Documentation/locking.txt b/tools/memory-model/Documentation/locking.txt
> index 4e05c6d53ab7..65c898c64a93 100644
> --- a/tools/memory-model/Documentation/locking.txt
> +++ b/tools/memory-model/Documentation/locking.txt
> @@ -91,25 +91,21 @@ double-checked locking work correctly,  This litmus test illustrates
>  one incorrect approach:
>  
>  	/* See Documentation/litmus-tests/locking/DCL-broken.litmus. */
> -	P0(int *flag, int *data, int *lck)
> +	void CPU0(void)
>  	{
> -		int r0;
> -		int r1;
> -		int r2;
> -
> -		r0 = READ_ONCE(*flag);
> +		r0 = READ_ONCE(flag);
>  		if (r0 == 0) {
> -			spin_lock(lck);
> -			r1 = READ_ONCE(*flag);
> +			spin_lock(&lck);
> +			r1 = READ_ONCE(flag);
>  			if (r1 == 0) {
> -				WRITE_ONCE(*data, 1);
> -				WRITE_ONCE(*flag, 1);
> +				WRITE_ONCE(data, 1);
> +				WRITE_ONCE(flag, 1);
>  			}
> -			spin_unlock(lck);
> +			spin_unlock(&lck);
>  		}
> -		r2 = READ_ONCE(*data);
> +		r2 = READ_ONCE(data);
>  	}
> -	/* P1() is the exactly the same as P0(). */
> +	/* CPU1() is the exactly the same as CPU0(). */
>  
>  There are two problems.  First, there is no ordering between the first
>  READ_ONCE() of "flag" and the READ_ONCE() of "data".  Second, there is
> @@ -120,25 +116,21 @@ One way to fix this is to use smp_load_acquire() and smp_store_release()
>  as shown in this corrected version:
>  
>  	/* See Documentation/litmus-tests/locking/DCL-fixed.litmus. */
> -	P0(int *flag, int *data, int *lck)
> +	void CPU0(void)
>  	{
> -		int r0;
> -		int r1;
> -		int r2;
> -
> -		r0 = smp_load_acquire(flag);
> +		r0 = smp_load_acquire(&flag);
>  		if (r0 == 0) {
> -			spin_lock(lck);
> -			r1 = READ_ONCE(*flag);
> +			spin_lock(&lck);
> +			r1 = READ_ONCE(flag);
>  			if (r1 == 0) {
> -				WRITE_ONCE(*data, 1);
> -				smp_store_release(flag, 1);
> +				WRITE_ONCE(data, 1);
> +				smp_store_release(&flag, 1);
>  			}
> -			spin_unlock(lck);
> +			spin_unlock(&lck);
>  		}
> -		r2 = READ_ONCE(*data);
> +		r2 = READ_ONCE(data);
>  	}
> -	/* P1() is the exactly the same as P0(). */
> +	/* CPU1() is the exactly the same as CPU0(). */
>  
>  The smp_load_acquire() guarantees that its load from "flags" will
>  be ordered before the READ_ONCE() from data, thus solving the first
> @@ -238,81 +230,67 @@ loads, with a "filter" clause to constrain the first to return the
>  initial value and the second to return the updated value, as shown below:
>  
>  	/* See Documentation/litmus-tests/locking/RM-fixed.litmus. */
> -	P0(int *x, int *y, int *lck)
> +	void CPU0(void)
>  	{
> -		int r2;
> -
> -		spin_lock(lck);
> -		r2 = atomic_inc_return(y);
> -		WRITE_ONCE(*x, 1);
> -		spin_unlock(lck);
> +		spin_lock(&lck);
> +		r2 = atomic_inc_return(&y);
> +		WRITE_ONCE(x, 1);
> +		spin_unlock(&lck);
>  	}
>  
> -	P1(int *x, int *y, int *lck)
> +	void CPU1(void)
>  	{
> -		int r0;
> -		int r1;
> -		int r2;
> -
> -		r0 = READ_ONCE(*x);
> -		r1 = READ_ONCE(*x);
> -		spin_lock(lck);
> -		r2 = atomic_inc_return(y);
> -		spin_unlock(lck);
> +		r0 = READ_ONCE(x);
> +		r1 = READ_ONCE(x);
> +		spin_lock(&lck);
> +		r2 = atomic_inc_return(&y);
> +		spin_unlock(&lck);
>  	}
>  
> -	filter (y=2 /\ 1:r0=0 /\ 1:r1=1)
> +	filter (1:r0=0 /\ 1:r1=1)
>  	exists (1:r2=1)
>  
>  The variable "x" is the control variable for the emulated spin loop.
> -P0() sets it to "1" while holding the lock, and P1() emulates the
> +CPU0() sets it to "1" while holding the lock, and CPU1() emulates the
>  spin loop by reading it twice, first into "1:r0" (which should get the
>  initial value "0") and then into "1:r1" (which should get the updated
>  value "1").
>  
> -The purpose of the variable "y" is to reject deadlocked executions.
> -Only those executions where the final value of "y" have avoided deadlock.
> +The "filter" clause takes this into account, constraining "1:r0" to
> +equal "0" and "1:r1" to equal 1.
>  
> -The "filter" clause takes all this into account, constraining "y" to
> -equal "2", "1:r0" to equal "0", and "1:r1" to equal 1.
> -
> -Then the "exists" clause checks to see if P1() acquired its lock first,
> -which should not happen given the filter clause because P0() updates
> +Then the "exists" clause checks to see if CPU1() acquired its lock first,
> +which should not happen given the filter clause because CPU0() updates
>  "x" while holding the lock.  And herd7 confirms this.
>  
>  But suppose that the compiler was permitted to reorder the spin loop
> -into P1()'s critical section, like this:
> +into CPU1()'s critical section, like this:
>  
>  	/* See Documentation/litmus-tests/locking/RM-broken.litmus. */
> -	P0(int *x, int *y, int *lck)
> +	void CPU0(void)
>  	{
>  		int r2;
>  
> -		spin_lock(lck);
> -		r2 = atomic_inc_return(y);
> -		WRITE_ONCE(*x, 1);
> -		spin_unlock(lck);
> +		spin_lock(&lck);
> +		r2 = atomic_inc_return(&y);
> +		WRITE_ONCE(x, 1);
> +		spin_unlock(&lck);
>  	}
>  
> -	P1(int *x, int *y, int *lck)
> +	void CPU1(void)
>  	{
> -		int r0;
> -		int r1;
> -		int r2;
> -
> -		spin_lock(lck);
> -		r0 = READ_ONCE(*x);
> -		r1 = READ_ONCE(*x);
> -		r2 = atomic_inc_return(y);
> -		spin_unlock(lck);
> +		spin_lock(&lck);
> +		r0 = READ_ONCE(x);
> +		r1 = READ_ONCE(x);
> +		r2 = atomic_inc_return(&y);
> +		spin_unlock(&lck);
>  	}
>  
> -	locations [x;lck;0:r2;1:r0;1:r1;1:r2]
> -	filter (y=2 /\ 1:r0=0 /\ 1:r1=1)
> +	filter (1:r0=0 /\ 1:r1=1)
>  	exists (1:r2=1)
>  
> -If "1:r0" is equal to "0", "1:r1" can never equal "1" because P0()
> -cannot update "x" while P1() holds the lock.  And herd7 confirms this,
> +If "1:r0" is equal to "0", "1:r1" can never equal "1" because CPU0()
> +cannot update "x" while CPU1() holds the lock.  And herd7 confirms this,
>  showing zero executions matching the "filter" criteria.
>  
>  And this is why Linux-kernel lock and unlock primitives must prevent
> 
> 
> 
