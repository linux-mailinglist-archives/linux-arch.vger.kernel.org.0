Return-Path: <linux-arch+bounces-9570-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A04A00862
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jan 2025 12:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C333A32C3
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jan 2025 11:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6561F9EBB;
	Fri,  3 Jan 2025 11:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tf96QP1n"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F83D1C8FB4;
	Fri,  3 Jan 2025 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735902917; cv=none; b=EJ56HUdhQAxSnZnAdteHLgtSgUbYjV+ivHvkIK47U+PzNeEU9H3iAvJKhDSyZXGEYmW27yyjllIY23efjx622zaXmXw8WAHMhscEgMdtlN+BtE72lBhg7Fu/sfHiGn+A9bvmrBwlBSrHHaTOES+A4XBjqR5p7NsNOWpVoNLKoAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735902917; c=relaxed/simple;
	bh=/7y3mM4jq5ZFPb8rK3oYjsNkhMjCwwWF586A1GZ7fHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qD0O8T142uNTDFpV9NJ5t/fe38LK/xhOHn3nB0xdNYMOl/oqeuwhQy6avoEnLGcBx1QsdjMxUPNvZlsWDnk03AiKMG3F/VLtAtEiMRKYyH8Xc6XrNcAzmpqFmqDprE34o5ifOWsWlM0MzU+GDiwp1S/vM/99YcGl9f1cZobDcrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Tf96QP1n; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CPGOdr/jsXJNO5Wu3fEBGF99GP73lSQF/IKxQW4k0R4=; b=Tf96QP1nI5zee8m+i5u3CA94h9
	3PVNNoLdvhSBk2t6LZQP6KHn1+Y/Ig9kK3lwT2hFjHWgZiqq3VK4SzqQBmD6A0e29acKD8NJDsAzp
	PBklhel75TRoOCf5VTzc00lXza1eWj1sW19Tjleo1fc/L5i9P5juDXyKQY9kHKExje/1wAmmZkrHj
	FdESUWBGwWEamk3EA3c0+gwV4EPoveBGXJo3r+051uO72Cz+2Bir5nMUbKQ2FfpEvF0r1gyVxRelx
	Ro4i1hRHlfJmHnjxqwmbD1SaYDgPeAH7HhcAneWE1IcOwP7nCEbEkp2xJxpa8O/6L3gNZJN11KFqb
	fYAj5NUQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tTfdp-00000005j4l-1npS;
	Fri, 03 Jan 2025 11:14:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3EDFC3003AF; Fri,  3 Jan 2025 12:14:57 +0100 (CET)
Date: Fri, 3 Jan 2025 12:14:57 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>, agordeev@linux.ibm.com,
	kevin.brodsky@arm.com, tglx@linutronix.de, david@redhat.com,
	jannh@google.com, hughd@google.com, yuzhao@google.com,
	willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
	lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
	rientjes@google.com, vishal.moola@gmail.com, arnd@arndb.de,
	will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
	dave.hansen@linux.intel.com, ryan.roberts@arm.com,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: Re: [PATCH v3 15/17] mm: pgtable: remove tlb_remove_page_ptdesc()
Message-ID: <20250103111457.GC22934@noisy.programming.kicks-ass.net>
References: <cover.1734945104.git.zhengqi.arch@bytedance.com>
 <b37435768345e0fcf7ea358f69b4a71767f0f530.1734945104.git.zhengqi.arch@bytedance.com>
 <Z2_EPmOTUHhcBegW@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2_EPmOTUHhcBegW@kernel.org>

On Sat, Dec 28, 2024 at 11:26:22AM +0200, Mike Rapoport wrote:
> On Mon, Dec 23, 2024 at 05:41:01PM +0800, Qi Zheng wrote:
> > Here we are explicitly dealing with struct page, and the following logic
> > semms strange:
> > 
> > tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));
> > 
> > tlb_remove_page_ptdesc
> > --> tlb_remove_page(tlb, ptdesc_page(pt));
> > 
> > So remove tlb_remove_page_ptdesc() and make callers call tlb_remove_page()
> > directly.
> 
> Please don't. The ptdesc wrappers are there as a part of reducing the size
> of struct page project [1]. 
> 
> For now struct ptdesc overlaps struct page, but the goal is to have them
> separate and always operate on struct ptdesc when working with page tables.

I don't see how the current idiotic code helps with that at all.

Fundamentally tlb_remove_page() is about removing *pages* as from a PTE,
there should not be a page-table anywhere near here *ever*.

Yes, some architectures use tlb_remove_page() for page-tables too, but
that is more or less an implementation detail that can be fixed.

So no, please keep these patches and kill this utterly idiotic code.

The only thing that should eventually care about page-tables is
tlb_remove_table(), and that takes a 'void *' and is expected to match
whatever __tlb_remove_table() does.

Flipping those to pgdesc, once its actually a thing, should be fairly
straight forward.

