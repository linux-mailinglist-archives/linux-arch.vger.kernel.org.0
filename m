Return-Path: <linux-arch+bounces-14296-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09574C01248
	for <lists+linux-arch@lfdr.de>; Thu, 23 Oct 2025 14:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9713418C4573
	for <lists+linux-arch@lfdr.de>; Thu, 23 Oct 2025 12:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2752E2DDE;
	Thu, 23 Oct 2025 12:31:46 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DC7303A2B;
	Thu, 23 Oct 2025 12:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761222706; cv=none; b=H0dfNPJDtivbt6a5xgEHdNu67XJCuM34iaXSeEwtXxlE4brZB9HLULJ2d9el78Ty53uk0VVcjvn77ca0GdEbYVKVpB/P4Hw4IGXsngmGcGbuBwMaZrTkprU9dc+wEuFtm/ztyG8PNbdi5ua24ygyaCcJJ4ERNszthZr1Za2taqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761222706; c=relaxed/simple;
	bh=cckBZtd997Irn2BQ+U3XNFKXD3yAPJ9xh7JsSRovh6w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQgS/k3UwigQ8RBtJMhThoI4EMicHmqghI8zmqluxyjbHCpyFqHcbaSrjQ9UnnTfCvHE5tvuy9M8FRJeAEbYGp14AlDwKodvJQQ0kE0RnV1u1h6pdWJ4tcN/BK5MOeqme5fWJWCNIgqUM+s6WkVfzoLYCpD+dLWGzM9gMTsgDC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4csljb4ypmz6L4tf;
	Thu, 23 Oct 2025 20:30:11 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A77814010C;
	Thu, 23 Oct 2025 20:31:39 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Oct
 2025 13:31:38 +0100
Date: Thu, 23 Oct 2025 13:31:36 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: Conor Dooley <conor@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, <linux-cxl@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, Dan Williams <dan.j.williams@intel.com>, "H . Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
	<james.morse@arm.com>, Will Deacon <will@kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, <linuxarm@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, Andy Lutomirski
	<luto@kernel.org>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v4 0/6] Cache coherency management subsystem
Message-ID: <20251023133136.00006cdd@huawei.com>
In-Reply-To: <20251022122241.d2aa0d7864f67112aa7691bf@linux-foundation.org>
References: <20251022113349.1711388-1-Jonathan.Cameron@huawei.com>
	<20251022122241.d2aa0d7864f67112aa7691bf@linux-foundation.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 22 Oct 2025 12:22:41 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 22 Oct 2025 12:33:43 +0100 Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > Support system level interfaces for cache maintenance as found on some
> > ARM64 systems. This is needed for correct functionality during various
> > forms of memory hotplug (e.g. CXL). Typical hardware has MMIO interface
> > found via ACPI DSDT.
> > 
> > Includes parameter changes to cpu_cache_invalidate_memregion() but no
> > functional changes for architectures that already support this call.  

Hi Andrew,

> 
> I see additions to lib/ so presumably there is an expectation that
> other architectures might use this.

Absolutely. It's not ARM specific in any way. Given, in at least some
implementations, it is part of the coherency fabric and there are
examples in the past of people mixing and matching those with CPU
architectures, it's more than possible a given driver might be applicable
across different CPU architectures.

> 
> Please expand on this.  Any particular architectures in mind?  Any
> words of wisdom which maintainers of those architectures might benefit
> from?

My initial guess for a second architecture using it would be RiscV
but I don't know if anyone yet cares about the any of the use cases.

The short answer is that it depends on whether the architecture
requires 'one solution' or leaves it as a system problem where
a driver needs to be loaded to suit the particular implementation.

Longer answer follows:

There are two aspects to when people might find this useful to
consider

A) The use case.  For it to apply to an architecture you need to have
   a requirement to support the case of content of memory presented
   at a PA to change without the host explicitly writing it.  That
   can happen for various reasons.
   - Late exposure of memory - security keys for pmem for instance.
     Until those are programmed any prefetchers will fill caches
     with garbage that needs clearing out.
   - Reprogramming of address decoders beyond the edge of where the
     Host Physical Addresses define what goes on.  This is the CXL
     case where there is a translation from Host Physical Address
     to Device Physical address which can change at runtime.
   - (not yet enabled) Interhost sharing without hw coherency. Necessary
     to flush local caches because someone changed the data under the
     hood. Because this happened beyond the scope of the local host
     normal cache flushing instructions might not do the job.
     Hopefully we will have lighter weight solutions for this.
So upshot today is that it is likely to only apply to server architectures.

B) Is there an architected solution for that architecture. (i.e. is it
   in the CPU architecture spec) If there is 'one solution', then
   registering the arch callbacks directly is sufficient. This is
   true for x86 as there is a CPU instruction that performances the
   relevant operations.

Arm decided (for now) to not go down the path of architecting this
in one of their architecture specs that licensees would then have
to comply with (I'll let James / others add more on that if they want).
There were already being multiple hardware IPs out there that providing
this feature as part of the coherency fabrics.  Earlier versions of
this series mentioned an attempt to provide a firmware interface to
hide away the complexity but that also turned out to be unnecessary
as everyone with a usecase had memory mapped devices the kernel can
directly control.

So there will be multiple different implementations on ARM servers.
I doubt we'll even keep it completely consistent across different
HiSilicon CPU generations. As per the discussion with Conor, there
are multiple agents each of which registers separately and has
no knowledge of the other instances. For now the ones I know of
are homogeneous for a given server, but it made no difference to
allow for heterogeneous cases (I emulated those to check).

So for other architectures, it is a case of which path do they want to
follow?  If they don't have existing instructions defined that work
for this, and have more than one implementer, then the approach seen
here should be useful. I think RiscV doesn't have such an instruction
so I'd expect this to be useful to them.  Not sure on other server
architectures as most of them today are much less diverse than ARM / RiscV
so a "one true solution" in an architecture spec is perhaps more likely.

In the various review rounds, we've had some discussion of the requirements
implied by the current simple interface (no ordering, single operation in
flight).  So I'd not be surprised if we have to make things a little
cleverer in the long run.  The HiSilicon HHA hardware interface is very simple
so I've supported what that (and the PSCI spec with sane options - see v3)
for now.

> 
> > How to merge?  When this is ready to proceed (so subject to review
> > feedback on this version), I'm not sure what the best route into the
> > kernel is. Conor could take the lot via his tree for drivers/cache but
> > the generic changes perhaps suggest it might be better if Andrew
> > handles this?  Any merge conflicts in drivers/cache will be trivial
> > build file stuff. Or maybe even take it throug one of the affected
> > trees such as CXL.  
> 
> Let's not split the series up.  Either CXL or COnor's tree is fine my
> me.

Thanks,

Jonathan
> 
> 


