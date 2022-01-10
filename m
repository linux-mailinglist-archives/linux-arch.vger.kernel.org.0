Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338DF48A26E
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 23:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241148AbiAJWHG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 17:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240960AbiAJWHF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2022 17:07:05 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD14FC06173F
        for <linux-arch@vger.kernel.org>; Mon, 10 Jan 2022 14:07:05 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id d1so42005943ybh.6
        for <linux-arch@vger.kernel.org>; Mon, 10 Jan 2022 14:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OLoSFmV+IY05QKb0dS8wO8UVqMpy7ASVbT1uYBBSlVk=;
        b=IxQB2TPmTUhakP4Y4I6pmrmn98v/DAm6vwbvYZyvTHDkJAVNk6OhngUc6IRUJFiHu2
         BSiMshSd/ISmmbFRNUuuA8MD0nYAwd5GwN6rbgWkNOaioMBnSt9aV60pbTjdP3ml0O5X
         h4e7+0/DpdPRxqnCe2HR/mvdRsJW8/f9eRjgqgXy+87Ek4PH5NnRwLLTLWppR1ppGAjm
         0/ZwnY8LeEs0c00hXL/70SpAcF1O2JRCq0HkVMtX5K6SlZqozKmWH4VI7nS3wtQlYuC6
         DMHPRAL2ec0Abox7w+nlLjciBrwB9Yw0HMH/73oDXAnuyr3KNTkRxGnQkDZ1yXLNGJMM
         Vy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OLoSFmV+IY05QKb0dS8wO8UVqMpy7ASVbT1uYBBSlVk=;
        b=Lnm3mLlxt/fJ9/kNOdXdGDtrW4gVB1sRCStm3TB4VV35+Eho93PvgxmemHLGORcdir
         7mydF9FluUn5zODgXgdHAT3tJSX2/L4fuirqN6OHoDC6xTFg/A1G9vzWyfIL59tM7IJE
         6CaNBfAsf2M2Stge/jmvVHEoIGIGT5lD9iNsM7gOna0gnueplLDJk98FTmnk9mvWi+hy
         mn6HMWEdSBJ5jpyOiH3Vz7mg4HdCTdchRz5CScgHe950Sm9UrK2j9qqDQC45cM+Ir0Xn
         Wfj+F5b5NjxcKv66A1HlxXbWE5NWz7f4kiDSZjVUmPHvkMGH7ZymveKTpADaOCWzPQK1
         EnZg==
X-Gm-Message-State: AOAM532/8dCgaeoyHucEkN8tmO6bO3JVukkpze9oCJhi6RbXTX8ci0gG
        YimblyDYQtfcpUOHYVmMgdq3PGjrHpFT5KnL2i4/5efmlsWoEQ==
X-Google-Smtp-Source: ABdhPJzryT/NjsVOi5SARPjPlviemKlUVT+U6gViPtgl/7bBvxfByaT33kw2rB4BLSc7HSihyH8Ow17sPMRTfMkN5RA=
X-Received: by 2002:a25:b9d2:: with SMTP id y18mr843069ybj.615.1641852424421;
 Mon, 10 Jan 2022 14:07:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641659630.git.luto@kernel.org> <233d81a0a1e7b8eca1907998152ee848159b8774.1641659630.git.luto@kernel.org>
In-Reply-To: <233d81a0a1e7b8eca1907998152ee848159b8774.1641659630.git.luto@kernel.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 10 Jan 2022 14:06:53 -0800
Message-ID: <CABCJKucptXNUfweVOLD==E2TNavGKCQ-Z=YsKF2Kdq60Tp+A3A@mail.gmail.com>
Subject: Re: [PATCH 11/23] sched/scs: Initialize shadow stack on idle thread
 bringup, not shutdown
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Woody Lin <woodylin@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Andy,

On Sat, Jan 8, 2022 at 8:44 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> Starting with commit 63acd42c0d49 ("sched/scs: Reset the shadow stack when
> idle_task_exit"), the idle thread's shadow stack was reset from the idle
> task's context during CPU hot-unplug.  This was fragile: between resetting
> the shadow stack and actually stopping the idle task, the shadow stack
> did not match the actual call stack.
>
> Clean this up by resetting the idle task's SCS in bringup_cpu().
>
> init_idle() still does scs_task_reset() -- see the comments there.  I
> leave this to an SCS maintainer to untangle further.
>
> Cc: Woody Lin <woodylin@google.com>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  kernel/cpu.c        | 3 +++
>  kernel/sched/core.c | 9 ++++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 192e43a87407..be16816bb87c 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -33,6 +33,7 @@
>  #include <linux/slab.h>
>  #include <linux/percpu-rwsem.h>
>  #include <linux/cpuset.h>
> +#include <linux/scs.h>
>
>  #include <trace/events/power.h>
>  #define CREATE_TRACE_POINTS
> @@ -587,6 +588,8 @@ static int bringup_cpu(unsigned int cpu)
>         struct task_struct *idle = idle_thread_get(cpu);
>         int ret;
>
> +       scs_task_reset(idle);
> +
>         /*
>          * Some architectures have to walk the irq descriptors to
>          * setup the vector space for the cpu which comes online.
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 917068b0a145..acd52a7d1349 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8621,7 +8621,15 @@ void __init init_idle(struct task_struct *idle, int cpu)
>         idle->flags |= PF_IDLE | PF_KTHREAD | PF_NO_SETAFFINITY;
>         kthread_set_per_cpu(idle, cpu);
>
> +       /*
> +        * NB: This is called from sched_init() on the *current* idle thread.
> +        * This seems fragile if not actively incorrect.
> +        *
> +        * Initializing SCS for about-to-be-brought-up CPU idle threads
> +        * is in bringup_cpu(), but that does not cover the boot CPU.
> +        */
>         scs_task_reset(idle);
> +
>         kasan_unpoison_task_stack(idle);
>
>  #ifdef CONFIG_SMP
> @@ -8779,7 +8787,6 @@ void idle_task_exit(void)
>                 finish_arch_post_lock_switch();
>         }
>
> -       scs_task_reset(current);
>         /* finish_cpu(), as ran on the BP, will clean up the active_mm state */
>  }

I believe Mark already fixed this one here:

https://lore.kernel.org/lkml/20211123114047.45918-1-mark.rutland@arm.com/

Sami
