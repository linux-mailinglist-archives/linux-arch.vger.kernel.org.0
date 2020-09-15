Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D93C26AA9C
	for <lists+linux-arch@lfdr.de>; Tue, 15 Sep 2020 19:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgIOR26 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Sep 2020 13:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbgIOR1G (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Sep 2020 13:27:06 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC9D520678;
        Tue, 15 Sep 2020 17:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600190751;
        bh=zAnK9MdJHBLYi0RM5uCLYkcfWnZYrpv2oBo/jSvr9uY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ykvmjz+uTRDK4muYb7ZaU4DA//3YkvSNNe72xuNxHLx5WYlF6vS8rMYi7/p95sA0e
         ZPdUkNpigzrHNbl4M/6ZTzpu5fGsQWXGQS5l9WSBuK+ES7WGVLX9Rtn/w5xojTk3HA
         SqvN6NXO/B4lR6nWQIM4LgYias8O7Oiya2Sq1o2E=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B8FC535226B7; Tue, 15 Sep 2020 10:25:50 -0700 (PDT)
Date:   Tue, 15 Sep 2020 10:25:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um <linux-um@lists.infradead.org>,
        Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [patch 00/13] preempt: Make preempt count unconditional
Message-ID: <20200915172550.GO29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200914204209.256266093@linutronix.de>
 <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 14, 2020 at 01:59:15PM -0700, Linus Torvalds wrote:
> On Mon, Sep 14, 2020 at 1:45 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Recently merged code does:
> >
> >          gfp = preemptible() ? GFP_KERNEL : GFP_ATOMIC;
> >
> > Looks obviously correct, except for the fact that preemptible() is
> > unconditionally false for CONFIF_PREEMPT_COUNT=n, i.e. all allocations in
> > that code use GFP_ATOMIC on such kernels.
> 
> I don't think this is a good reason to entirely get rid of the no-preempt thing.
> 
> The above is just garbage. It's bogus. You can't do it.
> 
> Blaming the no-preempt code for this bug is extremely unfair, imho.
> 
> And the no-preempt code does help make for much better code generation
> for simple spinlocks.
> 
> Where is that horribly buggy recent code? It's not in that exact
> format, certainly, since 'grep' doesn't find it.

It would be convenient for that "gfp =" code to work, as this would
allow better cache locality while invoking RCU callbacks, and would
further provide better robustness to callback floods.  The full story
is quite long, but here are alternatives have not yet been proven to be
abject failures:

1.	Use workqueues to do the allocations in a clean context.
	While waiting for the allocations, the callbacks are queued
	in the old cache-busting manner.  This functions correctly,
	but in the meantime (which on busy systems can be some time)
	the cache locality and robustness are lost.

2.	Provide the ability to allocate memory in raw atomic context.
	This is extremely effective, especially when used in combination
	with #1 above, but as you might suspect, the MM guys don't like
	it much.

In contrast, with Thomas's patch series, call_rcu() and kvfree_rcu()
could just look at preemptible() to see whether or not it was safe to
allocate memory, even in !PREEMPT kernels -- and in the common case,
it almost always would be safe.  It is quite possible that this approach
would work in isolation, or failing that, that adding #1 above would do
the trick.

I understand that this is all very hand-wavy, and I do apologize for that.
If you really want the full sad story with performance numbers and the
works, let me know!

							Thanx, Paul
