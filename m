Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA916D66EE
	for <lists+linux-arch@lfdr.de>; Tue,  4 Apr 2023 17:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbjDDPNx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Apr 2023 11:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235358AbjDDPNv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Apr 2023 11:13:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1A344A3;
        Tue,  4 Apr 2023 08:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZvG/eQpMaXzqTjgxevrqYb3nMrHM03KndTh2qrpj9U0=; b=bcnFN54+FqSTJ1jVRh6m09inYu
        noe6Iv3bQ7qijhJ/b9UGGN6Xt79Ty18dyrnQsn/wOzNoAcusUKSZugfCQZJIfcivHmKl5Htj45Qwd
        ccGGSAQj9syXjLSIRXbEvQsrpf9p0Xy0FekbeJFs47DIWWemWhZzBtG9rQKFRcwjv+cHhFYk66JGV
        2HCsJDNMPUXX7me+AUz2d2QBnIrseciExrbE14eKjKA7MZLsO/Q8Jbd4n6OnSKkaSOHQYkG6uYpr6
        koyhLd7cLRwuUjPUq+GJx03ybD0cikWGzZymBFhZWnuULPo+uvY3cWeZ1M+SD+eS8UBWnzMmymLz6
        5MfnUH9A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pjiKY-00FSz8-RV; Tue, 04 Apr 2023 15:12:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 084FA300338;
        Tue,  4 Apr 2023 17:12:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E4AEB26442AC2; Tue,  4 Apr 2023 17:12:17 +0200 (CEST)
Date:   Tue, 4 Apr 2023 17:12:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yair Podemsky <ypodemsk@redhat.com>
Cc:     linux@armlinux.org.uk, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, will@kernel.org,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        arnd@arndb.de, keescook@chromium.org, paulmck@kernel.org,
        jpoimboe@kernel.org, samitolvanen@google.com, frederic@kernel.org,
        ardb@kernel.org, juerg.haefliger@canonical.com,
        rmk+kernel@armlinux.org.uk, geert+renesas@glider.be,
        tony@atomide.com, linus.walleij@linaro.org,
        sebastian.reichel@collabora.com, nick.hawkins@hpe.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, mtosatti@redhat.com, vschneid@redhat.com,
        dhildenb@redhat.com, alougovs@redhat.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 3/3] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to CPUs in kernel mode
Message-ID: <20230404151217.GB297936@hirez.programming.kicks-ass.net>
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-4-ypodemsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404134224.137038-4-ypodemsk@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 04, 2023 at 04:42:24PM +0300, Yair Podemsky wrote:
> The tlb_remove_table_smp_sync IPI is used to ensure the outdated tlb page
> is not currently being accessed and can be cleared.
> This occurs once all CPUs have left the lockless gup code section.
> If they reenter the page table walk, the pointers will be to the new
> pages.
> Therefore the IPI is only needed for CPUs in kernel mode.
> By preventing the IPI from being sent to CPUs not in kernel mode,
> Latencies are reduced.
> 
> Race conditions considerations:
> The context state check is vulnerable to race conditions between the
> moment the context state is read to when the IPI is sent (or not).
> 
> Here are these scenarios.
> case 1:
> CPU-A                                             CPU-B
> 
>                                                   state == CONTEXT_KERNEL
> int state = atomic_read(&ct->state);
>                                                   Kernel-exit:
>                                                   state == CONTEXT_USER
> if (state & CT_STATE_MASK == CONTEXT_KERNEL)
> 
> In this case, the IPI will be sent to CPU-B despite it is no longer in
> the kernel. The consequence of which would be an unnecessary IPI being
> handled by CPU-B, causing a reduction in latency.
> This would have been the case every time without this patch.
> 
> case 2:
> CPU-A                                             CPU-B
> 
> modify pagetables
> tlb_flush (memory barrier)
>                                                   state == CONTEXT_USER
> int state = atomic_read(&ct->state);
>                                                   Kernel-enter:
>                                                   state == CONTEXT_KERNEL
>                                                   READ(pagetable values)
> if (state & CT_STATE_MASK == CONTEXT_USER)
> 
> In this case, the IPI will not be sent to CPU-B despite it returning to
> the kernel and even reading the pagetable.
> However since this CPU-B has entered the pagetable after the
> modification it is reading the new, safe values.
> 
> The only case when this IPI is truly necessary is when CPU-B has entered
> the lockless gup code section before the pagetable modifications and
> has yet to exit them, in which case it is still in the kernel.
> 
> Signed-off-by: Yair Podemsky <ypodemsk@redhat.com>
> ---
>  mm/mmu_gather.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index 5ea9be6fb87c..731d955e152d 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -9,6 +9,7 @@
>  #include <linux/smp.h>
>  #include <linux/swap.h>
>  #include <linux/rmap.h>
> +#include <linux/context_tracking_state.h>
>  
>  #include <asm/pgalloc.h>
>  #include <asm/tlb.h>
> @@ -191,6 +192,20 @@ static void tlb_remove_table_smp_sync(void *arg)
>  	/* Simply deliver the interrupt */
>  }
>  
> +
> +#ifdef CONFIG_CONTEXT_TRACKING
> +static bool cpu_in_kernel(int cpu, void *info)
> +{
> +	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
> +	int state = atomic_read(&ct->state);
> +	/* will return true only for cpus in kernel space */
> +	return state & CT_STATE_MASK == CONTEXT_KERNEL;
> +}
> +#define CONTEXT_PREDICATE cpu_in_kernel
> +#else
> +#define CONTEXT_PREDICATE NULL
> +#endif /* CONFIG_CONTEXT_TRACKING */
> +
>  #ifdef CONFIG_ARCH_HAS_CPUMASK_BITS
>  #define REMOVE_TABLE_IPI_MASK mm_cpumask(mm)
>  #else
> @@ -206,8 +221,8 @@ void tlb_remove_table_sync_one(struct mm_struct *mm)
>  	 * It is however sufficient for software page-table walkers that rely on
>  	 * IRQ disabling.
>  	 */
> -	on_each_cpu_mask(REMOVE_TABLE_IPI_MASK, tlb_remove_table_smp_sync,
> -			NULL, true);
> +	on_each_cpu_cond_mask(CONTEXT_PREDICATE, tlb_remove_table_smp_sync,
> +			NULL, true, REMOVE_TABLE_IPI_MASK);
>  }

I think this is correct; but... I would like much of the changelog
included in a comment above cpu_in_kernel(). I'm sure someone will try
and read this code and wonder about those race conditions.

Of crucial importance is the fact that the page-table modification comes
before the tlbi.

Also, do we really not already have this helper function somewhere, it
seems like something obvious to already have, Frederic?


