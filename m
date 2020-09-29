Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE2327BF20
	for <lists+linux-arch@lfdr.de>; Tue, 29 Sep 2020 10:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgI2IUM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Sep 2020 04:20:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:60682 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbgI2IUM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 29 Sep 2020 04:20:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601367609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KFyfyEQCS1dcCR4BhfL+zwiQ3CuzyAy4x23tr+VkzjE=;
        b=pr56FUr28WzVjlye8ocfuUATkeSwhUXvbjPgGkEbab2FCVC+0BKyl8PhOHOFpR/zRWD2YJ
        XkENxEAzZ+xaNySUfCCAfperdR1yK017PGgjlx8BHtiTSBrVceVD6B+fvb12QX9yuBiWP6
        UV9FaMEAQthXh0P6zC/B1D/pMFgxjZ8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 981CFB2AE;
        Tue, 29 Sep 2020 08:20:09 +0000 (UTC)
Date:   Tue, 29 Sep 2020 10:20:08 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Segall <bsegall@google.com>, Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-hexagon@vger.kernel.org,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Brian Cain <bcain@codeaurora.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mel Gorman <mgorman@suse.de>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Matt Turner <mattst88@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-xtensa@linux-xtensa.org, Shuah Khan <shuah@kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        linux-um <linux-um@lists.infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 00/13] preempt: Make preempt count unconditional
Message-ID: <20200929081938.GC22035@dhcp22.suse.cz>
References: <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
 <871rj4owfn.fsf@nanos.tec.linutronix.de>
 <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
 <87bli75t7v.fsf@nanos.tec.linutronix.de>
 <CAHk-=wht7kAeyR5xEW2ORj7m0hibVxZ3t+2ie8vNHLQfdbN2_g@mail.gmail.com>
 <CAKMK7uHAk9-Vy2cof0ws=DrcD52GHiCDiyHbjLd19CgpBU2rKQ@mail.gmail.com>
 <20200916152956.GV29330@paulmck-ThinkPad-P72>
 <CAKMK7uGFyfhEyt=jmdk2jDO-hq0_Pf0ck+cKSELHjr2U3rPuYQ@mail.gmail.com>
 <20200916205840.GD29330@paulmck-ThinkPad-P72>
 <CAKMK7uHL2dMv80b8uBXr=BqHD2TQeODQQM1MGYhAfCYbX7sLrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uHL2dMv80b8uBXr=BqHD2TQeODQQM1MGYhAfCYbX7sLrA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed 16-09-20 23:43:02, Daniel Vetter wrote:
> I can
> then figure out whether it's better to risk not spotting issues with
> call_rcu vs slapping a memalloc_noio_save/restore around all these
> critical section which force-degrades any allocation to GFP_ATOMIC at

did you mean memalloc_noreclaim_* here?

> most, but has the risk that we run into code that assumes "GFP_KERNEL
> never fails for small stuff" and has a decidedly less tested fallback
> path than rcu code.

Even if the above then please note that memalloc_noreclaim_* or
PF_MEMALLOC should be used with an extreme care. Essentially only for
internal memory reclaimers. It grants access to _all_ the available
memory so any abuse can be detrimental to the overall system operation.
Allocation failure in this mode means that we are out of memory and any
code relying on such an allocation has to carefuly consider failure.
This is not a random allocation mode.

-- 
Michal Hocko
SUSE Labs
