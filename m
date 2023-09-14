Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55217A0A30
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 18:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241704AbjINQCl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 12:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241718AbjINQCO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 12:02:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E061FF2;
        Thu, 14 Sep 2023 09:02:00 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rmhlw1C71z67Jb4;
        Thu, 14 Sep 2023 23:57:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 14 Sep
 2023 17:01:56 +0100
Date:   Thu, 14 Sep 2023 17:01:55 +0100
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
Subject: Re: [RFC PATCH v2 31/35] arm64: psci: Ignore DENIED CPUs
Message-ID: <20230914170155.000065cf@Huawei.com>
In-Reply-To: <20230913163823.7880-32-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
        <20230913163823.7880-32-james.morse@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 13 Sep 2023 16:38:19 +0000
James Morse <james.morse@arm.com> wrote:

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> When a CPU is marked as disabled, but online capable in the MADT, PSCI
> applies some firmware policy to control when it can be brought online.
> PSCI returns DENIED to a CPU_ON request if this is not currently
> permitted. The OS can learn the current policy from the _STA enabled bit.
> 
> Handle the PSCI DENIED return code gracefully instead of printing an
> error.

Specification reference would be good particularly as it's only been
added as a possibility fairly recently.

> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> [ morse: Rewrote commit message ]
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/arm64/kernel/psci.c     | 2 +-
>  arch/arm64/kernel/smp.c      | 3 ++-
>  drivers/firmware/psci/psci.c | 2 ++
>  3 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> index 29a8e444db83..4fcc0cdd757b 100644
> --- a/arch/arm64/kernel/psci.c
> +++ b/arch/arm64/kernel/psci.c
> @@ -40,7 +40,7 @@ static int cpu_psci_cpu_boot(unsigned int cpu)
>  {
>  	phys_addr_t pa_secondary_entry = __pa_symbol(secondary_entry);
>  	int err = psci_ops.cpu_on(cpu_logical_map(cpu), pa_secondary_entry);
> -	if (err)
> +	if (err && err != -EPROBE_DEFER)

Hmm. EPROBE_DEFER has very specific meaning around driver requesting a retry
when some other bit of the system has finished booting. 
I'm not sure it's a good idea for this use case.  Maybe just keep to EPERM
as psci_to_linux_errno() will return anyway.  Seems valid to me, or
is the requirement to use EPROBE_DEFER coming from further up the stack?



>  		pr_err("failed to boot CPU%d (%d)\n", cpu, err);
>  
>  	return err;
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 8c8f55721786..e958db987665 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -124,7 +124,8 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  	/* Now bring the CPU into our world */
>  	ret = boot_secondary(cpu, idle);
>  	if (ret) {
> -		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
> +		if (ret != -EPROBE_DEFER)
> +			pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
>  		return ret;
>  	}
>  
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index d9629ff87861..f7ab3fed3528 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -218,6 +218,8 @@ static int __psci_cpu_on(u32 fn, unsigned long cpuid, unsigned long entry_point)
>  	int err;
>  
>  	err = invoke_psci_fn(fn, cpuid, entry_point, 0);
> +	if (err == PSCI_RET_DENIED)
> +		return -EPROBE_DEFER;
>  	return psci_to_linux_errno(err);
>  }
>  

