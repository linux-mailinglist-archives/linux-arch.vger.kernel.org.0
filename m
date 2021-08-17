Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EB83EEEF6
	for <lists+linux-arch@lfdr.de>; Tue, 17 Aug 2021 17:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbhHQPLu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Aug 2021 11:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238258AbhHQPLr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Aug 2021 11:11:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF59C061764;
        Tue, 17 Aug 2021 08:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EuJByfvQk0EBkTrYkEfND0mLwG08uWKKtyupgcpfEi8=; b=NVftCgQ+xjBGnrwNBx5ruvegqJ
        FAVc3sV285AjsRH0KssPlRljyVsgHrS49ryXkCZfdr2OrWxuEXOVQ7eL00e+dHX/2qH91U01wLlyA
        pnH1Nf0cLhUZxT/b4LoclXcLvQlyTJJTe/YQhn53JkCaw00IVv1UVwoGZ+Ts2e9o1gGyhYGh3y/Eq
        cfHUYVRU06fBib/zrz7QgfqcJsvcRyeKVH74Km2N9LyD2uLj491uQfgaUR4mOCYoYM2DfoDHFRlvn
        zQ4yEGGHd06hD13wDz0jQCtRPh3ug8n3kHhU2yMX40H6No2wzmRzBrnpTe6WJNZwv/GFjWHzaSKLC
        9t53/qBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mG0jv-00AUjl-Vy; Tue, 17 Aug 2021 15:10:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 006F530009A;
        Tue, 17 Aug 2021 17:10:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ADFC42C8F5E0B; Tue, 17 Aug 2021 17:10:53 +0200 (CEST)
Date:   Tue, 17 Aug 2021 17:10:53 +0200
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
        Valentin Schneider <valentin.schneider@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, kernel-team@android.com
Subject: Re: [PATCH v11 08/16] sched: Allow task CPU affinity to be
 restricted on asymmetric systems
Message-ID: <YRvRfZ/NnuNyIu3s@hirez.programming.kicks-ass.net>
References: <20210730112443.23245-1-will@kernel.org>
 <20210730112443.23245-9-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730112443.23245-9-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 30, 2021 at 12:24:35PM +0100, Will Deacon wrote:
> @@ -2783,20 +2778,173 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>  
>  	__do_set_cpus_allowed(p, new_mask, flags);
>  
> -	return affine_move_task(rq, p, &rf, dest_cpu, flags);
> +	if (flags & SCA_USER)
> +		release_user_cpus_ptr(p);
> +
> +	return affine_move_task(rq, p, rf, dest_cpu, flags);
>  
>  out:
> -	task_rq_unlock(rq, p, &rf);
> +	task_rq_unlock(rq, p, rf);
>  
>  	return ret;
>  }

> +void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
> +{
> +	unsigned long flags;
> +	struct cpumask *mask = p->user_cpus_ptr;
> +
> +	/*
> +	 * Try to restore the old affinity mask. If this fails, then
> +	 * we free the mask explicitly to avoid it being inherited across
> +	 * a subsequent fork().
> +	 */
> +	if (!mask || !__sched_setaffinity(p, mask))
> +		return;
> +
> +	raw_spin_lock_irqsave(&p->pi_lock, flags);
> +	release_user_cpus_ptr(p);
> +	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
> +}

Both these are a problem on RT.

The easiest recourse is simply never freeing the CPU mask (except on
exit). The alternative is something like the below I suppose..

I'm leaning towards the former option, wdyt?

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2733,6 +2733,7 @@ static int __set_cpus_allowed_ptr_locked
 	const struct cpumask *cpu_allowed_mask = task_cpu_possible_mask(p);
 	const struct cpumask *cpu_valid_mask = cpu_active_mask;
 	bool kthread = p->flags & PF_KTHREAD;
+	struct cpumask *user_mask = NULL;
 	unsigned int dest_cpu;
 	int ret = 0;
 
@@ -2792,9 +2793,13 @@ static int __set_cpus_allowed_ptr_locked
 	__do_set_cpus_allowed(p, new_mask, flags);
 
 	if (flags & SCA_USER)
-		release_user_cpus_ptr(p);
+		swap(user_mask, p->user_cpus_ptr);
+
+	ret = affine_move_task(rq, p, rf, dest_cpu, flags);
+
+	kfree(user_mask);
 
-	return affine_move_task(rq, p, rf, dest_cpu, flags);
+	return ret;
 
 out:
 	task_rq_unlock(rq, p, rf);
@@ -2954,8 +2959,10 @@ void relax_compatible_cpus_allowed_ptr(s
 		return;
 
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
-	release_user_cpus_ptr(p);
+	p->user_cpus_ptr = NULL;
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+
+	kfree(mask);
 }
 
 void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
