Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5983D7A0764
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 16:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbjINOcP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 10:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjINOcO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 10:32:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B79E1A2;
        Thu, 14 Sep 2023 07:32:10 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RmfmH4clgz67KXG;
        Thu, 14 Sep 2023 22:27:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 14 Sep
 2023 15:32:08 +0100
Date:   Thu, 14 Sep 2023 15:32:07 +0100
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
Subject: Re: [RFC PATCH v2 23/35] ACPI: Warn when the present bit changes
 but the feature is not enabled
Message-ID: <20230914153207.00006492@Huawei.com>
In-Reply-To: <20230913163823.7880-24-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
        <20230913163823.7880-24-james.morse@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 13 Sep 2023 16:38:11 +0000
James Morse <james.morse@arm.com> wrote:

> ACPI firmware can trigger the events to add and remove CPUs, but the
> OS may not support this.
> 
> Print a warning when this happens.
> 
> This gives early warning on arm64 systems that don't support
> CONFIG_ACPI_HOTPLUG_PRESENT_CPU, as making CPUs not present has
> side effects for other parts of the system.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
Seem like a good idea to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/acpi/acpi_processor.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 2cafea1edc24..b67616079751 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -188,8 +188,10 @@ static int acpi_processor_make_present(struct acpi_processor *pr)
>  	acpi_status status;
>  	int ret;
>  
> -	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU))
> +	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU)) {
> +		pr_err_once("Changing CPU present bit is not supported\n");
>  		return -ENODEV;
> +	}
>  
>  	if (invalid_phys_cpuid(pr->phys_id))
>  		return -ENODEV;
> @@ -462,8 +464,10 @@ static void acpi_processor_make_not_present(struct acpi_device *device)
>  {
>  	struct acpi_processor *pr;
>  
> -	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU))
> +	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU)) {
> +		pr_err_once("Changing CPU present bit is not supported");
>  		return;
> +	}
>  
>  	pr = acpi_driver_data(device);
>  	if (pr->id >= nr_cpu_ids)

