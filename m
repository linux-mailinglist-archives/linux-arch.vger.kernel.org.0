Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284197A077E
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 16:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239953AbjINOj1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 10:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238205AbjINOj0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 10:39:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B561A5;
        Thu, 14 Sep 2023 07:39:21 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rmg1G5Xz2z6K5p0;
        Thu, 14 Sep 2023 22:38:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 14 Sep
 2023 15:39:18 +0100
Date:   Thu, 14 Sep 2023 15:39:18 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     James Morse <james.morse@arm.com>
CC:     <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
        <linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        <x86@kernel.org>, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <jianyong.wu@arm.com>, <justin.he@arm.com>
Subject: Re: [RFC PATCH v2 24/35] drivers: base: Implement weak
 arch_unregister_cpu()
Message-ID: <20230914153918.00004c92@Huawei.com>
In-Reply-To: <20230913163823.7880-25-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
        <20230913163823.7880-25-james.morse@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 13 Sep 2023 16:38:12 +0000
James Morse <james.morse@arm.com> wrote:

> Add arch_unregister_cpu() to allow the ACPI machinery to call
> unregister_cpu(). This is enough for arm64, riscv and loongarch, but
> needs to be overridden by x86 and ia64 who need to do more work.
> 
> CC: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: James Morse <james.morse@arm.com>

Ah.  Was thinking this should happen in an earlier patch.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> Changes since v1:
>  * Added CONFIG_HOTPLUG_CPU ifdeffery around unregister_cpu
> ---
>  arch/ia64/include/asm/cpu.h      | 4 ----
>  arch/loongarch/include/asm/cpu.h | 6 ------
>  arch/x86/include/asm/cpu.h       | 1 -
>  drivers/base/cpu.c               | 9 ++++++++-
>  4 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/ia64/include/asm/cpu.h b/arch/ia64/include/asm/cpu.h
> index a3e690e685e5..642d71675ddb 100644
> --- a/arch/ia64/include/asm/cpu.h
> +++ b/arch/ia64/include/asm/cpu.h
> @@ -15,8 +15,4 @@ DECLARE_PER_CPU(struct ia64_cpu, cpu_devices);
>  
>  DECLARE_PER_CPU(int, cpu_state);
>  
> -#ifdef CONFIG_HOTPLUG_CPU
> -extern void arch_unregister_cpu(int);
> -#endif
> -
>  #endif /* _ASM_IA64_CPU_H_ */
> diff --git a/arch/loongarch/include/asm/cpu.h b/arch/loongarch/include/asm/cpu.h
> index b8568e637420..48b9f7168bcc 100644
> --- a/arch/loongarch/include/asm/cpu.h
> +++ b/arch/loongarch/include/asm/cpu.h
> @@ -128,10 +128,4 @@ enum cpu_type_enum {
>  #define LOONGARCH_CPU_HYPERVISOR	BIT_ULL(CPU_FEATURE_HYPERVISOR)
>  #define LOONGARCH_CPU_PTW		BIT_ULL(CPU_FEATURE_PTW)
>  
> -#if !defined(__ASSEMBLY__)
> -#ifdef CONFIG_HOTPLUG_CPU
> -void arch_unregister_cpu(int cpu);
> -#endif
> -#endif /* ! __ASSEMBLY__ */
> -
>  #endif /* _ASM_CPU_H */
> diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
> index f349c94510e8..91867a6a9f8e 100644
> --- a/arch/x86/include/asm/cpu.h
> +++ b/arch/x86/include/asm/cpu.h
> @@ -24,7 +24,6 @@ static inline void prefill_possible_map(void) {}
>  #endif /* CONFIG_SMP */
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> -extern void arch_unregister_cpu(int);
>  extern void soft_restart_cpu(void);
>  #endif
>  
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 677f963e02ce..c709747c4a18 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -531,7 +531,14 @@ int __weak arch_register_cpu(int cpu)
>  {
>  	return register_cpu(&per_cpu(cpu_devices, cpu), cpu);
>  }
> -#endif
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +void __weak arch_unregister_cpu(int num)
> +{
> +	unregister_cpu(&per_cpu(cpu_devices, num));
> +}
> +#endif /* CONFIG_HOTPLUG_CPU */
> +#endif /* CONFIG_GENERIC_CPU_DEVICES */
>  
>  static void __init cpu_dev_register_generic(void)
>  {

