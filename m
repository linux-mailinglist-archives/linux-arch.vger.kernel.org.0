Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A244A38CC90
	for <lists+linux-arch@lfdr.de>; Fri, 21 May 2021 19:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238437AbhEURss (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 13:48:48 -0400
Received: from foss.arm.com ([217.140.110.172]:52684 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235764AbhEURsr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 13:48:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 316201424;
        Fri, 21 May 2021 10:47:24 -0700 (PDT)
Received: from [192.168.1.16] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6F273F73D;
        Fri, 21 May 2021 10:47:20 -0700 (PDT)
Subject: Re: [PATCH v6 13/21] sched: Admit forcefully-affined tasks into
 SCHED_DEADLINE
To:     Juri Lelli <juri.lelli@redhat.com>,
        Quentin Perret <qperret@google.com>
Cc:     Will Deacon <will@kernel.org>,
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
References: <20210520101640.GA10065@willie-the-truck>
 <YKY7FvFeRlXVjcaA@google.com>
 <f9d1a138-3150-d404-7cd5-ddf72e93837b@redhat.com>
 <20210520180138.GA10523@willie-the-truck>
 <YKdEX9uaQXy8g/S/@localhost.localdomain> <YKdsOBCjASzFSzLm@google.com>
 <YKdxxDfu81W28n1A@localhost.localdomain>
 <20210521103724.GA11680@willie-the-truck>
 <3620bad5-2a27-0f9e-f1f0-70036997d33c@arm.com> <YKevSSLHjdRvrJ2i@google.com>
 <YKe94oTVSbywMw2r@localhost.localdomain>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <1031558c-acc8-d1b2-2964-ed78fd9b22a0@arm.com>
Date:   Fri, 21 May 2021 19:47:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YKe94oTVSbywMw2r@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 21/05/2021 16:04, Juri Lelli wrote:
> On 21/05/21 13:02, Quentin Perret wrote:
> 
> ...
> 
>> So I think Will has a point since, IIRC, the root domains get rebuilt
>> during hotplug. So you can imagine a case with a single root domain, but
>> CPUs 4-7 are offline. In this case, sched_setattr() will happily promote
>> a task to DL as long as its affinity mask is a superset of the rd span,
>> but things may get ugly when CPUs are plugged back in later on.

Yeah, that's true. I understand the condition, that the task's affinity
mask has to be a superset of the rd span, as that DL AC (i.e DL BW
management) can only work correctly if all admitted tasks can run on
every CPU in the rd.

Like you said, you can already today let tasks with reduced affinity
mask pass the DL AC in case you hp out the other CPUs and then trick DL
AC by hp in the remaining CPUs and admit more DL tasks. But these steps
require a lot of effort to create this false setup.

The dedicated rd for 32-bit tasks matching `aarch32_el0` in an exclusive
cpuset env seems to be a feasible approach to me. But I also don't see
an eminent use case for this.

>> This looks like an existing bug though. I just tried the following on a
>> system with 4 CPUs:
>>
>>     // Create a task affined to CPU [0-2]
>>     > while true; do echo "Hi" > /dev/null; done &
>>     [1] 560
>>     > mypid=$!
>>     > taskset -p 7 $mypid
>>     pid 560's current affinity mask: f
>>     pid 560's new affinity mask: 7
>>
>>     // Try to move it DL, this should fail because of the affinity
>>     > chrt -d -T 5000000 -P 16666666 -p 0 $mypid
>>     chrt: failed to set pid 560's policy: Operation not permitted
>>
>>     // Offline CPU 3, so the rd now covers CPUs 0-2 only
>>     > echo 0 > /sys/devices/system/cpu/cpu3/online
>>     [  400.843830] CPU3: shutdown
>>     [  400.844100] psci: CPU3 killed (polled 0 ms)
>>
>>     // Try to admit the task again, which now succeeds
>>     > chrt -d -T 5000000 -P 16666666 -p 0 $mypid
>>
>>     // Plug CPU3 back online
>>     > echo 1 > /sys/devices/system/cpu/cpu3/online
>>     [  408.819337] Detected PIPT I-cache on CPU3
>>     [  408.819642] GICv3: CPU3: found redistributor 3 region 0:0x0000000008100000
>>     [  408.820165] CPU3: Booted secondary processor 0x0000000003 [0x410fd083]
>>
>> I don't see any easy way to fix this w/o iterating over all deadline
>> tasks in the rd when hotplugging a CPU back on, and blocking the hotplug
>> operation if it'll cause affinity issues. Urgh.

Something like dl_cpu_busy() in cpuset_cpu_inactive() but the other way
around in cpuset_cpu_active().

We iterate over all DL tasks in partition_and_rebuild_sched_domains() ->
rebuild_root_domains() -> update_tasks_root_domain() ->
dl_add_task_root_domain(struct task_struct *p) to recreate DL BW
information after CPU hp but this is asynchronously to cpuset_cpu_active().

> 
> Yeah this looks like a plain existing bug, joy. :)
> 
> We fixed a few around AC lately, but I guess work wasn't complete.
> 
> Thanks,
> Juri

