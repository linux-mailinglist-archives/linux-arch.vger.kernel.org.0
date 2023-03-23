Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4656C7071
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 19:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjCWSpc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 14:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjCWSpa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 14:45:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916851166D;
        Thu, 23 Mar 2023 11:45:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AB1362859;
        Thu, 23 Mar 2023 18:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB9BC433EF;
        Thu, 23 Mar 2023 18:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679597124;
        bh=WBplPgPjttulgaA8Xi55MWgaUgRrcw1aBmIQbNUQakg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hO0vpyI7W+wHQtVzcAKmyObsj+Fk00P30z8SnYEWhqaHiQWj7CgEDGWfHThs6C6VP
         tyBzXBO1wRbWzlBxu74Np0Qh6uz2aA3rNLaETAQRKB6FIQy5nRm/uoC4W+SAUj47+p
         SlDIKgeAjLNgjFpbTlhHTyDweTIthe0ENHElEo9JiSZlRHp+GdhRJ/njqjLukVveb+
         jAk2rKxW95dw5HySvIEXrWLJAgYwCJNGXrWfhpgliK9KLtmUaVBSbetLn3esdwq+tn
         xRV3qftHOoBYDwQHjkmMX4V4qSQ4I1MJ1i0JG+L/lPs+UvtT1olWnPw5gaoW7Bj+M+
         Ac+1ZgpN1grFA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EBF701540398; Thu, 23 Mar 2023 11:45:23 -0700 (PDT)
Date:   Thu, 23 Mar 2023 11:45:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] tools/memory-model: Remove out-of-date SRCU documentation
Message-ID: <451e1eb4-a1a3-41b3-9189-fa8aa5096eb3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230323013751.77588-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323013751.77588-1-parri.andrea@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 23, 2023 at 02:37:51AM +0100, Andrea Parri wrote:
> Commit 6cd244c87428 ("tools/memory-model: Provide exact SRCU semantics")
> changed the semantics of partially overlapping SRCU read-side critical
> sections (among other things), making such documentation out-of-date.
> The new, semantic changes are discussed in explanation.txt.  Remove the
> out-of-date documentation.
> 
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Applied, thank you all!

							Thanx, Paul

> ---
>  .../Documentation/litmus-tests.txt            | 27 +------------------
>  1 file changed, 1 insertion(+), 26 deletions(-)
> 
> diff --git a/tools/memory-model/Documentation/litmus-tests.txt b/tools/memory-model/Documentation/litmus-tests.txt
> index 26554b1c5575e..acac527328a1f 100644
> --- a/tools/memory-model/Documentation/litmus-tests.txt
> +++ b/tools/memory-model/Documentation/litmus-tests.txt
> @@ -1028,32 +1028,7 @@ Limitations of the Linux-kernel memory model (LKMM) include:
>  		additional call_rcu() process to the site of the
>  		emulated rcu-barrier().
>  
> -	e.	Although sleepable RCU (SRCU) is now modeled, there
> -		are some subtle differences between its semantics and
> -		those in the Linux kernel.  For example, the kernel
> -		might interpret the following sequence as two partially
> -		overlapping SRCU read-side critical sections:
> -
> -			 1  r1 = srcu_read_lock(&my_srcu);
> -			 2  do_something_1();
> -			 3  r2 = srcu_read_lock(&my_srcu);
> -			 4  do_something_2();
> -			 5  srcu_read_unlock(&my_srcu, r1);
> -			 6  do_something_3();
> -			 7  srcu_read_unlock(&my_srcu, r2);
> -
> -		In contrast, LKMM will interpret this as a nested pair of
> -		SRCU read-side critical sections, with the outer critical
> -		section spanning lines 1-7 and the inner critical section
> -		spanning lines 3-5.
> -
> -		This difference would be more of a concern had anyone
> -		identified a reasonable use case for partially overlapping
> -		SRCU read-side critical sections.  For more information
> -		on the trickiness of such overlapping, please see:
> -		https://paulmck.livejournal.com/40593.html
> -
> -	f.	Reader-writer locking is not modeled.  It can be
> +	e.	Reader-writer locking is not modeled.  It can be
>  		emulated in litmus tests using atomic read-modify-write
>  		operations.
>  
> -- 
> 2.34.1
> 
