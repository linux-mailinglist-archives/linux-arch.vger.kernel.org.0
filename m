Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0021369BB99
	for <lists+linux-arch@lfdr.de>; Sat, 18 Feb 2023 20:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjBRTVa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Feb 2023 14:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBRTVa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Feb 2023 14:21:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E298C1557F;
        Sat, 18 Feb 2023 11:21:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95E82B80860;
        Sat, 18 Feb 2023 19:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8D9C433D2;
        Sat, 18 Feb 2023 19:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676748086;
        bh=ERRPUkuGs6ei/8zsYh5mEgzu5rkdv0mpyjaQrJ0AMOg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mror2wFvyMD2N3YigBLNVVHAfx1IyQ4AYJD/NIo9/jBRow+wLe92vyOvSr9JQiHKX
         +Gilf17WaafLm/g3Tz41Uuts2fUekVGMrZLWvlZQNuICD0Sutt4MimqDsXiGDe38r8
         WtFYaQYeJIZM1rIp2PyCNVJyRVz2EcM571P+QP4p/Skg7bbNuNrz998ex5dhg5Q7e5
         N5XYEhaMpVs1mWHAhmNrKjdmncSgTk/eqIgP8l0ZiJyp/EB+MpEEki6Nmf7TMd7dT6
         YND2qfA9q5OOetFy9FHSvuxoOxx7ie9JkKxpnGAZTRPf7e4nFGx0YMSaxgFeZH3CAS
         zGaye6ZL6n80g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B139C5C0ACF; Sat, 18 Feb 2023 11:21:23 -0800 (PST)
Date:   Sat, 18 Feb 2023 11:21:23 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: Current LKMM patch disposition
Message-ID: <20230218192123.GC2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230204014941.GS2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y95yhJgNq8lMXPdF@rowland.harvard.edu>
 <20230204222411.GC2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9+41ctA54pjm/KG@google.com>
 <Y+FJSzUoGTgReLPB@rowland.harvard.edu>
 <Y+fN2fvUjGDWBYrv@google.com>
 <Y+f4TYZ9BPlt8y8B@rowland.harvard.edu>
 <CAEXW_YRuTfjc=5OAskTV0Qt_zSJTPP3-01=Y=SypMdPsF_weAQ@mail.gmail.com>
 <Y+hWAksfk4C0M2gB@rowland.harvard.edu>
 <CAEXW_YQ3fvFDNi9wG5w4Zqkbda8SUByOnM6y6MXQpxT9oQw8xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQ3fvFDNi9wG5w4Zqkbda8SUByOnM6y6MXQpxT9oQw8xQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 18, 2023 at 01:13:59AM -0500, Joel Fernandes wrote:
> Hi Alan,
> 
> On Sat, Feb 11, 2023 at 9:59 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> [...]
> >
> > Would you like to post a few examples showing some of the most difficult
> > points you encountered?  Maybe explanation.txt can be improved.
> 
> One additional feedback I wanted to mention, regarding this paragraph
> under "WARNING":
> ===========
> The protections provided by READ_ONCE(), WRITE_ONCE(), and others are
> not perfect; and under some circumstances it is possible for the
> compiler to undermine the memory model. Here is an example. Suppose
> both branches of an "if" statement store the same value to the same
> location:
> r1 = READ_ONCE(x);
> if (r1) {
> WRITE_ONCE(y, 2);
> ... /* do something */
> } else {
> WRITE_ONCE(y, 2);
> ... /* do something else */
> }
> ===========
> 
> I tried lots of different compilers with varying degrees of
> optimization, in all cases I find that the conditional instruction
> always appears in program order before the stores inside the body of
> the conditional. So I am not sure if this is really a valid concern on
> current compilers, if not - could you provide an example of a compiler
> and options that cause it?
> 
> In any case, if it is a theoretical concern, it could be clarified
> that this is a theoretical possibility in the text.  And if it is a
> real/practical concern, then it could be mentioned the specific
> compiler/arch this was seen in.

I could be misremembering, but I believe that this reordering has been
seen in the past.

							Thanx, Paul

> Thanks!
> 
>  - Joel
> 
> 
> 
> >
> > > > I'm not sure that breaking this relation up into pieces will make it any
> > > > easier to understand.
> > >
> > > Yes, but I tried. I will keep trying to understand your last patch
> > > more. Especially I am still not sure, why in the case of an SRCU
> > > reader on a single CPU, the following does not work:
> > > let srcu-rscs = ([Srcu-lock]; data; [Srcu-unlock]).
> >
> > You have to understand that herd7 does not track dependencies through
> > stores and subsequent loads.  That is, if you have something like:
> >
> >         r1 = READ_ONCE(*x);
> >         WRITE_ONCE(*y, r1);
> >         r2 = READ_ONCE(*y);
> >         WRITE_ONCE(*z, r2);
> >
> > then herd7 will realize that the write to y depends on the value read
> > from x, and it will realize that the write to z depends on the value
> > read from y.  But it will not realize that the write to z depends on the
> > value read from x; it loses track of that dependency because of the
> > intervening store/load from y.
> >
> > More to the point, if you have:
> >
> >         r1 = srcu_read_lock(lock);
> >         WRITE_ONCE(*y, r1);
> >         r2 = READ_ONCE(*y);
> >         srcu_read_unlock(lock, r2);
> >
> > then herd7 will not realize that the value of r2 depends on the value of
> > r1.  So there will be no data dependency from the srcu_read_lock() to
> > the srcu_read_unlock().
> >
> > Alan
