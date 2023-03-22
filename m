Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D326C4DB7
	for <lists+linux-arch@lfdr.de>; Wed, 22 Mar 2023 15:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjCVObC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Mar 2023 10:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjCVObB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Mar 2023 10:31:01 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 5C8F664B10
        for <linux-arch@vger.kernel.org>; Wed, 22 Mar 2023 07:30:58 -0700 (PDT)
Received: (qmail 1103384 invoked by uid 1000); 22 Mar 2023 10:30:57 -0400
Date:   Wed, 22 Mar 2023 10:30:57 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, Joel Fernandes <joel@joelfernandes.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH memory-model 7/8] tools/memory-model: Add documentation
 about SRCU read-side critical sections
Message-ID: <4599c0d4-6c2a-431f-8bf3-173855c7ba77@rowland.harvard.edu>
References: <778147e4-ccab-40cf-b6ef-31abe4e3f6b7@paulmck-laptop>
 <20230321010246.50960-7-paulmck@kernel.org>
 <ZBpcpPIq9k2mX7cw@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBpcpPIq9k2mX7cw@andrea>
X-Spam-Status: No, score=0.2 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 22, 2023 at 02:40:52AM +0100, Andrea Parri wrote:
> On Mon, Mar 20, 2023 at 06:02:45PM -0700, Paul E. McKenney wrote:
> > From: Alan Stern <stern@rowland.harvard.edu>
> > 
> > Expand the discussion of SRCU and its read-side critical sections in
> > the Linux Kernel Memory Model documentation file explanation.txt.  The
> > new material discusses recent changes to the memory model made in
> > commit 6cd244c87428 ("tools/memory-model: Provide exact SRCU
> > semantics").
> 
> How about squashing the diff below (adjusting subject and changelog):
> 
>   Andrea
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

Excellent suggestion!

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan
