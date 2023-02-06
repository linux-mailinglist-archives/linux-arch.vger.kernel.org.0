Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DD568C5EF
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 19:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBFSjK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 13:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjBFSjJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 13:39:09 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 57123420E
        for <linux-arch@vger.kernel.org>; Mon,  6 Feb 2023 10:39:08 -0800 (PST)
Received: (qmail 665605 invoked by uid 1000); 6 Feb 2023 13:39:07 -0500
Date:   Mon, 6 Feb 2023 13:39:07 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: Current LKMM patch disposition
Message-ID: <Y+FJSzUoGTgReLPB@rowland.harvard.edu>
References: <20230204004843.GA2677518@paulmck-ThinkPad-P17-Gen-1>
 <Y920w4QRLtC6kd+x@rowland.harvard.edu>
 <20230204014941.GS2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y95yhJgNq8lMXPdF@rowland.harvard.edu>
 <20230204222411.GC2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9+41ctA54pjm/KG@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9+41ctA54pjm/KG@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Feb 05, 2023 at 02:10:29PM +0000, Joel Fernandes wrote:
> On Sat, Feb 04, 2023 at 02:24:11PM -0800, Paul E. McKenney wrote:
> > On Sat, Feb 04, 2023 at 09:58:12AM -0500, Alan Stern wrote:
> > > On Fri, Feb 03, 2023 at 05:49:41PM -0800, Paul E. McKenney wrote:
> > > > On Fri, Feb 03, 2023 at 08:28:35PM -0500, Alan Stern wrote:
> > > > > The "Provide exact semantics for SRCU" patch should have:
> > > > > 
> > > > > 	Portions suggested by Boqun Feng and Jonas Oberhauser.
> > > > > 
> > > > > added at the end, together with your Reported-by: tag.  With that, I 
> > > > > think it can be queued for 6.4.
> > > > 
> > > > Thank you!  Does the patch shown below work for you?
> > > > 
> > > > (I have tentatively queued this, but can easily adjust or replace it.)
> > > 
> > > It looks fine.
> > 
> > Very good, thank you for looking it over!  I pushed it out on branch
> > stern.2023.02.04a.
> > 
> > Would anyone like to ack/review/whatever this one?
> 
> Would it be possible to add comments, something like the following? Apologies
> if it is missing some ideas. I will try to improve it later.
> 
> thanks!
> 
>  - Joel
> 
> ---8<-----------------------
> 
> diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
> index ce068700939c..0a16177339bc 100644
> --- a/tools/memory-model/linux-kernel.bell
> +++ b/tools/memory-model/linux-kernel.bell
> @@ -57,7 +57,23 @@ let rcu-rscs = let rec
>  flag ~empty Rcu-lock \ domain(rcu-rscs) as unmatched-rcu-lock
>  flag ~empty Rcu-unlock \ range(rcu-rscs) as unmatched-rcu-unlock
>  
> +(***************************************************************)
>  (* Compute matching pairs of nested Srcu-lock and Srcu-unlock *)
> +(***************************************************************)
> +(*
> + * carry-srcu-data: To handle the case of the SRCU critical section split
> + * across CPUs, where the idx is used to communicate the SRCU index across CPUs
> + * (say CPU0 and CPU1), data is between the R[srcu-lock] to W[once][idx] on
> + * CPU0, which is sequenced with the ->rf is between the W[once][idx] and the
> + * R[once][idx] on CPU1.  The carry-srcu-data is made to exclude Srcu-unlock
> + * events to prevent capturing accesses across back-to-back SRCU read-side
> + * critical sections.
> + *
> + * srcu-rscs: Putting everything together, the carry-srcu-data is sequenced with
> + * a data relation, which is the data dependency between R[once][idx] on CPU1
> + * and the srcu-unlock store, and loc ensures the relation is unique for a
> + * specific lock.
> + *)
>  let carry-srcu-data = (data ; [~ Srcu-unlock] ; rf)*
>  let srcu-rscs = ([Srcu-lock] ; carry-srcu-data ; data ; [Srcu-unlock]) & loc

My tendency has been to keep comments in the herd7 files to a minimum 
and to put more extended descriptions in the explanation.txt file.  
Right now that file contains almost nothing (a single paragraph!) about 
SRCU, so it needs to be updated to talk about the new definition of 
srcu-rscs.  In my opinion, that's where this sort of comment belongs.

Joel, would you like to write an extra paragraph of two for that file, 
explaining in more detail how SRCU lock-to-unlock matching is different 
from regular RCU and how the definition of the srcu-rscs relation works?  
I'd be happy to edit anything you come up with.

Alan

PS: We also need to update the PLAIN ACCESSES AND DATA RACES section of 
explanation.txt, to mention the carry-dep relation and why it is 
important.
