Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18D51E7D5D
	for <lists+linux-arch@lfdr.de>; Fri, 29 May 2020 14:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgE2MhH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 May 2020 08:37:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37462 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbgE2MhG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 May 2020 08:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DptdA1/V+5FkC3vPba0mtFM4V0F9ANd+9Ig+L5lvr7Q=; b=qXYsXDjDNmBXT8VWhFUDC9YDld
        oIgSZAsorhm+KlpiAXKflk7WhSslRt205AP30suHRrQrKIzOkOjUl8P17PmsiX5nazLaZuXizywjI
        cwZRsGBmu8FoEglYiduB64OUUqork3+TlBNyW87Mdt+0+NeNBtQIo9xcr78LM9gdb2iDDmn/G8bjF
        JSAxJTr3cyx64178NPHUFbTNzkp+c/awB65bE/NznrhbmbQSZqX9UAcdpV91BWMgjW3ihWWyaa9hw
        5XMLpkx6y5fx8qJhVle97YE20kaLP83rmjAY485MT7teqsMEYmI9YoGVRpgGTHDd84Babaf3S8LGP
        m+I03HZg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeeFX-0005PL-P9; Fri, 29 May 2020 12:36:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1D333301A80;
        Fri, 29 May 2020 14:36:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 05A9E203C05AF; Fri, 29 May 2020 14:36:27 +0200 (CEST)
Date:   Fri, 29 May 2020 14:36:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com,
        will@kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, Akira Yokosawa <akiyks@gmail.com>,
        dlustig@nvidia.com, open list <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org
Subject: Re: Some -serious- BPF-related litmus tests
Message-ID: <20200529123626.GL706495@hirez.programming.kicks-ass.net>
References: <20200522143201.GB32434@rowland.harvard.edu>
 <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com>
 <20200525112521.GD317569@hirez.programming.kicks-ass.net>
 <20200525154730.GW2869@paulmck-ThinkPad-P72>
 <20200525170257.GA325280@hirez.programming.kicks-ass.net>
 <20200525172154.GZ2869@paulmck-ThinkPad-P72>
 <20200528220047.GB211369@google.com>
 <20200528221659.GS2483@worktop.programming.kicks-ass.net>
 <CAEf4BzYf6jjrStc08R1bDASFyEdKj6vYg_MOaipUJ3vbdqNrSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYf6jjrStc08R1bDASFyEdKj6vYg_MOaipUJ3vbdqNrSg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 28, 2020 at 10:14:21PM -0700, Andrii Nakryiko wrote:

> There is another cluster of applications which are unnecessarily more
> complicated just for the fact that there is no ordering between
> correlated events that happen on different CPUs. Per-CPU buffers are
> not well suited for such cases, unfortunately.

And yet, I've been debugging concurrency issues with ftrace for well
over a decade.

In fact, adding a spinlock in the mix will make a certain class of
concurrency problems go-away! because you introduce artificial
serialization between CPUs.

Heck, even the ftrace buffer can sometimes make problems go way just
because of the overhead of tracing itself changes the timing.

It is perfectly possible to reconstruct order with per-cpu buffers in so
far as that there is order to begin with. Esp on modern CPUs that have
synchronized TSC.

Computers are not SC, pretending that events are is just a lie.

> > people, but apparently they've not spend enough time debugging stuff
> > with partial logs yet. Of course, bpf_prog_active already makes BPF
> > lossy, so maybe they went with that.
> 
> Not sure which "partial logs" you mean, I'll assume dropped samples?

Yep. Trying to reconstruct what actually happened from incomplete logs
is one of the most frustrating things in the world.

> All production BPF applications are already designed to handle data
> loss, because it could and does happen due to running out of buffer
> space. Of course, amount of such drops is minimized however possible,
> but applications still need to be able to handle that.

Running out of space is fixable and 'obvious'. Missing random events in
the middle is bloody infuriating. Even more so if you can't tell there's
gaps in the midle.

AFAICT, you don't even mark a reservation fail.... ah, you leave that to
the user :-( And it can't tell if it's spurious or space related.

Same with bpf_prog_active, it's silent 'random' data loss. You can
easily tell where a CPU buffer starts and stops, and thus if the events
are contained within, but not if there's random bits missing from the
middle.

> Now, though, there will be more options. Now it's not just a question
> of whether to allocate a tiny 64KB per-CPU buffer on 80 core server
> and use reasonable 5MB for perfbuf overall, but suffer high and
> frequent data loss whenever a burst of incoming events happen. Or bump
> it up to, say, 256KB (or higher) and use 20MB+ now, which most of the
> time will be completely unused, but be able to absorb 4x more events.
> Now it might be more than enough to just allocate a single shared 5MB
> buffer and be able to absorb much higher spikes (of course, assuming
> not all CPUs will be spiking at the same time, in which case nothing
> can really help you much w.r.t. data loss).

Muwhahaha, a single shared buffer with 80 CPUs! That's bloody murder on
performance.

> So many BPF users are acutely aware of data loss and care a lot, but
> there are other constraints that they have to take into account.
> 
> As for expensiveness of spinlock and atomics, a lot of applications we
> are seeing do not require huge throughput that per-CPU data structures
> provide, so such overhead is acceptable. Even under high contention,
> BPF ringbuf performance is pretty reasonable and will satisfy a lot of
> applications, see [1].

I've done benchmarks on contended atomic ops, and they go from ~20
cycles (uncontended, cache hot) to well over 10k cycles when you jump on
them with say a dozen cores across a few nodes (more numa, more
horrible).

>   [1] https://patchwork.ozlabs.org/project/netdev/patch/20200526063255.1675186-5-andriin@fb.com/

From that: "Ringbuf, multi-producer contention", right? I read that as:
'performance is bloody horrible if you add contention'.

I suppose most of your users have very low event rates, otherwise I
can't see that working.

> > All reasons why I never bother with BPF, aside from it being more
> > difficult than hacking up a kernel in the first place.
> 
> It's not my goal to pitch BPF here, but for a lot of real-world use
> cases, hacking kernel is not an option at all, for many reasons. One
> of them is that kernel upgrades across huge fleet of servers take a
> long time, which teams can't afford to wait. In such cases, BPF is a
> perfect solution, which can't be beaten, as evidenced by a wide
> variety of BPF applications solving real problems.

Yeah; lots of people use it because they really have nothing better for
their situation.

As long as people understand the constraints (and that's a *BIG* if) I
suppose it's usable.

It's just things I don't want to have to worry about.

Anyway, all that said, I like how you did the commits, I should look to
see if I can retro-fit the perf buffer to have some of that. Once
question though; why are you using xchg() for the commit? Isn't that
more expensive than it should be?

That is, why isn't that:

  smp_store_release(&hdr->len, new_len);

? Or are you needing the smp_mb() for the store->load ordering for the
->consumer_pos load? That really needs a comment.

I think you can get rid of the smp_load_acquire() there, you're ordering
a load->store and could rely on the branch to do that:

	cons_pos = READ_ONCE(&rb->consumer_pos) & rb->mask;
	if ((flags & BPF_RB_FORCE_WAKEUP) || (cons_pos == rec_pos && !(flags &BPF_RB_NO_WAKEUP))
		irq_work_queue(&rq->work);

should be a control dependency.
