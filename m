Return-Path: <linux-arch+bounces-3828-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B51298AB40D
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 19:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1851F22E34
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 17:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A955E13775C;
	Fri, 19 Apr 2024 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUL9Opqg"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4608712FB05;
	Fri, 19 Apr 2024 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713546219; cv=none; b=nsMz7ChFXQUquMH/1LJKq3fciYWxhRA0ojHrmOV2zgTnLwgDSI0uP3hI7whCDzM4lKcWELNsxkiG1+OSwAe9W2bB2tcaIZ3x1bAP9WILtbK3eH43ra+5gZZcbmjef9ZEjunkP+6Yr4ESfrCzPz0zhhRmFW47WgGlxNBIr4aoa34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713546219; c=relaxed/simple;
	bh=jFxi5qZrScF2xjH3z+fMU0rA+S3WPw/R5/k/PlfLlD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4ek9+vpT8JzKWf48sYDBD4TxWUGYKv1hvrhUh3Nxip5z2b4Fob52CcB8CoHsXPt/W9HDsthfVmv2LjwHOndiQcFEbyBDywszlnNn/inRk2Nv3mrWehTUbqJpLdaW7CA7ZT0ICC3p1ge+5Moq7+VQFeIAPBt3ijBXdevda2RjWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUL9Opqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D36C3277B;
	Fri, 19 Apr 2024 17:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713546218;
	bh=jFxi5qZrScF2xjH3z+fMU0rA+S3WPw/R5/k/PlfLlD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RUL9Opqg9lVQKyIEyIuq2xjKwlBEmIHBH/IVoveA6aP2JLQi0uzPvTDRn7OmSzfgD
	 nIb4g/5o2RBtfUp3FCsBZLo4UMhQBN8itmVTPuHB1vCt7tnCtqGOlM7w17hYv3aiWy
	 FPRpIYW/h0QBF2/1gYcg2KSSl6cBIyHw8P1BRp78GQ/1rnAZNqj1HgINRQQE2y6kx8
	 pa/lP0BVFbrI+oqwHSJpzLJUH1OONwzfgc8jyKWmKgwbnoS/jGKAA+PE+NrL1eKBBr
	 VPLO+D3Fy9QluAkUMgIaLcYTb9+hJ5Az7wIHrpBlSplLPGXqXzT9s0UFhk3C1grs7n
	 akOPXTz5YdCXA==
Date: Fri, 19 Apr 2024 20:02:17 +0300
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
Message-ID: <ZiKjmaDgz_56ovbv@kernel.org>
References: <20240415075241.GF40213@noisy.programming.kicks-ass.net>
 <Zh1lnIdgFeM1o8S5@FVFF77S0Q05N.cambridge.arm.com>
 <Zh4nJp8rv1qRBs8m@kernel.org>
 <CAPhsuW6Pbg2k_Gu4dsBx+H8H5XCHvNdtEZJBPiG_eT0qqr9D1w@mail.gmail.com>
 <ZiE91CJcNw7gBj9g@kernel.org>
 <CAPhsuW4au6v8k8Ab7Ff6Yj64rGvZ7wkz=Xrgh8ZZtLyscpChqQ@mail.gmail.com>
 <ZiFd567L4Zzm2okO@kernel.org>
 <CAPhsuW5SL4_=ZXdHZV8o0KS+5Vf25UMvEKhRgFQLioFtf2pgoQ@mail.gmail.com>
 <ZiIVVBgaDN4RsroT@kernel.org>
 <CAPhsuW7WoU+a46FhqqH8f-3=ehxeD4wSgKDWegMin1pT49OSWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW7WoU+a46FhqqH8f-3=ehxeD4wSgKDWegMin1pT49OSWw@mail.gmail.com>

On Fri, Apr 19, 2024 at 08:54:40AM -0700, Song Liu wrote:
> On Thu, Apr 18, 2024 at 11:56 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Thu, Apr 18, 2024 at 02:01:22PM -0700, Song Liu wrote:
> > > On Thu, Apr 18, 2024 at 10:54 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > >
> > > > On Thu, Apr 18, 2024 at 09:13:27AM -0700, Song Liu wrote:
> > > > > On Thu, Apr 18, 2024 at 8:37 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > > > > > >
> > > > > > > > I'm looking at execmem_types more as definition of the consumers, maybe I
> > > > > > > > should have named the enum execmem_consumer at the first place.
> > > > > > >
> > > > > > > I think looking at execmem_type from consumers' point of view adds
> > > > > > > unnecessary complexity. IIUC, for most (if not all) archs, ftrace, kprobe,
> > > > > > > and bpf (and maybe also module text) all have the same requirements.
> > > > > > > Did I miss something?
> > > > > >
> > > > > > It's enough to have one architecture with different constrains for kprobes
> > > > > > and bpf to warrant a type for each.
> > > > >
> > > > > AFAICT, some of these constraints can be changed without too much work.
> > > >
> > > > But why?
> > > > I honestly don't understand what are you trying to optimize here. A few
> > > > lines of initialization in execmem_info?
> > >
> > > IIUC, having separate EXECMEM_BPF and EXECMEM_KPROBE makes it
> > > harder for bpf and kprobe to share the same ROX page. In many use cases,
> > > a 2MiB page (assuming x86_64) is enough for all BPF, kprobe, ftrace, and
> > > module text. It is not efficient if we have to allocate separate pages for each
> > > of these use cases. If this is not a problem, the current approach works.
> >
> > The caching of large ROX pages does not need to be per type.
> >
> > In the POC I've posted for caching of large ROX pages on x86 [1], the cache is
> > global and to make kprobes and bpf use it it's enough to set a flag in
> > execmem_info.
> >
> > [1] https://lore.kernel.org/all/20240411160526.2093408-1-rppt@kernel.org
> 
> For the ROX to work, we need different users (module text, kprobe, etc.) to have
> the same execmem_range. From [1]:
> 
> static void *execmem_cache_alloc(struct execmem_range *range, size_t size)
> {
> ...
>        p = __execmem_cache_alloc(size);
>        if (p)
>                return p;
>       err = execmem_cache_populate(range, size);
> ...
> }
> 
> We are calling __execmem_cache_alloc() without range. For this to work,
> we can only call execmem_cache_alloc() with one execmem_range.

Actually, on x86 this will "just work" because everything shares the same
address space :)

The 2M pages in the cache will be in the modules space, so
__execmem_cache_alloc() will always return memory from that address space.

For other architectures this indeed needs to be fixed with passing the
range to __execmem_cache_alloc() and limiting search in the cache for that
range.
 
> Did I miss something?
> 
> Thanks,
> Song

-- 
Sincerely yours,
Mike.

