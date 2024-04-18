Return-Path: <linux-arch+bounces-3812-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2478AA341
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 21:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36DC92881A7
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 19:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7874119DF41;
	Thu, 18 Apr 2024 19:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmVx6dRz"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAC0194C62;
	Thu, 18 Apr 2024 19:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469549; cv=none; b=VqvR9C6I9hX5kFd3KznBHJpCoHWSkhjfX/p0NTjiqQxRxch5R/y7FGZMZDZRAEQIcGIaHUUDi+0L1QDLUqOL2BGSWH3O8Ak2R6gQeN0pzaC1HVhiNjFAz1qEL4obMskQnCcUbiIk7/6UFt7FWU05EUzhLs5chKh1VKa3lNOhL5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469549; c=relaxed/simple;
	bh=dHO0bamdxUUeACG8WtZho+GCcL4yBYsb4entMWbbmyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeuLydmOy43wm77BprVIRDo9C2R0ZLK1SeQ9zN3+wz0EaAEPlphAvRSyd7M3fb9/ySjonJ1hgZhbmmAO20tH97yReu37Wzf8qSkWXdQIWo/9BPVN481ZQNKdSlBdpj+h7YQ8DVBTKArq/x62lwd6T0IHYsCNuhRNzCIdtEFEEf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmVx6dRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87BEC113CC;
	Thu, 18 Apr 2024 19:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713469548;
	bh=dHO0bamdxUUeACG8WtZho+GCcL4yBYsb4entMWbbmyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CmVx6dRzicEYeby+eqehWh43quHdNoBbYY/i36pebwlC3hu3ZmeS4VjBXURj7aNy3
	 iceEu2pMqBEVdzfyoNs6zYPwdeFEVjMU4daLSOF+34RPv/VgtKgm1TQzPbhCvKJCzp
	 PwHKW3yddAFwEE2clGQPe9VCz0EWlv35PYz4PkEEkLTMMrd+GAZOMmGABmKaUl5Y8d
	 4udjlt3Z97dUrMWxxJyIATuY3MTqmnZM5WdZYeq2ykeLqUHwwS1ZlLE9RAdOJI4t5m
	 dZHSPXrDPE8q2nmOH9o+Xw5o1ED5ivvKuuyvGRHdoAhgoYmdvYsWWSvRA9smcyAVNW
	 9J1gVzjdVbV+Q==
Date: Thu, 18 Apr 2024 22:44:31 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Nadav Amit <nadav.amit@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>, Will Deacon <will@kernel.org>,
	bpf <bpf@vger.kernel.org>, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	linux-modules@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [RFC PATCH 3/7] module: [
Message-ID: <ZiF4H5_tGx7woaXH@kernel.org>
References: <20240411160526.2093408-1-rppt@kernel.org>
 <20240411160526.2093408-4-rppt@kernel.org>
 <0C4B9C1A-97DE-4798-8256-158369AF42A4@gmail.com>
 <ZiDz4YbIHEOAnpwF@kernel.org>
 <A714B340-9EFB-4F27-9CD6-CFBC1BC9139F@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A714B340-9EFB-4F27-9CD6-CFBC1BC9139F@gmail.com>

On Thu, Apr 18, 2024 at 10:31:16PM +0300, Nadav Amit wrote:
> 
> > On 18 Apr 2024, at 13:20, Mike Rapoport <rppt@kernel.org> wrote:
> > 
> > On Tue, Apr 16, 2024 at 12:36:08PM +0300, Nadav Amit wrote:
> >> 
> >> 
> >> 
> >> I might be missing something, but it seems a bit racy.
> >> 
> >> IIUC, module_finalize() calls alternatives_smp_module_add(). At this
> >> point, since you don’t hold the text_mutex, some might do text_poke(),
> >> e.g., by enabling/disabling static-key, and the update would be
> >> overwritten. No?
> > 
> > Right :(
> > Even worse, for UP case alternatives_smp_unlock() will "patch" still empty
> > area.
> > 
> > So I'm thinking about calling alternatives_smp_module_add() from an
> > additional callback after the execmem_update_copy().
> > 
> > Does it make sense to you?
> 
> Going over the code again - I might have just been wrong: I confused the
> alternatives and the jump-label mechanisms (as they do share a lot of
> code and characteristics).
> 
> The jump-labels are updated when prepare_coming_module() is called, which
> happens after post_relocation() [which means they would be updated using
> text_poke() “inefficiently” but should be safe].
> 
> The “alternatives” appear only to use text_poke() (in contrast for
> text_poke_early()) from very specific few flows, e.g., 
> common_cpu_up() -> alternatives_enable_smp().
> 
> Are those flows pose a problem after boot?

Yes, common_cpu_up is called  on CPU hotplug, so it's possible to have a
race between alternatives_smp_module_add() and common_cpu_up() ->
alternatives_enable_smp().

And in UP case alternatives_smp_module_add() will call
alternatives_smp_unlock() that will patch module text before it is updated.

> Anyhow, sorry for the noise.

On the contrary, I would have missed it.

-- 
Sincerely yours,
Mike.

