Return-Path: <linux-arch+bounces-3709-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3648A58B3
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 19:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F051A1C20AA1
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 17:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F396984A53;
	Mon, 15 Apr 2024 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eA4Y4x6L"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAACB83CD8;
	Mon, 15 Apr 2024 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200726; cv=none; b=D4vR0jY7jASS66cIUiPvhMUynlacCLw48FpDomi3EDrtjqnh92neyxuBDFy+fzANysgZodViBbPfK6h/M+e/GK5gjOZhf1KdbtDMrGyuVQl9wYPXcB6Afs1PLIg2PrGmcGtRv63QvWGUGYI6dT1+AzPvetFtgaARQ1z4mwOZwvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200726; c=relaxed/simple;
	bh=brTfnO2VyUJAmFmt0xYsxELn1GfIqBydjJY5MAA2GwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZJ85qC0HBDw3r8J0cbDsDD19Con1J0u4NqUej0Xl7wSVVGFmg2MnW/4izSnPX2CceHFQUwIrH3CK8Bw518QCYq55bFdV8XkkH26qSJK/GGc8rwELB/XLp19CRGemip2i30yBHN1z9K2+/8jXI6HXkr3YQYqPK5KVKouSBNu15w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eA4Y4x6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EB7C2BD10;
	Mon, 15 Apr 2024 17:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713200726;
	bh=brTfnO2VyUJAmFmt0xYsxELn1GfIqBydjJY5MAA2GwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eA4Y4x6LpKDmJlhsFuCKUKDWszVPc0aMol9ibBC4zWuhXiukyHzmx+wctUQDy9YcO
	 SgrxzhBVYrKzoib5nD4pxj58Yru3AKozTZkN+TvcG/88RKgokKwWdJ7ot3KrqKc7Eq
	 DUMXngRm3Kt+F/W7nD5rsdsyrXI/SKwSE27eJw0RyuFsxXe2CY8Th13OWBhzodIeFI
	 g3IfMeClHVfNPTzOpcIibEz/rTBRU3MdIzMovL+lADX98nFVYDJgBcU0E0gUS/Sp3y
	 NkyrAJJ3bphAZ5D3Vr/0URqS2QdYx5P8qEukDaFoUJqWeYw/1mketQaU4aGKwRL5Ma
	 kNnuFlXqLWYaw==
Date: Mon, 15 Apr 2024 20:04:13 +0300
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
Subject: Re: [RFC PATCH 5/7] x86/module: perpare module loading for ROX
 allocations of text
Message-ID: <Zh1eDU1L1FbFwZzT@kernel.org>
References: <20240411160526.2093408-1-rppt@kernel.org>
 <20240411160526.2093408-6-rppt@kernel.org>
 <20240415104316.GI40213@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415104316.GI40213@noisy.programming.kicks-ass.net>

On Mon, Apr 15, 2024 at 12:43:16PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 11, 2024 at 07:05:24PM +0300, Mike Rapoport wrote:
> > diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> > index 45a280f2161c..b4d6868df573 100644
> > --- a/arch/x86/kernel/alternative.c
> > +++ b/arch/x86/kernel/alternative.c
> 
> > @@ -504,17 +513,17 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
> >  		 *   patch if feature is *NOT* present.
> >  		 */
> >  		if (!boot_cpu_has(a->cpuid) == !(a->flags & ALT_FLAG_NOT)) {
> > -			optimize_nops_inplace(instr, a->instrlen);
> > +			optimize_nops_inplace(wr_instr, a->instrlen);
> >  			continue;
> >  		}
> >  
> > -		DPRINTK(ALT, "feat: %d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d) flags: 0x%x",
> > +		DPRINTK(ALT, "feat: %d*32+%d, old: (%px (%px) len: %d), repl: (%px (%px), len: %d) flags: 0x%x",
> >  			a->cpuid >> 5,
> >  			a->cpuid & 0x1f,
> > -			instr, instr, a->instrlen,
> > -			replacement, a->replacementlen, a->flags);
> > +			instr, wr_instr, a->instrlen,
> > +			replacement, wr_replacement, a->replacementlen, a->flags);
> 
> I think this, and

I've found printing both address handy when I debugged it, but no strong
feelings here.
 
> >  
> > -		memcpy(insn_buff, replacement, a->replacementlen);
> > +		memcpy(insn_buff, wr_replacement, a->replacementlen);
> >  		insn_buff_sz = a->replacementlen;
> >  
> >  		if (a->flags & ALT_FLAG_DIRECT_CALL) {
> > @@ -528,11 +537,11 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
> >  
> >  		apply_relocation(insn_buff, a->instrlen, instr, replacement, a->replacementlen);
> >  
> > -		DUMP_BYTES(ALT, instr, a->instrlen, "%px:   old_insn: ", instr);
> > +		DUMP_BYTES(ALT, wr_instr, a->instrlen, "%px:   old_insn: ", instr);
> 
> this, want to remain as is. 

here wr_instr is the buffer to dump:

DUMP_BYTES(type, buf, len, fmt, args...)

rather than an address, which remained 'instr'.
 
> >  		DUMP_BYTES(ALT, replacement, a->replacementlen, "%px:   rpl_insn: ", replacement);
> >  		DUMP_BYTES(ALT, insn_buff, insn_buff_sz, "%px: final_insn: ", instr);
> >  
> > -		text_poke_early(instr, insn_buff, insn_buff_sz);
> > +		text_poke_early(wr_instr, insn_buff, insn_buff_sz);
> >  	}
> >  
> >  	kasan_enable_current();
> 
> The rationale being that we then print an address that can be correlated
> to the kernel image (provided one either kills kaslr or adjusts for it).

-- 
Sincerely yours,
Mike.

