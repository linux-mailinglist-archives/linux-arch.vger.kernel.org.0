Return-Path: <linux-arch+bounces-3806-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3721F8A9E8A
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 17:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17B62833F1
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 15:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786ED16D32C;
	Thu, 18 Apr 2024 15:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeWcQxDn"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B5616C6B2;
	Thu, 18 Apr 2024 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713454627; cv=none; b=EjsNuF/e3w8gwcWSe5prn/SOCOKoMzrSXPVzcmHEgb7phSP9Hf2cHHUXuXjcY99tQuuknSehA+9ts4b/VehqPGs10AzLz+w8RvpyL/igJNXIivbHvvHM9YMRV/OyOdPVZbwp015fcNi6m4f2nWG8ZUfOb1dh7CgOeVysTiWlzCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713454627; c=relaxed/simple;
	bh=/6e7koqBjxGvjgcyfyqozsKjWrzhFa989KlG6h+G83A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/O/9YP2XAw2VJx+ElzT1qWtTQidbE/OLxYy6Fzyo9F5B7biSUsL6bqeMzZSKjn7InQ4yAMugzGRAvatMWtdbH7T/vaU6jJCiKgAeMxOAXvruBfYx1zX6hNrABOkKWwNKsYy+mDa7efNr9gRlbw1Gv6fJXr+zGrLrKj33ePkgk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeWcQxDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B5DC113CC;
	Thu, 18 Apr 2024 15:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713454626;
	bh=/6e7koqBjxGvjgcyfyqozsKjWrzhFa989KlG6h+G83A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aeWcQxDnlnHobtWl/wSsLjnz0sXveyb3C9ZWUzhRio2isgl/ECkWL5MfHpcmEMTW7
	 /3gTsH9zle5F7iUK2MtYGoEYVXSVNBMbfrRBJdAbuLXT5C4Rci/tim3vMb2/HkXNT3
	 0BdaT4fZ5qEwRw4j04psUJzOpDE+rRKi3VjZ9pFXSPLklZtfjmSfaFH4UR8286lGH5
	 60/sHoFS02dtG3EW7cMEMNkjH3P1jYGW/oaOVey/LIzfE2ojr8NLFIf5bqbQCitx7d
	 hsc5w5cHL6aJI5zSA/0oAAIzFKyYOhtBXIDwcp4O2/SqIU/0gLgXdRamRK8O7d7lre
	 JIoqk7vYwCgbA==
Date: Thu, 18 Apr 2024 18:35:48 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Topel <bjorn@kernel.org>,
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
	Russell King <linux@armlinux.org.uk>,
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
Message-ID: <ZiE91CJcNw7gBj9g@kernel.org>
References: <20240411160051.2093261-1-rppt@kernel.org>
 <20240411160051.2093261-6-rppt@kernel.org>
 <20240415075241.GF40213@noisy.programming.kicks-ass.net>
 <Zh1lnIdgFeM1o8S5@FVFF77S0Q05N.cambridge.arm.com>
 <Zh4nJp8rv1qRBs8m@kernel.org>
 <CAPhsuW6Pbg2k_Gu4dsBx+H8H5XCHvNdtEZJBPiG_eT0qqr9D1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6Pbg2k_Gu4dsBx+H8H5XCHvNdtEZJBPiG_eT0qqr9D1w@mail.gmail.com>

