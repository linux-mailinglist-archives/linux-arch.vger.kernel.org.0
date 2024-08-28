Return-Path: <linux-arch+bounces-6734-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E23963348
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 22:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395A3283352
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 20:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B91D1AC89A;
	Wed, 28 Aug 2024 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sfXBm4yH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E812D1AB521
	for <linux-arch@vger.kernel.org>; Wed, 28 Aug 2024 20:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878768; cv=none; b=MoCS8tOcS2b8I9RaFCACQNBN154kVZlqpSbMCHwXkNaQbsSV8fAZZSpmah882wl6SIEGpx33Jn/V9xF4vef1SLlSH7sty0GDVgZwTn3iu0sKgCSlZnqR0Dg6JhL1W2r3gAJzzK96TCLkVMWUpwjnV5ABVb4Htv3+DKmezzeLibA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878768; c=relaxed/simple;
	bh=gJpIxpR/VAlpQp/gicgIPNBdF4tEnI2bNeXKol6jRoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjPzduz+8MSycwhKFvhNSU28UORu4sSwmPloFn1R26TIcow/oMBiOE26AJAnHo7rMxOizNnEUEkN2AWGGYFsfK77ZasUf+we4D4voiMfEeNpWkhTI6vAgfTu8bZOmD7potIxW+h7nXp+xOru/nY0Z9lTkcSXz/gQLa+dor63oGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sfXBm4yH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-715cc93694fso1613577b3a.2
        for <linux-arch@vger.kernel.org>; Wed, 28 Aug 2024 13:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724878763; x=1725483563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i/zDBXzpitxR3zo9kDta1Br+UZ/dQrtli222s8BWZ0g=;
        b=sfXBm4yHksY8QoVcBZeI7hwRL4bbd9ninJ31BFTn7d3eEKad11MzoLOiylCTZ80OL3
         tVoytqC+aUS2uuuYa38JtmXUDkrgwjTS4n0NtWOv67vo3duBQgRuRyuiACNcVjM+UddB
         T+u0ep6yN+hfGXckftMsUdpyju2b7PaiQ5PUbfxiqDSlOHlmsg3zlS3/DRgm/gyPP3EQ
         gSOzikG2bGz/Yom7bLHBDm3sXFQbkEdog0lsTGhVJH/xGQylao8QevzMvmJdEUSxG7uq
         ReVviH1SSNQjRRJY8THp0JzJykJNpAyWRblzk/u2zHXPQOlK1mAIZq48FWgSY1zpDFyg
         8tGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724878763; x=1725483563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/zDBXzpitxR3zo9kDta1Br+UZ/dQrtli222s8BWZ0g=;
        b=G5P7ZXJoEnJmqh2I/AMiWg66aVNmSvsyedRogmmaCbVCsHOorUCHLny7OgiMWwd3mf
         ReL6lnMDLoJxo5a0zOac9EBehCBzeYEX3ym8Bf3yvk+6AnI3mCR7+VzeeKUzDG5izice
         YMvFINaITHOMgKayBKlohj++PMi9rfiFGJxLt6K/xeT4zL4hyTJfk2CR+D4Y/Nk34LLm
         61ExeyOo4ob4cYPBu8HCZxqTaNteErwifGWLrtV4ibQ2LZbM7iwA/lWCy/PnQeqdmcU0
         nbTd77vy8Kn1N6kSVTiPjqEKhh3y4RqZbH4imu6MzACepG2Li4She2b6xVJVsr+aYIVU
         y+3A==
X-Forwarded-Encrypted: i=1; AJvYcCWo2ITSZhtJhbsNBAh6nafIqbmtJnV5MLojVlGCNJs8AmOm7GuldtBGxFlVnUcx5Un1M642V+pbV2pz@vger.kernel.org
X-Gm-Message-State: AOJu0YxXgzfEB1/AQzR5aYby+MgahXP8DZAxGovIGKjCCJG2Qj/axHXS
	72lpmXQ4JwhWzA1l4r+19p9HIe2EFTYr3y43g75hAmYk1WIWYdYYSas+E6jpUU0=
X-Google-Smtp-Source: AGHT+IG7I/ksvpo1L5d4I2EaTAuTvr9NK9oL0S5iJqb7m4xLEH9N4JCU4pfHpqjb0Cf1ei4I8vFF1g==
X-Received: by 2002:a05:6a00:2191:b0:70b:1b51:b8af with SMTP id d2e1a72fcca58-715dfc92f6fmr921313b3a.19.1724878762830;
        Wed, 28 Aug 2024 13:59:22 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714468bf2dbsm8722718b3a.102.2024.08.28.13.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:59:22 -0700 (PDT)
Date: Wed, 28 Aug 2024 13:59:18 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
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
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
Message-ID: <Zs+Ppk0ANaUah7p9@ghost>
References: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
 <dbqqojpvqodfxavt4fxugoj3a2ppk5b4b3sp77qsmbg33sc2em@fhjccbxaihrh>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbqqojpvqodfxavt4fxugoj3a2ppk5b4b3sp77qsmbg33sc2em@fhjccbxaihrh>

