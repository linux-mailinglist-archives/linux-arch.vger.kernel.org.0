Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC29438C59D
	for <lists+linux-arch@lfdr.de>; Fri, 21 May 2021 13:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhEULZe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 07:25:34 -0400
Received: from foss.arm.com ([217.140.110.172]:45038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229973AbhEULZe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 07:25:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C3B51424;
        Fri, 21 May 2021 04:24:11 -0700 (PDT)
Received: from [192.168.1.16] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99D383F73D;
        Fri, 21 May 2021 04:24:07 -0700 (PDT)
Subject: Re: [PATCH v6 13/21] sched: Admit forcefully-affined tasks into
 SCHED_DEADLINE
To:     Will Deacon <will@kernel.org>, Juri Lelli <juri.lelli@redhat.com>
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
References: <20210518105951.GC7770@willie-the-truck>
 <YKO+9lPLQLPm4Nwt@google.com> <YKYoQ0ezahSC/RAg@localhost.localdomain>
 <20210520101640.GA10065@willie-the-truck> <YKY7FvFeRlXVjcaA@google.com>
 <f9d1a138-3150-d404-7cd5-ddf72e93837b@redhat.com>
 <20210520180138.GA10523@willie-the-truck>
 <YKdEX9uaQXy8g/S/@localhost.localdomain> <YKdsOBCjASzFSzLm@google.com>
 <YKdxxDfu81W28n1A@localhost.localdomain>
 <20210521103724.GA11680@willie-the-truck>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <3620bad5-2a27-0f9e-f1f0-70036997d33c@arm.com>
Date:   Fri, 21 May 2021 13:23:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210521103724.GA11680@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 21/05/2021 12:37, Will Deacon wrote:
> On Fri, May 21, 2021 at 10:39:32AM +0200, Juri Lelli wrote:
>> On 21/05/21 08:15, Quentin Perret wrote:
>>> On Friday 21 May 2021 at 07:25:51 (+0200), Juri Lelli wrote:
>>>> On 20/05/21 19:01, Will Deacon wrote:
>>>>> On Thu, May 20, 2021 at 02:38:55PM +0200, Daniel Bristot de Oliveira wrote:
>>>>>> On 5/20/21 12:33 PM, Quentin Perret wrote:
>>>>>>> On Thursday 20 May 2021 at 11:16:41 (+0100), Will Deacon wrote:
>>>>>>>> Ok, thanks for the insight. In which case, I'll go with what we discussed:
>>>>>>>> require admission control to be disabled for sched_setattr() but allow
>>>>>>>> execve() to a 32-bit task from a 64-bit deadline task with a warning (this
>>>>>>>> is probably similar to CPU hotplug?).
>>>>>>>
>>>>>>> Still not sure that we can let execve go through ... It will break AC
>>>>>>> all the same, so it should probably fail as well if AC is on IMO
>>>>>>>
>>>>>>
>>>>>> If the cpumask of the 32-bit task is != of the 64-bit task that is executing it,
>>>>>> the admission control needs to be re-executed, and it could fail. So I see this
>>>>>> operation equivalent to sched_setaffinity(). This will likely be true for future
>>>>>> schedulers that will allow arbitrary affinities (AC should run on affinity
>>>>>> change, and could fail).
>>>>>>
>>>>>> I would vote with Juri: "I'd go with fail hard if AC is on, let it
>>>>>> pass if AC is off (supposedly the user knows what to do)," (also hope nobody
>>>>>> complains until we add better support for affinity, and use this as a motivation
>>>>>> to get back on this front).
>>>>>
>>>>> I can have a go at implementing it, but I don't think it's a great solution
>>>>> and here's why:
>>>>>
>>>>> Failing an execve() is _very_ likely to be fatal to the application. It's
>>>>> also very likely that the task calling execve() doesn't know whether the
>>>>> program it's trying to execute is 32-bit or not. Consequently, if we go
>>>>> with failing execve() then all that will happen is that people will disable
>>>>> admission control altogether.
>>>
>>> Right, but only on these dumb 32bit asymmetric systems, and only if we
>>> care about running 32bits deadline tasks -- which I seriously doubt for
>>> the Android use-case.
>>>
>>> Note that running deadline tasks is also a privileged operation, it
>>> can't be done by random apps.
>>>
>>>>> That has a negative impact on "pure" 64-bit
>>>>> applications and so I think we end up with the tail wagging the dog because
>>>>> admission control will be disabled for everybody just because there is a
>>>>> handful of 32-bit programs which may get executed. I understand that it
>>>>> also means that RT throttling would be disabled.
>>>>
>>>> Completely understand your perplexity. But how can the kernel still give
>>>> guarantees to "pure" 64-bit applications if there are 32-bit
>>>> applications around that essentially broke admission control when they
>>>> were restricted to a subset of cores?
>>>>
>>>>> Allowing the execve() to continue with a warning is very similar to the
>>>>> case in which all the 64-bit CPUs are hot-unplugged at the point of
>>>>> execve(), and this is much closer to the illusion that this patch series
>>>>> intends to provide.
>>>>
>>>> So, for hotplug we currently have a check that would make hotplug
>>>> operations fail if removing a CPU would mean not enough bandwidth to run
>>>> the currently admitted set of DEADLINE tasks.
>>>
>>> Aha, wasn't aware. Any pointers to that check for my education?
>>
>> Hotplug ends up calling dl_cpu_busy() (after the cpu being hotplugged out
>> got removed), IIRC. So, if that fails the operation in undone.
> 
> Interesting, thanks. Thinking about this some more, it strikes me that with
> these silly asymmetric systems there could be an interesting additional
> problem with hotplug and deadline tasks. Imagine the following sequence of
> events:
> 
>   1. All online CPUs are 32-bit-capable
>   2. sched_setattr() admits a 32-bit deadline task
>   3. A 64-bit-only CPU is onlined
>   4. Some of the 32-bit-capable CPUs are offlined
> 
> I wonder if we can get into a situation where we think we have enough
> bandwidth available, but in reality the 32-bit task is in trouble because
> it can't make use of the 64-bit-only CPU.
> 
> If so, then it seems to me that admission control is really just
> "best-effort" for 32-bit deadline tasks on these systems because it's based
> on a snapshot in time of the available resources.

IMHO DL AC is per root domain (rd). So if we have e.g. an 8 CPU system
with aarch32_el0 eq. [0-3] then we would need 2 exclusive cpusets ([0-3]
and [4-7]) to admit 32-bit DL tasks into [0-3] (i.e. to pass the `if
(!cpumask_subset(span, p->cpus_ptr) ...` test in __sched_setscheduler().

Trying to admit too many 32-bit DL tasks or trying to hp out a CPU[0-3]
would lead to `Device or resource busy` in case the rd bw wouldn't be
sufficient anymore for the set of admitted tasks. But the [0-3] DL AC
wouldn't care about hp on CPU[4-7].
