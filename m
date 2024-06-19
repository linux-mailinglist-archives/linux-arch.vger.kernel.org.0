Return-Path: <linux-arch+bounces-4967-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9DB90E54C
	for <lists+linux-arch@lfdr.de>; Wed, 19 Jun 2024 10:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DC86B246E8
	for <lists+linux-arch@lfdr.de>; Wed, 19 Jun 2024 08:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127FA78C73;
	Wed, 19 Jun 2024 08:11:46 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1FD78C6D;
	Wed, 19 Jun 2024 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718784706; cv=none; b=VodKQUgj5E2FaQxXzdlRHuusv8YkT2i6eIbxCTH7dpV7jXnr4kxgozHZhKFoK2Cbn363V/pudVPYCMhhF5vD8F5FyQ8ic6VgaWwbGtO++T+d8hiTKFjgiuSsjhHEIzM/8o02hTgtiSct5BEHQBp6ArdRqwodUQig72ma6hzWPkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718784706; c=relaxed/simple;
	bh=4SIlKV9xWC8OiXcIVxQ0T6S3AYpJoIlOmn9UTDWDXPg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NieVMYyLUX/wuxTDT6hxhQrxAna6dtj3obbW6ioFB/Q7ECSyR+tsF9B/IUyec9DP3XJWXzJImzOLM4Nfj94+jQ1rVvf5anjuKLyp4bijWvFSJ/5maAE+itQm0pPtDzf6oeCLpxd9ppWsQzapcRmGnkZ0KO5b0IHdu3hqZBrLP+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W3x6B2f2tz6JB5T;
	Wed, 19 Jun 2024 16:06:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 32FD9140B63;
	Wed, 19 Jun 2024 16:11:40 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 19 Jun
 2024 09:11:39 +0100
Date: Wed, 19 Jun 2024 09:11:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>
CC: Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, <loongarch@lists.linux.dev>,
	<x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki"
	<rafael@kernel.org>, "Miguel Luis" <miguel.luis@oracle.com>, James Morse
	<james.morse@arm.com>, "Salil Mehta" <salil.mehta@huawei.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Hanjun Guo <guohanjun@huawei.com>, Gavin
 Shan <gshan@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<justin.he@arm.com>, <jianyong.wu@arm.com>
Subject: Re: [PATCH v10 13/19] irqchip/gic-v3: Don't return errors from
 gic_acpi_match_gicc()
Message-ID: <20240619091122.00003a9e@huawei.com>
In-Reply-To: <20240529133446.28446-14-Jonathan.Cameron@huawei.com>
References: <20240529133446.28446-1-Jonathan.Cameron@huawei.com>
	<20240529133446.28446-14-Jonathan.Cameron@huawei.com>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 29 May 2024 14:34:40 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> From: James Morse <james.morse@arm.com>
> 
> gic_acpi_match_gicc() is only called via gic_acpi_count_gicr_regions().
> It should only count the number of enabled redistributors, but it
> also tries to sanity check the GICC entry, currently returning an
> error if the Enabled bit is set, but the gicr_base_address is zero.
> 
> Adding support for the online-capable bit to the sanity check will
> complicate it, for no benefit. The existing check implicitly depends on
> gic_acpi_count_gicr_regions() previous failing to find any GICR regions
> (as it is valid to have gicr_base_address of zero if the redistributors
> are described via a GICR entry).
> 
> Instead of complicating the check, remove it. Failures that happen at
> this point cause the irqchip not to register, meaning no irqs can be
> requested. The kernel grinds to a panic() pretty quickly.
> 
> Without the check, MADT tables that exhibit this problem are still
> caught by gic_populate_rdist(), which helpfully also prints what went
> wrong:
> | CPU4: mpidr 100 has no re-distributor!
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Sorry. I managed not to pick up Marc's RB form v8 and this patch is unchanged.
https://lore.kernel.org/all/87jzkktaui.wl-maz@kernel.org/

Hopefully whoever picks this up is using tooling (b4 or similar) that will get it from
here.

Reviewed-by: Marc Zyngier <maz@kernel.org>

So just patch 14 waiting for Marc to take another glance.


> ---
>  drivers/irqchip/irq-gic-v3.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 6fb276504bcc..10af15f93d4d 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -2415,19 +2415,10 @@ static int __init gic_acpi_match_gicc(union acpi_subtable_headers *header,
>  	 * If GICC is enabled and has valid gicr base address, then it means
>  	 * GICR base is presented via GICC
>  	 */
> -	if (acpi_gicc_is_usable(gicc) && gicc->gicr_base_address) {
> +	if (acpi_gicc_is_usable(gicc) && gicc->gicr_base_address)
>  		acpi_data.enabled_rdists++;
> -		return 0;
> -	}
>  
> -	/*
> -	 * It's perfectly valid firmware can pass disabled GICC entry, driver
> -	 * should not treat as errors, skip the entry instead of probe fail.
> -	 */
> -	if (!acpi_gicc_is_usable(gicc))
> -		return 0;
> -
> -	return -ENODEV;
> +	return 0;
>  }
>  
>  static int __init gic_acpi_count_gicr_regions(void)


