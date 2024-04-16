Return-Path: <linux-arch+bounces-3716-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA398A64FB
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 09:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 057F3B21621
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 07:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6993484E0A;
	Tue, 16 Apr 2024 07:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekk8HCBF"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9336EB75;
	Tue, 16 Apr 2024 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713252206; cv=none; b=VHkeyzIbKbKGyGXLYc8WCAkzSIf45pmkXFPO39XulTqCp8JJt/VEmI/5zqg1Jqo6Wmy/ZVyh5thfkGWRbDRnp74yq47yDxrd7F053nt8oEP+d4VPJgUEmNNM5xh9f+yPPiB28qE+352P3m7l/fO/+G+uFsyTPbXrNkjMhaV64ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713252206; c=relaxed/simple;
	bh=ULqJjlTCraVJ0ruf913jYz2dlG1gS6UCOgmOiRdXRlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjCvUPLzf0P3JLPBqJW2/Sn+xfkNer8nzPpJ1PQZr0VieC5pN2cPRDtF86WlRWoIMN163+SoQ1iEKRXtCwXwxWKOfl+DcQCsuFTcPeEUDF3NH+HFL84kVCy3ArKqnHlZf/m0tWDuZLJTDnBDJy2NWegGodnzs2laWUFeMHkhecM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekk8HCBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBECC113CE;
	Tue, 16 Apr 2024 07:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713252205;
	bh=ULqJjlTCraVJ0ruf913jYz2dlG1gS6UCOgmOiRdXRlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ekk8HCBFjthC7O7PxrFN7j/GM7z/nWOuO8k9QOUSLiGyz09GAO2cg64dmGZlUlds7
	 00Ewxyx3C6wcPZBoIkKGD6lbL3qbO2ksVpnRUlonLdQr9BhpV1yf7+bx9loZNn41At
	 rywVk+bWOXuipnXUZImOPnzXQlyIpQamAXCi97V5XEUtgpABiSiT97flmkQAEFDr7A
	 YcuRY0rwjZPTJIRXEph9PF+jUZc4mOVTGomsCx8EugJ6WC8EEbdEckfhASAJlczMAM
	 pEgjXqHCw7T7cVdoBUzlejwen9ZBJYRh+vjYrzCI4CZ6xsCi82SwkYS2yHPnvfOsma
	 Wo31Nl9r7Gz/Q==
Date: Tue, 16 Apr 2024 10:22:14 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
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
Message-ID: <Zh4nJp8rv1qRBs8m@kernel.org>
References: <20240411160051.2093261-1-rppt@kernel.org>
 <20240411160051.2093261-6-rppt@kernel.org>
 <20240415075241.GF40213@noisy.programming.kicks-ass.net>
 <Zh1lnIdgFeM1o8S5@FVFF77S0Q05N.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh1lnIdgFeM1o8S5@FVFF77S0Q05N.cambridge.arm.com>

On Mon, Apr 15, 2024 at 06:36:39PM +0100, Mark Rutland wrote:
> On Mon, Apr 15, 2024 at 09:52:41AM +0200, Peter Zijlstra wrote:
> > On Thu, Apr 11, 2024 at 07:00:41PM +0300, Mike Rapoport wrote:
> > > +/**
> > > + * enum execmem_type - types of executable memory ranges
> > > + *
> > > + * There are several subsystems that allocate executable memory.
> > > + * Architectures define different restrictions on placement,
> > > + * permissions, alignment and other parameters for memory that can be used
> > > + * by these subsystems.
> > > + * Types in this enum identify subsystems that allocate executable memory
> > > + * and let architectures define parameters for ranges suitable for
> > > + * allocations by each subsystem.
> > > + *
> > > + * @EXECMEM_DEFAULT: default parameters that would be used for types that
> > > + * are not explcitly defined.
> > > + * @EXECMEM_MODULE_TEXT: parameters for module text sections
> > > + * @EXECMEM_KPROBES: parameters for kprobes
> > > + * @EXECMEM_FTRACE: parameters for ftrace
> > > + * @EXECMEM_BPF: parameters for BPF
> > > + * @EXECMEM_TYPE_MAX:
> > > + */
> > > +enum execmem_type {
> > > +	EXECMEM_DEFAULT,
> > > +	EXECMEM_MODULE_TEXT = EXECMEM_DEFAULT,
> > > +	EXECMEM_KPROBES,
> > > +	EXECMEM_FTRACE,
> > > +	EXECMEM_BPF,
> > > +	EXECMEM_TYPE_MAX,
> > > +};
> > 
> > Can we please get a break-down of how all these types are actually
> > different from one another?
> > 
> > I'm thinking some platforms have a tiny immediate space (arm64 comes to
> > mind) and has less strict placement constraints for some of them?
> 
> Yeah, and really I'd *much* rather deal with that in arch code, as I have said
> several times.
> 
> For arm64 we have two bsaic restrictions: 
> 
> 1) Direct branches can go +/-128M
>    We can expand this range by having direct branches go to PLTs, at a
>    performance cost.
> 
> 2) PREL32 relocations can go +/-2G
>    We cannot expand this further.
> 
> * We don't need to allocate memory for ftrace. We do not use trampolines.
> 
> * Kprobes XOL areas don't care about either of those; we don't place any
>   PC-relative instructions in those. Maybe we want to in future.
> 
> * Modules care about both; we'd *prefer* to place them within +/-128M of all
>   other kernel/module code, but if there's no space we can use PLTs and expand
>   that to +/-2G. Since modules can refreence other modules, that ends up
>   actually being halved, and modules have to fit within some 2G window that
>   also covers the kernel.
> 
> * I'm not sure about BPF's requirements; it seems happy doing the same as
>   modules.

BPF are happy with vmalloc().
 
> So if we *must* use a common execmem allocator, what we'd reall want is our own
> types, e.g.
> 
> 	EXECMEM_ANYWHERE
> 	EXECMEM_NOPLT
> 	EXECMEM_PREL32
> 
> ... and then we use those in arch code to implement module_alloc() and friends.

I'm looking at execmem_types more as definition of the consumers, maybe I
should have named the enum execmem_consumer at the first place.

And the arch constrains defined in struct execmem_range describe how memory
should be allocated for each consumer.

These constraints are defined early at boot and remain static, so
initializing them once and letting a common allocator use them makes
perfect sense to me.

I agree that fallback_{start,end} are not ideal, but we have 3
architectures that have preferred and secondary range for modules. And arm
and powerpc use the same logic for kprobes as well, and I don't see why this
code should be duplicated.

And, for instance, if you decide to place PC-relative instructions if
kprobes XOL areas, you'd only need to update execmem_range for kprobes to
be more like the range for modules.

With central allocator it's easier to deal with the things like
VM_FLUSH_RESET_PERMS and caching of ROX memory and I think it will be more
maintainable that module_alloc(), alloc_insn_page() and
bpf_jit_alloc_exec() spread all over the place.
 
> Mark.

-- 
Sincerely yours,
Mike.

