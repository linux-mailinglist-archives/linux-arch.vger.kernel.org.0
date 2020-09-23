Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D7127629D
	for <lists+linux-arch@lfdr.de>; Wed, 23 Sep 2020 22:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgIWUz5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Sep 2020 16:55:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40710 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgIWUz5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Sep 2020 16:55:57 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600894555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l2WJ9VY/ovlOeTamqA6hSSk6rkurGuhlcvh+V81qWPQ=;
        b=KMxSh7B9yWMw8PeMibjvvc2K7UOxI4lmPORR16F3qgfamXgPw6W2rNezAEQwEe6OJiYe4H
        KA1VFmz3v9+AAAyGKXqh0V2F00BcNrhxAyYwtww9hIJko06aHPQ0Qs+ySI2L/J2EXxUy++
        CvEgXKPNZfLsjh7NP0EX4EMRBspJVLGoRpGEZGVn28aSQB2FMNShRbroRGx95X5g5CH1z2
        Jmfoo6OzXyLS27oCCIOZJaxYLXmXXqVHJpj66p+awnyn1l9VeiLy2JKTO40uT7ro90AvQj
        BedSnC4tHLgo1VR7G3ERu+f8FeVmrMFkGCEBOb66xrRWFUbPXEpMUqIwQ2qEcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600894555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l2WJ9VY/ovlOeTamqA6hSSk6rkurGuhlcvh+V81qWPQ=;
        b=2urhFSWhq3UaaqI7581rYD0LbsWTkSa2pjmt+peY735+/10gUPHibCgr+piKbh9Xsfbp65
        bVJ9t3cFY/BDWVBQ==
To:     Steven Rostedt <rostedt@goodmis.org>, peterz@infradead.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
In-Reply-To: <20200923115251.7cc63a7e@oasis.local.home>
References: <20200919091751.011116649@linutronix.de> <CAHk-=wiYGyrFRbA1cc71D2-nc5U9LM9jUJesXGqpPnB7E4X1YQ@mail.gmail.com> <87mu1lc5mp.fsf@nanos.tec.linutronix.de> <87k0wode9a.fsf@nanos.tec.linutronix.de> <CAHk-=wgbmwsTOKs23Z=71EBTrULoeaH2U3TNqT2atHEWvkBKdw@mail.gmail.com> <87eemwcpnq.fsf@nanos.tec.linutronix.de> <CAHk-=wgF-upZVpqJWK=TK7MS9H-Rp1ZxGfOG+dDW=JThtxAzVQ@mail.gmail.com> <87a6xjd1dw.fsf@nanos.tec.linutronix.de> <CAHk-=wjhxzx3KHHOMvdDj3Aw-_Mk5eRiNTUBB=tFf=vTkw1FeA@mail.gmail.com> <87sgbbaq0y.fsf@nanos.tec.linutronix.de> <20200923084032.GU1362448@hirez.programming.kicks-ass.net> <20200923115251.7cc63a7e@oasis.local.home>
Date:   Wed, 23 Sep 2020 22:55:54 +0200
Message-ID: <874kno9pr9.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 23 2020 at 11:52, Steven Rostedt wrote:
> On Wed, 23 Sep 2020 10:40:32 +0200
> peterz@infradead.org wrote:
>
>> However, with migrate_disable() we can have each task preempted in a
>> migrate_disable() region, worse we can stack them all on the _same_ CPU
>> (super ridiculous odds, sure). And then we end up only able to run one
>> task, with the rest of the CPUs picking their nose.
>
> What if we just made migrate_disable() a local_lock() available for !RT?
>
> I mean make it a priority inheritance PER CPU lock.
>
> That is, no two tasks could do a migrate_disable() on the same CPU? If
> one task does a migrate_disable() and then gets preempted and the
> preempting task does a migrate_disable() on the same CPU, it will block
> and wait for the first task to do a migrate_enable().
>
> No two tasks on the same CPU could enter the migrate_disable() section
> simultaneously, just like no two tasks could enter a preempt_disable()
> section.
>
> In essence, we just allow local_lock() to be used for both RT and !RT.
>
> Perhaps make migrate_disable() an anonymous local_lock()?
>
> This should lower the SHC in theory, if you can't have stacked migrate
> disables on the same CPU.

I'm pretty sure this ends up in locking hell pretty fast and aside of
that it's not working for scenarios like:

     kmap_local();
       migrate_disable();
       ...

     copy_from_user()
        -> #PF
           -> schedule()

which brought us into that discussion in the first place. You would stop
any other migrate disable user from running until the page fault is
resolved...

Thanks,

        tglx
