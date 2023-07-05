Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B43C747B1E
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jul 2023 03:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjGEBkX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jul 2023 21:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGEBkX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2023 21:40:23 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 644E3DD;
        Tue,  4 Jul 2023 18:40:15 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Dxg_D9yaRkhS4AAA--.936S3;
        Wed, 05 Jul 2023 09:40:13 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxriP6yaRkBM0bAA--.44417S3;
        Wed, 05 Jul 2023 09:40:10 +0800 (CST)
Message-ID: <26e355dd-049c-fa82-dc5d-565b86339253@loongson.cn>
Date:   Wed, 5 Jul 2023 09:40:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [01/12] efi: Do not include <linux/screen_info.h> from EFI header
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de,
        deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc:     linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-arch@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-staging@lists.linux.dev,
        Russell King <linux@armlinux.org.uk>,
        linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20230629121952.10559-2-tzimmermann@suse.de>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
In-Reply-To: <20230629121952.10559-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxriP6yaRkBM0bAA--.44417S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxGF1DKFy5Wr47KF13Gw1ktFc_yoWrGF1rpa
        1DCF4xAw4DGF4rGas5uw17uF1DXws8Gr9FgF9F9r10y347tr1vqrs5urnIkr1DXFWUKw10
        gFy5tw1Yka4DXwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUd529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUmCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Gr1j6F4UJwAaw2AFwI0_Jw0_GFyle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
        xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
        Jw0_WrylYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64
        vIr41lFIxGxcIEc7CjxVCFY4xvr7I5Mxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
        wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxV
        AFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
        zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar
        1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
        CwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
        BIdaVFxhVjvjDU0xZFpf9x07joNtxUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Thomas


I love your patch, LoongArch also have UEFI GOP support,

Maybe the arch/loongarch/kernel/efi.c don't include the '#include 
<linux/screen_info.h>' explicitly.


```

diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
index 3d448fef3af4..04f4d217aefb 100644
--- a/arch/loongarch/kernel/efi.c
+++ b/arch/loongarch/kernel/efi.c
@@ -19,6 +19,7 @@
  #include <linux/memblock.h>
  #include <linux/reboot.h>
  #include <linux/uaccess.h>
+#include <linux/screen_info.h>

  #include <asm/early_ioremap.h>
  #include <asm/efi.h>
```


On 2023/6/29 19:45, Thomas Zimmermann wrote:
> The header file <linux/efi.h> does not need anything from
> <linux/screen_info.h>. Declare struct screen_info and remove
> the include statements. Update a number of source files that
> require struct screen_info's definition.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

With the above issue solved, please take my R-B if you would like.


Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>

> ---
>   arch/arm/kernel/efi.c                         | 2 ++
>   arch/arm64/kernel/efi.c                       | 1 +
>   drivers/firmware/efi/libstub/efi-stub-entry.c | 2 ++
>   drivers/firmware/efi/libstub/screen_info.c    | 2 ++
>   include/linux/efi.h                           | 3 ++-
>   5 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/kernel/efi.c b/arch/arm/kernel/efi.c
> index e2b9d2618c672..e94655ef16bb3 100644
> --- a/arch/arm/kernel/efi.c
> +++ b/arch/arm/kernel/efi.c
> @@ -5,6 +5,8 @@
>   
>   #include <linux/efi.h>
>   #include <linux/memblock.h>
> +#include <linux/screen_info.h>
> +
>   #include <asm/efi.h>
>   #include <asm/mach/map.h>
>   #include <asm/mmu_context.h>
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index baab8dd3ead3c..3afbe503b066f 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -9,6 +9,7 @@
>   
>   #include <linux/efi.h>
>   #include <linux/init.h>
> +#include <linux/screen_info.h>
>   
>   #include <asm/efi.h>
>   #include <asm/stacktrace.h>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-entry.c b/drivers/firmware/efi/libstub/efi-stub-entry.c
> index cc4dcaea67fa6..2f1902e5d4075 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-entry.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-entry.c
> @@ -1,6 +1,8 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   
>   #include <linux/efi.h>
> +#include <linux/screen_info.h>
> +
>   #include <asm/efi.h>
>   
>   #include "efistub.h"
> diff --git a/drivers/firmware/efi/libstub/screen_info.c b/drivers/firmware/efi/libstub/screen_info.c
> index 4be1c4d1f922b..a51ec201ca3cb 100644
> --- a/drivers/firmware/efi/libstub/screen_info.c
> +++ b/drivers/firmware/efi/libstub/screen_info.c
> @@ -1,6 +1,8 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
>   #include <linux/efi.h>
> +#include <linux/screen_info.h>
> +
>   #include <asm/efi.h>
>   
>   #include "efistub.h"
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 571d1a6e1b744..360895a5572c0 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -24,10 +24,11 @@
>   #include <linux/range.h>
>   #include <linux/reboot.h>
>   #include <linux/uuid.h>
> -#include <linux/screen_info.h>
>   
>   #include <asm/page.h>
>   
> +struct screen_info;
> +
>   #define EFI_SUCCESS		0
>   #define EFI_LOAD_ERROR		( 1 | (1UL << (BITS_PER_LONG-1)))
>   #define EFI_INVALID_PARAMETER	( 2 | (1UL << (BITS_PER_LONG-1)))

