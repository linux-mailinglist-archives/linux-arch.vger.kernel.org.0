Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F122F6935B6
	for <lists+linux-arch@lfdr.de>; Sun, 12 Feb 2023 03:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjBLC7R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 Feb 2023 21:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBLC7Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Feb 2023 21:59:16 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 45D5CFF2E
        for <linux-arch@vger.kernel.org>; Sat, 11 Feb 2023 18:59:15 -0800 (PST)
Received: (qmail 864692 invoked by uid 1000); 11 Feb 2023 21:59:14 -0500
Date:   Sat, 11 Feb 2023 21:59:14 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: Current LKMM patch disposition
Message-ID: <Y+hWAksfk4C0M2gB@rowland.harvard.edu>
References: <20230204004843.GA2677518@paulmck-ThinkPad-P17-Gen-1>
 <Y920w4QRLtC6kd+x@rowland.harvard.edu>
 <20230204014941.GS2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y95yhJgNq8lMXPdF@rowland.harvard.edu>
 <20230204222411.GC2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9+41ctA54pjm/KG@google.com>
 <Y+FJSzUoGTgReLPB@rowland.harvard.edu>
 <Y+fN2fvUjGDWBYrv@google.com>
 <Y+f4TYZ9BPlt8y8B@rowland.harvard.edu>
 <CAEXW_YRuTfjc=5OAskTV0Qt_zSJTPP3-01=Y=SypMdPsF_weAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YRuTfjc=5OAskTV0Qt_zSJTPP3-01=Y=SypMdPsF_weAQ@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 11, 2023 at 07:30:32PM -0500, Joel Fernandes wrote:
> On Sat, Feb 11, 2023 at 3:19 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > The idea is that the value returned by srcu_read_lock() can be stored to
> > and loaded from a sequence (possibly of length 0) of variables, and the
> > final load gets fed to srcu_read_unlock().  That's what the original
> > version of the code expresses.
> 
> Now I understand it somewhat, and I see where I went wrong. Basically,
> you were trying to sequence zero or one "data + rf sequence" starting
> from lock and unlock with a final "data" sequence. That data sequence
> can be between the srcu-lock and srcu-unlock itself, in case where the
> lock/unlock happened on the same CPU.

In which case the sequence has length 0.  Exactly right.

> Damn, that's really complicated.. and I still don't fully understand it.

It sounds like you've made an excellent start.  :-)

> In trying to understand your CAT code, I made some assumptions about
> your formulas by reverse engineering the CAT code with the tests,
> which is kind of my point that it is extremely hard to read CAT. That

I can't argue against that; it _is_ hard.  It helps to have had the 
right kind of training beforehand (my degree was in mathematical logic).

> is kind of why I want to understand the CAT, because for me
> explanation.txt is too much at a higher level to get a proper
> understanding of the memory model.. I tried re-reading explanation.txt
> many times.. then I realized I am just rewriting my own condensed set
> of notes every few months.

Would you like to post a few examples showing some of the most difficult 
points you encountered?  Maybe explanation.txt can be improved.

> > I'm not sure that breaking this relation up into pieces will make it any
> > easier to understand.
> 
> Yes, but I tried. I will keep trying to understand your last patch
> more. Especially I am still not sure, why in the case of an SRCU
> reader on a single CPU, the following does not work:
> let srcu-rscs = ([Srcu-lock]; data; [Srcu-unlock]).

You have to understand that herd7 does not track dependencies through 
stores and subsequent loads.  That is, if you have something like:

	r1 = READ_ONCE(*x);
	WRITE_ONCE(*y, r1);
	r2 = READ_ONCE(*y);
	WRITE_ONCE(*z, r2);

then herd7 will realize that the write to y depends on the value read 
from x, and it will realize that the write to z depends on the value 
read from y.  But it will not realize that the write to z depends on the 
value read from x; it loses track of that dependency because of the 
intervening store/load from y.

More to the point, if you have:

	r1 = srcu_read_lock(lock);
	WRITE_ONCE(*y, r1);
	r2 = READ_ONCE(*y);
	srcu_read_unlock(lock, r2);

then herd7 will not realize that the value of r2 depends on the value of 
r1.  So there will be no data dependency from the srcu_read_lock() to 
the srcu_read_unlock().

Alan
