Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877E374B45A
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jul 2023 17:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjGGPbT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jul 2023 11:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjGGPbS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jul 2023 11:31:18 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8F8AF;
        Fri,  7 Jul 2023 08:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1688743875;
        bh=6r0pVTMiXPIZxuj/C4xxxu1nMFpZhaCFC1W3fq20TXI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FhFFgHuTdpwQ36mN93527p/AICqsZ5lB/YjyN69PD4017Iki3cN4uXGK0oAyzRNw0
         6mvCFv026mjMRE4lEzF2LcIC82byjyYDs99uXizssVVk2UdekAMg7ZTrxApZUQLodC
         KGvmhoTdjtccOt83XDbM547OTeQrcq42/8kBB09xGzCXO7ur1XzEcocHOg7g3BagIc
         xMm+XTDpJhqDd0FB51ZNRS/tYZWObEqD9OoQt4jRGUgkvGCmLALh2prjw9HCG4E1NH
         YHqzx2EHUg8UZa6brQuJzJm9d6Q9+N0mpynIUlR/zTdRlN+oTyPoFykhkaxl6sbqFz
         p9LcYkmT47vRA==
Received: from [172.16.0.85] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QyHRj4PP0z1G9d;
        Fri,  7 Jul 2023 11:31:13 -0400 (EDT)
Message-ID: <ecf1b725-1351-3460-4a99-7a03f15af152@efficios.com>
Date:   Fri, 7 Jul 2023 11:31:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC] Bridging the gap between the Linux Kernel Memory
 Consistency Model (LKMM) and C11/C++11 atomics
Content-Language: en-US
To:     Jonathan Wakely <jwakely.gcc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Olivier Dion <odion@efficios.com>, rnk@google.com,
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
References: <87ttukdcow.fsf@laura>
 <20230704094627.GS4253@hirez.programming.kicks-ass.net>
 <CAH6eHdQQWO2AYQRXnAATt6nvcyDjKj-_5Ktt2ze6F158hBon=Q@mail.gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAH6eHdQQWO2AYQRXnAATt6nvcyDjKj-_5Ktt2ze6F158hBon=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/4/23 06:23, Jonathan Wakely wrote:
> On Tue, 4 Jul 2023 at 10:47, Peter Zijlstra wrote:
>>
>> On Mon, Jul 03, 2023 at 03:20:31PM -0400, Olivier Dion wrote:
>>
>>>    int x = 0;
>>>    int y = 0;
>>>    int r0, r1;
>>>
>>>    int dummy;
>>>
>>>    void t0(void)
>>>    {
>>>            __atomic_store_n(&x, 1, __ATOMIC_RELAXED);
>>>
>>>            __atomic_exchange_n(&dummy, 1, __ATOMIC_SEQ_CST);
>>>            __atomic_thread_fence(__ATOMIC_SEQ_CST);
>>>
>>>            r0 = __atomic_load_n(&y, __ATOMIC_RELAXED);
>>>    }
>>>
>>>    void t1(void)
>>>    {
>>>            __atomic_store_n(&y, 1, __ATOMIC_RELAXED);
>>>            __atomic_thread_fence(__ATOMIC_SEQ_CST);
>>>            r1 = __atomic_load_n(&x, __ATOMIC_RELAXED);
>>>    }
>>>
>>>    // BUG_ON(r0 == 0 && r1 == 0)
>>>
>>> On x86-64 (gcc 13.1 -O2) we get:
>>>
>>>    t0():
>>>            movl    $1, x(%rip)
>>>            movl    $1, %eax
>>>            xchgl   dummy(%rip), %eax
>>>            lock orq $0, (%rsp)       ;; Redundant with previous exchange.
>>>            movl    y(%rip), %eax
>>>            movl    %eax, r0(%rip)
>>>            ret
>>>    t1():
>>>            movl    $1, y(%rip)
>>>            lock orq $0, (%rsp)
>>>            movl    x(%rip), %eax
>>>            movl    %eax, r1(%rip)
>>>            ret
>>
>> So I would expect the compilers to do better here. It should know those
>> __atomic_thread_fence() thingies are superfluous and simply not emit
>> them. This could even be done as a peephole pass later, where it sees
>> consecutive atomic ops and the second being a no-op.
> 
> Right, I don't see why we need a whole set of new built-ins that say
> "this fence isn't needed if the adjacent atomic op already implies a
> fence". If the adjacent atomic op already implies a fence for a given
> ISA, then the compiler should already be able to elide the explicit
> fence.
> 
> So just write your code with the explicit fence, and rely on the
> compiler to optimize it properly. Admittedly, today's compilers don't
> do that optimization well, but they also don't support your proposed
> built-ins, so you're going to have to wait for compilers to make
> improvements either way.

Emitting the redundant fences is the plan we have for liburcu.  The
current situation unfortunately requires users to choose between
generation of inefficient code with C11 or implement their own inline
assembler until the compilers catch up.

> 
> https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2015/n4455.html
> discusses that compilers could (and should) optimize around atomics
> better.

Our understanding of the C11/C++11 memory model is that it aims at
defining the weakest possible guarantees for each ordering to be as
efficient as possible on weakly ordered architectures.  However, when
writing portable code in practice, the C11/C++11 memory model force the
programmer to insert memory fences which are redundant on strongly
ordered architectures.

We want something that can apply across procedures from different
modules: e.g. a mutex lock operation (glibc) has an acquire semantic
using a RMW operation that the caller could promote to a full fence.
The peephole optimizations cannot do this because they focus on a single
basic block.  PRE can apply across procedures, but would rely on LTO and
possibly function annotation across modules.  I am not aware of any
progress in that research field in the past 6 years. [1-2]

The new atomic builtins we propose allow the user to better express its
intent to the compiler, allowing for better code generation.  Therefore,
reducing the number of emitted redundant fences, without having to rely on
optimizations.

It should be noted that the builtins extensions we propose are not
entirely free.  Here are our perceived downsides of introducing those
APIs:

- They add complexity to the atomic builtins API.

- They add constraints which need to be taken into account for future
   architecture-specific backend optimizations, as an example the (broken)
   xchg RELEASE | RELAXED -> store on x86 (Clang) [3].

   If an atomic op class (e.g. rmw) can be optimized to a weaker
   instruction by the architecture backend, then the emission of a
   before/after-fence associated with this class of atomic op, must be
   pessimistic and assume the weakest instruction pattern which can
   be generated.

There are optimizations of atomics and redundant fences in Clang.  The
redundant fences optimizations appear to be limited to a peephole, which
does not appear to leverage the fact that lock-prefixed atomic
operations act as implicit fences on x86.  Perhaps this could be a
low-hanging fruit for optimization.

We have not observed any similar optimizations in gcc as of today, which
appears to be a concern for many users. [4-7]

Thanks,

Mathieu

[1] https://dl.acm.org/doi/10.1145/3033019.3033021
[2] https://reviews.llvm.org/D5758
[3] https://github.com/llvm/llvm-project/issues/60418
[4] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=86056
[5] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=68622
[6] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=86072
[7] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63273

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

