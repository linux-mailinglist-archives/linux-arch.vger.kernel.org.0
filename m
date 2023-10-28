Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBCC7DA8FA
	for <lists+linux-arch@lfdr.de>; Sat, 28 Oct 2023 21:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjJ1Tm1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Oct 2023 15:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1Tm0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 28 Oct 2023 15:42:26 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E91ED
        for <linux-arch@vger.kernel.org>; Sat, 28 Oct 2023 12:42:22 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-6707401e22eso6474906d6.2
        for <linux-arch@vger.kernel.org>; Sat, 28 Oct 2023 12:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698522141; x=1699126941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qq6x4Nq7vuXjfz7tKTCkE6tm57DtbpxomcSKCh+LPx0=;
        b=JcqMxQRQ8YIOi+Rzn6HDLik/suyzEhoSbiu8bGyrvZAPeASXFOXN+IpuTTyygV1/Fc
         kfNEwkJuWW0v67TGqYMm7FLM5IGJy25SNA+NjnpemG4kZe6Vx8PWmXWpIiR47TRJcVPg
         6PZbC9gMc3dVeYnbNw9n2xTbzYM5Wq2kyE1qZL6MQLxMuZu43+UuNmRdCS09/ldV2J5A
         OP5O7ZjRI9AP4CT5dKC+gJl9xVPv4VRxMHSYjsUQw7U6Cm7ytFoh3vID1jya4rj8SPZ+
         qg3ywwZ+4vYVAMRg1u2VXttGuyoENYYLsEn1D8WKK/ptfqYqRlvTFN7AgMYc2WZV5gH7
         PRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698522141; x=1699126941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qq6x4Nq7vuXjfz7tKTCkE6tm57DtbpxomcSKCh+LPx0=;
        b=uSXEJUEYiGWTBqM+w2ySVzT2pH7btlctH1sdBztW7Vi31y7kADqtaHokMUGHcDEC/I
         +a3zwvevUzcQAYqVYjYgJbeYJkpXErgwbiVm3UEXIejXLlRejbNNtpzRXLWa12PTkGbj
         p1PgwGaAIXgKO+kr76BQPFFcXs9npL2Q6tFC03FShtI0qxq5wB8pRrFZXdI4/7Qsez9n
         dGP6KiyUdgd87bf0NHFBIajSGKSU5ognM9Sf+Bqs6lD7tdvEFQmhU79KGN7pEzQxPuxa
         yQgaZ8H7uosjvwOy6BU4stBqCNy7m+rU1P4Eh627u8TiPYJx0Jl/3das/M3B1sdOYrhs
         DjSQ==
X-Gm-Message-State: AOJu0YyQr0eA0P9UFMZCNzz4CAHnVljmbhkGhGHX2/Lper7/fhYvtpRr
        EMYifRmbFRm654jE3dstdRGNfQ==
X-Google-Smtp-Source: AGHT+IG8lUSEc0ZqGXmBwx7uoR3D0JZCF8vHTRrCrxH1Pssc53OXRuD5E/+biagdI12WjtsL+f8OvQ==
X-Received: by 2002:ad4:4ee3:0:b0:66d:49aa:6844 with SMTP id dv3-20020ad44ee3000000b0066d49aa6844mr9472629qvb.19.1698522141362;
        Sat, 28 Oct 2023 12:42:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:2000:b002:c988:e7b9:36ab:57c6? ([2600:1700:2000:b002:c988:e7b9:36ab:57c6])
        by smtp.gmail.com with ESMTPSA id l4-20020a056214104400b0065afe284b3csm1853091qvr.125.2023.10.28.12.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Oct 2023 12:42:20 -0700 (PDT)
Message-ID: <65d7ea77-35fa-4aa2-9431-8f7f218cae57@sifive.com>
Date:   Sat, 28 Oct 2023 14:42:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] riscv: Improve flush_tlb_kernel_range()
Content-Language: en-US
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Will Deacon <will@kernel.org>,
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
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
References: <20231019140151.21629-1-alexghiti@rivosinc.com>
 <20231019140151.21629-5-alexghiti@rivosinc.com>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20231019140151.21629-5-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2023-10-19 9:01 AM, Alexandre Ghiti wrote:
> This function used to simply flush the whole tlb of all harts, be more
> subtile and try to only flush the range.
> 
> The problem is that we can only use PAGE_SIZE as stride since we don't know
> the size of the underlying mapping and then this function will be improved
> only if the size of the region to flush is < threshold * PAGE_SIZE.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # On RZ/Five SMARC
> ---
>  arch/riscv/include/asm/tlbflush.h | 11 ++++++-----
>  arch/riscv/mm/tlbflush.c          | 33 ++++++++++++++++++++++---------
>  2 files changed, 30 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
> index 170a49c531c6..8f3418c5f172 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -40,6 +40,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>  void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
>  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  		     unsigned long end);
> +void flush_tlb_kernel_range(unsigned long start, unsigned long end);
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
>  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
> @@ -56,15 +57,15 @@ static inline void flush_tlb_range(struct vm_area_struct *vma,
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
> index c27ba720e35f..7e182f2bc0ab 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -97,19 +97,27 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
>  			      unsigned long size, unsigned long stride)
>  {
>  	struct flush_tlb_range_data ftd;
> -	struct cpumask *cmask = mm_cpumask(mm);
> +	struct cpumask *cmask, full_cmask;
>  	unsigned long asid = FLUSH_TLB_NO_ASID;
> -	unsigned int cpuid;
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
>  
> -	cpuid = get_cpu();
> -	/* check if the tlbflush needs to be sent to other CPUs */
> -	broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
> +		cpuid = get_cpu();
> +		/* check if the tlbflush needs to be sent to other CPUs */
> +		broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
> +	} else {
> +		cpumask_setall(&full_cmask);
> +		cmask = &full_cmask;
> +		broadcast = true;

on_each_cpu_mask() only considers CPUs in cpu_online_mask anyway, so you can
more efficiently use:

  cmask = cpu_online_mask;

here (after making cmask const).

> +	}
>  
> -	if (static_branch_unlikely(&use_asid_allocator))
> +	if (static_branch_unlikely(&use_asid_allocator) && mm)
>  		asid = atomic_long_read(&mm->context.id) & asid_mask;

Instead of adding another check, please move this inside "if (mm)" above. Those
are both non-functional changes, so:

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Tested-by: Samuel Holland <samuel.holland@sifive.com>

>  
>  	if (broadcast) {
> @@ -128,7 +136,8 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
>  		local_flush_tlb_range_asid(start, size, stride, asid);
>  	}
>  
> -	put_cpu();
> +	if (mm)
> +		put_cpu();
>  }
>  
>  void flush_tlb_mm(struct mm_struct *mm)
> @@ -181,6 +190,12 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  
>  	__flush_tlb_range(vma->vm_mm, start, end - start, stride_size);
>  }
> +
> +void flush_tlb_kernel_range(unsigned long start, unsigned long end)
> +{
> +	__flush_tlb_range(NULL, start, end - start, PAGE_SIZE);
> +}
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  			unsigned long end)

