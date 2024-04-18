Return-Path: <linux-arch+bounces-3787-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D09AF8A972F
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 12:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F9E3B20EFE
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 10:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D612315B971;
	Thu, 18 Apr 2024 10:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SELAoNeX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C86D15AAD9;
	Thu, 18 Apr 2024 10:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713435694; cv=none; b=bd7/6N5LhhhYbfab3j82Zk/0Cg/PMjHbOC+Fwb1U4CI4wf4P4Ljjyx+4zS8eOYhtJyHU5iSm1oegfZJgTQHgRp21m1dIc5L5ldKYgW6imos+OynGcy7GWLrpuzqv0J4ZklTp7E2OSB4HNjuv7miARB0nJVeIJDAdXHcXfYocrSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713435694; c=relaxed/simple;
	bh=GIF39x+DoxCddvDNRomXCworfiQAca8ygUjDy3+kOkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgpGF4OF2T51IvROcPFCNlgkLQPpqYIMOyAm+tqk2ViNJUx0g4QjNfjeYKbVtuR3IJ9Tz0JMB9OkrYoxdBSrM8NuPf6FOq3Bgb70tS0mjlLVD3QUv9rPabXmP1+57eQhs8/ESsl9O8A0dyfT5ecgorpjUBnq8GjtUJOxoK0QYtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SELAoNeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE78C113CC;
	Thu, 18 Apr 2024 10:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713435694;
	bh=GIF39x+DoxCddvDNRomXCworfiQAca8ygUjDy3+kOkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SELAoNeXc3Beu0HbaRnXjo5QYZwKVoBtQiv3DGWKIGD1ByoQxYtKIRMmvzmqWXRIs
	 l28WXlrgf45drPhQ9fcY+C862qqlcZ84I3lISaD2oLaKCzcGbAykPBulJ9k6bwvlRz
	 LV8NaKjnWubu4ei2CwJbivkB4YEQEKSRsSyVzaW8Mxs5W6YReOjEi+EuEAD86bBnwS
	 qFPhIxsVlHHsOebyI08OR68Lghu75Srbh8a5UrbpGFwRlRYkMIVyzmMjHu+Dqlrqq9
	 fLqc6ctyg9Ep6vn3VgTN09QBUzcZ5AVisQI/jdvTkZRhUWxPwNNaW0QWW5GqKdhOFZ
	 JlWziN6p3qThQ==
Date: Thu, 18 Apr 2024 13:20:17 +0300
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
	bpf@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	linux-modules@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [RFC PATCH 3/7] module: prepare to handle ROX allocations for
 text
Message-ID: <ZiDz4YbIHEOAnpwF@kernel.org>
References: <20240411160526.2093408-1-rppt@kernel.org>
 <20240411160526.2093408-4-rppt@kernel.org>
 <0C4B9C1A-97DE-4798-8256-158369AF42A4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0C4B9C1A-97DE-4798-8256-158369AF42A4@gmail.com>

On Tue, Apr 16, 2024 at 12:36:08PM +0300, Nadav Amit wrote:
> 
> 
> > On 11 Apr 2024, at 19:05, Mike Rapoport <rppt@kernel.org> wrote:
> > 
> > @@ -2440,7 +2479,24 @@ static int post_relocation(struct module *mod, const struct load_info *info)
> > 	add_kallsyms(mod, info);
> > 
> > 	/* Arch-specific module finalizing. */
> > -	return module_finalize(info->hdr, info->sechdrs, mod);
> > +	ret = module_finalize(info->hdr, info->sechdrs, mod);
> > +	if (ret)
> > +		return ret;
> > +
> > +	for_each_mod_mem_type(type) {
> > +		struct module_memory *mem = &mod->mem[type];
> > +
> > +		if (mem->is_rox) {
> > +			if (!execmem_update_copy(mem->base, mem->rw_copy,
> > +						 mem->size))
> > +				return -ENOMEM;
> > +
> > +			vfree(mem->rw_copy);
> > +			mem->rw_copy = NULL;
> > +		}
> > +	}
> > +
> > +	return 0;
> > }
> 
> I might be missing something, but it seems a bit racy.
> 
> IIUC, module_finalize() calls alternatives_smp_module_add(). At this
> point, since you don’t hold the text_mutex, some might do text_poke(),
> e.g., by enabling/disabling static-key, and the update would be
> overwritten. No?

Right :(
Even worse, for UP case alternatives_smp_unlock() will "patch" still empty
area.

So I'm thinking about calling alternatives_smp_module_add() from an
additional callback after the execmem_update_copy().

Does it make sense to you?

-- 
Sincerely yours,
Mike.

