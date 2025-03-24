Return-Path: <linux-arch+bounces-11058-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D1DA6D9A8
	for <lists+linux-arch@lfdr.de>; Mon, 24 Mar 2025 13:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C0C167C42
	for <lists+linux-arch@lfdr.de>; Mon, 24 Mar 2025 12:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA45209F2D;
	Mon, 24 Mar 2025 12:00:52 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD62F18D65F;
	Mon, 24 Mar 2025 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742817652; cv=none; b=aqWXGq/aAKwtCSRwJUrc3O9njQEVyRWV78i97PenebhoLdWeYAPPAvvBc3Jbq8Ef9IngN6ZXOLmNU12zTx3PP2y1ROekM0Gh2ZpIJetzOmXly8JpCIYrK514eiwKhBetyxSZGG2TFCY/qc9Df4lMUT+5tmW7De3GGchFSud+y70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742817652; c=relaxed/simple;
	bh=4z9ekr9axEjl595SBoFrIRppYmPBGV4MEUDc3iGBkEs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tT5DvifXJwU8TkLVD6G1RTtDt8Gp0U+VnOHKs2Sm4X0FVCsC2kV0Q5iO+ziTe7yqWUQhlH42I/QK3bdspiawtyhmawgw/sA1RA8bTHaeWJPDRyp1FdW8+gM+LVFHWMIwPA3T+lNLl3jplpJWeINNYxROQLvLywH7e/qqr2JQjGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZLs415Lnbz6M4ly;
	Mon, 24 Mar 2025 19:57:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 48F591400D4;
	Mon, 24 Mar 2025 20:00:47 +0800 (CST)
Received: from localhost (10.48.158.58) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 24 Mar
 2025 13:00:44 +0100
Date: Mon, 24 Mar 2025 12:00:40 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Conor Dooley <conor@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<james.morse@arm.com>, Yicong Yang <yangyicong@huawei.com>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linuxarm@huawei.com>, Yushan Wang <wangyushan12@huawei.com>,
	<linux-mm@kvack.org>, <gregkh@linuxfoundation.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Catalin
 Marinas" <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Dan
 Williams" <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 0/6] Cache coherency management subsystem
Message-ID: <20250324120040.00003d95@huawei.com>
In-Reply-To: <20250321-failing-squatted-37a88909bde2@spud>
References: <20250320174118.39173-1-Jonathan.Cameron@huawei.com>
	<20250321-failing-squatted-37a88909bde2@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 21 Mar 2025 22:32:15 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Thu, Mar 20, 2025 at 05:41:12PM +0000, Jonathan Cameron wrote:
> > Note that I've only a vague idea of who will care about this
> > so please do +CC others as needed.
> > 
> > On x86 there is the much loved WBINVD instruction that causes a write back
> > and invalidate of all caches in the system. It is expensive but it is
> > necessary in a few corner cases. These are cases where the contents of
> > Physical Memory may change without any writes from the host. Whilst there
> > are a few reasons this might happen, the one I care about here is when
> > we are adding or removing mappings on CXL. So typically going from
> > there being actual memory at a host Physical Address to nothing there
> > (reads as zero, writes dropped) or visa-versa. That involves the
> > reprogramming of address decoders (HDM Decoders); in the near future
> > it may also include the device offering dynamic capacity extents. The
> > thing that makes it very hard to handle with CPU flushes is that the
> > instructions are normally VA based and not guaranteed to reach beyond
> > the Point of Coherence or similar. You might be able to (ab)use
> > various flush operations intended to ensure persistence memory but
> > in general they don't work either.
> > 
> > So on other architectures such as ARM64 we have no instruction similar to
> > WBINVD but we may have device interfaces in the system that provide a way
> > to ensure a PA range undergoes the write back and invalidate action. This
> > RFC is to find a way to support those cache maintenance device interfaces.
> > The ones I know about are much more flexible than WBINVD, allowing
> > invalidation of particular PA ranges, or a much richer set of flush types
> > (not supported yet as not needed for upstream use cases).
> > 
> > To illustrate how a solution might work, I've taken both a HiSilicon
> > design (slight quirk as registers overlap with existing PMU driver)
> > and more controversially a firmware interface proposal from ARM
> > (wrapped up in made up ACPI) that was dropped from the released spec
> > but for which the alpha spec is still available.
> > 
> > Why drivers/cache?
> > - Mainly because it exists and smells like a reasonable place.
> > - Conor, you are maintainer for this currently do you mind us putting this
> >   stuff in there?  
> 
> drivers/cache was just something to put the cache controller drivers we
> have on RISC-V that implement the various arch_dma*() callbacks in
> non-standard ways that made more sense than drivers/soc/<soc vendor>
> since the controllers are IP provided by CPU vendors. There's only
> two drivers here now, but I am aware of another two non-standard CMO
> mechanisms if the silicon with them so there'll likely be more in the
> future :) I'm only really maintainer of it to avoid it being another
> thing for Palmer to look after :)

I suspected as much :)

> 
> I've only skimmed this for now, but I think it is reasonable to put them
> here. Maybe my skim is showing, but it would not surprise me to see a
> driver providing both non-standard arch_dma*() callbacks as well as
> dealing with CXL mappings via this new class on RISC-V in the future..

Absolutely.  The use of an ARM callback was just a place holder for now
(Greg pointed that one out as well as I forgot to mention it in the patch
description!)

I think this will turn out to be at least some subset of implementations
for other architectures unless they decide to go the route of an instruction
(like x86).

> Either way, I think it'd probably be a good idea to add ?you? as a
> co-maintainer if the directory is going to be used for your proposed
> interface/drivers, for what I hope is an obvious reason!

Sure.  That would make sense.

Jonathan
> 


