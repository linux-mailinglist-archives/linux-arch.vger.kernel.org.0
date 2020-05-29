Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390FE1E8861
	for <lists+linux-arch@lfdr.de>; Fri, 29 May 2020 22:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgE2UCF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 May 2020 16:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgE2UCE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 May 2020 16:02:04 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703F1C03E969;
        Fri, 29 May 2020 13:02:04 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id l3so1662356qvo.7;
        Fri, 29 May 2020 13:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zRCoyWjfliwC5Lr3BREGwZWFPF0dfO/LEpefmnrOEJA=;
        b=rJp4Zrx4kyrYS4mcjp7vSwXUoo8znvD5mUspBF0c5pM0TvYMiBoFFsJxDqqSg3Li8z
         Hg2lwTOXuM+kcuhBT2WRy4Oiu+4ex4SUu6OBN0vYF/Sur6vK8301YSWCdiqJMTeeur5r
         zkzA0QM/tgBObz4BlsT/XIknLBC3XvUEChgwomNqAZ/nTLZfqHaXwIVO3JInL0tBBGLp
         P+15UUif6RTF+KPa+x7HowWXDJY2E7lYBeckzS4l1EcMi8Plbj+PgJngqocCjOBB68aK
         Z0bDw0naay3HbqTOITPCGaLDWvm0EdIi8gC2GVQQQFb9aqIwfjMhnDU+XSeNuiK4I0hF
         L+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zRCoyWjfliwC5Lr3BREGwZWFPF0dfO/LEpefmnrOEJA=;
        b=ipKkAMkY6OEVG/UELNfIqgA/Njt29p1a2F/LOiGQfVvgU236wYcGoBvAve/3OqtxPx
         sajm8UyBM9Pq+U0350PCBGWbDZ6J8PznoeKBL72cGPTf9yYVHr5MbpTgQdbW3+2kEkB9
         JriAEtw0pSzrVQRbUN2A2Yj31NlEVwKHd12NnAp5V/1qTA3+rDGL6gC6MOohOJhw5oyT
         1ttjqQtslU/PA8eneRnhqMh6Bg2clcsVLpHFneRR+CHUmxF75YB9SGUbq1jtiPtqAluz
         dhCO5oOhZTIjoyx4BYKbBiahybMDm+5I1FARxpC3IBctkkKRqyinzkGz2jTfXHDTigJo
         CHng==
X-Gm-Message-State: AOAM530HLNNgDVfDDRzTAbD523J33xFI7ijU/76qKw9q5bzxmirzWx0U
        FEPuzCfOiYJ1CmIRUuGl+6RGFBrzjxcPZuZdwYI=
X-Google-Smtp-Source: ABdhPJwxFTWZVwd4AgwEuA6atv0ebPp0EuSUzhoyiIOL0GjrfSrUJSvXj3zrz+2ojd1yTAy3GJX8QYB3D6aJfpVz8PQ=
X-Received: by 2002:a0c:b92f:: with SMTP id u47mr9825686qvf.247.1590782523414;
 Fri, 29 May 2020 13:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200522143201.GB32434@rowland.harvard.edu> <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com> <20200525112521.GD317569@hirez.programming.kicks-ass.net>
 <20200525154730.GW2869@paulmck-ThinkPad-P72> <20200525170257.GA325280@hirez.programming.kicks-ass.net>
 <20200525172154.GZ2869@paulmck-ThinkPad-P72> <20200528220047.GB211369@google.com>
 <20200528221659.GS2483@worktop.programming.kicks-ass.net> <CAEf4BzYf6jjrStc08R1bDASFyEdKj6vYg_MOaipUJ3vbdqNrSg@mail.gmail.com>
 <20200529123626.GL706495@hirez.programming.kicks-ass.net>
In-Reply-To: <20200529123626.GL706495@hirez.programming.kicks-ass.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 29 May 2020 13:01:51 -0700
Message-ID: <CAEf4Bzb9D1jTdmUzopc35qmFopaW-UfvLO9ohFsFsBuLVm0ZCw@mail.gmail.com>
Subject: Re: Some -serious- BPF-related litmus tests
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com,
        will@kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, Akira Yokosawa <akiyks@gmail.com>,
        dlustig@nvidia.com, open list <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 29, 2020 at 5:36 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, May 28, 2020 at 10:14:21PM -0700, Andrii Nakryiko wrote:
