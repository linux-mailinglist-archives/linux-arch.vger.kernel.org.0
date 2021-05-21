Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5C738CA91
	for <lists+linux-arch@lfdr.de>; Fri, 21 May 2021 18:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhEUQGD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 12:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhEUQGC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 May 2021 12:06:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264B8C061574;
        Fri, 21 May 2021 09:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rOUSMzUazFVWTtdtGXWIZ9Ml1r75lqXoNz586zbgxOE=; b=nNRqUIHd25G1YFdETP5KXvxo6m
        5UQvVEciIApRzCglIzquESH/jC97Kr9NVZNfUWodXMc0XYBhYYrSBZK29fE3tH5VFXKXGyQJZ1juI
        ryVsHOxYFrH5q7LISOk3/00iqTR6hq/Q3cgCBzjzpzCgY9j7TeaNk1LM+DGNRlTqA6UJffy8w7T0B
        +ee/iyr//K8+EcY5cIcWU3DldmkaGWfm3mjEvXVZyPnuQ8L6QFiVHgUlDFxen1TeeeJulIIY3ohqt
        5ZQcHdEVSR+Ww2IGDuMCmEOxKR4/dGyVJCrik7zYMcX+SyWOGC8sRZ6WO5/FY4HJn9QNWg1U5C3Xs
        QYVuzQRw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lk7co-0003fs-5O; Fri, 21 May 2021 16:03:49 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D90FE981F05; Fri, 21 May 2021 18:03:44 +0200 (CEST)
Date:   Fri, 21 May 2021 18:03:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: Re: [PATCH v6 06/21] sched: Introduce task_cpu_possible_mask() to
 limit fallback rq selection
Message-ID: <20210521160344.GJ5618@worktop.programming.kicks-ass.net>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-7-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518094725.7701-7-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 18, 2021 at 10:47:10AM +0100, Will Deacon wrote:
> diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
> index 03dee12d2b61..bc4ac3c525e6 100644
> --- a/include/linux/mmu_context.h
> +++ b/include/linux/mmu_context.h
> @@ -14,4 +14,12 @@
>  static inline void leave_mm(int cpu) { }
>  #endif
>  
> +/*
> + * CPUs that are capable of running task @p. By default, we assume a sane,
> + * homogeneous system. Must contain at least one active CPU.
> + */
> +#ifndef task_cpu_possible_mask
> +# define task_cpu_possible_mask(p)	cpu_possible_mask
> +#endif

#ifndef task_cpu_possible_mask
# define task_cpu_possible_mask(p)	cpu_possible_mask
# define task_cpu_possible(cpu, p)	true
#else
# define task_cpu_possible(cpu, p)	cpumask_test_cpu((cpu), task_cpu_possible_mask(p))
#endif

> +
>  #endif
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5226cc26a095..482f7fdca0e8 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1813,8 +1813,11 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
>  		return cpu_online(cpu);
>  
>  	/* Non kernel threads are not allowed during either online or offline. */
>  	if (!(p->flags & PF_KTHREAD))
> -		return cpu_active(cpu);
+		return cpu_active(cpu) && task_cpu_possible(cpu, p);

>  	/* KTHREAD_IS_PER_CPU is always allowed. */
>  	if (kthread_is_per_cpu(p))

Would something like that make sense?
