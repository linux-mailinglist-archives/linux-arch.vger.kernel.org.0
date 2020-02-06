Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C67B153E9E
	for <lists+linux-arch@lfdr.de>; Thu,  6 Feb 2020 07:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgBFGSI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Feb 2020 01:18:08 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:19642 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgBFGSI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Feb 2020 01:18:08 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48CpC01NgvzB09bJ;
        Thu,  6 Feb 2020 07:18:04 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=IJc3jder; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Ff_laLB1i3Yt; Thu,  6 Feb 2020 07:18:04 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48CpC008FQzB09bG;
        Thu,  6 Feb 2020 07:18:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1580969884; bh=/zXspG1kSDBchHeXMPNEW4CMohV4cfmd+YhDCREVeRU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IJc3jderGna62CaEbuKOvFjwfgtAoqVWDE/KIjuvt5lVBel/amt4R+kH9JR8F0zKw
         WAex/t5oBpzyaF9Z2SiGAv2B3XAU6NFAGf9SqVrv+8Utda7pe6bWVzA08BRFijg6AW
         z6fcy7RHCPd0QkreMH9zr+46SWRtxYBXVtnBy+Ug=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CCBF78B85E;
        Thu,  6 Feb 2020 07:18:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JUidJKGusZ7Y; Thu,  6 Feb 2020 07:18:04 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 289C18B776;
        Thu,  6 Feb 2020 07:18:03 +0100 (CET)
Subject: Re: [PATCH v6 07/11] powerpc/kvm/e500: Use functions to track
 lockless pgtbl walks
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
 <20200206030900.147032-8-leonardo@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <fae235d5-78b6-87aa-ed3f-1a908d61abf4@c-s.fr>
Date:   Thu, 6 Feb 2020 07:18:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206030900.147032-8-leonardo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 06/02/2020 à 04:08, Leonardo Bras a écrit :
> Applies the new functions used for tracking lockless pgtable walks on
> kvmppc_e500_shadow_map().
> 
> Fixes the place where local_irq_restore() is called: previously, if ptep
> was NULL, local_irq_restore() would never be called.
> 
> local_irq_{save,restore} is already inside {begin,end}_lockless_pgtbl_walk,
> so there is no need to repeat it here.
> 
> Variable that saves the	irq mask was renamed from flags to irq_mask so it
> doesn't lose meaning now it's not directly passed to local_irq_* functions.
> 
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> ---
>   arch/powerpc/kvm/e500_mmu_host.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
> index 425d13806645..3dcf11f77256 100644
> --- a/arch/powerpc/kvm/e500_mmu_host.c
> +++ b/arch/powerpc/kvm/e500_mmu_host.c
> @@ -336,7 +336,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
>   	pte_t *ptep;
>   	unsigned int wimg = 0;
>   	pgd_t *pgdir;
> -	unsigned long flags;
> +	unsigned long irq_mask;
>   
>   	/* used to check for invalidations in progress */
>   	mmu_seq = kvm->mmu_notifier_seq;
> @@ -473,7 +473,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
>   	 * We are holding kvm->mmu_lock so a notifier invalidate
>   	 * can't run hence pfn won't change.
>   	 */
> -	local_irq_save(flags);
> +	irq_mask = begin_lockless_pgtbl_walk();
>   	ptep = find_linux_pte(pgdir, hva, NULL, NULL);
>   	if (ptep) {
>   		pte_t pte = READ_ONCE(*ptep);
> @@ -481,15 +481,16 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
>   		if (pte_present(pte)) {
>   			wimg = (pte_val(pte) >> PTE_WIMGE_SHIFT) &
>   				MAS2_WIMGE_MASK;
> -			local_irq_restore(flags);
>   		} else {
> -			local_irq_restore(flags);
> +			end_lockless_pgtbl_walk(irq_mask);
>   			pr_err_ratelimited("%s: pte not present: gfn %lx,pfn %lx\n",
>   					   __func__, (long)gfn, pfn);
>   			ret = -EINVAL;
>   			goto out;
>   		}
>   	}
> +	end_lockless_pgtbl_walk(irq_mask);
> +

I don't really like unbalanced begin/end.

Something like the following would be cleaner:


begin_lockless_pgtbl_walk()
ptep = find()
if (ptep) {
	pte = READ_ONCE()
	if (pte_present(pte))
		wing=
	else
		ret = -EINVAL;
}
end_lockless_pgtbl_walk()

if (ret) {
	pr_err_rate...()
	goto out;
}



>   	kvmppc_e500_ref_setup(ref, gtlbe, pfn, wimg);
>   
>   	kvmppc_e500_setup_stlbe(&vcpu_e500->vcpu, gtlbe, tsize,
> 

Christophe
