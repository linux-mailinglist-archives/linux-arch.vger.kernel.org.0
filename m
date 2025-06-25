Return-Path: <linux-arch+bounces-12459-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F2DAE8B4E
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jun 2025 19:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2785518874BF
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jun 2025 17:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FE32DCC08;
	Wed, 25 Jun 2025 17:03:52 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D272DE1FE;
	Wed, 25 Jun 2025 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750871032; cv=none; b=TAulrDLtGmT4IPM+B30W8Du3bt5EUwJafeN03hU7NnH+hURCF/P/r07fCd6kKEN1XNYz8Vil5JugTPT7qB8AK0aNP7FImvsqs8vuHsQAoUsaF2XbqnHT0p8gOdAZWy2JjlAV29lX0TaFKKugt6+sTB6QmRHYmRmQfPg2g2mB98M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750871032; c=relaxed/simple;
	bh=qHpJQgFbSnWLpLMIEMXz/hPE0rhwCApGoNHwZnNsbBM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nAU8od0KuUeTGp9yJynIbp2vL1f88M5hkDwS1Xg6C0bhpnyeJzjKxIiHXYqFAMtnEFIuR7XXs+O4o/72GqtzzJf3LSn9IQN8Z2RfIyzHJY21A6oXJTWxuGDM4DXm2Z68OAdVeV8vkd9FYShnG1xUzjwAIxbEmu0SLva/mhxiU8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bS7Pk1vB4z6K9B9;
	Thu, 26 Jun 2025 01:01:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7DA671402EC;
	Thu, 26 Jun 2025 01:03:47 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 25 Jun
 2025 19:03:46 +0200
Date: Wed, 25 Jun 2025 18:03:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas
	<catalin.marinas@arm.com>, <james.morse@arm.com>,
	<linux-cxl@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, <gregkh@linuxfoundation.org>, Will Deacon
	<will@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Yicong Yang <yangyicong@huawei.com>,
	<linuxarm@huawei.com>, Yushan Wang <wangyushan12@huawei.com>, "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	<x86@kernel.org>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 0/8] Cache coherency management subsystem
Message-ID: <20250625180343.000020de@huawei.com>
In-Reply-To: <20250625093152.GZ1613376@noisy.programming.kicks-ass.net>
References: <20250624154805.66985-1-Jonathan.Cameron@huawei.com>
	<20250625085204.GC1613200@noisy.programming.kicks-ass.net>
	<FB7122A4-BF5E-4C05-805A-2EE3240286A1@zytor.com>
	<20250625093152.GZ1613376@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 25 Jun 2025 11:31:52 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Jun 25, 2025 at 02:12:39AM -0700, H. Peter Anvin wrote:
> > On June 25, 2025 1:52:04 AM PDT, Peter Zijlstra <peterz@infradead.org> wrote:  
> > >On Tue, Jun 24, 2025 at 04:47:56PM +0100, Jonathan Cameron wrote:
> > >  
> > >> On x86 there is the much loved WBINVD instruction that causes a write back
> > >> and invalidate of all caches in the system. It is expensive but it is  
> > >
> > >Expensive is not the only problem. It actively interferes with things
> > >like Cache-Allocation-Technology (RDT-CAT for the intel folks). Doing
> > >WBINVD utterly destroys the cache subsystem for everybody on the
> > >machine.
> > >  
> > >> necessary in a few corner cases.   
> > >
> > >Don't we have things like CLFLUSH/CLFLUSHOPT/CLWB exactly so that we can
> > >avoid doing dumb things like WBINVD ?!?
> > >  
> > >> These are cases where the contents of
> > >> Physical Memory may change without any writes from the host. Whilst there
> > >> are a few reasons this might happen, the one I care about here is when
> > >> we are adding or removing mappings on CXL. So typically going from
> > >> there being actual memory at a host Physical Address to nothing there
> > >> (reads as zero, writes dropped) or visa-versa.   
> > >  
> > >> The
> > >> thing that makes it very hard to handle with CPU flushes is that the
> > >> instructions are normally VA based and not guaranteed to reach beyond
> > >> the Point of Coherence or similar. You might be able to (ab)use
> > >> various flush operations intended to ensure persistence memory but
> > >> in general they don't work either.  
> > >
> > >Urgh so this. Dan, Dave, are we getting new instructions to deal with
> > >this? I'm really not keen on having WBINVD in active use.
> > >  
> > 
> > WBINVD is the nuclear weapon to use when you have lost all notion of
> > where the problematic data can be, and amounts to a full reset of the
> > cache system. 
> > 
> > WBINVD can block interrupts for many *milliseconds*, system wide, and
> > so is really only useful for once-per-boot type events, like MTRR
> > initialization.  
> 
> Right this... But that CXL thing sounds like that's semi 'regular' to
> the point that providing some infrastructure around it makes sense. This
> should not be.

I'm fully on board with the WBINVD issues (and hope for something new for
the X86 world). However, this particular infrastructure (for those systems
that can do so) is about pushing the problem and information to where it
can be handled in a lot less disruptive fashion. It can take 'a while' but
we are flushing only cache entries in the requested PA range. Other than
some potential excess snoop traffic if the coherency tracking isn't precise,
there should be limited affect on the rest of the system.

So, for the systems I particularly care about, the CXL case isn't that bad.

Just for giggles, if you want some horror stories the (dropped) ARM PSCI
spec provides for approaches that require synchronization of calls across
all CPUs.

"CPU Rendezvous" in the attributes of CLEAN_INV_MEMREGION requires all
CPUs to make a call within an impdef (discoverable) timeout.
https://developer.arm.com/documentation/den0022/falp1/?lang=en

I gather no one actually needs that on 'real' systems - that is systems
where we actually need to do these flushes! The ACPI 'RFC' doesn't support
that delight.

Jonathan


