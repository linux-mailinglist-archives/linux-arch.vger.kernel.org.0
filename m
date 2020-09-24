Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB7427710F
	for <lists+linux-arch@lfdr.de>; Thu, 24 Sep 2020 14:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgIXMct (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Sep 2020 08:32:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbgIXMcs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 24 Sep 2020 08:32:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E4EA205F4;
        Thu, 24 Sep 2020 12:32:43 +0000 (UTC)
Date:   Thu, 24 Sep 2020 08:32:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
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
Subject: Re: [patch RFC 00/15] mm/highmem: Provide a preemptible variant of
 kmap_atomic & friends
Message-ID: <20200924083241.314f2102@gandalf.local.home>
In-Reply-To: <871riracgf.fsf@nanos.tec.linutronix.de>
References: <20200919091751.011116649@linutronix.de>
        <CAHk-=wiYGyrFRbA1cc71D2-nc5U9LM9jUJesXGqpPnB7E4X1YQ@mail.gmail.com>
        <87mu1lc5mp.fsf@nanos.tec.linutronix.de>
        <87k0wode9a.fsf@nanos.tec.linutronix.de>
        <CAHk-=wgbmwsTOKs23Z=71EBTrULoeaH2U3TNqT2atHEWvkBKdw@mail.gmail.com>
        <87eemwcpnq.fsf@nanos.tec.linutronix.de>
        <CAHk-=wgF-upZVpqJWK=TK7MS9H-Rp1ZxGfOG+dDW=JThtxAzVQ@mail.gmail.com>
        <87a6xjd1dw.fsf@nanos.tec.linutronix.de>
        <CAHk-=wjhxzx3KHHOMvdDj3Aw-_Mk5eRiNTUBB=tFf=vTkw1FeA@mail.gmail.com>
        <87sgbbaq0y.fsf@nanos.tec.linutronix.de>
        <20200923084032.GU1362448@hirez.programming.kicks-ass.net>
        <20200923115251.7cc63a7e@oasis.local.home>
        <874kno9pr9.fsf@nanos.tec.linutronix.de>
        <20200923171234.0001402d@oasis.local.home>
        <871riracgf.fsf@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 24 Sep 2020 08:57:52 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> > Now as for migration disabled nesting, at least now we would have
> > groupings of this, and perhaps the theorists can handle that. I mean,
> > how is this much different that having a bunch of tasks blocked on a
> > mutex with the owner is pinned on a CPU?
> >
> > migrate_disable() is a BKL of pinning affinity.  
> 
> No. That's just wrong. preempt disable is a concurrency control,

I think you totally misunderstood what I was saying. The above wasn't about
comparing preempt_disable to migrate_disable. It was comparing
migrate_disable to a chain of tasks blocked on mutexes where the top owner
has preempt_disable set. You still have a bunch of tasks that can't move to
other CPUs.


> > If we only have local_lock() available (even on !RT), then it makes
> > the blocking in groups. At least this way you could grep for all the
> > different local_locks in the system and plug that into the algorithm
> > for WCS, just like one would with a bunch of mutexes.  
> 
> You cannot do that on RT at all where migrate disable is substituting
> preempt disable in spin and rw locks. The result would be the same as
> with a !RT kernel just with horribly bad performance.

Note, the spin and rwlocks already have a lock associated with them. Why
would it be any different on RT? I wasn't suggesting adding another lock
inside a spinlock. Why would I recommend THAT? I wasn't recommending
blindly replacing migrate_disable() with local_lock(). I just meant expose
local_lock() but not migrate_disable().

> 
> That means the stacking problem has to be solved anyway.
> 
> So why on earth do you want to create yet another special duct tape case
> for kamp_local() which proliferates inconsistency instead of aiming for
> consistency accross all preemption models?

The idea was to help with the scheduling issue.

Anyway, instead of blocking. What about having a counter of number of
migrate disabled tasks per cpu, and when taking a migrate_disable(), and there's
already another task with migrate_disabled() set, and the current task has
an affinity greater than 1, it tries to migrate to another CPU?

This way migrate_disable() is less likely to have a bunch of tasks blocked
on one CPU serialized by each task exiting the migrate_disable() section.

Yes, there's more overhead, but it only happens if multiple tasks are in a
migrate disable section on the same CPU.

-- Steve

