Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DB92B8F4D
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 10:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgKSJrw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 04:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgKSJrv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Nov 2020 04:47:51 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D69C0613D4
        for <linux-arch@vger.kernel.org>; Thu, 19 Nov 2020 01:47:49 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r17so5783203wrw.1
        for <linux-arch@vger.kernel.org>; Thu, 19 Nov 2020 01:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g38xN0FDkwhpZzEhM271vqmkWxD69SkDmYogp+3razQ=;
        b=boKOL+16LzadIMhdXR656SedOKYpIvGLcI2AlaTC8Cq/lTr1baf1u6HUNT0bASYkOa
         oAu7td6myhRWROuJEHaBafytCXTqNsIGaFKD6r2Mct8z14nDy99MyyDHmv5KE67UW7IG
         llq1B0K5zfJc6KCxhEQnfYFzwXSeZkQ0S4rtHHbNkXkO6fz8U7dNbxpe1pRGExnF+28q
         rC2hPzCMf0ru3+/G4fUey+Mrm4v0ZgLHqaQfKxA5DTv+WEtv4CugZoqnv4a8FkHi/Dz/
         2o5xBJeoBZjGCYxP8UyZomtfMeQHNYoqI+RKO57kxdbpaKGNkl/mV2xQypznsLu1wTx2
         rnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g38xN0FDkwhpZzEhM271vqmkWxD69SkDmYogp+3razQ=;
        b=Tzwf0i7husaVqJK03Pz701ti88967l3Gd5rSmYs+KOtJLs9f7DA3UczNyjvhZC+o/p
         C2yOdDJOOlUY0xJuaVxSY6/NUI0/f9OtCDvpEGsUmcy9v/oPHkM5OEFxQn7qa7H5Bz1L
         gUaTvfoOhMV5+ZEyH+A3XKZ5ww8qDutPu0VBiVDM1otKl6pzMRbHUD+PKy3mUNrarE/5
         MyvFnIvSIC0SCoD0Yoa9bEWQn4ooz/7o2nRdgohyF6coAsUfq1S97cHtO/8WZX/pPSv7
         GlNgya5WSG4db04CUmSnnlsmGDFawUNR7Ix9w297x6NaklWTlW6TuRZ2Tgolux3KGi6U
         nE8Q==
X-Gm-Message-State: AOAM531IVNfT7C/sR++RyxxavWgd1bl05RxpWsgMya8DjaFvBupT6aaw
        O9hcRuy92tlQg9yqL7bGvbQqsQ==
X-Google-Smtp-Source: ABdhPJzSkfKT2wUMTd6J8oqmowCmaCTnckpBFf352uxLmwWqYQq4slZX+ptNmWR0V342nxkaJPvwNg==
X-Received: by 2002:a5d:4612:: with SMTP id t18mr9098818wrq.401.1605779268509;
        Thu, 19 Nov 2020 01:47:48 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id h20sm8303072wmb.29.2020.11.19.01.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 01:47:48 -0800 (PST)
Date:   Thu, 19 Nov 2020 09:47:44 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
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
Message-ID: <20201119094744.GE2416649@google.com>
References: <20201113093720.21106-1-will@kernel.org>
 <20201113093720.21106-12-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113093720.21106-12-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Friday 13 Nov 2020 at 09:37:16 (+0000), Will Deacon wrote:
> Reject explicit requests to change the affinity mask of a task via
> set_cpus_allowed_ptr() if the requested mask is not a subset of the
> mask returned by arch_cpu_allowed_mask(). This ensures that the
> 'cpus_mask' for a given task cannot contain CPUs which are incapable of
> executing it, except in cases where the affinity is forced.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  kernel/sched/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 8df38ebfe769..13bdb2ae4d3f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1877,6 +1877,7 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
>  					 struct rq_flags *rf)
>  {
>  	const struct cpumask *cpu_valid_mask = cpu_active_mask;
> +	const struct cpumask *cpu_allowed_mask = arch_cpu_allowed_mask(p);
>  	unsigned int dest_cpu;
>  	int ret = 0;
>  
> @@ -1887,6 +1888,9 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
>  		 * Kernel threads are allowed on online && !active CPUs
>  		 */
>  		cpu_valid_mask = cpu_online_mask;
> +	} else if (!cpumask_subset(new_mask, cpu_allowed_mask)) {
> +		ret = -EINVAL;
> +		goto out;

So, IIUC, this should make the sched_setaffinity() syscall fail and
return -EINVAL to userspace if it tries to put 64bits CPUs in the
affinity mask of a 32 bits task, which I think makes sense.

But what about affinity change via cpusets? e.g., if a 32 bit task is
migrated to a cpuset with 64 bit CPUs, then the migration will be
'successful' and the task will appear to be in the destination cgroup,
but the actual affinity of the task will be something completely
different?

That's a bit yuck, but I'm not sure what else can be done here :/

Thanks,
Quentin
