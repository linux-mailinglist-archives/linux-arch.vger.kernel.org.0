Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C69755EF8
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jul 2023 11:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjGQJHV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jul 2023 05:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGQJHU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Jul 2023 05:07:20 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE201E55;
        Mon, 17 Jul 2023 02:07:18 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9DA961C0012;
        Mon, 17 Jul 2023 09:07:13 +0000 (UTC)
Message-ID: <bb296a8e-4f84-f45d-8f46-5acfa73022d9@ghiti.fr>
Date:   Mon, 17 Jul 2023 11:07:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] riscv: Add HAVE_IOREMAP_PROT support
To:     guoren@kernel.org, palmer@rivosinc.com, paul.walmsley@sifive.com,
        falcon@tinylab.org, bjorn@kernel.org, conor.dooley@microchip.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
References: <20230716152033.3713581-1-guoren@kernel.org>
Content-Language: en-US
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230716152033.3713581-1-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Guo,

On 16/07/2023 17:20, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Add pte_pgprot macro, then riscv could have HAVE_IOREMAP_PROT,
> which will enable generic_access_phys() code, it is useful for
> debug, eg, gdb.


I don't understand, we already have the generic ioremap_prot() 
implementation since we select GENERIC_IOREMAP: shouldn't 
HAVE_IOREMAP_PROT imply that we have our own implementation?

Thanks,

Alex


> Because generic_access_phys() would call ioremap_prot()->
> pgprot_nx() to disable excutable attribute, add definition
> of pgprot_nx() for riscv.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>   .../features/vm/ioremap_prot/arch-support.txt     |  2 +-
>   arch/riscv/Kconfig                                |  1 +
>   arch/riscv/include/asm/pgtable.h                  | 15 +++++++++++++++
>   3 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/features/vm/ioremap_prot/arch-support.txt b/Documentation/features/vm/ioremap_prot/arch-support.txt
> index a24149e59d73..ea8c8a361455 100644
> --- a/Documentation/features/vm/ioremap_prot/arch-support.txt
> +++ b/Documentation/features/vm/ioremap_prot/arch-support.txt
> @@ -21,7 +21,7 @@
>       |    openrisc: | TODO |
>       |      parisc: | TODO |
>       |     powerpc: |  ok  |
> -    |       riscv: | TODO |
> +    |       riscv: |  ok  |
>       |        s390: |  ok  |
>       |          sh: |  ok  |
>       |       sparc: | TODO |
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 4c07b9189c86..15900fa20797 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -117,6 +117,7 @@ config RISCV
>   	select HAVE_FUNCTION_ERROR_INJECTION
>   	select HAVE_GCC_PLUGINS
>   	select HAVE_GENERIC_VDSO if MMU && 64BIT
> +	select HAVE_IOREMAP_PROT
>   	select HAVE_IRQ_TIME_ACCOUNTING
>   	select HAVE_KPROBES if !XIP_KERNEL
>   	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 75970ee2bda2..c9552a161f90 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -415,6 +415,11 @@ static inline pte_t pte_mkhuge(pte_t pte)
>   	return pte;
>   }
>   
> +static inline pgprot_t pte_pgprot(pte_t pte)
> +{
> +	return __pgprot(pte_val(pte) & ~_PAGE_PFN_MASK);
> +}
> +
>   #ifdef CONFIG_NUMA_BALANCING
>   /*
>    * See the comment in include/asm-generic/pgtable.h
> @@ -573,6 +578,16 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>   	return ptep_test_and_clear_young(vma, address, ptep);
>   }
>   
> +#define pgprot_nx pgprot_nx
> +static inline pgprot_t pgprot_nx(pgprot_t _prot)
> +{
> +	unsigned long prot = pgprot_val(_prot);
> +
> +	prot &= ~_PAGE_EXEC;
> +
> +	return __pgprot(prot);
> +}
> +
>   #define pgprot_noncached pgprot_noncached
>   static inline pgprot_t pgprot_noncached(pgprot_t _prot)
>   {
