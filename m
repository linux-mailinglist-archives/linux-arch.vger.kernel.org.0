Return-Path: <linux-arch+bounces-1087-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA22814D27
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 17:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435F31F21304
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 16:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2253EA68;
	Fri, 15 Dec 2023 16:33:08 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ADF3FE45;
	Fri, 15 Dec 2023 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SsF9T2nGtz6J9hQ;
	Sat, 16 Dec 2023 00:31:57 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 20C23140390;
	Sat, 16 Dec 2023 00:33:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Dec
 2023 16:33:02 +0000
Date: Fri, 15 Dec 2023 16:33:01 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
CC: <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, <acpica-devel@lists.linuxfoundation.org>,
	<linux-csky@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-ia64@vger.kernel.org>, <linux-parisc@vger.kernel.org>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	<jianyong.wu@arm.com>, <justin.he@arm.com>, James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 14/21] irqchip/gic-v3: Don't return errors from
 gic_acpi_match_gicc()
Message-ID: <20231215163301.0000183a@Huawei.com>
In-Reply-To: <E1rDOgx-00Dvkv-Bb@rmk-PC.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
	<E1rDOgx-00Dvkv-Bb@rmk-PC.armlinux.org.uk>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 13 Dec 2023 12:50:23 +0000
Russell King (Oracle) <rmk+kernel@armlinux.org.uk> wrote:

> From: James Morse <james.morse@arm.com>
> 
> gic_acpi_match_gicc() is only called via gic_acpi_count_gicr_regions().
> It should only count the number of enabled redistributors, but it
> also tries to sanity check the GICC entry, currently returning an
> error if the Enabled bit is set, but the gicr_base_address is zero.
> 
> Adding support for the online-capable bit to the sanity check
> complicates it, for no benefit. The existing check implicitly
> depends on gic_acpi_count_gicr_regions() previous failing to find
> any GICR regions (as it is valid to have gicr_base_address of zero if
> the redistributors are described via a GICR entry).
> 
> Instead of complicating the check, remove it. Failures that happen
> at this point cause the irqchip not to register, meaning no irqs
> can be requested. The kernel grinds to a panic() pretty quickly.
> 
> Without the check, MADT tables that exhibit this problem are still
> caught by gic_populate_rdist(), which helpfully also prints what
> went wrong:
> | CPU4: mpidr 100 has no re-distributor!
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/irqchip/irq-gic-v3.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 98b0329b7154..ebecd4546830 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -2420,21 +2420,15 @@ static int __init gic_acpi_match_gicc(union acpi_subtable_headers *header,
>  
>  	/*
>  	 * If GICC is enabled and has valid gicr base address, then it means
> -	 * GICR base is presented via GICC
> +	 * GICR base is presented via GICC. The redistributor is only known to
> +	 * be accessible if the GICC is marked as enabled. If this bit is not
> +	 * set, we'd need to add the redistributor at runtime, which isn't
> +	 * supported.
>  	 */
> -	if (acpi_gicc_is_usable(gicc) && gicc->gicr_base_address) {
> +	if (gicc->flags & ACPI_MADT_ENABLED && gicc->gicr_base_address)

I was very vague in previous review.  I think the reasons you are switching
from acpi_gicc_is_useable(gicc) to the gicc->flags & ACPI_MADT_ENABLED
needs calling out as I'm fairly sure that this point in the series at least
acpi_gicc_is_usable is same as current upstream:

static inline bool acpi_gicc_is_usable(struct acpi_madt_generic_interrupt *gicc)
{
	return gicc->flags & ACPI_MADT_ENABLED;
}

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


