Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1721E766EBA
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jul 2023 15:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbjG1Ns4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Jul 2023 09:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbjG1Nsy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Jul 2023 09:48:54 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1FA3C05
        for <linux-arch@vger.kernel.org>; Fri, 28 Jul 2023 06:48:44 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bd1d0cf2fso300398866b.3
        for <linux-arch@vger.kernel.org>; Fri, 28 Jul 2023 06:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1690552122; x=1691156922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xglqSrB2iPFW2I/fuXfPFH2AjeG9G8DHiCGCdZ7AftA=;
        b=AB6+MgpeqsfDfT0Gtsokz5BQci7npK3FQ2KziJGiv0UyZ8bcgvhqc+jcNFZrgvptI9
         AIrPkUC39/8FTuu/2fdqNt4nPY7RpvzNBpE7u/1AXmaIiKrDozV1gP+5xgOZOIjJVg14
         v4JrgVF+IQYC8AW77Co4dn69YatbvqQJ1SQm5mYkHE6NZyD60qjFEj4H0s0FvdQ5X9/s
         ujEuMICe9jOyJ0EPcuouBIXvftZ9Tthnvhpr+wf+Bx5uPEZrkR50ZxRGeActqvJAADh7
         bvgMp3mmy12GUl0qjKexge/lNeaeMf3tZsrb+qxNw4/y3M9VQ2w6+z84jeC0dMO0xJRS
         5fFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690552122; x=1691156922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xglqSrB2iPFW2I/fuXfPFH2AjeG9G8DHiCGCdZ7AftA=;
        b=P6nGRpQBffX4gip8TaTb/uF+o5yef0U0Qmc6fQqht0FE9dm5EWVWI8HyS0G2Odk1e7
         fG49SdgZdCcgf+lHHSISn+ZSABKSmZjKp7Eue0wYJCERJPnlMM2G0aH+GsVEyL20TdKc
         PvqpWT0t8N1QDhipdS8ExZ3tHDlDkLD3HHTF0uWbqj7TB0gh0SC7NuQVCB6R86hqR8eo
         asfu1B+Hspp+0hA2dKAf2awY2P3HqaawcJd4Zh6JavD5VqDw5f3+GcSMGCOka9h/zV5F
         JgbUvtpavesb0AGXzRl0WPM69Rca5aq1gTGB102GSZZp9uhmEKUWXT8Tre1mDMxwWMD4
         rC0Q==
X-Gm-Message-State: ABy/qLb7hjeK+RDqFTECYwGXgMye0TXhWswVdQYr639N23a+Ab/6H25U
        1s89AEr7jHNKDxUrXV2Y2DBO5g==
X-Google-Smtp-Source: APBJJlGnEXAlsMCADN+Nq6BK+wfKYf1MY6AOSQRz7CvibJgwy8Y7+jhKeE+hbVuLfVBpD8mGaYmFsQ==
X-Received: by 2002:a17:907:7710:b0:988:6491:98e1 with SMTP id kw16-20020a170907771000b00988649198e1mr2173678ejc.42.1690552122403;
        Fri, 28 Jul 2023 06:48:42 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id t10-20020a17090616ca00b00982a352f078sm2066763ejd.124.2023.07.28.06.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 06:48:41 -0700 (PDT)
Date:   Fri, 28 Jul 2023 15:48:41 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] riscv: Improve flush_tlb_kernel_range()
Message-ID: <20230728-f5c389ac7f2a9aadf93939f5@orel>
References: <20230727185553.980262-1-alexghiti@rivosinc.com>
 <20230727185553.980262-5-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727185553.980262-5-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 27, 2023 at 08:55:53PM +0200, Alexandre Ghiti wrote:
> This function used to simply flush the whole tlb of all harts, be more
> subtile and try to only flush the range.
> 
> The problem is that we can only use PAGE_SIZE as stride since we don't know
> the size of the underlying mapping and then this function will be improved
> only if the size of the region to flush is < threshold * PAGE_SIZE.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/tlbflush.h | 11 +++++-----
>  arch/riscv/mm/tlbflush.c          | 35 +++++++++++++++++++++++--------
>  2 files changed, 32 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
> index f5c4fb0ae642..7426fdcd8ec5 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -37,6 +37,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>  void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
>  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  		     unsigned long end);
> +void flush_tlb_kernel_range(unsigned long start, unsigned long end);
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
>  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
> @@ -53,15 +54,15 @@ static inline void flush_tlb_range(struct vm_area_struct *vma,
>  	local_flush_tlb_all();
>  }
>  
> -#define flush_tlb_mm(mm) flush_tlb_all()
> -#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all()
> -#endif /* !CONFIG_SMP || !CONFIG_MMU */
> -
>  /* Flush a range of kernel pages */
>  static inline void flush_tlb_kernel_range(unsigned long start,
>  	unsigned long end)
>  {
> -	flush_tlb_all();
> +	local_flush_tlb_all();
>  }
>  
> +#define flush_tlb_mm(mm) flush_tlb_all()
> +#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all()
> +#endif /* !CONFIG_SMP || !CONFIG_MMU */
> +
>  #endif /* _ASM_RISCV_TLBFLUSH_H */
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 8017d2130e27..96aeacb269d5 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -117,18 +117,27 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
>  			      unsigned long size, unsigned long stride)
>  {
>  	struct flush_tlb_range_data ftd;
> -	struct cpumask *cmask = mm_cpumask(mm);
> -	unsigned int cpuid;
> +	struct cpumask *cmask, full_cmask;
>  	bool broadcast;
>  
> -	if (cpumask_empty(cmask))
> -		return;
> +	if (mm) {
> +		unsigned int cpuid;
> +
> +		cmask = mm_cpumask(mm);
> +		if (cpumask_empty(cmask))
> +			return;
> +
> +		cpuid = get_cpu();
> +		/* check if the tlbflush needs to be sent to other CPUs */
> +		broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
> +	} else {
> +		cpumask_setall(&full_cmask);
> +		cmask = &full_cmask;
> +		broadcast = true;
> +	}
>  
> -	cpuid = get_cpu();
> -	/* check if the tlbflush needs to be sent to other CPUs */
> -	broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
>  	if (static_branch_unlikely(&use_asid_allocator)) {
> -		unsigned long asid = atomic_long_read(&mm->context.id) & asid_mask;
> +		unsigned long asid = mm ? atomic_long_read(&mm->context.id) & asid_mask : 0;
>  
>  		if (broadcast) {
>  			if (riscv_use_ipi_for_rfence()) {
> @@ -162,7 +171,8 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
>  		}
>  	}
>  
> -	put_cpu();
> +	if (mm)
> +		put_cpu();
>  }
>  
>  void flush_tlb_mm(struct mm_struct *mm)
> @@ -194,6 +204,13 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  	__flush_tlb_range(vma->vm_mm,
>  			  start, end - start, 1 << stride_shift);
>  }
> +
> +void flush_tlb_kernel_range(unsigned long start,
> +			    unsigned long end)

No need to wrap this line.

> +{
> +	__flush_tlb_range(NULL, start, end, PAGE_SIZE);
> +}
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  			unsigned long end)
> -- 
> 2.39.2
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
