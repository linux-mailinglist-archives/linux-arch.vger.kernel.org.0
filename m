Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A1439307E
	for <lists+linux-arch@lfdr.de>; Thu, 27 May 2021 16:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbhE0OMw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 May 2021 10:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236393AbhE0OMw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 May 2021 10:12:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670C4C061574;
        Thu, 27 May 2021 07:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2TpipisoyiQShDSgOrMbU4bXv5bVkfbp9Gedq1CItPw=; b=AuDNkHzJr2U0O4tgmVvipc9ReH
        zfsg1lYGbZkv+GyMUGK0pO6Ey3OnmL6cGSbQhgeD+h/++IOKun0A/CJTC7Oq3KQ2Rdvls0I7j+SM7
        pabNBbaxLMVg+P51fAEw7GrhsJx/aYN2Q4K0Ego2rQi9z86E2avFEp6Jrlwx0GooYwuSgOEnC8EAg
        +ppBM3aLz4A9zI2ih365Q9skPJ55aD495J3pGoMBH61sAk8jXLK7lCKp3l8MelQcP6Lgkp2Z0RfZh
        CaZbXUzqyn2U5LkmMsc+VrW8S+E4hYYsOqiS9fcW4w3lypI8SPZT6MSAISOaswPechPwwm5G+T239
        RirKAXCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lmGiJ-005bkl-QD; Thu, 27 May 2021 14:10:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB855300221;
        Thu, 27 May 2021 16:10:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FD35200E0DD7; Thu, 27 May 2021 16:10:16 +0200 (CEST)
Date:   Thu, 27 May 2021 16:10:16 +0200
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
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        kernel-team@android.com
Subject: Re: [PATCH v7 16/22] sched: Defer wakeup in ttwu() for unschedulable
 frozen tasks
Message-ID: <YK+oSPlNQJKiMYYc@hirez.programming.kicks-ass.net>
References: <20210525151432.16875-1-will@kernel.org>
 <20210525151432.16875-17-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525151432.16875-17-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 25, 2021 at 04:14:26PM +0100, Will Deacon wrote:
> diff --git a/kernel/freezer.c b/kernel/freezer.c
> index dc520f01f99d..8f3d950c2a87 100644
> --- a/kernel/freezer.c
> +++ b/kernel/freezer.c
> @@ -11,6 +11,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/freezer.h>
>  #include <linux/kthread.h>
> +#include <linux/mmu_context.h>
>  
>  /* total number of freezing conditions in effect */
>  atomic_t system_freezing_cnt = ATOMIC_INIT(0);
> @@ -146,9 +147,16 @@ bool freeze_task(struct task_struct *p)
>  void __thaw_task(struct task_struct *p)
>  {
>  	unsigned long flags;
> +	const struct cpumask *mask = task_cpu_possible_mask(p);
>  
>  	spin_lock_irqsave(&freezer_lock, flags);
> -	if (frozen(p))
> +	/*
> +	 * Wake up frozen tasks. On asymmetric systems where tasks cannot
> +	 * run on all CPUs, ttwu() may have deferred a wakeup generated
> +	 * before thaw_secondary_cpus() had completed so we generate
> +	 * additional wakeups here for tasks in the PF_FREEZER_SKIP state.
> +	 */
> +	if (frozen(p) || (frozen_or_skipped(p) && mask != cpu_possible_mask))
>  		wake_up_process(p);
>  	spin_unlock_irqrestore(&freezer_lock, flags);
>  }
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 42e2aecf087c..6cb9677d635a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3529,6 +3529,19 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  	if (!(p->state & state))
>  		goto unlock;
>  
> +#ifdef CONFIG_FREEZER
> +	/*
> +	 * If we're going to wake up a thread which may be frozen, then
> +	 * we can only do so if we have an active CPU which is capable of
> +	 * running it. This may not be the case when resuming from suspend,
> +	 * as the secondary CPUs may not yet be back online. See __thaw_task()
> +	 * for the actual wakeup.
> +	 */
> +	if (unlikely(frozen_or_skipped(p)) &&
> +	    !cpumask_intersects(cpu_active_mask, task_cpu_possible_mask(p)))
> +		goto unlock;
> +#endif
> +
>  	trace_sched_waking(p);
>  
>  	/* We're going to change ->state: */

OK, I really hate this. This is slowing down the very hot wakeup path
for the silly freezer that *never* happens. Let me try and figure out if
there's another option.
