Return-Path: <linux-arch+bounces-3835-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A7B8ABAA5
	for <lists+linux-arch@lfdr.de>; Sat, 20 Apr 2024 11:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1D0281979
	for <lists+linux-arch@lfdr.de>; Sat, 20 Apr 2024 09:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6C317BA2;
	Sat, 20 Apr 2024 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiOFFcIs"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C55B107B2;
	Sat, 20 Apr 2024 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713604294; cv=none; b=Fy48uhlfA6rQXRwBe/7xJ1A+SPT7iQ6GlhXZDS+jYjYbIB+mkAH6149Bfl+v+GNbJ3a6tbmDKSQcoHKPsSq0C1ZdvMkNE1HkH+nll2AgdeRwf5vWVz6LJKUASjBxDNiNM9KZmK53cwQVNAD53RUkdcy2KHt0mSz/jkZAzjTCfN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713604294; c=relaxed/simple;
	bh=gx+4p/uDBfF9iByUyBCzGltg748yzYFaTBhBB8UsaaI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=A6Qxdt0AlZnQ2f3oFAxplmICh7d02SlpM8GM6tpCIJu0o5bSf4PZiaxfL/79BMxWNCKNtC/B5xrShbqSSABPNlnZRrSQFY+kHCeJKOwIcmo23PP1fyJ02HovmuRPj1m+tQBVbx1u8eCkaJ1m8j4q6zWhPwg6WAuT+sAUr2zN/2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiOFFcIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72072C072AA;
	Sat, 20 Apr 2024 09:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713604294;
	bh=gx+4p/uDBfF9iByUyBCzGltg748yzYFaTBhBB8UsaaI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WiOFFcIsUZjqS2Hu+iFB3XXcMZa5pzL1HBjixIci52d8Dz9R1WD9G9VB56jkKYeZ0
	 yDy0eI1sbeixq6g8aSxoZ6nlN7GVrsoYNR+OtdV5qezCXWWNalxmX0AQMOmxxVvjB8
	 mDIxwHW3sBjsjL/fldCkVAVACyfuDXihwfUSyE32m5VVdZN1QGS01/8WCa5+GHvn0e
	 eqnq4e8Pva3SV5BNn9cHwpijQL1+svPQU6wcQztqSBwE5iNQ3v/A2Gh1fOxnMqAWe6
	 p9b3Z1WSt5cu2C+P9w6zBxw+xdBSQlJVW4JFCyv2uFOrSDGSq+nT5wb2kq12tKe8xw
	 OK7o8nQPMJ1wg==
Date: Sat, 20 Apr 2024 18:11:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Song Liu <song@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Peter
 Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, Alexandre
 Ghiti <alexghiti@rivosinc.com>, Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Topel <bjorn@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, "David S. Miller"
 <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, Donald Dutile
 <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>, Heiko Carstens
 <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen
 <chenhuacai@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, Luis
 Chamberlain <mcgrof@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nadav Amit <nadav.amit@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Puranjay Mohan <puranjay12@gmail.com>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Russell King <linux@armlinux.org.uk>, Steven
 Rostedt <rostedt@goodmis.org>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, Will
 Deacon <will@kernel.org>, bpf@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4 05/15] mm: introduce execmem_alloc() and
 execmem_free()
Message-Id: <20240420181121.d6c7be11a6f98dc2462f8b41@kernel.org>
In-Reply-To: <ZiNDGjkcqEPqruza@kernel.org>
References: <ZiE91CJcNw7gBj9g@kernel.org>
	<CAPhsuW4au6v8k8Ab7Ff6Yj64rGvZ7wkz=Xrgh8ZZtLyscpChqQ@mail.gmail.com>
	<ZiFd567L4Zzm2okO@kernel.org>
	<CAPhsuW5SL4_=ZXdHZV8o0KS+5Vf25UMvEKhRgFQLioFtf2pgoQ@mail.gmail.com>
	<ZiIVVBgaDN4RsroT@kernel.org>
	<CAPhsuW7WoU+a46FhqqH8f-3=ehxeD4wSgKDWegMin1pT49OSWw@mail.gmail.com>
	<ZiKjmaDgz_56ovbv@kernel.org>
	<CAPhsuW7Nj1Sa_9xQtTgHz9AmX39zdh2x2COqA-qmkfpfX9hNWw@mail.gmail.com>
	<ZiLNGgVSQ7_cg58y@kernel.org>
	<CAPhsuW4KRM4O4RFbYQrt=Coqyh9w29WiF2YF=8soDfauLFsKBA@mail.gmail.com>
	<ZiNDGjkcqEPqruza@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 20 Apr 2024 07:22:50 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> On Fri, Apr 19, 2024 at 02:42:16PM -0700, Song Liu wrote:
