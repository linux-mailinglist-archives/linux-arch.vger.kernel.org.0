Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518C638C768
	for <lists+linux-arch@lfdr.de>; Fri, 21 May 2021 15:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbhEUNDe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 09:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbhEUND3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 May 2021 09:03:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DDFC061763
        for <linux-arch@vger.kernel.org>; Fri, 21 May 2021 06:02:06 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id f75-20020a1c1f4e0000b0290171001e7329so7108788wmf.1
        for <linux-arch@vger.kernel.org>; Fri, 21 May 2021 06:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UNcu1gnGvN2oxqT95bOBswNHvPMphanY7lKyhZ21jHY=;
        b=nuWu1qhayIJu7AWE6lkwfPs5YgxewndlzjeUHpG73kOziPhiTbWkF6vTuriZwEPFMZ
         XqadNeGOaE4d0Gx7YfEKaSOMi7mPa1IJRiYyqEn1tqeMg8uEvpdfeGUASLDQFzkdkd8x
         bfB9Z0jXQj30tjyr46zCxTXFkC+jfzcmWnFrXU1IL4vRYafvMJ/DS9wwiTiw39ZJBvr8
         AHBZbtXgJq86Oh0Sa9li/3PE6d7itTFFymEFx973yaJbEH38DBWLIobPIuOlK/UhOiRO
         z+9mA45Sg1sT8JZgOiTgEp1LvilPMv/v0vIhxERLVDakMkQGdKruaoExweNdi2mgy3s2
         w1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UNcu1gnGvN2oxqT95bOBswNHvPMphanY7lKyhZ21jHY=;
        b=J05u2Twmhh59KE8kLAXE2lz0FTTO99/75g0RbusgO+HAfA02t/fC52IaQa1y27Eib/
         odKkbhwreWYf9RiyslHK7RiA//rtfEx7j319Z3RLO0gnd1O+fEh1REYC/w1wDNrjssxT
         bUIRyajCSL8q2Il/TtBFWrf/P3UPatiyXerlctM/CCUM781OrVd00w6mWGfY9puYac+O
         7RIsEbgOVB+3hu5xyCoLm6DeSDo8MCq6iB3kkZg+vJxR7vJznS+H/+wd38MzI1dHHAKg
         NMO9u1LS+bn4hdN+bLF3+TRl29PHPgfYkM8Fuk5CNrfbT7oYiDf7wtZ+8fzSTJp32upe
         Gm9w==
X-Gm-Message-State: AOAM530aouUBHK51t+ROexk2rNHjwnq5tHBjgPfZM/tSg1IR3lh0yxDp
        Zy4CeKtPBE/h0JgPF0xa6oJxnw==
X-Google-Smtp-Source: ABdhPJyScHKztdg9UQFgMBxbRd0FUAkNEY4SwwrXQF1IbF6hPKlDuMyOWPhrSvUFkcAgWefNU0cjQA==
X-Received: by 2002:a1c:ed0a:: with SMTP id l10mr8651931wmh.151.1621602124678;
        Fri, 21 May 2021 06:02:04 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id t17sm1967572wrp.89.2021.05.21.06.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 06:02:04 -0700 (PDT)
Date:   Fri, 21 May 2021 13:02:01 +0000
From:   Quentin Perret <qperret@google.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Will Deacon <will@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
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
Message-ID: <YKevSSLHjdRvrJ2i@google.com>
References: <YKYoQ0ezahSC/RAg@localhost.localdomain>
 <20210520101640.GA10065@willie-the-truck>
 <YKY7FvFeRlXVjcaA@google.com>
 <f9d1a138-3150-d404-7cd5-ddf72e93837b@redhat.com>
 <20210520180138.GA10523@willie-the-truck>
 <YKdEX9uaQXy8g/S/@localhost.localdomain>
 <YKdsOBCjASzFSzLm@google.com>
 <YKdxxDfu81W28n1A@localhost.localdomain>
 <20210521103724.GA11680@willie-the-truck>
 <3620bad5-2a27-0f9e-f1f0-70036997d33c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3620bad5-2a27-0f9e-f1f0-70036997d33c@arm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Friday 21 May 2021 at 13:23:55 (+0200), Dietmar Eggemann wrote:
