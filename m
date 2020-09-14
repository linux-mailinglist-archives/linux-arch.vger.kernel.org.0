Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA5B2689A8
	for <lists+linux-arch@lfdr.de>; Mon, 14 Sep 2020 12:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgINK44 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Sep 2020 06:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgINK4x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Sep 2020 06:56:53 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E257DC06174A;
        Mon, 14 Sep 2020 03:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=12iDO9zK0M5MrFc9v9LnmYPbTArC0uf4AF99UCMX0/g=; b=MypNEzMCKsV0kDjFZpdYlzLbrc
        6jVvG6vst2kP1TuKPU0RbKSwT4f5aXkemcmA++NmHlfjANB+KOIuYBTFK+U4dDrGkq08pVvTYuCGr
        64XrtFpwD+zaYM0wPLqkolL1pXzmez6O2GauA4GZxoZWC2JUCo58zMGjmZ4KQyykyxoC3pE4HFsOV
        wOdaJZ4wz5kYT0uT7MPzM6GQxyCQ6sVHR+Fiqkx1/HH5YcgPYsMoXksVoBOfa6PPoTtsC/17phU5P
        0FBTRJC5a6qRi0OxEvGOoCLGZsWCVmH7DaTXnCWgOL7BmL6M13ECbEyckAnfF5siMO3wHN+5pxlQD
        k7eINU4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHm9l-0001Ya-CT; Mon, 14 Sep 2020 10:56:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8D20A30257C;
        Mon, 14 Sep 2020 12:56:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 694F52CA75A81; Mon, 14 Sep 2020 12:56:17 +0200 (CEST)
Date:   Mon, 14 Sep 2020 12:56:17 +0200
From:   peterz@infradead.org
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2 1/4] mm: fix exec activate_mm vs TLB shootdown and
 lazy tlb switching race
Message-ID: <20200914105617.GP1362448@hirez.programming.kicks-ass.net>
References: <20200914045219.3736466-1-npiggin@gmail.com>
 <20200914045219.3736466-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914045219.3736466-2-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 14, 2020 at 02:52:16PM +1000, Nicholas Piggin wrote:
> Reading and modifying current->mm and current->active_mm and switching
> mm should be done with irqs off, to prevent races seeing an intermediate
> state.
> 
> This is similar to commit 38cf307c1f20 ("mm: fix kthread_use_mm() vs TLB
> invalidate"). At exec-time when the new mm is activated, the old one
> should usually be single-threaded and no longer used, unless something
> else is holding an mm_users reference (which may be possible).
> 
> Absent other mm_users, there is also a race with preemption and lazy tlb
> switching. Consider the kernel_execve case where the current thread is
> using a lazy tlb active mm:
> 
>   call_usermodehelper()
>     kernel_execve()
>       old_mm = current->mm;
>       active_mm = current->active_mm;
>       *** preempt *** -------------------->  schedule()
>                                                prev->active_mm = NULL;
>                                                mmdrop(prev active_mm);
>                                              ...
>                       <--------------------  schedule()
>       current->mm = mm;
>       current->active_mm = mm;
>       if (!old_mm)
>           mmdrop(active_mm);
> 
> If we switch back to the kernel thread from a different mm, there is a
> double free of the old active_mm, and a missing free of the new one.
> 
> Closing this race only requires interrupts to be disabled while ->mm
> and ->active_mm are being switched, but the TLB problem requires also
> holding interrupts off over activate_mm. Unfortunately not all archs
> can do that yet, e.g., arm defers the switch if irqs are disabled and
> expects finish_arch_post_lock_switch() to be called to complete the
> flush; um takes a blocking lock in activate_mm().
> 
> So as a first step, disable interrupts across the mm/active_mm updates
> to close the lazy tlb preempt race, and provide an arch option to
> extend that to activate_mm which allows architectures doing IPI based
> TLB shootdowns to close the second race.
> 
> This is a bit ugly, but in the interest of fixing the bug and backporting
> before all architectures are converted this is a compromise.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I'm thinking we want this selected on x86 as well. Andy?

> ---
>  arch/Kconfig |  7 +++++++
>  fs/exec.c    | 17 +++++++++++++++--
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index af14a567b493..94821e3f94d1 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -414,6 +414,13 @@ config MMU_GATHER_NO_GATHER
>  	bool
>  	depends on MMU_GATHER_TABLE_FREE
>  
> +config ARCH_WANT_IRQS_OFF_ACTIVATE_MM
> +	bool
> +	help
> +	  Temporary select until all architectures can be converted to have
> +	  irqs disabled over activate_mm. Architectures that do IPI based TLB
> +	  shootdowns should enable this.
> +
>  config ARCH_HAVE_NMI_SAFE_CMPXCHG
>  	bool
>  
> diff --git a/fs/exec.c b/fs/exec.c
> index a91003e28eaa..d4fb18baf1fb 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1130,11 +1130,24 @@ static int exec_mmap(struct mm_struct *mm)
>  	}
>  
>  	task_lock(tsk);
> -	active_mm = tsk->active_mm;
>  	membarrier_exec_mmap(mm);
> -	tsk->mm = mm;
> +
> +	local_irq_disable();
> +	active_mm = tsk->active_mm;
>  	tsk->active_mm = mm;
> +	tsk->mm = mm;
> +	/*
> +	 * This prevents preemption while active_mm is being loaded and
> +	 * it and mm are being updated, which could cause problems for
> +	 * lazy tlb mm refcounting when these are updated by context
> +	 * switches. Not all architectures can handle irqs off over
> +	 * activate_mm yet.
> +	 */
> +	if (!IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
> +		local_irq_enable();
>  	activate_mm(active_mm, mm);
> +	if (IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
> +		local_irq_enable();
>  	tsk->mm->vmacache_seqnum = 0;
>  	vmacache_flush(tsk);
>  	task_unlock(tsk);
> -- 
> 2.23.0
> 
