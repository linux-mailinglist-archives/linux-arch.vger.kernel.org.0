Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69472B978D
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 17:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgKSQPD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 11:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbgKSQPD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Nov 2020 11:15:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15943C0613CF;
        Thu, 19 Nov 2020 08:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d5rQ16w64peZRzRHWzAxkB2LwT7DS/SXDMY8OqFuQNY=; b=YJwUoJv45W97ErJVfazec+sHxs
        hq51UV+/nTAfEiPVZEwD9mrusLQ/nV3TnwhRIHICcchcHbPvnr44cSBqaidFOm52WsqmnykhIZ9n+
        BvHt1pvgQS/fEAKZ3pBlHYKl7j1s/Kbdn0ykKIYiBsOWDOOfs58Cwn1eLBoVpcBtpxoBygPKwYXrM
        SL/XpGqevieEZW8Npvo62E+aE8sjYa0Zlr8cETEMJAEIowdw0kKU/uDtKnLwtieWmb6y9GcHGpgPW
        L2gNFgTO1vuLoabvLfZe0rCzqU4jgiXWbqPW4rR5bf1uASwPIOoMYbk4lyjD5XkQzB03NF1V6ZpP1
        wNQCVqKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfmaA-0006zX-SH; Thu, 19 Nov 2020 16:14:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ABB5F3019CE;
        Thu, 19 Nov 2020 17:14:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8703A203C45DF; Thu, 19 Nov 2020 17:14:48 +0100 (CET)
Date:   Thu, 19 Nov 2020 17:14:48 +0100
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
        kernel-team@android.com
Subject: Re: [PATCH v3 08/14] arm64: exec: Adjust affinity for compat tasks
 with mismatched 32-bit EL0
Message-ID: <20201119161448.GR3121392@hirez.programming.kicks-ass.net>
References: <20201113093720.21106-1-will@kernel.org>
 <20201113093720.21106-9-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113093720.21106-9-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 13, 2020 at 09:37:13AM +0000, Will Deacon wrote:
> When exec'ing a 32-bit task on a system with mismatched support for
> 32-bit EL0, try to ensure that it starts life on a CPU that can actually
> run it.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/kernel/process.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 1540ab0fbf23..17b94007fed4 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -625,6 +625,16 @@ unsigned long arch_align_stack(unsigned long sp)
>  	return sp & ~0xf;
>  }
>  
> +static void adjust_compat_task_affinity(struct task_struct *p)
> +{
> +	const struct cpumask *mask = system_32bit_el0_cpumask();
> +
> +	if (restrict_cpus_allowed_ptr(p, mask))
> +		set_cpus_allowed_ptr(p, mask);

This silently destroys user state, at the very least that ought to go
with a WARN or something. Ideally SIGKILL though. What's to stop someone
from doing a sched_setaffinity() right after the execve, same problem.
So why bother..

> +
> +	set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
> +}
> +
>  /*
>   * Called from setup_new_exec() after (COMPAT_)SET_PERSONALITY.
>   */
> @@ -635,7 +645,7 @@ void arch_setup_new_exec(void)
>  	if (is_compat_task()) {
>  		mmflags = MMCF_AARCH32;
>  		if (static_branch_unlikely(&arm64_mismatched_32bit_el0))
> -			set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
> +			adjust_compat_task_affinity(current);
>  	}
>  
>  	current->mm->context.flags = mmflags;
> -- 
> 2.29.2.299.gdc1121823c-goog
> 