On Wed, Apr 17, 2024 at 04:32:49PM -0700, Song Liu wrote:
> On Tue, Apr 16, 2024 at 12:23 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Mon, Apr 15, 2024 at 06:36:39PM +0100, Mark Rutland wrote:
> > > On Mon, Apr 15, 2024 at 09:52:41AM +0200, Peter Zijlstra wrote:
> > > > On Thu, Apr 11, 2024 at 07:00:41PM +0300, Mike Rapoport wrote:
> > > > > +/**
> > > > > + * enum execmem_type - types of executable memory ranges
> > > > > + *
> > > > > + * There are several subsystems that allocate executable memory.
> > > > > + * Architectures define different restrictions on placement,
> > > > > + * permissions, alignment and other parameters for memory that can be used
> > > > > + * by these subsystems.
> > > > > + * Types in this enum identify subsystems that allocate executable memory
> > > > > + * and let architectures define parameters for ranges suitable for
> > > > > + * allocations by each subsystem.
> > > > > + *
> > > > > + * @EXECMEM_DEFAULT: default parameters that would be used for types that
> > > > > + * are not explcitly defined.
> > > > > + * @EXECMEM_MODULE_TEXT: parameters for module text sections
> > > > > + * @EXECMEM_KPROBES: parameters for kprobes
> > > > > + * @EXECMEM_FTRACE: parameters for ftrace
> > > > > + * @EXECMEM_BPF: parameters for BPF
> > > > > + * @EXECMEM_TYPE_MAX:
> > > > > + */
> > > > > +enum execmem_type {
> > > > > + EXECMEM_DEFAULT,
> > > > > + EXECMEM_MODULE_TEXT = EXECMEM_DEFAULT,
> > > > > + EXECMEM_KPROBES,
> > > > > + EXECMEM_FTRACE,
> > > > > + EXECMEM_BPF,
> > > > > + EXECMEM_TYPE_MAX,
> > > > > +};
> > > >
> > > > Can we please get a break-down of how all these types are actually
> > > > different from one another?
> > > >
> > > > I'm thinking some platforms have a tiny immediate space (arm64 comes to
> > > > mind) and has less strict placement constraints for some of them?
> > >
> > > Yeah, and really I'd *much* rather deal with that in arch code, as I have said
> > > several times.
> > >
> > > For arm64 we have two bsaic restrictions:
> > >
> > > 1) Direct branches can go +/-128M
> > >    We can expand this range by having direct branches go to PLTs, at a
> > >    performance cost.
> > >
> > > 2) PREL32 relocations can go +/-2G
> > >    We cannot expand this further.
> > >
> > > * We don't need to allocate memory for ftrace. We do not use trampolines.
> > >
> > > * Kprobes XOL areas don't care about either of those; we don't place any
> > >   PC-relative instructions in those. Maybe we want to in future.
> > >
> > > * Modules care about both; we'd *prefer* to place them within +/-128M of all
> > >   other kernel/module code, but if there's no space we can use PLTs and expand
> > >   that to +/-2G. Since modules can refreence other modules, that ends up
> > >   actually being halved, and modules have to fit within some 2G window that
> > >   also covers the kernel.
> 
> Is +/- 2G enough for all realistic use cases? If so, I guess we don't
> really need
> EXECMEM_ANYWHERE below?
> 
> > >
> > > * I'm not sure about BPF's requirements; it seems happy doing the same as
> > >   modules.
> >
> > BPF are happy with vmalloc().
> >
> > > So if we *must* use a common execmem allocator, what we'd reall want is our own
> > > types, e.g.
> > >
> > >       EXECMEM_ANYWHERE
> > >       EXECMEM_NOPLT
> > >       EXECMEM_PREL32
> > >
> > > ... and then we use those in arch code to implement module_alloc() and friends.
> >
> > I'm looking at execmem_types more as definition of the consumers, maybe I
> > should have named the enum execmem_consumer at the first place.
> 
> I think looking at execmem_type from consumers' point of view adds
> unnecessary complexity. IIUC, for most (if not all) archs, ftrace, kprobe,
> and bpf (and maybe also module text) all have the same requirements.
> Did I miss something?

It's enough to have one architecture with different constrains for kprobes
and bpf to warrant a type for each.

Where do you see unnecessary complexity?
 
> IOW, we have
> 
> enum execmem_type {
>         EXECMEM_DEFAULT,
>         EXECMEM_TEXT,
>         EXECMEM_KPROBES = EXECMEM_TEXT,
>         EXECMEM_FTRACE = EXECMEM_TEXT,
>         EXECMEM_BPF = EXECMEM_TEXT,      /* we may end up without
> _KPROBE, _FTRACE, _BPF */
>         EXECMEM_DATA,  /* rw */
>         EXECMEM_RO_DATA,
>         EXECMEM_RO_AFTER_INIT,
>         EXECMEM_TYPE_MAX,
> };
> 
> Does this make sense?
 
How do you suggest to deal with e.g. riscv that has separate address spaces
for modules, kprobes and bpf?

> Thanks,
> Song

-- 
Sincerely yours,
Mike.

