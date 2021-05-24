Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F22338F4BD
	for <lists+linux-arch@lfdr.de>; Mon, 24 May 2021 23:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbhEXVLL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 May 2021 17:11:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232859AbhEXVLL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 May 2021 17:11:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C855610CB;
        Mon, 24 May 2021 21:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621890582;
        bh=bBVvu9BwkIhT16vHfiGspPJX5gwuVmaTgviVfKVqdIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WHCn6Ce0EHaodtDiJVOnsBXQNC0yOJpjA0YfIwBajS0GVFugucJ6l0zWW8X8hvCJI
         FZA1nH/3Q5ZsSNr1ON+4enMaCgetcouIZdMadWHrb7FGDLtBhjEGEPKG200zH5GfpP
         ECyFnXcrwN9/+A0/ZAmPMLDwncRS6zSnC4lV3af9UCO1i0ZlHZu8j7AcsLZ7IT9mxp
         v87mVz5WWduDxocUBxYGKe3aYZtj5dvAZR9vvc6cTsVyfLSHNExh9Afr7312n3M5IB
         aPpzvqw4wYwrNYSXN5wxvyzsY9i3knGPzI02oqfKyjSdmdLjG9YkgwlTqdSGQhIYdx
         djAVHD3EcLxhA==
Date:   Mon, 24 May 2021 22:09:36 +0100
From:   Will Deacon <will@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
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
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: Re: [PATCH v6 08/21] cpuset: Honour task_cpu_possible_mask() in
 guarantee_online_cpus()
Message-ID: <20210524210935.GF15545@willie-the-truck>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-9-will@kernel.org>
 <20210521162524.22cwmrao3df7m4jb@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521162524.22cwmrao3df7m4jb@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 21, 2021 at 05:25:24PM +0100, Qais Yousef wrote:
> On 05/18/21 10:47, Will Deacon wrote:
> > Asymmetric systems may not offer the same level of userspace ISA support
> > across all CPUs, meaning that some applications cannot be executed by
> > some CPUs. As a concrete example, upcoming arm64 big.LITTLE designs do
> > not feature support for 32-bit applications on both clusters.
> > 
> > Modify guarantee_online_cpus() to take task_cpu_possible_mask() into
> > account when trying to find a suitable set of online CPUs for a given
> > task. This will avoid passing an invalid mask to set_cpus_allowed_ptr()
> > during ->attach() and will subsequently allow the cpuset hierarchy to be
> > taken into account when forcefully overriding the affinity mask for a
> > task which requires migration to a compatible CPU.
> > 
> > Cc: Li Zefan <lizefan@huawei.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  include/linux/cpuset.h |  2 +-
> >  kernel/cgroup/cpuset.c | 33 +++++++++++++++++++--------------
> >  2 files changed, 20 insertions(+), 15 deletions(-)
> > 
> > diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> > index ed6ec677dd6b..414a8e694413 100644
> > --- a/include/linux/cpuset.h
> > +++ b/include/linux/cpuset.h
> > @@ -185,7 +185,7 @@ static inline void cpuset_read_unlock(void) { }
> >  static inline void cpuset_cpus_allowed(struct task_struct *p,
> >  				       struct cpumask *mask)
> >  {
> > -	cpumask_copy(mask, cpu_possible_mask);
> > +	cpumask_copy(mask, task_cpu_possible_mask(p));
> >  }
> >  
> >  static inline void cpuset_cpus_allowed_fallback(struct task_struct *p)
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index 8c799260a4a2..b532a5333ff9 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -372,18 +372,26 @@ static inline bool is_in_v2_mode(void)
> >  }
> >  
> >  /*
> > - * Return in pmask the portion of a cpusets's cpus_allowed that
> > - * are online.  If none are online, walk up the cpuset hierarchy
> > - * until we find one that does have some online cpus.
> > + * Return in pmask the portion of a task's cpusets's cpus_allowed that
> > + * are online and are capable of running the task.  If none are found,
> > + * walk up the cpuset hierarchy until we find one that does have some
> > + * appropriate cpus.
> >   *
> >   * One way or another, we guarantee to return some non-empty subset
> >   * of cpu_online_mask.
> >   *
> >   * Call with callback_lock or cpuset_mutex held.
> >   */
> > -static void guarantee_online_cpus(struct cpuset *cs, struct cpumask *pmask)
> > +static void guarantee_online_cpus(struct task_struct *tsk,
> > +				  struct cpumask *pmask)
> >  {
> > -	while (!cpumask_intersects(cs->effective_cpus, cpu_online_mask)) {
> > +	struct cpuset *cs = task_cs(tsk);
> 
> task_cs() requires rcu_read_lock(), but I can't see how the lock is obtained
> from cpuset_attach() path, did I miss it? Running with lockdep should spill
> suspicious RCU usage warning.
> 
> Maybe it makes more sense to move the rcu_read_lock() inside the function now
> with task_cs()?

Well spotted! I'll add the rcu_read_[un]lock() calls to
guarantee_online_cpus().

Will
