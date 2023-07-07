Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2A774B278
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jul 2023 16:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjGGOEM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jul 2023 10:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGGOEL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jul 2023 10:04:11 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4167E11B;
        Fri,  7 Jul 2023 07:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1688738646;
        bh=5jbxwb1aPjrUPrfRW2dBw44je1ZzASY+efNvvqqX77E=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bO3WwwnpXUmsPeGK/VzYP/BxzqqbcJ7yGTLa5EXcqB47OM/KCOQR6Ptnr0kd+OaoR
         30bCgjYNw3wdiJH/NdPy47S/pkF3Pa6TUZFEzO6PaXd1dvc6lI5lYvSKA7Ougu/uGX
         7AD+uLdlxq8Io9UN/Ct5sKi8eY9tsvDuH08qOA49etvJOVyArVsRSzTXYozDjMo8W2
         xPd0RWL9TovbU1wfZasC2NkuyxuR6wQwVlJKNWdnvGYWctuT1vlPmL6xqry0tDAfWY
         hTgl2Y6JdrUMNmoYVC6StSKbi0STZqAoF0xMHH9xAD9td4KpECLi4ZhQxdfKTtxpyo
         O6uKAeMA1W4tA==
Received: from localhost (modemcable094.169-200-24.mc.videotron.ca [24.200.169.94])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QyFWB6FM1z1G4y;
        Fri,  7 Jul 2023 10:04:06 -0400 (EDT)
From:   Olivier Dion <odion@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, rnk@google.com,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
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
In-Reply-To: <20230704094627.GS4253@hirez.programming.kicks-ass.net>
Organization: EfficiOS
References: <87ttukdcow.fsf@laura>
 <20230704094627.GS4253@hirez.programming.kicks-ass.net>
Date:   Fri, 07 Jul 2023 10:04:06 -0400
Message-ID: <87cz13hl7t.fsf@laura>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 04 Jul 2023, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Jul 03, 2023 at 03:20:31PM -0400, Olivier Dion wrote:
[...]
>> On x86-64 (gcc 13.1 -O2) we get:
>> 
>>   t0():
>>           movl    $1, x(%rip)
>>           movl    $1, %eax
>>           xchgl   dummy(%rip), %eax
>>           lock orq $0, (%rsp)       ;; Redundant with previous exchange.
>>           movl    y(%rip), %eax
>>           movl    %eax, r0(%rip)
>>           ret
>>   t1():
>>           movl    $1, y(%rip)
>>           lock orq $0, (%rsp)
>>           movl    x(%rip), %eax
>>           movl    %eax, r1(%rip)
>>           ret
>
> So I would expect the compilers to do better here. It should know those
> __atomic_thread_fence() thingies are superfluous and simply not emit
> them. This could even be done as a peephole pass later, where it sees
> consecutive atomic ops and the second being a no-op.

Indeed, a peephole optimization could work for this Dekker, if the
compiler adds the pattern for it.  However, AFAIK, a peephole can not be
applied when the two fences are in different basic blocks.  For example,
only emitting a fence on a compare_exchange success.  This limitation
implies that the optimization can not be done across functions/modules
(shared libraries).  For example, it would be interesting to be able to
promote an acquire fence of a pthread_mutex_lock() to a full fence on
weakly ordered architectures while preventing a redundant fence on
strongly ordered architectures.

We know that at least Clang has such peephole optimizations for some
architecture backends.  It seems however that they do not recognize
lock-prefixed instructions as fence.  AFAIK, GCC does not have that kind
of optimization.

We are also aware that some research has been done on this topic [0].
The idea is to use PRE for elimiation of redundant fences.  This would
work across multiple basic blocks, although the paper focus on
intra-procedural eliminations.  However, it seems that the latest work
on that [1] has never been completed [2].

Our proposed approach provides a mean for the user to express -- and
document -- the wanted semantic in the source code.  This allows the
compiler to only emit wanted fences, therefore not relying on
architecture specific backend optimizations.  In other words, this
applies even on unoptimized binaries.

[...]

	Thanks,
        Olivier

  [0] https://dl.acm.org/doi/10.1145/3033019.3033021

  [1] https://discourse.llvm.org/t/fence-elimination-pass-proposal/33679

  [2] https://reviews.llvm.org/D5758
-- 
Olivier Dion
EfficiOS Inc.
https://www.efficios.com
