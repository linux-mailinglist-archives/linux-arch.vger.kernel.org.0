Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9C62C66E2
	for <lists+linux-arch@lfdr.de>; Fri, 27 Nov 2020 14:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgK0Ncv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Nov 2020 08:32:51 -0500
Received: from foss.arm.com ([217.140.110.172]:41950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729169AbgK0Ncu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Nov 2020 08:32:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29F1F31B;
        Fri, 27 Nov 2020 05:32:50 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED1A43F70D;
        Fri, 27 Nov 2020 05:32:47 -0800 (PST)
Date:   Fri, 27 Nov 2020 13:32:45 +0000
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
Message-ID: <20201127133245.4hbx65mo3zinawvo@e107158-lin.cambridge.arm.com>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-10-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201124155039.13804-10-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/24/20 15:50, Will Deacon wrote:
> If the scheduler cannot find an allowed CPU for a task,
> cpuset_cpus_allowed_fallback() will widen the affinity to cpu_possible_mask
> if cgroup v1 is in use.
> 
> In preparation for allowing architectures to provide their own fallback
> mask, just return early if we're not using cgroup v2 and allow
> select_fallback_rq() to figure out the mask by itself.

What about cpuset_attach()? When a task attaches to a new group its affinity
could be reset to possible_cpu_mask if it moves to top_cpuset or the
intersection of effective_cpus & cpu_online_mask.

Probably handled with later patches.

/me continue to look at the rest

Okay so in patch 11 we make set_cpus_allowed_ptr() fail. cpuset_attach will
just do WARN_ON_ONCE() and carry on.

I think we can fix that by making sure cpuset_can_attach() will fail. Which can
be done by fixing task_can_attach() to take into account the new arch
task_cpu_possible_mask()?

Thanks

--
Qais Yousef

> 
> Cc: Li Zefan <lizefan@huawei.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Quentin Perret <qperret@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  kernel/cgroup/cpuset.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 57b5b5d0a5fd..e970737c3ed2 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3299,9 +3299,11 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
>  
>  void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
>  {
> +	if (!is_in_v2_mode())
> +		return; /* select_fallback_rq will try harder */
> +
>  	rcu_read_lock();
> -	do_set_cpus_allowed(tsk, is_in_v2_mode() ?
> -		task_cs(tsk)->cpus_allowed : cpu_possible_mask);
> +	do_set_cpus_allowed(tsk, task_cs(tsk)->cpus_allowed);
>  	rcu_read_unlock();
>  
>  	/*
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 
