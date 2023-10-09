Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986B87BE8B8
	for <lists+linux-arch@lfdr.de>; Mon,  9 Oct 2023 19:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345624AbjJIRxf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Oct 2023 13:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbjJIRxe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Oct 2023 13:53:34 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5229D
        for <linux-arch@vger.kernel.org>; Mon,  9 Oct 2023 10:53:31 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-777252c397cso5117485a.1
        for <linux-arch@vger.kernel.org>; Mon, 09 Oct 2023 10:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1696874010; x=1697478810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IoyXQp0nB/IWm6dvckPcOr8vbJO99u9ZUrMCMrf5qWM=;
        b=XxDesE0pMy1h4OblGmF9MMUOwZYdCFHNb4KAAR56hGOuqVYQc4pKkJWF37JUpKlI7V
         nBUbXd4Ct3PiZl9RI83vfbjnOb8Qf285XkaKyNwk0lsOloRhFEejqDNK7CGHyoEMsKw5
         +sTekenXDJsjQifkatll6qhJITYNFfi+cwljCPEXFn5FK7gaOETJGwPM80W0aamwjCqC
         8wuAzE/lpb8ZmksO5k0WbDumNd9PVG3cSbLwAwxj7atewsqreq9ON0qsSP3vzW7dxmWt
         vNQW0upgpQoP5RhCw6qQlBib70H6G6ykIyMF9sK5gFhp70E6WXe+mcXAqr6cHQudsSUV
         OgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696874010; x=1697478810;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IoyXQp0nB/IWm6dvckPcOr8vbJO99u9ZUrMCMrf5qWM=;
        b=TuQLsTxRv38EwsLqFUrqI2Skr4cKh9q+BmLRXbUoA6TL76l5QfFypW6Mj6a16BFjNT
         C8wOPiDoknEXgYk5uoMbOOvix2hS5nrCfgsSv8Ay1N4N2JOkhwpVR12scBTE87lGUVX2
         9U0eTiBOeRPbZccS4w5qsW/yY2cgjwt+7ptMOLI4ovwArMAX74edfN2/yPTas+2ooNFy
         bPswNi6fdCoDz+ucQ/k5c9I6Pmb1VvW1iHnsgHkiTibnNyw0ujqPM6jWjLKHFto86g6f
         2BPJmc6jmMF87txPfGFn7odkGi0maodVnLyfDsTVJ/O/XEHJnuTsbTOQ7OM55o0sT4Cs
         eh0g==
X-Gm-Message-State: AOJu0YyhCVWhM24tmvVqrT00KZYNQv48YR5RH+n2npEMspAqAsXUl2/r
        ftoH4qP6tI9W7eiJU/2j3pK/ig==
X-Google-Smtp-Source: AGHT+IE1Qk4KpxGExPbP+Bwm/XXhpMnfLUgfDaerG1rDq19vZJtPM/OZ16TFeKYeE6po2KeQFV7LTw==
X-Received: by 2002:a05:620a:16c9:b0:76f:f11:7d1 with SMTP id a9-20020a05620a16c900b0076f0f1107d1mr14894821qkn.77.1696874010272;
        Mon, 09 Oct 2023 10:53:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:2000:b002:41c4:1832:a984:34e2? ([2600:1700:2000:b002:41c4:1832:a984:34e2])
        by smtp.gmail.com with ESMTPSA id f10-20020a05620a15aa00b007659935ce64sm3681308qkk.71.2023.10.09.10.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 10:53:29 -0700 (PDT)
Message-ID: <2047b2c2-bf37-4c02-9297-d89f95863ed5@sifive.com>
Date:   Mon, 9 Oct 2023 12:53:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] riscv: Improve flush_tlb()
Content-Language: en-US
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
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
References: <20230911131224.61924-1-alexghiti@rivosinc.com>
 <20230911131224.61924-2-alexghiti@rivosinc.com>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20230911131224.61924-2-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2023-09-11 8:12 AM, Alexandre Ghiti wrote:
> For now, flush_tlb() simply calls flush_tlb_mm() which results in a

s/flush_tlb/tlb_flush/ here and in the subject.

Otherwise:
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>

> flush of the whole TLB. So let's use mmu_gather fields to provide a more
> fine-grained flush of the TLB.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/include/asm/tlb.h      | 8 +++++++-
>  arch/riscv/include/asm/tlbflush.h | 3 +++
>  arch/riscv/mm/tlbflush.c          | 7 +++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
> index 120bcf2ed8a8..1eb5682b2af6 100644
> --- a/arch/riscv/include/asm/tlb.h
> +++ b/arch/riscv/include/asm/tlb.h
> @@ -15,7 +15,13 @@ static void tlb_flush(struct mmu_gather *tlb);
>  
>  static inline void tlb_flush(struct mmu_gather *tlb)
>  {
> -	flush_tlb_mm(tlb->mm);
> +#ifdef CONFIG_MMU
> +	if (tlb->fullmm || tlb->need_flush_all)
> +		flush_tlb_mm(tlb->mm);
> +	else
> +		flush_tlb_mm_range(tlb->mm, tlb->start, tlb->end,
> +				   tlb_get_unmap_size(tlb));
> +#endif
>  }
>  
>  #endif /* _ASM_RISCV_TLB_H */
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
> index a09196f8de68..f5c4fb0ae642 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -32,6 +32,8 @@ static inline void local_flush_tlb_page(unsigned long addr)
>  #if defined(CONFIG_SMP) && defined(CONFIG_MMU)
>  void flush_tlb_all(void);
>  void flush_tlb_mm(struct mm_struct *mm);
> +void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
> +			unsigned long end, unsigned int page_size);
>  void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
>  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  		     unsigned long end);
> @@ -52,6 +54,7 @@ static inline void flush_tlb_range(struct vm_area_struct *vma,
>  }
>  
>  #define flush_tlb_mm(mm) flush_tlb_all()
> +#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all()
>  #endif /* !CONFIG_SMP || !CONFIG_MMU */
>  
>  /* Flush a range of kernel pages */
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 77be59aadc73..fa03289853d8 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -132,6 +132,13 @@ void flush_tlb_mm(struct mm_struct *mm)
>  	__flush_tlb_range(mm, 0, -1, PAGE_SIZE);
>  }
>  
> +void flush_tlb_mm_range(struct mm_struct *mm,
> +			unsigned long start, unsigned long end,
> +			unsigned int page_size)
> +{
> +	__flush_tlb_range(mm, start, end - start, page_size);
> +}
> +
>  void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
>  {
>  	__flush_tlb_range(vma->vm_mm, addr, PAGE_SIZE, PAGE_SIZE);

