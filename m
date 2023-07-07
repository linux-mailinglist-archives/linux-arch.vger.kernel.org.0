Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EBD74B48F
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jul 2023 17:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjGGPqA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jul 2023 11:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjGGPp7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jul 2023 11:45:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8209F1BF4;
        Fri,  7 Jul 2023 08:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Sbue8uRujdfGf15vt4de2yZ6JUgInnsREPoZVJderQQ=; b=DnEXpIFT0PgJN2YOy+8MTlp/11
        yOSSIOasFRVBy2ZRej2Cs0zE7gH2sBSuU+7WStq5iYCb5rSGqEwfEezf7VGmHbTiryPxUP5EECc0w
        SNr0vnNR8zv83zLeWiBlkARHRvxEzL7pXf9aWN23zXLiCB7B2bgpTj7bFj++G/bTC14cSb+jXRetR
        3OI24q6VzExGvCnX+rJmpmG62TC9RI9RwwKKc5SoDerbcqt3aFCKNgVj0aA+kprMx4soLR1SZaXh/
        XWdOy0cKvOg5vdN5Z965slmgRJ3bRT8Hv5Z1hRf2IGrwUqoC/fjabYxuPaHnPbiuYMj3PYnWpwEZN
        IoaDe3dA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qHneF-00F9FP-0y;
        Fri, 07 Jul 2023 15:45:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A2DA5300222;
        Fri,  7 Jul 2023 17:45:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8DC7724B204C3; Fri,  7 Jul 2023 17:45:28 +0200 (CEST)
Date:   Fri, 7 Jul 2023 17:45:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Olivier Dion <odion@efficios.com>
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
Message-ID: <20230707154528.GC2883469@hirez.programming.kicks-ass.net>
References: <87ttukdcow.fsf@laura>
 <20230704094627.GS4253@hirez.programming.kicks-ass.net>
 <87cz13hl7t.fsf@laura>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cz13hl7t.fsf@laura>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 07, 2023 at 10:04:06AM -0400, Olivier Dion wrote:
> On Tue, 04 Jul 2023, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Mon, Jul 03, 2023 at 03:20:31PM -0400, Olivier Dion wrote:
> [...]
> >> On x86-64 (gcc 13.1 -O2) we get:
> >> 
> >>   t0():
> >>           movl    $1, x(%rip)
> >>           movl    $1, %eax
> >>           xchgl   dummy(%rip), %eax
> >>           lock orq $0, (%rsp)       ;; Redundant with previous exchange.
> >>           movl    y(%rip), %eax
> >>           movl    %eax, r0(%rip)
> >>           ret
> >>   t1():
> >>           movl    $1, y(%rip)
> >>           lock orq $0, (%rsp)
> >>           movl    x(%rip), %eax
> >>           movl    %eax, r1(%rip)
> >>           ret
> >
> > So I would expect the compilers to do better here. It should know those
> > __atomic_thread_fence() thingies are superfluous and simply not emit
> > them. This could even be done as a peephole pass later, where it sees
> > consecutive atomic ops and the second being a no-op.
> 
> Indeed, a peephole optimization could work for this Dekker, if the
> compiler adds the pattern for it.  However, AFAIK, a peephole can not be
> applied when the two fences are in different basic blocks.  For example,
> only emitting a fence on a compare_exchange success.  This limitation
> implies that the optimization can not be done across functions/modules
> (shared libraries).

LTO FTW :-)

> For example, it would be interesting to be able to
> promote an acquire fence of a pthread_mutex_lock() to a full fence on
> weakly ordered architectures while preventing a redundant fence on
> strongly ordered architectures.

That's a very non-trivial thing to do. I know Linux has
smp_mb__after_spinlock() and that x86 has it a no-op, but even on x86
adding a full fence after a lock has observable differences IIRC.

Specifically, the actual store that acquires the lock is not well
ordered vs the critical section itself for non-trivial spinlock
implementations (notably qspinlock).

For RCU you mostly care about RCsc locks (IIRC), and upgrading unlock is
a 'simpler' (IMO) approach to achieve that (which is what RCU does with
smp_mb_after_unlock_lock()).

> We know that at least Clang has such peephole optimizations for some
> architecture backends.  It seems however that they do not recognize
> lock-prefixed instructions as fence.

They seem confused in general for emitting MFENCE.

> AFAIK, GCC does not have that kind
> of optimization.

> We are also aware that some research has been done on this topic [0].
> The idea is to use PRE for elimiation of redundant fences.  This would
> work across multiple basic blocks, although the paper focus on
> intra-procedural eliminations.  However, it seems that the latest work
> on that [1] has never been completed [2].
> 
> Our proposed approach provides a mean for the user to express -- and
> document -- the wanted semantic in the source code.  This allows the
> compiler to only emit wanted fences, therefore not relying on
> architecture specific backend optimizations.  In other words, this
> applies even on unoptimized binaries.

I'm not a tool person, but if I were, I'd be very hesitant to add
__builtin functions that 'conflict'/'overlap' with what an optimizer
should be able to do.

Either way around you need work done on the compilers, and I'm thinking
'fixing' the optimizer will benefit far more people than adding
__builtin's.

Then again, I'm not a tools person, so you don't need to convince me.
But one of the selling points of the whole Atomics as a language feature
was that whole optimizer angle. Otherwise you might as well do as we do,
inline asm the world.

I'll shut up now, thanks for that PRE reference [0], that seems a fun
read for when I'm bored.
