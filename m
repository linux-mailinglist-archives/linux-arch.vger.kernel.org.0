Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0C92762EA
	for <lists+linux-arch@lfdr.de>; Wed, 23 Sep 2020 23:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgIWVMl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Sep 2020 17:12:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgIWVMl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Sep 2020 17:12:41 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CA3D2145D;
        Wed, 23 Sep 2020 21:12:35 +0000 (UTC)
Date:   Wed, 23 Sep 2020 17:12:34 -0400
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
Message-ID: <20200923171234.0001402d@oasis.local.home>
In-Reply-To: <874kno9pr9.fsf@nanos.tec.linutronix.de>
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
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 23 Sep 2020 22:55:54 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> > Perhaps make migrate_disable() an anonymous local_lock()?
> >
> > This should lower the SHC in theory, if you can't have stacked migrate
> > disables on the same CPU.  
> 
> I'm pretty sure this ends up in locking hell pretty fast and aside of
> that it's not working for scenarios like:
> 
>      kmap_local();
>        migrate_disable();
>        ...
> 
>      copy_from_user()
>         -> #PF
>            -> schedule()  
> 
> which brought us into that discussion in the first place. You would stop
> any other migrate disable user from running until the page fault is
> resolved...

Then scratch the idea of having anonymous local_lock() and just bring
local_lock in directly? Then have a kmap local lock, which would only
block those that need to do a kmap.

Now as for migration disabled nesting, at least now we would have
groupings of this, and perhaps the theorists can handle that. I mean,
how is this much different that having a bunch of tasks blocked on a
mutex with the owner is pinned on a CPU?

migrate_disable() is a BKL of pinning affinity. If we only have
local_lock() available (even on !RT), then it makes the blocking in
groups. At least this way you could grep for all the different
local_locks in the system and plug that into the algorithm for WCS,
just like one would with a bunch of mutexes.

-- Steve
