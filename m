Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35845602CF5
	for <lists+linux-arch@lfdr.de>; Tue, 18 Oct 2022 15:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiJRN3L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Oct 2022 09:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiJRN3F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Oct 2022 09:29:05 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102E7719BC
        for <linux-arch@vger.kernel.org>; Tue, 18 Oct 2022 06:29:04 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n12so23433746wrp.10
        for <linux-arch@vger.kernel.org>; Tue, 18 Oct 2022 06:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wcJzlEsI0Q0Zkw3UiSk1AeQ+ZeMU0Uy0FowbXkpqvqY=;
        b=eEqeweMgoAha2gA3agmhPrwheBhBw4LuItboa3KIkd3futKzMLro4OSFn/+GsHoO2q
         1g0UsVLbq6G7LYgkvrjjF0/aK9i1HtM2ftwQjwVtT+HxYmYOQu0iXWkYvn5R2pCAGqs4
         s9cqF+SV17FECoYNEG3BbIsBfCDRYocVPcCDrmyfVwRyAV9hx0spYE9DLW1VgzgBS4tr
         UbQ3nKR9UHhV4a0DtNBqTW1c7Zei2Dx2gjoyD+xI5pcx7YWlyHGRsdGlvYb4iC3lrx8I
         5fNhFiugt5kE/2K8pSWMOmRr7GxD0aGVofbLzCMH3mgH/+99nu8B3Ir/+6nZinH/MMQ3
         hyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wcJzlEsI0Q0Zkw3UiSk1AeQ+ZeMU0Uy0FowbXkpqvqY=;
        b=WIGlJMSylkc6OWYHfayZ/6EpnpaAyfatVYGmIQkfGPJfXB262Wq8nSH+ZHF4ZRroZm
         3o3D4Jw9MGEz578FhInJo1gSl2vBg/0QTwG46xKJTOBh6K532shxdKeNE6ViDUZwZN61
         AP5ScWsO8XO0M+KeADOmd50fC6YQb65RwHnuXTSVPSo/9/j87XpfmfA4+yS2yjLGzEEm
         GXheJIVlzWHCqSb/G8dhJMNHrMKst7lYYDdObNR78irSWlFYsaUGpeTN+iJuomkiXS/8
         OpJuq9+mD2/I8UBUuIyWx3w25/4xBX0I1POAGlTA9KKvJbNVZEo2irfWuz4XWM49ho43
         R27g==
X-Gm-Message-State: ACrzQf2gWLleFAmsZ36BgU4QE3kxM59Vu4RAePVWA99CWp4CYNSY+lrd
        6j9sKIEcS3eFjh8+mBWhxK9Ipw==
X-Google-Smtp-Source: AMsMyM51yRiBRyVMbbU7I9haBznkPLb7xvkfhQYeXVron/xlOZ8CJeyh1CIWGi75RgG0LYv0FAdxow==
X-Received: by 2002:a05:6000:1190:b0:232:c73d:7524 with SMTP id g16-20020a056000119000b00232c73d7524mr1991986wrx.371.1666099742541;
        Tue, 18 Oct 2022 06:29:02 -0700 (PDT)
Received: from [192.168.1.115] ([185.126.107.38])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c089300b003c409244bb0sm12880231wmp.6.2022.10.18.06.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 06:29:01 -0700 (PDT)
Message-ID: <95a0537f-27b2-adc9-d44e-527281326b0d@linaro.org>
Date:   Tue, 18 Oct 2022 15:28:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH V11 1/4] MIPS&LoongArch&NIOS2: Adjust prototypes of
 p?d_init()
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Feiyang Chen <chenfeiyang@loongson.cn>
References: <20221017024027.2389370-1-chenhuacai@loongson.cn>
 <20221017024027.2389370-2-chenhuacai@loongson.cn>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20221017024027.2389370-2-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 17/10/22 04:40, Huacai Chen wrote:
> From: Feiyang Chen <chenfeiyang@loongson.cn>
> 
> We are preparing to add sparse vmemmap support to LoongArch. MIPS and
> LoongArch need to call pgd_init()/pud_init()/pmd_init() when populating
> page tables, so adjust their prototypes to make generic helpers can call
> them.
> 
> NIOS2 declares pmd_init() but doesn't use, just remove it to avoid build
> errors.
> 
> Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/include/asm/pgalloc.h | 13 ++-----------
>   arch/loongarch/include/asm/pgtable.h |  8 ++++----
>   arch/loongarch/kernel/numa.c         |  4 ++--
>   arch/loongarch/mm/pgtable.c          | 23 +++++++++++++----------
>   arch/mips/include/asm/pgalloc.h      | 10 +++++-----
>   arch/mips/include/asm/pgtable-64.h   |  8 ++++----
>   arch/mips/kvm/mmu.c                  |  3 +--
>   arch/mips/mm/pgtable-32.c            | 10 +++++-----
>   arch/mips/mm/pgtable-64.c            | 18 ++++++++++--------
>   arch/mips/mm/pgtable.c               |  2 +-
>   arch/nios2/include/asm/pgalloc.h     |  5 -----
>   11 files changed, 47 insertions(+), 57 deletions(-)

> diff --git a/arch/mips/mm/pgtable-32.c b/arch/mips/mm/pgtable-32.c
> index 61891af25019..88819a21d97e 100644
> --- a/arch/mips/mm/pgtable-32.c
> +++ b/arch/mips/mm/pgtable-32.c
> @@ -13,9 +13,9 @@
>   #include <asm/pgalloc.h>
>   #include <asm/tlbflush.h>
>   
> -void pgd_init(unsigned long page)
> +void pgd_init(void *addr)
>   {
> -	unsigned long *p = (unsigned long *) page;
> +	unsigned long *p = (unsigned long *)addr;
>   	int i;
>   
>   	for (i = 0; i < USER_PTRS_PER_PGD; i+=8) {
> @@ -61,9 +61,9 @@ void __init pagetable_init(void)
>   #endif
>   
>   	/* Initialize the entire pgd.  */
> -	pgd_init((unsigned long)swapper_pg_dir);
> -	pgd_init((unsigned long)swapper_pg_dir
> -		 + sizeof(pgd_t) * USER_PTRS_PER_PGD);
> +	pgd_init(swapper_pg_dir);
> +	pgd_init((void *)((unsigned long)swapper_pg_dir
> +		 + sizeof(pgd_t) * USER_PTRS_PER_PGD));

Pre-existing, but why not use:

         pgd_init(&swapper_pg_dir[USER_PTRS_PER_PGD]);

?

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
