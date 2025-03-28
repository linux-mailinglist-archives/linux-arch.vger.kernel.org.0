Return-Path: <linux-arch+bounces-11174-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79841A74352
	for <lists+linux-arch@lfdr.de>; Fri, 28 Mar 2025 06:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A563AD5EF
	for <lists+linux-arch@lfdr.de>; Fri, 28 Mar 2025 05:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FE31FF7D8;
	Fri, 28 Mar 2025 05:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ko7P85Wj"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EAE28373;
	Fri, 28 Mar 2025 05:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743139652; cv=none; b=ImVjVPWgZVUwVksdDzjmuu+Z6z+CWuwllkoiYaqslIEI5M1/kqOqninu3ZDm3swvHTL5134FTVXzfBcemMl5NBg6z6ndBZS5EYKNRp9Y8nrnDlKlMwLFL4sQoksAwf48mCTDt4RuUTrkpSkwoJVAJsYa4jXOXfYtMUcHP4rJahM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743139652; c=relaxed/simple;
	bh=/9CFKDl82EzxqmY+0eTCnlyT5HwDG+k1q37M983nkv0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lbaX6wFqnp1Kyi2awkfzcZIhfrtwmZclBNH9Iia0ZAsdlSXb0a+0B+yHFvXEaiHxm7RfhVQyzNs1h7RkSIKSwyM85KRWojOFbaP57ydTzRcxPPVSF7aM5Fvg9NzySfanuH4QfT+rnx20KOTO6bvBRvkkcimc/93sOtkNGmiyVnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ko7P85Wj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D39CC4CEE4;
	Fri, 28 Mar 2025 05:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743139652;
	bh=/9CFKDl82EzxqmY+0eTCnlyT5HwDG+k1q37M983nkv0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ko7P85WjkjfQMEAqtP1kzs8nHDBITIf5T45w3FZqKEmEZdRXku1tsxkW/Z7BJXEqO
	 iELw7LVttx8jxmToZxpl53rzOipavPZHmVrnjQgouwVU+OGgFkV5r0IQ4Mevw7dUXG
	 YM7v3sqSXdP0/C5teDZ8oa8m/ciErxnFuyRAyXM0+eDn8ADlawSnE+auzyTFAhLm1j
	 wK1yG1o86aTVhJv74gdGSZ+7dx0UwEWo0A0JUWOuH7Z3ODGRqqM+YcbRFrShJJLH6g
	 uS6D+1sc05VH+gOOo19ED5dldgJwUJSCUHcu17Zv8mnT29TMNaS5xMNb4mbUfrb13C
	 KwDiHe7mEKdCg==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>, x86@kernel.org
Cc: kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
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
	AXu Yilun <yilun.xu@linux.intel.com>,
	Alexey Kardashevskiy <aik@amd.com>
Subject: Re: [RFC PATCH v2 14/22] iommufd: Add TIO calls
In-Reply-To: <20250218111017.491719-15-aik@amd.com>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com>
Date: Fri, 28 Mar 2025 10:57:18 +0530
Message-ID: <yq5av7rt7mix.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexey Kardashevskiy <aik@amd.com> writes:

....

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
> +	if (IS_ERR(viommu))
> +		return PTR_ERR(viommu);
>

Would this require an IOMMU_HWPT_ALLOC_NEST_PARENT page table
allocation? How would this work in cases where there's no need to set up
Stage 1 IOMMU tables?

Alternatively, should we allocate an IOMMU_HWPT_ALLOC_NEST_PARENT with a
Stage 1 disabled translation config? (In the ARM case, this could mean
marking STE entries as Stage 1 bypass and Stage 2 translate.)

Also, if a particular setup doesn't require creating IOMMU
entries because the entire guest RAM is identity-mapped in the IOMMU, do
we still need to make tsm_tdi_bind use this abstraction in iommufd?


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
> +		rc = PTR_ERR(idev);
> +		goto out_put_dev;
> +	}
> +
> +	tdi = tsm_tdi_get(idev->dev);
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

-aneesh

