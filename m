Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B137A0A87
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 18:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbjINQNu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 12:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjINQNt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 12:13:49 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECC21BE1;
        Thu, 14 Sep 2023 09:13:45 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rmj4r2vBYz6HJcg;
        Fri, 15 Sep 2023 00:11:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 14 Sep
 2023 17:13:41 +0100
Date:   Thu, 14 Sep 2023 17:13:41 +0100
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
Subject: Re: [RFC PATCH v2 32/35] ACPI: add support to register CPUs based
 on the _STA enabled bit
Message-ID: <20230914171341.00006e51@Huawei.com>
In-Reply-To: <20230913163823.7880-33-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
        <20230913163823.7880-33-james.morse@arm.com>
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

On Wed, 13 Sep 2023 16:38:20 +0000
James Morse <james.morse@arm.com> wrote:

> acpi_processor_get_info() registers all present CPUs. Registering a
> CPU is what creates the sysfs entries and triggers the udev
> notifications.
> 
> arm64 virtual machines that support 'virtual cpu hotplug' use the
> enabled bit to indicate whether the CPU can be brought online, as
> the existing ACPI tables require all hardware to be described and
> present.
> 
> If firmware describes a CPU as present, but disabled, skip the
> registration. Such CPUs are present, but can't be brought online for
> whatever reason. (e.g. firmware/hypervisor policy).
> 
> Once firmware sets the enabled bit, the CPU can be registered and
> brought online by user-space. Online CPUs, or CPUs that are missing
> an _STA method must always be registered.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
A small argument with myself inline. Feel free to ignore.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/acpi/acpi_processor.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index b67616079751..b49859eab01a 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -227,6 +227,32 @@ static int acpi_processor_make_present(struct acpi_processor *pr)
>  	return ret;
>  }
>  
> +static int acpi_processor_make_enabled(struct acpi_processor *pr)
> +{
> +	unsigned long long sta;
> +	acpi_status status;
> +	bool present, enabled;
> +
> +	if (!acpi_has_method(pr->handle, "_STA"))
> +		return arch_register_cpu(pr->id);
> +
> +	status = acpi_evaluate_integer(pr->handle, "_STA", NULL, &sta);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	present = sta & ACPI_STA_DEVICE_PRESENT;
> +	enabled = sta & ACPI_STA_DEVICE_ENABLED;
> +
> +	if (cpu_online(pr->id) && (!present || !enabled)) {
> +		pr_err_once(FW_BUG "CPU %u is online, but described as not present or disabled!\n", pr->id);

Why once?  If this for some reason happened on multiple CPUs I think we'd want to know.

> +		add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
> +	} else if (!present || !enabled) {
> +		return -ENODEV;
> +	}

I guess you didn't do a nested if here to avoid even longer lines.
Could flip things around though I don't like this much either as it makes
the normal good path exit mid way down.

	if (present && enabled)
		return arch_register_cpu(pr->id);

	if (!cpu_online(pr->id))
		return -ENODEV;

	pr_err...
	add_taint(...

	return arch_register_cpu(pr->id);

Ah well. Some code just has to be less than pretty.	

> +
> +	return arch_register_cpu(pr->id);
> +}
> +
>  static int acpi_processor_get_info(struct acpi_device *device)
>  {
>  	union acpi_object object = { 0 };
> @@ -318,7 +344,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
>  	 */
>  	if (!invalid_logical_cpuid(pr->id) && cpu_present(pr->id) &&
>  	    !get_cpu_device(pr->id)) {
> -		int ret = arch_register_cpu(pr->id);
> +		int ret = acpi_processor_make_enabled(pr);
>  
>  		if (ret)
>  			return ret;
> @@ -526,6 +552,9 @@ static void acpi_processor_post_eject(struct acpi_device *device)
>  		acpi_processor_make_not_present(device);
>  		return;
>  	}
> +
> +	if (cpu_present(pr->id) && !(sta & ACPI_STA_DEVICE_ENABLED))
> +		arch_unregister_cpu(pr->id);
>  }
>  
>  #ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC

