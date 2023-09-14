Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475637A0693
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 15:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239107AbjINN4S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 09:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239273AbjINN4O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 09:56:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57A1CEB;
        Thu, 14 Sep 2023 06:56:10 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rmf2700D8z6HJb0;
        Thu, 14 Sep 2023 21:54:22 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 14 Sep
 2023 14:56:08 +0100
Date:   Thu, 14 Sep 2023 14:56:07 +0100
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
Subject: Re: [RFC PATCH v2 16/35] ACPI: processor: Register CPUs that are
 online, but not described in the DSDT
Message-ID: <20230914145607.00006f9b@Huawei.com>
In-Reply-To: <20230913163823.7880-17-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
        <20230913163823.7880-17-james.morse@arm.com>
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

On Wed, 13 Sep 2023 16:38:04 +0000
James Morse <james.morse@arm.com> wrote:

> ACPI has two descriptions of CPUs, one in the MADT/APIC table, the other
> in the DSDT. Both are required. (ACPI 6.5's 8.4 "Declaring Processors"
> says "Each processor in the system must be declared in the ACPI
> namespace"). Having two descriptions allows firmware authors to get
> this wrong.
> 
> If CPUs are described in the MADT/APIC, they will be brought online
> early during boot. Once the register_cpu() calls are moved to ACPI,
> they will be based on the DSDT description of the CPUs. When CPUs are
> missing from the DSDT description, they will end up online, but not
> registered.
> 
> Add a helper that runs after acpi_init() has completed to register
> CPUs that are online, but weren't found in the DSDT. Any CPU that
> is registered by this code triggers a firmware-bug warning and kernel
> taint.
> 
> Qemu TCG only describes the first CPU in the DSDT, unless cpu-hotplug
> is configured.

We should fix that as who likes warnings and taint :)
I dread to think how common this will turn out to be.

> 
> Signed-off-by: James Morse <james.morse@arm.com>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/acpi/acpi_processor.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index b4bde78121bb..a01e315aa16a 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -790,6 +790,25 @@ void __init acpi_processor_init(void)
>  	acpi_pcc_cpufreq_init();
>  }
>  
> +static int __init acpi_processor_register_missing_cpus(void)
> +{
> +	int cpu;
> +
> +	if (acpi_disabled)
> +		return 0;
> +
> +	for_each_online_cpu(cpu) {
> +		if (!get_cpu_device(cpu)) {
> +			pr_err_once(FW_BUG "CPU %u has no ACPI namespace description!\n", cpu);
> +			add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
> +			arch_register_cpu(cpu);
> +		}
> +	}
> +
> +	return 0;
> +}
> +subsys_initcall_sync(acpi_processor_register_missing_cpus);
> +
>  #ifdef CONFIG_ACPI_PROCESSOR_CSTATE
>  /**
>   * acpi_processor_claim_cst_control - Request _CST control from the platform.

