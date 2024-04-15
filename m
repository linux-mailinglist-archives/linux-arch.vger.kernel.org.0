Return-Path: <linux-arch+bounces-3712-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8A68A5943
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 19:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43E9285593
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 17:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BFA137C41;
	Mon, 15 Apr 2024 17:37:06 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A082386630;
	Mon, 15 Apr 2024 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713202626; cv=none; b=m4eQ6SR7zHQL4WMM4wt71bfbtg7jo/Nqpnf9N+UnsMU++KZn/GzVMkT66KfZBqWD2R1kfNbFDg1ajhqrM9kViSwB8NcxE0zfNA92aoN8CeS7Do6fD5QeYXVm9s2fUtYtH7hhMXxexxko83dtLQypF29BEXr3mkqB5jwnxud3W4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713202626; c=relaxed/simple;
	bh=ugJ7VhityyPTecy8wf9JRI9YbfU9MGW+oLb8yf0nono=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lz398WWt3ASiObpqk1Z5cKfqqu9lzTk6vRmdOAFSzKUdkrUjXW7A99sMSDWgXkhb/WbdGPpGOV4HO4VOEtytUzYkyJL2VTeuFJWzpqgJbnt7xnGyy5Bt98pl8+nOQ+SpNYhzDXIQrbaUNXWMDOuS4D7dK4DnRuoS8T6E/JGVY/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30ED11515;
	Mon, 15 Apr 2024 10:37:23 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.38.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6579A3F64C;
	Mon, 15 Apr 2024 10:36:49 -0700 (PDT)
Date: Mon, 15 Apr 2024 18:36:39 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Bj\"orn T\"opel" <bjorn@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nadav Amit <nadav.amit@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4 05/15] mm: introduce execmem_alloc() and execmem_free()
Message-ID: <Zh1lnIdgFeM1o8S5@FVFF77S0Q05N.cambridge.arm.com>
References: <20240411160051.2093261-1-rppt@kernel.org>
 <20240411160051.2093261-6-rppt@kernel.org>
 <20240415075241.GF40213@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415075241.GF40213@noisy.programming.kicks-ass.net>

On Mon, Apr 15, 2024 at 09:52:41AM +0200, Peter Zijlstra wrote:
> On Thu, Apr 11, 2024 at 07:00:41PM +0300, Mike Rapoport wrote:
> > +/**
> > + * enum execmem_type - types of executable memory ranges
> > + *
> > + * There are several subsystems that allocate executable memory.
> > + * Architectures define different restrictions on placement,
> > + * permissions, alignment and other parameters for memory that can be used
> > + * by these subsystems.
> > + * Types in this enum identify subsystems that allocate executable memory
> > + * and let architectures define parameters for ranges suitable for
> > + * allocations by each subsystem.
> > + *
> > + * @EXECMEM_DEFAULT: default parameters that would be used for types that
> > + * are not explcitly defined.
> > + * @EXECMEM_MODULE_TEXT: parameters for module text sections
> > + * @EXECMEM_KPROBES: parameters for kprobes
> > + * @EXECMEM_FTRACE: parameters for ftrace
> > + * @EXECMEM_BPF: parameters for BPF
> > + * @EXECMEM_TYPE_MAX:
> > + */
> > +enum execmem_type {
> > +	EXECMEM_DEFAULT,
> > +	EXECMEM_MODULE_TEXT = EXECMEM_DEFAULT,
> > +	EXECMEM_KPROBES,
> > +	EXECMEM_FTRACE,
> > +	EXECMEM_BPF,
> > +	EXECMEM_TYPE_MAX,
> > +};
> 
> Can we please get a break-down of how all these types are actually
> different from one another?
> 
> I'm thinking some platforms have a tiny immediate space (arm64 comes to
> mind) and has less strict placement constraints for some of them?

Yeah, and really I'd *much* rather deal with that in arch code, as I have said
several times.

For arm64 we have two bsaic restrictions: 

1) Direct branches can go +/-128M
   We can expand this range by having direct branches go to PLTs, at a
   performance cost.

2) PREL32 relocations can go +/-2G
   We cannot expand this further.

* We don't need to allocate memory for ftrace. We do not use trampolines.

* Kprobes XOL areas don't care about either of those; we don't place any
  PC-relative instructions in those. Maybe we want to in future.

* Modules care about both; we'd *prefer* to place them within +/-128M of all
  other kernel/module code, but if there's no space we can use PLTs and expand
  that to +/-2G. Since modules can refreence other modules, that ends up
  actually being halved, and modules have to fit within some 2G window that
  also covers the kernel.

* I'm not sure about BPF's requirements; it seems happy doing the same as
  modules.

So if we *must* use a common execmem allocator, what we'd reall want is our own
types, e.g.

	EXECMEM_ANYWHERE
	EXECMEM_NOPLT
	EXECMEM_PREL32

... and then we use those in arch code to implement module_alloc() and friends.

Mark.

