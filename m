Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166F52DC498
	for <lists+linux-arch@lfdr.de>; Wed, 16 Dec 2020 17:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgLPQtg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Dec 2020 11:49:36 -0500
Received: from foss.arm.com ([217.140.110.172]:34908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbgLPQtg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Dec 2020 11:49:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3DB01FB;
        Wed, 16 Dec 2020 08:48:50 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 318893F66E;
        Wed, 16 Dec 2020 08:48:48 -0800 (PST)
Date:   Wed, 16 Dec 2020 16:48:45 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     surenb@google.com, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v5 00/15] An alternative series for asymmetric AArch32
 systems
Message-ID: <20201216164845.qakwbuhety73lmvr@e107158-lin.cambridge.arm.com>
References: <20201208132835.6151-1-will@kernel.org>
 <20201216111646.omrxyhbobejzqprh@e107158-lin.cambridge.arm.com>
 <20201216141450.GA16421@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201216141450.GA16421@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/16/20 14:14, Will Deacon wrote:
> Hi Qais,
> 
> On Wed, Dec 16, 2020 at 11:16:46AM +0000, Qais Yousef wrote:
> > On 12/08/20 13:28, Will Deacon wrote:
> > > Changes in v5 include:
> > > 
> > >   * Teach cpuset_cpus_allowed() about task_cpu_possible_mask() so that
> > >     we can avoid returning incompatible CPUs for a given task. This
> > >     means that sched_setaffinity() can be used with larger masks (like
> > >     the online mask) from userspace and also allows us to take into
> > >     account the cpuset hierarchy when forcefully overriding the affinity
> > >     for a task on execve().
> > > 
> > >   * Honour task_cpu_possible_mask() when attaching a task to a cpuset,
> > >     so that the resulting affinity mask does not contain any incompatible
> > >     CPUs (since it would be rejected by set_cpus_allowed_ptr() otherwise).
> > > 
> > >   * Moved overriding of the affinity mask into the scheduler core rather
> > >     than munge affinity masks directly in the architecture backend.
> > > 
> > >   * Extended comments and documentation.
> > > 
> > >   * Some renaming and cosmetic changes.
> > > 
> > > I'm pretty happy with this now, although it still needs review and will
> > > require rebasing to play nicely with the SCA changes in -next.
> > 
> > I still have concerns about the cpuset v1 handling. Specifically:
> > 
> > 	1. Attaching a 32bit task to 64bit only cpuset is allowed.
> > 
> > 	   I think the right behavior here is to prevent that as the
> > 	   intersection will appear as offline cpus for the 32bit tasks. So it
> > 	   shouldn't be allowed to move there.
> 
> Suren or Quantin can correct me if I'm wrong I'm here, but I think Android
> relies on this working so it's not an option for us to prevent the attach.

I don't think so. It's just a matter who handles the error. ie: kernel fix it
up silently and effectively make the cpuset a NOP since we don't respect the
affinity of the cpuset, or user space pick the next best thing. Since this
could return an error anyway, likely user space already handles this.

> I also don't think it really achieves much, since as you point out, the same
> problem exists in other cases such as execve() of a 32-bit binary, or
> hotplugging off all 32-bit CPUs within a mixed cpuset. Allowing the attach
> and immediately reparenting would probably be better, but see below.

I am just wary that we're introducing a generic asymmetric ISA support, so my
concerns have been related to making sure the behavior is sane generally. When
this gets merged, I can bet more 'fun' hardware will appear all over the place.
We're opening the flood gates I'm afraid :p

> > 	2. Modifying cpuset.cpus could result with empty set for 32bit tasks.
> > 
> > 	   It is a variation of the above, it's just the cpuset transforms into
> > 	   64bit only after we attach.
> > 
> > 	   I think the right behavior here is to move the 32bit tasks to the
> > 	   nearest ancestor like we do when all cpuset.cpus are hotplugged out.
> > 
> > 	   We could too return an error if the new set will result an empty set
> > 	   for the 32bit tasks. In a similar manner to how it fails if you
> > 	   write a cpu that is offline.
> > 
> > 	3. If a 64bit task belongs to 64bit-only-cpuset execs a 32bit binary,
> > 	   the 32 tasks will inherit the cgroup setting.
> > 
> > 	   Like above, we should move this to the nearest ancestor.
> 
> I considered this when I was writing the patches, but the reality is that
> by allowing 32-bit tasks to attach to a 64-bit only cpuset (which is required
> by Android), we have no choice but to expose a new ABI to userspace. This is
> all gated behind a command-line option, so I think that's fine, but then why
> not just have the same behaviour as cgroup v2? I don't see the point in
> creating two new ABIs (for cgroup v1 and v2 respectively) if we don't need

Ultimately it's up to Tejun and Peter I guess. I thought we need to preserve
the v1 behavior for the new class of tasks. I won't object to the new ABI
myself. Maybe we just need to make the commit messages and cgroup-v1
documentation reflect that explicitly.

> to. If it was _identical_ to the hotplug case, then we would surely just
> follow the existing behaviour, but it's really quite different in this
> situation because the cpuset is not empty.

It is actually effectively empty for those tasks. But I see that one could look
at it from two different angles.

> One thing we should definitely do though is add this to the documentation
> for the command-line option.

+1

By the way, should the command-line option be renamed to something more
generic? This has already grown beyond just enabling the support for one
isolated case. No strong opinion, just a suggestion.

Thanks

--
Qais Yousef
