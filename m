Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C126AB508
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 04:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCFDVd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Mar 2023 22:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjCFDVb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 22:21:31 -0500
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699EB93F8;
        Sun,  5 Mar 2023 19:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1678072887; bh=6vjYI8Q8uw2bYGAG6a88ZZWfz7Vkjax20kWczargcZw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lHtuoGDjxxhhng8DCi0x+1gsg9uxk6urmjmVZcCiADU0jHdPj4XQoyt91aXWGLseJ
         K9fxcV3pIvAF51kmYZThsZs1l8u+R0aQvZUskpRj2XpQ4giea2TWhW5jHlFmTUs6pI
         RmEF0USwlqHyZX8ywqFvF8tJFDB8sVWsFYWUFcdU=
Received: from [100.100.57.122] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 9F52F600A6;
        Mon,  6 Mar 2023 11:21:26 +0800 (CST)
Message-ID: <95ddb5c5-57d4-4594-2712-863391f1c6c1@xen0n.name>
Date:   Mon, 6 Mar 2023 11:21:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH V2] LoongArch: Provide kernel fpu functions
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
References: <20230306031258.99230-1-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20230306031258.99230-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2023/3/6 11:12, Huacai Chen wrote:
> Provide kernel_fpu_begin()/kernel_fpu_end() to allow the kernel itself
> to use fpu. They can be used by some other kernel components, e.g., the
> AMDGPU graphic driver for DCN.

IMO my previous explanation works better, but the current wording kinda 
works for me. </grumble>

> 
> Reported-by: WANG Xuerui<kernel@xen0n.name>

One space before the opening angle bracket.

> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> V2: Use non-GPL exports and update commit messages.
> 
>   arch/loongarch/include/asm/fpu.h |  3 +++
>   arch/loongarch/kernel/Makefile   |  2 +-
>   arch/loongarch/kernel/kfpu.c     | 41 ++++++++++++++++++++++++++++++++
>   3 files changed, 45 insertions(+), 1 deletion(-)
>   create mode 100644 arch/loongarch/kernel/kfpu.c
> 
> diff --git a/arch/loongarch/include/asm/fpu.h b/arch/loongarch/include/asm/fpu.h
> index 358b254d9c1d..192f8e35d912 100644
> --- a/arch/loongarch/include/asm/fpu.h
> +++ b/arch/loongarch/include/asm/fpu.h
> @@ -21,6 +21,9 @@
>   
>   struct sigcontext;
>   
> +extern void kernel_fpu_begin(void);
> +extern void kernel_fpu_end(void);
> +
>   extern void _init_fpu(unsigned int);
>   extern void _save_fp(struct loongarch_fpu *);
>   extern void _restore_fp(struct loongarch_fpu *);
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
> index 78d4e3384305..9a72d91cd104 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -13,7 +13,7 @@ obj-y		+= head.o cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
>   obj-$(CONFIG_ACPI)		+= acpi.o
>   obj-$(CONFIG_EFI) 		+= efi.o
>   
> -obj-$(CONFIG_CPU_HAS_FPU)	+= fpu.o
> +obj-$(CONFIG_CPU_HAS_FPU)	+= fpu.o kfpu.o
>   
>   obj-$(CONFIG_ARCH_STRICT_ALIGN)	+= unaligned.o
>   
> diff --git a/arch/loongarch/kernel/kfpu.c b/arch/loongarch/kernel/kfpu.c
> new file mode 100644
> index 000000000000..cd2a18fecdcc
> --- /dev/null
> +++ b/arch/loongarch/kernel/kfpu.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2020-2023 Loongson Technology Corporation Limited

2020?

> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/init.h>
> +#include <asm/fpu.h>
> +#include <asm/smp.h>
> +
> +static DEFINE_PER_CPU(bool, in_kernel_fpu);
> +
> +void kernel_fpu_begin(void)
> +{
> +	if(this_cpu_read(in_kernel_fpu))
> +		return;

You've ignored my WARN suggestion, but I could add it later anyway so 
I'd allow this to go in as-is for now.

> +
> +	preempt_disable();
> +	this_cpu_write(in_kernel_fpu, true);
> +
> +	if (!is_fpu_owner())
> +		enable_fpu();
> +	else
> +		_save_fp(&current->thread.fpu);
> +}
> +EXPORT_SYMBOL(kernel_fpu_begin);
> +
> +void kernel_fpu_end(void)
> +{
> +	if(!this_cpu_read(in_kernel_fpu))
> +		return;
> +
> +	if (!is_fpu_owner())
> +		disable_fpu();
> +	else
> +		_restore_fp(&current->thread.fpu);
> +
> +	this_cpu_write(in_kernel_fpu, false);
> +	preempt_enable();
> +}
> +EXPORT_SYMBOL(kernel_fpu_end);

I've tested this along with the amdgpu DCN enablement, so:

Tested-by: WANG Xuerui <git@xen0n.name>

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

