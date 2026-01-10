Return-Path: <linux-arch+bounces-15740-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDE2D0CF56
	for <lists+linux-arch@lfdr.de>; Sat, 10 Jan 2026 06:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 962CC300DB2F
	for <lists+linux-arch@lfdr.de>; Sat, 10 Jan 2026 05:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02086248867;
	Sat, 10 Jan 2026 05:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="C74SC47v"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B832AEE1;
	Sat, 10 Jan 2026 05:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768021624; cv=none; b=Nqrayuw0so6BiVY3L50/tUaaEeAQdXW+8Ic6PEoc8wAtN6y+EjaUERetZorxmA0oDycCojl4muLfroCF/z4tVDv4hK2CsDoP+n6aD7Ron87jfrdHYIey0EH6h7GJr6oFct3hGmJ54TAzgvUrClQZC0gTiXn3ks/EM7ExUMxtY4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768021624; c=relaxed/simple;
	bh=H9sP3OuduopwwfkgZnqCplKd7Uw7oudWDC+SRAthous=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAjyArsK5QfnRDkPyIRKnihwZQxfqcylBbXpUGH6dSdwhfwQEHdHZ6+jbcG+MVnc1DHOQaJmm0jSNSaUA2DQq/61ccDFU2e5CDMSRcOw+FlZY9qezXiHCLslNzJkee1o8lNNLK8yjEWcyrhioM/YbC9Lk0Giy3R08A3yS/aQ9JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=C74SC47v; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [167.220.232.230])
	by linux.microsoft.com (Postfix) with ESMTPSA id 44F97201AC7E;
	Fri,  9 Jan 2026 21:07:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 44F97201AC7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768021622;
	bh=8LDRrRcWPAQ/JM0ulR7Cmo3AX3HSBKt9ssdkQit4fZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C74SC47v/fG9cBx+G9rSDmaT3PUXefUfqblHqSXIXFtD91RKQH1jXzFHRw2eXLqCO
	 RE/wVcJv2dYVCEU3g6AmDBpSveCVqhg4/9YIBhgC1ZFpp8sRFci2fpKU1IKBi48X7c
	 wBUKrY4EigDJ5oH/ycm2aJzLVAMzRiwsxTHQPi3k=
Date: Sat, 10 Jan 2026 13:07:00 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "kys@microsoft.com" <kys@microsoft.com>, 
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, 
	"decui@microsoft.com" <decui@microsoft.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"arnd@arndb.de" <arnd@arndb.de>, "joro@8bytes.org" <joro@8bytes.org>, 
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>, 
	"easwar.hariharan@linux.microsoft.com" <easwar.hariharan@linux.microsoft.com>, "jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>, 
	"nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>, "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [RFC v1 4/5] hyperv: allow hypercall output pages to be
 allocated for child partitions
Message-ID: <4xjdq3js7w4qxcev727ujedpcujvzgrhf4xsfn3plfrn7fskxu@2qwxljanz3i6>
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
 <20251209051128.76913-5-zhangyu1@linux.microsoft.com>
 <SN6PR02MB4157C3EF6617A7BA4CA9E432D485A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157C3EF6617A7BA4CA9E432D485A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Thu, Jan 08, 2026 at 06:47:44PM +0000, Michael Kelley wrote:
> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, December 8, 2025 9:11 PM
> > 
> 
> The "Subject:" line prefix for this patch should probably be "Drivers: hv:"
> to be consistent with most other changes to this source code file.
> 
> > Previously, the allocation of per-CPU output argument pages was restricted
> > to root partitions or those operating in VTL mode.
> > 
> > Remove this restriction to support guest IOMMU related hypercalls, which
> > require valid output pages to function correctly.
> 
> The thinking here isn't quite correct. Just because a hypercall produces output
> doesn't mean that Linux needs to allocate a page for the output that is separate
> from the input. It's perfectly OK to use the same page for both input and output,
> as long as the two areas don't overlap. Yes, the page is called
> "hyperv_pcpu_input_arg", but that's a historical artifact from before the time
> it was realized that the same page can be used for both input and output.
> 
> Of course, if there's ever a hypercall that needs lots of input and lots of output
> such that the combined size doesn't fit in a single page, then separate input
> and output pages will be needed. But I'm skeptical that will ever happen. Rep
> hypercalls could have large amounts of input and/or output, but I'd venture
> that the rep count can always be managed so everything fits in a single page.
> 

Thanks, Michael.

Is there an existing hypercall precedent that reuses the input page for output?
I believe reusing the input page should be acceptable, at least for pvIOMMU's
hypercalls, but I will confirm these interfaces with the Hyper-V team.

> > 
> > While unconditionally allocating per-CPU output pages scales with the number
> > of vCPUs, and potentially adding overhead for guests that may not utilize the
> > IOMMU, this change anticipates that future hypercalls from child partitions
> > may also require these output pages.
> 
> I've heard the argument that the amount of overhead is modest relative to the
> overall amount of memory that is typically in a VM, particularly VMs with high
> vCPU counts. And I don't disagree. But on the flip side, why tie up memory when
> there's no need to do so? I'd argue for dropping this patch, and changing the
> two hypercall call sites in Patch 5 to just use part of the so-called hypercall input
> page for the output as well. It's only a one-line change in each hypercall call site.
> 

I share your concern about unconditionally allocating a separate output page
for each vCPU. And if reusing the input page isn't accepted by the Hyper-V team,
perhaps we could gate the allocation by checking IS_ENABLED(CONFIG_HYPERV_PVIOMMU)
in hv_output_page_exist()?

B.R.
Yu

