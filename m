Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C392B90AA
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 12:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgKSLHc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 06:07:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:33432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgKSLHb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Nov 2020 06:07:31 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB98A22248;
        Thu, 19 Nov 2020 11:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605784050;
        bh=IFWCYkPdfqc245s/XXDJ72zIwthXd5CYEww4fQuyMKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=he9WtmW7U8XMQ7IHFIvgoUxjzie8s4Ven1o1/QWXq+g1T/8ZhjiuayVMhWin8Iu9s
         7XH5+ElgMqV7pi+NWIzowDER3ZlzIH8xTevnazQlpph+PupkOe//ZQ5PsY5adsgv/E
         qqTkqyrtXpxBvvfIoPb9HHSqB4k2ffoc3plB/KFU=
Date:   Thu, 19 Nov 2020 11:07:24 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v3 11/14] sched: Reject CPU affinity changes based on
 arch_cpu_allowed_mask()
Message-ID: <20201119110723.GE3946@willie-the-truck>
References: <20201113093720.21106-1-will@kernel.org>
 <20201113093720.21106-12-will@kernel.org>
 <20201119094744.GE2416649@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119094744.GE2416649@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 19, 2020 at 09:47:44AM +0000, Quentin Perret wrote:
> On Friday 13 Nov 2020 at 09:37:16 (+0000), Will Deacon wrote:
> > Reject explicit requests to change the affinity mask of a task via
> > set_cpus_allowed_ptr() if the requested mask is not a subset of the
> > mask returned by arch_cpu_allowed_mask(). This ensures that the
> > 'cpus_mask' for a given task cannot contain CPUs which are incapable of
> > executing it, except in cases where the affinity is forced.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  kernel/sched/core.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 8df38ebfe769..13bdb2ae4d3f 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1877,6 +1877,7 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
> >  					 struct rq_flags *rf)
> >  {
> >  	const struct cpumask *cpu_valid_mask = cpu_active_mask;
> > +	const struct cpumask *cpu_allowed_mask = arch_cpu_allowed_mask(p);
> >  	unsigned int dest_cpu;
> >  	int ret = 0;
> >  
> > @@ -1887,6 +1888,9 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
> >  		 * Kernel threads are allowed on online && !active CPUs
> >  		 */
> >  		cpu_valid_mask = cpu_online_mask;
> > +	} else if (!cpumask_subset(new_mask, cpu_allowed_mask)) {
> > +		ret = -EINVAL;
> > +		goto out;
> 
> So, IIUC, this should make the sched_setaffinity() syscall fail and
> return -EINVAL to userspace if it tries to put 64bits CPUs in the
> affinity mask of a 32 bits task, which I think makes sense.
> 
> But what about affinity change via cpusets? e.g., if a 32 bit task is
> migrated to a cpuset with 64 bit CPUs, then the migration will be
> 'successful' and the task will appear to be in the destination cgroup,
> but the actual affinity of the task will be something completely
> different?

Yeah, the cpuset code ignores the return value of set_cpus_allowed_ptr() in
update_tasks_cpumask() so the failure won't be propagated, but then again I
think that might be the right thing to do. Nothing prevents 32-bit and
64-bit tasks from co-existing in the same cpuseti afaict, so forcing the
64-bit tasks onto the 32-bit-capable cores feels much worse than the
approach taken here imo. Nothing says we _have_ to schedule on all of the
cores in the mask.

The interesting case is what happens if the cpuset for a 32-bit task is
changed to contain only the 64-bit-only cores. I think that's a userspace
bug, but the fallback rq selection should avert disaster.

Will
