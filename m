Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FB021AC24
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jul 2020 02:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgGJApn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 20:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgGJApn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 20:45:43 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF46C08C5CE
        for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2020 17:45:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B2vTv36nyz9sRR;
        Fri, 10 Jul 2020 10:45:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1594341940; bh=axuTFacv0vlR2b4eDxzmyLAJ+X2RFqq+HZ3USl8MHLM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pzt9/VtLxnaI9srBSJ2NpAJcl61PrkmWlF6f36PkF0j9XhGmsxxuJ/DWImOu1NVVl
         1CKmVkfpK7lDWFUXqJr8EY/ZeXC9fZaw2QITDFqESpqv1c6Qc6U3OBfiO+MsKVuco8
         R/qEc01q61jGMCcPU7R5R+9naQRkoNoV7YKTWXQUjIEtIYEgYLqHKpBlX4M3yzmLc+
         Rnp3F7dZ/7z/LM0+HnhIks6Sybp7vYUnaQ7nWrj7bhYWd+VTjlmExmRMGTXUV389XH
         02FmxVwopm1IE+gz/KzQzCeSClbuYuFcWTuCepGyFDBiSoR5vSJNWLnvrAXyetbBrH
         qaRPCq3xR/98g==
Date:   Fri, 10 Jul 2020 10:45:38 +1000
From:   Anton Blanchard <anton@ozlabs.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC][PATCH] avoid refcounting the lazy tlb mm struct
Message-ID: <20200710104538.71b510d7@kryten.localdomain>
In-Reply-To: <1594019787.286knc5cet.astroid@bobo.none>
References: <1594019787.286knc5cet.astroid@bobo.none>
X-Mailer: Mutt/1.8.0 (2017-02-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Nick,

> On big systems, the mm refcount can become highly contented when doing
> a lot of context switching with threaded applications (particularly
> switching between the idle thread and an application thread).
> 
> Not doing lazy tlb at all slows switching down quite a bit, so I
> wonder if we can avoid the refcount for the lazy tlb, but have
> __mmdrop() IPI all CPUs that might be using this mm lazily.
> 
> This patch has only had light testing so far, but seems to work okay.

I tested this patch on a large POWER8 system with 1536 hardware threads.
I can create a worst case situation for mm refcounting by using
the threaded context switch test in will-it-scale set to half the
number of available CPUs (768).

With that workload the patch improves the context switch rate by 118x!

Tested-by: Anton Blanchard <anton@ozlabs.org>

Thanks,
Anton

> diff --git a/arch/Kconfig b/arch/Kconfig
> index 8cc35dc556c7..69ea7172db3d 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -411,6 +411,16 @@ config MMU_GATHER_NO_GATHER
>  	bool
>  	depends on MMU_GATHER_TABLE_FREE
>  
> +config MMU_LAZY_TLB_SHOOTDOWN
> +	bool
> +	help
> +	  Instead of refcounting the "lazy tlb" mm struct, which can
> cause
> +	  contention with multi-threaded apps on large
> multiprocessor systems,
> +	  this option causes __mmdrop to IPI all CPUs in the
> mm_cpumask and
> +	  switch to init_mm if they were using the to-be-freed mm as
> the lazy
> +	  tlb. Architectures which do not track all possible lazy
> tlb CPUs in
> +	  mm_cpumask can not use this (without modification).
> +
>  config ARCH_HAVE_NMI_SAFE_CMPXCHG
>  	bool
>  
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 920c4e3ca4ef..24ac85c868db 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -225,6 +225,7 @@ config PPC
>  	select HAVE_PERF_USER_STACK_DUMP
>  	select MMU_GATHER_RCU_TABLE_FREE
>  	select MMU_GATHER_PAGE_SIZE
> +	select MMU_LAZY_TLB_SHOOTDOWN
>  	select HAVE_REGS_AND_STACK_ACCESS_API
>  	select HAVE_RELIABLE_STACKTRACE		if
> PPC_BOOK3S_64 && CPU_LITTLE_ENDIAN select HAVE_SYSCALL_TRACEPOINTS
> diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c
> b/arch/powerpc/mm/book3s64/radix_tlb.c index
> b5cc9b23cf02..52730629b3eb 100644 ---
> a/arch/powerpc/mm/book3s64/radix_tlb.c +++
> b/arch/powerpc/mm/book3s64/radix_tlb.c @@ -652,10 +652,10 @@ static
> void do_exit_flush_lazy_tlb(void *arg)
>  		 * Must be a kernel thread because sender is
> single-threaded. */
>  		BUG_ON(current->mm);
> -		mmgrab(&init_mm);
> +		mmgrab_lazy_tlb(&init_mm);
>  		switch_mm(mm, &init_mm, current);
>  		current->active_mm = &init_mm;
> -		mmdrop(mm);
> +		mmdrop_lazy_tlb(mm);
>  	}
>  	_tlbiel_pid(pid, RIC_FLUSH_ALL);
>  }
> diff --git a/fs/exec.c b/fs/exec.c
> index e6e8a9a70327..6c96c8feba1f 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1119,7 +1119,7 @@ static int exec_mmap(struct mm_struct *mm)
>  		mmput(old_mm);
>  		return 0;
>  	}
> -	mmdrop(active_mm);
> +	mmdrop_lazy_tlb(active_mm);
>  	return 0;
>  }
>  
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 480a4d1b7dd8..ef28059086a1 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -51,6 +51,25 @@ static inline void mmdrop(struct mm_struct *mm)
>  
>  void mmdrop(struct mm_struct *mm);
>  
> +static inline void mmgrab_lazy_tlb(struct mm_struct *mm)
> +{
> +	if (!IS_ENABLED(CONFIG_MMU_LAZY_TLB_SHOOTDOWN))
> +		mmgrab(mm);
> +}
> +
> +static inline void mmdrop_lazy_tlb(struct mm_struct *mm)
> +{
> +	if (!IS_ENABLED(CONFIG_MMU_LAZY_TLB_SHOOTDOWN))
> +		mmdrop(mm);
> +}
> +
> +static inline void mmdrop_lazy_tlb_smp_mb(struct mm_struct *mm)
> +{
> +	mmdrop_lazy_tlb(mm);
> +	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_SHOOTDOWN))
> +		smp_mb();
> +}
> +
>  /*
>   * This has to be called after a get_task_mm()/mmget_not_zero()
>   * followed by taking the mmap_lock for writing before modifying the
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 142b23645d82..e3f1039cee9f 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -685,6 +685,34 @@ static void check_mm(struct mm_struct *mm)
>  #define allocate_mm()	(kmem_cache_alloc(mm_cachep,
> GFP_KERNEL)) #define free_mm(mm)	(kmem_cache_free(mm_cachep,
> (mm))) 
> +static void do_shoot_lazy_tlb(void *arg)
> +{
> +	struct mm_struct *mm = arg;
> +
> +	if (current->active_mm == mm) {
> +		BUG_ON(current->mm);
> +		switch_mm(mm, &init_mm, current);
> +		current->active_mm = &init_mm;
> +	}
> +}
> +
> +static void do_check_lazy_tlb(void *arg)
> +{
> +	struct mm_struct *mm = arg;
> +
> +	BUG_ON(current->active_mm == mm);
> +}
> +
> +void shoot_lazy_tlbs(struct mm_struct *mm)
> +{
> +	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_SHOOTDOWN)) {
> +		smp_call_function_many(mm_cpumask(mm),
> do_shoot_lazy_tlb, (void *)mm, 1);
> +		do_shoot_lazy_tlb(mm);
> +	}
> +	smp_call_function(do_check_lazy_tlb, (void *)mm, 1);
> +	do_check_lazy_tlb(mm);
> +}
> +
>  /*
>   * Called when the last reference to the mm
>   * is dropped: either by a lazy thread or by
> @@ -692,6 +720,7 @@ static void check_mm(struct mm_struct *mm)
>   */
>  void __mmdrop(struct mm_struct *mm)
>  {
> +	shoot_lazy_tlbs(mm);
>  	BUG_ON(mm == &init_mm);
>  	WARN_ON_ONCE(mm == current->mm);
>  	WARN_ON_ONCE(mm == current->active_mm);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ca5db40392d4..4d615e0be9e0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3308,7 +3308,7 @@ static struct rq *finish_task_switch(struct
> task_struct *prev) */
>  	if (mm) {
>  		membarrier_mm_sync_core_before_usermode(mm);
> -		mmdrop(mm);
> +		mmdrop_lazy_tlb_smp_mb(mm);
>  	}
>  	if (unlikely(prev_state == TASK_DEAD)) {
>  		if (prev->sched_class->task_dead)
> @@ -3413,9 +3413,9 @@ context_switch(struct rq *rq, struct
> task_struct *prev, 
>  	/*
>  	 * kernel -> kernel   lazy + transfer active
> -	 *   user -> kernel   lazy + mmgrab() active
> +	 *   user -> kernel   lazy + mmgrab_lazy_tlb() active
>  	 *
> -	 * kernel ->   user   switch + mmdrop() active
> +	 * kernel ->   user   switch + mmdrop_lazy_tlb() active
>  	 *   user ->   user   switch
>  	 */
>  	if (!next->mm) {                                // to kernel
> @@ -3423,7 +3423,7 @@ context_switch(struct rq *rq, struct
> task_struct *prev, 
>  		next->active_mm = prev->active_mm;
>  		if (prev->mm)                           // from user
> -			mmgrab(prev->active_mm);
> +			mmgrab_lazy_tlb(prev->active_mm);
>  		else
>  			prev->active_mm = NULL;
>  	} else {                                        // to user
> @@ -3439,7 +3439,7 @@ context_switch(struct rq *rq, struct
> task_struct *prev, switch_mm_irqs_off(prev->active_mm, next->mm,
> next); 
>  		if (!prev->mm) {                        // from
> kernel
> -			/* will mmdrop() in finish_task_switch(). */
> +			/* will mmdrop_lazy_tlb() in
> finish_task_switch(). */ rq->prev_mm = prev->active_mm;
>  			prev->active_mm = NULL;
>  		}
> 

