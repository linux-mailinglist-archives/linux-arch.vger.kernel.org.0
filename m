Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8039925866C
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 05:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgIADpP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 23:45:15 -0400
Received: from foss.arm.com ([217.140.110.172]:36256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgIADpP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Aug 2020 23:45:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00C2F30E;
        Mon, 31 Aug 2020 20:45:14 -0700 (PDT)
Received: from [10.163.69.171] (unknown [10.163.69.171])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 806F83F68F;
        Mon, 31 Aug 2020 20:45:09 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v3 10/13] mm/debug_vm_pgtable/locks: Take correct page
 table lock
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
 <20200827080438.315345-11-aneesh.kumar@linux.ibm.com>
Message-ID: <7da0de4c-8fc8-7e40-c9f7-a8f2d875e364@arm.com>
Date:   Tue, 1 Sep 2020 09:14:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200827080438.315345-11-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 08/27/2020 01:34 PM, Aneesh Kumar K.V wrote:
> Make sure we call pte accessors with correct lock held.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  mm/debug_vm_pgtable.c | 34 ++++++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 78c8af3445ac..0a6e771ebd13 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -1039,33 +1039,39 @@ static int __init debug_vm_pgtable(void)
>  	pmd_thp_tests(pmd_aligned, prot);
>  	pud_thp_tests(pud_aligned, prot);
>  
> +	hugetlb_basic_tests(pte_aligned, prot);
> +

This moved back again. As pointed out earlier, there will be a bisect
problem and so this patch must be folded back with the previous one.

>  	/*
>  	 * Page table modifying tests
>  	 */
> -	pte_clear_tests(mm, ptep, vaddr);
> -	pmd_clear_tests(mm, pmdp);
> -	pud_clear_tests(mm, pudp);
> -	p4d_clear_tests(mm, p4dp);
> -	pgd_clear_tests(mm, pgdp);
>  
>  	ptep = pte_alloc_map_lock(mm, pmdp, vaddr, &ptl);
> +	pte_clear_tests(mm, ptep, vaddr);
>  	pte_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
> -	pmd_advanced_tests(mm, vma, pmdp, pmd_aligned, vaddr, prot, saved_ptep);
> -	pud_advanced_tests(mm, vma, pudp, pud_aligned, vaddr, prot);
> -	hugetlb_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
> -
> +	pte_unmap_unlock(ptep, ptl);
>  
> +	ptl = pmd_lock(mm, pmdp);
> +	pmd_clear_tests(mm, pmdp);
> +	pmd_advanced_tests(mm, vma, pmdp, pmd_aligned, vaddr, prot, saved_ptep);
>  	pmd_huge_tests(pmdp, pmd_aligned, prot);
> +	pmd_populate_tests(mm, pmdp, saved_ptep);
> +	spin_unlock(ptl);
> +
> +	ptl = pud_lock(mm, pudp);
> +	pud_clear_tests(mm, pudp);
> +	pud_advanced_tests(mm, vma, pudp, pud_aligned, vaddr, prot);
>  	pud_huge_tests(pudp, pud_aligned, prot);
> +	pud_populate_tests(mm, pudp, saved_pmdp);
> +	spin_unlock(ptl);
>  
> -	pte_unmap_unlock(ptep, ptl);
> +	hugetlb_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
>  
> -	pmd_populate_tests(mm, pmdp, saved_ptep);
> -	pud_populate_tests(mm, pudp, saved_pmdp);
> +	spin_lock(&mm->page_table_lock);
> +	p4d_clear_tests(mm, p4dp);
> +	pgd_clear_tests(mm, pgdp);
>  	p4d_populate_tests(mm, p4dp, saved_pudp);
>  	pgd_populate_tests(mm, pgdp, saved_p4dp);
> -
> -	hugetlb_basic_tests(pte_aligned, prot);
> +	spin_unlock(&mm->page_table_lock);
>  
>  	p4d_free(mm, saved_p4dp);
>  	pud_free(mm, saved_pudp);
> 

Overall, grouping together dynamic tests at various page table levels and
taking a corresponding lock, makes sense. Commit message for the resultant
patch should include (a) Test classification (b) Grouping by function for
the static tests, by page table level for the dynamic tests (c) Locking
requirement for the dynamic tests each level etc.
