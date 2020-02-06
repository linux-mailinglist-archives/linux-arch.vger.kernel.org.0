Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1417153E4E
	for <lists+linux-arch@lfdr.de>; Thu,  6 Feb 2020 06:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgBFFqa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Feb 2020 00:46:30 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:32408 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgBFFqa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Feb 2020 00:46:30 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48CnVW2zD1z9v024;
        Thu,  6 Feb 2020 06:46:27 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=h8SXhH9C; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 6m1t9Kik8HIJ; Thu,  6 Feb 2020 06:46:27 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48CnVW1P9yz9v01y;
        Thu,  6 Feb 2020 06:46:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1580967987; bh=EEYv+zTzd9qo5V5Yah42Eq7K5Bol2cKDrKt1OC5EqeA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h8SXhH9CINBhzxoawEfiaQhcpGYYlkCHb5JEs48IVhBekiJ64SiIpqe6fXiA3rqln
         WAoKLqvJ1kBesxZn6PVqsffW9G05yXC4JbwiQZf52Ec5mt6qzFhf12fhUeD5nyKrUy
         qSm9Tle02ACObMn+dv64Har56iHXDlphw+4s1C00=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 271E68B787;
        Thu,  6 Feb 2020 06:46:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qN1rH3Apcu68; Thu,  6 Feb 2020 06:46:27 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 04F048B776;
        Thu,  6 Feb 2020 06:46:18 +0100 (CET)
Subject: Re: [PATCH v6 03/11] powerpc/mm: Adds arch-specificic functions to
 track lockless pgtable walks
To:     Leonardo Bras <leonardo@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Suchanek <msuchanek@suse.de>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
 <20200206030900.147032-4-leonardo@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1311ce1c-7e5a-f7c4-2ab2-c03e124ca1c1@c-s.fr>
Date:   Thu, 6 Feb 2020 06:46:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206030900.147032-4-leonardo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 06/02/2020 à 04:08, Leonardo Bras a écrit :
> On powerpc, we need to do some lockless pagetable walks from functions
> that already have disabled interrupts, specially from real mode with
> MSR[EE=0].
> 
> In these contexts, disabling/enabling interrupts can be very troubling.

When interrupts are already disabled, the flag returned when disabling 
it will be such that when we restore it later, interrupts remain 
disabled, so what's the problem ?

> 
> So, this arch-specific implementation features functions with an extra
> argument that allows interrupt enable/disable to be skipped:
> __begin_lockless_pgtbl_walk() and __end_lockless_pgtbl_walk().
> 
> Functions similar to the generic ones are also exported, by calling
> the above functions with parameter {en,dis}able_irq = true.
> 
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/book3s/64/pgtable.h |  6 ++
>   arch/powerpc/mm/book3s64/pgtable.c           | 86 +++++++++++++++++++-
>   2 files changed, 91 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 201a69e6a355..78f6ffb1bb3e 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -1375,5 +1375,11 @@ static inline bool pgd_is_leaf(pgd_t pgd)
>   	return !!(pgd_raw(pgd) & cpu_to_be64(_PAGE_PTE));
>   }
>   
> +#define __HAVE_ARCH_LOCKLESS_PGTBL_WALK_CONTROL
> +unsigned long begin_lockless_pgtbl_walk(void);
> +unsigned long __begin_lockless_pgtbl_walk(bool disable_irq);
> +void end_lockless_pgtbl_walk(unsigned long irq_mask);
> +void __end_lockless_pgtbl_walk(unsigned long irq_mask, bool enable_irq);
> +

Why not make them static inline just like the generic ones ?

>   #endif /* __ASSEMBLY__ */
>   #endif /* _ASM_POWERPC_BOOK3S_64_PGTABLE_H_ */
> diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
> index 2bf7e1b4fd82..535613030363 100644
> --- a/arch/powerpc/mm/book3s64/pgtable.c
> +++ b/arch/powerpc/mm/book3s64/pgtable.c
> @@ -82,6 +82,7 @@ static void do_nothing(void *unused)
>   {
>   
>   }
> +

Is this blank line related to the patch ?

