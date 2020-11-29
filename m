Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6D52C76DE
	for <lists+linux-arch@lfdr.de>; Sun, 29 Nov 2020 01:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgK2Aj2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Nov 2020 19:39:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:39372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgK2Aj2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 28 Nov 2020 19:39:28 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2E8120885
        for <linux-arch@vger.kernel.org>; Sun, 29 Nov 2020 00:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606610326;
        bh=lWw5TMojtbxaKw7VvjVfQ7hiJVxsrMbwUI8CIDgcSZY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a0taiRYTV5hE9MJz5yrB/E4wLTcpu6J4VhuvST+LEVmSTVkna4nUBPRDjdWVBTVMJ
         fuTCF7fuMt1843shzrtQziGt1E6DLo44ThR0PCOZcAPf5A0Sg0lmg8AcXiordCw4sf
         uiPYBlSLwsDESf2UJUzrOy9iNR4XYHvtnQJKiDYs=
Received: by mail-wm1-f44.google.com with SMTP id w24so12637408wmi.0
        for <linux-arch@vger.kernel.org>; Sat, 28 Nov 2020 16:38:46 -0800 (PST)
X-Gm-Message-State: AOAM530IoL5QcJItjzyNbayL1yMJfBWbpNjPRmWxjFti4siLWhSotdDI
        YB/AWIvns8xR20XEGSXBtk6sgKRHavq1wJVmhy/shQ==
X-Google-Smtp-Source: ABdhPJwLyYJ+CcbT9yQXWivpvUJZnHSwXyqV4grvoj5mlZ4cyzQ891rccLTwbv5dzdTuLdNLgiIWQRFmH9pj5WLHwsU=
X-Received: by 2002:a7b:cb41:: with SMTP id v1mr4301883wmj.36.1606610325224;
 Sat, 28 Nov 2020 16:38:45 -0800 (PST)
MIME-Version: 1.0
References: <20201128160141.1003903-1-npiggin@gmail.com> <20201128160141.1003903-2-npiggin@gmail.com>
In-Reply-To: <20201128160141.1003903-2-npiggin@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 28 Nov 2020 16:38:33 -0800
X-Gmail-Original-Message-ID: <CALCETrVbFm7gZ7G_5DWa6UGYtCzZTQvC_CPRVDZ0Lb-tiMnjSg@mail.gmail.com>
Message-ID: <CALCETrVbFm7gZ7G_5DWa6UGYtCzZTQvC_CPRVDZ0Lb-tiMnjSg@mail.gmail.com>
Subject: Re: [PATCH 1/8] lazy tlb: introduce exit_lazy_tlb
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

On Sat, Nov 28, 2020 at 8:01 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> This is called at points where a lazy mm is switched away or made not
> lazy (by its owner switching back).
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/arm/mach-rpc/ecard.c            |  1 +
>  arch/powerpc/mm/book3s64/radix_tlb.c |  1 +
>  fs/exec.c                            |  6 ++++--
>  include/asm-generic/mmu_context.h    | 21 +++++++++++++++++++++
>  kernel/kthread.c                     |  1 +
>  kernel/sched/core.c                  |  2 ++
>  6 files changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-rpc/ecard.c b/arch/arm/mach-rpc/ecard.c
> index 827b50f1c73e..43eb1bfba466 100644
> --- a/arch/arm/mach-rpc/ecard.c
> +++ b/arch/arm/mach-rpc/ecard.c
> @@ -253,6 +253,7 @@ static int ecard_init_mm(void)
>         current->mm = mm;
>         current->active_mm = mm;
>         activate_mm(active_mm, mm);
> +       exit_lazy_tlb(active_mm, current);
>         mmdrop(active_mm);
>         ecard_init_pgtables(mm);
>         return 0;
> diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
> index b487b489d4b6..ac3fec03926a 100644
> --- a/arch/powerpc/mm/book3s64/radix_tlb.c
> +++ b/arch/powerpc/mm/book3s64/radix_tlb.c
> @@ -661,6 +661,7 @@ static void do_exit_flush_lazy_tlb(void *arg)
>                 mmgrab(&init_mm);
>                 current->active_mm = &init_mm;
>                 switch_mm_irqs_off(mm, &init_mm, current);
> +               exit_lazy_tlb(mm, current);
>                 mmdrop(mm);
>         }
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 547a2390baf5..4b4dea1bb7ba 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1017,6 +1017,8 @@ static int exec_mmap(struct mm_struct *mm)
>         if (!IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
>                 local_irq_enable();
>         activate_mm(active_mm, mm);
> +       if (!old_mm)
> +               exit_lazy_tlb(active_mm, tsk);
>         if (IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
>                 local_irq_enable();
>         tsk->mm->vmacache_seqnum = 0;
> @@ -1028,9 +1030,9 @@ static int exec_mmap(struct mm_struct *mm)
>                 setmax_mm_hiwater_rss(&tsk->signal->maxrss, old_mm);
>                 mm_update_next_owner(old_mm);
>                 mmput(old_mm);
> -               return 0;
> +       } else {
> +               mmdrop(active_mm);
>         }
> -       mmdrop(active_mm);

This looks like an unrelated change.

>         return 0;
>  }
>
> diff --git a/include/asm-generic/mmu_context.h b/include/asm-generic/mmu_context.h
> index 91727065bacb..4626d0020e65 100644
> --- a/include/asm-generic/mmu_context.h
> +++ b/include/asm-generic/mmu_context.h
> @@ -24,6 +24,27 @@ static inline void enter_lazy_tlb(struct mm_struct *mm,
>  }
>  #endif
>
> +/*
> + * exit_lazy_tlb - Called after switching away from a lazy TLB mode mm.
> + *
> + * mm:  the lazy mm context that was switched
> + * tsk: the task that was switched to (with a non-lazy mm)
> + *
> + * mm may equal tsk->mm.
> + * mm and tsk->mm will not be NULL.
> + *
> + * Note this is not symmetrical to enter_lazy_tlb, this is not
> + * called when tasks switch into the lazy mm, it's called after the
> + * lazy mm becomes non-lazy (either switched to a different mm or the
> + * owner of the mm returns).
> + */
> +#ifndef exit_lazy_tlb
> +static inline void exit_lazy_tlb(struct mm_struct *mm,

Maybe name this parameter prev_lazy_mm?
