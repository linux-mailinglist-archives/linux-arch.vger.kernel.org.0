Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779182CA545
	for <lists+linux-arch@lfdr.de>; Tue,  1 Dec 2020 15:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgLAOMM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 09:12:12 -0500
Received: from foss.arm.com ([217.140.110.172]:43662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbgLAOMM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Dec 2020 09:12:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 349D630E;
        Tue,  1 Dec 2020 06:11:26 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 022223F718;
        Tue,  1 Dec 2020 06:11:23 -0800 (PST)
Date:   Tue, 1 Dec 2020 14:11:21 +0000
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
Message-ID: <20201201141121.5w2wed3633slo6dw@e107158-lin.cambridge.arm.com>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-10-will@kernel.org>
 <20201127133245.4hbx65mo3zinawvo@e107158-lin.cambridge.arm.com>
 <20201130170531.qo67rai5lftskmk2@e107158-lin.cambridge.arm.com>
 <20201130173610.GA1715200@google.com>
 <20201201115842.t77abecneuesd5ih@e107158-lin.cambridge.arm.com>
 <20201201123748.GA1896574@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201201123748.GA1896574@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/01/20 12:37, Quentin Perret wrote:
> On Tuesday 01 Dec 2020 at 11:58:42 (+0000), Qais Yousef wrote:
> > On 11/30/20 17:36, Quentin Perret wrote:
> > > On Monday 30 Nov 2020 at 17:05:31 (+0000), Qais Yousef wrote:
> > > > I create 3 cpusets: 64bit, 32bit and mix. As the name indicates, 64bit contains
> > > > all 64bit-only cpus, 32bit contains 32bit-capable ones and mix has a mixture of
> > > > both.
> > > > 
> > > > If I try to move my test binary to 64bit cpuset, it moves there and I see the
> > > > WARN_ON_ONCE() triggered. The task has attached to the new cpuset but
> > > > set_allowed_cpus_ptr() has failed and we end up with whatever affinity we had
> > > > previously. Breaking cpusets effectively.
> > > 
> > > Right, and so does exec'ing from a 64 bit task into 32 bit executable
> > > from within a 64 bit-only cpuset :( . And there is nothing we can really
> > 
> > True. The kernel can decide to kill the task or force detach it then, no?
> > Sending SIGKILL makes more sense.
> 
> Yeah but again, we need this to work for existing apps. Just killing it
> basically means we have no support, so that doesn't work for the use
> case :/

I don't get you. Unless what you're saying is you want to support this without
userspace having to do anything to opt-in, then this statement is hard to
digest for me. Existing apps will work. OEMs and vendors who want to enable
this feature must configure their userspace to deal with this correctly. This
includes passing the cmdline option, and parsing the cpumask in
/sys/device/system/cpu/aarch32_el0 to ensure their cpusets contains at least
one cpu from this list.

> 
> > > do about it, we cannot fail the exec because we need this to work for
> > > existing apps, and there is no way the Android framework can know
> > > upfront.
> > 
> > It knows upfront it has enabled asym aarch32. So it needs to make sure not to
> > create 'invalid' cpusets?
> 
> Problem is, we _really_ don't want to keep a big CPU in the background

I don't get you here too.

AFAIU, OEMs have to define their cpusets. So it makes sense to me for them to
define it correctly if they want to enable asym aarch32.

Systems that don't care about this feature shouldn't be affected. If they do,
then I'm missing something.

> cpuset just for that. And even if we did, we'd have to deal with hotplug.

We deal with hotplug by not allowing one of the aarch32 cpus from going
offline.

> 
> > > 
> > > So the only thing we can do really is WARN() and proceed to ignore the
> > > cpuset, which is what this series does :/. It's not exactly pretty but I
> > > don't think we can do much better than that TBH, and it's the same thing
> > > for the example you brought up. Failing cpuset_can_attach() will not
> > > help, we can only WARN and proceed ...
> > 
> > I think for cases where we can prevent userspace from doing something wrong, we
> > should. Like trying to attach to a cpuset that will result in an empty mask.
> > FWIW, it does something similar with deadline tasks. See task_can_attach().
> > 
> > Similarly for the case when userspace tries to modify the cpuset.cpus such that
> > a task will end up with empty cpumask. We now have the new case that some tasks
> > can only run on a subset of cpu_possible_mask. So the definition of empty
> > cpumask has gained an extra meaning.
> 
> I see this differently, e.g. if you affine a task to a CPU and you
> hotunplug it, then the kernel falls back to the remaining online CPUs
> for that task. Not pretty, but it keeps things functional. I'm thinking
> a similar kind of support would be good enough here.

Sorry I can't see it this way :(

The comparison is fundamentally different. Being able to attach to a cpuset, or
modify its cpus is different than short circuiting a cpu out of the system.

For hotplug we have to make sure a single cpu stays alive. The fallback you're
talking about should still work the same if the task is not attached to
a cpuset. Just it has to take the intersection with the
arch_task_cpu_possible_cpu() into account.

For cpusets, if hotunplug results in an empty cpuset, then all tasks are moved
to the nearest ancestor if I read the code correctly. In our case, only 32bit
tasks have to move out to retain this behavior. Since now for the first time we
have tasks that can't run on all cpus.

Which by the way might be the right behavior for 64bit tasks execing 32bit
binary in a 64bit only cpuset. I suggested SIGKILL'ing them but maybe moving
them to the nearest ancestor too is more aligned with the behavior above.

> 
> But yes, this cpuset mess is the part of the series I hate most too.
> It's just not clear we have better solutions :/
> 
> > > 
> > > Now, Android should be fine with that I think. We only need the kernel
> > > to implement a safe fallback mechanism when userspace gives
> > > contradictory commands, because we know there are edge cases userspace
> > > _cannot_ deal with correctly, but this fallback doesn't need to be
> > > highly optimized (at least for Android), but I'm happy to hear what
> > > others think.
> > 
> > Why not go with our original patch that fixes affinity then in the arch code if
> > the task wakes up on the wrong cpu? It is much simpler approach IMO to achieve
> > the same thing.
> 
> I personally had no issues with that patch, but as per Peter's original
> reply, that's "not going to happen". Will's proposal seems to go one
> step further and tries its best to honor the contract with userspace (by

The only difference I see is that this series blocks sched_setaffinity(). Other
than that we fix up the task affinity in a similar way, just in different
places.

If the intersection was empty, we sent a SIGKILL; making it fallback to
something sensible is dead easy. I opted for SIGKILL because I didn't expect
Peter to agree with the fallback. But if we're arguing it's okay now, then it
should be okay in that patch too then.

> keeping the subset of the affinity mask, ...) when that can be done, so
> if that can be acceptable, then be it. But I'd still rather keep this
> simple if at all possible. It's just my opinion though :)

The way I see it, this series adds support to handle generic asym ISA. Asym
AArch32 will be the first and only user for now, but it's paving the way for
others.

It's up to the maintainers to decide, but IMHO if we'll do this via enabling
scheduler to deal with generic asym ISA support, we should deal with these
corner cases. Otherwise a specific solution for the current problem at hand in
the arch code makes more sense to me.

It all depends how much the community wants/is willing to cater for these
systems in the future too.

Thanks

--
Qais Yousef
