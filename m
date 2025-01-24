Return-Path: <linux-arch+bounces-9879-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4667A1B27E
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2025 10:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B6F3A434B
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2025 09:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB661DB137;
	Fri, 24 Jan 2025 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GMoPNTxh"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A47320B;
	Fri, 24 Jan 2025 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737710504; cv=none; b=CS4emFYuzCFCFhrJlrNbOf6zdjK7ZncX4n7yjRlFHciJYLfhmZRxxUgqythFLSCloLnszfPg2zzojOSWrSik6RruaM9GCLRfmLCbNlIPVx9FlQogq/GysKF6xnc+taJaMTbZfjElz2kTPkNYive5KQn0z2SnuXfGeT6tu+T5WzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737710504; c=relaxed/simple;
	bh=j56GNBYo6KQ/LUfE8WYqENsW2DbPRJbcgMZwFsCI07E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9AXcCeaG82GLitmCzUyTHMqB4H4wuTVwHphQX8bIS3QhjMJVIuk21Ccfpb+IoLhj+AgHcQx/GJOrs8QuCudeV/vVfIEjy1SRMnsvVz48ed1Ir5U5QDZwlRgt2GTPtIwoXOHCswk4ysmDvjaJ8dxcIC23GKeDAOf0cTzSM54Q0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GMoPNTxh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/+M5Ubh5p8DlqI6wZwc5gaFWz2GtMxNLGDwH0dogozY=; b=GMoPNTxhr/YokXcKKjTQyIc+eh
	2qh1YFGLccsKNzCDmVLy1f7veNKJABJyovmOjx8po0PfpHIfg6gAmLiWeUhEZi2YMETVnHjCOIBLp
	aoed7lxLwExrJt6rIEGhKQXQt9qyZlsqIcDHctPUc9GdBWp6ZPQuiG41HVDuP5WqQUDRE+yiuFfEh
	pDLUrMW/BFeWruqC599mHvbhrXB2rflZeT+ThdB+eE/dKQM0uxraFBZay1AlZTl/eeGWjbloFna4/
	ibt0WCkrzrOj2tCiWzgY58ff0Vcs6aKYv3McG3FBdfBcrTlRzkpwwhMtTfvX0H6v4njJTuWisC72b
	Ujgly4Pw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tbFc7-0000000EhjW-2qWi;
	Fri, 24 Jan 2025 09:04:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 12FEB300619; Fri, 24 Jan 2025 10:04:31 +0100 (CET)
Date: Fri, 24 Jan 2025 10:04:31 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Hugh Dickins <hughd@google.com>
Cc: Jann Horn <jannh@google.com>, Roman Gushchin <roman.gushchin@linux.dev>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP
 vmas into free_pgtables()
Message-ID: <20250124090431.GA3861@noisy.programming.kicks-ass.net>
References: <20250122232716.1321171-1-roman.gushchin@linux.dev>
 <20250123214531.GA969@noisy.programming.kicks-ass.net>
 <Z5LM4b2sC1fHgB3p@google.com>
 <26cd41c2-b8b6-0c1d-c36d-28f2f9f369be@google.com>
 <20250124083139.GB13226@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124083139.GB13226@noisy.programming.kicks-ass.net>

On Fri, Jan 24, 2025 at 09:31:39AM +0100, Peter Zijlstra wrote:
> On Thu, Jan 23, 2025 at 08:42:36PM -0800, Hugh Dickins wrote:
> > The changelog of commit b67fbebd4cf9 ("mmu_gather: Force tlb-flush
> > VM_PFNMAP vmas") has not helped me either.  Nor could I locate any
> > discussion (Jann, Linus, Peter, Will?) that led up to it.
> 
> Hmm, that was probably on security -- I should have those mails around
> somewhere, I'll see if I can dig them up.

Hugh, I've bounced you a copy of Jann's original report on the issue.

Subject: unmap_mapping_range() race with munmap() on VM_PFNMAP mappings leads to stale TLB entry

