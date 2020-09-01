Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A94258695
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 06:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgIAEDn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 00:03:43 -0400
Received: from foss.arm.com ([217.140.110.172]:36382 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgIAEDm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Sep 2020 00:03:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C839430E;
        Mon, 31 Aug 2020 21:03:41 -0700 (PDT)
Received: from [10.163.69.171] (unknown [10.163.69.171])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7EAD3F68F;
        Mon, 31 Aug 2020 21:03:36 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v3 12/13] mm/debug_vm_pgtable/hugetlb: Disable hugetlb
 test on ppc64
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
 <20200827080438.315345-13-aneesh.kumar@linux.ibm.com>
Message-ID: <6191e77f-c3b7-21ea-6dbd-eecc09735923@arm.com>
Date:   Tue, 1 Sep 2020 09:33:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200827080438.315345-13-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 08/27/2020 01:34 PM, Aneesh Kumar K.V wrote:
> The seems to be missing quite a lot of details w.r.t allocating
> the correct pgtable_t page (huge_pte_alloc()), holding the right
> lock (huge_pte_lock()) etc. The vma used is also not a hugetlb VMA.
> 
> ppc64 do have runtime checks within CONFIG_DEBUG_VM for most of these.
> Hence disable the test on ppc64.

Would really like this to get resolved in an uniform and better way
instead, i.e a modified hugetlb_advanced_tests() which works on all
platforms including ppc64.

In absence of a modified version, I do realize the situation here,
where DEBUG_VM_PGTABLE test either runs on ppc64 or just completely
remove hugetlb_advanced_tests() from other platforms as well.

> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  mm/debug_vm_pgtable.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index a188b6e4e37e..21329c7d672f 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -813,6 +813,7 @@ static void __init hugetlb_basic_tests(unsigned long pfn, pgprot_t prot)
>  #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
>  }
>  
> +#ifndef CONFIG_PPC_BOOK3S_64
>  static void __init hugetlb_advanced_tests(struct mm_struct *mm,
>  					  struct vm_area_struct *vma,
>  					  pte_t *ptep, unsigned long pfn,
> @@ -855,6 +856,7 @@ static void __init hugetlb_advanced_tests(struct mm_struct *mm,
>  	pte = huge_ptep_get(ptep);
>  	WARN_ON(!(huge_pte_write(pte) && huge_pte_dirty(pte)));
>  }
> +#endif

In the worst case if we could not get a new hugetlb_advanced_tests() test
that works on all platforms, this might be the last fallback option. In
which case, it will require a proper comment section with a "FIXME: ",
explaining the current situation (and that #ifdef is temporary in nature)
and a hugetlb_advanced_tests() stub when CONFIG_PPC_BOOK3S_64 is enabled.

>  #else  /* !CONFIG_HUGETLB_PAGE */
>  static void __init hugetlb_basic_tests(unsigned long pfn, pgprot_t prot) { }
>  static void __init hugetlb_advanced_tests(struct mm_struct *mm,
> @@ -1065,7 +1067,9 @@ static int __init debug_vm_pgtable(void)
>  	pud_populate_tests(mm, pudp, saved_pmdp);
>  	spin_unlock(ptl);
>  
> +#ifndef CONFIG_PPC_BOOK3S_64
>  	hugetlb_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
> +#endif

#ifdef will not be required here as there would be a stub definition
for hugetlb_advanced_tests() when CONFIG_PPC_BOOK3S_64 is enabled.

>  
>  	spin_lock(&mm->page_table_lock);
>  	p4d_clear_tests(mm, p4dp);
> 

But again, we should really try and avoid taking this path.
