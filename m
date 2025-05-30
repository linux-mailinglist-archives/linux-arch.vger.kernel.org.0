Return-Path: <linux-arch+bounces-12152-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463C1AC8A7A
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 11:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B69E7A5D77
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 09:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B087C21323C;
	Fri, 30 May 2025 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MAyTs0UH"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4642421D5AA;
	Fri, 30 May 2025 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748596168; cv=none; b=mqXezoi5wuNByqcoFgHfYCc/eSh7QY+aHQa86xL/zor2kVYea/AcqUu+It6Kb5CNM3iPPKR9Oy8f0m5OuZv6vdhH5asQnoj3z77s3bXynWpdYGqf2d530dOFAxI7QD4SIVVkPSeJ7dRqXyKxIQMnr4WYWZzXwl56TKLX6/AMcNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748596168; c=relaxed/simple;
	bh=zsGAJjYLsmPlm2wB128S10iUARQb+H7Mj+zl0TaQXas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qpo1GNO7eMlMI7kLQngETyVJ0X/alBLrEGz45zr3Yd2fNQlW2ajfCvOhvx1fqM/pMfa1ixcF0LhotjxJUHjLRo80Yq1BuBnRCGzOQTBpuTXQcXQVj2iwE3NBZRstWHzTpZHVcTFPyfocldX1v/rsFitRi/B+9RYr9K88x0HN9Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MAyTs0UH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KV51Tq5Hn+Qgevf9gWTDy9yyqkC2J2EnaAWxedH0XH0=; b=MAyTs0UHki9WYlSirqlJs3y03b
	ed1bGPuX5V/rH2Vac/Wcrz1fq1Z9pgmoiaCUX2Uf2v69+ASWAwUM5SSe8DDUpEgrqrOD/HGw/yBso
	KTV610rhBoZGwjPbhxwvGjOUzPrDK6UlVPUry41fDpMQUHNnAJPwf8aHibgYnXSjQ9ld0RYteqgTG
	C3oaoCV1ds+FDpuLm9LAlst6TTeX3RhnKbxKNW/sIW9zGCo7t+3jAlst5GZJxV1rJxykNODbUAexT
	N9kWq9RZDEJw+scmaRSmwJXMWR7xe5gTaqedSqE3PW5tYCeIkIFfq4ZJVMkjtim24JmuPmJCh6mww
	bxWnBZ+Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKvjt-0000000FeW1-1Dxy;
	Fri, 30 May 2025 09:09:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A5B2030066A; Fri, 30 May 2025 11:09:20 +0200 (CEST)
Date: Fri, 30 May 2025 11:09:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	Jann Horn <jannh@google.com>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v6] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP
 vmas into free_pgtables()
Message-ID: <20250530090920.GB21197@noisy.programming.kicks-ass.net>
References: <20250522012838.163876-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522012838.163876-1-roman.gushchin@linux.dev>

On Thu, May 22, 2025 at 01:28:38AM +0000, Roman Gushchin wrote:
> Commit b67fbebd4cf9 ("mmu_gather: Force tlb-flush VM_PFNMAP vmas")
> added a forced tlbflush to tlb_vma_end(), which is required to avoid a
> race between munmap() and unmap_mapping_range(). However it added some
> overhead to other paths where tlb_vma_end() is used, but vmas are not
> removed, e.g. madvise(MADV_DONTNEED).
> 
> Fix this by moving the tlb flush out of tlb_end_vma() into new
> tlb_flush_vmas() called from free_pgtables(), somewhat similar to the
> stable version of the original commit:
> commit 895428ee124a ("mm: Force TLB flush for PFNMAP mappings before
> unlink_file_vma()").
> 
> Note, that if tlb->fullmm is set, no flush is required, as the whole
> mm is about to be destroyed.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

