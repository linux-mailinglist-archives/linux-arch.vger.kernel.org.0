Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55720437C46
	for <lists+linux-arch@lfdr.de>; Fri, 22 Oct 2021 19:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbhJVRzD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Oct 2021 13:55:03 -0400
Received: from foss.arm.com ([217.140.110.172]:57268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231472AbhJVRzD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Oct 2021 13:55:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 844181063;
        Fri, 22 Oct 2021 10:52:45 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.73.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 164F03F73D;
        Fri, 22 Oct 2021 10:52:39 -0700 (PDT)
Date:   Fri, 22 Oct 2021 18:52:36 +0100
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
        linux-arch@vger.kernel.org, ardb@kernel.org,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        broonie@kernel.org
Subject: Re: [PATCH 6/7] arch: __get_wchan() || ARCH_STACKWALK
Message-ID: <20211022175236.GJ86184@C02TD0UTHF1T.local>
References: <20211022150933.883959987@infradead.org>
 <20211022152104.487919043@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022152104.487919043@infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 22, 2021 at 05:09:39PM +0200, Peter Zijlstra wrote:
> Use ARCH_STACKWALK to implement a generic __get_wchan().
> 
> STACKTRACE should be possible, but the various implementations of
> stack_trace_save_tsk() are not consistent enough for this to work.
> ARCH_STACKWALK is a smaller set of architectures with a better defined
> interface.
> 
> Since get_wchan() pins the task in a blocked state, it is not
> necessary to take a reference on the task stack, the task isn't going
> anywhere.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/arm/include/asm/processor.h     |    2 -
>  arch/arm/kernel/process.c            |   22 --------------------
>  arch/arm64/include/asm/processor.h   |    2 -
>  arch/arm64/kernel/process.c          |   26 ------------------------
>  arch/powerpc/include/asm/processor.h |    2 -
>  arch/powerpc/kernel/process.c        |   37 -----------------------------------
>  arch/riscv/include/asm/processor.h   |    3 --
>  arch/riscv/kernel/stacktrace.c       |   21 -------------------
>  arch/s390/include/asm/processor.h    |    1 
>  arch/s390/kernel/process.c           |   29 ---------------------------
>  arch/x86/include/asm/processor.h     |    2 -
>  arch/x86/kernel/process.c            |   25 -----------------------
>  kernel/sched/core.c                  |   24 ++++++++++++++++++++++
>  13 files changed, 24 insertions(+), 172 deletions(-)

Nice!

> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -528,32 +528,6 @@ struct task_struct *__switch_to(struct t
>  	return last;
>  }
>  
> -unsigned long __get_wchan(struct task_struct *p)
> -{
> -	struct stackframe frame;
> -	unsigned long stack_page, ret = 0;
> -	int count = 0;
> -
> -	stack_page = (unsigned long)try_get_task_stack(p);
> -	if (!stack_page)
> -		return 0;
> -
> -	start_backtrace(&frame, thread_saved_fp(p), thread_saved_pc(p));
> -
> -	do {
> -		if (unwind_frame(p, &frame))
> -			goto out;
> -		if (!in_sched_functions(frame.pc)) {
> -			ret = frame.pc;
> -			goto out;
> -		}
> -	} while (count++ < 16);
> -
> -out:
> -	put_task_stack(p);
> -	return ret;
> -}

> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1966,6 +1966,30 @@ bool sched_task_on_rq(struct task_struct
>  	return task_on_rq_queued(p);
>  }
>  
> +#ifdef CONFIG_ARCH_STACKWALK
> +
> +static bool consume_wchan(void *cookie, unsigned long addr)
> +{
> +	unsigned long *wchan = cookie;
> +
> +	if (in_sched_functions(addr))
> +		return true;
> +
> +	*wchan = addr;
> +	return false;
> +}
> +
> +static unsigned long __get_wchan(struct task_struct *p)
> +{
> +	unsigned long wchan = 0;
> +
> +	arch_stack_walk(consume_wchan, &wchan, p, NULL);
> +
> +	return wchan;
> +}

It's amazing how much simpler things become with the right
infrastructure!

I gave this a spin on arm64, and /proc/*/wchan looks as expected. The
code looks "obviously correct" to me given the changes in prior patches,
so FWIW:

Reviewed-by: Mark Rutland <mark.rutland@arm.com> [arm64]
Tested-by: Mark Rutland <mark.rutland@arm.com> [arm64]

Thanks,
Mark.
