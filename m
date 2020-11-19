Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98052B8F27
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 10:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgKSJi4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 04:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgKSJi4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Nov 2020 04:38:56 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E84C0613D4
        for <linux-arch@vger.kernel.org>; Thu, 19 Nov 2020 01:38:55 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a65so6113240wme.1
        for <linux-arch@vger.kernel.org>; Thu, 19 Nov 2020 01:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zh6jK0nTwF8Mjff9qMjpCT6FseWaEgBbFKmM+bidrxk=;
        b=FcP//IHNuyf1Vp9U2tB/k1bP76J7+crZ59cPVvIDOTpY9p2EwDRC4nte+8bqd0O1FQ
         4VG0bPOk3gL+NkMBDkNqMtn0nQgRTtk6lGintUAsDa4frSh8rGMfKYDDQqMp62l5fd+C
         6PoaYyp5J3nNUftwG1E0PhGb9lAuOdEENl/SNqCogDRRQqIfJJRrDgyOWcab7glWNI+g
         krBKu+G0QHF9y4/qh+nGfMR0TkuihBile34SqvVd34uRfEpRPFGL45F4io09zYR6lMXI
         5/rdbtWMJRclOKf+/lSiZDOMEL4fQImvtN6GdUtJH1wNRMTyte51BrcApCnXFw4zAy7Y
         XdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zh6jK0nTwF8Mjff9qMjpCT6FseWaEgBbFKmM+bidrxk=;
        b=o64wwcW1oXXSQY1n5p3eLH9XOHKs2kCAfkYQc6AJQeT/AmlRBa8qPhDlCUJZ7P9gsb
         Hs6R4GDx5cDqM4d5tObvkJlHBjdqsqwBM3uA6Sp1iLAgMm+AzjyIlg3j7up4KVVWL4b8
         TfOb1Vtg0qzQcywPMAZXri4aRND13Gqm4YVZFRwKrHQEvYrTXgBA9qV3uRbMJ9aavwNK
         3zv20POK4F2EqtObHOq7CrDaoWdAglgpOJUSo0nZw8hX0BAGZuTXmfGGL4hy63PQbYBl
         5RpsjRkXxwnQeoow12AzgVmBKPcmTRI+AHGp19uRwUn83IA2JiEZJq4X1zNDVhURrFol
         JGiw==
X-Gm-Message-State: AOAM532QaKtoVw4mpNWdvjOneGQaNxU8oewpBCm66dZK74PYuGgyI4kQ
        SgHgc/nBxgYgFOIGnDQIWwu1jQ==
X-Google-Smtp-Source: ABdhPJxxLp0CX7ilKK6FIe9rSVDycd8yjVil3Bjlh72aOQ9txwqOsOBf4t7SQ75Zl4Oh80pXRlmBLg==
X-Received: by 2002:a7b:c05a:: with SMTP id u26mr3710902wmc.159.1605778734546;
        Thu, 19 Nov 2020 01:38:54 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id 31sm16398540wre.43.2020.11.19.01.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 01:38:54 -0800 (PST)
Date:   Thu, 19 Nov 2020 09:38:50 +0000
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
Subject: Re: [PATCH v3 10/14] sched: Introduce arch_cpu_allowed_mask() to
 limit fallback rq selection
Message-ID: <20201119093850.GD2416649@google.com>
References: <20201113093720.21106-1-will@kernel.org>
 <20201113093720.21106-11-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113093720.21106-11-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Friday 13 Nov 2020 at 09:37:15 (+0000), Will Deacon wrote:
> Asymmetric systems may not offer the same level of userspace ISA support
> across all CPUs, meaning that some applications cannot be executed by
> some CPUs. As a concrete example, upcoming arm64 big.LITTLE designs do
> not feature support for 32-bit applications on both clusters.
> 
> On such a system, we must take care not to migrate a task to an
> unsupported CPU when forcefully moving tasks in select_fallback_rq()
> in response to a CPU hot-unplug operation.
> 
> Introduce an arch_cpu_allowed_mask() hook which, given a task argument,
> allows an architecture to return a cpumask of CPUs that are capable of
> executing that task. The default implementation returns the
> cpu_possible_mask, since sane machines do not suffer from per-cpu ISA
> limitations that affect scheduling. The new mask is used when selecting
> the fallback runqueue as a last resort before forcing a migration to the
> first active CPU.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  kernel/sched/core.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 818c8f7bdf2a..8df38ebfe769 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1696,6 +1696,11 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
>  
>  #ifdef CONFIG_SMP
>  
> +/* Must contain at least one active CPU */
> +#ifndef arch_cpu_allowed_mask
> +#define  arch_cpu_allowed_mask(p)	cpu_possible_mask
> +#endif
> +
>  /*
>   * Per-CPU kthreads are allowed to run on !active && online CPUs, see
>   * __set_cpus_allowed_ptr() and select_fallback_rq().
> @@ -1708,7 +1713,10 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
>  	if (is_per_cpu_kthread(p))
>  		return cpu_online(cpu);
>  
> -	return cpu_active(cpu);
> +	if (!cpu_active(cpu))
> +		return false;
> +
> +	return cpumask_test_cpu(cpu, arch_cpu_allowed_mask(p));
>  }
>  
>  /*
> @@ -2361,10 +2369,9 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
>  			}
>  			fallthrough;
>  		case possible:
> -			do_set_cpus_allowed(p, cpu_possible_mask);
> +			do_set_cpus_allowed(p, arch_cpu_allowed_mask(p));

Nit: I'm wondering if this should be called arch_cpu_possible_mask()
instead?

In any case:

Reviewed-by: Quentin Perret <qperret@google.com?

Thanks,
Quentin
