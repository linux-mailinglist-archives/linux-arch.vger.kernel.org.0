Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925DE74779F
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jul 2023 19:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjGDRTc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jul 2023 13:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGDRTa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2023 13:19:30 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B0F10D7;
        Tue,  4 Jul 2023 10:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1688491164;
        bh=XoqjGAAisrMB/Pfyua6e1oRHYcJ+y87IfUpKWBoC9wk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=N2D2FNXOyS0ABkYSbbOai7GzSARmAlho0m8eLsvqFxANOIuMOhO1LxydQEjhJqWyn
         s4diZvaronIi3ssoqSJLXbG2Evq/maxxdpiOJUSEh/lXO8vRT9kOiXIgk6/vlSH72L
         SoAmwZR1oFltK2T3OZT7oqpbU9kE+AnZRPw+R71IXS3aARtVDA+vkBW3RoghrODyGA
         LNHHXSzwcvpj5hUxSspofjvrHBgPIgFJeLfkY/HYpuR6P21DoPavis1F8YwgHyI9Cm
         lKxMFY44J/zevh4FFKsVftiCQZvvfa9EmOv/54AsOL+YBt7uD0VDfqyCww4cIbuzEA
         6CZ5BEHfIqYSw==
Received: from localhost (modemcable094.169-200-24.mc.videotron.ca [24.200.169.94])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QwTzv6tQ7z1C97;
        Tue,  4 Jul 2023 13:19:23 -0400 (EDT)
From:   Olivier Dion <odion@efficios.com>
To:     Alan Stern <stern@rowland.harvard.edu>
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
In-Reply-To: <feb9c2c0-24ce-40bf-a865-5898ffad3005@rowland.harvard.edu>
Organization: EfficiOS
References: <87ttukdcow.fsf@laura>
 <feb9c2c0-24ce-40bf-a865-5898ffad3005@rowland.harvard.edu>
Date:   Tue, 04 Jul 2023 13:19:23 -0400
Message-ID: <87ilazd278.fsf@laura>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 03 Jul 2023, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, Jul 03, 2023 at 03:20:31PM -0400, Olivier Dion wrote:
>> This is a request for comments on extending the atomic builtins API to
>> help avoiding redundant memory barriers.  Indeed, there are
>
> What atomic builtins API are you talking about?  The kernel's?  That's 
> what it sounded like when I first read this sentence -- why else post 
> your message on a kernel mailing list?

Good point, we meant the `__atomic' builtins from GCC and Clang.  Sorry
for the confusion.

[...]

>> fully-ordered atomic operations like xchg and cmpxchg success in LKMM
>> have implicit memory barriers before/after the operations [1-2], while
>> atomic operations using the __ATOMIC_SEQ_CST memory order in C11/C++11
>> do not have any ordering guarantees of an atomic thread fence
>> __ATOMIC_SEQ_CST with respect to other non-SEQ_CST operations [3].
>
> After reading what you wrote below, I realized that the API you're 
> thinking of modifying is the one used by liburcu for user programs.  
> It's a shame you didn't mention this in either the subject line or the 
> first few paragraphs of the email; that would have made understanding 
> the message a little easier.

Indeed, our intent is to discuss the Userspace RCU uatomic API by extending
the toolchain's atomic builtins and not the LKMM itself.  The reason why
we've reached out to the Linux kernel developers is because the
original Userspace RCU uatomic API is based on the LKMM.

> In any case, your proposal seems reasonable to me at first glance, with 
> two possible exceptions:
>
> 1.	I can see why you have special fences for before/after load, 
> 	store, and rmw operations.  But why clear?  In what way is 
> 	clearing an atomic variable different from storing a 0 in it?

We could indeed group the clear with the store.

We had two approaches in mind:

  a) A before/after pair by category of operation:

     - load
     - store
     - RMW
  
  b) A before/after pair for every operation:

     - load
     - store
     - exchange
     - compare_exchange
     - {add,sub,and,xor,or,nand}_fetch
     - fetch_{add,sub,and,xor,or,nand}
     - test_and_set
     - clear

If we go for the grouping in a), we have to take into account that the
barriers emitted need to cover the worse case scenario.  As an example,
Clang can emit a store for a exchange with SEQ_CST on x86-64, if the
returned value is not used.

Therefore, for the grouping in a), all RMW would need to emit a memory
barrier (with Clang on x86-64).  But with the scheme in b), we can emit
the barrier explicitly for the exchange operation.  We however question
the usefulness of this kind of optimization made by the compiler, since
a user should use a store operation instead.

> 2.	You don't have a special fence for use after initializing an 
> 	atomic.  This operation can be treated specially, because at the 
> 	point where an atomic is initialized, it generally has not yet 
> 	been made visible to any other threads.

I assume that you're referring to something like std::atomic_init from
C++11 and deprecated in C++20?  I do not see any scenario on any
architecture where a compiler would emit an atomic operation for the
initialization of an atomic variable.  If a memory barrier is required
in this situation, then an explicit one can be emitted using the
existing API.

In our case -- with the compiler's atomic builtins -- the initialization
of a variable can be done without any atomic operations and does not
require any memory barrier.  This is a consequence of being capable of
working with integral-scalar/pointer type without an atomic qualifier.

> Therefore the fence which would normally appear after a store (or
> clear) generally need not appear after an initialization, and you
> might want to add a special API to force the generation of such a
> fence.

I am puzzled by this.  Initialization of a shared variable does not need
to be atomic until its publication.  Could you expand on this?

Thanks for the feedback,
	Olivier

-- 
Olivier Dion
EfficiOS Inc.
https://www.efficios.com
