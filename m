Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D172DD135
	for <lists+linux-arch@lfdr.de>; Thu, 17 Dec 2020 13:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgLQMQo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Dec 2020 07:16:44 -0500
Received: from foss.arm.com ([217.140.110.172]:60956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgLQMQn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 17 Dec 2020 07:16:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B49E831B;
        Thu, 17 Dec 2020 04:15:57 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 458A53F66B;
        Thu, 17 Dec 2020 04:15:55 -0800 (PST)
Date:   Thu, 17 Dec 2020 12:15:52 +0000
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
Subject: Re: [PATCH v5 07/15] cpuset: Don't use the cpu_possible_mask as a
 last resort for cgroup v1
Message-ID: <20201217121552.ds7g2icvqp5nvtha@e107158-lin.cambridge.arm.com>
References: <20201208132835.6151-1-will@kernel.org>
 <20201208132835.6151-8-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201208132835.6151-8-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/08/20 13:28, Will Deacon wrote:
> If the scheduler cannot find an allowed CPU for a task,
> cpuset_cpus_allowed_fallback() will widen the affinity to cpu_possible_mask
> if cgroup v1 is in use.
> 
> In preparation for allowing architectures to provide their own fallback
> mask, just return early if we're not using cgroup v2 and allow
> select_fallback_rq() to figure out the mask by itself.
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

Why is it safe to return that for cpuset v2? task_cs(tsk)->cpus_allowed is the
original user configured settings of the cpuset.cpus; which could have empty
intersection with task_cpu_possible_mask(), no?

do_set_cpus_allowed() will call set_cpus_allowed_common() which will end up
copying the mask as-is.

So unless I missed something there's a risk a 32bit task ends up having a 64bit
only cpu_mask when using cpuset v2.

Thanks

--
Qais Yousef

>  	rcu_read_unlock();
>  
>  	/*
> -- 
> 2.29.2.576.ga3fc446d84-goog
> 
