Return-Path: <linux-arch+bounces-14295-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3E4C00E19
	for <lists+linux-arch@lfdr.de>; Thu, 23 Oct 2025 13:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B971A06EDA
	for <lists+linux-arch@lfdr.de>; Thu, 23 Oct 2025 11:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43D830E83A;
	Thu, 23 Oct 2025 11:49:22 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717C43009CA;
	Thu, 23 Oct 2025 11:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220162; cv=none; b=tRg0/5YGe79G/JAgnGUwKpYVxIdpIQqYA3xFNLSiQQVqoqPrfIexElFGg9E4YoLV/DSfjjIIYiFyf+bZ1E2baWPvK8VePKaw7ye/T0MuKdl88bsSf7bS96Ucf4yeKtqNVm2l7npe/9torWl9ZOTDcUcO4Ol0DSBAToh0uQmqVYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220162; c=relaxed/simple;
	bh=7KOg7rdlAbrSwgjNY4mTSXNHQN8OFRoryiuNl6S8lBM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4VB6pFqREeCBljaNFtYAVyZKpJkoWgYNBVVUAqqAdQTRLKVF980DYcZnygiH9BVVO6BAcir/3Yqobjytgt53VuGN6R91bg+QFg3cJp9HOG4F0xReVTHMwrf5Uirxk+fTas+ru0Nz9a766Ggkp2JhFZKI0//j2KJROnUvA7yDKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cskkf1VNJz6HJgq;
	Thu, 23 Oct 2025 19:46:02 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 876941402F3;
	Thu, 23 Oct 2025 19:49:17 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Oct
 2025 12:49:16 +0100
Date: Thu, 23 Oct 2025 12:49:14 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Conor Dooley <conor@kernel.org>
CC: Catalin Marinas <catalin.marinas@arm.com>, <linux-cxl@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, Dan Williams <dan.j.williams@intel.com>, "H . Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, <james.morse@arm.com>, Will Deacon
	<will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	<linuxarm@huawei.com>, Yushan Wang <wangyushan12@huawei.com>, "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	<x86@kernel.org>, Andy Lutomirski <luto@kernel.org>, "Dave Jiang"
	<dave.jiang@intel.com>
Subject: Re: [PATCH v4 6/6] cache: Support cache maintenance for HiSilicon
 SoC Hydra Home Agent
Message-ID: <20251023124914.00001005@huawei.com>
In-Reply-To: <20251022-kite-revert-2c2684054d05@spud>
References: <20251022113349.1711388-1-Jonathan.Cameron@huawei.com>
	<20251022113349.1711388-7-Jonathan.Cameron@huawei.com>
	<20251022-kite-revert-2c2684054d05@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 22 Oct 2025 22:39:28 +0100
Conor Dooley <conor@kernel.org> wrote:

Hi Conor,

