Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B080780D83
	for <lists+linux-arch@lfdr.de>; Fri, 18 Aug 2023 16:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356488AbjHROGc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Aug 2023 10:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377618AbjHROGG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2023 10:06:06 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E92453C31;
        Fri, 18 Aug 2023 07:05:58 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxDOvAet9kieIZAA--.47825S3;
        Fri, 18 Aug 2023 22:05:52 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxjiN2et9ky6ddAA--.58163S3;
        Fri, 18 Aug 2023 22:04:48 +0800 (CST)
Message-ID: <924934b8-d2ca-c1ea-b357-202c2f995adc@loongson.cn>
Date:   Fri, 18 Aug 2023 22:04:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [06/12] arch: Declare screen_info in <asm/screen_info.h>
To:     Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de,
        deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc:     linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-ia64@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Rich Felker <dalias@libc.org>, Guo Ren <guoren@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-arch@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-hexagon@vger.kernel.org, linux-staging@lists.linux.dev,
        Russell King <linux@armlinux.org.uk>,
        linux-csky@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Matt Turner <mattst88@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        loongarch@lists.linux.dev,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org,
        Brian Cain <bcain@quicinc.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        linux-alpha@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>, x86@kernel.org
References: <20230629121952.10559-7-tzimmermann@suse.de>
Content-Language: en-US
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <20230629121952.10559-7-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8AxjiN2et9ky6ddAA--.58163S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj9fXoWfJr4UJFyruFW8Zr13CFyfAFc_yoW8GryUCo
        WUK3Wj9w48ArWIqr4fGws5CFW5Jryqkr4rZF4xKwsrXF1avF45tFW5Ka42y3yayry8Krn8
        CFWa9FZxJw48Grn3l-sFpf9Il3svdjkaLaAFLSUrUUUUvb8apTn2vfkv8UJUUUU8wcxFpf
        9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
        UjIYCTnIWjp_UUUOh7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI
        8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
        Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
        v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26r4UJVWxJr1ln4kS14v26rWY6Fy7M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
        kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
        6rWY6Fy7McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcV
        AKI48JM4IIrI8v6xkF7I0E4cxCY480cwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS
        14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I
        0E14v26rWY6Fy7MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
        x4CE17CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JV
        W7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
        JVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
        UvcSsGvfC2KfnxnUUI43ZEXa7IU5jjg7UUUUU==
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,


Why this patch get dropped in the end?

Since the global screen_info is an arch-specific thing,
Whenever an arch-neutral module or subsystem references the global screen_info,
There are some complaints from either compile testing robot.
Well, a programmer may handle it by using the CONFIG_SYSFB guard,
but it is not as precise as what this patch provided.

Personally, I think this patch is still valuable.
I suggest either forcing all other architectures to export screen_info,
like the X86 and IA64 arch does, after all the screen_info is a good thing.
or provide the fine-control version like this patch does.


