Return-Path: <linux-arch+bounces-3833-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E19F8AB97D
	for <lists+linux-arch@lfdr.de>; Sat, 20 Apr 2024 06:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71CF1C2094F
	for <lists+linux-arch@lfdr.de>; Sat, 20 Apr 2024 04:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFDCD524;
	Sat, 20 Apr 2024 04:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhvasTWv"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7469625;
	Sat, 20 Apr 2024 04:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713587053; cv=none; b=VhWLqgak1Me5Cq17UDoX0QXk5gkU+nrxjDO8pZPvjSfj9wdd6re/jCFHzfxqtTYo8mur88T2jhfgBCNc3y2AAbsRUDEQ9DI5HbL5TpAq33FX2m0IJzD79DUYiegmUH9tj2dAQMnq56wncp5pNuq6/pJRWi43VnntYAppSasH6gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713587053; c=relaxed/simple;
	bh=XIe/vC5nJoDDEu9/Q7ZoXeJlkdIzu3x0dG0pVHSQyaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/F3neD3QRJUKWQQrsGReOJCd+id8uImiaYCDBFlCN1puOdsR7K4TtL+9KwScLfGZ6B+uxNZcg6TXPXy8rzXEikkur2n5rfEuGJ+qM4ICOq7CQpbGshFuy1tQ/sse2zqGqjMfqM6U2FRv+QXhb/B0VfeN6sdV9pt8q3w1sYUOn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhvasTWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83904C072AA;
	Sat, 20 Apr 2024 04:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713587052;
	bh=XIe/vC5nJoDDEu9/Q7ZoXeJlkdIzu3x0dG0pVHSQyaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YhvasTWvPZXPkThPYjnuTXJtKsDsFI6ZK4Bt9IvngW4VcopIHwZq0rN2TN47VCWUq
	 FBJkDpR2DtP+unWDJY8C7sJEQiAOVs8L9KzXsojOjPLi6kQ9YDHioYtZ6nUFM1e0iU
	 J5CLWhI8Oh/UQKju6kDG7HnVFfwfwBxuIE1OR267WnG9gRFiBTNZwpWVx17pWQtTrY
	 fdbuHV6o8S3vVJ6wqWsJuIqtAsaxpsI2nzHYz53bqy1qeEbZ3ljz7qw9wo3USiXNjB
	 OSy86A07SSbIPPzvVI3U5+/bWUkfoO6zoETP+0NHBuzBlMRXY9HoUBu5v7wjVTOH+s
	 DowdwAPfYuE4g==
Date: Sat, 20 Apr 2024 07:22:50 +0300
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
Message-ID: <ZiNDGjkcqEPqruza@kernel.org>
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
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4KRM4O4RFbYQrt=Coqyh9w29WiF2YF=8soDfauLFsKBA@mail.gmail.com>

On Fri, Apr 19, 2024 at 02:42:16PM -0700, Song Liu wrote:
> On Fri, Apr 19, 2024 at 1:00 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Fri, Apr 19, 2024 at 10:32:39AM -0700, Song Liu wrote:
> > > On Fri, Apr 19, 2024 at 10:03 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > [...]
> > > > > >
> > > > > > [1] https://lore.kernel.org/all/20240411160526.2093408-1-rppt@kernel.org
> > > > >
> > > > > For the ROX to work, we need different users (module text, kprobe, etc.) to have
> > > > > the same execmem_range. From [1]:
> > > > >
> > > > > static void *execmem_cache_alloc(struct execmem_range *range, size_t size)
> > > > > {
> > > > > ...
> > > > >        p = __execmem_cache_alloc(size);
> > > > >        if (p)
> > > > >                return p;
> > > > >       err = execmem_cache_populate(range, size);
> > > > > ...
> > > > > }
> > > > >
> > > > > We are calling __execmem_cache_alloc() without range. For this to work,
> > > > > we can only call execmem_cache_alloc() with one execmem_range.
> > > >
> > > > Actually, on x86 this will "just work" because everything shares the same
> > > > address space :)
> > > >
> > > > The 2M pages in the cache will be in the modules space, so
> > > > __execmem_cache_alloc() will always return memory from that address space.
> > > >
> > > > For other architectures this indeed needs to be fixed with passing the
> > > > range to __execmem_cache_alloc() and limiting search in the cache for that
> > > > range.
> > >
> > > I think we at least need the "map to" concept (initially proposed by Thomas)
> > > to get this work. For example, EXECMEM_BPF and EXECMEM_KPROBE
> > > maps to EXECMEM_MODULE_TEXT, so that all these actually share
> > > the same range.
> >
> > Why?
> 
> IIUC, we need to update __execmem_cache_alloc() to take a range pointer as
> input. module text will use "range" for EXECMEM_MODULE_TEXT, while kprobe
> will use "range" for EXECMEM_KPROBE. Without "map to" concept or sharing
> the "range" object, we will have to compare different range parameters to check
> we can share cached pages between module text and kprobe, which is not
> efficient. Did I miss something?

We can always share large ROX pages as long as they are within the correct
address space. The permissions for them are ROX and the alignment
differences are due to KASAN and this is handled during allocation of the
large page to refill the cache. __execmem_cache_alloc() only needs to limit
the search for the address space of the range.

And regardless, they way we deal with sharing of the cache can be sorted
out later.

> Thanks,
> Song

-- 
Sincerely yours,
Mike.

