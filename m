Return-Path: <linux-arch+bounces-3671-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7B68A4CDE
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 12:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC221F22692
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 10:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079665C901;
	Mon, 15 Apr 2024 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DmPlp+Gw"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF5F5B692;
	Mon, 15 Apr 2024 10:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178092; cv=none; b=eF9m+gcFYoIAOdb/tKTW7zNcwOvur2xrhjtUt0JJDkDK+CF9nOizyaYr+T4mR4jK+wjpe6wtmUSeLbLunGCM4dC5GgQYZNz6cX7whJcLI8czLWAZnERRuy/tQQkX48yyip/QE0CxbwN+6FN8k8aU4c57GyfSzI8jcQsduIMPX0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178092; c=relaxed/simple;
	bh=DHHOkCShD1hzMwPMuxL6SrFxpgSganyXDD6xvwRxLUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EU1CxCT0GTZouk3hhRqsio4WG8qRUPN4esVBqcXPmqoFeLFNrnuWTqDPCWhFSPIkR3Ic5STiyt9dz5zfaFqkpa6lq1POtHwKogDejCt5eCwgzPcl5sS6mpWsMWaWuKaDkAxA5O6rxHgFQje/lqj1LSuZsdDx/gbMu9zY0CJt5zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DmPlp+Gw; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RaoQRV0+66EHGN6m1Ed2GcaJhrluoYf96YNmq1kLoeM=; b=DmPlp+GwTjnqhKH6J+sryoEdrY
	Bs7/bAK5dGN/tvOZpggS1MRWFWhxCzXtg3Kme5+z0u7Td+mbEbDDM50WNlWh1bBT5LGWUxcb+bGHm
	elRahugHUcxnEkAqkbSjVEdy4EY9K3hAojTO6rN2gFUgyfCr0rBFNu0FLG+U39e1a1V9WMtD/KjXZ
	Zp9hCayzKEN/2qzib0qaBIaeLkLJf4Ht0/GJYYy/QPucZKIP2egPoJY7GIjLvQztCzQtItKx8NefU
	MgyHUypo6g915o9W6pq9YTc3bSEs3SrWCDaJITQ7Iyh1VXY7BNiW5EFf6MEbQ4nSlfuaPnF415DH5
	Z7AJDBhA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwJsN-0000000AXAk-0b8k;
	Mon, 15 Apr 2024 10:47:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C563430040C; Mon, 15 Apr 2024 12:47:50 +0200 (CEST)
Date: Mon, 15 Apr 2024 12:47:50 +0200
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
Message-ID: <20240415104750.GJ40213@noisy.programming.kicks-ass.net>
References: <20240411160526.2093408-1-rppt@kernel.org>
 <20240411160526.2093408-7-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411160526.2093408-7-rppt@kernel.org>

On Thu, Apr 11, 2024 at 07:05:25PM +0300, Mike Rapoport wrote:

> To populate the cache, a writable large page is allocated from vmalloc with
> VM_ALLOW_HUGE_VMAP, filled with invalid instructions and then remapped as
> ROX.

> +static void execmem_invalidate(void *ptr, size_t size, bool writable)
> +{
> +	if (execmem_info->invalidate)
> +		execmem_info->invalidate(ptr, size, writable);
> +	else
> +		memset(ptr, 0, size);
> +}

+static void execmem_invalidate(void *ptr, size_t size, bool writeable)
+{
+       /* fill memory with INT3 instructions */
+       if (writeable)
+               memset(ptr, 0xcc, size);
+       else
+               text_poke_set(ptr, 0xcc, size);
+}

Thing is, 0xcc (aka INT3_INSN_OPCODE) is not an invalid instruction.
It raises #BP not #UD.