On Wed, Aug 28, 2024 at 02:31:42PM -0400, Liam R. Howlett wrote:
> * Charlie Jenkins <charlie@rivosinc.com> [240828 01:49]:
> > Some applications rely on placing data in free bits addresses allocated
> > by mmap. Various architectures (eg. x86, arm64, powerpc) restrict the
> > address returned by mmap to be less than the maximum address space,
> > unless the hint address is greater than this value.
> 
> Wait, what arch(s) allows for greater than the max?  The passed hint
> should be where we start searching, but we go to the lower limit then
> start at the hint and search up (or vice-versa on the directions).
> 

I worded this awkwardly. On arm64 there is a page-table boundary at 48
bits and at 52 bits. On x86 the boundaries are at 48 bits and 57 bits.
The max value mmap is able to return on arm64 is 48 bits if the hint
address uses 48 bits or less, even if the architecture supports 5-level
paging and thus addresses can be 52 bits. Applications can opt-in to
using up to 52-bits in an address by using a hint address greater than
48 bits. x86 has the same behavior but with 57 bits instead of 52.

This reason this exists is because some applications arbitrarily replace
bits in virtual addresses with data with an assumption that the address
will not be using any of the bits above bit 48 in the virtual address.
As hardware with larger address spaces was released, x86 decided to
build safety guards into the kernel to allow the applications that made
these assumptions to continue to work on this different hardware.

This causes all application that use a hint address to silently be
restricted to 48-bit addresses. The goal of this flag is to have a way
for applications to explicitly request how many bits they want mmap to
use.

> I don't understand how unmapping works on a higher address; we would
> fail to free it on termination of the application.
> 
> Also, there are archs that map outside of the VMAs, which are freed by
> freeing from the prev->vm_end to next->vm_start, so I don't understand
> what that looks like in this reality as well.
> 
> > 
> > On arm64 this barrier is at 52 bits and on x86 it is at 56 bits. This
> > flag allows applications a way to specify exactly how many bits they
> > want to be left unused by mmap. This eliminates the need for
> > applications to know the page table hierarchy of the system to be able
> > to reason which addresses mmap will be allowed to return.
> 
> But, why do they need to know today?  We have a limit for this don't we?

The limit is different for different architectures. On x86 the limit is
57 bits, and on arm64 it is 52 bits. So in the theoretical case that an
application requires 10 bits free in a virtual address, the application
would always work on arm64 regardless of the hint address, but on x86 if
the hint address is greater than 48 bits then the application will not
work.

The goal of this flag is to have consistent and tunable behavior of
mmap() when it is desired to ensure that mmap() only returns addresses
that use some number of bits.

> 
> Also, these upper limits are how some archs use the upper bits that you
> are trying to use.
> 

It does not eliminate the existing behavior of the architectures to
place this upper limits, it instead provides a way to have consistent
behavior across all architectures.

> > 
> > ---
> > riscv made this feature of mmap returning addresses less than the hint
> > address the default behavior. This was in contrast to the implementation
> > of x86/arm64 that have a single boundary at the 5-level page table
> > region. However this restriction proved too great -- the reduced
> > address space when using a hint address was too small.
> 
> Yes, the hint is used to group things close together so it would
> literally be random chance on if you have enough room or not (aslr and
> all).
> 
> > 
> > A patch for riscv [1] reverts the behavior that broke userspace. This
> > series serves to make this feature available to all architectures.
> 
> I don't fully understand this statement, you say it broke userspace so
> now you are porting it to everyone?  This reads as if you are braking
> the userspace on all architectures :)

It was the default for mmap on riscv. The difference here is that it is now
enabled by a flag instead. Instead of making the flag specific to riscv,
I figured that other architectures might find it useful as well.

> 
> If you fail to find room below, then your application fails as there is
> no way to get the upper bits you need.  It would be better to fix this
> in userspace - if your application is returned too high an address, then
> free it and exit because it's going to fail anyways.
> 

This flag is trying to define an API that is more robust than the
current behavior on that x86 and arm64 which implicitly restricts mmap()
addresses to 48 bits. A solution could be to just write in the docs that
mmap() will always exhaust all addresses below the hint address before
returning an address that is above the hint address. However a flag that
defines this behavior seems more intuitive.

> > 
> > I have only tested on riscv and x86.
> 
> This should be an RFC then.

Fair enough.

> 
> > There is a tremendous amount of
> > duplicated code in mmap so the implementations across architectures I
> > believe should be mostly consistent. I added this feature to all
> > architectures that implement either
> > arch_get_mmap_end()/arch_get_mmap_base() or
> > arch_get_unmapped_area_topdown()/arch_get_unmapped_area(). I also added
> > it to the default behavior for arch_get_mmap_end()/arch_get_mmap_base().
> 
> Way too much duplicate code.  We should be figuring out how to make this
> all work with the same code.
> 
> This is going to make the cloned code problem worse.

That would require standardizing every architecture with the generic
mmap() framework that arm64 has developed. That is far outside the scope
of this patch, but would be a great area to research for each of the
architectures that do not use the generic framework.

- Charlie

> 
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

