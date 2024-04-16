Return-Path: <linux-arch+bounces-3726-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D96BE8A6D30
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 16:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66E88B22A1C
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 14:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9607212CD8B;
	Tue, 16 Apr 2024 14:00:13 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44F612BF3A;
	Tue, 16 Apr 2024 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276013; cv=none; b=eEGzyorkpWFp9lVq/7aGMnmW0kCOboyNd/zycKBQO5T91OUFHC1NzZ+lS4RlS4uXmKf+UPDPrfP/wcSSEqIwWSl42iLqYZZ68j9bH3Fj4Bt0fr8akb1uufrhZTQN6tXdVt8O43gxNJ6PS4K79QY0tAB1csbxldiRcUH3Z998dwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276013; c=relaxed/simple;
	bh=b1c9Idw5WwR1wow0ywz3fwqqsRx0+1L+gWDdhubKeBU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mDTmf4a6nfiGhKVoHnZ8UMaMH6/dvigoOhlEVJx/0MXKd3ifvUJY9qytNv5RP0eD0EzRF2K4zjUtDvKzU48XJPILwqSaZ4nM0h7idcqmTTuU0HTbrmnlZe9HvKdBPjFhMaRX/ZL5lFOUSESFXw2BokpJxca7QcUsGxoC2psBAxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VJlsk53Hnz6K8xT;
	Tue, 16 Apr 2024 21:55:06 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id DCBEF140B3C;
	Tue, 16 Apr 2024 22:00:02 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 16 Apr
 2024 15:00:02 +0100
Date: Tue, 16 Apr 2024 15:00:01 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, <x86@kernel.org>, Russell King
	<linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>, "Miguel
 Luis" <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, "Salil
 Mehta" <salil.mehta@huawei.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, <linuxarm@huawei.com>
CC: <justin.he@arm.com>, <jianyong.wu@arm.com>
Subject: Re: [PATCH v5 03/18] ACPI: processor: Register deferred CPUs from
 acpi_processor_get_info()
Message-ID: <20240416145917.00004a7b@huawei.com>
In-Reply-To: <20240412143719.11398-4-Jonathan.Cameron@huawei.com>
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
	<20240412143719.11398-4-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 12 Apr 2024 15:37:04 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> From: James Morse <james.morse@arm.com>
> 
> The arm64 specific arch_register_cpu() call may defer CPU registration
> until the ACPI interpreter is available and the _STA method can
> be evaluated.
> 
> If this occurs, then a second attempt is made in
> acpi_processor_get_info(). Note that the arm64 specific call has
> not yet been added so for now this will never be successfully
> called.
> 
> Systems can still be booted with 'acpi=off', or not include an
> ACPI description at all as in these cases arch_register_cpu()
> will not have deferred registration when first called.
> 
> This moves the CPU register logic back to a subsys_initcall(),
> while the memory nodes will have been registered earlier.
> Note this is where the call was prior to the cleanup series so
> there should be no side effects of moving it back again for this
> specific case.
> 
> [PATCH 00/21] Initial cleanups for vCPU HP.
> https://lore.kernel.org/all/ZVyz%2FVe5pPu8AWoA@shell.armlinux.org.uk/
> 
> e.g. 5b95f94c3b9f ("x86/topology: Switch over to GENERIC_CPU_DEVICES")
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Joanthan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v5: Update commit message to make it clear this is moving the
>     init back to where it was until very recently.
> 
>     No longer change the condition in the earlier registration point
>     as that will be handled by the arm64 registration routine
>     deferring until called again here.
> ---
>  drivers/acpi/acpi_processor.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 93e029403d05..c78398cdd060 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -317,6 +317,18 @@ static int acpi_processor_get_info(struct acpi_device *device)
>  
>  	c = &per_cpu(cpu_devices, pr->id);
>  	ACPI_COMPANION_SET(&c->dev, device);
> +	/*
> +	 * Register CPUs that are present. get_cpu_device() is used to skip
> +	 * duplicate CPU descriptions from firmware.
> +	 */
> +	if (!invalid_logical_cpuid(pr->id) && cpu_present(pr->id) &&
> +	    !get_cpu_device(pr->id)) {

Just a quick note to call out that this case of 'duplicate' firmware
description needs an updated comment.  Now we are not deferring
registration on x86 this is detecting that arch_register_cpu()
has already been successfully called and we should not do it again.

I've added rather more detailed comments enumerating of the paths we
can take to hit acpi_processor_hotadd_init() in the v6 series
(tests ongoing)

Jonathan


> +		int ret = arch_register_cpu(pr->id);
> +
> +		if (ret)
> +			return ret;
> +	}
> +
>  	/*
>  	 *  Extra Processor objects may be enumerated on MP systems with
>  	 *  less than the max # of CPUs. They should be ignored _iff


