Return-Path: <linux-arch+bounces-11197-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EE6A77FCB
	for <lists+linux-arch@lfdr.de>; Tue,  1 Apr 2025 18:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62D13A45A4
	for <lists+linux-arch@lfdr.de>; Tue,  1 Apr 2025 16:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5143A20C48A;
	Tue,  1 Apr 2025 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VAWPmv2v"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ABC20B1E6
	for <linux-arch@vger.kernel.org>; Tue,  1 Apr 2025 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743523425; cv=none; b=G2aMoPJZnm2R0enI/6zyK6W/EDZdPVV1BsSkdNMbAFCG1Ot0jf4pOtf6WkD70nz65FbOT1vOHZoR4By48k3O8mGKRclN4J3NobfzGV+dqj1foj2XfR1Kk/qfams+Iqk2IDd8d9kJRrT1HEg0KI8CuUSUyLcaTlKaaQgD2xVuzK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743523425; c=relaxed/simple;
	bh=xnUsRAnCTM6iow/f/UCejEdDYoiWEl5F6w3kOCDrBoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFt/JWTEJrqCLR9eXwqAklRaNQzo37WsWPGfBwNuv7gBemRuLmHK/gCtVUltCeUA2XMB639ESvrSTk206+b0s5xSwSlY+EA2qIVRbYlXxTET3unutR2F6DfLPBsS+Q5ECdZifwcLAC97VYqlVXt7nTAzn97ZVhwgfTmkk0ryPh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VAWPmv2v; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c5b8d13f73so604308485a.0
        for <linux-arch@vger.kernel.org>; Tue, 01 Apr 2025 09:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1743523422; x=1744128222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HUIWAEN6Qyb8+Hz58OV+4wJouq5dad93BnZ8Do0foZI=;
        b=VAWPmv2vgdrgIZYQ+IyU5bPlsVeKFD8gZ1OyyuWhpXZg+GVLGzCoZV+rpDPC9KYwsj
         eG8Hkgj+vKSC4Efpo6oLrgBcs06tFYEYGMYoGFzyiVCyuYJAZzloRsYqtWUFAVRoiu5p
         UvBkkCsBPfX2zfz0UdP+0+h/GaNkbPSupRBY3gFWf1/dnmVx28rTHPb9+l4KcuKiyxab
         s5amtKNg8muf/FpVkWwJifWQa4cpZybl1Z6l/mZih1fZ8eX2h5O/le7dfsytwOl3IVBN
         Zl4WI5kg/nStRH9f9pPMlPtUiLi6IhA5iuHYC+49a3UlL/gervngmrw2l00kT77FmqYP
         MbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743523422; x=1744128222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUIWAEN6Qyb8+Hz58OV+4wJouq5dad93BnZ8Do0foZI=;
        b=GC5PP0/qBjgSYpAcsdTYOaUU8g04ocQHTta2NV+PcQDBwIMvCoRgwyuuBwJhZEgrMJ
         sviqQHjttzCZzk/NbOfr22mPK9wealMq5lxypR0FsWv9Es59FGHm8abcOYJmn8n8VaSP
         mBStUonsHHPMcbJ5r5+6e0NzGrZ2S5RP+44sX02AyjNGOUKlXdftRX8ELm46FqVKFn51
         JFvqiBpnWckPJP8bnHILB1cm9b5fkZSZKpRvUj+/ggJro9wJRv7Yt5mBR8zj6xMqGX3A
         vDdb2kqoTyMcA9RrqgYPy8MEgI7T5cL21X8bYbRvq2Oht7Ye2M5xvLNtdtAsJKAjsqTK
         Bkig==
X-Forwarded-Encrypted: i=1; AJvYcCUNtC+2HBctt5T92iYiwd5TalSxB66pfCs9gE9pzjkJpWOEq36UWyMeG6UaInUq4EmwAuthTOznj+9w@vger.kernel.org
X-Gm-Message-State: AOJu0YwP85gqe3b5ttlusHbOPKBxxcoF5a27tP2wxdJtx6+2wwqdVHZ/
	OJKIhl+4CUlK6u0RXDxfNt+2wA3BqxDH7FdiStp2d9ZRrNngq0SvhP+1gQUtw5o=
