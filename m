Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635EC7478F6
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jul 2023 22:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjGDUZt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jul 2023 16:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGDUZt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2023 16:25:49 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 6FF73E7B
        for <linux-arch@vger.kernel.org>; Tue,  4 Jul 2023 13:25:46 -0700 (PDT)
Received: (qmail 1108780 invoked by uid 1000); 4 Jul 2023 16:25:45 -0400
Date:   Tue, 4 Jul 2023 16:25:45 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Olivier Dion <odion@efficios.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, rnk@google.com,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, gcc@gcc.gnu.org, llvm@lists.linux.dev
Subject: Re: [RFC] Bridging the gap between the Linux Kernel Memory
 Consistency Model (LKMM) and C11/C++11 atomics
Message-ID: <bcdd09ec-b98f-42d6-b59d-64db953076f6@rowland.harvard.edu>
References: <87ttukdcow.fsf@laura>
 <feb9c2c0-24ce-40bf-a865-5898ffad3005@rowland.harvard.edu>
 <87ilazd278.fsf@laura>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilazd278.fsf@laura>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 04, 2023 at 01:19:23PM -0400, Olivier Dion wrote:
> On Mon, 03 Jul 2023, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Mon, Jul 03, 2023 at 03:20:31PM -0400, Olivier Dion wrote:
> >> This is a request for comments on extending the atomic builtins API to
> >> help avoiding redundant memory barriers.  Indeed, there are
> >
> > What atomic builtins API are you talking about?  The kernel's?  That's 
> > what it sounded like when I first read this sentence -- why else post 
> > your message on a kernel mailing list?
> 
> Good point, we meant the `__atomic' builtins from GCC and Clang.  Sorry
> for the confusion.

Oh, is that it?  Then I misunderstood entirely; I thought you were 
talking about augmenting the set of functions or macros made available 
in liburcu.  I did not realize you intended to change the compilers.

> Indeed, our intent is to discuss the Userspace RCU uatomic API by extending
> the toolchain's atomic builtins and not the LKMM itself.  The reason why
> we've reached out to the Linux kernel developers is because the
> original Userspace RCU uatomic API is based on the LKMM.

But why do you want to change the compilers to better support urcu?  
That seems like going about things backward; wouldn't it make more sense 
to change urcu to better match the facilities offered by the current 
compilers?

What if everybody started to do this: modifying the compilers to better 
support their pet projects?  The end result would be chaos!

> > 1.	I can see why you have special fences for before/after load, 
> > 	store, and rmw operations.  But why clear?  In what way is 
> > 	clearing an atomic variable different from storing a 0 in it?
> 
> We could indeed group the clear with the store.
> 
> We had two approaches in mind:
> 
>   a) A before/after pair by category of operation:
> 
>      - load
>      - store
>      - RMW
>   
>   b) A before/after pair for every operation:
> 
>      - load
>      - store
>      - exchange
>      - compare_exchange
>      - {add,sub,and,xor,or,nand}_fetch
>      - fetch_{add,sub,and,xor,or,nand}
>      - test_and_set
>      - clear
> 
> If we go for the grouping in a), we have to take into account that the
> barriers emitted need to cover the worse case scenario.  As an example,
> Clang can emit a store for a exchange with SEQ_CST on x86-64, if the
> returned value is not used.
> 
> Therefore, for the grouping in a), all RMW would need to emit a memory
> barrier (with Clang on x86-64).  But with the scheme in b), we can emit
> the barrier explicitly for the exchange operation.  We however question
> the usefulness of this kind of optimization made by the compiler, since
> a user should use a store operation instead.

So in the end you settled on a compromise?

> > 2.	You don't have a special fence for use after initializing an 
> > 	atomic.  This operation can be treated specially, because at the 
> > 	point where an atomic is initialized, it generally has not yet 
> > 	been made visible to any other threads.
> 
> I assume that you're referring to something like std::atomic_init from
> C++11 and deprecated in C++20?  I do not see any scenario on any
> architecture where a compiler would emit an atomic operation for the
> initialization of an atomic variable.  If a memory barrier is required
> in this situation, then an explicit one can be emitted using the
> existing API.
> 
> In our case -- with the compiler's atomic builtins -- the initialization
> of a variable can be done without any atomic operations and does not
> require any memory barrier.  This is a consequence of being capable of
> working with integral-scalar/pointer type without an atomic qualifier.
> 
> > Therefore the fence which would normally appear after a store (or
> > clear) generally need not appear after an initialization, and you
> > might want to add a special API to force the generation of such a
> > fence.
> 
> I am puzzled by this.  Initialization of a shared variable does not need
> to be atomic until its publication.  Could you expand on this?

In the kernel, I believe it sometimes happens that an atomic variable 
may be published before it is initialized.  (If that's wrong, Paul or 
Peter can correct me.)  But since this doesn't apply to the situations 
you're concerned with, you can forget I mentioned it.

Alan
