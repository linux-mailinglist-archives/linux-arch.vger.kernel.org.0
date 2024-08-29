Return-Path: <linux-arch+bounces-6790-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B658963C5A
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 09:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EFFC1F22851
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 07:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562DC15CD7D;
	Thu, 29 Aug 2024 07:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PIIEhp54"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F6C16D33C
	for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2024 07:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724915672; cv=none; b=lnJEh/Fq49KDKB2veGH23NXPsNCAesqSJhFnfRHLcdzJXeewOZP02qgPD3jLu1ZqEzepV70F+qG6Q4cT5rRD2+KnXKSLzbgY2Ky+Yg7WRcQlFtVKWeWL7sjytAToep5gjJnZPHf5kxK7DMTtSK2M4YeFUy8VoBb/pMp03bDGYwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724915672; c=relaxed/simple;
	bh=mNPIeGFfgjC58ulUTJ+p+Pb5VTFBXszyjEecP5hXE0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLwshiBirKWkk0CYH5n4gHVVLrApQq9lVwJO0oGkOTRdjxVKAiBoN7Zmaa9AXN+gV4XVS9qypjo/jfaYMsL5yvFrRcdtVwwA7GbsEpD1MF1tJzO/0bkIIDZeF4Qb/flitRkyGX108KPRIVrRlmzpASeAxdf9IqIUC+8MdT9n3Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=PIIEhp54; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7143ae1b560so190842b3a.1
        for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2024 00:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724915668; x=1725520468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=59qS8d6E7jAm/hvEeiY72pf/LRpSv6Q2qjD/8hJgS38=;
        b=PIIEhp54GOUcEbiVG3smr8WA1ZLj8nAAx5k3WfnPUD++LVzbh72TtgNZcQqA4Loc69
         SfxWVNo8xkoGeVS3KZsCBKyJ2HN+N+B9N3tFN/48xOhqVeDVHX/S/1hCPBb2gol/BP8J
         hdzWRj3w25NqzOwmdHVXrDu8ncd9378ljlADKQRHSxz9v9cv6+fdtr6Kbo+mzYoXkNsv
         3HDohwlD3A3RWzUyLLsEVoJt10ASz2Dn+1GZvl7GWagfRXsztJXa/8zKZL3MmKhws1e1
         AhDILhheeUphBmdl/ETIszbSXtndhDvM2zL9L6igHZOVUdCnhWWLRPxOcFwaz0A7HXyH
         1r7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724915668; x=1725520468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59qS8d6E7jAm/hvEeiY72pf/LRpSv6Q2qjD/8hJgS38=;
        b=ErO9fYRmAARPtVyASUAojSGrURKk8pcSemoTUrWDpUcSmckprrwUWjiafnYUyzy8tp
         POjTFNQ4KTAnlUur60sxaSSp0woATS9M9Q1vnjYtEwjW92mFb9kBt/rGAWuIgr6eVo6t
         QojgKXWs04Cf7wTcR8p1ees0T9q6z1BfzhjSkk42AuglfdBu/Ou0hj4fpGaizo2zv6ff
         g17HN5za81JQ0vlGnH4BkoAi8ODQuhIAY6iovocwqnaNavweAjUEDME/b13TIZ98KkdA
         R3FU1p45AyJqCmF2N8ECElvYj/dkg1ESq6JCO1rr0FZknoRdCA7+UJ/mntGXwfylXjlH
         MUVg==
X-Forwarded-Encrypted: i=1; AJvYcCVXSIPAe2ur8Lb4qU0W5obqJUnoir336rQQq/pp9dPJ34vHoqgXwcxlJY2p7deMQwpt6grQZeHLMre1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/uPXHLPqUPrKJiDcCkQCagg+/YqDWwoEVuQ2TtBFFRWNNZWC/
	jpwlbZYJG1zninKmKtsj4rxbTk6PbhcfkcANGpDcSgGR/LF5L8jRerOfYnN4u0A=
X-Google-Smtp-Source: AGHT+IFxhM4cuDGdAmG+3DSZ8PIKqAZRC1xEgxgW4g8JXtjfrvLb83nabdJs3AxBg2ozZcKKdgajyA==
X-Received: by 2002:a05:6a20:e196:b0:1c4:c1cd:a29d with SMTP id adf61e73a8af0-1cce101c8fdmr2021570637.28.1724915668227;
        Thu, 29 Aug 2024 00:14:28 -0700 (PDT)
