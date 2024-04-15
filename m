Return-Path: <linux-arch+bounces-3707-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C308A5836
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 18:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99BEEB2164A
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 16:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4E88248E;
	Mon, 15 Apr 2024 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9583Q6y"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4233642072;
	Mon, 15 Apr 2024 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713199990; cv=none; b=Pci6F4BLaJbSnJCtfw0RQXSH2KUYyJg/21lTO4yrsWcG4PdkgGnPEYvuP/+7j09E07wDZ84S9ar0J8YslP2ZbZQHybKPSQPPcUvPo/j63eT8EdmWnlPjt3bi/NI9ZzQg/Bhp67eBLEvWNwstM+aRtMBsUtj0mcQORNPx13B7OsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713199990; c=relaxed/simple;
	bh=xJZBsBz/ovkewwHaqkWgEKUCLl3sCJ9igaEyaiYi248=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+zQfhfRZUb683zSkhUtYDFDYn/bvHU6nvLZL6TLONTpV6+GTMtmLFwd9AK3LXvJ/wftAN3INL5I7WnAwUHy3VrvCfdXfEevTnNX4gH3SB+26f0OIpvHNk+s8Lk0xxcKmRCR/73S+WrBh2Rw8+05OleT1cTD3y6Eju4ShGk44SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9583Q6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57527C113CC;
	Mon, 15 Apr 2024 16:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713199989;
	bh=xJZBsBz/ovkewwHaqkWgEKUCLl3sCJ9igaEyaiYi248=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n9583Q6y/kVDUsC/Sk35DHsUlzQxomP4brOeJWEqMK5tTGdFfL5yXDBwNh/dc1R8t
	 OnTvm1XERGxz1JxTUG2JWpufMQFhEpCf0upLztHBi97mz83HQzMB81Cj+bMHmQeLrO
	 vdSyDt4foue7u5p0z1MAb6dHJ1a7FzO8x/EelybB33sZUvBK4gAoiim0DQVOThRBq2
	 3ERPw7wOWw5Nw3DB6b+PtiKpkHgDPedzRaGZsUTWRIfT1yQsmJ+qNm4oAZ/M1rF747
	 dHBdlhRGfIq7wIyTjPR6B4GdpTUD5V0JGj4lcLZS8oQu4cdKYlcTv5ldjuZ1AicK/r
	 qCFC3y/AMEfuA==
Date: Mon, 15 Apr 2024 19:51:52 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
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
	Mark Rutland <mark.rutland@arm.com>,
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
Message-ID: <Zh1bKAaD7nLyJ9ya@kernel.org>
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

loongarch, mips, nios2 and sparc define modules address space different
from vmalloc and use that for modules, kprobes and bpf (where supported).

parisc uses vmalloc range for everything, but it sets permissions to
PAGE_KERNEL_RWX because it's PAGE_KERNEL_EXEC is read only and it lacks
set_memory_* APIs.

arm has an address space for modules, but it fall back to the entire
vmalloc with CONFIG_ARM_MODULE_PLTS=y.

arm64 uses different ranges for modules and bpf/kprobes. For kprobes it
does vmalloc(PAGE_KERNEL_ROX) and for bpf just plain vmalloc().
For modules arm64 first tries to allocated from 128M below kernel_end and
if that fails it uses 2G below kernel_end as a fallback.

powerpc uses vmalloc space for everything for some configurations. For
book3s-32 and 8xx it defines two ranges that are used for module text,
kprobes and bpf and the module data can be allocated anywhere in vmalloc.

riscv has an address space for modules, a different address space for bpf
and uses vmalloc space for kprobes.

s390 and x86 have modules address space and use that space for all
executable allocations.

The EXECMEM_FTRACE type is only used on s390 and x86 and for now it's there
more for completeness rather to denote special constraints or properties.

-- 
Sincerely yours,
Mike.