>   /*
>    * Serialize against find_current_mm_pte which does lock-less
>    * lookup in page tables with local interrupts disabled. For huge pages
> @@ -98,6 +99,89 @@ void serialize_against_pte_lookup(struct mm_struct *mm)
>   	smp_call_function_many(mm_cpumask(mm), do_nothing, NULL, 1);
>   }
>   
> +/* begin_lockless_pgtbl_walk: Must be inserted before a function call that does
> + *   lockless pagetable walks, such as __find_linux_pte().
> + * This version allows setting disable_irq=false, so irqs are not touched, which
> + *   is quite useful for running when ints are already disabled (like real-mode)
> + */
> +inline
> +unsigned long __begin_lockless_pgtbl_walk(bool disable_irq)
> +{
> +	unsigned long irq_mask = 0;
> +
> +	/*
> +	 * Interrupts must be disabled during the lockless page table walk.
> +	 * That's because the deleting or splitting involves flushing TLBs,
> +	 * which in turn issues interrupts, that will block when disabled.
> +	 *
> +	 * When this function is called from realmode with MSR[EE=0],
> +	 * it's not needed to touch irq, since it's already disabled.
> +	 */
> +	if (disable_irq)
> +		local_irq_save(irq_mask);
> +
> +	/*
> +	 * This memory barrier pairs with any code that is either trying to
> +	 * delete page tables, or split huge pages. Without this barrier,
> +	 * the page tables could be read speculatively outside of interrupt
> +	 * disabling or reference counting.
> +	 */
> +	smp_mb();
> +
> +	return irq_mask;
> +}
> +EXPORT_SYMBOL(__begin_lockless_pgtbl_walk);
> +
> +/* begin_lockless_pgtbl_walk: Must be inserted before a function call that does
> + *   lockless pagetable walks, such as __find_linux_pte().
> + * This version is used by generic code, and always assume irqs will be disabled
> + */
> +unsigned long begin_lockless_pgtbl_walk(void)
> +{
> +	return __begin_lockless_pgtbl_walk(true);
> +}
> +EXPORT_SYMBOL(begin_lockless_pgtbl_walk);

Even more than begin_lockless_pgtbl_walk(), this one is worth being 
static inline in the H file.

> +
> +/*
> + * __end_lockless_pgtbl_walk: Must be inserted after the last use of a pointer
> + *   returned by a lockless pagetable walk, such as __find_linux_pte()
> + * This version allows setting enable_irq=false, so irqs are not touched, which
> + *   is quite useful for running when ints are already disabled (like real-mode)
> + */
> +inline void __end_lockless_pgtbl_walk(unsigned long irq_mask, bool enable_irq)
> +{
> +	/*
> +	 * This memory barrier pairs with any code that is either trying to
> +	 * delete page tables, or split huge pages. Without this barrier,
> +	 * the page tables could be read speculatively outside of interrupt
> +	 * disabling or reference counting.
> +	 */
> +	smp_mb();
> +
> +	/*
> +	 * Interrupts must be disabled during the lockless page table walk.
> +	 * That's because the deleting or splitting involves flushing TLBs,
> +	 * which in turn issues interrupts, that will block when disabled.
> +	 *
> +	 * When this function is called from realmode with MSR[EE=0],
> +	 * it's not needed to touch irq, since it's already disabled.
> +	 */
> +	if (enable_irq)
> +		local_irq_restore(irq_mask);
> +}
> +EXPORT_SYMBOL(__end_lockless_pgtbl_walk);
> +
> +/*
> + * end_lockless_pgtbl_walk: Must be inserted after the last use of a pointer
> + *   returned by a lockless pagetable walk, such as __find_linux_pte()
> + * This version is used by generic code, and always assume irqs will be enabled
> + */
> +void end_lockless_pgtbl_walk(unsigned long irq_mask)
> +{
> +	__end_lockless_pgtbl_walk(irq_mask, true);
> +}
> +EXPORT_SYMBOL(end_lockless_pgtbl_walk);
> +
>   /*
>    * We use this to invalidate a pmdp entry before switching from a
>    * hugepte to regular pmd entry.
> @@ -487,7 +571,7 @@ static int __init setup_disable_tlbie(char *str)
>   	tlbie_capable = false;
>   	tlbie_enabled = false;
>   
> -        return 1;
> +	return 1;

Is that related to this patch at all ?

>   }
>   __setup("disable_tlbie", setup_disable_tlbie);
>   
> 

Christophe