> > On Fri, Apr 19, 2024 at 1:00 PM Mike Rapoport <rppt@kernel.org> wrote:
> > >
> > > On Fri, Apr 19, 2024 at 10:32:39AM -0700, Song Liu wrote:
> > > > On Fri, Apr 19, 2024 at 10:03 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > > [...]
> > > > > > >
> > > > > > > [1] https://lore.kernel.org/all/20240411160526.2093408-1-rppt@kernel.org
> > > > > >
> > > > > > For the ROX to work, we need different users (module text, kprobe, etc.) to have
> > > > > > the same execmem_range. From [1]:
> > > > > >
> > > > > > static void *execmem_cache_alloc(struct execmem_range *range, size_t size)
> > > > > > {
> > > > > > ...
> > > > > >        p = __execmem_cache_alloc(size);
> > > > > >        if (p)
> > > > > >                return p;
> > > > > >       err = execmem_cache_populate(range, size);
> > > > > > ...
> > > > > > }
> > > > > >
> > > > > > We are calling __execmem_cache_alloc() without range. For this to work,
> > > > > > we can only call execmem_cache_alloc() with one execmem_range.
> > > > >
> > > > > Actually, on x86 this will "just work" because everything shares the same
> > > > > address space :)
> > > > >
> > > > > The 2M pages in the cache will be in the modules space, so
> > > > > __execmem_cache_alloc() will always return memory from that address space.
> > > > >
> > > > > For other architectures this indeed needs to be fixed with passing the
> > > > > range to __execmem_cache_alloc() and limiting search in the cache for that
> > > > > range.
> > > >
> > > > I think we at least need the "map to" concept (initially proposed by Thomas)
> > > > to get this work. For example, EXECMEM_BPF and EXECMEM_KPROBE
> > > > maps to EXECMEM_MODULE_TEXT, so that all these actually share
> > > > the same range.
> > >
> > > Why?
> > 
> > IIUC, we need to update __execmem_cache_alloc() to take a range pointer as
> > input. module text will use "range" for EXECMEM_MODULE_TEXT, while kprobe
> > will use "range" for EXECMEM_KPROBE. Without "map to" concept or sharing
> > the "range" object, we will have to compare different range parameters to check
> > we can share cached pages between module text and kprobe, which is not
> > efficient. Did I miss something?

Song, thanks for trying to eplain. I think I need to explain why I used
module_alloc() originally.

This depends on how kprobe features are implemented on the architecture, and
how much features are supported on kprobes.

Because kprobe jump optimization and kprobe jump-back optimization need to
use a jump instruction to jump into the trampoline and jump back from the
trampoline directly, if the architecuture jmp instruction supports +-2GB range
like x86, it needs to allocate the trampoline buffer inside such address space.
This requirement is similar to the modules (because module function needs to
call other functions in the kernel etc.), at least kprobes on x86 used
module_alloc().

However, if an architecture only supports breakpoint/trap based kprobe,
it does not need to consider whether the execmem is allocated.

> 
> We can always share large ROX pages as long as they are within the correct
> address space. The permissions for them are ROX and the alignment
> differences are due to KASAN and this is handled during allocation of the
> large page to refill the cache. __execmem_cache_alloc() only needs to limit
> the search for the address space of the range.

So I don't think EXECMEM_KPROBE always same as EXECMEM_MODULE_TEXT, it
should be configured for each arch. Especially, if it is only used for
searching parameter, it looks OK to me.

Thank you,

> 
> And regardless, they way we deal with sharing of the cache can be sorted
> out later.
> 
> > Thanks,
> > Song
> 
> -- 
> Sincerely yours,
> Mike.
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

