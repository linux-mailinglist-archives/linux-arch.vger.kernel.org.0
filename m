Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE9E747AF6
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jul 2023 03:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjGEBZR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jul 2023 21:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGEBZQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2023 21:25:16 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD0A810CF;
        Tue,  4 Jul 2023 18:25:10 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxlPB1xqRknC0AAA--.946S3;
        Wed, 05 Jul 2023 09:25:09 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxniNtxqRki8kbAA--.44387S3;
        Wed, 05 Jul 2023 09:25:01 +0800 (CST)
Message-ID: <d1c0702f-e16d-1edd-19a4-1bdc2def14ab@loongson.cn>
Date:   Wed, 5 Jul 2023 09:25:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [05/12] arch: Remove trailing whitespaces
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de,
        deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc:     linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mips@vger.kernel.org, Rich Felker <dalias@libc.org>,
        sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-hexagon@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-csky@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Zi Yan <ziy@nvidia.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        loongarch@lists.linux.dev,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        linux-alpha@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20230629121952.10559-6-tzimmermann@suse.de>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
In-Reply-To: <20230629121952.10559-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxniNtxqRki8kbAA--.44387S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWryxAr17Ww18uw15tw15WrX_yoW5Wr1UpF
        WDCw1kGryDWFsYyF1xJ348uFWSgws7tFW3uryDK34UAr90vryjvrykt3Z3A34DGrnrCFW0
        g3yrWF4jg3WrAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUjr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUQjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Gr1j6F4UJwAaw2AFwI0_GFv_Wryle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
        xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
        Wrv_ZF1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64
        vIr41lFIxGxcIEc7CjxVCFY4xvr7I5Mxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
        wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxV
        AFwI0_GFv_Wrylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
        zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w
        1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
        JVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr
        1UYxBIdaVFxhVjvjDU0xZFpf9x07bjSdkUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 2023/6/29 19:45, Thomas Zimmermann wrote:
> Fix coding style. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Arnd Bergmann <arnd@kernel.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>

> ---
>   arch/ia64/Kconfig | 4 ++--
>   arch/sh/Kconfig   | 6 +++---
>   2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> index 21fa63ce5ffc0..e79f15e32a451 100644
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -260,7 +260,7 @@ config PERMIT_BSP_REMOVE
>   	default n
>   	help
>   	Say Y here if your platform SAL will support removal of BSP with HOTPLUG_CPU
> -	support.
> +	support.
>   
>   config FORCE_CPEI_RETARGET
>   	bool "Force assumption that CPEI can be re-targeted"
> @@ -335,7 +335,7 @@ config IA64_PALINFO
>   config IA64_MC_ERR_INJECT
>   	tristate "MC error injection support"
>   	help
> -	  Adds support for MC error injection. If enabled, the kernel
> +	  Adds support for MC error injection. If enabled, the kernel
>   	  will provide a sysfs interface for user applications to
>   	  call MC error injection PAL procedures to inject various errors.
>   	  This is a useful tool for MCA testing.
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 9652d367fc377..04b9550cf0070 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -234,7 +234,7 @@ config CPU_SUBTYPE_SH7201
>   	select CPU_SH2A
>   	select CPU_HAS_FPU
>   	select SYS_SUPPORTS_SH_MTU2
> -
> +
>   config CPU_SUBTYPE_SH7203
>   	bool "Support SH7203 processor"
>   	select CPU_SH2A
> @@ -496,7 +496,7 @@ config CPU_SUBTYPE_SH7366
>   endchoice
>   
>   source "arch/sh/mm/Kconfig"
> -
> +
>   source "arch/sh/Kconfig.cpu"
>   
>   source "arch/sh/boards/Kconfig"
> @@ -647,7 +647,7 @@ config GUSA
>   	  This is the default implementation for both UP and non-ll/sc
>   	  CPUs, and is used by the libc, amongst others.
>   
> -	  For additional information, design information can be found
> +	  For additional information, design information can be found
>   	  in <http://lc.linux.or.jp/lc2002/papers/niibe0919p.pdf>.
>   
>   	  This should only be disabled for special cases where alternate

