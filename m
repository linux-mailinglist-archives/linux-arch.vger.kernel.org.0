Return-Path: <linux-arch+bounces-5966-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE49947750
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 10:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392331F218CF
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 08:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE96B14B966;
	Mon,  5 Aug 2024 08:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="h0enI0Nz"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696156BFB5;
	Mon,  5 Aug 2024 08:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722846626; cv=none; b=oH3qpJVIudQQ6Uk5goRn/xaOowkpZlzBSQxqqZLB8RNrmmM2GV0EK4T5tzEXCP4O/1KQF45sVLcLH8S+2M5VmB8+pyug8qne4DxXVZ16RIrUH5SH3dgrCkKp1j1GYtOjWaRWhJV7/G7I45QvtTHNReeFZnFaONUav7kt4U/ycCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722846626; c=relaxed/simple;
	bh=89w4/dsEv0i3Cnr8cTwhmNrSeVvE6WWWhRigNFNYrRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVYLiEk9xg4EyPCpTQDs8biA60HeA6+gvp1VBDnBQi85a9q+RKkf/ekr2qEtu6QVEnsxSc/4Hgj8UAQXMaDrgTXTnSd04t6SQEVxRPgy2sG5Ml/yPeIjDYe/T/VAmCH4Sdo0tDrXFtxMoFuh/HW0IAhSVZW4rCtmy0CaiPKZ1JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=h0enI0Nz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id D178320B7123; Mon,  5 Aug 2024 01:30:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D178320B7123
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722846624;
	bh=ZMhkGoAt3nHKrkR3GOV1cGVDXt2ZM4vel/TKh6vKLos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h0enI0Nz5nIJg3QmOqKULmKtzZJVIYwVyeraibFcsUbfMWBOzT++Qlvb6R6RUsgPs
	 sHcn3ukM25Vexlq3W+879tsqLgLdNeFs6RTFxxLc76MvC+QEK45P4R7LNX2r+T3pGZ
	 2xMr1BNCXkrGJ99eRVfRULe4QTOcnV+C6pl5AJAI=
Date: Mon, 5 Aug 2024 01:30:24 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
	catalin.marinas@arm.com, dave.hansen@linux.intel.com,
	decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
	kw@linux.com, kys@microsoft.com, lenb@kernel.org,
	lpieralisi@kernel.org, mingo@redhat.com, rafael@kernel.org,
	robh@kernel.org, tglx@linutronix.de, wei.liu@kernel.org,
	will@kernel.org, linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
	benhill@microsoft.com, ssengar@microsoft.com,
	sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v3 6/7] Drivers: hv: vmbus: Get the IRQ number from DT
Message-ID: <20240805083024.GB31897@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-7-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726225910.1912537-7-romank@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Jul 26, 2024 at 03:59:09PM -0700, Roman Kisel wrote:
> The VMBus driver uses ACPI for interrupt assignment on
> arm64 hence it won't function in the VTL mode where only
> DeviceTree can be used.
> 
> Update the VMBus driver to discover interrupt configuration
> via DeviceTree and indicate DMA cache coherency.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 49 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 12a707ab73f8..7eee7caff5f6 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2306,6 +2306,34 @@ static int vmbus_acpi_add(struct platform_device *pdev)
>  }
>  #endif
>  
> +static int __maybe_unused vmbus_set_irq(struct platform_device *pdev)
> +{
> +	struct irq_desc *desc;
> +	int irq;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq == 0) {
> +		pr_err("VMBus interrupt mapping failure\n");
> +		return -EINVAL;
> +	}
> +	if (irq < 0) {
> +		pr_err("VMBus interrupt data can't be read from DeviceTree, error %d\n", irq);
> +		return irq;
> +	}
> +
> +	desc = irq_to_desc(irq);

irq_to_desc is not an exported symbol if CONFIG_SPARSE_IRQ is enabled. This will
break the builds for HYPERV as module.

- Saurabh

