Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A63F3B67ED
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jun 2021 19:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhF1Rr6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 13:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbhF1Rr6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jun 2021 13:47:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A826C061574;
        Mon, 28 Jun 2021 10:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wnF6ygE3BEKF+lX8atfhFJ5A2+kLhgDPuQhHnJimzGI=; b=k772z4bHFtUoC+RYLp9jsZU8VX
        lGk3HzWc1f6BaTm8BWsNXPJIPvJ5aQk+6pDaYN79RC1o6JKKVhIpLvzNiwYpCxEne3pDHtrFpdTqK
        KoVbXBeeTHKpToY8nNip3zjuLl/2mRR6h1YLJoC/U9DC+nWuYKjRwFzjnOBHhjTPGXQOwxB3ETdME
        S6wiimB+btHEBhlSOChTBGWudfOWUUIyDKvvAIrad0v3552LgRxRlvsik8FqBoWSxX85Qo0SpdP2t
        GwzbeMGYJZZ0Mg7IUhrP37x8qNyJpP7j/Dbsd+KTA0CGrgt2qLKkLPgvGBaQdcjawyC4JhCRwqyWK
        QNXiZivQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxvIT-003InL-Pm; Mon, 28 Jun 2021 17:43:57 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F61C982D9E; Mon, 28 Jun 2021 19:43:48 +0200 (CEST)
Date:   Mon, 28 Jun 2021 19:43:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thiago Macieira <thiago.macieira@intel.com>
Cc:     fweimer@redhat.com,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        hjl.tools@gmail.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org
Subject: Re: x86 CPU features detection for applications (and AMX)
Message-ID: <20210628174347.GB13401@worktop.programming.kicks-ass.net>
References: <22261946.eFiGugXE7Z@tjmaciei-mobl1>
 <2379132.fg5cGID6mU@tjmaciei-mobl1>
 <YNnqXCSVUhYhzT6T@hirez.programming.kicks-ass.net>
 <2094802.S4rhTtsRBG@tjmaciei-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2094802.S4rhTtsRBG@tjmaciei-mobl1>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 28, 2021 at 09:13:29AM -0700, Thiago Macieira wrote:

> Anyway, what's the current thinking on what the arch_prctl() should be? Is 
> that a per-thread state or will it affect the entire process group? And is it 
> a sticky functionality, or are we talking about ref/deref?

So I didn't follow the initial discussion too well; so I might be
getting this wrong. In which case I'm hoping Thomas and/or Andy will
correct me.

But I think the proposal was per process. Having this per thread would
be really unfortunate IMO.

> Maybe in order to answer that, we need to understand what the worst case 
> scenario we need to support is. What are they?
> 
> 1) alt-stack signal handlers, usually for crashing signals (to catch a stack 
> overflow)
> 
> 2) cooperative user-space task schedulers, e.g. coroutines
> 
> 3) preemptive user-space task schedulers (I don't know if such software exists 
> or even if it is possible)

I think it's been done; use sigsetmask()/pthread_sigmask() as 'IRQ'
disable, and run a preemption tick off of SIGALRM or something.

> 4) combination of 1 and 3

None of those I think. The worst case is old executables using
MINSIGSTKSZ and not using the magic signal context at all, just regular
old signals. If you run them on an AVX512 enabled machine, they overflow
their stack and cause memory corruption.

AFAICT the only feasible way forward with that is some sysctl which
default disables AVX512 and add the prctl() and have some unsafe wrapper
that enables AVX512 for select 'legacy' programs for as long as they
exist :/

That is, binaries/libraries compiled against a static (and small)
MINSIGSTKSZ are the enemy. Which brings us to:

> 5) #4, in which each part is comes from a separate library with no knowledge 
> of each other, and initialised concurrently in different threads

That's terrible... library init should *NEVER* spawn threads (I know,
don't start).

Anything that does this is basically unfixable, because we can't
guarantee the AMX prctl() gets done before the first thread.

So yes, worst case I suppose...
