Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0077E153E68
	for <lists+linux-arch@lfdr.de>; Thu,  6 Feb 2020 06:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgBFFyo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Feb 2020 00:54:44 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:9160 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgBFFyo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Feb 2020 00:54:44 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48Cnh11K9LzB09b4;
        Thu,  6 Feb 2020 06:54:41 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=S0F7eAPt; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id PeyJBm5d3ZjO; Thu,  6 Feb 2020 06:54:41 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48Cnh06jH1zB09b3;
        Thu,  6 Feb 2020 06:54:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1580968480; bh=+f8zGT9Ebstem/Pxu4Cc5kGrF5RDE+p8c6MevcVDVRY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=S0F7eAPt7dAILYlJsklcUf+6F62oSjTIx7JnglrKhz714+RhC1qH7YiuZIag86/SP
         iOtkJ41PYMq7as/vgcVlvIC7B892qJ2prn5WkGVNA7Lrn6l0P75rW/jvDwBTaO5tcr
         bjeXm4IrDa8ro+bGiE5QSFM5FtpGZAbMttDt3MeM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B002F8B787;
        Thu,  6 Feb 2020 06:54:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id EalpXgNeYE9k; Thu,  6 Feb 2020 06:54:41 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0AEA38B776;
        Thu,  6 Feb 2020 06:54:40 +0100 (CET)
Subject: Re: [PATCH v6 01/11] asm-generic/pgtable: Adds generic functions to
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
 <20200206030900.147032-2-leonardo@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <f55e593c-27d5-df12-602f-ea217f62c5a1@c-s.fr>
Date:   Thu, 6 Feb 2020 06:54:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206030900.147032-2-leonardo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 06/02/2020 à 04:08, Leonardo Bras a écrit :
> It's necessary to track lockless pagetable walks, in order to avoid doing
> THP splitting/collapsing during them.
> 
> The default solution is to disable irq before lockless pagetable walks and
> enable it after it's finished.
> 
> On code, this means you can find local_irq_disable() and local_irq_enable()
> around some pieces of code, usually without comments on why it is needed.
> 
> This patch proposes a set of generic functions to be called before starting
> and after finishing a lockless pagetable walk. It is supposed to make clear
> that a lockless pagetable walk happens there, and also carries information
> on why the irq disable/enable is needed.
> 
> begin_lockless_pgtbl_walk()
>          Insert before starting any lockless pgtable walk
> end_lockless_pgtbl_walk()
>          Insert after the end of any lockless pgtable walk
>          (Mostly after the ptep is last used)
> 
> A memory barrier was also added just to make sure there is no speculative
> read outside the interrupt disabled area. Other than that, it is not
> supposed to have any change of behavior from current code.

Is that speculative barrier necessary for all architectures ? Does it 
impact performance ? Shouldn't this be another patch ?

> 
> It is planned to allow arch-specific versions, so that additional steps can
> be added while keeping the code clean.
> 
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> ---
>   include/asm-generic/pgtable.h | 51 +++++++++++++++++++++++++++++++++++
>   1 file changed, 51 insertions(+)
> 
> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
> index e2e2bef07dd2..8d368d3c0974 100644
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -1222,6 +1222,57 @@ static inline bool arch_has_pfn_modify_check(void)
>   #endif
>   #endif
>   
> +#ifndef __HAVE_ARCH_LOCKLESS_PGTBL_WALK_CONTROL
> +/*
> + * begin_lockless_pgtbl_walk: Must be inserted before a function call that does
> + *   lockless pagetable walks, such as __find_linux_pte()
> + */
> +static inline
> +unsigned long begin_lockless_pgtbl_walk(void)

What about keeping the same syntax as local_irq_save(), something like:

#define begin_lockless_pgtbl_walk(flags) \
do {
	local_irq_save(flags);
	smp_mb();
} while (0)

> +{
> +	unsigned long irq_mask;
> +
> +	/*
> +	 * Interrupts must be disabled during the lockless page table walk.
> +	 * That's because the deleting or splitting involves flushing TLBs,
> +	 * which in turn issues interrupts, that will block when disabled.
> +	 */
> +	local_irq_save(irq_mask);
> +
> +	/*
> +	 * This memory barrier pairs with any code that is either trying to
> +	 * delete page tables, or split huge pages. Without this barrier,
> +	 * the page tables could be read speculatively outside of interrupt
> +	 * disabling.
> +	 */
> +	smp_mb();
> +
> +	return irq_mask;
> +}
> +
> +/*
> + * end_lockless_pgtbl_walk: Must be inserted after the last use of a pointer
> + *   returned by a lockless pagetable walk, such as __find_linux_pte()
> + */
> +static inline void end_lockless_pgtbl_walk(unsigned long irq_mask)

Same

#define end_lockless_pgtbl_walk(flags) \
do {
	smp_mb();
	local_irq_restore(flags);
} while (0);

> +{
> +	/*
> +	 * This memory barrier pairs with any code that is either trying to
> +	 * delete page tables, or split huge pages. Without this barrier,
> +	 * the page tables could be read speculatively outside of interrupt
> +	 * disabling.
> +	 */
> +	smp_mb();
> +
> +	/*
> +	 * Interrupts must be disabled during the lockless page table walk.
> +	 * That's because the deleting or splitting involves flushing TLBs,
> +	 * which in turn issues interrupts, that will block when disabled.
> +	 */
> +	local_irq_restore(irq_mask);
> +}
> +#endif
> +
>   /*
>    * On some architectures it depends on the mm if the p4d/pud or pmd
>    * layer of the page table hierarchy is folded or not.
> 

Christophe