> On 21/05/2021 12:37, Will Deacon wrote:
> > On Fri, May 21, 2021 at 10:39:32AM +0200, Juri Lelli wrote:
> >> On 21/05/21 08:15, Quentin Perret wrote:
> >>> On Friday 21 May 2021 at 07:25:51 (+0200), Juri Lelli wrote:
> >>>> On 20/05/21 19:01, Will Deacon wrote:
> >>>>> On Thu, May 20, 2021 at 02:38:55PM +0200, Daniel Bristot de Oliveira wrote:
> >>>>>> On 5/20/21 12:33 PM, Quentin Perret wrote:
> >>>>>>> On Thursday 20 May 2021 at 11:16:41 (+0100), Will Deacon wrote:
> >>>>>>>> Ok, thanks for the insight. In which case, I'll go with what we discussed:
> >>>>>>>> require admission control to be disabled for sched_setattr() but allow
> >>>>>>>> execve() to a 32-bit task from a 64-bit deadline task with a warning (this
> >>>>>>>> is probably similar to CPU hotplug?).
> >>>>>>>
> >>>>>>> Still not sure that we can let execve go through ... It will break AC
> >>>>>>> all the same, so it should probably fail as well if AC is on IMO
> >>>>>>>
> >>>>>>
> >>>>>> If the cpumask of the 32-bit task is != of the 64-bit task that is executing it,
> >>>>>> the admission control needs to be re-executed, and it could fail. So I see this
> >>>>>> operation equivalent to sched_setaffinity(). This will likely be true for future
> >>>>>> schedulers that will allow arbitrary affinities (AC should run on affinity
> >>>>>> change, and could fail).
> >>>>>>
> >>>>>> I would vote with Juri: "I'd go with fail hard if AC is on, let it
> >>>>>> pass if AC is off (supposedly the user knows what to do)," (also hope nobody
> >>>>>> complains until we add better support for affinity, and use this as a motivation
> >>>>>> to get back on this front).
> >>>>>
> >>>>> I can have a go at implementing it, but I don't think it's a great solution
> >>>>> and here's why:
> >>>>>
> >>>>> Failing an execve() is _very_ likely to be fatal to the application. It's
> >>>>> also very likely that the task calling execve() doesn't know whether the
> >>>>> program it's trying to execute is 32-bit or not. Consequently, if we go
> >>>>> with failing execve() then all that will happen is that people will disable
> >>>>> admission control altogether.
> >>>
> >>> Right, but only on these dumb 32bit asymmetric systems, and only if we
> >>> care about running 32bits deadline tasks -- which I seriously doubt for
> >>> the Android use-case.
> >>>
> >>> Note that running deadline tasks is also a privileged operation, it
> >>> can't be done by random apps.
> >>>
> >>>>> That has a negative impact on "pure" 64-bit
> >>>>> applications and so I think we end up with the tail wagging the dog because
> >>>>> admission control will be disabled for everybody just because there is a
> >>>>> handful of 32-bit programs which may get executed. I understand that it
> >>>>> also means that RT throttling would be disabled.
> >>>>
> >>>> Completely understand your perplexity. But how can the kernel still give
> >>>> guarantees to "pure" 64-bit applications if there are 32-bit
> >>>> applications around that essentially broke admission control when they
> >>>> were restricted to a subset of cores?
> >>>>
> >>>>> Allowing the execve() to continue with a warning is very similar to the
> >>>>> case in which all the 64-bit CPUs are hot-unplugged at the point of
> >>>>> execve(), and this is much closer to the illusion that this patch series
> >>>>> intends to provide.
> >>>>
> >>>> So, for hotplug we currently have a check that would make hotplug
> >>>> operations fail if removing a CPU would mean not enough bandwidth to run
> >>>> the currently admitted set of DEADLINE tasks.
> >>>
> >>> Aha, wasn't aware. Any pointers to that check for my education?
> >>
> >> Hotplug ends up calling dl_cpu_busy() (after the cpu being hotplugged out
> >> got removed), IIRC. So, if that fails the operation in undone.
> > 
> > Interesting, thanks. Thinking about this some more, it strikes me that with
> > these silly asymmetric systems there could be an interesting additional
> > problem with hotplug and deadline tasks. Imagine the following sequence of
> > events:
> > 
> >   1. All online CPUs are 32-bit-capable
> >   2. sched_setattr() admits a 32-bit deadline task
> >   3. A 64-bit-only CPU is onlined
> >   4. Some of the 32-bit-capable CPUs are offlined
> > 
> > I wonder if we can get into a situation where we think we have enough
> > bandwidth available, but in reality the 32-bit task is in trouble because
> > it can't make use of the 64-bit-only CPU.
> > 
> > If so, then it seems to me that admission control is really just
> > "best-effort" for 32-bit deadline tasks on these systems because it's based
> > on a snapshot in time of the available resources.
> 
> IMHO DL AC is per root domain (rd). So if we have e.g. an 8 CPU system
> with aarch32_el0 eq. [0-3] then we would need 2 exclusive cpusets ([0-3]
> and [4-7]) to admit 32-bit DL tasks into [0-3] (i.e. to pass the `if
> (!cpumask_subset(span, p->cpus_ptr) ...` test in __sched_setscheduler().
> 
> Trying to admit too many 32-bit DL tasks or trying to hp out a CPU[0-3]
> would lead to `Device or resource busy` in case the rd bw wouldn't be
> sufficient anymore for the set of admitted tasks. But the [0-3] DL AC
> wouldn't care about hp on CPU[4-7].

So I think Will has a point since, IIRC, the root domains get rebuilt
during hotplug. So you can imagine a case with a single root domain, but
CPUs 4-7 are offline. In this case, sched_setattr() will happily promote
a task to DL as long as its affinity mask is a superset of the rd span,
but things may get ugly when CPUs are plugged back in later on.

This looks like an existing bug though. I just tried the following on a
system with 4 CPUs:

    // Create a task affined to CPU [0-2]
    > while true; do echo "Hi" > /dev/null; done &
    [1] 560
    > mypid=$!
    > taskset -p 7 $mypid
    pid 560's current affinity mask: f
    pid 560's new affinity mask: 7

    // Try to move it DL, this should fail because of the affinity
    > chrt -d -T 5000000 -P 16666666 -p 0 $mypid
    chrt: failed to set pid 560's policy: Operation not permitted

    // Offline CPU 3, so the rd now covers CPUs 0-2 only
    > echo 0 > /sys/devices/system/cpu/cpu3/online
    [  400.843830] CPU3: shutdown
    [  400.844100] psci: CPU3 killed (polled 0 ms)

    // Try to admit the task again, which now succeeds
    > chrt -d -T 5000000 -P 16666666 -p 0 $mypid

    // Plug CPU3 back online
    > echo 1 > /sys/devices/system/cpu/cpu3/online
    [  408.819337] Detected PIPT I-cache on CPU3
    [  408.819642] GICv3: CPU3: found redistributor 3 region 0:0x0000000008100000
    [  408.820165] CPU3: Booted secondary processor 0x0000000003 [0x410fd083]

I don't see any easy way to fix this w/o iterating over all deadline
tasks in the rd when hotplugging a CPU back on, and blocking the hotplug
operation if it'll cause affinity issues. Urgh.
