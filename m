Return-Path: <linux-arch+bounces-3717-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0481F8A6576
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 09:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 877FDB2175B
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 07:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04D584FBA;
	Tue, 16 Apr 2024 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fU/cNEu5"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FC27FBBA;
	Tue, 16 Apr 2024 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713253978; cv=none; b=VMOUCcfMZ/8ldRjdrvv5QxazZlhRcEwZMaZFpUVUfH3blcbyp/HEASK2hUP/+/RksSmf6UlDT0INiFVDcEplNgx/ig+tR7peuFgm9nzHgEAFcVwZqDB3l+n8FOB01+c0Sf15rmWW9U3Pz0Spe5h7HEMOjBIIxeiRmkSWbR+ufUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713253978; c=relaxed/simple;
	bh=i4wZ/rKAd8t/gotjo/bAEFp0Lbj6N0UFOKrt5kXOcq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ougX+RgZQZXSIA5SuCZrgrp6r79/skGa4vJcoqNMQDYUWvrx5tWvCZSSghcGpGGO1yIMEffDrQS6JIGAfBgonhaI1Jgtt8/rLr0vCSBs1iPwcWqcaZn6ZFbuN/XlLhwCcq26uDDB5qW+zwAT1FmvVcFbCTCsD3sf4VVkHVIFfW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fU/cNEu5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=507ZBsLeuCe8QOYcleBeRL5NXt96hdJ7/5G0PziK1K0=; b=fU/cNEu5qw/O2Klf8s6HCr+ThI
	AhpI1nEs4Up9XFmJBI03cktnXOkGdoRbOvIZzjK48ok45c2JILgNd4BIrGYsKyEjDF0eQQL+HYJwR
	Yiyrnny32/na/Ys3afDWWVnk61J34su4s2sCj0Ub01AHgZcx+Fsp5j+qrF1A8v0sYzXZMlCD5kjBk
	s3viP3O4TygKJJxdljC/ZTymqUoM44K9+R+bQ//RVwqZYO5nBn5merN0aN+obc8V8nFi/A7z6wGAX
	iEjE6w/enUoiPeoQuWrQTmG1HLtwkxvfU1NO54vIH5bCDXvS5cudA99gRVmIMYwS4kC9jIInm3J/Z
	dg+Vrz+Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwdcJ-0000000HZIl-1TGs;
	Tue, 16 Apr 2024 07:52:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0630E30040C; Tue, 16 Apr 2024 09:52:35 +0200 (CEST)
Date: Tue, 16 Apr 2024 09:52:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>, Helge Deller <deller@gmx.de>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [RFC PATCH 6/7] execmem: add support for cache of large ROX pages
Message-ID: <20240416075234.GA31647@noisy.programming.kicks-ass.net>
References: <20240411160526.2093408-1-rppt@kernel.org>
 <20240411160526.2093408-7-rppt@kernel.org>
 <20240415104750.GJ40213@noisy.programming.kicks-ass.net>
 <Zh1dKkFr6zdBh2Kz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh1dKkFr6zdBh2Kz@kernel.org>

On Mon, Apr 15, 2024 at 08:00:26PM +0300, Mike Rapoport wrote:
> On Mon, Apr 15, 2024 at 12:47:50PM +0200, Peter Zijlstra wrote:
> > On Thu, Apr 11, 2024 at 07:05:25PM +0300, Mike Rapoport wrote:
> > 
> > > To populate the cache, a writable large page is allocated from vmalloc with
> > > VM_ALLOW_HUGE_VMAP, filled with invalid instructions and then remapped as
> > > ROX.
> > 
> > > +static void execmem_invalidate(void *ptr, size_t size, bool writable)
> > > +{
> > > +	if (execmem_info->invalidate)
> > > +		execmem_info->invalidate(ptr, size, writable);
> > > +	else
> > > +		memset(ptr, 0, size);
> > > +}
> > 
> > +static void execmem_invalidate(void *ptr, size_t size, bool writeable)
> > +{
> > +       /* fill memory with INT3 instructions */
> > +       if (writeable)
> > +               memset(ptr, 0xcc, size);
> > +       else
> > +               text_poke_set(ptr, 0xcc, size);
> > +}
> > 
> > Thing is, 0xcc (aka INT3_INSN_OPCODE) is not an invalid instruction.
> > It raises #BP not #UD.
> 
> Do you mean that _invalidate is a poor name choice or that it's necessary
> to use an instruction that raises #UD?

Poor naming, mostly. #BP handler will still scream bloody murder if the
site is otherwise unclaimed.

It just isn't an invalid instruction.

