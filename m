Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19114275379
	for <lists+linux-arch@lfdr.de>; Wed, 23 Sep 2020 10:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgIWImX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Sep 2020 04:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgIWImS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Sep 2020 04:42:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB242C061755;
        Wed, 23 Sep 2020 01:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XUajjvVX4H86jnKIk5XMmvtu2ykOTjeXul3/BJu/hwU=; b=vqx/B66IY6FJeZM3oZmg/+Un+I
        juk4SYQ/onu0T+HuU6X7fOPUIa6l9h67CTBxy3SeH234BxCXwizgdRSm3ioDdv8gF+TwH9O22nczg
        iqTkLZMjcnlPg/CQhzPF7llJEWqzYy/Dtj1pYfU2/xkQ01m00/IofSzmAb4/u67Eqx5ofz6yzA4Jr
        k+ENSw1eHzIn/yXomefawgme8b2QPv9bNql8zuIi3CmNCPYqKCAg5yJhl56cZVRivF4fUyQXVfWDV
        f/qwJzeMoNXuRo68QwZoXhQ3RDUab4cXjbENpYgZ4B+vroJlmNEOdrOdKJLG7gc49cxKVxNJisFa1
        TLPApaFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kL0KM-0004t5-Gu; Wed, 23 Sep 2020 08:40:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A998D300455;
        Wed, 23 Sep 2020 10:40:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A1AD213DCC80; Wed, 23 Sep 2020 10:40:32 +0200 (CEST)
Date:   Wed, 23 Sep 2020 10:40:32 +0200
From:   peterz@infradead.org
To:     Thomas Gleixner <tglx@linutronix.de>
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
Subject: Re: [patch RFC 00/15] mm/highmem: Provide a preemptible variant of
 kmap_atomic & friends
Message-ID: <20200923084032.GU1362448@hirez.programming.kicks-ass.net>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgbbaq0y.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 21, 2020 at 09:27:57PM +0200, Thomas Gleixner wrote:
> On Mon, Sep 21 2020 at 09:24, Linus Torvalds wrote:
> > On Mon, Sep 21, 2020 at 12:39 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >>
> >> If a task is migrated to a different CPU then the mapping address will
> >> change which will explode in colourful ways.
> >
> > Right you are.
> >
> > Maybe we really *could* call this new kmap functionality something
> > like "kmap_percpu()" (or maybe "local" is good enough), and make it
> > act like your RT code does for spinlocks - not disable preemption, but
> > only disabling CPU migration.
> 
> I"m all for it, but the scheduler people have opinions :)

Right, so I'm concerned. migrate_disable() wrecks pretty much all
Real-Time scheduler theory we have, and PREEMPRT_RT bringing it in is
somewhat ironic.

Yes, it allows breaking up non-preemptible regions of non-deterministic
duration, and thereby both reduce and bound the scheduling latency, the
cost for doing that is that the theory on CPU utilization/bandwidth go
out the window.

To easily see this consider an SMP system with a number of tasks equal
to the number of CPUs. On a regular (preempt_disable) kernel we can
always run each task, by virtue of always having an idle CPU to take the
task.

However, with migrate_disable() we can have each task preempted in a
migrate_disable() region, worse we can stack them all on the _same_ CPU
(super ridiculous odds, sure). And then we end up only able to run one
task, with the rest of the CPUs picking their nose.

The end result is that, like with unbounded latency, we will still miss
our deadline, simply because we got starved for CPU.


Now, while we could (with a _lot_ of work) rework the kernel to not rely
on the implicit per-cpu ness of things like spinlock_t, the moment we
bring in basic primitives that rely on migrate_disable() we're stuck
with it.


The problem is; afaict there's been no research into this problem. There
might be scheduling (read: balancing) schemes that can mitigate/solve
this problem, or it might prove to be a 'hard' problem, I just don't
know. But once we start down this road, it's going to be hell to get rid
of it.

That's why I've been arguing (for many years) to strictly limit this to
PREEMPT_RT and only as a gap-stop, not a fundamental primitive to build
on.
