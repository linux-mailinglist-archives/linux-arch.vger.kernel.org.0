Return-Path: <linux-arch+bounces-3670-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAE68A4CBC
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 12:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48AB3282D27
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 10:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAA15C8E6;
	Mon, 15 Apr 2024 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GwGuQ4aH"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2DA5C602;
	Mon, 15 Apr 2024 10:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713177822; cv=none; b=d+px96eOxravbYrft5qkAIqcNl8bfJbbPsggVJrfldCXVuojpN3D9TcrFjY3DS/YUSY898e3vhAp3yYvPzmsNRZMdnOvg+2iltRZWi+MjZH6gUkjOxna9gA+75m56W1dtpG1K8xuONZEJ9+Y/nlWV62qBHR0hRk693FWwQbzN/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713177822; c=relaxed/simple;
	bh=RFYztRJUTq9jSdRkMIaWfGnpsOm5wmTtBN7NNF1RSJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6rRTVXKQJN7Se7fYdqomuaIpZlhev6IUVG71Vd1N6qr6LE0DnNWH86NGp6FnYxwt3qfpRg8a3T+266nQybr4WeLGeh9Bb7QvH14/f7juPHVoFd/WrH6FxPQfY8uImAPwykz3CFW7rG/lhaI5J1eID3nZDOOqM/rC/FuyNQ1eeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GwGuQ4aH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sHN9K6TMgi0EQGirMl9LJrLTL74puiAUj6pDWO1mbbg=; b=GwGuQ4aHjE28h3DMQEljrl12S9
	k7qbRgAehAWmB1KZsKYRkIe5T4YmQ/IK7K1/tscLIiWM+Frzf3BTbHghy00qu8vsdYndUrZk657/5
	7U6MObgQX8Hy2DTMmRYPlPtuplIcSQak3GNH/5HdZ6q2oAguSRJjpD+LaJ9a87To/HWlTYLJ9YvvV
	DlPdjGnZeeuN/uKeKILlCHLcOLy+D7L1I3Tkf+oPOF+MhpDr74c6GfylqnVH3luQcSx0xGQC7Rr+F
	/Pi5v1/cfv4gkg/y9fqk5azH4jFf+jsMj8+XJZsS62wcfAHMmEcUQTu5cq8eADVZRA0kd303q26id
	Ns2I29PA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwJnx-0000000FWHZ-0CDf;
	Mon, 15 Apr 2024 10:43:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id ACBA530040C; Mon, 15 Apr 2024 12:43:16 +0200 (CEST)
Date: Mon, 15 Apr 2024 12:43:16 +0200
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
Subject: Re: [RFC PATCH 5/7] x86/module: perpare module loading for ROX
 allocations of text
Message-ID: <20240415104316.GI40213@noisy.programming.kicks-ass.net>
References: <20240411160526.2093408-1-rppt@kernel.org>
 <20240411160526.2093408-6-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411160526.2093408-6-rppt@kernel.org>

On Thu, Apr 11, 2024 at 07:05:24PM +0300, Mike Rapoport wrote:
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 45a280f2161c..b4d6868df573 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c

> @@ -504,17 +513,17 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
>  		 *   patch if feature is *NOT* present.
>  		 */
>  		if (!boot_cpu_has(a->cpuid) == !(a->flags & ALT_FLAG_NOT)) {
> -			optimize_nops_inplace(instr, a->instrlen);
> +			optimize_nops_inplace(wr_instr, a->instrlen);
>  			continue;
>  		}
>  
> -		DPRINTK(ALT, "feat: %d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d) flags: 0x%x",
> +		DPRINTK(ALT, "feat: %d*32+%d, old: (%px (%px) len: %d), repl: (%px (%px), len: %d) flags: 0x%x",
>  			a->cpuid >> 5,
>  			a->cpuid & 0x1f,
> -			instr, instr, a->instrlen,
> -			replacement, a->replacementlen, a->flags);
> +			instr, wr_instr, a->instrlen,
> +			replacement, wr_replacement, a->replacementlen, a->flags);

I think this, and

>  
> -		memcpy(insn_buff, replacement, a->replacementlen);
> +		memcpy(insn_buff, wr_replacement, a->replacementlen);
>  		insn_buff_sz = a->replacementlen;
>  
>  		if (a->flags & ALT_FLAG_DIRECT_CALL) {
> @@ -528,11 +537,11 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
>  
>  		apply_relocation(insn_buff, a->instrlen, instr, replacement, a->replacementlen);
>  
> -		DUMP_BYTES(ALT, instr, a->instrlen, "%px:   old_insn: ", instr);
> +		DUMP_BYTES(ALT, wr_instr, a->instrlen, "%px:   old_insn: ", instr);

this, want to remain as is. 

>  		DUMP_BYTES(ALT, replacement, a->replacementlen, "%px:   rpl_insn: ", replacement);
>  		DUMP_BYTES(ALT, insn_buff, insn_buff_sz, "%px: final_insn: ", instr);
>  
> -		text_poke_early(instr, insn_buff, insn_buff_sz);
> +		text_poke_early(wr_instr, insn_buff, insn_buff_sz);
>  	}
>  
>  	kasan_enable_current();

The rationale being that we then print an address that can be correlated
to the kernel image (provided one either kills kaslr or adjusts for it).

