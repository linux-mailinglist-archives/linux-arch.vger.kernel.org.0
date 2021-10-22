Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D19A437726
	for <lists+linux-arch@lfdr.de>; Fri, 22 Oct 2021 14:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhJVMf6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Oct 2021 08:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhJVMf4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Oct 2021 08:35:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1177C061764;
        Fri, 22 Oct 2021 05:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+iqfxl1bOnUqQBYQwxlUeaPnvsk9jRCJKtP69+WVQmw=; b=FaAS0eZKYrwXkNRSph0rdnR8sp
        bVG0WLZEfA0LSIUeBcySJUff3gzVVTTxhIfH2fLLEKTjaH0Q9hm+Dh4mRpVo4RMPDXJp+IGH4JOEg
        o41/AyGAW7u/Kn89THveZCo9FyHs5RCpX++HIy19BqU9vbWfoYtqFJ6ufYKSthFABy33u9FB1cuUp
        GCks1N2qn2OS+OiEApHJNXU76IFnjAl+7WDW8lTSDaQ/NynIG0Sgf7Fs/ZDWWXR9u84N+23ztmbp2
        ezhMOMzh7vjymWyloyJkmFgUCYk1q4G3jNkY+RkK7NIyz6bd88mBBU8ctCchAlvGBcV6VO+I2HQTp
        B/8/oDIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdthN-00Dtq7-V5; Fri, 22 Oct 2021 12:31:16 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D67509812EB; Fri, 22 Oct 2021 14:31:00 +0200 (CEST)
Date:   Fri, 22 Oct 2021 14:31:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Christoph =?iso-8859-1?Q?M=FCllner?= <christophm30@gmail.com>,
        Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH] locking: Generic ticket lock
Message-ID: <20211022123100.GZ174703@worktop.programming.kicks-ass.net>
References: <YXFli3mzMishRpEq@hirez.programming.kicks-ass.net>
 <YXKC9qh+evVmUuLI@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXKC9qh+evVmUuLI@FVFF77S0Q05N>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 22, 2021 at 10:23:02AM +0100, Mark Rutland wrote:
> Hi Peter,
> 
> On Thu, Oct 21, 2021 at 03:05:15PM +0200, Peter Zijlstra wrote:
> > +static __always_inline void ticket_lock(arch_spinlock_t *lock)
> > +{
> > +	u32 val = atomic_fetch_add_acquire(ONE_TICKET, lock);
> 
> I wonder, should these atomics be arch_atomic_*(), in case an arch_ or raw_
> lock is used in noinstr code? The plain atomic_*() forms can have explicit
> inline instrumentation.
> 
> I haven't seen any issues with qspinlock so far, and that also uses the
> (instrumented) atomics, so maybe that's not actually a problem, but I'm not
> sure what we intend here w.r.t.  instrumentability.

So far it's not been a problem, and as you say, if we want to change
this, we need a larger audit/cleanup.

IIRC there's a potential problem in the arm idle code (noinstr'ing the
idle code is still on the TODO list somewhre, hampered by the need to
create more tooling).
