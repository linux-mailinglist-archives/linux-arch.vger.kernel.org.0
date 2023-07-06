Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EF374A24C
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jul 2023 18:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjGFQiD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jul 2023 12:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjGFQiC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jul 2023 12:38:02 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30C21AE;
        Thu,  6 Jul 2023 09:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1688661478;
        bh=lwhfZRazYulsiYsKZXPsOI+0dCJb/SmcqpyPmq8W+xg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=V5+vwnmtFaeTpMVye7LZyjBp+CBcvDlhWRyHsGt6a09D3mQLNDKSZBwx7LP/WTs7Z
         j7g912oLYj3A1TIQF0gX9a1OGn25C6l3MchqXU7clXjKOcWt+ynjy61eOFNruLf1iY
         tg2y2Vy3sCo6b/upoVrH2APR6rYVy+9DXWHUhMmiitkV0U8/IomVQVD26FX6oPE3uu
         0mYGe7xioVr8UKoI1Rc7qmcLG+sQY6LIId0IB8HaEez2S9gEMqzdXg0jdTnbQjgoZQ
         cg9era4hELiMQ78azUIkk7MOGe6rKbmwYf3pPReaRG79ioKXnQ2II/cZgbuxlQwCEw
         15Bdg97bULYcg==
Received: from localhost (modemcable094.169-200-24.mc.videotron.ca [24.200.169.94])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QxhzB3Jcxz1C9p;
        Thu,  6 Jul 2023 12:37:58 -0400 (EDT)
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
In-Reply-To: <bcdd09ec-b98f-42d6-b59d-64db953076f6@rowland.harvard.edu>
Organization: EfficiOS
References: <87ttukdcow.fsf@laura>
 <feb9c2c0-24ce-40bf-a865-5898ffad3005@rowland.harvard.edu>
 <87ilazd278.fsf@laura>
 <bcdd09ec-b98f-42d6-b59d-64db953076f6@rowland.harvard.edu>
Date:   Thu, 06 Jul 2023 12:37:58 -0400
Message-ID: <87sfa1atcp.fsf@laura>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 04 Jul 2023, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Tue, Jul 04, 2023 at 01:19:23PM -0400, Olivier Dion wrote:
>> On Mon, 03 Jul 2023, Alan Stern <stern@rowland.harvard.edu> wrote:
>> > On Mon, Jul 03, 2023 at 03:20:31PM -0400, Olivier Dion wrote:
[...]
> Oh, is that it?  Then I misunderstood entirely; I thought you were 
> talking about augmenting the set of functions or macros made available 
> in liburcu.  I did not realize you intended to change the compilers.

Yes.  We want to extend the atomic builtins API of the toolchains.

>> Indeed, our intent is to discuss the Userspace RCU uatomic API by extending
>> the toolchain's atomic builtins and not the LKMM itself.  The reason why
>> we've reached out to the Linux kernel developers is because the
>> original Userspace RCU uatomic API is based on the LKMM.
>
> But why do you want to change the compilers to better support urcu?  
> That seems like going about things backward; wouldn't it make more sense 
> to change urcu to better match the facilities offered by the current 
> compilers?

The initial motivation for the migration of the Userspace RCU atomics
API from custom inline assembler (mimicking the LKMM) to the C11/C++11
memory model was for supporting userspace tools such as TSAN.

We did that by porting everything to the compiler's atomic builtins API.
However, because of the "fully-ordered" atomic semantic of the LKMM, we
had no other choices than to add memory fences which are redundant on
some strongly ordered architectures.

> What if everybody started to do this: modifying the compilers to better 
> support their pet projects?  The end result would be chaos!

This is why we are starting this discussion which involves members of
the Kernel and toolchains communities.  We have prior experience, e.g. with
asm gotos which were implemented in GCC, and Clang afterward, in
response to Linux Kernel tracepoint's requirements.

Note that the motivation for supporting TSAN in Userspace RCU is coming
from the requirements of the ISC for the BIND 9 project.

[...]
>> If we go for the grouping in a), we have to take into account that the
>> barriers emitted need to cover the worse case scenario.  As an example,
>> Clang can emit a store for a exchange with SEQ_CST on x86-64, if the
>> returned value is not used.
>> 
>> Therefore, for the grouping in a), all RMW would need to emit a memory
>> barrier (with Clang on x86-64).  But with the scheme in b), we can emit
>> the barrier explicitly for the exchange operation.  We however question
>> the usefulness of this kind of optimization made by the compiler, since
>> a user should use a store operation instead.
>
> So in the end you settled on a compromise?

We have not settled on anything yet.  Choosing between options a) and b)
is open to discussion.

[...]


        Thanks,
        Olivier
-- 
Olivier Dion
EfficiOS Inc.
https://www.efficios.com
