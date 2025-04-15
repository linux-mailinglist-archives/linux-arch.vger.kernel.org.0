Return-Path: <linux-arch+bounces-11413-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB38FA8A94A
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 22:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351351900EBD
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 20:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3186E253F26;
	Tue, 15 Apr 2025 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVgscv+W"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC74253F01;
	Tue, 15 Apr 2025 20:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744748821; cv=none; b=lgkOYhv93dOiCL8O54DGeqVFKSmoM+7DjltL4gdCl7tg1+7cgqCr9s0HYjjG5DOVzlEan1IXqV2S7YtGS2NVyaPHHCwNS7y9Z4lZLBTs9u4t8IjDYzJcvwclxyVu4WARQHkYK144AB44CrBCc9dZUgtaHdQNhPl3XH7Axieb6ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744748821; c=relaxed/simple;
	bh=z+LV6xhDo9Q2ZYHbY+DUAsDNkF4xFWtk8MYflbeADdI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iWR3+wbJzV2StLQ1WaGzx6XycAkqixowX45XsIf86r/XaIzzd3TrqGwZp0PGd03MClNLY06WlEoVbnZd5s3QKNNizZagmAg3a4P0bv81pFlbqteEnQG4X+6E1yxYw0MNFWMQKS3ZOv7m/m+mWTSmHg6HJGzvdkRx9HU0kbUhjsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVgscv+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8D8C4CEE7;
	Tue, 15 Apr 2025 20:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744748820;
	bh=z+LV6xhDo9Q2ZYHbY+DUAsDNkF4xFWtk8MYflbeADdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uVgscv+WmFAtCaKQ4pUzDMBAsYg5NTmdgt8d3mIogBqq7Q3w7l/H+bRPSKbkDrafA
	 gkhVu3wnYvl1bPNbsqOUIdIO95WmLrhiUV+tvavITIX/3t4UzlbrBkLoLZuG5+zvra
	 iHegPdifoFyattVH3FcCMA01vq6jhvXV5Pjt34xpzQ6Xx65pJXk199cyhtW1xBj0wF
	 G09hX0E3JR5bCWxFdrmXvd1p7xV+RhfttXkTOolwD8Hn3t8W2CapGsqt7MHZJ7vtZt
	 HM8XTXeIwNPcYcRyR8mecBrIfrEojxQgvKEIZ7FvGBMOI/IaN43ushhh1UezULV37k
	 Mab6iQYZS8nZA==
Date: Tue, 15 Apr 2025 15:26:58 -0500
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
Subject: Re: [RFC PATCH v2 19/22] RFC: pci: Add BUS_NOTIFY_PCI_BUS_MASTER
 event
Message-ID: <20250415202658.GA33084@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218111017.491719-20-aik@amd.com>

Match subject capitalization style.

On Tue, Feb 18, 2025 at 10:10:06PM +1100, Alexey Kardashevskiy wrote:
> TDISP allows secure MMIO access to a validated MMIO range.
> The validation is done in the TSM and after that point changing
> the device's Memory Space enable (MSE) or Bus Master enable (BME)
> transitions the device into the error state.
> 
> For PCI device drivers which enable MSE, then BME, and then
> start using the device, enabling BME is a logical point to perform
> the MMIO range validation in the TSM.
> 
> Define new event for a bus. TSM is going to listen to it in the TVM
> and do the validation for TEE ranges.
> 
> This does not switch MMIO to private by default though as this is
> for the driver to decide (at least, for now).

Wrap all to fill 75 columns.