Received: from ghost (c-67-164-127-253.hsd1.ca.comcast.net. [67.164.127.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d9716sm545002b3a.174.2024.08.29.00.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 00:14:27 -0700 (PDT)
Date: Thu, 29 Aug 2024 00:14:22 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-mm@kvack.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/16] mm: Introduce MAP_BELOW_HINT
Message-ID: <ZtAfzrOMitPlx96X@ghost>
References: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
 <2570b1ea-d2a4-4bcb-9bb3-8d979657c56a@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2570b1ea-d2a4-4bcb-9bb3-8d979657c56a@lucifer.local>

On Wed, Aug 28, 2024 at 07:19:36PM +0100, Lorenzo Stoakes wrote:
> On Tue, Aug 27, 2024 at 10:49:06PM GMT, Charlie Jenkins wrote:
> > Some applications rely on placing data in free bits addresses allocated
> > by mmap. Various architectures (eg. x86, arm64, powerpc) restrict the
> > address returned by mmap to be less than the maximum address space,
> > unless the hint address is greater than this value.
> >
> > On arm64 this barrier is at 52 bits and on x86 it is at 56 bits. This
> > flag allows applications a way to specify exactly how many bits they
> > want to be left unused by mmap. This eliminates the need for
> > applications to know the page table hierarchy of the system to be able
> > to reason which addresses mmap will be allowed to return.
> >
> > ---
> > riscv made this feature of mmap returning addresses less than the hint
> > address the default behavior. This was in contrast to the implementation
> > of x86/arm64 that have a single boundary at the 5-level page table
> > region. However this restriction proved too great -- the reduced
> > address space when using a hint address was too small.
> >
> > A patch for riscv [1] reverts the behavior that broke userspace. This
> > series serves to make this feature available to all architectures.
> 
> I'm a little confused as to the justification for this - you broke RISC V by
> doing this, and have now reverted it, but now offer the same behaviour that
> broke RISC V to all other architectures?
> 
> I mean this is how this reads, so I might be being ungenerous here :) but would
> be good to clarify what the value-add is here.

Yeah I did not do a good job of explaining this! Having this be the
default behavior was broken, not that this feature in general was
broken.

> 
> I also wonder at use of a new MAP_ flag, they're a limited resource and we
> should only ever add them if we _really_ need to. This seems a bit niche and
> specific to be making such a big change for including touching a bunch of pretty
> sensitive arch-specific code.
>
> We have the ability to change how mmap() functions through 'personalities'
> though of course this would impact every mmap() call in the process.
> 
> Overall I'm really not hugely convinced by this, it feels like userland
> could find better ways of doing this (mostly you'd do a PROT_NONE mmap() to
> reserve a domain and mprotect() it on allocation or mmap() over it).
> 
> So I just struggle to see the purpose myself. BUT absolutely I may be
> missing context/others may have a view on the value of this. So happy to
> stand corrected.
> 
> >
> > I have only tested on riscv and x86. There is a tremendous amount of
> 
> Yeah, OK this is crazy, you can't really submit something as non-RFC that
> touches every single arch and not test it.
> 
> I also feel like we need more justification than 'this is a neat thing that
> we use in RISC V sometimes' conceptually for such a big change.

I will send out a new version that does a much better job at explaining!
This is not something that is done on riscv ever currently. This is
something that is done on other architectures such as x86 and arm64.
This flag is to make similar behavior (the ability to force mmap to
return addresses that have a constrained address space) available to all
architectures.

> 
> Also your test program is currently completely broken afaict (have
> commented on it directly). I also feel like your test program is a little
> rudimentary, and should test some edge cases close to the limit etc.
> 
> So I think this is a NACK until there is testing across the board and a little
> more justification.
> 
> Feel free to respin, but I think any future revisions should be RFC until
> we're absolutely sure on testing/justification.
> 
> I appreciate your efforts here so sorry to be negative, but just obviously
> want to make sure this is functional and trades off added complexity for
> value for the kernel and userland :)
> 

Totally understand thank you! After reviewing comments I have realized
that I made this much more complicated than it needs to be. This should
be able to be done without changing any architecture specific code. That
will mostly eliminate all of the complexity, but still has the downside
of consuming a MAP_ flag.

- Charlie