>
> > There is another cluster of applications which are unnecessarily more
> > complicated just for the fact that there is no ordering between
> > correlated events that happen on different CPUs. Per-CPU buffers are
> > not well suited for such cases, unfortunately.
>
> And yet, I've been debugging concurrency issues with ftrace for well
> over a decade.
>
> In fact, adding a spinlock in the mix will make a certain class of
> concurrency problems go-away! because you introduce artificial
> serialization between CPUs.
>
> Heck, even the ftrace buffer can sometimes make problems go way just
> because of the overhead of tracing itself changes the timing.
>

All true, but seems like you are looking at this from purely tracing
perspective, especially with very high-frequency events. And that's a
very challenging domain for sure. But *a lot* of BPF applications
(actually all I'm aware of at Facebook and outside of it) trace and
collect much less high-frequency events, so they don't need to
sacrifice so much to get ultimate performance. Performance profiling,
which comes closest to what you are describing, is just one of many
uses.

> It is perfectly possible to reconstruct order with per-cpu buffers in so
> far as that there is order to begin with. Esp on modern CPUs that have
> synchronized TSC.
>
> Computers are not SC, pretending that events are is just a lie.

Right, with precise enough clock or some atomic in-kernel counter, you
can re-construct order in user-space. But that has its own downsides:
you need to send this counter over the wire with every sample (takes
more space, reducing amounf of "useful" payload you can fit in a ring
buffer), plus user-space re-sorting takes engineering effort and isn't
exactly trivial. Now multiply that by many teams who need this, and it
becomes a problem worth solving.

Few examples of events that do occur sequentially in an ordered
manner, but due to per-cpu buffers might come back to user-space out
of order: fork/exec/exit events and tcp connection state tracking.
E.g., for short-lived process, fork can happen on one CPU, exit - on
another within tiny period of time between each other. In such case,
user-space might get exit event from one buffer before getting a fork
event on another one. Similarly for TCP connection state transitions.
For fork/exec/exit, typical rate of events, even on 80-core machines
is on the order of thousands of events per second at most (typically,
spikes do happen, unfortunately), so MPSC queue contention isn't a big
deal.

>
> > > people, but apparently they've not spend enough time debugging stuff
> > > with partial logs yet. Of course, bpf_prog_active already makes BPF
> > > lossy, so maybe they went with that.
> >
> > Not sure which "partial logs" you mean, I'll assume dropped samples?
>
> Yep. Trying to reconstruct what actually happened from incomplete logs
> is one of the most frustrating things in the world.
>
> > All production BPF applications are already designed to handle data
> > loss, because it could and does happen due to running out of buffer
> > space. Of course, amount of such drops is minimized however possible,
> > but applications still need to be able to handle that.
>
> Running out of space is fixable and 'obvious'. Missing random events in
> the middle is bloody infuriating. Even more so if you can't tell there's
> gaps in the midle.
>
> AFAICT, you don't even mark a reservation fail.... ah, you leave that to
> the user :-( And it can't tell if it's spurious or space related.

BPF program cannot ignore reservation failure, it has to check that
reserve() returned non-NULL pointer, verifier enforces that. It's true
that out-of-space vs locking failed in NMI is indistinguishable. We'll
see how important it is to distinguish in practice, there are very few
applications that do run in NMI context.

As for internal accounting of dropped samples, I've considered that
and there is 4 bytes per-sample I can use to communicate it back to
user-space, but it requires another atomic increment, which would just
reduce performance further. Modern BPF applications actually have a
very simple and straightforward ways to count that themselves with use
of global variables, memory-mapped into user-space. So it's simple and
fast to do. But again, we'll see in practice how that works for users
and will adjust/enhance as necessary.

>
> Same with bpf_prog_active, it's silent 'random' data loss. You can
> easily tell where a CPU buffer starts and stops, and thus if the events
> are contained within, but not if there's random bits missing from the
> middle.
>
> > Now, though, there will be more options. Now it's not just a question
> > of whether to allocate a tiny 64KB per-CPU buffer on 80 core server
> > and use reasonable 5MB for perfbuf overall, but suffer high and
> > frequent data loss whenever a burst of incoming events happen. Or bump
> > it up to, say, 256KB (or higher) and use 20MB+ now, which most of the
> > time will be completely unused, but be able to absorb 4x more events.
> > Now it might be more than enough to just allocate a single shared 5MB
> > buffer and be able to absorb much higher spikes (of course, assuming
> > not all CPUs will be spiking at the same time, in which case nothing
> > can really help you much w.r.t. data loss).
>
> Muwhahaha, a single shared buffer with 80 CPUs! That's bloody murder on
> performance.

Loved the laugh :) But see above, a lot of interesting events are
pretty low-frequency even on those giant servers.

>
> > So many BPF users are acutely aware of data loss and care a lot, but
> > there are other constraints that they have to take into account.
> >
> > As for expensiveness of spinlock and atomics, a lot of applications we
> > are seeing do not require huge throughput that per-CPU data structures
> > provide, so such overhead is acceptable. Even under high contention,
> > BPF ringbuf performance is pretty reasonable and will satisfy a lot of
> > applications, see [1].
>
> I've done benchmarks on contended atomic ops, and they go from ~20
> cycles (uncontended, cache hot) to well over 10k cycles when you jump on
> them with say a dozen cores across a few nodes (more numa, more
> horrible).
>
> >   [1] https://patchwork.ozlabs.org/project/netdev/patch/20200526063255.1675186-5-andriin@fb.com/
>
> From that: "Ringbuf, multi-producer contention", right? I read that as:
> 'performance is bloody horrible if you add contention'.
>
> I suppose most of your users have very low event rates, otherwise I
> can't see that working.

Yes and yes :) Good thing is that with MPSC ringbuf, if contention is
an issue, they can go with a model of 1 ringbuf for each cpu, similar
to perfbuf, or something in between with few ringbufs for larger
number of CPUs, again trading performance for memory, as necessary.
This is easy to do in BPF by combining ringbuf map with ARRAY_OF_MAPS
or HASH_OF_MAPS.

