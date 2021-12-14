Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63C74746AF
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 16:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhLNPlJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 10:41:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54830 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbhLNPlE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 10:41:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2219061360;
        Tue, 14 Dec 2021 15:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230C9C34604;
        Tue, 14 Dec 2021 15:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639496463;
        bh=i8FKSIqV2eS4/ooZi6RLJpb4SBS7G50iXyqn/X4rmJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XYcMg4PyGtpbadSWa/qigudm/9GoS7I0mBQYuYwo41UHhowzQgi1ASsKvCUHGDy2Y
         8pmW7iAznCKiuGXKXSvYhLF75OMuyZivPxnra1Fn5McTzyaP2zmbzpNW+AnhV/KdnZ
         XD0K0BVDRz2u5+hBueF7QjCahrYoBLPhz1EdtylFiAXp9FSZR4HvonxgmeQ4xVeQyd
         krXOVIcn/kO+MnsLdE6yFp96sD+9zLeiwkGjv81O6DZFYwclHAuA4MFjBs+wxDYt5p
         yc4xPu7GwmkLokjyC3/J/8CTxypeP0YhU4yLvvRg49/cwTQYaSo854/Yayb0unQjvW
         a55fXoSP9NX/g==
Date:   Tue, 14 Dec 2021 15:40:57 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Christoph =?iso-8859-1?Q?M=FCllner?= <christophm30@gmail.com>,
        Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH] locking: Generic ticket lock
Message-ID: <20211214154057.GB15416@willie-the-truck>
References: <YXFli3mzMishRpEq@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXFli3mzMishRpEq@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 21, 2021 at 03:05:15PM +0200, Peter Zijlstra wrote:
> 
> There's currently a number of architectures that want/have graduated
> from test-and-set locks and are looking at qspinlock.
> 
> *HOWEVER* qspinlock is very complicated and requires a lot of an
> architecture to actually work correctly. Specifically it requires
> forward progress between a fair number of atomic primitives, including
> an xchg16 operation, which I've seen a fair number of fundamentally
> broken implementations of in the tree (specifically for qspinlock no
> less).
> 
> The benefit of qspinlock over ticket lock is also non-obvious, esp.
> at low contention (the vast majority of cases in the kernel), and it
> takes a fairly large number of CPUs (typically also NUMA) to make
> qspinlock beat ticket locks.
> 
> Esp. things like ARM64's WFE can move the balance a lot in favour of
> simpler locks by reducing the cacheline pressure due to waiters (see
> their smp_cond_load_acquire() implementation for details).
> 
> Unless you've audited qspinlock for your architecture and found it
> sound *and* can show actual benefit, simpler is better.
> 
> Therefore provide ticket locks, which depend on a single atomic
> operation (fetch_add) while still providing fairness.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/asm-generic/qspinlock.h         |   30 +++++++++
>  include/asm-generic/ticket_lock_types.h |   11 +++
>  include/asm-generic/ticket_lock.h       |   97 ++++++++++++++++++++++++++++++++
>  3 files changed, 138 insertions(+)

Huh. I looked quite closely at this a while back but seems like I forgot to
actually reply here. So, given that it doesn't seem to be in linux-next yet:

Acked-by: Will Deacon <will@kernel.org>

Will
