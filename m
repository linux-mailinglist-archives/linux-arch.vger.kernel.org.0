Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A834C26A10C
	for <lists+linux-arch@lfdr.de>; Tue, 15 Sep 2020 10:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIOIjy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Sep 2020 04:39:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40486 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgIOIjx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Sep 2020 04:39:53 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600159189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a15vj77Xa9KXo3Ek21dMycAwDWIIiMUe5bjhvVzzjCs=;
        b=4ZO6BoNleN8HQgP0z8q+4JbOh4PFsXqPl2O1VMMFsqMl6Je+Vd4svU6GjBOnz4JBLm59ef
        n28q3APVdlSA6QtUBbVtHjAsCDNA9DMNxmpB3Xs8JDO2mhj9om6HKXu9jHt5uTY4drNVe+
        Xi88yb65/jAIcWHRrtrHzz6pJv5CkGBo0rMdCdV0m6UGwcjwsaPqQyFAYyPj9eb+iOpbLb
        OyGnJVFkDuM2Xw/Zd91HZnJtSCpZf4n90+HYVnsyWEI2CIiSdIZikeb1E30oqvvQPgJtwy
        7GKY8eCHlWViBl9/zu9LXs5HqsgBdJJ10OMSGETAETJYeANond9fGhpnX7IhVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600159189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a15vj77Xa9KXo3Ek21dMycAwDWIIiMUe5bjhvVzzjCs=;
        b=8ik3d8quF/oYipmw+L5R6EnAKiYsBpkerr1Z3ToGRa9dHoJtFKl9KfoiSlZU5EwJHOK7Qp
        VqVAEKjJfZ9P9ICw==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [patch 00/13] preempt: Make preempt count unconditional
In-Reply-To: <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
References: <20200914204209.256266093@linutronix.de> <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com> <871rj4owfn.fsf@nanos.tec.linutronix.de> <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
Date:   Tue, 15 Sep 2020 10:39:48 +0200
Message-ID: <87bli75t7v.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 14 2020 at 15:24, Linus Torvalds wrote:
> On Mon, Sep 14, 2020 at 2:55 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Yes it does generate better code, but I tried hard to spot a difference
>> in various metrics exposed by perf. It's all in the noise and I only
>> can spot a difference when the actual preemption check after the
>> decrement
>
> I'm somewhat more worried about the small-device case.

I just checked on one of my old UP ARM toys which I run at home. The .text
increase is about 2% (75k) and none of the tests I ran showed any
significant difference. Couldn't verify with perf though as the PMU on
that piece of art is unusable.

> That said, the diffstat certainly has its very clear charm, and I do
> agree that it makes things simpler.
>
> I'm just not convinced people should ever EVER do things like that "if
> (preemptible())" garbage. It sounds like somebody is doing seriously
> bad things.

OTOH, having a working 'preemptible()' or maybe better named
'can_schedule()' check makes tons of sense to make decisions about
allocation modes or other things.

We're currently looking through all of in_atomic(), in_interrupt()
etc. usage sites and quite some of them are historic and have the clear
intent of checking whether the code is called from task context or
hard/softirq context. Lots of them are completely broken or just work by
chance.

But there is clearly historic precendence that context checks are
useful, but they only can be useful if we have a consistent mechanism
which works everywhere.

Of course we could mandate that every interface which might be called
from one or the other context has a context argument or provides two
variants of the same thing. But I'm not really convinced whether that's
a win over having a consistent and reliable set of checks.

Thanks,

        tglx




