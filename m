Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6C169327E
	for <lists+linux-arch@lfdr.de>; Sat, 11 Feb 2023 17:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjBKQeI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 Feb 2023 11:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjBKQeH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Feb 2023 11:34:07 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B53CE26CC0
        for <linux-arch@vger.kernel.org>; Sat, 11 Feb 2023 08:34:04 -0800 (PST)
Received: (qmail 851986 invoked by uid 1000); 11 Feb 2023 11:34:04 -0500
Date:   Sat, 11 Feb 2023 11:34:04 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: Current LKMM patch disposition
Message-ID: <Y+fDfMaZ6ix3rxlF@rowland.harvard.edu>
References: <20230204004843.GA2677518@paulmck-ThinkPad-P17-Gen-1>
 <Y920w4QRLtC6kd+x@rowland.harvard.edu>
 <20230204014941.GS2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y95yhJgNq8lMXPdF@rowland.harvard.edu>
 <20230204222411.GC2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9+41ctA54pjm/KG@google.com>
 <Y+FJSzUoGTgReLPB@rowland.harvard.edu>
 <CAEXW_YR=J9Y9acRaZrU_F7S5Fwe7rhxwqKmxV2NOGwo0pjNBnA@mail.gmail.com>
 <Y+e5E6YkVw3C9YBk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+e5E6YkVw3C9YBk@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 11, 2023 at 03:49:39PM +0000, Joel Fernandes wrote:
> Hi Alan, all,
> 
> One thing I noticed: Shouldn't the model have some notion of fences with the
> srcu lock primitive? SRCU implementation in the kernel does an unconditional
> memory barrier on srcu_read_lock() (which it has to do for a number of
> reasons including correctness), but currently both with/without this patch,
> the following returns "Sometimes", instead of "Never". Sorry if this was
> discussed before:
> 
> C MP+srcu
> 
> (*
>  * Result: Sometimes
>  *
>  * If an srcu_read_unlock() is called between 2 stores, they should propogate
>  * in order.
>  *)
> 
> {}
> 
> P0(struct srcu_struct *s, int *x, int *y)
> {
> 	int r1;
> 
> 	r1 = srcu_read_lock(s);
> 	WRITE_ONCE(*x, 1);
> 	srcu_read_unlock(s, r1); // replace with smp_mb() makes Never.
> 	WRITE_ONCE(*y, 1);
> }
> 
> P1(struct srcu_struct *s, int *x, int *y)
> {
> 	int r1;
> 	int r2;
> 
> 	r1 = READ_ONCE(*y);
> 	smp_rmb();
> 	r2 = READ_ONCE(*x);
> }
> 
> exists (1:r1=1 /\ 1:r2=0)

As far as I know, the SRCU API does not guarantee this behavior.  The 
current implementation behaves this way, but future implementations 
might not.  Therefore we don't want to put it in the memory model.

> Also, one more general (and likely silly) question about reflexive-transitive closures.
> 
> Say you have 2 relations, R1 and R2. Except that R2 is completely empty.
> 
> What does (R1; R2)* return?

It returns the identity relation, that is, a relation which links each 
event with itself.  Remember, R* is defined as linking A to B if there 
is a series of R links, of _any_ length (including 0!), going from A to 
B.  Since there is always a series of length 0 linking A to itself, R* 
always contains the identity relation.

> I expect (R1; R2) to be empty, since there does not exist a tail in R1, that
> is a head in R2.

Correct.  But for any relation R, R* always contains the identity 
relation -- even when R is empty.  R+, on the other hand, does not.  
That's the difference between R* and R+: In R* the series of links can 
be of any length, whereas in R+ there must be at least one link.

In your example, both R2+ and (R1 ; R2)+ would be empty.

> However, that does not appear to be true like in the carry-srcu-data relation
> in Alan's patch. For instance, if I have a simple litmus test with a single
> reader on a single CPU, and an updater on a second CPU, I see that
> carry-srcu-data is a bunch of self-loops on all individual loads and stores
> on all CPUs, including the loads and stores surrounding the updater's
> synchronize_srcu() call, far from being an empty relation!

Yep, that's the identity relation.

Alan
