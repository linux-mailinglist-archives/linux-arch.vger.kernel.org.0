Return-Path: <linux-arch+bounces-11384-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949CCA8503B
	for <lists+linux-arch@lfdr.de>; Fri, 11 Apr 2025 01:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862F34C43CD
	for <lists+linux-arch@lfdr.de>; Thu, 10 Apr 2025 23:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EA4214A8F;
	Thu, 10 Apr 2025 23:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KrhKWLnx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5591211486
	for <linux-arch@vger.kernel.org>; Thu, 10 Apr 2025 23:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744328701; cv=none; b=NJ0wbnSRvvlcs7m0rgYNxZdySwJqUFS/UVt6kNWuAiwnyEpzYQKaoCViZuzp5R/rygZfPDCJ5tViGGqm9kRN3AsxdAVvQb54SDJURe4yVtEKBMGwCPr4ffDGwbeXuC4VpaeDxVIZlLY8pGWlgvzIX0TCA2TGq3NAK5K5NF42ptY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744328701; c=relaxed/simple;
	bh=mghY2rYVvlPDE9Jsz5ZnOqrYyA6SfVM8M7wxlDc8iBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJ3cinDXRVq/bGHMYiFpTZJyhjIi/84twWELoyVJL1svQMOuyDCny8EJj3KvIoY2FaeXACLIbZJkwiI3RBD+x6Y141keHRltCYsjBDOaZ22iQcSJ6vFlleQDmt5nWhYXIBSXAkCc8hBnQ+9qhTx/8lfv3gIQ2JGy98rFsKzB/+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KrhKWLnx; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c5c815f8efso136948285a.2
        for <linux-arch@vger.kernel.org>; Thu, 10 Apr 2025 16:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1744328698; x=1744933498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uBiekUdIFmCYXVIVV+7WWzU3nvigAruofoH1gZDVt3E=;
        b=KrhKWLnxwrB3779MEaa6gYJrnDo7d/PhHhK/bfKFq0bPCl0e2XnJvrDLCkmlqum1uJ
         FTpVFiYJs83FLW/QMEdJUG7UJuYRchoHuKU2k7+LFuclVUgU2UngxLJgxzS/iuVxVPmb
         v27VCEhGiO5ECZdn0D65R3xdiE6bW2Zy7d/Zw/rMm4ck6lJrrvrh2DQFoTyM+zJp57IF
         J0emHN21O7y0jx/t11beVFLXKvqL88r1ckulksvINUHkxTg6R7Y5uoj0rkMLl2uL6b/X
         m5TujPtbm2w4OpZ0w/+XODAFEt7exCHM4RBQvjZzNso5hxDIGCfd/K8OglBLS49GuTXR
         xqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744328698; x=1744933498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBiekUdIFmCYXVIVV+7WWzU3nvigAruofoH1gZDVt3E=;
        b=VXC15jC2qQ5ZBnaPDQwXZnexy9NGC1jy10363duGtFiUg25u9LUj+uDXaAFD7ez3Ep
         m2MEB7dPNyY2rawx2gZv/yRgf/Wb7U22zQhpC56OO33pqiNDhJr1c39KlGD3dXvRRBAU
         HshBGgZSFc0PaMOJvCR5jov4f33ciCAs4cJqvi2+C0YgdJHCFFOpoTvOZm0L/aDSP1uf
         aDsBk+jjp/PGZyKUQyHWWeZPKqqfo6ej5AnS5C/FDCxip4Ojelq0dsAvvxGfkwLWYG9i
         9+phFCJogMvJA2V3zAEOdfHwQZgdnPuDcC37HpxyLg9BpCJj9edXEH3GrNxdtD4O88tI
         VXXw==
X-Forwarded-Encrypted: i=1; AJvYcCVay4Ll0tFYQB57ADSqamE+HoAhRdKcOAcW6kpmG/uzNqCl7v+K+Pi081TJpstRq1ZeC1kFpZspGeUM@vger.kernel.org
X-Gm-Message-State: AOJu0Yybu2UAXxhhx7D31W62cEQccvlGB6dPW5jk1hb+r6qUWLLh9Y6Y
	WJyr9i0jI8oPrDAKBl2w8ijLybnWAz1sIBW7rT9qDn94pofrY/mXfMIcqmedtYE=
