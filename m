Return-Path: <linux-arch+bounces-3809-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C758AA191
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 19:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2D57B21095
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 17:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DE8176FAB;
	Thu, 18 Apr 2024 17:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qitx/umw"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2311442F4;
	Thu, 18 Apr 2024 17:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713462839; cv=none; b=i9w5i8935nPo1sdrS6/UQmSKRCap9P+Ga8M96m0Aa2f/AaDznnb7SrkKX6zzJPlkzGj83Owk1yKukmnFLuQFHgUBDKAeCJDUXlKZERBL97VW/vtESPO+UH/iOIi0RdTKmrDjokSBxgUbb1c47Q6ersSVFvKXv18DQNEr6rzQYDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713462839; c=relaxed/simple;
	bh=GVKHg9/GMb+Q7svthQO5bm+rPzNDL6zXlQZOsDeKWL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPDzZv5Y/UdvP5C0JHl0OsL2oiIyxexW4QoxqHuXhvBsKnOxQsbvnFrhuqK/y8RwqIwVgQLyace7C4RywoTWZIjx8w1Mvl2OrVeuA6YyeEuJdEVgz7BIGd8GYISmj1vCGm/Slf3tCd6PZdiqc/ocV0DX5HFZ9kCkgZCd25yjBMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qitx/umw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F12DC3277B;
	Thu, 18 Apr 2024 17:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713462839;
	bh=GVKHg9/GMb+Q7svthQO5bm+rPzNDL6zXlQZOsDeKWL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qitx/umwjvXDKNme47QxvztrUiipBcKV2Lg0Yvd1RXezrm9EMN+zfFrxXb923+dxO
	 AxZ6KgXvjlorR3mUIjvBXST4+3n8nelthPynguxJTOQoS9rNBrqZ+3MIlU37kTQ9FA
	 a4e+nx+8unMMLT17+KcFFJ93DVlkbK2eXc4Av0nU3f2Yxj+rBXrkR0WI95IANr/7qX
	 uZj4q1Xb4qjUIP87QNJk+Jgy4oid7eW9FtvEPOx7D0x1Tt1iXSqSWNLPcTP4XbQ2OW
	 z8BEya9Rxr0dlQHlDm5T4jpRs2aqcA2Iy8EkKuiv4ehWjUKDt48ywWZ7K+xjdgeN4d
	 Qxf4CJCyjHkiA==
Date: Thu, 18 Apr 2024 20:52:39 +0300
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
Message-ID: <ZiFd567L4Zzm2okO@kernel.org>
References: <20240411160051.2093261-1-rppt@kernel.org>
 <20240411160051.2093261-6-rppt@kernel.org>
 <20240415075241.GF40213@noisy.programming.kicks-ass.net>
 <Zh1lnIdgFeM1o8S5@FVFF77S0Q05N.cambridge.arm.com>
 <Zh4nJp8rv1qRBs8m@kernel.org>
 <CAPhsuW6Pbg2k_Gu4dsBx+H8H5XCHvNdtEZJBPiG_eT0qqr9D1w@mail.gmail.com>
 <ZiE91CJcNw7gBj9g@kernel.org>
 <CAPhsuW4au6v8k8Ab7Ff6Yj64rGvZ7wkz=Xrgh8ZZtLyscpChqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4au6v8k8Ab7Ff6Yj64rGvZ7wkz=Xrgh8ZZtLyscpChqQ@mail.gmail.com>

On Thu, Apr 18, 2024 at 09:13:27AM -0700, Song Liu wrote:
> On Thu, Apr 18, 2024 at 8:37 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > >
> > > > I'm looking at execmem_types more as definition of the consumers, maybe I
> > > > should have named the enum execmem_consumer at the first place.
> > >
> > > I think looking at execmem_type from consumers' point of view adds
> > > unnecessary complexity. IIUC, for most (if not all) archs, ftrace, kprobe,
> > > and bpf (and maybe also module text) all have the same requirements.
> > > Did I miss something?
> >
> > It's enough to have one architecture with different constrains for kprobes
> > and bpf to warrant a type for each.
> 
> AFAICT, some of these constraints can be changed without too much work.

But why?
I honestly don't understand what are you trying to optimize here. A few
lines of initialization in execmem_info?
What is the advantage in forcing architectures to have imposed limits on
kprobes or bpf allocations?

> > Where do you see unnecessary complexity?
> >
> > > IOW, we have
> > >
> > > enum execmem_type {
> > >         EXECMEM_DEFAULT,
> > >         EXECMEM_TEXT,
> > >         EXECMEM_KPROBES = EXECMEM_TEXT,
> > >         EXECMEM_FTRACE = EXECMEM_TEXT,
> > >         EXECMEM_BPF = EXECMEM_TEXT,      /* we may end up without
> > > _KPROBE, _FTRACE, _BPF */
> > >         EXECMEM_DATA,  /* rw */
> > >         EXECMEM_RO_DATA,
> > >         EXECMEM_RO_AFTER_INIT,
> > >         EXECMEM_TYPE_MAX,
> > > };
> > >
> > > Does this make sense?
> >
> > How do you suggest to deal with e.g. riscv that has separate address spaces
> > for modules, kprobes and bpf?
> 
> IIUC, modules and bpf use the same address space on riscv

Not exactly, bpf is a subset of modules on riscv.

> while kprobes use vmalloc address.

The whole point of using the entire vmalloc for kprobes is to avoid
pollution of limited modules space.
 
> Thanks,
> Song

-- 
Sincerely yours,
Mike.

