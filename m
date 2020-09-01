Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D2125887C
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 08:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgIAGtu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 02:49:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgIAGtt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Sep 2020 02:49:49 -0400
Received: from kernel.org (unknown [87.70.91.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E479208DB;
        Tue,  1 Sep 2020 06:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598942988;
        bh=NvCekPHIZCmnbkeS6yKm6q1qga5DpGl3Zr7rAiRiOHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JZ1I6hjvaQ67DJfPskMNXjYHEDuqWjex2aZC8Zfyxjmj/mq/nE8TOuA8Dhh+w3rxw
         ogOuBGdv3DJ4rSGgL8qcm5KYEpf5hTQCgN9UqbE9icLxSbAs7a/lp74v/M1LnsdKwh
         vtKGLgt0ovSk6VsSz2SfdluksPtSSjR0rBMspnUQ=
Date:   Tue, 1 Sep 2020 09:49:42 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 01/23] asm-generic: add generic MMU versions of mmu
 context functions
Message-ID: <20200901064942.GD432455@kernel.org>
References: <20200826145249.745432-1-npiggin@gmail.com>
 <20200826145249.745432-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826145249.745432-2-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 27, 2020 at 12:52:27AM +1000, Nicholas Piggin wrote:
> Many of these are no-ops on many architectures, so extend mmu_context.h
> to cover MMU and NOMMU, and split the NOMMU bits out to nommu_context.h
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/microblaze/include/asm/mmu_context.h |  2 +-
>  arch/sh/include/asm/mmu_context.h         |  2 +-
>  include/asm-generic/mmu_context.h         | 57 +++++++++++++++++------
>  include/asm-generic/nommu_context.h       | 19 ++++++++
>  4 files changed, 64 insertions(+), 16 deletions(-)
>  create mode 100644 include/asm-generic/nommu_context.h
> 
> diff --git a/arch/microblaze/include/asm/mmu_context.h b/arch/microblaze/include/asm/mmu_context.h
> index f74f9da07fdc..34004efb3def 100644
> --- a/arch/microblaze/include/asm/mmu_context.h
> +++ b/arch/microblaze/include/asm/mmu_context.h
> @@ -2,5 +2,5 @@
>  #ifdef CONFIG_MMU
>  # include <asm/mmu_context_mm.h>
>  #else
> -# include <asm-generic/mmu_context.h>
> +# include <asm-generic/nommu_context.h>
>  #endif
> diff --git a/arch/sh/include/asm/mmu_context.h b/arch/sh/include/asm/mmu_context.h
> index f664e51e8a15..461b1304580b 100644
> --- a/arch/sh/include/asm/mmu_context.h
> +++ b/arch/sh/include/asm/mmu_context.h
> @@ -133,7 +133,7 @@ static inline void switch_mm(struct mm_struct *prev,
>  #define set_TTB(pgd)			do { } while (0)
>  #define get_TTB()			(0)
>  
> -#include <asm-generic/mmu_context.h>
> +#include <asm-generic/nommu_context.h>
>  
>  #endif /* CONFIG_MMU */
>  
> diff --git a/include/asm-generic/mmu_context.h b/include/asm-generic/mmu_context.h
> index 6be9106fb6fb..86cea80a50df 100644
> --- a/include/asm-generic/mmu_context.h
> +++ b/include/asm-generic/mmu_context.h
> @@ -3,44 +3,73 @@
>  #define __ASM_GENERIC_MMU_CONTEXT_H
>  
>  /*
> - * Generic hooks for NOMMU architectures, which do not need to do
> - * anything special here.
> + * Generic hooks to implement no-op functionality.
>   */
>  
> -#include <asm-generic/mm_hooks.h>
> -
>  struct task_struct;
>  struct mm_struct;
>  
> +/*
> + * enter_lazy_tlb - Called when "tsk" is about to enter lazy TLB mode.
> + *
> + * @mm:  the currently active mm context which is becoming lazy
> + * @tsk: task which is entering lazy tlb
> + *
> + * tsk->mm will be NULL
> + */
> +#ifndef enter_lazy_tlb
>  static inline void enter_lazy_tlb(struct mm_struct *mm,
>  			struct task_struct *tsk)
>  {
>  }
> +#endif
>  
> +/**
> + * init_new_context - Initialize context of a new mm_struct.
> + * @tsk: task struct for the mm
> + * @mm:  the new mm struct

'make *docs' will complain here about missing Return: description

> + */
> +#ifndef init_new_context
>  static inline int init_new_context(struct task_struct *tsk,
>  			struct mm_struct *mm)
>  {
>  	return 0;
>  }
> +#endif

Most architectures have non-trivial init_new_context, maybe this
should go into nommu_context.h?

> +/**
> + * destroy_context - Undo init_new_context when the mm is going away
> + * @mm: old mm struct
> + */
> +#ifndef destroy_context
>  static inline void destroy_context(struct mm_struct *mm)
>  {
>  }
> +#endif
>  
> -static inline void deactivate_mm(struct task_struct *task,
> -			struct mm_struct *mm)
> -{
> -}
> -
> -static inline void switch_mm(struct mm_struct *prev,
> -			struct mm_struct *next,
> -			struct task_struct *tsk)
> +/**
> + * activate_mm - called after exec switches the current task to a new mm, to switch to it
> + * @prev_mm: previous mm of this task
> + * @next_mm: new mm
> + */
> +#ifndef activate_mm
> +static inline void activate_mm(struct mm_struct *prev_mm,
> +			       struct mm_struct *next_mm)
>  {
> +	switch_mm(prev_mm, next_mm, current);
>  }
> +#endif
>  
> -static inline void activate_mm(struct mm_struct *prev_mm,
> -			       struct mm_struct *next_mm)
> +/**
> + * dectivate_mm - called when an mm is released after exit or exec switches away from it
> + * @tsk: the task
> + * @mm:  the old mm
> + */
> +#ifndef deactivate_mm
> +static inline void deactivate_mm(struct task_struct *tsk,
> +			struct mm_struct *mm)
>  {
>  }
> +#endif
>  
>  #endif /* __ASM_GENERIC_MMU_CONTEXT_H */
> diff --git a/include/asm-generic/nommu_context.h b/include/asm-generic/nommu_context.h
> new file mode 100644
> index 000000000000..4f916f9e16cd
> --- /dev/null
> +++ b/include/asm-generic/nommu_context.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_GENERIC_NOMMU_H
> +#define __ASM_GENERIC_NOMMU_H
> +
> +/*
> + * Generic hooks for NOMMU architectures, which do not need to do
> + * anything special here.
> + */
> +#include <asm-generic/mm_hooks.h>
> +
> +static inline void switch_mm(struct mm_struct *prev,
> +			struct mm_struct *next,
> +			struct task_struct *tsk)
> +{
> +}
> +
> +#include <asm-generic/mmu_context.h>
> +
> +#endif /* __ASM_GENERIC_NOMMU_H */
> -- 
> 2.23.0
> 
> 

-- 
Sincerely yours,
Mike.
