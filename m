Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA00D38C512
	for <lists+linux-arch@lfdr.de>; Fri, 21 May 2021 12:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhEUKi7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 06:38:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhEUKi6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 06:38:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DA43613B6;
        Fri, 21 May 2021 10:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621593455;
        bh=YAisXoj6NBkEL7x8HnOJnqS+ubE1o8niv9ITsKtPa1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o99V2rahnd1Oq0LfujPDhIFNx42f6AxUnVhqpcNgyEApwqPGdmHjQEnyOiIYhFWeW
         B8iKatYNyvNQs9ImwBHI5gCrI84jfNyydb4k08VVZp+SezAw2Nz5wNtYEzWabZT2xm
         r0xjdQI2sP03s8AeDBos8ca7u1DGp0hub0h3cK/cpVHYiIHs+bhwk6CbwREx44o1sq
         AK09qk/D+L3V64LzQzIU3KohV+ZUr53ygi5nJEsLref7bY4lPd7gbzjqIvGYZQc/dk
         xZiOoObjveGNDU2WIsWqBeUbzc17NNgqv+fN0bn0tyrMY/apdpr2ur9KaCwn8tRLje
         i+ljANCcIOYNg==
Date:   Fri, 21 May 2021 11:37:25 +0100
From:   Will Deacon <will@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Quentin Perret <qperret@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: Re: [PATCH v6 13/21] sched: Admit forcefully-affined tasks into
 SCHED_DEADLINE
Message-ID: <20210521103724.GA11680@willie-the-truck>
References: <20210518105951.GC7770@willie-the-truck>
 <YKO+9lPLQLPm4Nwt@google.com>
 <YKYoQ0ezahSC/RAg@localhost.localdomain>
 <20210520101640.GA10065@willie-the-truck>
 <YKY7FvFeRlXVjcaA@google.com>
 <f9d1a138-3150-d404-7cd5-ddf72e93837b@redhat.com>
 <20210520180138.GA10523@willie-the-truck>
 <YKdEX9uaQXy8g/S/@localhost.localdomain>
 <YKdsOBCjASzFSzLm@google.com>
 <YKdxxDfu81W28n1A@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKdxxDfu81W28n1A@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 21, 2021 at 10:39:32AM +0200, Juri Lelli wrote:
> On 21/05/21 08:15, Quentin Perret wrote:
> > On Friday 21 May 2021 at 07:25:51 (+0200), Juri Lelli wrote:
> > > On 20/05/21 19:01, Will Deacon wrote:
> > > > On Thu, May 20, 2021 at 02:38:55PM +0200, Daniel Bristot de Oliveira wrote:
> > > > > On 5/20/21 12:33 PM, Quentin Perret wrote:
> > > > > > On Thursday 20 May 2021 at 11:16:41 (+0100), Will Deacon wrote:
> > > > > >> Ok, thanks for the insight. In which case, I'll go with what we discussed:
> > > > > >> require admission control to be disabled for sched_setattr() but allow
> > > > > >> execve() to a 32-bit task from a 64-bit deadline task with a warning (this
> > > > > >> is probably similar to CPU hotplug?).
> > > > > > 
> > > > > > Still not sure that we can let execve go through ... It will break AC
> > > > > > all the same, so it should probably fail as well if AC is on IMO
> > > > > > 
> > > > > 
> > > > > If the cpumask of the 32-bit task is != of the 64-bit task that is executing it,
> > > > > the admission control needs to be re-executed, and it could fail. So I see this
> > > > > operation equivalent to sched_setaffinity(). This will likely be true for future
> > > > > schedulers that will allow arbitrary affinities (AC should run on affinity
> > > > > change, and could fail).
> > > > > 
> > > > > I would vote with Juri: "I'd go with fail hard if AC is on, let it
> > > > > pass if AC is off (supposedly the user knows what to do)," (also hope nobody
> > > > > complains until we add better support for affinity, and use this as a motivation
> > > > > to get back on this front).
> > > > 
> > > > I can have a go at implementing it, but I don't think it's a great solution
> > > > and here's why:
> > > > 
> > > > Failing an execve() is _very_ likely to be fatal to the application. It's
> > > > also very likely that the task calling execve() doesn't know whether the
> > > > program it's trying to execute is 32-bit or not. Consequently, if we go
> > > > with failing execve() then all that will happen is that people will disable
> > > > admission control altogether.
> > 
> > Right, but only on these dumb 32bit asymmetric systems, and only if we
> > care about running 32bits deadline tasks -- which I seriously doubt for
> > the Android use-case.
> > 
> > Note that running deadline tasks is also a privileged operation, it
> > can't be done by random apps.
> > 
> > > > That has a negative impact on "pure" 64-bit
> > > > applications and so I think we end up with the tail wagging the dog because
> > > > admission control will be disabled for everybody just because there is a
> > > > handful of 32-bit programs which may get executed. I understand that it
> > > > also means that RT throttling would be disabled.
> > > 
> > > Completely understand your perplexity. But how can the kernel still give
> > > guarantees to "pure" 64-bit applications if there are 32-bit
> > > applications around that essentially broke admission control when they
> > > were restricted to a subset of cores?
> > > 
> > > > Allowing the execve() to continue with a warning is very similar to the
> > > > case in which all the 64-bit CPUs are hot-unplugged at the point of
> > > > execve(), and this is much closer to the illusion that this patch series
> > > > intends to provide.
> > > 
> > > So, for hotplug we currently have a check that would make hotplug
> > > operations fail if removing a CPU would mean not enough bandwidth to run
> > > the currently admitted set of DEADLINE tasks.
> > 
> > Aha, wasn't aware. Any pointers to that check for my education?
> 
> Hotplug ends up calling dl_cpu_busy() (after the cpu being hotplugged out
> got removed), IIRC. So, if that fails the operation in undone.

Interesting, thanks. Thinking about this some more, it strikes me that with
these silly asymmetric systems there could be an interesting additional
problem with hotplug and deadline tasks. Imagine the following sequence of
events:

  1. All online CPUs are 32-bit-capable
  2. sched_setattr() admits a 32-bit deadline task
  3. A 64-bit-only CPU is onlined
  4. Some of the 32-bit-capable CPUs are offlined

I wonder if we can get into a situation where we think we have enough
bandwidth available, but in reality the 32-bit task is in trouble because
it can't make use of the 64-bit-only CPU.

If so, then it seems to me that admission control is really just
"best-effort" for 32-bit deadline tasks on these systems because it's based
on a snapshot in time of the available resources.

Will
