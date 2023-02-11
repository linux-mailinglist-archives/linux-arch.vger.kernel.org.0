Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4F0693218
	for <lists+linux-arch@lfdr.de>; Sat, 11 Feb 2023 16:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBKPtp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 Feb 2023 10:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBKPtn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Feb 2023 10:49:43 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EBC1025E
        for <linux-arch@vger.kernel.org>; Sat, 11 Feb 2023 07:49:41 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id h24so9214621qtr.0
        for <linux-arch@vger.kernel.org>; Sat, 11 Feb 2023 07:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5AvGFPdQ9LV/OmxK5Fq/4Lrr3Ax5+9mdfcnywPcSJcU=;
        b=ZrUqdOK8ekHcdzuGQmMbnnU5eAoV2ayWZcIMFNsopzw2CHrjweNd1qUiTFzL1jheIU
         xq79EH6GRAIJNKl6BB2oQSKTJ4oLSJKnu+ZuRUL2z2Nk7Ba5vg2IqzNZdHvh9l4aB+Cz
         qnKyG+VJa9mSSwMKumXkjPvyTPq4DKLxa6NT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AvGFPdQ9LV/OmxK5Fq/4Lrr3Ax5+9mdfcnywPcSJcU=;
        b=qbydst57tAdrA1kiksbhoLXoToOofvU3+KdwPoMloIV4x147OuVMtx1G4+45ubxRrN
         VyAbUINnhpJkPwnHUUVejaOOay6iTqhjjIXxoQA2DD478b1sdYcYpIpv2iRXeUMtyZbR
         6yMpnzoantOdRhWwZq02BdDG3sakzq3mDztcQAh2B8qBA8mO3rwED4UnJ525i756EvzS
         ncV3+b3SCmzvG+xkvQa58uQjur9zHFFGoSFilhdwzr8tnuPm4OVEMAlJAvyWbsr0wiTQ
         soeNEJFflbTJudbWSBpoVqol1xnurGnGvZXKhsX6sB6NEwsJzzr50a0NGqXW8e35T0Do
         QoMA==
X-Gm-Message-State: AO0yUKUzy55dpllnvYjuP5peK00d/+zpcey1NO4ot2t2DYKVKRsLv3OT
        NdBIgd9n5DlyyzdeJlb63CQv1A==
X-Google-Smtp-Source: AK7set8osMHbOPu1ZyGjfZ9WEl9TknDZY6xdx8UGzGqYZa5wIcuE4iBV9PuVSrqHU3FKVu9CJYLIkg==
X-Received: by 2002:a05:622a:11c2:b0:3a8:fdf:8ff8 with SMTP id n2-20020a05622a11c200b003a80fdf8ff8mr32397947qtk.36.1676130580909;
        Sat, 11 Feb 2023 07:49:40 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id c20-20020ae9ed14000000b00720ae160601sm5870218qkg.22.2023.02.11.07.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 07:49:40 -0800 (PST)
Date:   Sat, 11 Feb 2023 15:49:39 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: Current LKMM patch disposition
Message-ID: <Y+e5E6YkVw3C9YBk@google.com>
References: <20230204004843.GA2677518@paulmck-ThinkPad-P17-Gen-1>
 <Y920w4QRLtC6kd+x@rowland.harvard.edu>
 <20230204014941.GS2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y95yhJgNq8lMXPdF@rowland.harvard.edu>
 <20230204222411.GC2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9+41ctA54pjm/KG@google.com>
 <Y+FJSzUoGTgReLPB@rowland.harvard.edu>
 <CAEXW_YR=J9Y9acRaZrU_F7S5Fwe7rhxwqKmxV2NOGwo0pjNBnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YR=J9Y9acRaZrU_F7S5Fwe7rhxwqKmxV2NOGwo0pjNBnA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 06, 2023 at 04:22:57PM -0500, Joel Fernandes wrote:
