Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBDC2C670E
	for <lists+linux-arch@lfdr.de>; Fri, 27 Nov 2020 14:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbgK0Nlz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Nov 2020 08:41:55 -0500
Received: from foss.arm.com ([217.140.110.172]:42216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729742AbgK0Nlz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Nov 2020 08:41:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95CB131B;
        Fri, 27 Nov 2020 05:41:54 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65FED3F70D;
        Fri, 27 Nov 2020 05:41:52 -0800 (PST)
Date:   Fri, 27 Nov 2020 13:41:50 +0000
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
Subject: Re: [PATCH v4 13/14] arm64: Implement arch_task_cpu_possible_mask()
Message-ID: <20201127134150.fzpasxm67umtv4ya@e107158-lin.cambridge.arm.com>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-14-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201124155039.13804-14-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/24/20 15:50, Will Deacon wrote:
> Provide an implementation of arch_task_cpu_possible_mask() so that we
> can prevent 64-bit-only cores being added to the 'cpus_mask' for compat
> tasks on systems with mismatched 32-bit support at EL0,
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/mmu_context.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index 0672236e1aea..641dff35a56f 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h

nit: wouldn't cpufeature.h be a better header? No strong opinion really, it
just looked weird to see this among memory management related code.

Cheers

--
Qais Yousef

> @@ -251,6 +251,19 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  #define deactivate_mm(tsk,mm)	do { } while (0)
>  #define activate_mm(prev,next)	switch_mm(prev, next, current)
>  
> +static inline const struct cpumask *
> +arch_task_cpu_possible_mask(struct task_struct *p)
> +{
> +	if (!static_branch_unlikely(&arm64_mismatched_32bit_el0))
> +		return cpu_possible_mask;
> +
> +	if (!is_compat_thread(task_thread_info(p)))
> +		return cpu_possible_mask;
> +
> +	return system_32bit_el0_cpumask();
> +}
> +#define arch_task_cpu_possible_mask	arch_task_cpu_possible_mask
> +
>  void verify_cpu_asid_bits(void);
>  void post_ttbr_update_workaround(void);
>  
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 
