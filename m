Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0F827731F
	for <lists+linux-arch@lfdr.de>; Thu, 24 Sep 2020 15:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgIXNvp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Sep 2020 09:51:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727835AbgIXNvp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 24 Sep 2020 09:51:45 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7B5D206CD;
        Thu, 24 Sep 2020 13:51:39 +0000 (UTC)
Date:   Thu, 24 Sep 2020 09:51:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        "open list:SYNOPSYS ARC ARCHITECTURE" 
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
Message-ID: <20200924095138.5318d242@oasis.local.home>
In-Reply-To: <20200924124241.GK2628@hirez.programming.kicks-ass.net>
References: <CAHk-=wgF-upZVpqJWK=TK7MS9H-Rp1ZxGfOG+dDW=JThtxAzVQ@mail.gmail.com>
        <87a6xjd1dw.fsf@nanos.tec.linutronix.de>
        <CAHk-=wjhxzx3KHHOMvdDj3Aw-_Mk5eRiNTUBB=tFf=vTkw1FeA@mail.gmail.com>
        <87sgbbaq0y.fsf@nanos.tec.linutronix.de>
        <20200923084032.GU1362448@hirez.programming.kicks-ass.net>
        <20200923115251.7cc63a7e@oasis.local.home>
        <874kno9pr9.fsf@nanos.tec.linutronix.de>
        <20200923171234.0001402d@oasis.local.home>
        <871riracgf.fsf@nanos.tec.linutronix.de>
        <20200924083241.314f2102@gandalf.local.home>
        <20200924124241.GK2628@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 24 Sep 2020 14:42:41 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Sep 24, 2020 at 08:32:41AM -0400, Steven Rostedt wrote:
> > Anyway, instead of blocking. What about having a counter of number of
> > migrate disabled tasks per cpu, and when taking a migrate_disable(), and there's
> > already another task with migrate_disabled() set, and the current task has
> > an affinity greater than 1, it tries to migrate to another CPU?  
> 
> That doesn't solve the problem. On wakeup we should already prefer an
> idle CPU over one running a (RT) task, but you can always wake more
> tasks than there's CPUs around and you'll _have_ to stack at some point.

Yes, understood.

> 
> The trick is how to unstack them correctly. We need to detect when a
> migrate_disable() task _should_ start running again, and migrate away
> whoever is in the way at that point.
> 
> It turns out, that getting selected for pull-balance is exactly that
> condition, and clearly a migrate_disable() task cannot be pulled, but we
> can use that signal to try and pull away the running task that's in the
> way.

Unless of course that running task is in a migrate disable section
itself ;-)

But I guess we will always have that SHC, and there will always be a
scenario that you can't balance properly. But hopefully in practice we
wont see that.

How to handle kmap_local(), will migrate_disable() be used only for
32bit or, for consistency, will it also apply to 64bit?

-- Steve
