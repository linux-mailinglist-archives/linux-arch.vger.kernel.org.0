Return-Path: <linux-arch+bounces-3708-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067AB8A585F
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 19:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66366B229AC
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 17:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A132883CD1;
	Mon, 15 Apr 2024 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQhmkrbx"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825B82C7E;
	Mon, 15 Apr 2024 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200500; cv=none; b=bwdikHusouShZVLgHAnumUH/2sEBpBRm7UcbMQrs87eDwT5/4lCt2VjYDaUxLi/t1ysMVwHchbt4nfmsZ1wBfB/UjG/dPov4ccMMrIgMaObrdxpNhvrSL3wKpGiO5aQewoOvrXEINy+qIODxfEZ0ZHNFFP5sXGhhMKw/LcCTraQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200500; c=relaxed/simple;
	bh=i8/bH2GflHHwL9Q6O831fT+UJyy/N/JxZRrEitYoDU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCWwxNYqABT7CbdlXiR+KpKFX0iWFQMd/EwniO/BS3wZtmvIyYDhM5mY6ks4fzs6TOEbIa0FRpCr0dFjvad92c3p6qb3P2NghMfeR3m+8Sn3S0i9RUzyUklhOfy0ShwyNNKN2Dh51cJDwIFbk7rT085FFs+g5YWPO0tAVxSAO0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQhmkrbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14FBC32783;
	Mon, 15 Apr 2024 17:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713200500;
	bh=i8/bH2GflHHwL9Q6O831fT+UJyy/N/JxZRrEitYoDU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JQhmkrbxlkokAIFsbHYvCZlDdyYFqLoERLQD9UjXNswKquLP0xtcV1u+YOoMVBYzN
	 Sb7LZUsXfhw2SSDicmJPXX6wJEySR7qXgqeF6WRCMsTmaxb6dTEEvdKVJ2QF8xV73M
	 zWVAeo2j5d2mIhRamGxbmxaN76CTvh0ZT5e287zxh62+7uCraDbeX1crXvejWzPawj
	 XA+nSfS1WF1QUSKZ+OwNWlmE2LS69a8cbAEH8Ow0G8h8jNNt9mOeOurVvGxQejJFIq
	 lJWV1cL3Cak0wByUAJkuz9CCwdQLw1/FNbKBb/4i5MFAWn2PKkhEyDcE8g7rJ9Kbjc
	 EpnrFltAXi4ng==
Date: Mon, 15 Apr 2024 20:00:26 +0300
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
Message-ID: <Zh1dKkFr6zdBh2Kz@kernel.org>
References: <20240411160526.2093408-1-rppt@kernel.org>
 <20240411160526.2093408-7-rppt@kernel.org>
 <20240415104750.GJ40213@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415104750.GJ40213@noisy.programming.kicks-ass.net>

On Mon, Apr 15, 2024 at 12:47:50PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 11, 2024 at 07:05:25PM +0300, Mike Rapoport wrote:
> 
> > To populate the cache, a writable large page is allocated from vmalloc with
> > VM_ALLOW_HUGE_VMAP, filled with invalid instructions and then remapped as
> > ROX.
> 
> > +static void execmem_invalidate(void *ptr, size_t size, bool writable)
> > +{
> > +	if (execmem_info->invalidate)
> > +		execmem_info->invalidate(ptr, size, writable);
> > +	else
> > +		memset(ptr, 0, size);
> > +}
> 
> +static void execmem_invalidate(void *ptr, size_t size, bool writeable)
> +{
> +       /* fill memory with INT3 instructions */
> +       if (writeable)
> +               memset(ptr, 0xcc, size);
> +       else
> +               text_poke_set(ptr, 0xcc, size);
> +}
> 
> Thing is, 0xcc (aka INT3_INSN_OPCODE) is not an invalid instruction.
> It raises #BP not #UD.

Do you mean that _invalidate is a poor name choice or that it's necessary
to use an instruction that raises #UD?

-- 
Sincerely yours,
Mike.

