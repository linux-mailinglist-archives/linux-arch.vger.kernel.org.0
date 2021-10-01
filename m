Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D0C41F171
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 17:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhJAPrX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 11:47:23 -0400
Received: from mail.efficios.com ([167.114.26.124]:58602 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhJAPrW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 11:47:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CA63638645D;
        Fri,  1 Oct 2021 11:45:37 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jvV3ZJgPqAFG; Fri,  1 Oct 2021 11:45:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7D33F386141;
        Fri,  1 Oct 2021 11:45:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7D33F386141
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1633103136;
        bh=tdZFM0RCTMf5TWq/BEKiN7Jxsreq5aQVUeqqY1I6YQo=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ffqVjaaZKkIHZVGNuahc4oYB3qHluEniIDzhUBpLAnUvwjq5gnoHJ9VpHc2hg88w8
         e4PidJrCjBCDUr5+fLz+nqIOJgIgWyVkCveIGfE5PAImJNK5ZiGIek/8rcHOHAPNN9
         oy3g8azJ21LeGNiTglAcKDpMCzZKPBbB95wFf7+bwtqwDhih77UfGXAlS10cp5YGxJ
         +hQD/QQVtlol0uPdL/5G6rGv8i/Iqk044sDSQwWSyCUbefhC/FbIZfQ75JJg2NE01y
         RmXGe+h9woVhI372kS37ys72b5AcloBVn7Ro8fvYtzInNMidkmjTWrvDt2aMDar9Ab
         SApdXhUqsTgQA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Xosu6iaAPBNq; Fri,  1 Oct 2021 11:45:36 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 65FE13861E0;
        Fri,  1 Oct 2021 11:45:36 -0400 (EDT)
Date:   Fri, 1 Oct 2021 11:45:36 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        j alglave <j.alglave@ucl.ac.uk>,
        luc maranget <luc.maranget@inria.fr>,
        akiyks <akiyks@gmail.com>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Message-ID: <1340204910.47919.1633103136293.JavaMail.zimbra@efficios.com>
In-Reply-To: <YVRWyq+rDeAFLx+X@elver.google.com>
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com> <YVRWyq+rDeAFLx+X@elver.google.com>
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4125 (ZimbraWebClient - FF92 (Linux)/8.8.15_GA_4059)
Thread-Topic: LKMM: Add ctrl_dep() macro for control dependency
Thread-Index: d9agcrBI/g+vSBSUYnraVzg7PQhubQ==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Sep 29, 2021, at 8:06 AM, Marco Elver elver@google.com wrote:

> On Tue, Sep 28, 2021 at 05:15PM -0400, Mathieu Desnoyers wrote:
>> The control dependency ordering currently documented in
>> Documentation/memory-barriers.txt is fragile and can be broken by
>> various compiler optimizations.
>> 
>> The goal here is to prevent the compiler from being able to optimize a
>> conditional branch into something which lacks the control dependency,
>> while letting the compiler choose the best conditional branch in each
>> case.
>> 
>> Prevent the compiler from considering the two legs of a conditional
>> branch as identical by adding a distinct volatile asm in each leg of the
>> branch. Those asm do not emit any instruction nor data into the
>> resulting executable, and do not have any clobbers.
>> 
>> GNU describes asm volatile statements as having side-effects. [1]
>> 
>> C99 describes that accessing volatile objects are side-effects, and that
>> "at certain specified points in the execution sequence called sequence
>> points, all side effects of previous evaluations shall be complete
>> and no side effects of subsequent evaluations shall have taken
>> place". [2]
>> 
>> This ensures that the program order of READ_ONCE(), asm volatile in both
>> legs of the branch, and following WRITE_ONCE() and after_ctrl_dep()
>> barriers are preserved.
>> 
>> With this approach, the following code now keeps the control dependency:
>> 
>>         z = READ_ONCE(var1);
>>         if (ctrl_dep(z))
>>                 WRITE_ONCE(var2, 5);
>>         else
>>                 WRITE_ONCE(var2, 5);
>> 
>> And the ctrl_dep_eval() checking the constant triggers a build error
>> for:
>> 
>>         y = READ_ONCE(var1);
>>         if (ctrl_dep(y % 1))
>>                 WRITE_ONCE(var2, 5);
>>         else
>>                 WRITE_ONCE(var2, 6);
>> 
>> Which is good to have to ensure the compiler don't end up removing the
>> conditional branch because the it evaluates a constant.
>> 
>> Introduce the ctrl_dep macro in the generic headers, and use it
>> everywhere it appears relevant.  The approach taken is simply to
>> look for smp_acquire__after_ctrl_dep and "control dependency" across the
>> kernel sources, so a few other uses may have been missed.
> 
> It would be nice to know where and on which arch things are currently
> broken of course, which might then also help raise confidence that this
> implementation of ctrl_dep() works.
> 
> Because it's still hard to prove that the compiler will always do the
> right thing with that implementation. The only concrete option I see
> here is creating tests with known or potential breakage.
> 
> In an ideal world we could add such tests to the compiler's test-suites
> themselves, assuming the behaviour your ctrl_dep() implementation relies
> on is supposed to be guaranteed (and the compiler folks agree..).

Indeed, if we end up agreeing on the need for a compiler builtin, it should
be added to the compiler test-suites with the known problematic scenarios
for each architecture.

> 
> Beyond the above trivial test case with 2 identical branches, here's
> another one that breaks on arm64 with clang 12 (taken from
> https://reviews.llvm.org/D103958):
> 
> | int x, y;
> | void noinline test_ctrl_dep_broken1(void)
> | {
> | 	/* ARM: do NOT expect: cinc | expect: cbz */
> | 	if (ctrl_dep(READ_ONCE(x))) {
> | 		y = 1;
> | 	} else {
> | 		y = 2;
> | 	}
> | }
> 
> Without ctrl_dep():
> 
> | <test_ctrl_dep_broken1>:
> |        d00042a8        adrp    x8, ffffffc010868000 <initcall_debug>
> |        b9400508        ldr     w8, [x8, #4]
> |        52800029        mov     w9, #0x1                        // #1
> |        7100011f        cmp     w8, #0x0
> |        1a891528        cinc    w8, w9, eq  // eq = none
> |        d00042a9        adrp    x9, ffffffc010868000 <initcall_debug>
> |        b9000928        str     w8, [x9, #8]
> |        d65f03c0        ret
> 
>			^^ no branch, compiler replaced branch with cinc!
> 
> with ctrl_dep():
> 
> | <test_ctrl_dep_broken1>:
> |        d00042a8        adrp    x8, ffffffc010868000 <initcall_debug>
> |        b9400508        ldr     w8, [x8, #4]
> |        34000068        cbz     w8, ffffffc0100124b4 <test_ctrl_dep_broken1+0x14>
> |        52800028        mov     w8, #0x1                        // #1
> |        14000002        b       ffffffc0100124b8 <test_ctrl_dep_broken1+0x18>
> |        52800048        mov     w8, #0x2                        // #2
> |        d00042a9        adrp    x9, ffffffc010868000 <initcall_debug>
> |        b9000928        str     w8, [x9, #8]
> |        d65f03c0        ret
> 
>			^^ has cbz (and no cinc)
> 
> Which is good -- empirically, this seems to work for this case at least.

Well AFAIU, this example with cinc does guarantee the control dependency for the store
to "y". The issue arises if we have additional stores which are also expected to be
ordered by the control dependency, e.g.:

 	if (READ_ONCE(x)) {
 		WRITE_ONCE(y, 1);
 	} else {
 		WRITE_ONCE(y, 2);
 	}
        WRITE_ONCE(z, 3);

Here the store to "z" would not necessarily be ordered by the control dependency.

Likewise with clang if we store the same value to different memory locations, e.g.:

 	if (READ_ONCE(x)) {
 		WRITE_ONCE(a, 0);
 	} else {
 		WRITE_ONCE(b, 0);
 	}
        WRITE_ONCE(z, 3);

With armv8, the csel instruction is done on the address being written to, which also
removes the conditional branch. I think this last example is missing from the kernel
documentation.

Another case which should perhaps be documented is the ability of the compiler to
match assembler, e.g.:

if (READ_ONCE(x)) {
   smp_acquire__after_ctrl_dep();
   WRITE_ONCE(a, 0);
} else {
   smp_rmb();
   WRITE_ONCE(b, 0);
}
WRITE_ONCE(z, 3);

In the example above, the compiler can match and lift the inline asm, and use
csel to select the address to write to, thus causing the store to z to lack
the control dependency with load x.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
