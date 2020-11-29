Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8152F2C76D9
	for <lists+linux-arch@lfdr.de>; Sun, 29 Nov 2020 01:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgK2AhM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Nov 2020 19:37:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgK2AhL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 28 Nov 2020 19:37:11 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F76B21D46
        for <linux-arch@vger.kernel.org>; Sun, 29 Nov 2020 00:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606610190;
        bh=mOXS/GH3UaFSuy+jtY/EBw5HQ/wdrNhDC08bkHMO8fA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=grkjgTt90qgkD7QxDR7tOEkcCif1VM3mCZDrJMoXgvteKpPgcjgBsB3iSk/R79M/X
         MnKmgVohjmSgVqj+R8YwybSQyt/uEXMVOzTpN2gybX6RHd1Ak/nZXaBALve+Y7BOEB
         IPKG9b72zuMFZeQfTHVVONUQKxYU4fn0TErUfPEo=
Received: by mail-wr1-f49.google.com with SMTP id u12so10006465wrt.0
        for <linux-arch@vger.kernel.org>; Sat, 28 Nov 2020 16:36:30 -0800 (PST)
X-Gm-Message-State: AOAM533s5NxYOTmuDPbJwI6f0eQjJHar/SWUv5HYzxbZLC4Wnt7Ro02f
        hJ9G9t3mhCsxGLu419sooHWXHSk6z97zir/y4HDmfQ==
X-Google-Smtp-Source: ABdhPJw8X06KdtkQ9qbb12mAMYxaRda5IFDNz5ooMIoWy5ii8bD6jyRgnZB6e2s1MohEpOC4s4mq8S0jFjI2Y2DZhHo=
X-Received: by 2002:adf:f0c2:: with SMTP id x2mr19588466wro.184.1606610189036;
 Sat, 28 Nov 2020 16:36:29 -0800 (PST)
MIME-Version: 1.0
References: <20201128160141.1003903-1-npiggin@gmail.com> <20201128160141.1003903-6-npiggin@gmail.com>
In-Reply-To: <20201128160141.1003903-6-npiggin@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 28 Nov 2020 16:36:18 -0800
X-Gmail-Original-Message-ID: <CALCETrWz3hqptsmTHAu1Qb=E8FPhYRVfcO1nhTVHwOpTNq6w1w@mail.gmail.com>
Message-ID: <CALCETrWz3hqptsmTHAu1Qb=E8FPhYRVfcO1nhTVHwOpTNq6w1w@mail.gmail.com>
Subject: Re: [PATCH 5/8] lazy tlb: allow lazy tlb mm switching to be configurable
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-MM <linux-mm@kvack.org>, Anton Blanchard <anton@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Nov 28, 2020 at 8:02 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> NOMMU systems could easily go without this and save a bit of code
> and the refcount atomics, because their mm switch is a no-op. I
> haven't flipped them over because haven't audited all arch code to
> convert over to using the _lazy_tlb refcounting.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/Kconfig             | 11 +++++++
>  include/linux/sched/mm.h | 13 ++++++--
>  kernel/sched/core.c      | 68 +++++++++++++++++++++++++++++-----------
>  kernel/sched/sched.h     |  4 ++-
>  4 files changed, 75 insertions(+), 21 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 56b6ccc0e32d..596bf589d74b 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -430,6 +430,17 @@ config ARCH_WANT_IRQS_OFF_ACTIVATE_MM
>           irqs disabled over activate_mm. Architectures that do IPI based TLB
>           shootdowns should enable this.
>
> +# Should make this depend on MMU, because there is little use for lazy mm switching
> +# with NOMMU. Must audit NOMMU architecture code for lazy mm refcounting first.
> +config MMU_LAZY_TLB
> +       def_bool y
> +       help
> +         Enable "lazy TLB" mmu context switching for kernel threads.
> +
> +config MMU_LAZY_TLB_REFCOUNT
> +       def_bool y
> +       depends on MMU_LAZY_TLB
> +

This could use some documentation as to what "no" means.