X-Gm-Gg: ASbGncsvHMrEVVXTKFDnQltNKvcFjvgb/1ylTD85cWZdzKeB/GkMZe7yXRfq2HMzkUw
	juohqwqI0Yw4j8hLnH7vK7kzPTs476difbD6bM+sJyBiCXqDJuIoHN66hv/kHR4qp4XZ7okFQ5K
	ePlFMikwGtVGEMa0Bfe8V4qaRoqnViH7g6nw0z3vwP7ZOa7bNA0JLthgQG8voJjXgfv2VNfmNWA
	EIJmdxIdr6+d7UK3pl3CdqAx6kLg1beurTi5FMI8l1njt7PQPIY72nuFPN7SaxYEBOvbPFJr1yd
	aOo4ZeI3WzPM7VLBOKwo/+tEqVInyZyxfLXR17Pn6+zFn3G6vzLd4bt4auclMdZH0qs0p8/gxGD
	3yNkbFFaTKW6ATasru1o=
X-Google-Smtp-Source: AGHT+IH4fTle0lZ5BXeT1W/Tk1EOzJKOHLxPsiVRzXbPb/Lh5qnqWIfCqkylbYRbJ/h5OGn56sXdfg==
X-Received: by 2002:a05:620a:4141:b0:7c5:b0b4:2cea with SMTP id af79cd13be357-7c7af1137f6mr129267485a.38.1744328698540;
        Thu, 10 Apr 2025 16:44:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8969f1asm169263385a.59.2025.04.10.16.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 16:44:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u31Zp-00000000N4j-0j3F;
	Thu, 10 Apr 2025 20:44:57 -0300
Date: Thu, 10 Apr 2025 20:44:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Robin Murphy <robin.murphy@arm.com>, aleksander.lobakin@intel.com,
	andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de,
	catalin.marinas@arm.com, corbet@lwn.net, dakr@kernel.org,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	gregkh@linuxfoundation.org, haiyangz@microsoft.com, hpa@zytor.com,
	James.Bottomley@hansenpartnership.com, Jonathan.Cameron@huawei.com,
	kys@microsoft.com, leon@kernel.org, lukas@wunner.de,
	luto@kernel.org, m.szyprowski@samsung.com,
	martin.petersen@oracle.com, mingo@redhat.com, peterz@infradead.org,
	quic_zijuhu@quicinc.com, tglx@linutronix.de, wei.liu@kernel.org,
	will@kernel.org, iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
	benhill@microsoft.com, bperkins@microsoft.com,
	sunilmut@microsoft.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH hyperv-next 5/6] arch, drivers: Add device struct
 bitfield to not bounce-buffer
Message-ID: <20250410234457.GB63245@ziepe.ca>
References: <20250409000835.285105-1-romank@linux.microsoft.com>
 <20250409000835.285105-6-romank@linux.microsoft.com>
 <0eb87302-fae8-4708-aaf8-d16e836e727f@arm.com>
 <0ab2849a-5c03-4a8c-891e-3cb89b20b0e4@linux.microsoft.com>
 <67f703099f124_71fe2949e@dwillia2-xfh.jf.intel.com.notmuch>
 <20250410072354.GB32563@lst.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410072354.GB32563@lst.de>

On Thu, Apr 10, 2025 at 09:23:54AM +0200, Christoph Hellwig wrote:
> On Wed, Apr 09, 2025 at 04:30:17PM -0700, Dan Williams wrote:
> > > Thanks, I should've highlighted that facet most certainly!
> > 
> > One would hope that no one is building a modern device with trusted I/O
> > capability, *and* with a swiotlb addressing dependency. However, I agree
> > that a non-shared swiotlb would be needed in such a scenario.
> 
> Hope is never a good idea when dealing with hardware :(  PCIe already
> requires no addressing limitations, and programming interface specs
> like NVMe double down on that.  But at least one big hyperscaler still
> managed to build such a device.
> 
> Also even if the periphal device is not addressing limited, the root
> port or interconnect might still be, we've seen quite a lot of that.

Still it would be very obnoxious for someone to build a CC VM platform
where CC DMA devices can't access all the guest physical memory in the
CC address map :\

Keeping in mind that that the CC address map is being created by using
the CPU MMU and the CPU IOMMU so it is entirely virtual and can be
configured to match most problems the devices might have.

Too much memory would be the main issue..

IMHO I wouldn't implement secure SWIOTLB until someone does such a
foolish thing, and I'd make them do the work as some kind of pennance
:P

Jason

