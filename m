Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3058A7DA8BD
	for <lists+linux-arch@lfdr.de>; Sat, 28 Oct 2023 20:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjJ1Swr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Oct 2023 14:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJ1Swq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 28 Oct 2023 14:52:46 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8828F2
        for <linux-arch@vger.kernel.org>; Sat, 28 Oct 2023 11:52:43 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-670e7ae4a2eso4361006d6.1
        for <linux-arch@vger.kernel.org>; Sat, 28 Oct 2023 11:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698519163; x=1699123963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rTzbMaF9e6LFHLkvVnlr1iqkQocBR5uDxVZIr/Uj4WE=;
        b=bKiCN+XifgLo/kCsXVZ5lyU1MMBSR5PZtUh2oeq3zr3v1A31KOPcJjRPnNr1RFnWya
         UBCYDpidnkE4lxC4pEAi+LfJoldNgHoDda6NrGGRw9NLWXvQ2vu5n0lo7fzbPgeOfWAP
         JS7epE/YfcPehp1w8QFwp3bobJG0mqIt1XJGDkSndFNSqApFAdP0SkaAmXQO3GV5wNoU
         Wqu8ESb06tZ26R0lGjsup22v3l4BE++bPpq+EmqM9ul5ZSvtxtPnDRz3YsujL4VPbvPs
         oQ4wGRaKBZ827tdr9smCebiTxQu4lUv2F3zUPEADtMwji/lCH57iMNm8wEKgrtY7KUZY
         ClmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698519163; x=1699123963;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rTzbMaF9e6LFHLkvVnlr1iqkQocBR5uDxVZIr/Uj4WE=;
        b=SYxKe141fwS75ZbjMA8E2y8eArdphPoNORqX2dacPgPZqJ0iv8JuDuFQs0ytX3B+EI
         U517E3L1nGyMXhvy42Rx1qIEBasoebI9cVVezw+VcFXCjEbWJg2eecQ/3KOBW0yFIolR
         NcAfTKEeel7TBW93My8w1oD5QOyM8zsAoVbS72+Kvx1Ri72lO04hRbu/Ps8M2O6md6se
         bJkhDxxUKp+J5daTuPw5X+nEl/VPvSIC2FdXbMWbtuCeEO5g6pcjVEauzNQI9TD43K+f
         sEKCp3ibLHxL7rXEGMAlq4rc459T0jvkX7C0dl0xPQj8BfSJeaNRWo1by5N0TNHsrBbU
         PYXQ==
X-Gm-Message-State: AOJu0YznLrU8U92ZchZtHaA0AJja3ypsKCVUpfHprFOXR+HiOreYCJhj
        Jrvv6MQdeOfeXyKbFLIRNQJo0g==
X-Google-Smtp-Source: AGHT+IHRhO2f1MH3WnnbQd9fLdzhnTNzypJ89qAUGrhcvHOOFaTQVJ4ekwM34frzhsDctzrIh0CLVQ==
X-Received: by 2002:ad4:5aaf:0:b0:66d:8752:b6cf with SMTP id u15-20020ad45aaf000000b0066d8752b6cfmr5006791qvg.26.1698519163004;
        Sat, 28 Oct 2023 11:52:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:2000:b002:c988:e7b9:36ab:57c6? ([2600:1700:2000:b002:c988:e7b9:36ab:57c6])
        by smtp.gmail.com with ESMTPSA id mg22-20020a056214561600b0065b0d9b4ee7sm1820353qvb.20.2023.10.28.11.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Oct 2023 11:52:42 -0700 (PDT)
Message-ID: <e661b2ef-2a9a-44d7-bb32-6c0c8f8b6e85@sifive.com>
Date:   Sat, 28 Oct 2023 13:52:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] riscv: Improve flush_tlb_range() for hugetlb pages
Content-Language: en-US
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
References: <20231019140151.21629-1-alexghiti@rivosinc.com>
 <20231019140151.21629-3-alexghiti@rivosinc.com>
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
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20231019140151.21629-3-alexghiti@rivosinc.com>
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

On 2023-10-19 9:01 AM, Alexandre Ghiti wrote:
> flush_tlb_range() uses a fixed stride of PAGE_SIZE and in its current form,
> when a hugetlb mapping needs to be flushed, flush_tlb_range() flushes the
> whole tlb: so set a stride of the size of the hugetlb mapping in order to
> only flush the hugetlb mapping. However, if the hugepage is a NAPOT region,
> all PTEs that constitute this mapping must be invalidated, so the stride
> size must actually be the size of the PTE.
> 
> Note that THPs are directly handled by flush_pmd_tlb_range().
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/mm/tlbflush.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index fa03289853d8..5933744df91a 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -3,6 +3,7 @@
>  #include <linux/mm.h>
>  #include <linux/smp.h>
>  #include <linux/sched.h>
> +#include <linux/hugetlb.h>
>  #include <asm/sbi.h>
>  #include <asm/mmu_context.h>
>  
> @@ -147,7 +148,35 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
>  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  		     unsigned long end)
>  {
> -	__flush_tlb_range(vma->vm_mm, start, end - start, PAGE_SIZE);
> +	unsigned long stride_size;
> +
> +	if (!is_vm_hugetlb_page(vma)) {
> +		stride_size = PAGE_SIZE;
> +	} else {
> +		stride_size = huge_page_size(hstate_vma(vma));
> +
> +#ifdef CONFIG_RISCV_ISA_SVNAPOT

There is a fallback implementation of has_svnapot(), so you do not need this
preprocessor check. With that removed:

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>

> +		/*
> +		 * As stated in the privileged specification, every PTE in a
> +		 * NAPOT region must be invalidated, so reset the stride in that
> +		 * case.
> +		 */
> +		if (has_svnapot()) {
> +			if (stride_size >= PGDIR_SIZE)
> +				stride_size = PGDIR_SIZE;
> +			else if (stride_size >= P4D_SIZE)
> +				stride_size = P4D_SIZE;

As a side note, and this is probably premature optimization... PGDIR_SIZE and
P4D_SIZE check pgtable_l{4,5}_enabled. That's not really necessary here, since
we are just trying to round down, and there won't be any higher-order hugepages
if those paging levels are disabled.

> +			else if (stride_size >= PUD_SIZE)
> +				stride_size = PUD_SIZE;
> +			else if (stride_size >= PMD_SIZE)
> +				stride_size = PMD_SIZE;
> +			else
> +				stride_size = PAGE_SIZE;
> +		}
> +#endif
> +	}
> +
> +	__flush_tlb_range(vma->vm_mm, start, end - start, stride_size);
>  }
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,

