Return-Path: <linux-arch+bounces-12452-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EB5AE7DB5
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jun 2025 11:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8941D1C22FA7
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jun 2025 09:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CD92BE7AF;
	Wed, 25 Jun 2025 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T0hKL8t6"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3936729A323;
	Wed, 25 Jun 2025 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843937; cv=none; b=GA0fsGDOGanFke4+Ea3tqZ7z4s3vEhCBYMc/bvkN3uWPumexfAZ6Rrk4qi4TM+WJFbtAJ7nXV3WuD5TCVqoevIE3N1N4ud9OrdIXPQ1yqqUrszC6lw5qizbvfS809Wlz5acW0jdpXiov2RHEZ3wXCvggvJkmuu2Fe/Kt1v7upSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843937; c=relaxed/simple;
	bh=wmlo0i7y7J244aINLuThG1MyR6ZNiLk68WnvjJsz/Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHr78eUSx4dii6UFBvW7/nxf4TuHiVytac4CaS83H5dgGJXPDq6lU7usv9h60LAyDPUFx1tE7qBNizZIa1SpGeM+CQZd2q0By3U2QCoNk76p4eoJFrvr/kIHSdJOUn4fYNoS3VKX+iwrca+1hGPgl2zfUJZTzVdSADVq2+PbFKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T0hKL8t6; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=51MXSIz01v2zZUYglT8WCA+VxWNWBxG8GinukyiOxuM=; b=T0hKL8t6mooi63qc6S+et8AjEC
	NVwOjCyKJ0NVeoGkxhfxlkPSOEAwqvdXxiNgnbDwJcu527SaM1mxQWC/cKtInWKKMKBvmZpCmV2EA
	eAUPbUBIq1el0HbcRgXOzWAFWBzG8vI9Mzv9p70J/3QX1dfYCIT+6sPBPTEarR3OOXBuazAbLLQFy
	xDBGoQ/8cJO91/xRVEMwE5PZCMfGvIkC8yKJoLjx4Ml8zhQfEQ8SV4LMlS7voq7Xcs8iUG8+wrEP0
	qJ0amzUljiPfMKhQGnEVcPhAbjynpeywC4kz46mj82jGmUDPssxzsKj3oXfYGWCn4oTEj0ccQHFyj
	97KGRIwg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUMTy-00000005joy-1YGc;
	Wed, 25 Jun 2025 09:31:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C64AD308983; Wed, 25 Jun 2025 11:31:52 +0200 (CEST)
Date: Wed, 25 Jun 2025 11:31:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
	linux-cxl@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org,
	Will Deacon <will@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Yicong Yang <yangyicong@huawei.com>, linuxarm@huawei.com,
	Yushan Wang <wangyushan12@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 0/8] Cache coherency management subsystem
Message-ID: <20250625093152.GZ1613376@noisy.programming.kicks-ass.net>
References: <20250624154805.66985-1-Jonathan.Cameron@huawei.com>
 <20250625085204.GC1613200@noisy.programming.kicks-ass.net>
 <FB7122A4-BF5E-4C05-805A-2EE3240286A1@zytor.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FB7122A4-BF5E-4C05-805A-2EE3240286A1@zytor.com>

On Wed, Jun 25, 2025 at 02:12:39AM -0700, H. Peter Anvin wrote:
> On June 25, 2025 1:52:04 AM PDT, Peter Zijlstra <peterz@infradead.org> wrote:
> >On Tue, Jun 24, 2025 at 04:47:56PM +0100, Jonathan Cameron wrote:
> >
> >> On x86 there is the much loved WBINVD instruction that causes a write back
> >> and invalidate of all caches in the system. It is expensive but it is
> >
> >Expensive is not the only problem. It actively interferes with things
> >like Cache-Allocation-Technology (RDT-CAT for the intel folks). Doing
> >WBINVD utterly destroys the cache subsystem for everybody on the
> >machine.
> >
> >> necessary in a few corner cases. 
> >
> >Don't we have things like CLFLUSH/CLFLUSHOPT/CLWB exactly so that we can
> >avoid doing dumb things like WBINVD ?!?
> >
> >> These are cases where the contents of
> >> Physical Memory may change without any writes from the host. Whilst there
> >> are a few reasons this might happen, the one I care about here is when
> >> we are adding or removing mappings on CXL. So typically going from
> >> there being actual memory at a host Physical Address to nothing there
> >> (reads as zero, writes dropped) or visa-versa. 
> >
> >> The
> >> thing that makes it very hard to handle with CPU flushes is that the
> >> instructions are normally VA based and not guaranteed to reach beyond
> >> the Point of Coherence or similar. You might be able to (ab)use
> >> various flush operations intended to ensure persistence memory but
> >> in general they don't work either.
> >
> >Urgh so this. Dan, Dave, are we getting new instructions to deal with
> >this? I'm really not keen on having WBINVD in active use.
> >
> 
> WBINVD is the nuclear weapon to use when you have lost all notion of
> where the problematic data can be, and amounts to a full reset of the
> cache system. 
> 
> WBINVD can block interrupts for many *milliseconds*, system wide, and
> so is really only useful for once-per-boot type events, like MTRR
> initialization.

Right this... But that CXL thing sounds like that's semi 'regular' to
the point that providing some infrastructure around it makes sense. This
should not be.

