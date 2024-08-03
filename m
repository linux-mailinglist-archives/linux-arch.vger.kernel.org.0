Return-Path: <linux-arch+bounces-5947-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74039466A5
	for <lists+linux-arch@lfdr.de>; Sat,  3 Aug 2024 03:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625FB28261E
	for <lists+linux-arch@lfdr.de>; Sat,  3 Aug 2024 01:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D731F4A32;
	Sat,  3 Aug 2024 01:21:03 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B3C63A9;
	Sat,  3 Aug 2024 01:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722648063; cv=none; b=DcmqSDgNTMejIIpHDBz/LhiiKJOqR/kxLbfd8xRLYMVBq4GgOnNftb5vBxjO1VByaKB5W7jWk2YYJErZZ7XsJoUvMx7V96emqOooprQAqI4umwaZOXcuUTrSHbMeSZRUgbhKy6/Er2eRm4sUKLMKRF3bkGkcyd7EF8VLmIInhfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722648063; c=relaxed/simple;
	bh=oEAO0LgkYP9rczh1sSRCG+VW1RMEXo+f+xqob+rZ3xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVee9OVdQgvHRDFQvDGRDjiVQ7fS7vqvsQLIhXeJBiki1gwAGnkTp0Qc26WWsNf01WKifcouP3zU8/te0QS+sNOF4JgoYNrGFTZIGvVqtTWR/taFxQ41LBL+FOxeqcalw/E38CbZa7dPaKQxorgJIPFgiInbrwINBObDEcsaUeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cd2f89825fso6129873a91.1;
        Fri, 02 Aug 2024 18:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722648061; x=1723252861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mn6019YORpOIN4p+uI+hS2FuSm00+ndoCRPl9w+srXE=;
        b=mE8LW/6PxB0xoXPQCmP6yH8S4DE3xZtkTKFMd0oA7hg/pl4qMKFlgfuM7FN/lPSxwj
         N2D1QyDjv3mMV2kdyoHFYmP2i2GHxM9EcYp/Rgp2q+QGJ1hZWX75vkL25BCw9ENl0Q+6
         U9b0t6Q8oLD+2afmlT1hGc21lM8zpPaleeZtFjF3GR6QWlJHwKYe5OcdVfumxak0ZT6Y
         O2tOHSBzaGbYZUTdMQhZltXgIS88BhmucPyy753zkKQgJafqkIcCdrgqMpDOjXZO0DuG
         U55oFSwc/lvMcNnFyKCE/ZTYbmmOIxwgk2+UpMZqgfLQDkHfjlcDsaBkOn6Fv1yAn4V1
         kk0w==
X-Forwarded-Encrypted: i=1; AJvYcCVGsALTIISONFPf5FOeOYj966Pjdh8ymZKEnzmsQjRgjSY1uTJQKQNKEly+OCaiCJhuNFjcPIocHZD8WhCWm8UH2bA/1DRulSpPisHWRWeXoQziy/63jM134E0tbX6XcJZbq+l+8/+JYSITp+xVd2rL+XZc0BocFeEzFnIJsYHZjlLRBeTzjjKM1XEEtJLlg49pZQ8TnSvglWWzZCSbQz/uHFOf3NILJIkm/h7BQLKC/A7hlfl7Esxqzq6L1Po=
X-Gm-Message-State: AOJu0YwIfKMy/lKHT5dxauowVFaoU7FgnoWIw33UJO1auK8Cmkfs/uth
	BRqPfRBSxJge+4VX2owrRKbPFj88Tb3RYGVwy9TDYVlGmyqXXNNI
X-Google-Smtp-Source: AGHT+IGcypEO6f2Pzk3wUXNz0LUEZUBSbjvtENiURYxWYOfgVYejP9sulcneRglr4VAxIUSiI4HadA==
X-Received: by 2002:a17:90a:fc92:b0:2c9:6b02:15ca with SMTP id 98e67ed59e1d1-2cff9544e21mr6464426a91.39.1722648061281;
        Fri, 02 Aug 2024 18:21:01 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfca2a2af6sm4671139a91.0.2024.08.02.18.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 18:21:00 -0700 (PDT)
Date: Sat, 3 Aug 2024 01:20:58 +0000
From: Wei Liu <wei.liu@kernel.org>
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
Subject: Re: [PATCH v3 7/7] PCI: hv: Get vPCI MSI IRQ domain from DT
Message-ID: <Zq2F-l2FWIrQ2Jt1@liuwe-devbox-debian-v2>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-8-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726225910.1912537-8-romank@linux.microsoft.com>

