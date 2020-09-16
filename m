Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0246E26CC75
	for <lists+linux-arch@lfdr.de>; Wed, 16 Sep 2020 22:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgIPUoE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Sep 2020 16:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728562AbgIPUoC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Sep 2020 16:44:02 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FF7621D7D;
        Wed, 16 Sep 2020 20:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600289039;
        bh=MM/OYkhIqW+q1jlzGplM7TRGk23CKIsPg/gtHCbpw/s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ePzv3fwWqslNC9hLhuqpPOyt/s8elqT4skklSXCKPyGt5+DSX45Mij1jR0UQAfYSu
         rlP0OmdNpXpvof5fQPOx2SpQZrxcPIGOMObx61mSVBfXvuGrzip0wCyXdOZekUurt/
         goh6RQLFx9+QF+bnlf7qV2Wg9jJz35j9g42ob9HA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 14CC43522BA0; Wed, 16 Sep 2020 13:43:59 -0700 (PDT)
Date:   Wed, 16 Sep 2020 13:43:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
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
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [patch 00/13] preempt: Make preempt count unconditional
Message-ID: <20200916204359.GB29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200914204209.256266093@linutronix.de>
 <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
 <871rj4owfn.fsf@nanos.tec.linutronix.de>
 <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
 <87bli75t7v.fsf@nanos.tec.linutronix.de>
 <CAHk-=wht7kAeyR5xEW2ORj7m0hibVxZ3t+2ie8vNHLQfdbN2_g@mail.gmail.com>
 <CAKMK7uHAk9-Vy2cof0ws=DrcD52GHiCDiyHbjLd19CgpBU2rKQ@mail.gmail.com>
 <20200916152956.GV29330@paulmck-ThinkPad-P72>
 <CAHk-=wjsMycgMHJrCmeetR3r+K5bpSRtmVWfd8iaoQCYd_VYAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjsMycgMHJrCmeetR3r+K5bpSRtmVWfd8iaoQCYd_VYAg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 16, 2020 at 11:32:00AM -0700, Linus Torvalds wrote:
> On Wed, Sep 16, 2020 at 8:29 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > All fair, but some of us need to write code that must handle being
> > invoked from a wide variety of contexts.
> 
> Note that I think that core functionality is different from random drivers.
> 
> Of course core code can (and will) look at things like
> 
>         if (in_interrupt())
>             .. schedule work asynchronously ..
> 
> because core code ends up being called from odd places, and code like
> that is expected to have understanding of the rules it plays with.
> 
> But something like RCU is a very different beast from some "walk the
> scatter-gather list" code.
> 
> RCU does its work in the background, and works with lots of different
> things. And it's so core and used everywhere that it knows about these
> things. I mean, we literally have special code explicitly to let RCU
> know "we entered kernel context now".
> 
> But something like a driver list walking thing should not be doing
> different things behind peoples back depending on whether they hold
> spinlocks or not. It should either just work regardless, or there
> should be a flag (or special interface) for the "you're being called
> in a crtitical region".
> 
> Because dynamically changing behavior really is very confusing.

Whew!  I feel much better now.  ;-)

							Thanx, Paul
