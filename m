Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672B24374A8
	for <lists+linux-arch@lfdr.de>; Fri, 22 Oct 2021 11:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhJVJZZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Oct 2021 05:25:25 -0400
Received: from foss.arm.com ([217.140.110.172]:51928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231563AbhJVJZY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Oct 2021 05:25:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46697ED1;
        Fri, 22 Oct 2021 02:23:07 -0700 (PDT)
Received: from FVFF77S0Q05N (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20CC63F70D;
        Fri, 22 Oct 2021 02:23:05 -0700 (PDT)
Date:   Fri, 22 Oct 2021 10:23:02 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Christoph =?utf-8?Q?M=C3=BCllner?= <christophm30@gmail.com>,
        Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH] locking: Generic ticket lock
Message-ID: <YXKC9qh+evVmUuLI@FVFF77S0Q05N>
References: <YXFli3mzMishRpEq@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXFli3mzMishRpEq@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Peter,

On Thu, Oct 21, 2021 at 03:05:15PM +0200, Peter Zijlstra wrote:
> +static __always_inline void ticket_lock(arch_spinlock_t *lock)
> +{
> +	u32 val = atomic_fetch_add_acquire(ONE_TICKET, lock);

I wonder, should these atomics be arch_atomic_*(), in case an arch_ or raw_
lock is used in noinstr code? The plain atomic_*() forms can have explicit
inline instrumentation.

I haven't seen any issues with qspinlock so far, and that also uses the
(instrumented) atomics, so maybe that's not actually a problem, but I'm not
sure what we intend here w.r.t.  instrumentability.

Thanks,
Mark.
