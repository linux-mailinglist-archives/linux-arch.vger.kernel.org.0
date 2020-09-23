Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249802758D7
	for <lists+linux-arch@lfdr.de>; Wed, 23 Sep 2020 15:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgIWNf5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Sep 2020 09:35:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37712 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWNf4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Sep 2020 09:35:56 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600868152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sQi8lZPkv33+2/p+CxEr9K+rfH1Bs0rDvL8F8tfBhFM=;
        b=hb9E+fGbYyw9hvwyuwWM5aRsnhQZbpwkXik+PBbS9GmRNPaEQzDG2cas3gsgGMI/WqcOgS
        fzq1pqwEssy4yQFNCOYopo/e6I6jqzzZ4/sCJexHt/8fEprytMHFGaMU02dXYOBLgdkUgL
        Ersq8pwIzxU83Z+Lnw2OTTDxn4eDleCVSMd1vext49huWceSLfCZht2xC3ZtNhkANl7Ot/
        SVxZ2XAQzZwFf5mjt/d8lr3db+PL5Yzj4qA7Tij8EewuBMC7eY/3tZzMEuUPieoxSXXFsl
        1/cA0sdEQ5mELiFAqkhL4mvqLWDQUGjcscHh4gzy8DesABDK4kf+8a+fZno/OA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600868152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sQi8lZPkv33+2/p+CxEr9K+rfH1Bs0rDvL8F8tfBhFM=;
        b=y8RA9Mp+iOMW8NAuIAQx5KwO92xGItjHMxSGsmGMHVaYsVtr0nXOezo7T+MTtRUT9KlaF2
        bd7Z3u4QE1LVBqCQ==
To:     peterz@infradead.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
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
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Vineet Gupta <vgupta@synopsys.com>,
        "open list\:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-sparc <sparclinux@vger.kernel.org>
Subject: Re: [patch RFC 00/15] mm/highmem: Provide a preemptible variant of kmap_atomic & friends
In-Reply-To: <20200923084032.GU1362448@hirez.programming.kicks-ass.net>
References: <20200919091751.011116649@linutronix.de> <CAHk-=wiYGyrFRbA1cc71D2-nc5U9LM9jUJesXGqpPnB7E4X1YQ@mail.gmail.com> <87mu1lc5mp.fsf@nanos.tec.linutronix.de> <87k0wode9a.fsf@nanos.tec.linutronix.de> <CAHk-=wgbmwsTOKs23Z=71EBTrULoeaH2U3TNqT2atHEWvkBKdw@mail.gmail.com> <87eemwcpnq.fsf@nanos.tec.linutronix.de> <CAHk-=wgF-upZVpqJWK=TK7MS9H-Rp1ZxGfOG+dDW=JThtxAzVQ@mail.gmail.com> <87a6xjd1dw.fsf@nanos.tec.linutronix.de> <CAHk-=wjhxzx3KHHOMvdDj3Aw-_Mk5eRiNTUBB=tFf=vTkw1FeA@mail.gmail.com> <87sgbbaq0y.fsf@nanos.tec.linutronix.de> <20200923084032.GU1362448@hirez.programming.kicks-ass.net>
Date:   Wed, 23 Sep 2020 15:35:52 +0200
Message-ID: <87imc4aa4n.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 23 2020 at 10:40, peterz wrote:
> Right, so I'm concerned. migrate_disable() wrecks pretty much all
> Real-Time scheduler theory we have, and PREEMPRT_RT bringing it in is
> somewhat ironic.

It's even more ironic that the approach of PREEMPT_RT has been
'pragmatic ignorance of theory' from the very beginning and despite
violating all theories it still works. :)

> Yes, it allows breaking up non-preemptible regions of non-deterministic
> duration, and thereby both reduce and bound the scheduling latency, the
> cost for doing that is that the theory on CPU utilization/bandwidth go
> out the window.

I agree, that the theory goes out of the window, but does it matter in
practice? I've yet to see a report of migrate disable stacking being the
culprit of a missed deadline and I surely have stared at lots of reports
in the past 10+ years.

> To easily see this consider an SMP system with a number of tasks equal
> to the number of CPUs. On a regular (preempt_disable) kernel we can
> always run each task, by virtue of always having an idle CPU to take the
> task.
>
> However, with migrate_disable() we can have each task preempted in a
> migrate_disable() region, worse we can stack them all on the _same_ CPU
> (super ridiculous odds, sure). And then we end up only able to run one
> task, with the rest of the CPUs picking their nose.
>
> The end result is that, like with unbounded latency, we will still miss
> our deadline, simply because we got starved for CPU.

I'm well aware of that.

> Now, while we could (with a _lot_ of work) rework the kernel to not rely
> on the implicit per-cpu ness of things like spinlock_t, the moment we
> bring in basic primitives that rely on migrate_disable() we're stuck
> with it.

Right, but we are stuck with per CPUness and distangling that is just
infeasible IMO.

> The problem is; afaict there's been no research into this problem.

There is no research on a lot of things the kernel does :)

> There might be scheduling (read: balancing) schemes that can
> mitigate/solve this problem, or it might prove to be a 'hard' problem,
> I just don't know.

In practive balancing surely can take the number of preempted tasks
which are in a migrate disable section into account which would be just
another measure to work around the fact that the kernel is not adhering
to the theories. It never did that even w/o migrate disable.

> But once we start down this road, it's going to be hell to get rid of
> it.

Like most of the other things the kernel came up with to deal with the
oddities of modern hardware :)

> That's why I've been arguing (for many years) to strictly limit this to
> PREEMPT_RT and only as a gap-stop, not a fundamental primitive to build
> on.

I know, but short of rewriting the world, I'm not seing the faintest
plan to remove the stop gap. :)

As we discussed not long ago we have too many inconsistent preemption
models already. RT is adding yet another one. And that's worse than
introducing migrate disable as a general available facility.

IMO, reaching a point of consistency where our different preemption
models (NONE, VOLUNTARY, PREEMPT. RT) build on each other is far more
important.

For !RT migrate disable is far less of an danger than for RT kernels
because the amount of code which will use it is rather limited compared
to code which still will disable preemption implicit through spin and rw
locks.

On RT converting these locks to 'sleepable spinlocks' is just possible
because RT forces almost everything into task context and migrate
disable is just the obvious decomposition of preempt disable which
implicitely disables migration.

But that means that RT is by orders of magnitude more prone to run into
the scheduling trainwreck you are worried about. It just refuses to do
so at least with real world work loads.

I'm surely in favour of having solid theories behind implementation, but
at some point you just have to bite the bullet and chose pragmatism in
order to make progress.

Proliferating inconsistency is not real progress, as it is violating the
most fundamental engineering principles. That's by far more dangerous
than violating scheduling theories which are built on perfect models and
therefore enforce violation by practical implementations anyway.

Thanks,

        tglx
