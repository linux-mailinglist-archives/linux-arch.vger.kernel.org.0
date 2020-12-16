Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9F72DBF43
	for <lists+linux-arch@lfdr.de>; Wed, 16 Dec 2020 12:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgLPLRh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Dec 2020 06:17:37 -0500
Received: from foss.arm.com ([217.140.110.172]:46572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgLPLRh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Dec 2020 06:17:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A0DF31B;
        Wed, 16 Dec 2020 03:16:51 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD4A33F66B;
        Wed, 16 Dec 2020 03:16:48 -0800 (PST)
Date:   Wed, 16 Dec 2020 11:16:46 +0000
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
Subject: Re: [PATCH v5 00/15] An alternative series for asymmetric AArch32
 systems
Message-ID: <20201216111646.omrxyhbobejzqprh@e107158-lin.cambridge.arm.com>
References: <20201208132835.6151-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201208132835.6151-1-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Will

On 12/08/20 13:28, Will Deacon wrote:
> Hi all,
> 
> Christmas has come early: it's time for version five of these patches
> which have previously appeared here:
> 
>   v1: https://lore.kernel.org/r/20201027215118.27003-1-will@kernel.org
>   v2: https://lore.kernel.org/r/20201109213023.15092-1-will@kernel.org
>   v3: https://lore.kernel.org/r/20201113093720.21106-1-will@kernel.org
>   v4: https://lore.kernel.org/r/20201124155039.13804-1-will@kernel.org
> 
> and which started life as a reimplementation of some patches from Qais:
> 
>   https://lore.kernel.org/r/20201021104611.2744565-1-qais.yousef@arm.com
> 
> There's also now a nice writeup on LWN:
> 
>   https://lwn.net/Articles/838339/
> 
> and rumours of a feature film are doing the rounds.
> 
> [subscriber-only, but if you're reading this then you should really
>  subscribe.]
> 
> The aim of this series is to allow 32-bit ARM applications to run on
> arm64 SoCs where not all of the CPUs support the 32-bit instruction set.
> Unfortunately, such SoCs are real and will continue to be productised
> over the next few years at least. I can assure you that I'm not just
> doing this for fun.
> 
> Changes in v5 include:
> 
>   * Teach cpuset_cpus_allowed() about task_cpu_possible_mask() so that
>     we can avoid returning incompatible CPUs for a given task. This
>     means that sched_setaffinity() can be used with larger masks (like
>     the online mask) from userspace and also allows us to take into
>     account the cpuset hierarchy when forcefully overriding the affinity
>     for a task on execve().
> 
>   * Honour task_cpu_possible_mask() when attaching a task to a cpuset,
>     so that the resulting affinity mask does not contain any incompatible
>     CPUs (since it would be rejected by set_cpus_allowed_ptr() otherwise).
> 
>   * Moved overriding of the affinity mask into the scheduler core rather
>     than munge affinity masks directly in the architecture backend.
> 
>   * Extended comments and documentation.
> 
>   * Some renaming and cosmetic changes.
> 
> I'm pretty happy with this now, although it still needs review and will
> require rebasing to play nicely with the SCA changes in -next.

I still have concerns about the cpuset v1 handling. Specifically:

	1. Attaching a 32bit task to 64bit only cpuset is allowed.

	   I think the right behavior here is to prevent that as the
	   intersection will appear as offline cpus for the 32bit tasks. So it
	   shouldn't be allowed to move there.

	2. Modifying cpuset.cpus could result with empty set for 32bit tasks.

	   It is a variation of the above, it's just the cpuset transforms into
	   64bit only after we attach.

	   I think the right behavior here is to move the 32bit tasks to the
	   nearest ancestor like we do when all cpuset.cpus are hotplugged out.

	   We could too return an error if the new set will result an empty set
	   for the 32bit tasks. In a similar manner to how it fails if you
	   write a cpu that is offline.

	3. If a 64bit task belongs to 64bit-only-cpuset execs a 32bit binary,
	   the 32 tasks will inherit the cgroup setting.

	   Like above, we should move this to the nearest ancestor.

I was worried if in a hierarchy the parent cpuset.cpus is modified such that
the childs no longer have a valid cpu for 32bit tasks. But I checked for v1 and
this isn't a problem. You'll get an error if you try to change it in a way that
ends up with an empty cpuset.

I played with v2, and the model allows tasks to remain attached even if cpus
are hotplugged, or cpusets.cpus is modified in such a way we end up with an
empty cpuset. So I think breaking the affinity of the cpuset for v2 is okay.

To simplify the problem for v1, we could say that asym ISA tasks can only live
in the root cpuset for v1. This will simplify the solution too since we will
only need to ensure that these tasks are moved to the root group on exec and
block any future move to anything else. Of course this dictates that such
systems must use cpuset v2 if they care. Not a terrible restriction IMO.

I hacked a patch to fix the exec scenario and it was easy to do. I just need to
block clone3 (cgroup_post_fork()) and task_can_attach() from allowing these
tasks from moving anywhere else.

Thanks

--
Qais Yousef
