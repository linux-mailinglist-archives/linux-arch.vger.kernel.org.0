Return-Path: <linux-arch+bounces-3788-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403178A974F
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 12:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F711C21B96
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 10:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8E515B980;
	Thu, 18 Apr 2024 10:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7r3HpYQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750CC15AAAD;
	Thu, 18 Apr 2024 10:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713435912; cv=none; b=av9OfEJ9navaKSI2hVUghjNwxROt4Y3dUBgvCz+xmpvWpG3NfdKUvgVLvVI6YUE6itpRPVyGkeMGGc8pARJemt4A4nmor0OyJKWjjS1xQP5yQM5/E2+os4oBURqf+8spjGR2NHoOUtb9yXhbiSHe75j1S23tSikDkXw6Sxh5YTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713435912; c=relaxed/simple;
	bh=YYR+dNmhH5n7QU2mxc3zizI6arTy/RTvZImlW/XQhPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOxBs69phnGBVh/0JjdNmSVJTMJq0hfaZ9+ln5E9W/tS/lTkIu2k4BJCpwQdUn4vcoKVGfgCaOHq8nAMp3trHPPX0o/B7FumymXS7Ou7iDZeKwjoP48ONkEl9egCmQLpm5yACWPXCyZuB7HMwBez/m5GJsM1ZBKx9hFGGCEOiiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7r3HpYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36123C113CC;
	Thu, 18 Apr 2024 10:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713435912;
	bh=YYR+dNmhH5n7QU2mxc3zizI6arTy/RTvZImlW/XQhPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r7r3HpYQ6nFiS0E8RoFspK8YNTCn1wvgAKmlggqCij/FXkbh7szpgdlp50MnvnkyP
	 lk96Jv8sQ1JdQGAURqqmqgYkF3mGapE5gySL9ZwhZHyzkL0O/RbIQf5t1nWm3gYpbq
	 uEpL9PSB2RTnOFLn1B9HaIE/diUnPoc6ZmU/M8wQ2SoiNmWWCQToS5x4OihQModqbL
	 wQp9NYpGP/8mk1FlFPEVNiGZQBNpmOaQ1CBof6I+gHZEt/zViTgmR/oZTmy5m+cXoj
	 Tt5QDTjkEbUg1MEvU+IXwpfYnYqHcejQQSHvHq4OyuZGU6Xkki5E+LhnslG0zaaCc7
	 s1wPnD7FtE6tA==
Date: Thu, 18 Apr 2024 13:23:55 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <ZiD0u3uz97ltnXJS@kernel.org>
References: <20240411160526.2093408-1-rppt@kernel.org>
 <20240411160526.2093408-7-rppt@kernel.org>
 <20240415104750.GJ40213@noisy.programming.kicks-ass.net>
 <Zh1dKkFr6zdBh2Kz@kernel.org>
 <20240416075234.GA31647@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416075234.GA31647@noisy.programming.kicks-ass.net>

On Tue, Apr 16, 2024 at 09:52:34AM +0200, Peter Zijlstra wrote:
> On Mon, Apr 15, 2024 at 08:00:26PM +0300, Mike Rapoport wrote:
> > On Mon, Apr 15, 2024 at 12:47:50PM +0200, Peter Zijlstra wrote:
> > > On Thu, Apr 11, 2024 at 07:05:25PM +0300, Mike Rapoport wrote:
> > > 
> > > > To populate the cache, a writable large page is allocated from vmalloc with
> > > > VM_ALLOW_HUGE_VMAP, filled with invalid instructions and then remapped as
> > > > ROX.
> > > 
> > > > +static void execmem_invalidate(void *ptr, size_t size, bool writable)
> > > > +{
> > > > +	if (execmem_info->invalidate)
> > > > +		execmem_info->invalidate(ptr, size, writable);
> > > > +	else
> > > > +		memset(ptr, 0, size);
> > > > +}
> > > 
> > > +static void execmem_invalidate(void *ptr, size_t size, bool writeable)
> > > +{
> > > +       /* fill memory with INT3 instructions */
> > > +       if (writeable)
> > > +               memset(ptr, 0xcc, size);
> > > +       else
> > > +               text_poke_set(ptr, 0xcc, size);
> > > +}
> > > 
> > > Thing is, 0xcc (aka INT3_INSN_OPCODE) is not an invalid instruction.
> > > It raises #BP not #UD.
> > 
> > Do you mean that _invalidate is a poor name choice or that it's necessary
> > to use an instruction that raises #UD?
> 
> Poor naming, mostly. #BP handler will still scream bloody murder if the
> site is otherwise unclaimed.
> 
> It just isn't an invalid instruction.

Well, execmem_fill_with_insns_screaming_bloody_murder seems too long, how
about execmem_fill_trapping_insns?

-- 
Sincerely yours,
Mike.