On Fri, Jul 26, 2024 at 03:59:10PM -0700, Roman Kisel wrote:
> The hyperv-pci driver uses ACPI for MSI IRQ domain configuration on
> arm64. It won't be able to do that in the VTL mode where only DeviceTree
> can be used.
> 
> Update the hyperv-pci driver to get vPCI MSI IRQ domain in the DeviceTree
> case, too.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c              | 23 +++++++-----
>  drivers/pci/controller/pci-hyperv.c | 55 +++++++++++++++++++++++++++--
>  include/linux/hyperv.h              |  2 ++
>  3 files changed, 69 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 7eee7caff5f6..038bd9be64b7 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -45,7 +45,8 @@ struct vmbus_dynid {
>  	struct hv_vmbus_device_id id;
>  };
>  
> -static struct device  *hv_dev;
> +/* VMBus Root Device */
> +static struct device  *vmbus_root_device;

You're changing the name of the variable. That should preferably be done
in a separate patch. That's going to make this patch shorter and easier
to review.

>  
>  static int hyperv_cpuhp_online;
>  
> @@ -80,9 +81,15 @@ static struct resource *fb_mmio;
>  static struct resource *hyperv_mmio;
>  static DEFINE_MUTEX(hyperv_mmio_lock);
>  
> +struct device *get_vmbus_root_device(void)
> +{
> +	return vmbus_root_device;
> +}
> +EXPORT_SYMBOL_GPL(get_vmbus_root_device);

I would like you to add "hv_" prefix to this exported symbol, or rename
it to "vmbus_get_root_device()".

> +
>  static int vmbus_exists(void)
>  {
> -	if (hv_dev == NULL)
> +	if (vmbus_root_device == NULL)
>  		return -ENODEV;
>  
>  	return 0;
> @@ -861,7 +868,7 @@ static int vmbus_dma_configure(struct device *child_device)
>  	 * On x86/x64 coherence is assumed and these calls have no effect.
>  	 */
>  	hv_setup_dma_ops(child_device,
> -		device_get_dma_attr(hv_dev) == DEV_DMA_COHERENT);
> +		device_get_dma_attr(vmbus_root_device) == DEV_DMA_COHERENT);
>  	return 0;
>  }
>  
> @@ -1892,7 +1899,7 @@ int vmbus_device_register(struct hv_device *child_device_obj)
>  		     &child_device_obj->channel->offermsg.offer.if_instance);
>  
>  	child_device_obj->device.bus = &hv_bus;
> -	child_device_obj->device.parent = hv_dev;
> +	child_device_obj->device.parent = vmbus_root_device;
>  	child_device_obj->device.release = vmbus_device_release;
>  
>  	child_device_obj->device.dma_parms = &child_device_obj->dma_parms;
> @@ -2253,7 +2260,7 @@ static int vmbus_acpi_add(struct platform_device *pdev)
>  	struct acpi_device *ancestor;
>  	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
>  
> -	hv_dev = &device->dev;
> +	vmbus_root_device = &device->dev;
>  
>  	/*
>  	 * Older versions of Hyper-V for ARM64 fail to include the _CCA
> @@ -2342,7 +2349,7 @@ static int vmbus_device_add(struct platform_device *pdev)
>  	struct device_node *np = pdev->dev.of_node;
>  	int ret;
>  
> -	hv_dev = &pdev->dev;
> +	vmbus_root_device = &pdev->dev;
>  
>  	ret = of_range_parser_init(&parser, np);
>  	if (ret)
> @@ -2675,7 +2682,7 @@ static int __init hv_acpi_init(void)
>  	if (ret)
>  		return ret;
>  
> -	if (!hv_dev) {
> +	if (!vmbus_root_device) {
>  		ret = -ENODEV;
>  		goto cleanup;
>  	}
> @@ -2706,7 +2713,7 @@ static int __init hv_acpi_init(void)
>  
>  cleanup:
>  	platform_driver_unregister(&vmbus_platform_driver);
> -	hv_dev = NULL;
> +	vmbus_root_device = NULL;
>  	return ret;
>  }
>  
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 5992280e8110..cdecefd1f9bd 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -50,6 +50,7 @@
>  #include <linux/irqdomain.h>
>  #include <linux/acpi.h>
>  #include <linux/sizes.h>
> +#include <linux/of_irq.h>
>  #include <asm/mshyperv.h>
>  
>  /*
> @@ -887,6 +888,35 @@ static const struct irq_domain_ops hv_pci_domain_ops = {
>  	.activate = hv_pci_vec_irq_domain_activate,
>  };
>  
> +#ifdef CONFIG_OF
> +
> +static struct irq_domain *hv_pci_of_irq_domain_parent(void)
> +{
> +	struct device_node *parent;
> +	struct irq_domain *domain;
> +
> +	parent = of_irq_find_parent(to_platform_device(get_vmbus_root_device())->dev.of_node);
> +	domain = NULL;
> +	if (parent) {
> +		domain = irq_find_host(parent);
> +		of_node_put(parent);
> +	}
> +

I cannot really comment on the ARM side of things around how this system
is set up. I will leave that to someone who's more familiar with the
matter to review.

Thanks,
Wei.

