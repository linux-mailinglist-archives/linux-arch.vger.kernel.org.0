Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A3648C7BC
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jan 2022 16:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348170AbiALP55 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jan 2022 10:57:57 -0500
Received: from mail.efficios.com ([167.114.26.124]:54324 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343616AbiALP54 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jan 2022 10:57:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 40F18256E7C;
        Wed, 12 Jan 2022 10:57:56 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SPaO46H5gORm; Wed, 12 Jan 2022 10:57:55 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 900C8256E7B;
        Wed, 12 Jan 2022 10:57:55 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 900C8256E7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1642003075;
        bh=lvSIQ7nHyGdo5VdZlys2synMzTuviA6UG4EyMZOPiBk=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=DMjgYNw7ks9LENQdMdg89+EVk+CS+16fs1KF1c0b7eWV7O9zDFSBEdmkpCqepBgQe
         /tRqGOwYQ0XMkfaWVdUf20FxqiEzCnZja/eKRO6101qSwp6TvGgIwAQ0dWOOC0uN68
         7WN6qbg8CnUUQCiELlK+YSh1AYRci2rvfg6Od0c2Dz+lVmUV1vqhUYhr4j6qoyztF8
         UI+qz2X8B1GMGxjciyCUz9iHqsPwDAWrTFW218P+lDAT83iDI+8Upui1Fn0m3Pw2rt
         +39h4ae9bV9d1xWkMrGHfrwwUVQSwnXFGYfeore4QoKc4UURmagVPz7IIosrsZZBZQ
         qr2mMAyFXzo7w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aitH9Lv6nELs; Wed, 12 Jan 2022 10:57:55 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 69C2F256E7A;
        Wed, 12 Jan 2022 10:57:55 -0500 (EST)
Date:   Wed, 12 Jan 2022 10:57:55 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>, x86 <x86@kernel.org>,
        riel <riel@surriel.com>, Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <1254407188.24737.1642003075387.JavaMail.zimbra@efficios.com>
In-Reply-To: <e1664cf686034204b8dd5dc1d2bf18e4058b00fd.1641659630.git.luto@kernel.org>
References: <cover.1641659630.git.luto@kernel.org> <e1664cf686034204b8dd5dc1d2bf18e4058b00fd.1641659630.git.luto@kernel.org>
Subject: Re: [PATCH 06/23] powerpc/membarrier: Remove special barrier on mm
 switch
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Topic: powerpc/membarrier: Remove special barrier on mm switch
Thread-Index: srPxMeA++0JyEL6ARp7mtgKf1UfwJw==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Jan 8, 2022, at 11:43 AM, Andy Lutomirski luto@kernel.org wrote:

> powerpc did the following on some, but not all, paths through
> switch_mm_irqs_off():
> 
>       /*
>        * Only need the full barrier when switching between processes.
>        * Barrier when switching from kernel to userspace is not
>        * required here, given that it is implied by mmdrop(). Barrier
>        * when switching from userspace to kernel is not needed after
>        * store to rq->curr.
>        */
>       if (likely(!(atomic_read(&next->membarrier_state) &
>                    (MEMBARRIER_STATE_PRIVATE_EXPEDITED |
>                     MEMBARRIER_STATE_GLOBAL_EXPEDITED)) || !prev))
>               return;
> 
> This is puzzling: if !prev, then one might expect that we are switching
> from kernel to user, not user to kernel, which is inconsistent with the
> comment.  But this is all nonsense, because the one and only caller would
> never have prev == NULL and would, in fact, OOPS if prev == NULL.
> 
> In any event, this code is unnecessary, since the new generic
> membarrier_finish_switch_mm() provides the same barrier without arch help.
> 
> arch/powerpc/include/asm/membarrier.h remains as an empty header,
> because a later patch in this series will add code to it.

My disagreement with "membarrier: Make the post-switch-mm barrier explicit"
may affect this patch significantly, or even make it irrelevant.

Thanks,

Mathieu

> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
> arch/powerpc/include/asm/membarrier.h | 24 ------------------------
> arch/powerpc/mm/mmu_context.c         |  1 -
> 2 files changed, 25 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/membarrier.h
> b/arch/powerpc/include/asm/membarrier.h
> index de7f79157918..b90766e95bd1 100644
> --- a/arch/powerpc/include/asm/membarrier.h
> +++ b/arch/powerpc/include/asm/membarrier.h
> @@ -1,28 +1,4 @@
> #ifndef _ASM_POWERPC_MEMBARRIER_H
> #define _ASM_POWERPC_MEMBARRIER_H
> 
> -static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
> -					     struct mm_struct *next,
> -					     struct task_struct *tsk)
> -{
> -	/*
> -	 * Only need the full barrier when switching between processes.
> -	 * Barrier when switching from kernel to userspace is not
> -	 * required here, given that it is implied by mmdrop(). Barrier
> -	 * when switching from userspace to kernel is not needed after
> -	 * store to rq->curr.
> -	 */
> -	if (IS_ENABLED(CONFIG_SMP) &&
> -	    likely(!(atomic_read(&next->membarrier_state) &
> -		     (MEMBARRIER_STATE_PRIVATE_EXPEDITED |
> -		      MEMBARRIER_STATE_GLOBAL_EXPEDITED)) || !prev))
> -		return;
> -
> -	/*
> -	 * The membarrier system call requires a full memory barrier
> -	 * after storing to rq->curr, before going back to user-space.
> -	 */
> -	smp_mb();
> -}
> -
> #endif /* _ASM_POWERPC_MEMBARRIER_H */
> diff --git a/arch/powerpc/mm/mmu_context.c b/arch/powerpc/mm/mmu_context.c
> index 74246536b832..5f2daa6b0497 100644
> --- a/arch/powerpc/mm/mmu_context.c
> +++ b/arch/powerpc/mm/mmu_context.c
> @@ -84,7 +84,6 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct
> mm_struct *next,
> 		asm volatile ("dssall");
> 
> 	if (!new_on_cpu)
> -		membarrier_arch_switch_mm(prev, next, tsk);
> 
> 	/*
> 	 * The actual HW switching method differs between the various
> --
> 2.33.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
