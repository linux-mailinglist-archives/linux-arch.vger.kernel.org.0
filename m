Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E7C6ABEFC
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 13:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjCFMDf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 07:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjCFMDe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 07:03:34 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B6F91E5CD;
        Mon,  6 Mar 2023 04:03:32 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8DxWNmT1gVkA80IAA--.16689S3;
        Mon, 06 Mar 2023 20:03:31 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxyr2R1gVks5BMAA--.2932S3;
        Mon, 06 Mar 2023 20:03:29 +0800 (CST)
Message-ID: <029a5993-b993-ab73-0a14-0df9b0ddf3da@loongson.cn>
Date:   Mon, 6 Mar 2023 20:03:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH V3] LoongArch: Provide kernel fpu functions
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
References: <20230306095934.609589-1-chenhuacai@loongson.cn>
From:   maobibo <maobibo@loongson.cn>
In-Reply-To: <20230306095934.609589-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxyr2R1gVks5BMAA--.2932S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxAF1fCF1rKrWDCw4DWr1ftFb_yoW5Zry3pF
        ZIkFs5GrZ5Cr92v3sxJa4j9r98Jw4kGw1ag3W3GFyrAF4jgF1DWr4vqr9rXFyjva18K3y0
        qFn5K39xK3WDJwUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kK
        e7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280
        aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
        xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOiSdUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



在 2023/3/6 17:59, Huacai Chen 写道:
> Provide kernel_fpu_begin()/kernel_fpu_end() to allow the kernel itself
> to use fpu. They can be used by some other kernel components, e.g., the
> AMDGPU graphic driver for DCN.
Since kernel is compiled with -msoft-float, I guess hw fpu will not be
used in kernel by present:). However it is deserved to try.
> 
> Reported-by: WANG Xuerui <kernel@xen0n.name>
> Tested-by: WANG Xuerui <kernel@xen0n.name>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> V2: Use non-GPL exports and update commit messages.
> V3: Add spaces for coding style.
> 
>  arch/loongarch/include/asm/fpu.h |  3 +++
>  arch/loongarch/kernel/Makefile   |  2 +-
>  arch/loongarch/kernel/kfpu.c     | 41 ++++++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+), 1 deletion(-)
>  create mode 100644 arch/loongarch/kernel/kfpu.c
> 
> diff --git a/arch/loongarch/include/asm/fpu.h b/arch/loongarch/include/asm/fpu.h
> index 358b254d9c1d..192f8e35d912 100644
> --- a/arch/loongarch/include/asm/fpu.h
> +++ b/arch/loongarch/include/asm/fpu.h
> @@ -21,6 +21,9 @@
>  
>  struct sigcontext;
>  
> +extern void kernel_fpu_begin(void);
> +extern void kernel_fpu_end(void);
> +
>  extern void _init_fpu(unsigned int);
>  extern void _save_fp(struct loongarch_fpu *);
>  extern void _restore_fp(struct loongarch_fpu *);
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
> index 78d4e3384305..9a72d91cd104 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -13,7 +13,7 @@ obj-y		+= head.o cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
>  obj-$(CONFIG_ACPI)		+= acpi.o
>  obj-$(CONFIG_EFI) 		+= efi.o
>  
> -obj-$(CONFIG_CPU_HAS_FPU)	+= fpu.o
> +obj-$(CONFIG_CPU_HAS_FPU)	+= fpu.o kfpu.o
>  
>  obj-$(CONFIG_ARCH_STRICT_ALIGN)	+= unaligned.o
>  
> diff --git a/arch/loongarch/kernel/kfpu.c b/arch/loongarch/kernel/kfpu.c
> new file mode 100644
> index 000000000000..cd2a18fecdcc
> --- /dev/null
> +++ b/arch/loongarch/kernel/kfpu.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Loongson Technology Corporation Limited
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
> +	if (this_cpu_read(in_kernel_fpu))
> +		return;
> +
> +	preempt_disable();
> +	this_cpu_write(in_kernel_fpu, true);
> +
> +	if (!is_fpu_owner())
> +		enable_fpu();
> +	else
> +		_save_fp(&current->thread.fpu);
Do we need initialize fcsr rather than using random fcsr value
of other processes? There may be fpu exception enabled by
other tasks.

Regards
Bibo,mao
> +}
> +EXPORT_SYMBOL(kernel_fpu_begin);
> +
> +void kernel_fpu_end(void)
> +{
> +	if (!this_cpu_read(in_kernel_fpu))
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

