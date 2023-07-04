Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CB0746DED
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jul 2023 11:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjGDJrB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jul 2023 05:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjGDJrA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2023 05:47:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC735B5;
        Tue,  4 Jul 2023 02:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FwpevetY3qEoIfFRnsl4wjyTfmQ8ybzfoGFpZ0wcNEw=; b=Ob1q3Yp0F/vKHRXDHBRSDYFMkM
        KZ0jQ0OGEJWwHXE8IyKnqLNZc6NVskS6JGN6JyLgvTxtPrjna9DMHH7e139KwlnR69haN+C0JZETd
        edL3Gxdg3sYChxvULplriLkSCcwS4hjr/WcgQ1ZTO+se6AXcOPIm/asXWmVapcyUJPj1fBg7k/RE0
        QXFXPQZT21fvihLFHEn8gpM4GQ6DL6IQM3bvRQuIr5cY9ZW5svQ4cuZtpcWjqXHXTJbTLqk4CnIBi
        Eyse70yVPsxcfAtrUJp7PPL9ffEWPO41nqgyEsFRonTlwIjzVnRYoHOEbx/lgcCls9hF+NP6O4Xqq
        MFq/HH7g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qGcc9-0091z6-Pk; Tue, 04 Jul 2023 09:46:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 37CD2300023;
        Tue,  4 Jul 2023 11:46:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 052A02028FBD7; Tue,  4 Jul 2023 11:46:27 +0200 (CEST)
Date:   Tue, 4 Jul 2023 11:46:27 +0200
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
Message-ID: <20230704094627.GS4253@hirez.programming.kicks-ass.net>
References: <87ttukdcow.fsf@laura>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttukdcow.fsf@laura>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 03, 2023 at 03:20:31PM -0400, Olivier Dion wrote:

>   int x = 0;
>   int y = 0;
>   int r0, r1;
> 
>   int dummy;
> 
>   void t0(void)
>   {
>           __atomic_store_n(&x, 1, __ATOMIC_RELAXED);
> 
>           __atomic_exchange_n(&dummy, 1, __ATOMIC_SEQ_CST);
>           __atomic_thread_fence(__ATOMIC_SEQ_CST);
> 
>           r0 = __atomic_load_n(&y, __ATOMIC_RELAXED);
>   }
> 
>   void t1(void)
>   {
>           __atomic_store_n(&y, 1, __ATOMIC_RELAXED);
>           __atomic_thread_fence(__ATOMIC_SEQ_CST);
>           r1 = __atomic_load_n(&x, __ATOMIC_RELAXED);
>   }
> 
>   // BUG_ON(r0 == 0 && r1 == 0)
> 
> On x86-64 (gcc 13.1 -O2) we get:
> 
>   t0():
>           movl    $1, x(%rip)
>           movl    $1, %eax
>           xchgl   dummy(%rip), %eax
>           lock orq $0, (%rsp)       ;; Redundant with previous exchange.
>           movl    y(%rip), %eax
>           movl    %eax, r0(%rip)
>           ret
>   t1():
>           movl    $1, y(%rip)
>           lock orq $0, (%rsp)
>           movl    x(%rip), %eax
>           movl    %eax, r1(%rip)
>           ret

So I would expect the compilers to do better here. It should know those
__atomic_thread_fence() thingies are superfluous and simply not emit
them. This could even be done as a peephole pass later, where it sees
consecutive atomic ops and the second being a no-op.

> On x86-64 (clang 16 -O2) we get:
> 
>   t0():
>           movl    $1, x(%rip)
>           movl    $1, %eax
>           xchgl   %eax, dummy(%rip)
>           mfence                    ;; Redundant with previous exchange.

And that's just terrible :/ Nobody should be using MFENCE for this. And
using MFENCE after a LOCK prefixes instruction (implicit in this case)
is just fail, because I don't think C++ atomics cover MMIO and other
such 'lovely' things.

>           movl    y(%rip), %eax
>           movl    %eax, r0(%rip)
>           retq
>   t1():
>           movl    $1, y(%rip)
>           mfence
>           movl    x(%rip), %eax
>           movl    %eax, r1(%rip)
>           retq