> Thanks!
> 
> > duplicated code in mmap so the implementations across architectures I
> > believe should be mostly consistent. I added this feature to all
> > architectures that implement either
> > arch_get_mmap_end()/arch_get_mmap_base() or
> > arch_get_unmapped_area_topdown()/arch_get_unmapped_area(). I also added
> > it to the default behavior for arch_get_mmap_end()/arch_get_mmap_base().
> >
> > Link: https://lore.kernel.org/lkml/20240826-riscv_mmap-v1-2-cd8962afe47f@rivosinc.com/T/ [1]
> >
> > To: Arnd Bergmann <arnd@arndb.de>
> > To: Paul Walmsley <paul.walmsley@sifive.com>
> > To: Palmer Dabbelt <palmer@dabbelt.com>
> > To: Albert Ou <aou@eecs.berkeley.edu>
> > To: Catalin Marinas <catalin.marinas@arm.com>
> > To: Will Deacon <will@kernel.org>
> > To: Michael Ellerman <mpe@ellerman.id.au>
> > To: Nicholas Piggin <npiggin@gmail.com>
> > To: Christophe Leroy <christophe.leroy@csgroup.eu>
> > To: Naveen N Rao <naveen@kernel.org>
> > To: Muchun Song <muchun.song@linux.dev>
> > To: Andrew Morton <akpm@linux-foundation.org>
> > To: Liam R. Howlett <Liam.Howlett@oracle.com>
> > To: Vlastimil Babka <vbabka@suse.cz>
> > To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > To: Thomas Gleixner <tglx@linutronix.de>
> > To: Ingo Molnar <mingo@redhat.com>
> > To: Borislav Petkov <bp@alien8.de>
> > To: Dave Hansen <dave.hansen@linux.intel.com>
> > To: x86@kernel.org
> > To: H. Peter Anvin <hpa@zytor.com>
> > To: Huacai Chen <chenhuacai@kernel.org>
> > To: WANG Xuerui <kernel@xen0n.name>
> > To: Russell King <linux@armlinux.org.uk>
> > To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > To: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
> > To: Helge Deller <deller@gmx.de>
> > To: Alexander Gordeev <agordeev@linux.ibm.com>
> > To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> > To: Heiko Carstens <hca@linux.ibm.com>
> > To: Vasily Gorbik <gor@linux.ibm.com>
> > To: Christian Borntraeger <borntraeger@linux.ibm.com>
> > To: Sven Schnelle <svens@linux.ibm.com>
> > To: Yoshinori Sato <ysato@users.sourceforge.jp>
> > To: Rich Felker <dalias@libc.org>
> > To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > To: David S. Miller <davem@davemloft.net>
> > To: Andreas Larsson <andreas@gaisler.com>
> > To: Shuah Khan <shuah@kernel.org>
> > To: Alexandre Ghiti <alexghiti@rivosinc.com>
> > Cc: linux-arch@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Palmer Dabbelt <palmer@rivosinc.com>
> > Cc: linux-riscv@lists.infradead.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: linux-mm@kvack.org
> > Cc: loongarch@lists.linux.dev
> > Cc: linux-mips@vger.kernel.org
> > Cc: linux-parisc@vger.kernel.org
> > Cc: linux-s390@vger.kernel.org
> > Cc: linux-sh@vger.kernel.org
> > Cc: sparclinux@vger.kernel.org
> > Cc: linux-kselftest@vger.kernel.org
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> >
> > ---
> > Charlie Jenkins (16):
> >       mm: Add MAP_BELOW_HINT
> >       riscv: mm: Do not restrict mmap address based on hint
> >       mm: Add flag and len param to arch_get_mmap_base()
> >       mm: Add generic MAP_BELOW_HINT
> >       riscv: mm: Support MAP_BELOW_HINT
> >       arm64: mm: Support MAP_BELOW_HINT
> >       powerpc: mm: Support MAP_BELOW_HINT
> >       x86: mm: Support MAP_BELOW_HINT
> >       loongarch: mm: Support MAP_BELOW_HINT
> >       arm: mm: Support MAP_BELOW_HINT
> >       mips: mm: Support MAP_BELOW_HINT
> >       parisc: mm: Support MAP_BELOW_HINT
> >       s390: mm: Support MAP_BELOW_HINT
> >       sh: mm: Support MAP_BELOW_HINT
> >       sparc: mm: Support MAP_BELOW_HINT
> >       selftests/mm: Create MAP_BELOW_HINT test
> >
> >  arch/arm/mm/mmap.c                           | 10 ++++++++
> >  arch/arm64/include/asm/processor.h           | 34 ++++++++++++++++++++++----
> >  arch/loongarch/mm/mmap.c                     | 11 +++++++++
> >  arch/mips/mm/mmap.c                          |  9 +++++++
> >  arch/parisc/include/uapi/asm/mman.h          |  1 +
> >  arch/parisc/kernel/sys_parisc.c              |  9 +++++++
> >  arch/powerpc/include/asm/task_size_64.h      | 36 +++++++++++++++++++++++-----
> >  arch/riscv/include/asm/processor.h           | 32 -------------------------
> >  arch/s390/mm/mmap.c                          | 10 ++++++++
> >  arch/sh/mm/mmap.c                            | 10 ++++++++
> >  arch/sparc/kernel/sys_sparc_64.c             |  8 +++++++
> >  arch/x86/kernel/sys_x86_64.c                 | 25 ++++++++++++++++---
> >  fs/hugetlbfs/inode.c                         |  2 +-
> >  include/linux/sched/mm.h                     | 34 ++++++++++++++++++++++++--
> >  include/uapi/asm-generic/mman-common.h       |  1 +
> >  mm/mmap.c                                    |  2 +-
> >  tools/arch/parisc/include/uapi/asm/mman.h    |  1 +
> >  tools/include/uapi/asm-generic/mman-common.h |  1 +
> >  tools/testing/selftests/mm/Makefile          |  1 +
> >  tools/testing/selftests/mm/map_below_hint.c  | 29 ++++++++++++++++++++++
> >  20 files changed, 216 insertions(+), 50 deletions(-)
> > ---
> > base-commit: 5be63fc19fcaa4c236b307420483578a56986a37
> > change-id: 20240827-patches-below_hint_mmap-b13d79ae1c55
> > --
> > - Charlie
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

