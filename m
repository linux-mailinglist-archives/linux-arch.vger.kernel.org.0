Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7742CA20A
	for <lists+linux-arch@lfdr.de>; Tue,  1 Dec 2020 13:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390693AbgLAL7d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 06:59:33 -0500
Received: from foss.arm.com ([217.140.110.172]:41540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389432AbgLAL7c (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Dec 2020 06:59:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEE38101E;
        Tue,  1 Dec 2020 03:58:46 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C8D43F718;
        Tue,  1 Dec 2020 03:58:44 -0800 (PST)
Date:   Tue, 1 Dec 2020 11:58:42 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v4 09/14] cpuset: Don't use the cpu_possible_mask as a
 last resort for cgroup v1
Message-ID: <20201201115842.t77abecneuesd5ih@e107158-lin.cambridge.arm.com>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-10-will@kernel.org>
 <20201127133245.4hbx65mo3zinawvo@e107158-lin.cambridge.arm.com>
 <20201130170531.qo67rai5lftskmk2@e107158-lin.cambridge.arm.com>
 <20201130173610.GA1715200@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201130173610.GA1715200@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/30/20 17:36, Quentin Perret wrote:
> On Monday 30 Nov 2020 at 17:05:31 (+0000), Qais Yousef wrote:
> > I create 3 cpusets: 64bit, 32bit and mix. As the name indicates, 64bit contains
> > all 64bit-only cpus, 32bit contains 32bit-capable ones and mix has a mixture of
> > both.
> > 
> > If I try to move my test binary to 64bit cpuset, it moves there and I see the
> > WARN_ON_ONCE() triggered. The task has attached to the new cpuset but
> > set_allowed_cpus_ptr() has failed and we end up with whatever affinity we had
> > previously. Breaking cpusets effectively.
> 
> Right, and so does exec'ing from a 64 bit task into 32 bit executable
> from within a 64 bit-only cpuset :( . And there is nothing we can really

True. The kernel can decide to kill the task or force detach it then, no?
Sending SIGKILL makes more sense.

> do about it, we cannot fail the exec because we need this to work for
> existing apps, and there is no way the Android framework can know
> upfront.

It knows upfront it has enabled asym aarch32. So it needs to make sure not to
create 'invalid' cpusets?

> 
> So the only thing we can do really is WARN() and proceed to ignore the
> cpuset, which is what this series does :/. It's not exactly pretty but I
> don't think we can do much better than that TBH, and it's the same thing
> for the example you brought up. Failing cpuset_can_attach() will not
> help, we can only WARN and proceed ...

I think for cases where we can prevent userspace from doing something wrong, we
should. Like trying to attach to a cpuset that will result in an empty mask.
FWIW, it does something similar with deadline tasks. See task_can_attach().

Similarly for the case when userspace tries to modify the cpuset.cpus such that
a task will end up with empty cpumask. We now have the new case that some tasks
can only run on a subset of cpu_possible_mask. So the definition of empty
cpumask has gained an extra meaning.

> 
> Now, Android should be fine with that I think. We only need the kernel
> to implement a safe fallback mechanism when userspace gives
> contradictory commands, because we know there are edge cases userspace
> _cannot_ deal with correctly, but this fallback doesn't need to be
> highly optimized (at least for Android), but I'm happy to hear what
> others think.

Why not go with our original patch that fixes affinity then in the arch code if
the task wakes up on the wrong cpu? It is much simpler approach IMO to achieve
the same thing.

I was under the impression that if we go down teaching the scheduler about asym
ISA, then we have to deal with these edge cases. I don't think we're far away
from getting there.

Thanks

--
Qais Yousef
