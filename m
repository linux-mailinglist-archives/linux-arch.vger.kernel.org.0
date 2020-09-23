Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F52275809
	for <lists+linux-arch@lfdr.de>; Wed, 23 Sep 2020 14:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgIWMdV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Sep 2020 08:33:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37306 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgIWMdV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Sep 2020 08:33:21 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600864398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4zUEMW9wU+kwouVfGxKhtf6Di/IFhmYOqDGQKAREV8o=;
        b=mQ42gd2DhQ/RG0jBtJb4meJN+5wV2pj9iVLxHpupYAkadW+bY5A7tLe5ML2OCxkUDyFcOz
        1ID+60xXG2OjXRxOxnGUclm3zYFaTcjPF9ahEeidyum940F7pRvQQ+6fARlpRL8arWBYw5
        sXQ3YFT0QLJJsnhzzhPX5pkUAQdcb0r75msvmD5rVzIQdvYOpaNOYhzVgXEW9+SvrTpZ5S
        VYlZevpT0pbNGk2c2vrUKV2OAsLRNBNh2/g0YkvfbfbDyed7rHhHQWMZYKtR79LU83j38G
        5r/WEDgX3y9hgl7i7P9JlU2XJG/6OaMoTDqwD5QZO9LvlKLV3P7ptN62EV3bIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600864398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4zUEMW9wU+kwouVfGxKhtf6Di/IFhmYOqDGQKAREV8o=;
        b=ohpCeECCtFRlt7dpUmuCjEyhCy6FZxCGdV74xdJ5JgvLxUGaba5R+t2Tfw4DYzdeiW9o4A
        74IrdXtsMBTtycCw==
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
In-Reply-To: <20200923101953.GT2674@hirez.programming.kicks-ass.net>
References: <20200919091751.011116649@linutronix.de> <CAHk-=wiYGyrFRbA1cc71D2-nc5U9LM9jUJesXGqpPnB7E4X1YQ@mail.gmail.com> <87mu1lc5mp.fsf@nanos.tec.linutronix.de> <87k0wode9a.fsf@nanos.tec.linutronix.de> <CAHk-=wgbmwsTOKs23Z=71EBTrULoeaH2U3TNqT2atHEWvkBKdw@mail.gmail.com> <87eemwcpnq.fsf@nanos.tec.linutronix.de> <CAHk-=wgF-upZVpqJWK=TK7MS9H-Rp1ZxGfOG+dDW=JThtxAzVQ@mail.gmail.com> <87a6xjd1dw.fsf@nanos.tec.linutronix.de> <CAHk-=wjhxzx3KHHOMvdDj3Aw-_Mk5eRiNTUBB=tFf=vTkw1FeA@mail.gmail.com> <87sgbbaq0y.fsf@nanos.tec.linutronix.de> <20200923101953.GT2674@hirez.programming.kicks-ass.net>
Date:   Wed, 23 Sep 2020 14:33:17 +0200
Message-ID: <87sgb8ad0y.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 23 2020 at 12:19, peterz wrote:
> On Mon, Sep 21, 2020 at 09:27:57PM +0200, Thomas Gleixner wrote:
>> Alternatively this could of course be solved with per CPU page tables
>> which will come around some day anyway I fear.
>
> Previously (with PTI) we looked at making the entire kernel map per-CPU,
> and that takes a 2K copy on switch_mm() (or more general, the user part
> of whatever the top level directory is for architectures that have a
> shared kernel/user page-table setup in the first place).
>
> The idea was having a fixed per-cpu kernel page-table, share a bunch of
> (kernel) page-tables between all CPUs and then copy in the user part on
> switch.
>
> I've forgotten what the plan was for ASID/PCID in that scheme.
>
> For x86_64 we've been fearing the performance of that 2k copy, but I
> don't think we've ever actually bit the bullet and implemented it to see
> how bad it really is.

I actually did at some point and depending on the workload the overhead
was clearly measurable. And yes, it fell apart with PCID and I could not
come up with a scheme for it which did not suck horribly. So I burried
the patches in the poison cabinet.

Aside of that, we'd need to implement that for a eight other
architectures as well...

Thanks,

        tglx