> On Mon, Feb 6, 2023 at 1:39 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Sun, Feb 05, 2023 at 02:10:29PM +0000, Joel Fernandes wrote:
> > > On Sat, Feb 04, 2023 at 02:24:11PM -0800, Paul E. McKenney wrote:
> > > > On Sat, Feb 04, 2023 at 09:58:12AM -0500, Alan Stern wrote:
> > > > > On Fri, Feb 03, 2023 at 05:49:41PM -0800, Paul E. McKenney wrote:
> > > > > > On Fri, Feb 03, 2023 at 08:28:35PM -0500, Alan Stern wrote:
> > > > > > > The "Provide exact semantics for SRCU" patch should have:
> > > > > > >
> > > > > > >       Portions suggested by Boqun Feng and Jonas Oberhauser.
> > > > > > >
> > > > > > > added at the end, together with your Reported-by: tag.  With that, I
> > > > > > > think it can be queued for 6.4.
> > > > > >
> > > > > > Thank you!  Does the patch shown below work for you?
> > > > > >
> > > > > > (I have tentatively queued this, but can easily adjust or replace it.)
> > > > >
> > > > > It looks fine.
> > > >
> > > > Very good, thank you for looking it over!  I pushed it out on branch
> > > > stern.2023.02.04a.
> > > >
> > > > Would anyone like to ack/review/whatever this one?
> > >
> > > Would it be possible to add comments, something like the following? Apologies
> > > if it is missing some ideas. I will try to improve it later.
> > >
> > > thanks!
> > >
> > >  - Joel
> > >
> > > ---8<-----------------------
> > >
> > > diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
> > > index ce068700939c..0a16177339bc 100644
> > > --- a/tools/memory-model/linux-kernel.bell
> > > +++ b/tools/memory-model/linux-kernel.bell
> > > @@ -57,7 +57,23 @@ let rcu-rscs = let rec
> > >  flag ~empty Rcu-lock \ domain(rcu-rscs) as unmatched-rcu-lock
> > >  flag ~empty Rcu-unlock \ range(rcu-rscs) as unmatched-rcu-unlock
> > >
> > > +(***************************************************************)
> > >  (* Compute matching pairs of nested Srcu-lock and Srcu-unlock *)
> > > +(***************************************************************)
> > > +(*
> > > + * carry-srcu-data: To handle the case of the SRCU critical section split
> > > + * across CPUs, where the idx is used to communicate the SRCU index across CPUs
> > > + * (say CPU0 and CPU1), data is between the R[srcu-lock] to W[once][idx] on
> > > + * CPU0, which is sequenced with the ->rf is between the W[once][idx] and the
> > > + * R[once][idx] on CPU1.  The carry-srcu-data is made to exclude Srcu-unlock
> > > + * events to prevent capturing accesses across back-to-back SRCU read-side
> > > + * critical sections.
> > > + *
> > > + * srcu-rscs: Putting everything together, the carry-srcu-data is sequenced with
> > > + * a data relation, which is the data dependency between R[once][idx] on CPU1
> > > + * and the srcu-unlock store, and loc ensures the relation is unique for a
> > > + * specific lock.
> > > + *)
> > >  let carry-srcu-data = (data ; [~ Srcu-unlock] ; rf)*
> > >  let srcu-rscs = ([Srcu-lock] ; carry-srcu-data ; data ; [Srcu-unlock]) & loc
> >
> > My tendency has been to keep comments in the herd7 files to a minimum
> > and to put more extended descriptions in the explanation.txt file.
> > Right now that file contains almost nothing (a single paragraph!) about
> > SRCU, so it needs to be updated to talk about the new definition of
> > srcu-rscs.  In my opinion, that's where this sort of comment belongs.
> 
> That makes sense, I agree.
> 
> > Joel, would you like to write an extra paragraph of two for that file,
> > explaining in more detail how SRCU lock-to-unlock matching is different
> > from regular RCU and how the definition of the srcu-rscs relation works?
> > I'd be happy to edit anything you come up with.
> 
> Yes I would love to, I'll spend some more time studying this up a bit
> more so I don't write nonsense. But yes, I am quite interested in
> writing something up and I will do so!

Hi Alan, all,

One thing I noticed: Shouldn't the model have some notion of fences with the
srcu lock primitive? SRCU implementation in the kernel does an unconditional
memory barrier on srcu_read_lock() (which it has to do for a number of
reasons including correctness), but currently both with/without this patch,
the following returns "Sometimes", instead of "Never". Sorry if this was
discussed before:

C MP+srcu

(*
 * Result: Sometimes
 *
 * If an srcu_read_unlock() is called between 2 stores, they should propogate
 * in order.
 *)

{}

P0(struct srcu_struct *s, int *x, int *y)
{
	int r1;

	r1 = srcu_read_lock(s);
	WRITE_ONCE(*x, 1);
	srcu_read_unlock(s, r1); // replace with smp_mb() makes Never.
	WRITE_ONCE(*y, 1);
}

P1(struct srcu_struct *s, int *x, int *y)
{
	int r1;
	int r2;

	r1 = READ_ONCE(*y);
	smp_rmb();
	r2 = READ_ONCE(*x);
}

exists (1:r1=1 /\ 1:r2=0)

Also, one more general (and likely silly) question about reflexive-transitive closures.

Say you have 2 relations, R1 and R2. Except that R2 is completely empty.

What does (R1; R2)* return?

I expect (R1; R2) to be empty, since there does not exist a tail in R1, that
is a head in R2.

However, that does not appear to be true like in the carry-srcu-data relation
in Alan's patch. For instance, if I have a simple litmus test with a single
reader on a single CPU, and an updater on a second CPU, I see that
carry-srcu-data is a bunch of self-loops on all individual loads and stores
on all CPUs, including the loads and stores surrounding the updater's
synchronize_srcu() call, far from being an empty relation!

Thanks!

 - Joel

