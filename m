Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355A129A5BF
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 08:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508066AbgJ0Hry (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 03:47:54 -0400
Received: from casper.infradead.org ([90.155.50.34]:33654 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508023AbgJ0Hry (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Oct 2020 03:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3oTLn60jppEmd2NdwdNgyToAKW6z2EiWKWWF8Pdsajg=; b=ZRPCTz9LYcloesMNvNT9Mq+kuj
        p0Oh8XHRHRx8BZdnNswg9WcV2pwoMtQimTlJscn/L0UFGbz6jgXEZ3LiNjwdObJxIemXF3KFyQOkr
        Z73az4rl1/JCEK3B2E9cr5tGNkdFOz2C5XLedjPpoNiU6irsavjlsbXldu1eETWsY6pzU1TEkE9fG
        rcJg33WkdgjCVKDs0MRyMNqxBo2ljAHLQGFgnCwCxhAEewRTdHFZiy1djhnMYEnE3dFFOgXZYxZDt
        EP3cLjNdFiBxQij/pNydE7eqE1AmClT5JKkBSD13ec5qhSU5wzljaSDKxFvkqHwVm0SbB1bV0xxNi
        lKXcuOww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXJha-0007j8-7G; Tue, 27 Oct 2020 07:47:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 469A53003E1;
        Tue, 27 Oct 2020 08:47:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 34CB02127D318; Tue, 27 Oct 2020 08:47:26 +0100 (CET)
Date:   Tue, 27 Oct 2020 08:47:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qspinlock: use signed temporaries for cmpxchg
Message-ID: <20201027074726.GX2611@hirez.programming.kicks-ass.net>
References: <20201026165807.3724647-1-arnd@kernel.org>
 <022365e9-f7fe-5589-7867-d2ad2d33cfa3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <022365e9-f7fe-5589-7867-d2ad2d33cfa3@redhat.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 26, 2020 at 02:03:06PM -0400, Waiman Long wrote:
> On 10/26/20 12:57 PM, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > When building with W=2, the build log is flooded with
> > 
> > include/asm-generic/qrwlock.h:65:56: warning: pointer targets in passing argument 2 of 'atomic_try_cmpxchg_acquire' differ in signedness [-Wpointer-sign]
> > include/asm-generic/qrwlock.h:92:53: warning: pointer targets in passing argument 2 of 'atomic_try_cmpxchg_acquire' differ in signedness [-Wpointer-sign]
> > include/asm-generic/qspinlock.h:68:55: warning: pointer targets in passing argument 2 of 'atomic_try_cmpxchg_acquire' differ in signedness [-Wpointer-sign]
> > include/asm-generic/qspinlock.h:82:52: warning: pointer targets in passing argument 2 of 'atomic_try_cmpxchg_acquire' differ in signedness [-Wpointer-sign]
> > 
> > The atomics are built on top of signed integers, but the caller
> > doesn't actually care. Just use signed types as well.

Code consistency cares. Fundamentally we're treating it as a u32 here,
using int just because of a confused compiler warning will confuse.

> > @@ -77,7 +77,7 @@ extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
> >    */
> >   static __always_inline void queued_spin_lock(struct qspinlock *lock)
> >   {
> > -	u32 val = 0;
> > +	int val = 0;
> >   	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL)))
> >   		return;

> Yes, it shouldn't really matter if the value is defined as int or u32.
> However, the only caveat that I see is queued_spin_lock_slowpath() is
> expecting a u32 argument. Maybe you should cast it back to (u32) when
> calling it.

No, we're not going to confuse the code. That stuff is hard enough as it
is. This warning is garbage and just needs to stay off.
