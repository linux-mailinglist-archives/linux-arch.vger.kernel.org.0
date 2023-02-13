Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225AF694D39
	for <lists+linux-arch@lfdr.de>; Mon, 13 Feb 2023 17:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjBMQsP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Feb 2023 11:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjBMQsO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Feb 2023 11:48:14 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0E15ACDCE
        for <linux-arch@vger.kernel.org>; Mon, 13 Feb 2023 08:48:12 -0800 (PST)
Received: (qmail 913444 invoked by uid 1000); 13 Feb 2023 11:48:12 -0500
Date:   Mon, 13 Feb 2023 11:48:12 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: Current LKMM patch disposition
Message-ID: <Y+ppzKlvzQIE18Hu@rowland.harvard.edu>
References: <20230204014941.GS2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y95yhJgNq8lMXPdF@rowland.harvard.edu>
 <20230204222411.GC2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9+41ctA54pjm/KG@google.com>
 <Y+FJSzUoGTgReLPB@rowland.harvard.edu>
 <Y+fN2fvUjGDWBYrv@google.com>
 <Y+f4TYZ9BPlt8y8B@rowland.harvard.edu>
 <CAEXW_YRuTfjc=5OAskTV0Qt_zSJTPP3-01=Y=SypMdPsF_weAQ@mail.gmail.com>
 <Y+hWAksfk4C0M2gB@rowland.harvard.edu>
 <CAEXW_YQUOgYxYUNkQ9W6PS-JPwPSOFU5B=COV7Vf+qNF1jFC7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQUOgYxYUNkQ9W6PS-JPwPSOFU5B=COV7Vf+qNF1jFC7g@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Feb 12, 2023 at 07:54:15PM -0500, Joel Fernandes wrote:
> On Sat, Feb 11, 2023 at 9:59 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> [...]
> > > is kind of why I want to understand the CAT, because for me
> > > explanation.txt is too much at a higher level to get a proper
> > > understanding of the memory model.. I tried re-reading explanation.txt
> > > many times.. then I realized I am just rewriting my own condensed set
> > > of notes every few months.
> >
> > Would you like to post a few examples showing some of the most difficult
> > points you encountered?  Maybe explanation.txt can be improved.
> 
> Just to list 2 of the pain points:
> 
> 1. I think it is hard to reason this section
> "PROPAGATION ORDER RELATION: cumul-fence"
> 
> All store-related fences should affect propagation order, even the
> smp_wmb() which is not A-cumulative should do so (po-earlier stores
> appearing before po-later). I think expanding this section with some
> examples would make sense to understand what makes "cumul-fence"
> different from any other store-related fence.

Adding some examples is a good idea.  That section is pretty terse.

> 2. This part is confusing and has always confused me " The
> happens-before relation (hb) links memory accesses that have to
> execute in a certain order"
> 
> It is not memory accesses that execute, it is instructions that
> execute. Can we separate out "memory access" from "instruction
> execution" in this description?

The memory model doesn't really talk about instruction execution; it 
thinks about everything in terms of events rather than instructions.  
However, I agree that the document isn't very precise about the 
distinction between instructions and events.

> I think ->hb tries to say that A ->hb B means, memory access A
> happened before memory access B exactly in its associated
> instruction's execution order (time order), but to be specific --
> should that be instruction issue order, or instruction retiring order?

The model isn't that specific.  It doesn't recognize that instructions 
take a nonzero amount of time to execute; it thinks of events as 
happening instantaneously.  (With exceptions perhaps for 
synchronize_rcu() and synchronize_srcu().)

If you want to relate the memory model to actual hardware, it's probably 
best to think in terms of instruction retiring.  But even that isn't 
exactly right.

For example, real CPUs can satisfy loads speculatively, possibly 
multiple times, before retiring them -- you should think of a load as 
executing at the _last_ time it is satisfied.  This generally is after 
the instruction has been issued and before it is retired.  You can think 
of a store as executing at the time the CPU commits to it.

> AFAICS ->hb maps instruction execution order to memory access order.

That's not the right way to think about it.  In the model, a memory 
access occurs when the corresponding event executes.  So saying that two 
events (or instructions) execute in a certain order is the same as 
saying that their two memory accesses execute in that order.  There's no 
mapping involved.

> Not all ->po does  fall into that category because of out-of-order
> hardware execution. As does not ->co because the memory subsystem may
> have writes to the same variable to be resolved out of order. It would
> be nice to call out that ->po is instruction issue order, which is
> different from execution/retiring and that's why it cannot be ->hb.

Okay, that would be a worthwhile addition.

> ->rf does because of data flow causality, ->ppo does because of
> program structure, so that makes sense to be ->hb.
> 
> IMHO, ->rfi should as well, because it is embodying a flow of data, so
> that is a bit confusing. It would be great to clarify more perhaps
> with an example about why ->rfi cannot be ->hb, in the
> "happens-before" section.

Maybe.  We do talk about store forwarding, and in fact the ppo section 
already says:

------------------------------------------------------------------------
        R ->dep W ->rfi R',

where the dep link can be either an address or a data dependency.  In
this situation we know it is possible for the CPU to execute R' before
W, because it can forward the value that W will store to R'.
------------------------------------------------------------------------

I suppose this could be reiterated in the hb section.

Alan
