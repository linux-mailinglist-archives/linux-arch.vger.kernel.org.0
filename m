Return-Path: <linux-arch+bounces-12661-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6916DB01B35
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 13:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC3D1C8386C
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 11:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19DC28BAB9;
	Fri, 11 Jul 2025 11:54:41 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A05175D47;
	Fri, 11 Jul 2025 11:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234881; cv=none; b=qfr2SljVrn9uI71XZHWbzR8nZMGWiFqgELvXZru09UPWwn6oir7VEUZQV0Hl8L15CkO+Pqt+0pOlx6Y/Okur9KPfJAdbaXINKKnKoQity3B+m21s/Qzu1gBGxxowkUtDf/ehzwLNkqP7+t06r84Ij9pzcXxXNXzBfHanAklGSLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234881; c=relaxed/simple;
	bh=MmmoynlAW2R7u926XTC2KMukop+KN1gGZGE8iwpHwqk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eX2Hokk+O0R+P3aZ98PuyPsoWvrn0yXZja8KaRztj/ZPjFzNAcWic+ns5qlK73hLrUKBKMtGdnrKdikD7qQuDoh+MUjvNyIz7khldg6X7HG6ng63fp2xx6RkGpgdewCzpOkdJ/buOod+lRy+D8V3hVegQ6qOp7ug7p6Y6jUFRsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bdqml1fHPz6L52V;
	Fri, 11 Jul 2025 19:51:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3542B1402EF;
	Fri, 11 Jul 2025 19:54:37 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 11 Jul
 2025 13:54:36 +0200
Date: Fri, 11 Jul 2025 12:54:34 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <dan.j.williams@intel.com>
CC: Catalin Marinas <catalin.marinas@arm.com>, <james.morse@arm.com>,
	<linux-cxl@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, <gregkh@linuxfoundation.org>, Will Deacon
	<will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Yicong Yang
	<yangyicong@huawei.com>, <linuxarm@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, H Peter Anvin
	<hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>
Subject: Re: [PATCH v2 1/8] memregion: Support fine grained invalidate by
 cpu_cache_invalidate_memregion()
Message-ID: <20250711125434.000050f3@huawei.com>
In-Reply-To: <686eedb25ed02_24471002e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250624154805.66985-1-Jonathan.Cameron@huawei.com>
	<20250624154805.66985-2-Jonathan.Cameron@huawei.com>
	<686eedb25ed02_24471002e@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 9 Jul 2025 15:31:14 -0700
<dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > From: Yicong Yang <yangyicong@hisilicon.com>
> > 
> > Extend cpu_cache_invalidate_memregion() to support invalidate certain
> > range of memory. Control of types of invlidation is left for when  
> 
> s/invlidation/invalidation/
> 
> > usecases turn up. For now everything is Clean and Invalidate.
> > 
> > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > ---
> >  arch/x86/mm/pat/set_memory.c | 2 +-
> >  drivers/cxl/core/region.c    | 6 +++++-
> >  drivers/nvdimm/region.c      | 3 ++-
> >  drivers/nvdimm/region_devs.c | 3 ++-
> >  include/linux/memregion.h    | 8 ++++++--
> >  5 files changed, 16 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > index 46edc11726b7..8b39aad22458 100644
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -368,7 +368,7 @@ bool cpu_cache_has_invalidate_memregion(void)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cpu_cache_has_invalidate_memregion, "DEVMEM");
> >  
> > -int cpu_cache_invalidate_memregion(int res_desc)
> > +int cpu_cache_invalidate_memregion(int res_desc, phys_addr_t start, size_t len)
> >  {
> >  	if (WARN_ON_ONCE(!cpu_cache_has_invalidate_memregion()))
> >  		return -ENXIO;
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 6e5e1460068d..6e6e8ace0897 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -237,7 +237,11 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
> >  		return -ENXIO;
> >  	}
> >  
> > -	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
> > +	if (!cxlr->params.res)
> > +		return -ENXIO;
> > +	cpu_cache_invalidate_memregion(IORES_DESC_CXL,
> > +				       cxlr->params.res->start,
> > +				       resource_size(cxlr->params.res));  
> 
> So lets abandon the never used @res_desc argument. It was originally
> there for documentation and the idea that with HDM-DB CXL invalidation
> could be triggered from the device. However, that never came to pass,
> and the continued existence of the option is confusing especially if
> the range may not be a strict subset of the res_desc.
> 
> Alternatively, keep the @res_desc parameter and have the backend lookup
> the ranges to flush from the descriptor, but I like that option less.
> 

I'll do that as a precursor so we can keep the discussion of that
vs the range being added separate.

Jonathan