> On Wed, Oct 22, 2025 at 12:33:49PM +0100, Jonathan Cameron wrote:
> 
> > +static int hisi_soc_hha_wbinv(struct cache_coherency_ops_inst *cci,
> > +			struct cc_inval_params *invp)
> > +{
> > +	struct hisi_soc_hha *soc_hha =
> > +		container_of(cci, struct hisi_soc_hha, cci);
> > +	phys_addr_t top, addr = invp->addr;
> > +	size_t size = invp->size;
> > +	u32 reg;
> > +
> > +	if (!size)
> > +		return -EINVAL;
> > +
> > +	addr = ALIGN_DOWN(addr, HISI_HHA_MAINT_ALIGN);
> > +	top = ALIGN(addr + size, HISI_HHA_MAINT_ALIGN);
> > +	size = top - addr;
> > +
> > +	guard(mutex)(&soc_hha->lock);
> > +
> > +	if (!hisi_hha_cache_maintain_wait_finished(soc_hha))
> > +		return -EBUSY;
> > +
> > +	/*
> > +	 * Hardware will search for addresses ranging [addr, addr + size - 1],
> > +	 * last byte included, and perform maintain in 128 byte granule
> > +	 * on those cachelines which contain the addresses.
> > +	 */  
> 
> Hmm, does this mean that the IP has some built-in handling for there
> being more than one "agent" in a system? IOW, if the address is not in
> its range, then the search will just fail into a NOP?

Exactly that. NOP if nothing to do. The hardware is only tracking
a subset of what it might contain (depending on which cachelines are
actually in caches) so it's very much a 'clear this if you happen to
have it' command.  Even if it is in the subset of PA being covered by
an instance, many cases will be a 'miss' and hence a NOP.

> If that's not the case, is this particular "agent" by design not suitable
> for a system like that? Or will a dual hydra home agent system come with
> a new ACPI ID that we can use to deal with that kind of situation?

Existing systems have multiple instances of this hardware block.

Simplifying things over reality just to make this explanation less
messy.  (ignoring other levels of interleaving beyond the Point of
Coherency etc).

In servers the DRAM access are pretty much always interleaved 
(usually at cache line granularity). That interleaving may go very
different physical locations on a die or across multiple dies.

Similarly the agent responsible for tracking the coherency state
(easy to think of this as a complete directory but it's never that
simple) is distributed so that it is on the path to the DRAM. Hence
if we have N way interleave there maybe N separate agents responsible for
different parts of the range 0..(64*N-1) (taking smallest possible
flush that would have to go to all those agents).
 
> (Although I don't know enough about ACPI to know where you'd even get
> the information about what instance handles what range from...)

We don't today. It would be easy to encode that information
as a resource and it may make sense for larger systems depending
on exactly how the coherency fabric in a system works. I'd definitely
expect to see some drivers doing this. Those drivers could then prefilter.

Interleaving gets really complex so any description is likely to only
provide a conservative superset of what is actually handled by a given
agent.

> 
> > +	size -= 1;
> > +
> > +	writel(lower_32_bits(addr), soc_hha->base + HISI_HHA_START_L);
> > +	writel(upper_32_bits(addr), soc_hha->base + HISI_HHA_START_H);
> > +	writel(lower_32_bits(size), soc_hha->base + HISI_HHA_LEN_L);
> > +	writel(upper_32_bits(size), soc_hha->base + HISI_HHA_LEN_H);
> > +
> > +	reg = FIELD_PREP(HISI_HHA_CTRL_TYPE, 1); /* Clean Invalid */
> > +	reg |= HISI_HHA_CTRL_RANGE | HISI_HHA_CTRL_EN;
> > +	writel(reg, soc_hha->base + HISI_HHA_CTRL);
> > +
> > +	return 0;
> > +}
> > +
> > +static int hisi_soc_hha_done(struct cache_coherency_ops_inst *cci)
> > +{
> > +	struct hisi_soc_hha *soc_hha =
> > +		container_of(cci, struct hisi_soc_hha, cci);
> > +
> > +	guard(mutex)(&soc_hha->lock);
> > +	if (!hisi_hha_cache_maintain_wait_finished(soc_hha))
> > +		return -ETIMEDOUT;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct cache_coherency_ops hha_ops = {
> > +	.wbinv = hisi_soc_hha_wbinv,
> > +	.done = hisi_soc_hha_done,
> > +};
> > +
> > +static int hisi_soc_hha_probe(struct platform_device *pdev)
> > +{
> > +	struct hisi_soc_hha *soc_hha;
> > +	struct resource *mem;
> > +	int ret;
> > +
> > +	soc_hha = cache_coherency_ops_instance_alloc(&hha_ops,
> > +						     struct hisi_soc_hha, cci);
> > +	if (!soc_hha)
> > +		return -ENOMEM;
> > +
> > +	platform_set_drvdata(pdev, soc_hha);
> > +
> > +	mutex_init(&soc_hha->lock);
> > +
> > +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!mem) {
> > +		ret = -ENOMEM;
> > +		goto err_free_cci;
> > +	}
> > +
> > +	/*
> > +	 * HHA cache driver share the same register region with HHA uncore PMU
> > +	 * driver in hardware's perspective, none of them should reserve the
> > +	 * resource to itself only.  Here exclusive access verification is
> > +	 * avoided by calling devm_ioremap instead of devm_ioremap_resource to  
> 
> The comment here doesn't exactly match the code, dunno if you went away
> from devm some reason and just forgot to to make the change or the other
> way around? Not a big deal obviously, but maybe you forgot to do
> something you intended doing. It's mentioned in the commit message too.

Ah. Indeed stale comment, I'll drop that.

Going away from devm was mostly a hang over from similar discussions in fwctl
where I copied the pattern of embedded device(there)/kref(here) and reluctance
to hide way the final put().

> 
> Other than the question I have about the multi-"agent" stuff, this
> looks fine to me. I assume it's been thought about and is fine for w/e
> reason, but I'd like to know what that is.

I'll see if I can craft a short intro bit of documentation for the
top of this driver file to state clearly that there are lots of instances
of this in a system and that a requests to clear something that isn't 'theirs'
results in a NOP.  Better to have that available so anyone writing
a similar driver thinks about whether that applies to what they have or
if they need to do in driver filtering.

> 
> Cheers,
> Conor.

Thanks!

Jonathan
> 
> > +	 * allow both drivers to exist at the same time.
> > +	 */
> > +	soc_hha->base = ioremap(mem->start, resource_size(mem));
> > +	if (!soc_hha->base) {
> > +		ret = dev_err_probe(&pdev->dev, -ENOMEM,
> > +				    "failed to remap io memory");
> > +		goto err_free_cci;
> > +	}
> > +
> > +	ret = cache_coherency_ops_instance_register(&soc_hha->cci);
> > +	if (ret)
> > +		goto err_iounmap;
> > +
> > +	return 0;
> > +
> > +err_iounmap:
> > +	iounmap(soc_hha->base);
> > +err_free_cci:
> > +	cache_coherency_ops_instance_put(&soc_hha->cci);
> > +	return ret;
> > +}
> > +
> > +static void hisi_soc_hha_remove(struct platform_device *pdev)
> > +{
> > +	struct hisi_soc_hha *soc_hha = platform_get_drvdata(pdev);
> > +
> > +	cache_coherency_ops_instance_unregister(&soc_hha->cci);
> > +	iounmap(soc_hha->base);
> > +	cache_coherency_ops_instance_put(&soc_hha->cci);
> > +}  
> 


