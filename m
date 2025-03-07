Return-Path: <linux-arch+bounces-10564-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B82CA56BDF
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 16:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B85177ADAE6
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 15:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1D621CC43;
	Fri,  7 Mar 2025 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mYAdAwxv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7F121D3E5
	for <linux-arch@vger.kernel.org>; Fri,  7 Mar 2025 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360670; cv=none; b=T1/qJUjie9IMircAT3YYcV69bnfMX76VishfebzysXB/oElROuyK1AeByhusaWJxaeAYcU2FXQlbAVbpgf2AWHHWUgVZOBAP0KvEzZxjKtP43TGRns7+L3VKUrGi6pP2uieluuDKBx/J9NbVhdnY5evzRU2Z+Mjn1GQnn/fpmx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360670; c=relaxed/simple;
	bh=rX0uMtq0RVZw5cLocHPJ4iQ1QgIw8r0WsZ5PnIUFg/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oT4/yZrihuJc2++bjOzdKvM1cUgYt0LLNaMtd9e1fGn7XzK+fWSauYRZsiWIX6FdgztY23v5AQKxS/Kbu6KGi/Utg0hxlp02oGkZhxpYz4JXQoBHa8z3ew0kmeH6uQsjVPIFzzkoMswoQD22H8ntmq6m70r6g7efhn24eNMk3PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mYAdAwxv; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c3d0e90c4eso309228085a.1
        for <linux-arch@vger.kernel.org>; Fri, 07 Mar 2025 07:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741360667; x=1741965467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kCAKy1MLCn9h59tEwZqypamw7ZoTBGTa4RgpePYYALo=;
        b=mYAdAwxvOF/FNKH8ghHWZmZmVqxewrCco3QLKzVoay/uP2SagsmrLgck+MK8C0BE9M
         p5Iv5tc49YScJNaj2Rnv6egDmCWLi+kHBxIkpweWKabbqDPoKWhkMgldw/0J38gj0jz2
         vufiHwYAYMsmehRUDGr3bVI4NVAFoJjrMF8dluSvVHBRKg6OAeDG4tsWs3SwHWrmeRlS
         oDfDvpIUpL18c4PqDn8Yro63tRRKk6tB3iE7Ej05DoCLsVj++pVTQ0uY94K20MPW5zUv
         IgmJhXjzv5XvU83qktfr42Pl7vbpw5veI6GpaXuB15HnnHqLdUOclLw9uMDN9vK9PVQs
         WK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741360667; x=1741965467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCAKy1MLCn9h59tEwZqypamw7ZoTBGTa4RgpePYYALo=;
        b=gmJnX0XLGSir8Ho0cFrfhy3eYuMKqH4oIoNm02AeTemmDy1UJnvdE3OsK5KzagqUDH
         FMGFzudWYNcoZJiutJsL/DrIxYvk7DmGn6Ush+WTmm7mY1DGc3h4/pVfmjyGX7JqcL5i
         ZY8yVop1HVeRzh6Z8ptdkykYzSe63X3rOWeBaieIJVhkAk4bnz8xaSWQAEWgrEQs8H8r
         HeW/BbZTtXVQIyv7SDs7CoLBToR7o7xrNr/gHVXlO76Nq2oOPy5jV3BeMxEBxbyjJoZi
         SCy2LczcF+aOGoM+Y/PdcfNScop4L8Uu75ftxZ5g+N5NDSGZAZH5Ls1LApBsPS8RAWcR
         +9UA==
X-Forwarded-Encrypted: i=1; AJvYcCWk7CHJPygpbEur0gOUL48gQ+Dh28wGeyFedWFOM0VCpivI2/TToWTLJeoJZIatB6RrS+ezifabWs4d@vger.kernel.org
X-Gm-Message-State: AOJu0YxsPLxgsvF8Fhf+Y8kcS4Xt1T7tudDX93AWYG39RPS8v3EPa2J6
	qtvNjorm/RTL3R/W8xQHpt9w0gwmX0VuGT3jOdPxkZjjdjDhN3o1IZrFBQ8F1uQ=
X-Gm-Gg: ASbGncsYAByDz9bwIOWBYVgfsJ4YqaGswE5VdH7zFpzhI+PreyRbsaG8l7gmuF49XIJ
	EquDIK0c+4RV4Ir0XGeX/VCbhXh+/uTEAcQOpFfO15W1IazNJxUm1lKE4crjsAyMZ0cVUmP7PiD
	mxeGYb6n2cOzcfHL0LcXoQJrX0NElaMaBubLuYo5am2cABVn0ErDG4K7nDbK3gHk2SVmnP/AVq6
	iGWPxPdky294Jn5yqaE0Fu61W2xfFnn8aBpnJlmFUnEKXqTODdevdDZtGl0XOuVCRRzHLFndqel
	qCJUs4bkjnzD/xdWMqLLajW9fEAjyltaZEF5nhSDA0TB2qJLPgSOmzgMyLVRZHxlf/sOrAknvKg
	IMi80jjlBUxT0lfpXdg==
X-Google-Smtp-Source: AGHT+IGPtlWnpTlq97dHBsYv9Qj2zzhftXBWiYKJa7fQGbPL61VR64KLpfRR/UmiZXjz25h9+jNuNw==
X-Received: by 2002:a05:620a:27ce:b0:7c3:cbad:5735 with SMTP id af79cd13be357-7c499d46c20mr545047685a.28.1741360667128;
        Fri, 07 Mar 2025 07:17:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e5511328sm252963085a.105.2025.03.07.07.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:17:46 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tqZSL-00000001ljV-3gSE;
	Fri, 07 Mar 2025 11:17:45 -0400
Date: Fri, 7 Mar 2025 11:17:45 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>, x86@kernel.org,
	kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
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
	Zhi Wang <zhiw@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v2 14/22] iommufd: Add TIO calls
Message-ID: <20250307151745.GH354403@ziepe.ca>
References: <Z72GmixR6NkzXAl7@yilunxu-OptiPlex-7050>
 <2fe6b3c6-3eed-424d-87f0-34c4e7e1c906@amd.com>
 <Z77xrqLtJfB84dJF@yilunxu-OptiPlex-7050>
 <20250226131202.GH5011@ziepe.ca>
 <Z7/jFhlsBrbrloia@yilunxu-OptiPlex-7050>
 <20250301003711.GR5011@ziepe.ca>
 <Z8U+/0IYyn7XX3ao@yilunxu-OptiPlex-7050>
 <20250305192842.GE354403@ziepe.ca>
 <Z8lE+5OpqZc746mT@yilunxu-OptiPlex-7050>
 <c5c31890-14fc-4fab-8cd4-d4dcfdecdd2d@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5c31890-14fc-4fab-8cd4-d4dcfdecdd2d@amd.com>

On Fri, Mar 07, 2025 at 01:19:11PM +1100, Alexey Kardashevskiy wrote:
> > > Part of my problem here is I don't see anyone who seems to have read
> > > all three specs and is trying to mush them together. Everyone is
> > > focused on their own spec. I know there are subtle differences :\
> 
> One is SEV TIO (earlier version published), another one TDX Connect (which I
> do not have and asked above) and what is the third one here? Or is it 4 as
> ARM and RiscV both doing this now? Thanks,

ARM will come with a spec someday, I don't know about RISCV. Maybe it
is 4..

Jason

