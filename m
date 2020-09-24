Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BB02769D7
	for <lists+linux-arch@lfdr.de>; Thu, 24 Sep 2020 08:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgIXG5z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Sep 2020 02:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgIXG5y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Sep 2020 02:57:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E880C0613CE;
        Wed, 23 Sep 2020 23:57:54 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600930672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5rTYnFSI7MvYdctqS1tc/c91OuHk2uQv9NNDSCQ04XQ=;
        b=ToSaPZLxQ2AH6wpji2/x8TcisM3A51I/7u6foK9kSTrf7OV6+B/sYvPqQhMtEJrg0N9zIx
        Cxs2etUyPDaehZQCOzhxH7PpvSyJSfy+zT5nw6FTVB78t6JNp7mDPmryw8BrJtWSznRbjf
        8WXrnLC1goQovtz1OVkxeDIie+039a2C5Ao2dLue3fpVFSN5R/cBi6m5tXzS9aMxE6UJwX
        Uwp2HtahcdV3lHGQhtB2rKe1baF/Au/D2y5x0sKC4vrpIL/XuoPxLZOPdKWgIlvAl5aFPa
        sm2IQ31/n393ddHyPDhkeJ4Ev5cXAXShQDmJK93cRSzGvYG6PFna1CfbOLLbSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600930672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5rTYnFSI7MvYdctqS1tc/c91OuHk2uQv9NNDSCQ04XQ=;
        b=EvF/NhfcVha3UwOSEREyL46c1SondfygAd7QtbHcK6NXwedthX3cPGyjT7D4JChbCJd2jo
        pNgVY6bwfByW4sDA==
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     peterz@infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
In-Reply-To: <20200923171234.0001402d@oasis.local.home>
References: <20200919091751.011116649@linutronix.de> <CAHk-=wiYGyrFRbA1cc71D2-nc5U9LM9jUJesXGqpPnB7E4X1YQ@mail.gmail.com> <87mu1lc5mp.fsf@nanos.tec.linutronix.de> <87k0wode9a.fsf@nanos.tec.linutronix.de> <CAHk-=wgbmwsTOKs23Z=71EBTrULoeaH2U3TNqT2atHEWvkBKdw@mail.gmail.com> <87eemwcpnq.fsf@nanos.tec.linutronix.de> <CAHk-=wgF-upZVpqJWK=TK7MS9H-Rp1ZxGfOG+dDW=JThtxAzVQ@mail.gmail.com> <87a6xjd1dw.fsf@nanos.tec.linutronix.de> <CAHk-=wjhxzx3KHHOMvdDj3Aw-_Mk5eRiNTUBB=tFf=vTkw1FeA@mail.gmail.com> <87sgbbaq0y.fsf@nanos.tec.linutronix.de> <20200923084032.GU1362448@hirez.programming.kicks-ass.net> <20200923115251.7cc63a7e@oasis.local.home> <874kno9pr9.fsf@nanos.tec.linutronix.de> <20200923171234.0001402d@oasis.local.home>
Date:   Thu, 24 Sep 2020 08:57:52 +0200
Message-ID: <871riracgf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 23 2020 at 17:12, Steven Rostedt wrote:
> On Wed, 23 Sep 2020 22:55:54 +0200
> Then scratch the idea of having anonymous local_lock() and just bring
> local_lock in directly? Then have a kmap local lock, which would only
> block those that need to do a kmap.

That's still going to end up in lock ordering nightmares and you lose
the ability to use kmap_local from arbitrary contexts which was again
one of the goals of this exercise.

Aside of that you're imposing reentrancy protections on something which
does not need it in the first place.

> Now as for migration disabled nesting, at least now we would have
> groupings of this, and perhaps the theorists can handle that. I mean,
> how is this much different that having a bunch of tasks blocked on a
> mutex with the owner is pinned on a CPU?
>
> migrate_disable() is a BKL of pinning affinity.

No. That's just wrong. preempt disable is a concurrency control,
i.e. protecting against reentrancy on a given CPU. But it's a cpu global
protection which means that it's not protecting a specific code path.

Contrary to preempt disable, migrate disable is not protecting against
reentrancy on a given CPU. It's a temporary restriction to the scheduler
on placement.

The fact that disabling preemption implicitely disables migration does
not make them semantically equivalent.

> If we only have local_lock() available (even on !RT), then it makes
> the blocking in groups. At least this way you could grep for all the
> different local_locks in the system and plug that into the algorithm
> for WCS, just like one would with a bunch of mutexes.

You cannot do that on RT at all where migrate disable is substituting
preempt disable in spin and rw locks. The result would be the same as
with a !RT kernel just with horribly bad performance.

That means the stacking problem has to be solved anyway.

So why on earth do you want to create yet another special duct tape case
for kamp_local() which proliferates inconsistency instead of aiming for
consistency accross all preemption models?

Thanks,

        tglx
