Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B47258614
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 05:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgIADRM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 23:17:12 -0400
Received: from foss.arm.com ([217.140.110.172]:35868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgIADRM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Aug 2020 23:17:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 173DA30E;
        Mon, 31 Aug 2020 20:17:11 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3437E3F68F;
        Mon, 31 Aug 2020 20:17:05 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v3 04/13] mm/debug_vm_pgtables/hugevmap: Use the arch
 helper to identify huge vmap support.
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
 <20200827080438.315345-5-aneesh.kumar@linux.ibm.com>
Message-ID: <eaf15275-f1b1-c5c7-f649-d2b43e4b4ac4@arm.com>
Date:   Tue, 1 Sep 2020 08:46:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200827080438.315345-5-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 08/27/2020 01:34 PM, Aneesh Kumar K.V wrote:
> ppc64 supports huge vmap only with radix translation. Hence use arch helper
> to determine the huge vmap support.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  mm/debug_vm_pgtable.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index bbf9df0e64c6..28f9d0558c20 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -28,6 +28,7 @@
>  #include <linux/swapops.h>
>  #include <linux/start_kernel.h>
>  #include <linux/sched/mm.h>
> +#include <linux/io.h>
>  #include <asm/pgalloc.h>
>  #include <asm/tlbflush.h>
>  
> @@ -206,11 +207,12 @@ static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot)
>  	WARN_ON(!pmd_leaf(pmd));
>  }
>  
> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
>  static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
>  {
>  	pmd_t pmd;
>  
> -	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP))
> +	if (!arch_ioremap_pmd_supported())
>  		return;
>  
>  	pr_debug("Validating PMD huge\n");
> @@ -224,6 +226,10 @@ static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
>  	pmd = READ_ONCE(*pmdp);
>  	WARN_ON(!pmd_none(pmd));
>  }
> +#else /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
> +static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot) { }
> +#endif /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
> +

Some small nits here.

- s/!CONFIG_HAVE_ARCH_HUGE_VMAP/CONFIG_HAVE_ARCH_HUGE_VMAP
- Drop the extra line at the end
- Move the { } down just to be consistent with existing stub for pmd_huge_tests()

>  
>  static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot)
>  {
> @@ -320,11 +326,12 @@ static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot)
>  	WARN_ON(!pud_leaf(pud));
>  }
>  
> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
>  static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
>  {
>  	pud_t pud;
>  
> -	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP))
> +	if (!arch_ioremap_pud_supported())
>  		return;
>  
>  	pr_debug("Validating PUD huge\n");
> @@ -338,6 +345,10 @@ static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
>  	pud = READ_ONCE(*pudp);
>  	WARN_ON(!pud_none(pud));
>  }
> +#else /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
> +static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot) { }
> +#endif /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
> +

Some small nits here.

- s/!CONFIG_HAVE_ARCH_HUGE_VMAP/CONFIG_HAVE_ARCH_HUGE_VMAP
- Drop the extra line at the end
- Move the { } down just to be consistent with existing stub for pud_huge_tests()

>  #else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
>  static void __init pud_basic_tests(unsigned long pfn, pgprot_t prot) { }
>  static void __init pud_advanced_tests(struct mm_struct *mm,
>
