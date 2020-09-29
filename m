Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5823027D1EC
	for <lists+linux-arch@lfdr.de>; Tue, 29 Sep 2020 16:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbgI2OyJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Sep 2020 10:54:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:33862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728937AbgI2OyH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 29 Sep 2020 10:54:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601391245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IgDvWNQP8iyuHEvr4G441L71BKSYFJPWhAP8LkzWJfg=;
        b=eoKKMBN7CEGS/O8wpnxX5YX5p7R/6oj0pmjByAZssa/tlgDzObwBIbhZXkZHaNf3yxFnjs
        /xxRgUM/x4iZ6RwvlYDvqSTGjNG6UgIhlOVv1JFsk77ppGGHvo3dx1IKn0uI5+hjhXkchS
        /V0QnFBKAlwY5qjuSlhyF3uziX8+a1k=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CB7CAAD0F;
        Tue, 29 Sep 2020 14:54:04 +0000 (UTC)
Date:   Tue, 29 Sep 2020 16:54:03 +0200
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
Message-ID: <20200929145403.GE2277@dhcp22.suse.cz>
References: <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
 <87bli75t7v.fsf@nanos.tec.linutronix.de>
 <CAHk-=wht7kAeyR5xEW2ORj7m0hibVxZ3t+2ie8vNHLQfdbN2_g@mail.gmail.com>
 <CAKMK7uHAk9-Vy2cof0ws=DrcD52GHiCDiyHbjLd19CgpBU2rKQ@mail.gmail.com>
 <20200916152956.GV29330@paulmck-ThinkPad-P72>
 <CAKMK7uGFyfhEyt=jmdk2jDO-hq0_Pf0ck+cKSELHjr2U3rPuYQ@mail.gmail.com>
 <20200916205840.GD29330@paulmck-ThinkPad-P72>
 <CAKMK7uHL2dMv80b8uBXr=BqHD2TQeODQQM1MGYhAfCYbX7sLrA@mail.gmail.com>
 <20200929081938.GC22035@dhcp22.suse.cz>
 <20200929090003.GG438822@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929090003.GG438822@phenom.ffwll.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue 29-09-20 11:00:03, Daniel Vetter wrote:
> On Tue, Sep 29, 2020 at 10:19:38AM +0200, Michal Hocko wrote:
> > On Wed 16-09-20 23:43:02, Daniel Vetter wrote:
> > > I can
> > > then figure out whether it's better to risk not spotting issues with
> > > call_rcu vs slapping a memalloc_noio_save/restore around all these
> > > critical section which force-degrades any allocation to GFP_ATOMIC at
> > 
> > did you mean memalloc_noreclaim_* here?
> 
> Yeah I picked the wrong one of that family of functions.
> 
> > > most, but has the risk that we run into code that assumes "GFP_KERNEL
> > > never fails for small stuff" and has a decidedly less tested fallback
> > > path than rcu code.
> > 
> > Even if the above then please note that memalloc_noreclaim_* or
> > PF_MEMALLOC should be used with an extreme care. Essentially only for
> > internal memory reclaimers. It grants access to _all_ the available
> > memory so any abuse can be detrimental to the overall system operation.
> > Allocation failure in this mode means that we are out of memory and any
> > code relying on such an allocation has to carefuly consider failure.
> > This is not a random allocation mode.
> 
> Agreed, that's why I don't like having these kind of automagic critical
> sections. It's a bit a shotgun approach. Paul said that the code would
> handle failures, but the problem is that it applies everywhere.

Ohh, in the ideal world we wouldn't need anything like that. But then
the reality fires:
* PF_MEMALLOC (resp memalloc_noreclaim_* for that matter) is primarily used
  to make sure that allocations from inside the memory reclaim - yeah that
  happens - will not recurse.
* PF_MEMALLOC_NO{FS,IO} (resp memalloc_no{fs,io}*) are used to mark no
  fs/io reclaim recursion critical sections because controling that for
  each allocation inside fs transaction (or other sensitive) or IO
  contexts turned out to be unmaintainable and people simply fallen into
  using NOFS/NOIO unconditionally which is causing reclaim imbalance
  problems.
* PF_MEMALLOC_NOCMA (resp memalloc_nocma*) is used for long term pinning
  when CMA pages cannot be pinned because that would break the CMA
  guarantees. Communicating this to all potential allocations during
  pinning is simply unfeasible.

So you are absolutely right that these critical sections with side
effects on all allocations are far from ideal from the API point of view
but they are mostly mirroring a demand for functionality which is
_practically_ impossible to achieve with our current code base. Not that
we couldn't get back to drawing board and come up with a saner thing and
rework the world...
-- 
Michal Hocko
SUSE Labs
