Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58487A021C
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 13:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjINLF3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 07:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjINLF1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 07:05:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AF21BF8;
        Thu, 14 Sep 2023 04:05:23 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RmZF36jdgz6HJdP;
        Thu, 14 Sep 2023 19:03:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 14 Sep
 2023 12:05:20 +0100
Date:   Thu, 14 Sep 2023 12:05:19 +0100
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
Subject: Re: [RFC PATCH v2 03/35] drivers: base: Allow parts of
 GENERIC_CPU_DEVICES to be overridden
Message-ID: <20230914120519.0000247e@Huawei.com>
In-Reply-To: <20230913163823.7880-4-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
        <20230913163823.7880-4-james.morse@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 13 Sep 2023 16:37:51 +0000
James Morse <james.morse@arm.com> wrote:

> Architectures often have extra per-cpu work that needs doing
> before a CPU is registered, often to determine if a CPU is
> hotpluggable.
> 
> To allow the ACPI architectures to use GENERIC_CPU_DEVICES, move
> the cpu_register() call into arch_register_cpu(), which is made __weak
> so architectures with extra work can override it.
> This aligns with the way x86, ia64 and loongarch register hotplug CPUs
> when they become present.

Perhaps call out that you are also making cpu_devices visible outside
of base/cpu.c

Note it isn't obvious to me why you do that in this patch. I assume
it will be needed later...


Otherwise seems sensible to me.

> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since RFC:
>  * Dropped __init from x86/ia64 arch_register_cpu()
> ---
>  arch/ia64/include/asm/cpu.h      |  1 -
>  arch/ia64/kernel/topology.c      |  2 +-
>  arch/loongarch/include/asm/cpu.h |  1 -
>  arch/x86/include/asm/cpu.h       |  1 -
>  arch/x86/kernel/topology.c       |  2 +-
>  drivers/base/cpu.c               | 14 ++++++++++----
>  include/linux/cpu.h              |  5 +++++
>  7 files changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/ia64/include/asm/cpu.h b/arch/ia64/include/asm/cpu.h
> index db125df9e088..a3e690e685e5 100644
> --- a/arch/ia64/include/asm/cpu.h
> +++ b/arch/ia64/include/asm/cpu.h
> @@ -16,7 +16,6 @@ DECLARE_PER_CPU(struct ia64_cpu, cpu_devices);
>  DECLARE_PER_CPU(int, cpu_state);
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> -extern int arch_register_cpu(int num);
>  extern void arch_unregister_cpu(int);
>  #endif
>  
> diff --git a/arch/ia64/kernel/topology.c b/arch/ia64/kernel/topology.c
> index 94a848b06f15..741863a187a6 100644
> --- a/arch/ia64/kernel/topology.c
> +++ b/arch/ia64/kernel/topology.c
> @@ -59,7 +59,7 @@ void __ref arch_unregister_cpu(int num)
>  }
>  EXPORT_SYMBOL(arch_unregister_cpu);
>  #else
> -static int __init arch_register_cpu(int num)
> +int __init arch_register_cpu(int num)
>  {
>  	return register_cpu(&sysfs_cpus[num].cpu, num);
>  }
> diff --git a/arch/loongarch/include/asm/cpu.h b/arch/loongarch/include/asm/cpu.h
> index 7afe8cbb844e..b8568e637420 100644
> --- a/arch/loongarch/include/asm/cpu.h
> +++ b/arch/loongarch/include/asm/cpu.h
> @@ -130,7 +130,6 @@ enum cpu_type_enum {
>  
>  #if !defined(__ASSEMBLY__)
>  #ifdef CONFIG_HOTPLUG_CPU
> -int arch_register_cpu(int num);
>  void arch_unregister_cpu(int cpu);
>  #endif
>  #endif /* ! __ASSEMBLY__ */
> diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
> index 3a233ebff712..96dc4665e87d 100644
> --- a/arch/x86/include/asm/cpu.h
> +++ b/arch/x86/include/asm/cpu.h
> @@ -28,7 +28,6 @@ struct x86_cpu {
>  };
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> -extern int arch_register_cpu(int num);
>  extern void arch_unregister_cpu(int);
>  extern void soft_restart_cpu(void);
>  #endif
> diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
> index ca004e2e4469..0bab03130033 100644
> --- a/arch/x86/kernel/topology.c
> +++ b/arch/x86/kernel/topology.c
> @@ -54,7 +54,7 @@ void arch_unregister_cpu(int num)
>  EXPORT_SYMBOL(arch_unregister_cpu);
>  #else /* CONFIG_HOTPLUG_CPU */
>  
> -static int __init arch_register_cpu(int num)
> +int __init arch_register_cpu(int num)
>  {
>  	return register_cpu(&per_cpu(cpu_devices, num).cpu, num);
>  }
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 34b48f660b6b..579064fda97b 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -525,19 +525,25 @@ bool cpu_is_hotpluggable(unsigned int cpu)
>  EXPORT_SYMBOL_GPL(cpu_is_hotpluggable);
>  
>  #ifdef CONFIG_GENERIC_CPU_DEVICES
> -static DEFINE_PER_CPU(struct cpu, cpu_devices);
> +DEFINE_PER_CPU(struct cpu, cpu_devices);
> +
> +int __weak arch_register_cpu(int cpu)
> +{
> +	return register_cpu(&per_cpu(cpu_devices, cpu), cpu);
> +}
>  #endif
>  
>  static void __init cpu_dev_register_generic(void)
>  {
> -#ifdef CONFIG_GENERIC_CPU_DEVICES
>  	int i;
>  
> +	if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES))
> +		return;
> +
>  	for_each_present_cpu(i) {
> -		if (register_cpu(&per_cpu(cpu_devices, i), i))
> +		if (arch_register_cpu(i))
>  			panic("Failed to register CPU device");
>  	}
> -#endif
>  }
>  
>  #ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index 0abd60a7987b..a71691d7c2ca 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -80,12 +80,17 @@ extern __printf(4, 5)
>  struct device *cpu_device_create(struct device *parent, void *drvdata,
>  				 const struct attribute_group **groups,
>  				 const char *fmt, ...);
> +extern int arch_register_cpu(int cpu);
>  #ifdef CONFIG_HOTPLUG_CPU
>  extern void unregister_cpu(struct cpu *cpu);
>  extern ssize_t arch_cpu_probe(const char *, size_t);
>  extern ssize_t arch_cpu_release(const char *, size_t);
>  #endif
>  
> +#ifdef CONFIG_GENERIC_CPU_DEVICES
> +DECLARE_PER_CPU(struct cpu, cpu_devices);
> +#endif
> +
>  /*
>   * These states are not related to the core CPU hotplug mechanism. They are
>   * used by various (sub)architectures to track internal state

