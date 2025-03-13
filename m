Return-Path: <linux-arch+bounces-10704-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0117FA5F1C8
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 12:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDEED188B97F
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 11:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A388265CC7;
	Thu, 13 Mar 2025 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bu+a/iHj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0DC1EF084;
	Thu, 13 Mar 2025 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741863830; cv=none; b=F62oxT/5hpH8PA18hjOW5To0ozflX2yH+PPynBmoPS6GTGS1hdT26e6KHuxY/Biy0/zIW2IpIYU72Ot/vsIm38uKeK7MhLMFHzG68cX5OuRDBLTEok7RYphgNd0V5wfQ2dK/0gSOmjIdQmZaYKxe1usrWDBt5nQ6Y45l+qzFEXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741863830; c=relaxed/simple;
	bh=PRm49VmHjxWTEv5l+Jj3Z5fYyVs179E0dso2MnFLV8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uh6VOSLAjwZrRjwr7hJBv/QHuNJ4n0atLGgFH4nEEtPsWA3AM8tPOasrTIfkVD+WNcyPcz6Td1X9KdAdfcYFFrRfGp/un+i3Rafjo3Id2z9jf6TWl5TRrmJiDRDG5NVdf/L3IVzqnbNR7ilzC1g0XjLLsS6ohLopQhEx/P7+NLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bu+a/iHj; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741863830; x=1773399830;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PRm49VmHjxWTEv5l+Jj3Z5fYyVs179E0dso2MnFLV8g=;
  b=Bu+a/iHjaxv6aq/ERCMb7HUyNC8LskCA5J1Qwx43aK9CBSwz+oKPzWBI
   lV/Tu2j5lCSfYyPW8ducbEdHtVc5mtx+tQjlj42kX3l1QYZ7+RxvL7UDu
   N5B81yfgf5nqy54lm47fcRBptgQz4mqqUbvMoY8+8f/pnO5T/NyALzEy1
   GpuN7i620LbVZh768CV6OAtAdFG+uo087Iy+L98K/er3Yinsgp3n2Roh3
   szmDFo2kzr65qA4uLft/At6eewqeL6S1wUtQ1W/sm21Qav8idDst9WHxu
   aw8cLY0WGBMz8sBNPSSO1Q1AUQM6h04SwuzpWwbE8z+FACvZdwQxp2HHo
   Q==;
X-CSE-ConnectionGUID: 7Tsr1VKUQu6MehpV1MvHiA==
X-CSE-MsgGUID: +ceLFAgxR8Cjjl22rBNHug==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42880217"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42880217"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 04:03:49 -0700
X-CSE-ConnectionGUID: Qsefzw/4RSOyJmWwfTvfZQ==
X-CSE-MsgGUID: c60qU6WUQcmlcM/iLDH6CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="120881485"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa010.jf.intel.com with ESMTP; 13 Mar 2025 04:03:41 -0700
Date: Thu, 13 Mar 2025 19:01:06 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
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
	Zhi Wang <zhiw@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v2 14/22] iommufd: Add TIO calls
Message-ID: <Z9K68m8iq3cDXShL@yilunxu-OptiPlex-7050>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218111017.491719-15-aik@amd.com>

> +int iommufd_vdevice_tsm_bind_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_vdevice_tsm_bind *cmd = ucmd->cmd;
> +	struct iommufd_viommu *viommu;
> +	struct iommufd_vdevice *vdev;
> +	struct iommufd_device *idev;
> +	struct tsm_tdi *tdi;
> +	int rc = 0;
> +
> +	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);

Why need user to input viommu_id? And why get viommu here?
The viommu is always available after vdevice is allocated, is it?

int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
{
	...

	vdev->viommu = viommu;
	refcount_inc(&viommu->obj.users);
	...
}

> +	if (IS_ERR(viommu))
> +		return PTR_ERR(viommu);
> +
> +	idev = iommufd_get_device(ucmd, cmd->dev_id);
> +	if (IS_ERR(idev)) {
> +		rc = PTR_ERR(idev);
> +		goto out_put_viommu;
> +	}
> +
> +	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
> +					       IOMMUFD_OBJ_VDEVICE),
> +			    struct iommufd_vdevice, obj);
> +	if (IS_ERR(idev)) {
                   ^
vdev?

> +		rc = PTR_ERR(idev);
> +		goto out_put_dev;
> +	}
> +
> +	tdi = tsm_tdi_get(idev->dev);

And do we still need dev_id for the struct device *? vdevice also has
this info.

int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
{
        ...
	vdev->dev = idev->dev;
	get_device(idev->dev);
        ...
}


> +	if (!tdi) {
> +		rc = -ENODEV;
> +		goto out_put_vdev;
> +	}
> +
> +	rc = tsm_tdi_bind(tdi, vdev->id, cmd->kvmfd);
> +	if (rc)
> +		goto out_put_tdi;
> +
> +	vdev->tsm_bound = true;
> +
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +out_put_tdi:
> +	tsm_tdi_put(tdi);
> +out_put_vdev:
> +	iommufd_put_object(ucmd->ictx, &vdev->obj);
> +out_put_dev:
> +	iommufd_put_object(ucmd->ictx, &idev->obj);
> +out_put_viommu:
> +	iommufd_put_object(ucmd->ictx, &viommu->obj);
> +	return rc;
> +}

Another concern is do we need an unbind ioctl? We don't bind on vdevice
create so it seems not symmetrical we only unbind on vdevice destroy.

Thanks,
Yilun



