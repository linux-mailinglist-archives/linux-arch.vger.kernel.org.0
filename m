Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB747766E78
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jul 2023 15:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236641AbjG1Ne0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Jul 2023 09:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236686AbjG1NeZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Jul 2023 09:34:25 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFBB4223
        for <linux-arch@vger.kernel.org>; Fri, 28 Jul 2023 06:33:49 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so22810751fa.2
        for <linux-arch@vger.kernel.org>; Fri, 28 Jul 2023 06:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1690551157; x=1691155957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yfPWFATzg2F/vGl+Rugnp8J3pij37XeUvwzh4yvIFCk=;
        b=SjWIgG6+pK5Kii8Yby+9NO7xIGyFBTEUn4+5wU/eQ5I0TU3hGh3GWvV9Scui3YYgFS
         AKpFsMUSp/P/TYQRDsiVUHZLauCM1MHhu2AkYu24OezBCBiGfpycIhgdfy/lx01Q8ia8
         7uNmyrFh2/3iUkHZmihu706TB82aCptMxg2JYUJ2EE+zFVkcWqKyzYjYKmf6dCaSJ/KV
         ozszfhbwpEQXwR66f9qjQPwxFF6KCTPtQ1HO3Qb8lDbpMCmmmYmGSBW01NcP6jXg49vy
         tVOTwgYAsDmTDYDWHz8TMg9gRXcZJ29nzcG4/l1+BM7IBkWJdefiASqT3FJht9c0rWsr
         cLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690551157; x=1691155957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfPWFATzg2F/vGl+Rugnp8J3pij37XeUvwzh4yvIFCk=;
        b=OBNz59JGEgKfXnCNNCmP5H1r9bJAiX3EHQydGkCIAmNDy+qlTBxoptbDFCCjAvou5D
         nm9Y5tpSn/y3Y+siHc1q/D7AJmhTD3qEGKaBEbvBRr1yvqpy0g153b/rMnGEK9Skpn3Z
         eoxAoE1Gy77ido4ufYT0HF+1/0L6GQsD+qdh/tIDvzHTylK9utIs/Ys8LLb1uD3nFbna
         KvBSqJ8N56QTh800zlskcNMTt5P/Hqlb5Ia8Ewk/f2RUtqlYYQl/UdlUGbvJXEbThZ4o
         5GR8cnABJbzgjIQUORHIrEzEh6AZIMsWX7+4n+/zOScfwuFnajFY8WsKVG7VCmAFeizH
         OYiA==
X-Gm-Message-State: ABy/qLaIMz3dYDmJbfYYsodnwcotDM39z2mif4eT09dU7k8zrZx2yLHg
        uXflLMFbtic494u/OZMAy58C5w==
X-Google-Smtp-Source: APBJJlHNHIiJYvgDvTPgNH06lQmbcxMDN4FEykHkmvVCH47PAaXmVTITjQ2d4Z+FSuew7Waq+UFM2g==
X-Received: by 2002:a2e:9444:0:b0:2b9:bbf5:7c6 with SMTP id o4-20020a2e9444000000b002b9bbf507c6mr1825736ljh.43.1690551156738;
        Fri, 28 Jul 2023 06:32:36 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id h19-20020a17090634d300b0098e422d6758sm2054351ejb.219.2023.07.28.06.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 06:32:36 -0700 (PDT)
Date:   Fri, 28 Jul 2023 15:32:35 +0200
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
Subject: Re: [PATCH v2 3/4] riscv: Make __flush_tlb_range() loop over pte
 instead of flushing the whole tlb
Message-ID: <20230728-f2cd8ddd252c2ece2e438790@orel>
References: <20230727185553.980262-1-alexghiti@rivosinc.com>
 <20230727185553.980262-4-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727185553.980262-4-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 27, 2023 at 08:55:52PM +0200, Alexandre Ghiti wrote:
> Currently, when the range to flush covers more than one page (a 4K page or
> a hugepage), __flush_tlb_range() flushes the whole tlb. Flushing the whole
> tlb comes with a greater cost than flushing a single entry so we should
> flush single entries up to a certain threshold so that:
> threshold * cost of flushing a single entry < cost of flushing the whole
> tlb.
> 
> This threshold is microarchitecture dependent and can/should be
> overwritten by vendors.
> 
> Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/mm/tlbflush.c | 41 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 3e4acef1f6bc..8017d2130e27 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -24,13 +24,48 @@ static inline void local_flush_tlb_page_asid(unsigned long addr,
>  			: "memory");
>  }
>  
> +/*
> + * Flush entire TLB if number of entries to be flushed is greater
> + * than the threshold below. Platforms may override the threshold
> + * value based on marchid, mvendorid, and mimpid.
> + */
> +static unsigned long tlb_flush_all_threshold __read_mostly = 64;
> +
> +static void local_flush_tlb_range_threshold_asid(unsigned long start,
> +						 unsigned long size,
> +						 unsigned long stride,
> +						 unsigned long asid)
> +{
> +	u16 nr_ptes_in_range = DIV_ROUND_UP(size, stride);
> +	int i;
> +
> +	if (nr_ptes_in_range > tlb_flush_all_threshold) {
> +		if (asid != -1)
> +			local_flush_tlb_all_asid(asid);
> +		else
> +			local_flush_tlb_all();
> +		return;
> +	}
> +
> +	for (i = 0; i < nr_ptes_in_range; ++i) {
> +		if (asid != -1)
> +			local_flush_tlb_page_asid(start, asid);
> +		else
> +			local_flush_tlb_page(start);
> +		start += stride;
> +	}
> +}
> +
>  static inline void local_flush_tlb_range(unsigned long start,
>  		unsigned long size, unsigned long stride)
>  {
>  	if (size <= stride)
>  		local_flush_tlb_page(start);
> -	else
> +	else if (size == (unsigned long)-1)

The more we scatter this -1 around, especially now that we also need to
cast it, the more I think we should introduce a #define for it.

>  		local_flush_tlb_all();
> +	else
> +		local_flush_tlb_range_threshold_asid(start, size, stride, -1);
> +
>  }
>  
>  static inline void local_flush_tlb_range_asid(unsigned long start,
> @@ -38,8 +73,10 @@ static inline void local_flush_tlb_range_asid(unsigned long start,
>  {
>  	if (size <= stride)
>  		local_flush_tlb_page_asid(start, asid);
> -	else
> +	else if (size == (unsigned long)-1)
>  		local_flush_tlb_all_asid(asid);
> +	else
> +		local_flush_tlb_range_threshold_asid(start, size, stride, asid);
>  }
>  
>  static void __ipi_flush_tlb_all(void *info)
> -- 
> 2.39.2
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
