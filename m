Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3336A8FBB
	for <lists+linux-arch@lfdr.de>; Fri,  3 Mar 2023 04:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjCCDPe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 22:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjCCDPe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 22:15:34 -0500
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AB217156;
        Thu,  2 Mar 2023 19:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1677813329; bh=XyzEnMHAK5hoo1yLA6lFEowVE+ZZX2zR9fnfmArCaFk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=l5G0ohlVB3fBUQs1D9qjx+K6Yx6fcgjFV00Uz2gKMQjDw6XvH4Aan9xmZOvYxP8yz
         vweiHw3Kxt7KEJgzsC7HYR00wi56oH1pACV8CFNq6tek8/lp8MyypFzGTFDOHhR92f
         Q9BA/1TiKKWS0oYCE4V4ixI2CC5A1x9nRwk6M9Hc=
Received: from [100.100.57.122] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id A28456087F;
        Fri,  3 Mar 2023 11:15:28 +0800 (CST)
Message-ID: <480ab341-6437-e409-8779-c4938924fd64@xen0n.name>
Date:   Fri, 3 Mar 2023 11:15:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] LoongArch: Fix the CRC32 feature probing
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
References: <20230303002508.2891681-1-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20230303002508.2891681-1-chenhuacai@loongson.cn>
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

On 2023/3/3 08:25, Huacai Chen wrote:
> Not all LoongArch processors support CRC32 instructions, and this feature
> is indicated by CPUCFG1.CRC32 (Bit25). This bit is wrongly defined in loongarch.h

