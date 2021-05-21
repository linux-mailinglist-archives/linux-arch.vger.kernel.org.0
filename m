Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D262138CC62
	for <lists+linux-arch@lfdr.de>; Fri, 21 May 2021 19:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbhEURlF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 13:41:05 -0400
Received: from foss.arm.com ([217.140.110.172]:52480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234956AbhEURlC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 13:41:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E389C1424;
        Fri, 21 May 2021 10:39:38 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 953653F73D;
        Fri, 21 May 2021 10:39:36 -0700 (PDT)
Date:   Fri, 21 May 2021 18:39:34 +0100
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
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: Re: [PATCH v6 07/21] cpuset: Don't use the cpu_possible_mask as a
 last resort for cgroup v1
Message-ID: <20210521173934.pjcv37j63odtsrp6@e107158-lin.cambridge.arm.com>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-8-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210518094725.7701-8-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05/18/21 10:47, Will Deacon wrote:
> If the scheduler cannot find an allowed CPU for a task,
> cpuset_cpus_allowed_fallback() will widen the affinity to cpu_possible_mask
> if cgroup v1 is in use.
> 
> In preparation for allowing architectures to provide their own fallback
> mask, just return early if we're either using cgroup v1 or we're using
> cgroup v2 with a mask that contains invalid CPUs. This will allow
> select_fallback_rq() to figure out the mask by itself.
> 
> Cc: Li Zefan <lizefan@huawei.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Quentin Perret <qperret@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  include/linux/cpuset.h |  1 +
>  kernel/cgroup/cpuset.c | 12 ++++++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 04c20de66afc..ed6ec677dd6b 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -15,6 +15,7 @@
>  #include <linux/cpumask.h>
>  #include <linux/nodemask.h>
>  #include <linux/mm.h>
> +#include <linux/mmu_context.h>
>  #include <linux/jump_label.h>
>  
>  #ifdef CONFIG_CPUSETS
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index a945504c0ae7..8c799260a4a2 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3322,9 +3322,17 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
>  
>  void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
>  {
> +	const struct cpumask *cs_mask;
> +	const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
> +
>  	rcu_read_lock();
> -	do_set_cpus_allowed(tsk, is_in_v2_mode() ?
> -		task_cs(tsk)->cpus_allowed : cpu_possible_mask);
> +	cs_mask = task_cs(tsk)->cpus_allowed;
> +
> +	if (!is_in_v2_mode() || !cpumask_subset(cs_mask, possible_mask))
> +		goto unlock; /* select_fallback_rq will try harder */
> +
> +	do_set_cpus_allowed(tsk, cs_mask);

Shouldn't we take the intersection with possible_mask like we discussed before?

	https://lore.kernel.org/lkml/20201217145954.GA17881@willie-the-truck/

Thanks

--
Qais Yousef

> +unlock:
>  	rcu_read_unlock();
>  
>  	/*
> -- 
> 2.31.1.751.gd2f1c929bd-goog
> 
