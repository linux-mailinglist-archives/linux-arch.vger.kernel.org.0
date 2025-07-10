Return-Path: <linux-arch+bounces-12630-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D2BAFFFEF
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 13:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68BC17BD7FE
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 10:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A382E427B;
	Thu, 10 Jul 2025 10:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QSvH7+i+"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4924324501E;
	Thu, 10 Jul 2025 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145191; cv=none; b=Ac5u6BWgKfhNj5NY0XZFgSbVRpdYJMyt6GlByHjznv+K/huIx3IH6VS2eml3gWCONT/P7al7onY4t/9TM7sOtkH+xRj+SugfVyWfhz3kKrU58XT2jiRHiCEs1WfUvDMKRcBmyRn8x6LH7IfXKqqzItEU4NSQXSXn5Dbx/pscGRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145191; c=relaxed/simple;
	bh=VmWjPE7D3mF+0RXhrRJoYzPbnQ2jl43nEJ1OVAPJTsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ey4UyviAyy8LvLED+2kRO8tX1m1q0alAYHpMuOMyXPm2r6o2VJljC3oysmJPC/s96u/TEPSb1ofHPDnND8HQJ0AJJJ1VLMqWNzE4zN3pzvenw5AS5pFcXGbajOlioVXZh0+H05MuuKXzaGDzgIZ8+xYB0cpzIgogpijtO5z7XgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QSvH7+i+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VmWjPE7D3mF+0RXhrRJoYzPbnQ2jl43nEJ1OVAPJTsw=; b=QSvH7+i+KZyp2mLIqa9KeKnzA4
	mJZ92k/0ULwFm/FdAzd4OQ3kGLbT0N5z9IOFdfb9jDjc/Tyi/6I1b24P4ErNTGMH4peSvitmNgLv/
	iAcAM5G4NdfT21r/fGCTBE9Zn8z6C8lHYGQhaXZbBJ7vlSb/IJ+cf6ARfwEf1uL1jCFvyrF+7aI1W
	1ASrbFUkb+lhPEF7+h8H7rRYkJLimKy+6euvBLC0qPcpwCx/8TeuPGM07wua5kn/6thpPpJN5nHM9
	5OhgqFrBqPla0VazZTb5egiyT7OJPMta1+Ywk0ly/YJ4Dk7Gn0aFiM0VeCLzD3opdK5OLJSTwPou5
	iYhkkGMw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZozk-00000009067-2kW4;
	Thu, 10 Jul 2025 10:59:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6A644300125; Thu, 10 Jul 2025 12:59:13 +0200 (CEST)
Date: Thu, 10 Jul 2025 12:59:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: dan.j.williams@intel.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linuxarm@huawei.com,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
	linux-cxl@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org,
	Will Deacon <will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Yicong Yang <yangyicong@huawei.com>,
	Yushan Wang <wangyushan12@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 0/8] Cache coherency management subsystem
Message-ID: <20250710105913.GB542000@noisy.programming.kicks-ass.net>
References: <20250624154805.66985-1-Jonathan.Cameron@huawei.com>
 <20250625085204.GC1613200@noisy.programming.kicks-ass.net>
 <FB7122A4-BF5E-4C05-805A-2EE3240286A1@zytor.com>
 <20250625093152.GZ1613376@noisy.programming.kicks-ass.net>
 <20250625180343.000020de@huawei.com>
 <20250626105530.000010be@huawei.com>
 <686f506020726_1d3d10069@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <686f506020726_1d3d10069@dwillia2-xfh.jf.intel.com.notmuch>

On Wed, Jul 09, 2025 at 10:32:16PM -0700, dan.j.williams@intel.com wrote:

> Theoretically there could be a threshold at which a CLFLUSHOPT loop is a
> better option, but I would rather it be the case* that software CXL
> cache management is stop-gap for early generation CXL platforms.

So isn't the problem that CLFLUSH and friends take a linear address
rather than a physical address? I suppose we can use our 1:1 mapping in
this case, is all of CXL in the 1:1 map?

