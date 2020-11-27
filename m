Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D317C2C626D
	for <lists+linux-arch@lfdr.de>; Fri, 27 Nov 2020 11:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgK0KBo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Nov 2020 05:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgK0KBn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Nov 2020 05:01:43 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F1EC0613D1
        for <linux-arch@vger.kernel.org>; Fri, 27 Nov 2020 02:01:43 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p8so4935513wrx.5
        for <linux-arch@vger.kernel.org>; Fri, 27 Nov 2020 02:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DiX1BOjtmBdaUBxd27sZjTmBGtSbOqX8zXkWXxLiRSk=;
        b=GwxYEgELirhM4f500MGN6ZFp3noYdf/8Ef7FA6s88Xk/mMJF0NTCWLt7bn3UMVwQ2j
         ivOYZrZ/U6WwhLiN7txIvY2IzgJMUvzOwnQIBq8nI0aNcWHIyJKov+bVttYznU+BOCsN
         a5/JOAE18R3ga1KK/KLZDXZdf8+YxYQ+mzcil/SUuWnm7J84ouIW1r28MQBtSBzpuOFo
         1Lo0z0RamLAUYRay4Ddq0bEKeuTNXfUTfqnmsnXCne24qUsm3Kmi6ik7yqSiDIpLPBRU
         +CT828fA8QhQP3Xv1H5hmzCx+r8TpgGgLKWFbcbykSNw83H95I43TYImE2HXQ0h7vrgH
         RWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DiX1BOjtmBdaUBxd27sZjTmBGtSbOqX8zXkWXxLiRSk=;
        b=No+fcVwppWtuOEt80hiZOuoIOC4MdWZllYb8W8mnlOrKbDzFArhaJReAHw3NufP4PX
         uPT7o9JEed02jefzruTLaAJuqJSshpRODYoT5o+F8B3EJf/4ZGH4K/ciO23tcLLfvjMU
         y2622kw4g6VCUcEwYalqUvw6Hl0hpC45bsU64O4kq6NN2XR3T2v8Rb1EivmnN6Fdwieu
         InGDmvyJ8LpeNbBI5De45coQN323Y6t/upVUj33bhiPB8Vywft4ZGFjTfOKCYiLhmVhq
         hHe9CvR83TnfGIvFWlxGPxaj6LiakkdpNi5CBIkW4Tp4Xkl6WziWxsGO6MhzDS5mS5b0
         NjEA==
X-Gm-Message-State: AOAM533aQ4C8Uqg1VDEFuwP9RtJXaS/oVPE5BMxztpTmWWoRA7ZbmmrF
        MtKsHje0wCayYN8jzUyjC0ssOUJkiD81gEQ4
X-Google-Smtp-Source: ABdhPJwC7qIr57iRwDeZya4zpiIbaD6hFj4axD8WZpWw0JGDRKDzWKHN8vWhzQjFj6ySkcVIUCt4oQ==
X-Received: by 2002:a5d:56cb:: with SMTP id m11mr9781162wrw.346.1606471301740;
        Fri, 27 Nov 2020 02:01:41 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id e27sm16006352wrc.9.2020.11.27.02.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 02:01:41 -0800 (PST)
Date:   Fri, 27 Nov 2020 10:01:38 +0000
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
Subject: Re: [PATCH v4 08/14] arm64: exec: Adjust affinity for compat tasks
 with mismatched 32-bit EL0
Message-ID: <20201127100138.GC906877@google.com>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-9-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124155039.13804-9-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tuesday 24 Nov 2020 at 15:50:33 (+0000), Will Deacon wrote:
> When exec'ing a 32-bit task on a system with mismatched support for
> 32-bit EL0, try to ensure that it starts life on a CPU that can actually
> run it.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/kernel/process.c | 42 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 1540ab0fbf23..72116b0c7c73 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -31,6 +31,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/init.h>
>  #include <linux/cpu.h>
> +#include <linux/cpuset.h>
>  #include <linux/elfcore.h>
>  #include <linux/pm.h>
>  #include <linux/tick.h>
> @@ -625,6 +626,45 @@ unsigned long arch_align_stack(unsigned long sp)
>  	return sp & ~0xf;
>  }
>  
> +static void adjust_compat_task_affinity(struct task_struct *p)
> +{
> +	cpumask_var_t cpuset_mask;
> +	const struct cpumask *possible_mask = system_32bit_el0_cpumask();
> +	const struct cpumask *newmask = possible_mask;
> +
> +	/*
> +	 * Restrict the CPU affinity mask for a 32-bit task so that it contains
> +	 * only the 32-bit-capable subset of its original CPU mask. If this is
> +	 * empty, then try again with the cpuset allowed mask. If that fails,
> +	 * forcefully override it with the set of all 32-bit-capable CPUs that
> +	 * we know about.
> +	 *
> +	 * From the perspective of the task, this looks similar to what would
> +	 * happen if the 64-bit-only CPUs were hot-unplugged at the point of
> +	 * execve().
> +	 */
> +	if (!restrict_cpus_allowed_ptr(p, possible_mask))
> +		goto out;
> +
> +	if (alloc_cpumask_var(&cpuset_mask, GFP_KERNEL)) {
> +		cpuset_cpus_allowed(p, cpuset_mask);
> +		if (cpumask_and(cpuset_mask, cpuset_mask, possible_mask)) {
> +			newmask = cpuset_mask;
> +			goto out_set_mask;
> +		}
> +	}
> +
> +	if (printk_ratelimit()) {
> +		printk_deferred("Overriding affinity for 32-bit process %d (%s) to CPUs %*pbl\n",
> +				task_pid_nr(p), p->comm, cpumask_pr_args(newmask));
> +	}
> +out_set_mask:
> +	set_cpus_allowed_ptr(p, newmask);
> +	free_cpumask_var(cpuset_mask);
> +out:
> +	set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
> +}

This starts to look an awful lot like select_fallback_rq(), but I
suppose we shouldn't bother factoring out that code yet as we probably
don't want this pattern to be re-used all over, so:

Reviewed-by: Quentin Perret <qperret@google.com>

Thanks,
Quentin
