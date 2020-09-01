Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB644258621
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 05:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgIADXB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 23:23:01 -0400
Received: from foss.arm.com ([217.140.110.172]:36024 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgIADXA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Aug 2020 23:23:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF8C830E;
        Mon, 31 Aug 2020 20:22:59 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D69F63F68F;
        Mon, 31 Aug 2020 20:22:54 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v3 08/13] mm/debug_vm_pgtable/thp: Use page table
 depost/withdraw with THP
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, x86@kernel.org,
        linux-arch@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Vineet Gupta <vgupta@synopsys.com>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
 <20200827080438.315345-9-aneesh.kumar@linux.ibm.com>
Message-ID: <e7877a8d-b433-0cb4-50a7-631de0022c24@arm.com>
Date:   Tue, 1 Sep 2020 08:52:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200827080438.315345-9-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 08/27/2020 01:34 PM, Aneesh Kumar K.V wrote:
> Architectures like ppc64 use deposited page table while updating the huge pte
> entries.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  mm/debug_vm_pgtable.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index f9f6358899a8..0ce5c6a24c5b 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -154,7 +154,7 @@ static void __init pmd_basic_tests(unsigned long pfn, pgprot_t prot)
>  static void __init pmd_advanced_tests(struct mm_struct *mm,
>  				      struct vm_area_struct *vma, pmd_t *pmdp,
>  				      unsigned long pfn, unsigned long vaddr,
> -				      pgprot_t prot)
> +				      pgprot_t prot, pgtable_t pgtable)
>  {
>  	pmd_t pmd;
>  
> @@ -165,6 +165,8 @@ static void __init pmd_advanced_tests(struct mm_struct *mm,
>  	/* Align the address wrt HPAGE_PMD_SIZE */
>  	vaddr = (vaddr & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE;
>  
> +	pgtable_trans_huge_deposit(mm, pmdp, pgtable);
> +
>  	pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
>  	set_pmd_at(mm, vaddr, pmdp, pmd);
>  	pmdp_set_wrprotect(mm, vaddr, pmdp);
> @@ -193,6 +195,8 @@ static void __init pmd_advanced_tests(struct mm_struct *mm,
>  	pmdp_test_and_clear_young(vma, vaddr, pmdp);
>  	pmd = READ_ONCE(*pmdp);
>  	WARN_ON(pmd_young(pmd));
> +
> +	pgtable = pgtable_trans_huge_withdraw(mm, pmdp);

Should the call sites here be wrapped with __HAVE_ARCH_PGTABLE_DEPOSIT and
__HAVE_ARCH_PGTABLE_WITHDRAW respectively. Though there are generic fallback
definitions, wondering whether they are indeed essential for all platforms.

>  }
>  
>  static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot)
> @@ -373,7 +377,7 @@ static void __init pud_basic_tests(unsigned long pfn, pgprot_t prot) { }
>  static void __init pmd_advanced_tests(struct mm_struct *mm,
>  				      struct vm_area_struct *vma, pmd_t *pmdp,
>  				      unsigned long pfn, unsigned long vaddr,
> -				      pgprot_t prot)
> +				      pgprot_t prot, pgtable_t pgtable)
>  {
>  }
>  static void __init pud_advanced_tests(struct mm_struct *mm,
> @@ -1015,7 +1019,7 @@ static int __init debug_vm_pgtable(void)
>  	pgd_clear_tests(mm, pgdp);
>  
>  	pte_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
> -	pmd_advanced_tests(mm, vma, pmdp, pmd_aligned, vaddr, prot);
> +	pmd_advanced_tests(mm, vma, pmdp, pmd_aligned, vaddr, prot, saved_ptep);
>  	pud_advanced_tests(mm, vma, pudp, pud_aligned, vaddr, prot);
>  	hugetlb_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
>  
> 

There is a checkpatch.pl warning here.

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#7: 
Architectures like ppc64 use deposited page table while updating the huge pte

total: 0 errors, 1 warnings, 40 lines checked
