Return-Path: <linux-arch+bounces-11412-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3845EA8A936
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 22:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82825189FBAA
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 20:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3974A2528E5;
	Tue, 15 Apr 2025 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbSgroWI"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E2924FC0D;
	Tue, 15 Apr 2025 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744748715; cv=none; b=s8NDIcCDPtS0zTpSlUTMhBASvQcLDkfRU++mXwOfKpXIAfUYCh4AHW/PYYyF1ybPs99Yjm00dtuLz3A9Ryh97islLlYXdREUttMyq5qdW698xGI6Jtk7cWNWIzmm0Pjvc3Rqi19KzkzI/CIYNyw1JPR/VzCOYcv2po89UYXrFRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744748715; c=relaxed/simple;
	bh=qBiIAnLYVgpmhBqfYZeLFMQbNfBn0ew0H6zvUUS7d7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KPpjbKZ1mmG4veKsNVJLnAOGkTeUkrYyUsyPwvIcoRO3F7xyLf/1iYP8JVM+X/unBIhvPoJLwiVC4ja1KOxzz+OR5PYOq0+8Gye7PTQ66e+ZDRYSMKg6Mhkfux4e0jUpGNzUUmI3gmT4KKvz707GOwb3IdGo8lQkE2Joq1qbpCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbSgroWI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410FFC4CEE7;
	Tue, 15 Apr 2025 20:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744748714;
	bh=qBiIAnLYVgpmhBqfYZeLFMQbNfBn0ew0H6zvUUS7d7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dbSgroWISwNnywfE78dGo4Jdk32uQASB63kxLMUE9l+s6nlognW8gbMCiG/kljbk2
	 VJAsIer0Hpj3xGLmTWBemAc2S5H/rXs5zhW+YNqw4enNGQY5Na03zr0w6j0iaIRsh4
	 qtoJdKINifKVpDXO6+aPGfb+DH1pxBcJZ7XzhLXcMu3yL4g/Q2Uyg7rZTllYGYsGPt
	 NxCNqRce2XKRjD+cMTk9A+wsDfVXuUd2ZZKVELCvD9Eor/Ed9nCqPAalV1mX+B3adY
	 lRBOi56jnHC+eTXjFf5e7jRoEzLg+dx+bRm1pW57PmHL6x8v+BsQi36GXarTSzMzVZ
	 m6/nFEyYnxFWA==
Date: Tue, 15 Apr 2025 15:25:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Christoph Hellwig <hch@lst.de>, Nikunj A Dadhania <nikunj@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Dionna Glaze <dionnaglaze@google.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-coco@lists.linux.dev,
	Zhi Wang <zhiw@nvidia.com>, AXu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v2 08/22] pci/tsm: Add PCI driver for TSM
Message-ID: <20250415202512.GA32830@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218111017.491719-9-aik@amd.com>

Match subject capitalization style of history.

Drop second "PCI", mostly redundant.

On Tue, Feb 18, 2025 at 10:09:55PM +1100, Alexey Kardashevskiy wrote:
> The PCI TSM module scans the PCI bus to initialize a TSM context for
> physical ("TDEV") and virtual ("TDI") functions. It also implements
> bus operations which at the moment is just an SPDM bouncer which talks
> to the PF's DOE mailboxes.

Expand "TSM" once here and maybe in the subject.

> + * Copyright(c) 2024 Intel Corporation. All rights reserved.

2025 now.

> +static int tsm_pci_dev_init(struct tsm_bus_subsys *tsm_bus,
> +			    struct pci_dev *pdev,
> +			    struct tsm_dev **ptdev)
> +{
> +	struct tsm_pci_dev_data *tdata;
> +	int ret = tsm_dev_init(tsm_bus, &pdev->dev, sizeof(*tdata), ptdev);

Move the tsm_dev_init() out of the automatic variable list.  Doing it
in the list is OK for trivial things, but this is kind of the meat of
the function.

> +	if (ret)
> +		return ret;
> +
> +	tdata = tsm_dev_to_bdata(*ptdev);
> +
> +	tdata->doe_mb = pci_find_doe_mailbox(pdev,
> +					     PCI_VENDOR_ID_PCI_SIG,
> +					     PCI_DOE_PROTOCOL_CMA_SPDM);
> +	tdata->doe_mb_sec = pci_find_doe_mailbox(pdev,
> +						 PCI_VENDOR_ID_PCI_SIG,
> +						 PCI_DOE_PROTOCOL_SECURED_CMA_SPDM);
> +
> +	if (tdata->doe_mb || tdata->doe_mb_sec)
> +		pci_notice(pdev, "DOE SPDM=%s SecuredSPDM=%s\n",
> +			   tdata->doe_mb ? "yes":"no", tdata->doe_mb_sec ? "yes":"no");
> +
> +	return ret;
> +}

