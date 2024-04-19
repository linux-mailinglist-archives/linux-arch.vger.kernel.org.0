Return-Path: <linux-arch+bounces-3831-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E70458AB5CD
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 22:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F261F229FA
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 20:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65B413CAB5;
	Fri, 19 Apr 2024 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hePROBT+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9651513C9CB;
	Fri, 19 Apr 2024 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713556842; cv=none; b=SE3wbmV8qDwQjD/+g32s18FwXpNNAg5Ib0NchlqfXCnmEXss6Cs3CiXoNHbFRyKXK+domDfSOGJ7j5ykMKrX8r+i5mrl7Y6gfD/EnC28zLh5+A/TvgaSxsQXm0ZaPnR0Yjc4kI0/84iN3OASp9gZWIuq5AJbekUxLqLPxpsF8qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713556842; c=relaxed/simple;
	bh=1irIlRUcjlhAgXQYQkJd/oGHdCUHLQFxqqgY1XfLhP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpQ5GM0/X29Fn+zEyr17iQ0OjGTs8i2rF3WHCXqGpT98PL8igV4sIjBIBCngaK3AtR8lA8RQJXMxqa7GFcyuW1PX1kdBIuIMpi3/3z+hlG9Kz+BzjTClkm52stIqCZ44Qa4JkQY1Ea0y9lZljmporMsntjtjEbYAILm/NXe3dJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hePROBT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E93C116B1;
	Fri, 19 Apr 2024 20:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713556842;
	bh=1irIlRUcjlhAgXQYQkJd/oGHdCUHLQFxqqgY1XfLhP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hePROBT+glizGF2HhWjQfOISipAvaDLeIwoPfB6eB/130EUaYxI8C9JiOZ0p4IuPP
	 wJr3uvJ18Qdtvzvp+1EN21A1wIYXV57CwgYBWxwwSTpuZVC3Y+zaCK4bAzWjqyz19x
	 of4ezj0xR0KrcZGKrma2TwE1tPaK9aqfe2f5ZULEd8dNouln7cfqCdOX1Qzu+4TMk8
	 WLbPp6C0rIz8BNuB+lG6UD/vpJZsyvT1zRcqUNkcRP+vw16ocKGnhDqx8/KxOoGcQD
	 fvWWbiJ1tqrYnX18IQfVwbrFy6dcbjd61pDUGP6pZkbtq0sqUsgCyvD6UjOkfp09sG
	 phC1jK7//sNkA==
Date: Fri, 19 Apr 2024 22:59:22 +0300
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
Message-ID: <ZiLNGgVSQ7_cg58y@kernel.org>
References: <Zh4nJp8rv1qRBs8m@kernel.org>
 <CAPhsuW6Pbg2k_Gu4dsBx+H8H5XCHvNdtEZJBPiG_eT0qqr9D1w@mail.gmail.com>
 <ZiE91CJcNw7gBj9g@kernel.org>
 <CAPhsuW4au6v8k8Ab7Ff6Yj64rGvZ7wkz=Xrgh8ZZtLyscpChqQ@mail.gmail.com>
 <ZiFd567L4Zzm2okO@kernel.org>
 <CAPhsuW5SL4_=ZXdHZV8o0KS+5Vf25UMvEKhRgFQLioFtf2pgoQ@mail.gmail.com>
 <ZiIVVBgaDN4RsroT@kernel.org>
 <CAPhsuW7WoU+a46FhqqH8f-3=ehxeD4wSgKDWegMin1pT49OSWw@mail.gmail.com>
 <ZiKjmaDgz_56ovbv@kernel.org>
 <CAPhsuW7Nj1Sa_9xQtTgHz9AmX39zdh2x2COqA-qmkfpfX9hNWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW7Nj1Sa_9xQtTgHz9AmX39zdh2x2COqA-qmkfpfX9hNWw@mail.gmail.com>

On Fri, Apr 19, 2024 at 10:32:39AM -0700, Song Liu wrote:
> On Fri, Apr 19, 2024 at 10:03 AM Mike Rapoport <rppt@kernel.org> wrote:
> [...]
> > > >
> > > > [1] https://lore.kernel.org/all/20240411160526.2093408-1-rppt@kernel.org
> > >
> > > For the ROX to work, we need different users (module text, kprobe, etc.) to have
> > > the same execmem_range. From [1]:
> > >
> > > static void *execmem_cache_alloc(struct execmem_range *range, size_t size)
> > > {
> > > ...
> > >        p = __execmem_cache_alloc(size);
> > >        if (p)
> > >                return p;
> > >       err = execmem_cache_populate(range, size);
> > > ...
> > > }
> > >
> > > We are calling __execmem_cache_alloc() without range. For this to work,
> > > we can only call execmem_cache_alloc() with one execmem_range.
> >
> > Actually, on x86 this will "just work" because everything shares the same
> > address space :)
> >
> > The 2M pages in the cache will be in the modules space, so
> > __execmem_cache_alloc() will always return memory from that address space.
> >
> > For other architectures this indeed needs to be fixed with passing the
> > range to __execmem_cache_alloc() and limiting search in the cache for that
> > range.
> 
> I think we at least need the "map to" concept (initially proposed by Thomas)
> to get this work. For example, EXECMEM_BPF and EXECMEM_KPROBE
> maps to EXECMEM_MODULE_TEXT, so that all these actually share
> the same range.

Why?
 
> Does this make sense?
> 
> Song

-- 
Sincerely yours,
Mike.

