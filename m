Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96AA2B8EB0
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 10:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgKSJYN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 04:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbgKSJYN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Nov 2020 04:24:13 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C07C0613CF
        for <linux-arch@vger.kernel.org>; Thu, 19 Nov 2020 01:24:12 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id s8so5607609wrw.10
        for <linux-arch@vger.kernel.org>; Thu, 19 Nov 2020 01:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zaC6HLGL+omaruF7IeeV6ol/EWI+2CFXnsLBGa9N2h8=;
        b=ln4/GRPsn1eE/mc4KtEhAra4RNxg2QN/XCka1Lm+SO2cFGcTgSz9JuA78/6LQkmPyJ
         nkkLeNCQ/OYPaQ9dGsJCCZmb9NJstm4EHu/gk4E23pILzrpw81pglIJJYC7PsR0UPMZe
         Y1NKVSYJ3N3sv3kd7Fzh1JfdJuqUw7HtX3G8hRSz0ga1xYFJ2r2G2QuGMfuivBO7cIX9
         E+Kk+0rSrYUicEpXsxUtZrPPpBoJtTy0ll5MkIi93UttK3WoWY0WfDcBIvnQfeji71wh
         KxXGz5pCBE2HIrHwg7D+bsoiUqqH/CeRN5FI3v2GoZUodzlwHRNctRvsX0ysVcbdQSRV
         Haew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zaC6HLGL+omaruF7IeeV6ol/EWI+2CFXnsLBGa9N2h8=;
        b=OfVa7CmmgvQAEk/T4wxcoUk7Lt2AKSNbGe7UNWP8mbSMGgEa9+GxTxTQJJCdT4s+Rc
         NQvM7VlM+ja2uikgtPuA6s3xOn/BQ2zzfqy83wni19W0Ko48r7oDZ7Q/VTkYhxdSvr5n
         4Wxv3Rezv/T3bhBj7g/VNhW0xvSag2Pv45b8us04Zy7c/mFQI5xE6TWcErPAln7MGLND
         loeCML2XvOVUb4qIODLQz7Z2iMgM9oD5qzt+PrFtyckDft3vnBwcsUVI3PA7f7+ITF2k
         g4MySj6/cT5QjNFyuZOgLgIm7EwGx/MuWm2Nlybqrpqmx6qS4ULEi/5mZr0mNM5VXMc4
         1rrQ==
X-Gm-Message-State: AOAM531QJ8EsgXwqKAaBnSr9YbHFbtzGYhy7VK0+JhUFK+kWHO1zFrqt
        PGNyzRgqz1IsZ8TDfUWksJBvGw==
X-Google-Smtp-Source: ABdhPJzg7aVYJrdLm/oL4IR42qo7g1ZbElMa34XwzM/Q9EDRF18UfbTJHr9aX3EK8RKHDuNBE14BdQ==
X-Received: by 2002:adf:c147:: with SMTP id w7mr9965825wre.60.1605777851508;
        Thu, 19 Nov 2020 01:24:11 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id l3sm9717175wmf.0.2020.11.19.01.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 01:24:11 -0800 (PST)
Date:   Thu, 19 Nov 2020 09:24:07 +0000
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
Subject: Re: [PATCH v3 08/14] arm64: exec: Adjust affinity for compat tasks
 with mismatched 32-bit EL0
Message-ID: <20201119092407.GB2416649@google.com>
References: <20201113093720.21106-1-will@kernel.org>
 <20201113093720.21106-9-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113093720.21106-9-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Friday 13 Nov 2020 at 09:37:13 (+0000), Will Deacon wrote:
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

My understanding of this call to set_cpus_allowed_ptr() is that you're
mimicking the hotplug vs affinity case behaviour in some ways. That is,
if a task is pinned to a CPU and userspace hotplugs that CPU, then the
kernel will reset the affinity of the task to the remaining online CPUs.

I guess that is a sensible fallback path when userspace gives
contradictory commands to the kernel, but that most certainly deserves a
comment :)

> +
> +	set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
> +}
>  
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