X-Gm-Gg: ASbGnctgQkSHHKeSgqBQIQacDSJN+wZk4VB9m4tTAJ8ZPDzYzQRQ3SLkKDOsX3CxEIM
	pb2KKLrp6hqwiO4tZX+rUzWLMGocEVRQFybj0rx0ktfUV97mANB/rewDI1rZFNTc4OehYgChGV8
	dJgKCjf80ma1KcR4VMjbMfvKVDWxuyf6FIZTjTQokBUmNZPco6HKGBp3dkG7xxiCfS6Pn4fPYil
	tWYiZOJLv4iEVH8257OJxW+0YWqaNQoT33zAnFqsuJwQIwwv9l2N6MmAWAxOKqNj6GxRh6LwSx3
	P6Q+S9spoxZSOYIcFRf/dXWF6uxB94ZXxH0F1lCkcYyjao7gn46q6ltPp0gIuO7JJ9iSSVVs/0I
	xwuTZ3mEJ/AU4SQYRigUdsDG4kwP0Bk93uQ==
X-Google-Smtp-Source: AGHT+IEK38CnaMLkGKnp6wFhyTba4uVPU2YkYY6SqmlutfADek1SIeamjKZM91laT+FptTnOqcHgWw==
X-Received: by 2002:a05:620a:2551:b0:7c5:6045:beb7 with SMTP id af79cd13be357-7c69072c8b5mr2068616685a.32.1743523422038;
        Tue, 01 Apr 2025 09:03:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f77802c0sm673482385a.104.2025.04.01.09.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 09:03:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tze5U-00000001MIe-3oUm;
	Tue, 01 Apr 2025 13:03:40 -0300
Date: Tue, 1 Apr 2025 13:03:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>, x86@kernel.org, kvm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
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
	Zhi Wang <zhiw@nvidia.com>, AXu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [RFC PATCH v2 14/22] iommufd: Add TIO calls
Message-ID: <20250401160340.GK186258@ziepe.ca>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com>
 <yq5av7rt7mix.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5av7rt7mix.fsf@kernel.org>

On Fri, Mar 28, 2025 at 10:57:18AM +0530, Aneesh Kumar K.V wrote:
> > +int iommufd_vdevice_tsm_bind_ioctl(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_vdevice_tsm_bind *cmd = ucmd->cmd;
> > +	struct iommufd_viommu *viommu;
> > +	struct iommufd_vdevice *vdev;
> > +	struct iommufd_device *idev;
> > +	struct tsm_tdi *tdi;
> > +	int rc = 0;
> > +
> > +	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
> > +	if (IS_ERR(viommu))
> > +		return PTR_ERR(viommu);
> >
> 
> Would this require an IOMMU_HWPT_ALLOC_NEST_PARENT page table
> allocation?

Probably. That flag is what forces a S2 page table.

> How would this work in cases where there's no need to set up Stage 1
> IOMMU tables?

Either attach the raw HWPT of the IOMMU_HWPT_ALLOC_NEST_PARENT or:

> Alternatively, should we allocate an IOMMU_HWPT_ALLOC_NEST_PARENT with a
> Stage 1 disabled translation config? (In the ARM case, this could mean
> marking STE entries as Stage 1 bypass and Stage 2 translate.)

For arm you mean IOMMU_HWPT_DATA_ARM_SMMUV3.. But yes, this can work
too and is mandatory if you want the various viommu linked features to
work.

> Also, if a particular setup doesn't require creating IOMMU
> entries because the entire guest RAM is identity-mapped in the IOMMU, do
> we still need to make tsm_tdi_bind use this abstraction in iommufd?

Even if the viommu will not be exposed to the guest I'm expecting that
iommufd will have a viommu object, just not use various features. We
are using viommu as the handle for the KVM, vmid and other things that
are likely important here.

Jason

