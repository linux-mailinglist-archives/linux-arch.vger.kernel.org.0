Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8824E6AAE58
	for <lists+linux-arch@lfdr.de>; Sun,  5 Mar 2023 06:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjCEFx3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Mar 2023 00:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEFx2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 00:53:28 -0500
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3527814E82;
        Sat,  4 Mar 2023 21:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1677995603; bh=ru9CFu4osSLUM/PSNshnk6mPmLOfwqKnocmDx/wnhi0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=V5nrTBOB8Hb5ZA2SK2gLNursyCkiyOvf+dsfE9n5mWzNm65hJiz/SQD8/gRt8Dfw6
         x/2L8cwzlFB18vZysaaa0bmaAvu0X1pV/gkaP8uu6q6pHyEhHzCUkCc5x1xa3b8hb2
         t9I1FnA8TVddZsfNxMZRmpJSR0HQE0/Uqy+IOzA4=
Received: from [192.168.9.172] (unknown [114.93.192.93])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 0DE53600F8;
        Sun,  5 Mar 2023 13:53:23 +0800 (CST)
Message-ID: <48f508aa-ab40-7032-a68d-90d8986afb2f@xen0n.name>
Date:   Sun, 5 Mar 2023 13:53:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] LoongArch: Provide kernel fpu functions
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
References: <20230305052818.4030447-1-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20230305052818.4030447-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/5/23 13:28, Huacai Chen wrote:
> Provide kernel_fpu_begin()/kernel_fpu_end() to let the kernel use fpu
> itself. They can be used by AMDGPU graphic driver for DCN.

Grammar nit: "itself" is wrongly placed. "allow the kernel itself to use 
FPU" could be better.

Also the expected usage is way broader than a single driver's single 
component. It's useful for a wide array of operations that will benefit 
from SIMD acceleration support that'll hopefully appear later. For now 
I'd suggest at least adding a single "e.g." after "used by" to signify 
this, if you're not rewording the sentence.

>
> Reported-by: Xuerui Wang <kernel@xen0n.name>
Thanks, but I prefer my name spelled in the native word order ;-)
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
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
Could be a conditional WARN_ON_ONCE like in arch/x86?
> +
> +	preempt_disable();
> +	this_cpu_write(in_kernel_fpu, true);
> +
> +	if (!is_fpu_owner())
> +		enable_fpu();
> +	else
> +		_save_fp(&current->thread.fpu);
> +}
> +EXPORT_SYMBOL_GPL(kernel_fpu_begin);

Might be good to provide some explanation in the commit message as to 
why the pair of helpers should be GPL-only. Do they touch state buried 
deep enough to make any downstream user a "derivative work"? Or are the 
annotation inspired by arch/x86?

I think this kinda needs more thought, because similar operations like 
arm's kernel_neon_{begin,end}, powerpc's enable_kernel_{fp,vsx,altivec} 
or s390's __kernel_fpu_{begin,end} are not made GPL-only. Making these 
helpers GPL-only precludes any non-GPL module to make use of SIMD on 
LoongArch, which may or may not be what you want. This can have 
commercial consequences so I can only leave the decision to you. 
(Although IMO the semantics are encapsulated and high-level enough to 
not warrant GPL-only marks, but it may well be the case that you have 
thought of something else but didn't mention here.)

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
> +EXPORT_SYMBOL_GPL(kernel_fpu_end);

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