>
> > > All reasons why I never bother with BPF, aside from it being more
> > > difficult than hacking up a kernel in the first place.
> >
> > It's not my goal to pitch BPF here, but for a lot of real-world use
> > cases, hacking kernel is not an option at all, for many reasons. One
> > of them is that kernel upgrades across huge fleet of servers take a
> > long time, which teams can't afford to wait. In such cases, BPF is a
> > perfect solution, which can't be beaten, as evidenced by a wide
> > variety of BPF applications solving real problems.
>
> Yeah; lots of people use it because they really have nothing better for
> their situation.
>
> As long as people understand the constraints (and that's a *BIG* if) I
> suppose it's usable.
>
> It's just things I don't want to have to worry about.
>
> Anyway, all that said, I like how you did the commits, I should look to
> see if I can retro-fit the perf buffer to have some of that. Once

Thanks, and yeah, it would be actually great to have this
reserve/commit API for perfbuf as well. Internally it actually does
that, AFAIU, but all of that is enclosed in
preempt_disable/preempt_enable region, not sure how practical and easy
it is to split this up and let BPF verifier enforce that each
reservation is followed by commit. Having this kind of API would allow
to eliminate some unfortunate code patterns with using extra per-CPU
array just to prepare a record before sending it over perfbuf with
perf_event_output().

> question though; why are you using xchg() for the commit? Isn't that
> more expensive than it should be?
>
> That is, why isn't that:
>
>   smp_store_release(&hdr->len, new_len);
>
> ? Or are you needing the smp_mb() for the store->load ordering for the
> ->consumer_pos load? That really needs a comment.

Yeah, smp_store_release() is not strong enough, this memory barrier is
necessary. And yeah, I'll follow up with some more comments, that's
been what Joel requested as well.

>
> I think you can get rid of the smp_load_acquire() there, you're ordering
> a load->store and could rely on the branch to do that:
>
>         cons_pos = READ_ONCE(&rb->consumer_pos) & rb->mask;
>         if ((flags & BPF_RB_FORCE_WAKEUP) || (cons_pos == rec_pos && !(flags &BPF_RB_NO_WAKEUP))
>                 irq_work_queue(&rq->work);
>
> should be a control dependency.

Could be. I tried to keep consistent
smp_load_acquire/smp_store_release usage to keep it simpler. It might
not be the absolutely minimal amount of ordering that would still be
correct. We might be able to tweak and tune this without changing
correctness.

Anyways, thanks for taking a look and feedback. I hope some of my
examples explain why this might be a fine approach for a lot of
applications, even if not the most performant one.
