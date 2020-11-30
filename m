Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006D62C8A71
	for <lists+linux-arch@lfdr.de>; Mon, 30 Nov 2020 18:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgK3RGW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Nov 2020 12:06:22 -0500
Received: from foss.arm.com ([217.140.110.172]:58120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727900AbgK3RGV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Nov 2020 12:06:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEE4A1042;
        Mon, 30 Nov 2020 09:05:35 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C77A3F718;
        Mon, 30 Nov 2020 09:05:33 -0800 (PST)
Date:   Mon, 30 Nov 2020 17:05:31 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v4 09/14] cpuset: Don't use the cpu_possible_mask as a
 last resort for cgroup v1
Message-ID: <20201130170531.qo67rai5lftskmk2@e107158-lin.cambridge.arm.com>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-10-will@kernel.org>
 <20201127133245.4hbx65mo3zinawvo@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201127133245.4hbx65mo3zinawvo@e107158-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/27/20 13:32, Qais Yousef wrote:
> On 11/24/20 15:50, Will Deacon wrote:
> > If the scheduler cannot find an allowed CPU for a task,
> > cpuset_cpus_allowed_fallback() will widen the affinity to cpu_possible_mask
> > if cgroup v1 is in use.
> > 
> > In preparation for allowing architectures to provide their own fallback
> > mask, just return early if we're not using cgroup v2 and allow
> > select_fallback_rq() to figure out the mask by itself.
> 
> What about cpuset_attach()? When a task attaches to a new group its affinity
> could be reset to possible_cpu_mask if it moves to top_cpuset or the
> intersection of effective_cpus & cpu_online_mask.
> 
> Probably handled with later patches.
> 
> /me continue to look at the rest
> 
> Okay so in patch 11 we make set_cpus_allowed_ptr() fail. cpuset_attach will
> just do WARN_ON_ONCE() and carry on.
> 
> I think we can fix that by making sure cpuset_can_attach() will fail. Which can
> be done by fixing task_can_attach() to take into account the new arch
> task_cpu_possible_mask()?

I ran some experiments and indeed we have some problems here :(

I create 3 cpusets: 64bit, 32bit and mix. As the name indicates, 64bit contains
all 64bit-only cpus, 32bit contains 32bit-capable ones and mix has a mixture of
both.

If I try to move my test binary to 64bit cpuset, it moves there and I see the
WARN_ON_ONCE() triggered. The task has attached to the new cpuset but
set_allowed_cpus_ptr() has failed and we end up with whatever affinity we had
previously. Breaking cpusets effectively.

This can be easily fixable with my suggestion to educate task_can_attach() to
take into account the new arch_task_cpu_cpu_possible_mask(). The attachment
will fail and userspace will get an error then.

But this introduces another issue..

If I use cpumask_subset() in task_can_attach(), then an attempt to move to
'mix' cpuset will fail. In Android foreground cpuset usually contains a mixture
of cpus. So we want this to work.

Also 'background' tasks are usually bound to littles. If the littles are 64bit
only, then user space must ensure to add a 32bit capable cpu to the list. If we
can't attach to mixed cpuset, then this workaround won't work and Android will
have to create different cpusets for 32bit and 64bit apps. Which would be
difficult since 64bit apps do embed 32bit binaries and it'd be hard for
userspace to deal with that. Unless we extend execve syscall to take a cgroup
as an arg to attach to (like clone3 syscall), then potentially we can do
something about it, I think, by 'fixing' the libc wrapper.

If I use cpumask_intersects() to validate the attachment, then the 64bit
attachment will fail but the 'mix' one will succeed, as desired. BUT we'll
re-introduce the WARN_ON_ONCE() again since __set_cpus_allowed_ptr_locked()
validates against arch_task_cpu_possible_mask() with cpumask_subset() :-/
ie: cpuset_attach()::set_cpus_allowed_ptr() will fail with just a warning
printed once when attaching to 'mix'.

We can fix this by making __set_cpus_allowed_ptr_locked() perform cpumask_and()
like restrict_cpus_allowed_ptr() does.

Though this will not only truncate cpuset mask with the intersection of
arch_task_cpu_possible_mask(), but also truncate it for sched_setaffinity()
syscall. Something to keep in mind.

Finally there's the ugly problem that I'm not sure how to address of modifying
the cpuset.cpus of, for example 'mix' cpuset, such that we end up with 64bit
only cpus. If the 32bit task has already attached, then we'll end up with
a broken cpuset with a task attached having 'invalid' cpumask.

We can teach cpuset.c:update_cpumask()::validate_change() to do something about
it. By either walking the attached tasks and validating the new mask against
the arch one. Or by storing the arch mask in struct cpuset. Though for the
latter if we want to be truly generic, we need to ensure we handle the case of
2 tasks having different arch_task_cpu_possible_mask().

Long email. Hopefully it makes sense!

I can share my test script, binary/code and fixup patches if you like.

Thanks

--
Qais Yousef
