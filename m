Return-Path: <linux-arch+bounces-6796-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A90A963E53
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 10:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3E61C21E86
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 08:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9504918C027;
	Thu, 29 Aug 2024 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ifdmLA2Z"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D6D18C025;
	Thu, 29 Aug 2024 08:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920019; cv=none; b=sIN7aB7N/arSSPmoFo0ZlJr3V+89Uw0Z83RheyuC9D4prVU0XVgq0Yj8oDvImwcHQmAZseIYOa/ah6KmlBmVIaoDU7e/vttdq29dOEdF2AyaXEK7WOtXzAoYGVz2JevY90UVByYAC+AkUQpLb4mBpXuM9E/dRMOwoLpPQ9KR4iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920019; c=relaxed/simple;
	bh=FDBLvL3b/XCdjS0adlnE6hBgdXNcogXnYATjW3mX3Gs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RXkRZdyYMOjbke8cuQYGYkIPG/HW4gk0bDFGtVA1sYoDX6gt/aFtC3PjFT0Z+9dHddJpk/jsfGbfGdLLhj30tI4Q0VoDRbx2cSplJ1wBbrtTMp2NfwAeQyqYdL8E945oIURTagh+HjWg6wkm56J9VTQhqs88z5OMfStWoR+3fRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=ifdmLA2Z; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1724920014;
	bh=CzX6lvuIolyjXVJmi/cVG/X6CAC23HjxHju8uHsztN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ifdmLA2ZirGiQQ8DKH6A6ZHgCMR1ss7zyDFp3CptPsdwMvp/3YGG5gBHGQUEUKUzg
	 ITO14BjJMTtMSVhv+OWGvxvVRuqV/uDr1qMTHrjCXpCA4AhG+fXdppjYRKj1SYalDA
	 c5OEvTytT2HGK7FuARoCOz0vu+NPkuwhztoGR1vEusip5cUw9u2oaNaTthykDEP4om
	 aG2SxS1UuJhaWBae0UnoEaKnIcych9qgh1+wLPD/3IrbnzUQZgDwgKUPmcIv0mATKK
	 PtmYiyKLMkmTsA/rAyMlTUsbJAoexgEIiM3ollUIPnJsv6rs7t3Jl4HY46paJVrakT
	 7gCuXwLBau9iw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WvZBV0vd6z4wd6;
	Thu, 29 Aug 2024 18:26:42 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Charlie Jenkins <charlie@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>,
 Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky
 <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta
 <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Guo Ren
 <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge
 Deller <deller@gmx.de>, Nicholas Piggin <npiggin@gmail.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [PATCH RFC v2 1/4] mm: Add MAP_BELOW_HINT
In-Reply-To: <20240829-patches-below_hint_mmap-v2-1-638a28d9eae0@rivosinc.com>
References: <20240829-patches-below_hint_mmap-v2-0-638a28d9eae0@rivosinc.com>
 <20240829-patches-below_hint_mmap-v2-1-638a28d9eae0@rivosinc.com>
Date: Thu, 29 Aug 2024 18:26:41 +1000
Message-ID: <87mskvenum.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Charlie Jenkins <charlie@rivosinc.com> writes:
> Some applications rely on placing data in free bits addresses allocated
> by mmap. Various architectures (eg. x86, arm64, powerpc) restrict the
> address returned by mmap to be less than the 48-bit address space,
> unless the hint address uses more than 47 bits (the 48th bit is reserved
> for the kernel address space).
>
> To make this behavior explicit and more versatile across all
> architectures, define a mmap flag that allows users to define an
> arbitrary upper limit on addresses returned by mmap.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  include/uapi/asm-generic/mman-common.h       | 1 +
>  tools/include/uapi/asm-generic/mman-common.h | 1 +
  
You're not meant to update the headers in tools/ directly. There's a
mail somewhere from acme somewhere describing the proper process, but
the tldr is leave it up to him.

> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index 6ce1f1ceb432..03ac13d9aa37 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -32,6 +32,7 @@
>  
>  #define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
>  					 * uninitialized */
> +#define MAP_BELOW_HINT	  0x8000000	/* give out address that is below (inclusive) hint address */

IMHO the API would be clearer if this actually forced the address to be
below the hint. That's what the flag name implies after all.

It would also mean the application doesn't need to take into account the
length of the mapping when passing the hint.

cheers

