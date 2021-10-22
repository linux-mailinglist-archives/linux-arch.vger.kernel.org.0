Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF83437C11
	for <lists+linux-arch@lfdr.de>; Fri, 22 Oct 2021 19:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbhJVRmf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Oct 2021 13:42:35 -0400
Received: from foss.arm.com ([217.140.110.172]:57156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233732AbhJVRmf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Oct 2021 13:42:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AFBE1063;
        Fri, 22 Oct 2021 10:40:17 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.73.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A36323F73D;
        Fri, 22 Oct 2021 10:40:13 -0700 (PDT)
Date:   Fri, 22 Oct 2021 18:40:11 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     keescook@chromium.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        zhengqi.arch@bytedance.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, palmer@dabbelt.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-arch@vger.kernel.org, ardb@kernel.org
Subject: Re: [PATCH 5/7] powerpc, arm64: Mark __switch_to() as __sched
Message-ID: <20211022174011.GI86184@C02TD0UTHF1T.local>
References: <20211022150933.883959987@infradead.org>
 <20211022152104.419533274@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022152104.419533274@infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 22, 2021 at 05:09:38PM +0200, Peter Zijlstra wrote:
> Unlike most of the other architectures, PowerPC and ARM64 have
> __switch_to() as a C function which remains on the stack. 

For clarity, could we say:

  Unlike most of the other architectures, PowerPC and ARM64 have
  __switch_to() as a C function which is visible when unwinding from
  their assembly switch function.

... since both arm64 and powerpc are branch-and-link architectures, and
this isn't stacked; it's in the GPR context saved by the switch
assembly.

> Their
> respective __get_wchan() skips one stack frame unconditionally,
> without testing is_sched_functions().

and similarly s/stack frame/caller/ here.

> 
> Mark them __sched such that we can forgo that special case.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/arm64/kernel/process.c   |    4 ++--
>  arch/powerpc/kernel/process.c |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -490,8 +490,8 @@ void update_sctlr_el1(u64 sctlr)
>  /*
>   * Thread switching.
>   */
> -__notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
> -				struct task_struct *next)
> +__notrace_funcgraph __sched
> +struct task_struct *__switch_to(struct task_struct *prev, struct task_struct *next)

As this only matters for the call to our cpu_switch_to() assembly, this
looks sufficient to me. This only changes the placement of the function
and doesn't affect the existing tracing restrictions, so I don't think
this should have any adverse effect.

For testing, this doesn't adversly affect the existing unwinder (which
should obviously be true since we skip the entry anyway, but hey..).

Regardless of the commit message wording:

Reviewed-by: Mark Rutland <mark.rutland@arm.com> [arm64]
Tested-by: Mark Rutland <mark.rutland@arm.com> [arm64]

Thanks,
Mark.

>  {
>  	struct task_struct *last;
>  
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1201,8 +1201,8 @@ static inline void restore_sprs(struct t
>  
>  }
>  
> -struct task_struct *__switch_to(struct task_struct *prev,
> -	struct task_struct *new)
> +__sched struct task_struct *__switch_to(struct task_struct *prev,
> +					struct task_struct *new)
>  {
>  	struct thread_struct *new_thread, *old_thread;
>  	struct task_struct *last;
> 
> 
