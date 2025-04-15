Return-Path: <linux-arch+bounces-11411-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC4DA8A906
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 22:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3C13B96D5
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 20:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEE0254B02;
	Tue, 15 Apr 2025 20:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jO/DDpLU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3A72528E1;
	Tue, 15 Apr 2025 20:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744748149; cv=none; b=hidYTTX5EP3hUVgFnKyUhp2VcZp4qNxO/jQmmMQTVbu07VOn7Guh6dF03Lby+2foH61Ppx3Mo4GEp/pf8zM0GJNgFEsO7OA75I3y07wCn+J4sfWomgDIepH/Qbu5BZfongJ2FQD03/AIx/89qSoxT4o8zTXcGQtOvn4F8ZAC+To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744748149; c=relaxed/simple;
	bh=QwTJf9GxpIvIfOhFYaJO6b+nTXK1Pmo5iQcJ/GI9BGU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YZTt/xE+NXDYaMT5J3DSekk+0gTaL8EP2mUSc254er92PqVnVV71hvFa7YVOVGSygEHSXe1mkiXibVfr54HOUBVycuGe7fBuTm9WPUDQRt4Gd/LTc3yq6nOwF4H9tB//vekIp8dgg3NVsgL4G/sLDDVrL/aJSlPTKyngZvFSl3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jO/DDpLU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857C9C4CEE7;
	Tue, 15 Apr 2025 20:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744748148;
	bh=QwTJf9GxpIvIfOhFYaJO6b+nTXK1Pmo5iQcJ/GI9BGU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jO/DDpLUw6lPmlvlhtrDhoKnokaxjzDFG0GJx6h2ALJm1U5w8n3wIIl6Mghx/t08C
	 YMkwUzvfYvZrMgehfXIZy9SbH4VdhGrgSQmg4r7pXhv2fCRdUZ4z2YZus6I8xxJhqV
	 YfR4KWoBRxqn5uOoOEXKA4lHgTsfTNqW13PaHhn3EGg3kN+K+pJPsDFhZgySRsv5u0
	 mWvFdU+STmgqRcOr47AOm/uU+FKrotrmwcAVZr6dUqqy/sAR7Bl87PDPViPgbbpMxy
	 9ccn8ebL8nU82lVjDkDyxwqebwgnK2ZGFbWq8QQsNdcMDxVm+2X8L1wUDLPXD7EcSs
	 jrM0MLUteVC6g==
Date: Tue, 15 Apr 2025 15:15:47 -0500
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
Subject: Re: [RFC PATCH v2 01/22] pci/doe: Define protocol types and make
 those public
Message-ID: <20250415201547.GA32736@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218111017.491719-2-aik@amd.com>

Match capitalization of subject from previous history.

On Tue, Feb 18, 2025 at 10:09:48PM +1100, Alexey Kardashevskiy wrote:
> Already public pci_doe() takes a protocol type argument.
> PCIe 6.0 defines three, define them in a header for use with pci_doe().

Add section number to spec reference, rewrap paragraph to fill 75
columns.

Bjorn

