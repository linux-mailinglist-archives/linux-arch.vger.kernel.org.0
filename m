Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE18176F06
	for <lists+linux-arch@lfdr.de>; Tue,  3 Mar 2020 06:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgCCF7t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Mar 2020 00:59:49 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:50442 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgCCF7t (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Mar 2020 00:59:49 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48WmYt2NC7z9tyyX;
        Tue,  3 Mar 2020 06:59:46 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=sXKIwD1R; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id UVZtmD4b7vsp; Tue,  3 Mar 2020 06:59:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48WmYt108kz9tyyS;
        Tue,  3 Mar 2020 06:59:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1583215186; bh=ocYA26gERwg/bGzKOX6R9AQoOaFWREyAef/Kd9zo+5s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sXKIwD1RD3BLfW6HS5aTsLH2zDt5HeqokUB+K7FsxVkoJhvVgR9r7Ff79VBf3fPhg
         IjF4WeUvoHflMO8+N2ifkTwV8WIp6KloKV0XCSvcbUBFZYWyK3co0cvATpqgmD7E3m
         B5ViAb14Ei63PR4Qy3/Ndcwn06LEcho6L0JaXjUc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D1E5C8B79A;
        Tue,  3 Mar 2020 06:59:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id b_l-0DSpkXO5; Tue,  3 Mar 2020 06:59:46 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 081278B755;
        Tue,  3 Mar 2020 06:59:44 +0100 (CET)
Subject: Re: [PATCH V14] mm/debug: Add tests validating architecture page
 table helpers
To:     Qian Cai <cai@lca.pw>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1581909460-19148-1-git-send-email-anshuman.khandual@arm.com>
 <1582726182.7365.123.camel@lca.pw>
 <7c707b7f-ce3d-993b-8042-44fdc1ed28bf@c-s.fr>
 <1582732318.7365.129.camel@lca.pw> <1583178042.7365.146.camel@lca.pw>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <6757aa1d-7951-69ef-de93-50a7b7b172e0@c-s.fr>
Date:   Tue, 3 Mar 2020 06:59:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1583178042.7365.146.camel@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 02/03/2020 à 20:40, Qian Cai a écrit :
> On Wed, 2020-02-26 at 10:51 -0500, Qian Cai wrote:
>> On Wed, 2020-02-26 at 15:45 +0100, Christophe Leroy wrote:
>>>
>>> Le 26/02/2020 à 15:09, Qian Cai a écrit :
>>>> On Mon, 2020-02-17 at 08:47 +0530, Anshuman Khandual wrote:
>>>>> This adds tests which will validate architecture page table helpers and
>>>>> other accessors in their compliance with expected generic MM semantics.
>>>>> This will help various architectures in validating changes to existing
>>>>> page table helpers or addition of new ones.
>>>>>
>>>>> This test covers basic page table entry transformations including but not
>>>>> limited to old, young, dirty, clean, write, write protect etc at various
>>>>> level along with populating intermediate entries with next page table page
>>>>> and validating them.
>>>>>
>>>>> Test page table pages are allocated from system memory with required size
>>>>> and alignments. The mapped pfns at page table levels are derived from a
>>>>> real pfn representing a valid kernel text symbol. This test gets called
>>>>> inside kernel_init() right after async_synchronize_full().
>>>>>
>>>>> This test gets built and run when CONFIG_DEBUG_VM_PGTABLE is selected. Any
>>>>> architecture, which is willing to subscribe this test will need to select
>>>>> ARCH_HAS_DEBUG_VM_PGTABLE. For now this is limited to arc, arm64, x86, s390
>>>>> and ppc32 platforms where the test is known to build and run successfully.
>>>>> Going forward, other architectures too can subscribe the test after fixing
>>>>> any build or runtime problems with their page table helpers. Meanwhile for
>>>>> better platform coverage, the test can also be enabled with CONFIG_EXPERT
>>>>> even without ARCH_HAS_DEBUG_VM_PGTABLE.
>>>>>
>>>>> Folks interested in making sure that a given platform's page table helpers
>>>>> conform to expected generic MM semantics should enable the above config
>>>>> which will just trigger this test during boot. Any non conformity here will
>>>>> be reported as an warning which would need to be fixed. This test will help
>>>>> catch any changes to the agreed upon semantics expected from generic MM and
>>>>> enable platforms to accommodate it thereafter.
>>>>
>>>> How useful is this that straightly crash the powerpc?
>>>>
>>>> [   23.263425][    T1] debug_vm_pgtable: debug_vm_pgtable: Validating
>>>> architecture page table helpers
>>>> [   23.263625][    T1] ------------[ cut here ]------------
>>>> [   23.263649][    T1] kernel BUG at arch/powerpc/mm/pgtable.c:274!
>>>
>>> The problem on PPC64 is known and has to be investigated and fixed.
>>
>> It might be interesting to hear what powerpc64 maintainers would say about it
>> and if it is actually worth "fixing" in the arch code, but that BUG_ON() was
>> there since 2009 and had not been exposed until this patch comes alone?
> 
> This patch below makes it works on powerpc64 in order to dodge the BUG_ON()s in
> assert_pte_locked() triggered by pte_clear_tests().
> 
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 96dd7d574cef..50b385233971 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -55,6 +55,8 @@
>   #define RANDOM_ORVALUE	GENMASK(BITS_PER_LONG - 1, S390_MASK_BITS)
>   #define RANDOM_NZVALUE	GENMASK(7, 0)
>   
> +unsigned long vaddr;
> +

Can we avoid global var ?

>   static void __init pte_basic_tests(unsigned long pfn, pgprot_t prot)
>   {
>   	pte_t pte = pfn_pte(pfn, prot);
> @@ -256,7 +258,7 @@ static void __init pte_clear_tests(struct mm_struct *mm,
> pte_t *ptep)
>   
>   	pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
>   	WRITE_ONCE(*ptep, pte);
> -	pte_clear(mm, 0, ptep);
> +	pte_clear(mm, vaddr, ptep);
>   	pte = READ_ONCE(*ptep);
>   	WARN_ON(!pte_none(pte));
>   }
> @@ -310,8 +312,9 @@ void __init debug_vm_pgtable(void)
>   	pgtable_t saved_ptep;
>   	pgprot_t prot;
>   	phys_addr_t paddr;
> -	unsigned long vaddr, pte_aligned, pmd_aligned;

Can we pass local vaddr to pte_clear_tests() instead of making it a 
global var ?

> +	unsigned long pte_aligned, pmd_aligned;
>   	unsigned long pud_aligned, p4d_aligned, pgd_aligned;
> +	spinlock_t *ptl;
>   
>   	pr_info("Validating architecture page table helpers\n");
>   	prot = vm_get_page_prot(VMFLAGS);
> @@ -344,7 +347,7 @@ void __init debug_vm_pgtable(void)
>   	p4dp = p4d_alloc(mm, pgdp, vaddr);
>   	pudp = pud_alloc(mm, p4dp, vaddr);
>   	pmdp = pmd_alloc(mm, pudp, vaddr);
> -	ptep = pte_alloc_map(mm, pmdp, vaddr);
> +	ptep = pte_alloc_map_lock(mm, pmdp, vaddr, &ptl);
>   
>   	/*
>   	 * Save all the page table page addresses as the page table
> @@ -370,7 +373,7 @@ void __init debug_vm_pgtable(void)
>   	p4d_clear_tests(mm, p4dp);
>   	pgd_clear_tests(mm, pgdp);
>   
> -	pte_unmap(ptep);
> +	pte_unmap_unlock(ptep, ptl);
>   
>   	pmd_populate_tests(mm, pmdp, saved_ptep);
>   	pud_populate_tests(mm, pudp, saved_pmdp);
> 

Christophe
