Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419EB6C5334
	for <lists+linux-arch@lfdr.de>; Wed, 22 Mar 2023 19:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCVSCc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Mar 2023 14:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjCVSCY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Mar 2023 14:02:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C3352901;
        Wed, 22 Mar 2023 11:02:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFA926223D;
        Wed, 22 Mar 2023 18:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314A2C433D2;
        Wed, 22 Mar 2023 18:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679508138;
        bh=oqee66un2xpmNmFuh7yyKaMc9gl0yG6mf5pxk2ZHWcc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Lgd/iFBuBjAcnL7lspVaca1JjWKDtXELYoW+hA4KDISRmFgak5RB6DRtwfe4S1rn7
         U73sVxu9SWiPAbnBTOUe/aK7BD9jGUIKiIi/pyz1zXBcYucJSbV0Pfjm3ahBHllsPK
         cwIWqtZXI5C+g4+HEpy+2eOwkyuEsHyB6BzxkIuAzQBWCpnicNCC3F7C6ZSPxtzauy
         3ZtU26PeM4qgNKqQLR/B8Cae0s20R2vlDhIfLKOF6so8/+i9KJiStB6vZ4kvo4pE55
         JNi3VCeFnvg/+DeXUrjKLMAwMpstZHX2rcl0E9h8EaJYS7ucue2UZXdVYHWiKTaddB
         MpuV+aWiwUL0g==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BC6F9154033A; Wed, 22 Mar 2023 11:02:17 -0700 (PDT)
Date:   Wed, 22 Mar 2023 11:02:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>
Subject: Re: [PATCH memory-model 7/8] tools/memory-model: Add documentation
 about SRCU read-side critical sections
Message-ID: <ee922523-cc65-4254-b735-9e471c0e1c20@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <778147e4-ccab-40cf-b6ef-31abe4e3f6b7@paulmck-laptop>
 <20230321010246.50960-7-paulmck@kernel.org>
 <ZBpcpPIq9k2mX7cw@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBpcpPIq9k2mX7cw@andrea>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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

Looks good to me, thank you!

Please submit an official patch with Joel's and Alan's tags and I
will be happy to pull it in.

							Thanx, Paul

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
>  
> 
>   Andrea
