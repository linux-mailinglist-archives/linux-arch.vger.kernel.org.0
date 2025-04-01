Return-Path: <linux-arch+bounces-11196-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06130A77F94
	for <lists+linux-arch@lfdr.de>; Tue,  1 Apr 2025 17:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 185447A2D59
	for <lists+linux-arch@lfdr.de>; Tue,  1 Apr 2025 15:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0655820C481;
	Tue,  1 Apr 2025 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZdJmAgh6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76F520C473
	for <linux-arch@vger.kernel.org>; Tue,  1 Apr 2025 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743522826; cv=none; b=uYQRmV96R1ParvNdjgHS1Sof8shJskq0b9odoedTApPSkQDhpC3KoHXFN5STmahHsUsjThHHieH+ed9IU27efEv6smWQKzsYA8s/3QI7om4occdTUBB2IPEM6UkyNphukWZYxC9S7DRV3a2MdQiJ+Wk7QuvPhB2l7Q7AOVYpL4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743522826; c=relaxed/simple;
	bh=MKudk/LIkF1mIN1017i5vn/dv6GMx6eTBMj2oFhk/BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OD/ewg95AZlVHWnPkAK9NWM1ltE8uHf/80/k8WuVkxikrkA2zAvtXXozUZ4rxBN3l+fcMuPHPl23/+w/UOLeGeIgK7LmMG4RGjvlDBg1tbNWIweYDPi8Jy6WXX6wPZ9VHV+fSM+U2YQrB5p42ljgpJ3mMDhAMC823jXmDjsk/dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZdJmAgh6; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8f4c50a8fso50953006d6.1
        for <linux-arch@vger.kernel.org>; Tue, 01 Apr 2025 08:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1743522823; x=1744127623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MKudk/LIkF1mIN1017i5vn/dv6GMx6eTBMj2oFhk/BU=;
        b=ZdJmAgh6BfI7FR71xO9Ltvyd+AqEmpa8+KXtD/0JgUoI2BXIYhrdSfOzzIPSIMyrPa
         iOtzJa69RJtuxBoWBivEXVE4F3G093H6PQhBJPTCP6aTJi0Y28885B0dPBaMFC5faUDa
         Z6ciQ7Ir6vu7c1vY6pcE8OQ6WaSISYO50Q0tGj/Z/UrOfesMwrCLBf0zXRaDHuT0RD20
         ly/ztp6GibJIvR2hUzsbrNk/T7CNcOtFu8WGGnkIuVRmywGHIdAqHgqQgh7lox70jBEe
         4QqUUZB7K1NIhLRHsnhwQrxSt9EdBJev7wvPG1dr/6BLG6NMJuNiM3ae0F4iLGsC83jC
         YDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743522823; x=1744127623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKudk/LIkF1mIN1017i5vn/dv6GMx6eTBMj2oFhk/BU=;
        b=mZVnfmt8901g3e6Kak/5RziBGgO8KVazKdcGvDzZSDahgS8OF79S+e9tj2VyelqjM6
         ECy7E6s0bSaOtWotbYIKjjstBI+//Gv+GU8Q8shSQv61pQfDC0t5GGp7rkULg9+p+brX
         XMAGwhIEbvU4h4StBLn2zQxSP4y8AjUOfdKHDMop4Rg8C5U+2k85pfqoohGQfw+3IuKZ
         p3DUspXw5SHWS+nFmKZqMbJa3av5oW2iwMa/FfPEZAzFmyA1J3SHCf3u/fp9QWwzUfFV
         hIzfTz+wi054zDf4s31Stt55SXF8e2cK/MNTw/4Dt39WjIpEc8RM5ylkP76dkw23IJuZ
         CgCA==
X-Forwarded-Encrypted: i=1; AJvYcCUHjeZmjq4AuPnbFfVgFpPFxfKDsDf9YBHTQKmhl9oJYVtvKxlIfvRHwcDz3j9GHtuD7iNgENwaFhO1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5pkEhCJLY6EqNKNP7Gyie4ZzP5txztsCuDhjFpCbD5ceuwKBM
	1Q8lcpqDKzucxXHyhN40ZSzsbSpRf/+gPKESmmbfbqu0sfbnOEOX6ZEhTu6m9i4=
X-Gm-Gg: ASbGncs+4Z759M/BRzdOlEVB2A9fMXdcJDd2TzK06b1huEJZT0FZjyca9CU+9mfj0pM
	YPQq+Mm56xNrbIyQumfKWlpCEYA83H2MZz3LGiEV4NYXup2uVb88NM0fcyBfMKHuKLHEWfMnTwd
	6bImenPHeGg3oq/SVs24rFVSVwfS0WDxLdLJ7qYqat0fAyF37xrORNSOi/gOXrk+C2gyf5oNLJg
	mWqRhKuv7cE6JKzCVLYg5Xrm+atNMwu+ba0YxM5xe1YdNB6y2yDAhGQUEmKHyQ8dAUXOnHWMyXW
	uRuxpqWow9d02Wkf+i3LtpYJ6+0POHMYpxGEoJTm9/Od7K+Z/ikacmu3DnpjQvDHp6EYr+vvdGK
	EwcUAEbjWhyTii9Q8YyUr4no=
X-Google-Smtp-Source: AGHT+IFJ+ooR1gogrE/PHgnfFzjzVnCoIzBOEcYnCXUPK3x+TiFlSiO2UYFbU0xPUKL90AfGX3nrhQ==
X-Received: by 2002:ad4:5c86:0:b0:6e8:9a55:8259 with SMTP id 6a1803df08f44-6eed5f924f4mr229513566d6.9.1743522823661;
        Tue, 01 Apr 2025 08:53:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec97970a2sm63068746d6.98.2025.04.01.08.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 08:53:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tzdvq-00000001MFn-2LDi;
	Tue, 01 Apr 2025 12:53:42 -0300
Date: Tue, 1 Apr 2025 12:53:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, x86@kernel.org,
	kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
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
	Dionna Glaze <dionnaglaze@google.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-coco@lists.linux.dev,
	Zhi Wang <zhiw@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v2 14/22] iommufd: Add TIO calls
Message-ID: <20250401155342.GJ186258@ziepe.ca>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com>
 <Z72GmixR6NkzXAl7@yilunxu-OptiPlex-7050>
 <2fe6b3c6-3eed-424d-87f0-34c4e7e1c906@amd.com>
 <20250226130804.GG5011@ziepe.ca>
 <67d4d3a5622f9_12e3129480@dwillia2-xfh.jf.intel.com.notmuch>
 <926022a3-3985-4971-94bd-05c09e40c404@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <926022a3-3985-4971-94bd-05c09e40c404@amd.com>

On Mon, Mar 17, 2025 at 01:32:31PM +1100, Alexey Kardashevskiy wrote:

> It is about accessing MMIO with Cbit set, and running DMA to/from private
> memory, in DPDK. On AMD, if we want the PCI's Tbit in MMIO, the Cbit needs
> to be set in some page table. "TVM" in this case is a few private pages (+
> bunch of PSP calls to bring to the right state) pretending to be a CVM which
> does not need to run. Thanks,

Yeah, though that may be infeasible on other platforms. I'm pretty
sure ARM and Intel route the Tbit packets directly to their secure
worlds so there is no possibility for VFIO to use them without also
using the secure world to create a VM.

Maybe AMD is different, IDK.

Jason