> +
> +static int tsm_pci_alloc_device(struct tsm_bus_subsys *tsm_bus,
> +				struct pci_dev *pdev)
> +{
> +	int ret = 0;

Unnecessary initialization.

> +	/* Set up TDIs for HV (physical functions) and VM (all functions) */
> +	if ((pdev->devcap & PCI_EXP_DEVCAP_TEE) &&
> +	    (((pdev->is_physfn && (PCI_FUNC(pdev->devfn) == 0)) ||
> +	      (!pdev->is_physfn && !pdev->is_virtfn)))) {
> +
> +		struct tsm_dev *tdev = NULL;
> +
> +		if (!is_physical_endpoint(pdev))
> +			return 0;
> +
> +		ret = tsm_pci_dev_init(tsm_bus, pdev, &tdev);
> +		if (ret)
> +			return ret;
> +
> +		ret = tsm_tdi_init(tdev, &pdev->dev);
> +		tsm_dev_put(tdev);
> +		return ret;
> +	}
> +
> +	/* Set up TDIs for HV (virtual functions), should do nothing in VMs */
> +	if (pdev->is_virtfn) {
> +		struct pci_dev *pf0 = pci_get_slot(pdev->physfn->bus,
> +						   pdev->physfn->devfn & ~7);
> +
> +		if (pf0 && (pf0->devcap & PCI_EXP_DEVCAP_TEE)) {
> +			struct tsm_dev *tdev = tsm_dev_get(&pf0->dev);
> +
> +			if (!is_endpoint(pdev))
> +				return 0;
> +
> +			ret = tsm_tdi_init(tdev, &pdev->dev);
> +			tsm_dev_put(tdev);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}

> +
> +static void tsm_pci_dev_free(struct pci_dev *pdev)
> +{
> +	struct tsm_tdi *tdi = tsm_tdi_get(&pdev->dev);
> +
> +	if (tdi) {
> +		tsm_tdi_put(tdi);
> +		tsm_tdi_free(tdi);
> +	}
> +
> +	struct tsm_dev *tdev = tsm_dev_get(&pdev->dev);

Move at least the declaration to automatic list at entry.

> +	if (tdev) {
> +		tsm_dev_put(tdev);
> +		tsm_dev_free(tdev);
> +	}
> +
> +	WARN_ON(!tdi && tdev);
> +}
> +
> +static int tsm_pci_bus_notifier(struct notifier_block *nb, unsigned long action, void *data)

Wrap to fit in 80 columns like the rest of drivers/pci/

> +{
> +	struct tsm_bus_subsys *tsm_bus = container_of(nb, struct tsm_bus_subsys, notifier);
> +
> +	switch (action) {
> +	case BUS_NOTIFY_ADD_DEVICE:
> +		tsm_pci_alloc_device(tsm_bus, to_pci_dev(data));
> +		break;
> +	case BUS_NOTIFY_DEL_DEVICE:
> +		tsm_pci_dev_free(to_pci_dev(data));
> +		break;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +struct tsm_bus_subsys *pci_tsm_register(struct tsm_subsys *tsm)
> +{
> +	struct tsm_bus_subsys *tsm_bus = kzalloc(sizeof(*tsm_bus), GFP_KERNEL);
> +	struct pci_dev *pdev = NULL;
> +
> +	pr_info("Scan TSM PCI\n");
> +	tsm_bus->ops = &tsm_pci_ops;
> +	tsm_bus->tsm = tsm;
> +	tsm_bus->notifier.notifier_call = tsm_pci_bus_notifier;
> +	for_each_pci_dev(pdev)
> +		tsm_pci_alloc_device(tsm_bus, pdev);
> +	bus_register_notifier(&pci_bus_type, &tsm_bus->notifier);

Looks racy that we iterate through PCI devs before registering the
notifier.

> +	return tsm_bus;
> +}

> +static int __init tsm_pci_init(void)
> +{
> +	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
> +	return 0;
> +}
> +
> +static void __exit tsm_pci_cleanup(void)
> +{
> +	pr_info(DRIVER_DESC " version: " DRIVER_VERSION " unload\n");

Both init and cleanup messages are OK for debug, but probably not for
upstream.

> +config PCI_TSM
> +	tristate "TEE Security Manager for PCI Device Security"
> +	select PCI_IDE
> +	depends on TSM
> +	default m
> +	help
> +	  The TEE (Trusted Execution Environment) Device Interface
> +	  Security Protocol (TDISP) defines a "TSM" as a platform agent

Expand "TSM" here.  From menu line above, I guess it's "TEE Security
Manager"?

> +	  that manages device authentication, link encryption, link
> +	  integrity protection, and assignment of PCI device functions
> +	  (virtual or physical) to confidential computing VMs that can
> +	  access (DMA) guest private memory.
> +
> +	  Enable a platform TSM driver to use this capability.
> +
>  config PCI_DOE
>  	bool
>  
> -- 
> 2.47.1
> 

