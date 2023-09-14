Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA52E7A02FD
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 13:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbjINLrc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 07:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236561AbjINLrc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 07:47:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E137BB;
        Thu, 14 Sep 2023 04:47:27 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rmb6D5jBWz67cSL;
        Thu, 14 Sep 2023 19:42:44 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 14 Sep
 2023 12:47:25 +0100
Date:   Thu, 14 Sep 2023 12:47:24 +0100
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
Subject: Re: [RFC PATCH v2 09/35] LoongArch: Switch over to
 GENERIC_CPU_DEVICES
Message-ID: <20230914124724.000027f3@Huawei.com>
In-Reply-To: <20230913163823.7880-10-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
        <20230913163823.7880-10-james.morse@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 13 Sep 2023 16:37:57 +0000
James Morse <james.morse@arm.com> wrote:

> Now that GENERIC_CPU_DEVICES calls arch_register_cpu(), which can be
> overridden by the arch code, switch over to this to allow common code
> to choose when the register_cpu() call is made.
> 
> This allows topology_init() to be removed.
> 
> This is an intermediate step to the logic being moved to drivers/acpi,
> where GENERIC_CPU_DEVICES will do the work when booting with acpi=off.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/loongarch/Kconfig           |  1 +
>  arch/loongarch/kernel/topology.c | 29 ++---------------------------
>  2 files changed, 3 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 2bddd202470e..5bed51adc68c 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -72,6 +72,7 @@ config LOONGARCH
>  	select GENERIC_CLOCKEVENTS
>  	select GENERIC_CMOS_UPDATE
>  	select GENERIC_CPU_AUTOPROBE
> +	select GENERIC_CPU_DEVICES
>  	select GENERIC_ENTRY
>  	select GENERIC_GETTIMEOFDAY
>  	select GENERIC_IOREMAP if !ARCH_IOREMAP
> diff --git a/arch/loongarch/kernel/topology.c b/arch/loongarch/kernel/topology.c
> index caa7cd859078..8e4441c1ff39 100644
> --- a/arch/loongarch/kernel/topology.c
> +++ b/arch/loongarch/kernel/topology.c
> @@ -7,20 +7,13 @@
>  #include <linux/percpu.h>
>  #include <asm/bootinfo.h>
>  
> -static DEFINE_PER_CPU(struct cpu, cpu_devices);
> -
>  #ifdef CONFIG_HOTPLUG_CPU
>  int arch_register_cpu(int cpu)
>  {
> -	int ret;
>  	struct cpu *c = &per_cpu(cpu_devices, cpu);
>  
> -	c->hotpluggable = 1;

This is a bit subtle.  Can loongarch hotplug a CPU that
is also io_master(cpu)?  I have no idea if there is a subtle difference
between.

1) CPUs present at boot where if they are an io_master they are not allowed
   to be hot removed.
2) CPUs that turn up (hotplugged) later which are an io_master and by original code
   can be removed.

My guess is that no io_master CPU can be hotplugged in making this irrelevant
and your code correct as the =1 is just a micro optimizatoin.

If we can confirm that, a one line addition to the patch description would be
great. 

Otherwise LGTM

> -	ret = register_cpu(c, cpu);
> -	if (ret < 0)
> -		pr_warn("register_cpu %d failed (%d)\n", cpu, ret);
> -
> -	return ret;
> +	c->hotpluggable = !io_master(cpu);
> +	return register_cpu(c, cpu);
>  }
>  EXPORT_SYMBOL(arch_register_cpu);
>  
> @@ -33,21 +26,3 @@ void arch_unregister_cpu(int cpu)
>  }
>  EXPORT_SYMBOL(arch_unregister_cpu);
>  #endif
> -
> -static int __init topology_init(void)
> -{
> -	int i, ret;
> -
> -	for_each_present_cpu(i) {
> -		struct cpu *c = &per_cpu(cpu_devices, i);
> -
> -		c->hotpluggable = !io_master(i);
> -		ret = register_cpu(c, i);
> -		if (ret < 0)
> -			pr_warn("topology_init: register_cpu %d failed (%d)\n", i, ret);
> -	}
> -
> -	return 0;
> -}
> -
> -subsys_initcall(topology_init);

