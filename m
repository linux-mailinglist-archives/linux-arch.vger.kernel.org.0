Return-Path: <linux-arch+bounces-11296-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3435CA7DC90
	for <lists+linux-arch@lfdr.de>; Mon,  7 Apr 2025 13:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF975178C72
	for <lists+linux-arch@lfdr.de>; Mon,  7 Apr 2025 11:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB0823ED58;
	Mon,  7 Apr 2025 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihfvx7i3"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5263623E35D;
	Mon,  7 Apr 2025 11:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744026045; cv=none; b=EqLPa82x9t2EdOYNeKHwmdXmJUwwzakSDYNT8J232Kr3pqr4gOCcs2mRchAMstW3cwkgBuxzBXsgntG3dxDU/eQhY/8QsXmL6MpLLHY6R9XbBUokY42g4USdfvwp6YFWlux64z+SbkPIDeRNfHDTt/66bEAFYGqHJCdETYuql54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744026045; c=relaxed/simple;
	bh=vzyAKLHqu3gRIT3XigIACxVJDWJCCNJWkRCnR4vlrpU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iZRrNJQBAXLycI7EFiJyPDwDnDnbAXRvK2I/ah6YjlDh77Jml0hgKRFstpySu9aB+5gb2RyBoDGAYsGNs0jPsoj5AHda+HRt7F9IfXHSEknKbbIr3zPWtyVt6IOr5snXJvvlwKIQs8gVwYPANuAX5CF3tmh7XjduVrXEQL6eSek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihfvx7i3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4031CC4CEDD;
	Mon,  7 Apr 2025 11:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744026044;
	bh=vzyAKLHqu3gRIT3XigIACxVJDWJCCNJWkRCnR4vlrpU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ihfvx7i3hTmS/r04UM0uF1arK6LEBDn5fWytpW7+ZiJsnRDfmKLwJBtzh7PN1XNSI
	 u+znc1IeLnyjRrgKMkjD94YLwDy+wtZLg1H+uqMpTGNke8HlUc2cDCa5sLVuT2YSQg
	 g2RqmcKfRwUpKnWGiNhh9HBrxMujr3oxWEnU1xxJ3WN8RqoFq5oCjQ7Kz+AprXY7CM
	 q9vc4EozkL2+taALxeW3EFGp4AdYg9TZ1OSfRLODymwNydsqrEAhbszSLVr6fWRChT
	 X8u1VlbYEIbqkl82fa1NwmOLeASjXl7YSgiLzOUMPlbythNvreSWcHUrQFYnXsDe+m
	 g9XQKpYvS2tig==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexey Kardashevskiy <aik@amd.com>, x86@kernel.org, kvm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Yi Liu <yi.l.liu@intel.com>, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev, Zhi Wang <zhiw@nvidia.com>,
	AXu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [RFC PATCH v2 14/22] iommufd: Add TIO calls
In-Reply-To: <20250401160340.GK186258@ziepe.ca>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com> <yq5av7rt7mix.fsf@kernel.org>
 <20250401160340.GK186258@ziepe.ca>
Date: Mon, 07 Apr 2025 17:10:29 +0530
Message-ID: <yq5a4iz019oy.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Fri, Mar 28, 2025 at 10:57:18AM +0530, Aneesh Kumar K.V wrote:
>> > +int iommufd_vdevice_tsm_bind_ioctl(struct iommufd_ucmd *ucmd)
>> > +{
>> > +	struct iommu_vdevice_tsm_bind *cmd = ucmd->cmd;
>> > +	struct iommufd_viommu *viommu;
>> > +	struct iommufd_vdevice *vdev;
>> > +	struct iommufd_device *idev;
>> > +	struct tsm_tdi *tdi;
>> > +	int rc = 0;
>> > +
>> > +	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
>> > +	if (IS_ERR(viommu))
>> > +		return PTR_ERR(viommu);
>> >
>> 
>> Would this require an IOMMU_HWPT_ALLOC_NEST_PARENT page table
>> allocation?
>
> Probably. That flag is what forces a S2 page table.
>
>> How would this work in cases where there's no need to set up Stage 1
>> IOMMU tables?
>
> Either attach the raw HWPT of the IOMMU_HWPT_ALLOC_NEST_PARENT or:
>
>> Alternatively, should we allocate an IOMMU_HWPT_ALLOC_NEST_PARENT with a
>> Stage 1 disabled translation config? (In the ARM case, this could mean
>> marking STE entries as Stage 1 bypass and Stage 2 translate.)
>
> For arm you mean IOMMU_HWPT_DATA_ARM_SMMUV3.. But yes, this can work
> too and is mandatory if you want the various viommu linked features to
> work.
>

I was trying to prototype this using kvmtool and I have run into some
issues. First i needed the below change for vIOMMU alloc to work

modified   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4405,6 +4405,8 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR3);
 	if (FIELD_GET(IDR3_RIL, reg))
 		smmu->features |= ARM_SMMU_FEAT_RANGE_INV;
+	if (FIELD_GET(IDR3_FWB, reg))
+		smmu->features |= ARM_SMMU_FEAT_S2FWB;
 
 	/* IDR5 */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR5);



Also current code don't allow a Stage 1 bypass, Stage2 translation when
allocating HWPT.

arm_vsmmu_alloc_domain_nested -> arm_smmu_validate_vste -> 

	cfg = FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(arg->ste[0]));
	if (cfg != STRTAB_STE_0_CFG_ABORT && cfg != STRTAB_STE_0_CFG_BYPASS &&
	    cfg != STRTAB_STE_0_CFG_S1_TRANS)
		return -EIO;


This only allow a abort or bypass or stage1 translate/stage2 bypass config

Also if we don't need stage1 table, what will
iommufd_viommu_alloc_hwpt_nested() return?

>
>> Also, if a particular setup doesn't require creating IOMMU
>> entries because the entire guest RAM is identity-mapped in the IOMMU, do
>> we still need to make tsm_tdi_bind use this abstraction in iommufd?
>
> Even if the viommu will not be exposed to the guest I'm expecting that
> iommufd will have a viommu object, just not use various features. We
> are using viommu as the handle for the KVM, vmid and other things that
> are likely important here.
>
> Jason

-aneesh

