Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADCF153EA9
	for <lists+linux-arch@lfdr.de>; Thu,  6 Feb 2020 07:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgBFGX2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Feb 2020 01:23:28 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:19958 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgBFGX2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Feb 2020 01:23:28 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48CpK93w5BzB09bK;
        Thu,  6 Feb 2020 07:23:25 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Y1dU660X; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id asWDc9O33Sil; Thu,  6 Feb 2020 07:23:25 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48CpK92fmTzB09bJ;
        Thu,  6 Feb 2020 07:23:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1580970205; bh=Uq8b4GJRWETNuaD6MUNnvgK+ffhgHHEsOWcKLASMC18=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Y1dU660XxRdZdA/27zEbpyOzaLtZOAGcSuIkJ/dj/pX+E56+LZXTBB0QWP8a4K+gh
         AaHGyK/mapKR1p7C6UkWKhJ8+0ru8mvW6YrfYcPBnryov7Nzxfp7efEhnOMJBPfo8m
         O8BFRVCXordsMjJ4rkwVuB+loP+QV7QLwGZp2vJE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3838D8B85F;
        Thu,  6 Feb 2020 07:23:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id R5Za9e4aaC32; Thu,  6 Feb 2020 07:23:26 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6BBC78B776;
        Thu,  6 Feb 2020 07:23:24 +0100 (CET)
Subject: Re: [PATCH v6 10/11] powerpc/mm: Adds counting method to track
 lockless pagetable walks
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
 <20200206030900.147032-11-leonardo@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d9bf6878-43d5-b45a-7abb-cdcb712a0d7a@c-s.fr>
Date:   Thu, 6 Feb 2020 07:23:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206030900.147032-11-leonardo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 06/02/2020 à 04:08, Leonardo Bras a écrit :
> Implements an additional feature to track lockless pagetable walks,
> using a per-cpu counter: lockless_pgtbl_walk_counter.
> 
> Before a lockless pagetable walk, preemption is disabled and the
> current cpu's counter is increased.
> When the lockless pagetable walk finishes, the current cpu counter
> is decreased and the preemption is enabled.
> 
> With that, it's possible to know in which cpus are happening lockless
> pagetable walks, and optimize serialize_against_pte_lookup().
> 
> Implementation notes:
> - Every counter can be changed only by it's CPU
> - It makes use of the original memory barrier in the functions
> - Any counter can be read by any CPU
> 
> Due to not locking nor using atomic variables, the impact on the
> lockless pagetable walk is intended to be minimum.

atomic variables have a lot less impact than preempt_enable/disable.

preemt_disable forces a re-scheduling, it really has impact. Why not use 
atomic variables instead ?

Christophe

> 
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> ---
>   arch/powerpc/mm/book3s64/pgtable.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
> index 535613030363..bb138b628f86 100644
> --- a/arch/powerpc/mm/book3s64/pgtable.c
> +++ b/arch/powerpc/mm/book3s64/pgtable.c
> @@ -83,6 +83,7 @@ static void do_nothing(void *unused)
>   
>   }
>   
> +static DEFINE_PER_CPU(int, lockless_pgtbl_walk_counter);
>   /*
>    * Serialize against find_current_mm_pte which does lock-less
>    * lookup in page tables with local interrupts disabled. For huge pages
> @@ -120,6 +121,15 @@ unsigned long __begin_lockless_pgtbl_walk(bool disable_irq)
>   	if (disable_irq)
>   		local_irq_save(irq_mask);
>   
> +	/*
> +	 * Counts this instance of lockless pagetable walk for this cpu.
> +	 * Disables preempt to make sure there is no cpu change between
> +	 * begin/end lockless pagetable walk, so that percpu counting
> +	 * works fine.
> +	 */
> +	preempt_disable();
> +	(*this_cpu_ptr(&lockless_pgtbl_walk_counter))++;
> +
>   	/*
>   	 * This memory barrier pairs with any code that is either trying to
>   	 * delete page tables, or split huge pages. Without this barrier,
> @@ -158,6 +168,14 @@ inline void __end_lockless_pgtbl_walk(unsigned long irq_mask, bool enable_irq)
>   	 */
>   	smp_mb();
>   
> +	/*
> +	 * Removes this instance of lockless pagetable walk for this cpu.
> +	 * Enables preempt only after end lockless pagetable walk,
> +	 * so that percpu counting works fine.
> +	 */
> +	(*this_cpu_ptr(&lockless_pgtbl_walk_counter))--;
> +	preempt_enable();
> +
>   	/*
>   	 * Interrupts must be disabled during the lockless page table walk.
>   	 * That's because the deleting or splitting involves flushing TLBs,
> 