On 2023/6/29 19:45, Thomas Zimmermann wrote:
> The variable screen_info does not exist on all architectures. Declare
> it in <asm-generic/screen_info.h>. All architectures that do declare it
> will provide it via <asm/screen_info.h>.
>
> Add the Kconfig token ARCH_HAS_SCREEN_INFO to guard against access on
> architectures that don't provide screen_info.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Brian Cain <bcain@quicinc.com>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Juerg Haefliger <juerg.haefliger@canonical.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Acked-by: WANG Xuerui <git@xen0n.name> # loongarch
> ---
>   arch/Kconfig                      |  6 ++++++
>   arch/alpha/Kconfig                |  1 +
>   arch/arm/Kconfig                  |  1 +
>   arch/arm64/Kconfig                |  1 +
>   arch/csky/Kconfig                 |  1 +
>   arch/hexagon/Kconfig              |  1 +
>   arch/ia64/Kconfig                 |  1 +
>   arch/loongarch/Kconfig            |  1 +
>   arch/mips/Kconfig                 |  1 +
>   arch/nios2/Kconfig                |  1 +
>   arch/powerpc/Kconfig              |  1 +
>   arch/riscv/Kconfig                |  1 +
>   arch/sh/Kconfig                   |  1 +
>   arch/sparc/Kconfig                |  1 +
>   arch/x86/Kconfig                  |  1 +
>   arch/xtensa/Kconfig               |  1 +
>   drivers/video/Kconfig             |  3 +++
>   include/asm-generic/Kbuild        |  1 +
>   include/asm-generic/screen_info.h | 12 ++++++++++++
>   include/linux/screen_info.h       |  2 +-
>   20 files changed, 38 insertions(+), 1 deletion(-)
>   create mode 100644 include/asm-generic/screen_info.h
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 205fd23e0cada..2f58293fd7bcb 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1466,6 +1466,12 @@ config ARCH_HAS_NONLEAF_PMD_YOUNG
>   	  address translations. Page table walkers that clear the accessed bit
>   	  may use this capability to reduce their search space.
>   
> +config ARCH_HAS_SCREEN_INFO
> +	bool
> +	help
> +	  Selected by architectures that provide a global instance of
> +	  screen_info.
> +
>   source "kernel/gcov/Kconfig"
>   
>   source "scripts/gcc-plugins/Kconfig"
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> index a5c2b1aa46b02..d749011d88b14 100644
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -4,6 +4,7 @@ config ALPHA
>   	default y
>   	select ARCH_32BIT_USTAT_F_TINODE
>   	select ARCH_HAS_CURRENT_STACK_POINTER
> +	select ARCH_HAS_SCREEN_INFO
>   	select ARCH_MIGHT_HAVE_PC_PARPORT
>   	select ARCH_MIGHT_HAVE_PC_SERIO
>   	select ARCH_NO_PREEMPT
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 0fb4b218f6658..a9d01ee67a90e 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -15,6 +15,7 @@ config ARM
>   	select ARCH_HAS_MEMBARRIER_SYNC_CORE
>   	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>   	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
> +	select ARCH_HAS_SCREEN_INFO
>   	select ARCH_HAS_SETUP_DMA_OPS
>   	select ARCH_HAS_SET_MEMORY
>   	select ARCH_STACKWALK
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 343e1e1cae10a..21addc4715bb3 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -36,6 +36,7 @@ config ARM64
>   	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>   	select ARCH_HAS_PTE_DEVMAP
>   	select ARCH_HAS_PTE_SPECIAL
> +	select ARCH_HAS_SCREEN_INFO
>   	select ARCH_HAS_SETUP_DMA_OPS
>   	select ARCH_HAS_SET_DIRECT_MAP
>   	select ARCH_HAS_SET_MEMORY
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 4df1f8c9d170b..28444e581fc1f 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -10,6 +10,7 @@ config CSKY
>   	select ARCH_USE_QUEUED_RWLOCKS
>   	select ARCH_USE_QUEUED_SPINLOCKS
>   	select ARCH_HAS_CURRENT_STACK_POINTER
> +	select ARCH_HAS_SCREEN_INFO
>   	select ARCH_INLINE_READ_LOCK if !PREEMPTION
>   	select ARCH_INLINE_READ_LOCK_BH if !PREEMPTION
>   	select ARCH_INLINE_READ_LOCK_IRQ if !PREEMPTION
> diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
> index 54eadf2651786..cc683c0a43d34 100644
> --- a/arch/hexagon/Kconfig
> +++ b/arch/hexagon/Kconfig
> @@ -5,6 +5,7 @@ comment "Linux Kernel Configuration for Hexagon"
>   config HEXAGON
>   	def_bool y
>   	select ARCH_32BIT_OFF_T
> +	select ARCH_HAS_SCREEN_INFO
>   	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>   	select ARCH_NO_PREEMPT
>   	select DMA_GLOBAL_POOL
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> index e79f15e32a451..8b1e785e6d53d 100644
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -10,6 +10,7 @@ config IA64
>   	bool
>   	select ARCH_BINFMT_ELF_EXTRA_PHDRS
>   	select ARCH_HAS_DMA_MARK_CLEAN
> +	select ARCH_HAS_SCREEN_INFO
>   	select ARCH_HAS_STRNCPY_FROM_USER
>   	select ARCH_HAS_STRNLEN_USER
>   	select ARCH_MIGHT_HAVE_PC_PARPORT
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index d38b066fc931b..6aab2fb7753da 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -13,6 +13,7 @@ config LOONGARCH
>   	select ARCH_HAS_FORTIFY_SOURCE
>   	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
>   	select ARCH_HAS_PTE_SPECIAL
> +	select ARCH_HAS_SCREEN_INFO
>   	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>   	select ARCH_INLINE_READ_LOCK if !PREEMPTION
>   	select ARCH_INLINE_READ_LOCK_BH if !PREEMPTION
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 675a8660cb85a..c0ae09789cb6d 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -10,6 +10,7 @@ config MIPS
>   	select ARCH_HAS_KCOV
>   	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE if !EVA
>   	select ARCH_HAS_PTE_SPECIAL if !(32BIT && CPU_HAS_RIXI)
> +	select ARCH_HAS_SCREEN_INFO
>   	select ARCH_HAS_STRNCPY_FROM_USER
>   	select ARCH_HAS_STRNLEN_USER
>   	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
> diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
> index e5936417d3cd3..7183eea282212 100644
> --- a/arch/nios2/Kconfig
> +++ b/arch/nios2/Kconfig
> @@ -3,6 +3,7 @@ config NIOS2
>   	def_bool y
>   	select ARCH_32BIT_OFF_T
>   	select ARCH_HAS_DMA_PREP_COHERENT
> +	select ARCH_HAS_SCREEN_INFO
>   	select ARCH_HAS_SYNC_DMA_FOR_CPU
>   	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>   	select ARCH_HAS_DMA_SET_UNCACHED
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index bff5820b7cda1..b1acad3076180 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -148,6 +148,7 @@ config PPC
>   	select ARCH_HAS_PTE_DEVMAP		if PPC_BOOK3S_64
>   	select ARCH_HAS_PTE_SPECIAL
>   	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
> +	select ARCH_HAS_SCREEN_INFO
>   	select ARCH_HAS_SET_MEMORY
>   	select ARCH_HAS_STRICT_KERNEL_RWX	if (PPC_BOOK3S || PPC_8xx || 40x) && !HIBERNATION
>   	select ARCH_HAS_STRICT_KERNEL_RWX	if PPC_85xx && !HIBERNATION && !RANDOMIZE_BASE
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 5966ad97c30c3..b5a48f8424af9 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -29,6 +29,7 @@ config RISCV
>   	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>   	select ARCH_HAS_PMEM_API
>   	select ARCH_HAS_PTE_SPECIAL
> +	select ARCH_HAS_SCREEN_INFO
>   	select ARCH_HAS_SET_DIRECT_MAP if MMU
>   	select ARCH_HAS_SET_MEMORY if MMU
>   	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 04b9550cf0070..001f5149952b4 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -10,6 +10,7 @@ config SUPERH
>   	select ARCH_HAS_GIGANTIC_PAGE
>   	select ARCH_HAS_GCOV_PROFILE_ALL
>   	select ARCH_HAS_PTE_SPECIAL
> +	select ARCH_HAS_SCREEN_INFO
>   	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>   	select ARCH_HIBERNATION_POSSIBLE if MMU
>   	select ARCH_MIGHT_HAVE_PC_PARPORT
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 8535e19062f65..e4bfb80b48cfe 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -13,6 +13,7 @@ config 64BIT
>   config SPARC
>   	bool
>   	default y
> +	select ARCH_HAS_SCREEN_INFO
>   	select ARCH_MIGHT_HAVE_PC_PARPORT if SPARC64 && PCI
>   	select ARCH_MIGHT_HAVE_PC_SERIO
>   	select DMA_OPS
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 53bab123a8ee4..d7c2bf4ee403d 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -91,6 +91,7 @@ config X86
>   	select ARCH_HAS_NONLEAF_PMD_YOUNG	if PGTABLE_LEVELS > 2
>   	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
>   	select ARCH_HAS_COPY_MC			if X86_64
> +	select ARCH_HAS_SCREEN_INFO
>   	select ARCH_HAS_SET_MEMORY
>   	select ARCH_HAS_SET_DIRECT_MAP
>   	select ARCH_HAS_STRICT_KERNEL_RWX
> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
> index 3c6e5471f025b..c6cbd7459939c 100644
> --- a/arch/xtensa/Kconfig
> +++ b/arch/xtensa/Kconfig
> @@ -8,6 +8,7 @@ config XTENSA
>   	select ARCH_HAS_DMA_PREP_COHERENT if MMU
>   	select ARCH_HAS_GCOV_PROFILE_ALL
>   	select ARCH_HAS_KCOV
> +	select ARCH_HAS_SCREEN_INFO
>   	select ARCH_HAS_SYNC_DMA_FOR_CPU if MMU
>   	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if MMU
>   	select ARCH_HAS_DMA_SET_UNCACHED if MMU
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 8b2b9ac37c3df..d4a72bea56be0 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -21,6 +21,9 @@ config STI_CORE
>   config VIDEO_CMDLINE
>   	bool
>   
> +config ARCH_HAS_SCREEN_INFO
> +	bool
> +
>   config VIDEO_NOMODESET
>   	bool
>   	default n
> diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
> index 941be574bbe00..5e5d4158a4b4b 100644
> --- a/include/asm-generic/Kbuild
> +++ b/include/asm-generic/Kbuild
> @@ -47,6 +47,7 @@ mandatory-y += percpu.h
>   mandatory-y += pgalloc.h
>   mandatory-y += preempt.h
>   mandatory-y += rwonce.h
> +mandatory-y += screen_info.h
>   mandatory-y += sections.h
>   mandatory-y += serial.h
>   mandatory-y += shmparam.h
> diff --git a/include/asm-generic/screen_info.h b/include/asm-generic/screen_info.h
> new file mode 100644
> index 0000000000000..6fd0e50fabfcd
> --- /dev/null
> +++ b/include/asm-generic/screen_info.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _ASM_GENERIC_SCREEN_INFO_H
> +#define _ASM_GENERIC_SCREEN_INFO_H
> +
> +#include <uapi/linux/screen_info.h>
> +
> +#if defined(CONFIG_ARCH_HAS_SCREEN_INFO)
> +extern struct screen_info screen_info;
> +#endif
> +
> +#endif /* _ASM_GENERIC_SCREEN_INFO_H */
> diff --git a/include/linux/screen_info.h b/include/linux/screen_info.h
> index eab7081392d50..c764b9a51c24b 100644
> --- a/include/linux/screen_info.h
> +++ b/include/linux/screen_info.h
> @@ -4,6 +4,6 @@
>   
>   #include <uapi/linux/screen_info.h>
>   
> -extern struct screen_info screen_info;
> +#include <asm/screen_info.h>
>   
>   #endif /* _SCREEN_INFO_H */

