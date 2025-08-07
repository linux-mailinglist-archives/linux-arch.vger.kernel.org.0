Return-Path: <linux-arch+bounces-13091-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAAEB1DB53
	for <lists+linux-arch@lfdr.de>; Thu,  7 Aug 2025 18:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8BE17A227
	for <lists+linux-arch@lfdr.de>; Thu,  7 Aug 2025 16:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D5226D4CE;
	Thu,  7 Aug 2025 16:07:56 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED84262FE6;
	Thu,  7 Aug 2025 16:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754582876; cv=none; b=nhUfdbd1aZDvBJzo1LEXHqq8douxcBKt0kR2GwbK4m028uMf7YLH3h39pKFxdT/3okx4UW5Bo/k2dMJP9iRCZxsrPlqcOVVSBe3J/PBgzENXAZwnpVPYCpaooGwhqs94wTMfAGgrw0Ork6Q13vjOCoqrA5tNY5sGTa9YbWsISkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754582876; c=relaxed/simple;
	bh=77Bd6MO+vxw+YiKm4kwM/UmJlRBOODqMevD0aSGVdNA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pa2xJdkq5WODk63pU9cPflR4zG9sDGuVhSgqA/1ov29NwtrxStz5nnpiEQLA2pp4mmM5ZVzq64xqm0ay1HSKmPXnGmueq+Q0HZdfoX4WpvcIfjuHMvRWYxrnUDFroKLL6g8rsc6ewkNDBP174NjH2JgE08eaqweVQKm8esmwkDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4byX894865z6DB6D;
	Fri,  8 Aug 2025 00:06:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5CAF11402EA;
	Fri,  8 Aug 2025 00:07:50 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 7 Aug
 2025 18:07:49 +0200
Date: Thu, 7 Aug 2025 17:07:47 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <dan.j.williams@intel.com>, <linuxarm@huawei.com>
CC: Catalin Marinas <catalin.marinas@arm.com>, <james.morse@arm.com>,
	<linux-cxl@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, <gregkh@linuxfoundation.org>, Will Deacon
	<will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Yicong Yang
	<yangyicong@huawei.com>, Yushan Wang <wangyushan12@huawei.com>, "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	<x86@kernel.org>, H Peter Anvin <hpa@zytor.com>, "Andy Lutomirski"
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/8] generic: Support
 ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
Message-ID: <20250807170704.00002ff2@huawei.com>
In-Reply-To: <20250711125218.000050bf@huawei.com>
References: <20250624154805.66985-1-Jonathan.Cameron@huawei.com>
	<20250624154805.66985-3-Jonathan.Cameron@huawei.com>
	<686f565121ea5_1d3d100ee@dwillia2-xfh.jf.intel.com.notmuch>
	<20250711125218.000050bf@huawei.com>
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

> > > +bool cpu_cache_has_invalidate_memregion(void)
> > > +{
> > > +	guard(spinlock_irqsave)(&scfm_lock);
> > > +	return !!scfm_data;    
> > 
> > Lock seems pointless here.
> > 
> > More concerning is this diverges from the original intent of this
> > function which was to disable physical address space manipulation from
> > virtual environments.  
> 
> Sure. We don't loose that - it just moved out to the registration framework
> for devices.  If a future VM actually wants to expose paravirt interfaces
> via device emulation then they can.
> 
> Maybe we can call from here to see if any device drivers actually registered.
> That's not a guarantee that all relevant ones did (yet) but it at least
> will result in warnings for the virtual machine case.
>
> > 
> > Now, different archs may have reason to diverge here but the fact that
> > the API requirements are non-obvious points at a minimum to missing
> > documentation if not missing cross-arch consensus.  
> 
> I'll see if I can figure out appropriate documentation for that.
> 

Hi Dan, 

I'm struggling a little for what these requirements should be (and hence the
documentation).  Do you think having the possibility for us to go from returning
that we have no support to later returning that we have support as additional
drivers arrive is acceptable? Potentially the opposite as well if someone is
unbinding the drivers.

So for x86 it's simple as you use an explicit cpu feature check on whether
it is in a hypervisor. For architectures using explicit 'drivers' (because
the interface is in MMIO or similar) there need be no difference between
the 'is it a VM' check and the 'do we have the hardware'.

If someone chooses to emulate (or pass through) the hardware interface then
they get to make it do something sane.

On a somewhat related note, I don't yet have a good answer for how, in
a complex system we know all the drivers have arrived and hence the
flush will be complete once they all acknowledge.

Could do an ACPI _DSM that returns a list of IDs and check drivers are
bound to them but would need to get that into some spec or other
which might take a while.

For now I'm taking the view that there are many ways to shoot yourself
in a the foot if you can control driver binding, so this isn't a blocker,
more of a nice to have.

I'll send out the new (simpler) code next week (so post rc1)

Jonathan

