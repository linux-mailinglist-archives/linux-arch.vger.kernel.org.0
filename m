Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1DB52767F
	for <lists+linux-arch@lfdr.de>; Sun, 15 May 2022 11:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbiEOJHM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 May 2022 05:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiEOJHK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 May 2022 05:07:10 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D2D18350;
        Sun, 15 May 2022 02:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1652605625; bh=ZAWhqvrmFjpIY2vBRREaiKU7FGkoaZMIpR85XAtmgqU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RJNL8opaXVAjtLLkAHCHToS2cmIGjMqb9RcssbMc6FJhFNKyrnITDwQtbM0iAu7pH
         bHNi0JUeKCu2N65o2/1ZKc/cH7wGO7AYtuSGqy64oNqSpUrZpH6xLrveXXmPRmOtLZ
         nNfsqxg/aDXJegtPcjLt5jNSGeAyEAdv87zG3dls=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 1EBD260691;
        Sun, 15 May 2022 17:07:05 +0800 (CST)
Message-ID: <3982e7e7-f98e-8d8b-f13b-2bfa10a69b95@xen0n.name>
Date:   Sun, 15 May 2022 17:07:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0a1
Subject: Re: [PATCH V10 10/22] LoongArch: Add exception/interrupt handling
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-11-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220514080402.2650181-11-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 5/14/22 16:03, Huacai Chen wrote:
> Add the exception and interrupt handling machanism for basic LoongArch
> support.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/include/asm/branch.h       |  21 +
>   arch/loongarch/include/asm/bug.h          |  23 +
>   arch/loongarch/include/asm/entry-common.h |  13 +
>   arch/loongarch/include/asm/hardirq.h      |  24 +
>   arch/loongarch/include/asm/hw_irq.h       |  17 +
>   arch/loongarch/include/asm/irq.h          | 130 ++++
>   arch/loongarch/include/asm/irq_regs.h     |  27 +
>   arch/loongarch/include/asm/irqflags.h     |  78 +++
>   arch/loongarch/include/asm/kdebug.h       |  23 +
>   arch/loongarch/include/asm/stackframe.h   | 212 ++++++
>   arch/loongarch/include/asm/stacktrace.h   |  74 +++
>   arch/loongarch/include/uapi/asm/break.h   |  23 +
>   arch/loongarch/kernel/access-helper.h     |  13 +
>   arch/loongarch/kernel/genex.S             |  95 +++
>   arch/loongarch/kernel/irq.c               | 131 ++++
>   arch/loongarch/kernel/traps.c             | 755 ++++++++++++++++++++++
>   16 files changed, 1659 insertions(+)
>   create mode 100644 arch/loongarch/include/asm/branch.h
>   create mode 100644 arch/loongarch/include/asm/bug.h
>   create mode 100644 arch/loongarch/include/asm/entry-common.h
>   create mode 100644 arch/loongarch/include/asm/hardirq.h
>   create mode 100644 arch/loongarch/include/asm/hw_irq.h
>   create mode 100644 arch/loongarch/include/asm/irq.h
>   create mode 100644 arch/loongarch/include/asm/irq_regs.h
>   create mode 100644 arch/loongarch/include/asm/irqflags.h
>   create mode 100644 arch/loongarch/include/asm/kdebug.h
>   create mode 100644 arch/loongarch/include/asm/stackframe.h
>   create mode 100644 arch/loongarch/include/asm/stacktrace.h
>   create mode 100644 arch/loongarch/include/uapi/asm/break.h
>   create mode 100644 arch/loongarch/kernel/access-helper.h
>   create mode 100644 arch/loongarch/kernel/genex.S
>   create mode 100644 arch/loongarch/kernel/irq.c
>   create mode 100644 arch/loongarch/kernel/traps.c
This patch mostly looks good, except...
> (snip)
>
> +asmlinkage void cache_parity_error(void)
> +{
> +	const int field = 2 * sizeof(unsigned long);
> +	unsigned int reg_val;
> +
> +	/* For the moment, report the problem and hang. */
> +	pr_err("Cache error exception:\n");
> +	pr_err("csr_merrera == %0*llx\n", field, csr_readq(LOONGARCH_CSR_MERRERA));
> +	reg_val = csr_readl(LOONGARCH_CSR_MERRCTL);
> +	pr_err("csr_merrctl == %08x\n", reg_val);
> +
> +	pr_err("Decoded c0_cacheerr: %s cache fault in %s reference.\n",
> +	       reg_val & (1<<30) ? "secondary" : "primary",
> +	       reg_val & (1<<31) ? "data" : "insn");
> +	if (((current_cpu_data.processor_id & 0xff0000) == PRID_COMP_LOONGSON)) {
> +		pr_err("Error bits: %s%s%s%s%s%s%s%s\n",
> +			reg_val & (1<<29) ? "ED " : "",
> +			reg_val & (1<<28) ? "ET " : "",
> +			reg_val & (1<<27) ? "ES " : "",
> +			reg_val & (1<<26) ? "EE " : "",
> +			reg_val & (1<<25) ? "EB " : "",
> +			reg_val & (1<<24) ? "EI " : "",
> +			reg_val & (1<<23) ? "E1 " : "",
> +			reg_val & (1<<22) ? "E0 " : "");
> +	} else {
> +		pr_err("Error bits: %s%s%s%s%s%s%s\n",
> +			reg_val & (1<<29) ? "ED " : "",
> +			reg_val & (1<<28) ? "ET " : "",
> +			reg_val & (1<<26) ? "EE " : "",
> +			reg_val & (1<<25) ? "EB " : "",
> +			reg_val & (1<<24) ? "EI " : "",
> +			reg_val & (1<<23) ? "E1 " : "",
> +			reg_val & (1<<22) ? "E0 " : "");
> +	}
> +	pr_err("IDX: 0x%08x\n", reg_val & ((1<<22)-1));
> +
> +	panic("Can't handle the cache error!");
> +}

... this function. This implementation is completely wrong, as it's the 
same logic on MIPS, but LoongArch's MERRCTL CSR is not arranged in the 
same way. There are no individual error bits, for example.

You can simply replace this with a direct panic for now, for correctness.

With this fixed:

Reviewed-by: WANG Xuerui <git@xen0n.name>