>  config ARCH_HAVE_NMI_SAFE_CMPXCHG
>         bool
>
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 7157c0f6fef8..bd0f27402d4b 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -51,12 +51,21 @@ static inline void mmdrop(struct mm_struct *mm)
>  /* Helpers for lazy TLB mm refcounting */
>  static inline void mmgrab_lazy_tlb(struct mm_struct *mm)
>  {
> -       mmgrab(mm);
> +       if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT))
> +               mmgrab(mm);
>  }
>
>  static inline void mmdrop_lazy_tlb(struct mm_struct *mm)
>  {
> -       mmdrop(mm);
> +       if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT)) {
> +               mmdrop(mm);
> +       } else {
> +               /*
> +                * mmdrop_lazy_tlb must provide a full memory barrier, see the
> +                * membarrier comment finish_task_switch.

"membarrier comment in finish_task_switch()", perhaps?

> +                */
> +               smp_mb();
> +       }
>  }
>
>  /**
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e372b613d514..3b79c6cc3a37 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3579,7 +3579,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
>         __releases(rq->lock)
>  {
>         struct rq *rq = this_rq();
> -       struct mm_struct *mm = rq->prev_mm;
> +       struct mm_struct *mm = NULL;
>         long prev_state;
>
>         /*
> @@ -3598,7 +3598,10 @@ static struct rq *finish_task_switch(struct task_struct *prev)
>                       current->comm, current->pid, preempt_count()))
>                 preempt_count_set(FORK_PREEMPT_COUNT);
>
> -       rq->prev_mm = NULL;
> +#ifdef CONFIG_MMU_LAZY_TLB_REFCOUNT
> +       mm = rq->prev_lazy_mm;
> +       rq->prev_lazy_mm = NULL;
> +#endif
>
>         /*
>          * A task struct has one reference for the use as "current".
> @@ -3630,6 +3633,8 @@ static struct rq *finish_task_switch(struct task_struct *prev)
>          * rq->curr, before returning to userspace, for
>          * {PRIVATE,GLOBAL}_EXPEDITED. This is implicitly provided by
>          * mmdrop_lazy_tlb().
> +        *
> +        * This same issue applies to other places that mmdrop_lazy_tlb().
>          */
>         if (mm)
>                 mmdrop_lazy_tlb(mm);
> @@ -3719,22 +3724,10 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
>         calculate_sigpending();
>  }
>
> -/*
> - * context_switch - switch to the new MM and the new thread's register state.
> - */
> -static __always_inline struct rq *
> -context_switch(struct rq *rq, struct task_struct *prev,
> -              struct task_struct *next, struct rq_flags *rf)
> +static __always_inline void
> +context_switch_mm(struct rq *rq, struct task_struct *prev,
> +              struct task_struct *next)
>  {
> -       prepare_task_switch(rq, prev, next);
> -
> -       /*
> -        * For paravirt, this is coupled with an exit in switch_to to
> -        * combine the page table reload and the switch backend into
> -        * one hypercall.
> -        */
> -       arch_start_context_switch(prev);
> -
>         /*
>          * kernel -> kernel   lazy + transfer active
>          *   user -> kernel   lazy + mmgrab_lazy_tlb() active
> @@ -3765,11 +3758,50 @@ context_switch(struct rq *rq, struct task_struct *prev,
>                 if (!prev->mm) {                        // from kernel
>                         exit_lazy_tlb(prev->active_mm, next);
>
> +#ifdef CONFIG_MMU_LAZY_TLB_REFCOUNT
>                         /* will mmdrop_lazy_tlb() in finish_task_switch(). */
> -                       rq->prev_mm = prev->active_mm;
> +                       rq->prev_lazy_mm = prev->active_mm;
>                         prev->active_mm = NULL;
> +#else
> +                       /* See membarrier comment in finish_task_switch(). */
> +                       smp_mb();
> +#endif
>                 }
>         }
> +}
> +

Comment here describing what this does, please.


> +static __always_inline void
> +context_switch_mm_nolazy(struct rq *rq, struct task_struct *prev,
> +              struct task_struct *next)
> +{
> +       if (!next->mm)
> +               next->active_mm = &init_mm;
> +       membarrier_switch_mm(rq, prev->active_mm, next->active_mm);
> +       switch_mm_irqs_off(prev->active_mm, next->active_mm, next);
> +       if (!prev->mm)
> +               prev->active_mm = NULL;
> +}
> +
> +/*
> + * context_switch - switch to the new MM and the new thread's register state.
> + */
> +static __always_inline struct rq *
> +context_switch(struct rq *rq, struct task_struct *prev,
> +              struct task_struct *next, struct rq_flags *rf)
> +{
> +       prepare_task_switch(rq, prev, next);
> +
> +       /*
> +        * For paravirt, this is coupled with an exit in switch_to to
> +        * combine the page table reload and the switch backend into
> +        * one hypercall.
> +        */
> +       arch_start_context_switch(prev);
> +
> +       if (IS_ENABLED(CONFIG_MMU_LAZY_TLB))
> +               context_switch_mm(rq, prev, next);
> +       else
> +               context_switch_mm_nolazy(rq, prev, next);
>
>         rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index df80bfcea92e..3b72aec5a2f2 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -950,7 +950,9 @@ struct rq {
>         struct task_struct      *idle;
>         struct task_struct      *stop;
>         unsigned long           next_balance;
> -       struct mm_struct        *prev_mm;
> +#ifdef CONFIG_MMU_LAZY_TLB_REFCOUNT
> +       struct mm_struct        *prev_lazy_mm;
> +#endif
>
>         unsigned int            clock_update_flags;
>         u64                     clock;
> --
> 2.23.0
>
