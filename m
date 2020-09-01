Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD728258909
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 09:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgIAHbH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 03:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgIAHbH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 03:31:07 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5D0C061244;
        Tue,  1 Sep 2020 00:31:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Bgdz92lPxz9sTC;
        Tue,  1 Sep 2020 17:31:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1598945461;
        bh=03sHYm631sdFvHM5NaS/cwjM4VK1GZ0RfuJMTFnqpEc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=a/bpJOhSiqrggdqpabXGJruLmgoojqIjNOtKdWPNocerR0Tx+kpxlpwOBXWByNo/u
         4MMDvjMJXHZd3qpIFjDpNQwir2JtlbC9QuIRNfQv7+DKiRCdMAqVS2zB0NNm3xvlxi
         hvo4hfX2X+T6n9TewBPyqOaQPF1dB6lLff4nNk3wepYL7lE7hDv4mTN4tfQemSqXSJ
         WI1dVOLHIsHxXYqamewX3UAYivUNxFlBxI1JOPhVmYtR5K6iqZSaxTQcLo/zn3B6PJ
         QNOduqvxUP/5omK0ZAxn1i6wfTDPjM1ab8plb48Tm0DDJw3DYQUCXwF5Hbpl36yYaa
         HcDxgeuynTQ2A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 16/23] powerpc: use asm-generic/mmu_context.h for no-op implementations
In-Reply-To: <20200826145249.745432-17-npiggin@gmail.com>
References: <20200826145249.745432-1-npiggin@gmail.com> <20200826145249.745432-17-npiggin@gmail.com>
Date:   Tue, 01 Sep 2020 17:30:59 +1000
Message-ID: <87sgc20x8s.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Nicholas Piggin <npiggin@gmail.com> writes:
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/mmu_context.h | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers


> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index 7f3658a97384..bc22e247ab55 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -14,7 +14,9 @@
>  /*
>   * Most if the context management is out of line
>   */
> +#define init_new_context init_new_context
>  extern int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
> +#define destroy_context destroy_context
>  extern void destroy_context(struct mm_struct *mm);
>  #ifdef CONFIG_SPAPR_TCE_IOMMU
>  struct mm_iommu_table_group_mem_t;
> @@ -235,27 +237,15 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  }
>  #define switch_mm_irqs_off switch_mm_irqs_off
>  
> -
> -#define deactivate_mm(tsk,mm)	do { } while (0)
> -
> -/*
> - * After we have set current->mm to a new value, this activates
> - * the context for the new mm so we see the new mappings.
> - */
> -static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
> -{
> -	switch_mm(prev, next, current);
> -}
> -
> -/* We don't currently use enter_lazy_tlb() for anything */
> +#ifdef CONFIG_PPC_BOOK3E_64
> +#define enter_lazy_tlb enter_lazy_tlb
>  static inline void enter_lazy_tlb(struct mm_struct *mm,
>  				  struct task_struct *tsk)
>  {
>  	/* 64-bit Book3E keeps track of current PGD in the PACA */
> -#ifdef CONFIG_PPC_BOOK3E_64
>  	get_paca()->pgd = NULL;
> -#endif
>  }
> +#endif
>  
>  extern void arch_exit_mmap(struct mm_struct *mm);
>  
> @@ -298,5 +288,7 @@ static inline int arch_dup_mmap(struct mm_struct *oldmm,
>  	return 0;
>  }
>  
> +#include <asm-generic/mmu_context.h>
> +
>  #endif /* __KERNEL__ */
>  #endif /* __ASM_POWERPC_MMU_CONTEXT_H */
> -- 
> 2.23.0
