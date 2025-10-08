Return-Path: <linux-arch+bounces-13958-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C499DBC5677
	for <lists+linux-arch@lfdr.de>; Wed, 08 Oct 2025 16:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1EF3B9BEA
	for <lists+linux-arch@lfdr.de>; Wed,  8 Oct 2025 14:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77392980C2;
	Wed,  8 Oct 2025 14:13:42 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED5E19F115;
	Wed,  8 Oct 2025 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932822; cv=none; b=P38oFtGXM59g2U9Qzrh+OYQ7P0RMiS66mLppVm8/IAzWBppW1dX5UYF1OLDc3iANE+mCXgsIpm8bYXAB5PRchivK2sGSqDpco4uFnTyByWIbo0Sp1CwMz7zlcAaPhanBkUjprq+qoTTnfaTLEF2PSKU3uAzP+bcxTxEFolG/9os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932822; c=relaxed/simple;
	bh=B/D3kUvY7OMyeVsf9T6JXPJxNREc8Db0eb/ZrW+5kXM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dokyDXwsN1EBBZr6adtHQyTxGGTjYxWDT0yhOwuXdavLxgi24hLxncEZ/paea7yJJnEGq9WMh7UBbJ6tOl8EveD0VDjOBu0V5R84dv3XCeF6wdX/YX2SEJKt+vC/uitV0ogl8dN6/GkbydSwFkUnjCrt3VtcAj4hyoXGL5x0IsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4chZfv4gGzz6L4vx;
	Wed,  8 Oct 2025 22:11:03 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 964541400DB;
	Wed,  8 Oct 2025 22:13:36 +0800 (CST)
Received: from localhost (10.122.19.247) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 8 Oct
 2025 15:13:35 +0100
Date: Wed, 8 Oct 2025 15:13:33 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <dan.j.williams@intel.com>
CC: Catalin Marinas <catalin.marinas@arm.com>, <james.morse@arm.com>,
	<linux-cxl@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, Will Deacon <will@kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, "H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
	<peterz@infradead.org>, "Yicong Yang" <yangyicong@huawei.com>,
	<linuxarm@huawei.com>, Yushan Wang <wangyushan12@huawei.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 6/8] cache: Support cache maintenance for HiSilicon
 SoC Hydra Home Agent
Message-ID: <20251008151333.00001b94@huawei.com>
In-Reply-To: <68bf52fa851d9_75e3100ac@dwillia2-mobl4.notmuch>
References: <20250820102950.175065-1-Jonathan.Cameron@huawei.com>
	<20250820102950.175065-7-Jonathan.Cameron@huawei.com>
	<68bf52fa851d9_75e3100ac@dwillia2-mobl4.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 8 Sep 2025 15:04:42 -0700
dan.j.williams@intel.com wrote:

> Jonathan Cameron wrote:
> > From: Yushan Wang <wangyushan12@huawei.com>
> > 
> > Hydra Home Agent is a device used to maintain cache coherency. Add support
> > of explicit cache maintenance operations for it.
> > 
> > Memory resource of HHA conflicts with that of HHA PMU. A workaround is
> > implemented here by replacing devm_ioremap_resource() to devm_ioremap() to
> > workaround the resource conflict check.
> > 
> > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > Co-developed-by: Yicong Yang <yangyicong@hisilicon.com>
> > Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> [..]
> > +static int hisi_soc_hha_probe(struct platform_device *pdev)
> > +{
> > +	struct hisi_soc_hha *soc_hha;
> > +	struct resource *mem;
> > +	int ret;
> > +
> > +	soc_hha = cache_coherency_device_alloc(&hha_ops, struct hisi_soc_hha,
> > +					       ccd);
> > +	if (!soc_hha)
> > +		return -ENOMEM;
> > +
> > +	platform_set_drvdata(pdev, soc_hha);
> > +
> > +	mutex_init(&soc_hha->lock);
> > +
> > +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!mem)
> > +		return -ENODEV;
> > +
> > +	/*
> > +	 * HHA cache driver share the same register region with HHA uncore PMU
> > +	 * driver in hardware's perspective, none of them should reserve the
> > +	 * resource to itself only.  Here exclusive access verification is
> > +	 * avoided by calling devm_ioremap instead of devm_ioremap_resource to
> > +	 * allow both drivers to exist at the same time.
> > +	 */
> > +	soc_hha->base = ioremap(mem->start, resource_size(mem));
> > +	if (IS_ERR_OR_NULL(soc_hha->base)) {
> > +		ret = dev_err_probe(&pdev->dev, PTR_ERR(soc_hha->base),
> > +				"failed to remap io memory");
> > +		goto err_free_ccd;
> > +	}
> > +
> > +	ret = cache_coherency_device_register(&soc_hha->ccd);
> > +	if (ret)
> > +		goto err_iounmap;
> > +
> > +	return 0;
> > +
> > +err_iounmap:
> > +	iounmap(soc_hha->base);
> > +err_free_ccd:
> > +	cache_coherency_device_free(&soc_hha->ccd);  
> 
> I understand that this scheme works because ccd is the first member and
> that is forced at alloc the same way fwctl does it. However, fwctl hides
> confusing code like this behind put_device() in the free path. So I would
> say if you want to borrow the "_alloc(ops, drv_struct, member)" approach do
> also hide the "offsetof(drv_struct, member) == 0" in the object release
> path and not have eye-popping code like:
> 
>     cache_coherency_device_free(&soc_hha->ccd)
> 
> ...that throws away the allocation side cleverness into a cloud of reader
> confusion. Either make this an actual "device" or otherwise have a kref.
> 
The device option is out because Greg KH was not keen on me using that
infrastructure when we don't have any userspace ABI. 

Kref seems fine but because we have to pass an explicit release to kref_put()
we end up either with the odd looking

kfree_put(&soc_hha->cci, cache_coherency_ops_inst_free);

or wrapping it up with a helper along the lines of
cache_coherency_ops_instance_put(&soc_hha->cci);

That seems reasonable but given there is no real reference counting going on
(the reference count == 1 from alloc to this call) using an actual kref is
perhaps overkill because this is really the same as having no kref and
just implementing.

void cache_coherency_ops_instance_put(struct cache_coherency_ops_inst *cci)
{
	kfree(cci);
}

So other than a rename it is the same as current implementation. :(

So for now I'm thinking have the helper and use a kref even if it's rather
silly just because it will then behave how people (hopefully) expect it to.

Jonathan





