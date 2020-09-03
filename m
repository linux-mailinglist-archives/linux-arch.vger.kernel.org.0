Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7131725BAA9
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 07:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgICF5R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 01:57:17 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:49140 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgICF5Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 01:57:16 -0400
Date:   Thu, 3 Sep 2020 01:57:15 -0400
From:   Rich Felker <dalias@libc.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Subject: Re: [PATCH v3 19/23] sh: use asm-generic/mmu_context.h for no-op
 implementations
Message-ID: <20200903055715.GY3265@brightrain.aerifal.cx>
References: <20200901141539.1757549-1-npiggin@gmail.com>
 <20200901141539.1757549-20-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901141539.1757549-20-npiggin@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 02, 2020 at 12:15:35AM +1000, Nicholas Piggin wrote:
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> 
> Please ack or nack if you object to this being mered via
> Arnd's tree.

Acked-by: Rich Felker <dalias@libc.org>

> 
>  arch/sh/include/asm/mmu_context.h    | 5 ++---
>  arch/sh/include/asm/mmu_context_32.h | 9 ---------
>  2 files changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/sh/include/asm/mmu_context.h b/arch/sh/include/asm/mmu_context.h
> index 461b1304580b..78eef4e7d5df 100644
> --- a/arch/sh/include/asm/mmu_context.h
> +++ b/arch/sh/include/asm/mmu_context.h
> @@ -84,6 +84,7 @@ static inline void get_mmu_context(struct mm_struct *mm, unsigned int cpu)
>   * Initialize the context related info for a new mm_struct
>   * instance.
>   */
> +#define init_new_context init_new_context
>  static inline int init_new_context(struct task_struct *tsk,
>  				   struct mm_struct *mm)
>  {
> @@ -120,9 +121,7 @@ static inline void switch_mm(struct mm_struct *prev,
>  			activate_context(next, cpu);
>  }
>  
> -#define activate_mm(prev, next)		switch_mm((prev),(next),NULL)
> -#define deactivate_mm(tsk,mm)		do { } while (0)
> -#define enter_lazy_tlb(mm,tsk)		do { } while (0)
> +#include <asm-generic/mmu_context.h>
>  
>  #else
>  
> diff --git a/arch/sh/include/asm/mmu_context_32.h b/arch/sh/include/asm/mmu_context_32.h
> index 71bf12ef1f65..bc5034fa6249 100644
> --- a/arch/sh/include/asm/mmu_context_32.h
> +++ b/arch/sh/include/asm/mmu_context_32.h
> @@ -2,15 +2,6 @@
>  #ifndef __ASM_SH_MMU_CONTEXT_32_H
>  #define __ASM_SH_MMU_CONTEXT_32_H
>  
> -/*
> - * Destroy context related info for an mm_struct that is about
> - * to be put to rest.
> - */
> -static inline void destroy_context(struct mm_struct *mm)
> -{
> -	/* Do nothing */
> -}
> -
>  #ifdef CONFIG_CPU_HAS_PTEAEX
>  static inline void set_asid(unsigned long asid)
>  {
> -- 
> 2.23.0