The ISA manual suggests it's IOCSR_BRD (likely "IOCSR Branding"). You 
have to somehow reconcile the two, either by fixing the manuals, or 
mention here explicitly that the manual is wrong. (Actually thinking 
about it harder now, you may be in fact re-purposing the IOCSR_BRD field 
for CRC32 capability, because all LoongArch cores in existence are 
designed by Loongson, and you may very well know that all cores 
supporting CRC32 have this bit set, and those not having CRC32 haven't. 
If that's the case, please explicitly document this reasoning too.)

> and CRC32 is set unconditionally now, so fix it.
> 
> BTW, expose the CRC32 feature in /proc/cpuinfo.
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/include/asm/cpu-features.h |  1 +
>   arch/loongarch/include/asm/cpu.h          | 40 ++++++++++++-----------
>   arch/loongarch/include/asm/loongarch.h    |  2 +-
>   arch/loongarch/kernel/cpu-probe.c         |  7 +++-
>   arch/loongarch/kernel/proc.c              |  1 +
>   5 files changed, 30 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/cpu-features.h b/arch/loongarch/include/asm/cpu-features.h
> index b07974218393..f6177f133477 100644
> --- a/arch/loongarch/include/asm/cpu-features.h
> +++ b/arch/loongarch/include/asm/cpu-features.h
> @@ -42,6 +42,7 @@
>   #define cpu_has_fpu		cpu_opt(LOONGARCH_CPU_FPU)
>   #define cpu_has_lsx		cpu_opt(LOONGARCH_CPU_LSX)
>   #define cpu_has_lasx		cpu_opt(LOONGARCH_CPU_LASX)
> +#define cpu_has_crc32		cpu_opt(LOONGARCH_CPU_CRC32)
>   #define cpu_has_complex		cpu_opt(LOONGARCH_CPU_COMPLEX)
>   #define cpu_has_crypto		cpu_opt(LOONGARCH_CPU_CRYPTO)
>   #define cpu_has_lvz		cpu_opt(LOONGARCH_CPU_LVZ)
> diff --git a/arch/loongarch/include/asm/cpu.h b/arch/loongarch/include/asm/cpu.h
> index c3da91759472..ca9e2be571ec 100644
> --- a/arch/loongarch/include/asm/cpu.h
> +++ b/arch/loongarch/include/asm/cpu.h
> @@ -78,25 +78,26 @@ enum cpu_type_enum {
>   #define CPU_FEATURE_FPU			3	/* CPU has FPU */
>   #define CPU_FEATURE_LSX			4	/* CPU has LSX (128-bit SIMD) */
>   #define CPU_FEATURE_LASX		5	/* CPU has LASX (256-bit SIMD) */
> -#define CPU_FEATURE_COMPLEX		6	/* CPU has Complex instructions */
> -#define CPU_FEATURE_CRYPTO		7	/* CPU has Crypto instructions */
> -#define CPU_FEATURE_LVZ			8	/* CPU has Virtualization extension */
> -#define CPU_FEATURE_LBT_X86		9	/* CPU has X86 Binary Translation */
> -#define CPU_FEATURE_LBT_ARM		10	/* CPU has ARM Binary Translation */
> -#define CPU_FEATURE_LBT_MIPS		11	/* CPU has MIPS Binary Translation */
> -#define CPU_FEATURE_TLB			12	/* CPU has TLB */
> -#define CPU_FEATURE_CSR			13	/* CPU has CSR */
> -#define CPU_FEATURE_WATCH		14	/* CPU has watchpoint registers */
> -#define CPU_FEATURE_VINT		15	/* CPU has vectored interrupts */
> -#define CPU_FEATURE_CSRIPI		16	/* CPU has CSR-IPI */
> -#define CPU_FEATURE_EXTIOI		17	/* CPU has EXT-IOI */
> -#define CPU_FEATURE_PREFETCH		18	/* CPU has prefetch instructions */
> -#define CPU_FEATURE_PMP			19	/* CPU has perfermance counter */
> -#define CPU_FEATURE_SCALEFREQ		20	/* CPU supports cpufreq scaling */
> -#define CPU_FEATURE_FLATMODE		21	/* CPU has flat mode */
> -#define CPU_FEATURE_EIODECODE		22	/* CPU has EXTIOI interrupt pin decode mode */
> -#define CPU_FEATURE_GUESTID		23	/* CPU has GuestID feature */
> -#define CPU_FEATURE_HYPERVISOR		24	/* CPU has hypervisor (running in VM) */
> +#define CPU_FEATURE_CRC32		6	/* CPU has Complex instructions */

"CPU has CRC32 instructions".

Also, the diff damage is real, is there any reason this must come here 
and not last? To me "aesthetics" is not enough to justify such a diff 
damage.

> +#define CPU_FEATURE_COMPLEX		7	/* CPU has Complex instructions */
> +#define CPU_FEATURE_CRYPTO		8	/* CPU has Crypto instructions */
> +#define CPU_FEATURE_LVZ			9	/* CPU has Virtualization extension */
> +#define CPU_FEATURE_LBT_X86		10	/* CPU has X86 Binary Translation */
> +#define CPU_FEATURE_LBT_ARM		11	/* CPU has ARM Binary Translation */
> +#define CPU_FEATURE_LBT_MIPS		12	/* CPU has MIPS Binary Translation */
> +#define CPU_FEATURE_TLB			13	/* CPU has TLB */
> +#define CPU_FEATURE_CSR			14	/* CPU has CSR */
> +#define CPU_FEATURE_WATCH		15	/* CPU has watchpoint registers */
> +#define CPU_FEATURE_VINT		16	/* CPU has vectored interrupts */
> +#define CPU_FEATURE_CSRIPI		17	/* CPU has CSR-IPI */
> +#define CPU_FEATURE_EXTIOI		18	/* CPU has EXT-IOI */
> +#define CPU_FEATURE_PREFETCH		19	/* CPU has prefetch instructions */
> +#define CPU_FEATURE_PMP			20	/* CPU has perfermance counter */
> +#define CPU_FEATURE_SCALEFREQ		21	/* CPU supports cpufreq scaling */
> +#define CPU_FEATURE_FLATMODE		22	/* CPU has flat mode */
> +#define CPU_FEATURE_EIODECODE		23	/* CPU has EXTIOI interrupt pin decode mode */
> +#define CPU_FEATURE_GUESTID		24	/* CPU has GuestID feature */
> +#define CPU_FEATURE_HYPERVISOR		25	/* CPU has hypervisor (running in VM) */
>   
>   #define LOONGARCH_CPU_CPUCFG		BIT_ULL(CPU_FEATURE_CPUCFG)
>   #define LOONGARCH_CPU_LAM		BIT_ULL(CPU_FEATURE_LAM)
> @@ -104,6 +105,7 @@ enum cpu_type_enum {
>   #define LOONGARCH_CPU_FPU		BIT_ULL(CPU_FEATURE_FPU)
>   #define LOONGARCH_CPU_LSX		BIT_ULL(CPU_FEATURE_LSX)
>   #define LOONGARCH_CPU_LASX		BIT_ULL(CPU_FEATURE_LASX)
> +#define LOONGARCH_CPU_CRC32		BIT_ULL(CPU_FEATURE_CRC32)
>   #define LOONGARCH_CPU_COMPLEX		BIT_ULL(CPU_FEATURE_COMPLEX)
>   #define LOONGARCH_CPU_CRYPTO		BIT_ULL(CPU_FEATURE_CRYPTO)
>   #define LOONGARCH_CPU_LVZ		BIT_ULL(CPU_FEATURE_LVZ)
> diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
> index 65b7dcdea16d..8c2969965c3c 100644
> --- a/arch/loongarch/include/asm/loongarch.h
> +++ b/arch/loongarch/include/asm/loongarch.h
> @@ -117,7 +117,7 @@ static inline u32 read_cpucfg(u32 reg)
>   #define  CPUCFG1_EP			BIT(22)
>   #define  CPUCFG1_RPLV			BIT(23)
>   #define  CPUCFG1_HUGEPG			BIT(24)
> -#define  CPUCFG1_IOCSRBRD		BIT(25)
> +#define  CPUCFG1_CRC32			BIT(25)
>   #define  CPUCFG1_MSGINT			BIT(26)
>   
>   #define LOONGARCH_CPUCFG2		0x2
> diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
> index 3a3fce2d7846..482643167119 100644
> --- a/arch/loongarch/kernel/cpu-probe.c
> +++ b/arch/loongarch/kernel/cpu-probe.c
> @@ -94,13 +94,18 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
>   	c->options = LOONGARCH_CPU_CPUCFG | LOONGARCH_CPU_CSR |
>   		     LOONGARCH_CPU_TLB | LOONGARCH_CPU_VINT | LOONGARCH_CPU_WATCH;
>   
> -	elf_hwcap = HWCAP_LOONGARCH_CPUCFG | HWCAP_LOONGARCH_CRC32;
> +	elf_hwcap = HWCAP_LOONGARCH_CPUCFG;
>   
>   	config = read_cpucfg(LOONGARCH_CPUCFG1);
>   	if (config & CPUCFG1_UAL) {
>   		c->options |= LOONGARCH_CPU_UAL;
>   		elf_hwcap |= HWCAP_LOONGARCH_UAL;
>   	}
> +	if (config & CPUCFG1_CRC32) {
> +		c->options |= LOONGARCH_CPU_CRC32;
> +		elf_hwcap |= HWCAP_LOONGARCH_CRC32;
> +	}
> +
>   
>   	config = read_cpucfg(LOONGARCH_CPUCFG2);
>   	if (config & CPUCFG2_LAM) {
> diff --git a/arch/loongarch/kernel/proc.c b/arch/loongarch/kernel/proc.c
> index 5c67cc4fd56d..0d82907b5404 100644
> --- a/arch/loongarch/kernel/proc.c
> +++ b/arch/loongarch/kernel/proc.c
> @@ -76,6 +76,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>   	if (cpu_has_fpu)	seq_printf(m, " fpu");
>   	if (cpu_has_lsx)	seq_printf(m, " lsx");
>   	if (cpu_has_lasx)	seq_printf(m, " lasx");
> +	if (cpu_has_crc32)	seq_printf(m, " crc32");
>   	if (cpu_has_complex)	seq_printf(m, " complex");
>   	if (cpu_has_crypto)	seq_printf(m, " crypto");
>   	if (cpu_has_lvz)	seq_printf(m, " lvz");

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

