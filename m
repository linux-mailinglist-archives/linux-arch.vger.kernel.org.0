Return-Path: <linux-arch+bounces-7095-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F278396EA00
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 08:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 136991C2206C
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 06:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA8113D891;
	Fri,  6 Sep 2024 06:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="UVBmSkVr"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB1313D243;
	Fri,  6 Sep 2024 06:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725603611; cv=none; b=oBQvoLBIM4018uWNcduzGAdTkfvWWZLLD4Vl3PkN/B1301Lg2HuOf349JgFo9w99IM+guTim0L6TJz6IfDuuOmCFA8yLs6yxbYWc384lEP6mDf0Sof+0hLi7T4rP9MyvUcuqqYe0XPJd6EV1ZPdeqiTTo/8mjTgibY0d7lJo5yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725603611; c=relaxed/simple;
	bh=UKaIpJynoawa1HVOQFmJU5QytarRlsA3CTyROeZKpxE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=piw3P2L6tjt290fl70pNdusbY+zSHnL0kea3t5c8wo9RIDyaL+D0u4zo+trDGJIfG1ityvTK6BoR331Sr37KFn+GYCWuitujUuGK7fuMiB7WqvJS5ZUladmaOF61B39yvQm+VPT1yimJeAlklJRgKdPQMH54a1+qKAlu045tnoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=UVBmSkVr; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Pf0qJBv2a5VO5pnFKJd+fG12gABSq0Jxz8dYrGBJaUk=; t=1725603607; x=1726208407; 
	b=UVBmSkVrUe+e4GwlrmpYBFL7XThM4/rH8ArwxC9ONYOQqEA5jNJSidPHlRmV4DrUDnGqZRnzrry
	dSx9rLqHQ1ffD8unKm5kK9jxsw5Hz92ahMhaJXep42l2lzZxx+zOl9Mt1b8gpaAS/J7ZhH+wNvF7D
	OrQ/Zi/ZV2uvnF4CqftIcFwctaeXeUzjFUFl3SrObKrLv5nBVIs0dstbmGehjZwrm8I1ja2+n5GMT
	rddZ9SeJLkERnJmtL7qQzMWUzOzBQCh9FKf44VQyZfXOOKinV19UxK7duwG2K5HxdMf1SGqmaCaSq
	wT4WHd2qmqtptSZq+Ty5J485YkBjTvVBgH7g==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1smSJT-00000003bKB-2zIl; Fri, 06 Sep 2024 08:19:19 +0200
Received: from dynamic-077-191-186-033.77.191.pool.telefonica.de ([77.191.186.33] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1smSJT-00000001qiA-1L1j; Fri, 06 Sep 2024 08:19:19 +0200
Message-ID: <f8e0faafbb56e8ab748cf14c314497501d375529.camel@physik.fu-berlin.de>
Subject: Re: [PATCH RFC v3 0/2] mm: Introduce ADDR_LIMIT_47BIT personality
 flag
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Charlie Jenkins <charlie@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>, 
 Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky
 <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta
 <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Guo Ren
 <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge
 Deller <deller@gmx.de>,  Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich
 Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Andreas
 Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Muchun Song <muchun.song@linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>, Christoph
 Hellwig <hch@infradead.org>, Michal Hocko <mhocko@suse.com>, "Kirill A.
 Shutemov" <kirill@shutemov.name>, Chris Torek <chris.torek@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org,  linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org,  linux-abi-devel@lists.sourceforge.net
Date: Fri, 06 Sep 2024 08:19:17 +0200
In-Reply-To: <20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com>
References: 
	<20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Charlie,

On Thu, 2024-09-05 at 14:15 -0700, Charlie Jenkins wrote:
> Some applications rely on placing data in free bits addresses allocated
> by mmap. Various architectures (eg. x86, arm64, powerpc) restrict the
> address returned by mmap to be less than the 48-bit address space,
> unless the hint address uses more than 47 bits (the 48th bit is reserved
> for the kernel address space).
>=20
> The riscv architecture needs a way to similarly restrict the virtual
> address space. On the riscv port of OpenJDK an error is thrown if
> attempted to run on the 57-bit address space, called sv57 [1].  golang
> has a comment that sv57 support is not complete, but there are some
> workarounds to get it to mostly work [2].
>=20
> These applications work on x86 because x86 does an implicit 47-bit
> restriction of mmap() address that contain a hint address that is less
> than 48 bits.
>=20
> Instead of implicitly restricting the address space on riscv (or any
> current/future architecture), provide a flag to the personality syscall
> that can be used to ensure an application works in any arbitrary VA
> space. A similar feature has already been implemented by the personality
> syscall in ADDR_LIMIT_32BIT.
>=20
> This flag will also allow seemless compatibility between all
> architectures, so applications like Go and OpenJDK that use bits in a
> virtual address can request the exact number of bits they need in a
> generic way. The flag can be checked inside of vm_unmapped_area() so
> that this flag does not have to be handled individually by each
> architecture.=20
>=20
> Link:
> https://github.com/openjdk/jdk/blob/f080b4bb8a75284db1b6037f8c00ef3b1ef1a=
dd1/src/hotspot/cpu/riscv/vm_version_riscv.cpp#L79
> [1]
> Link:
> https://github.com/golang/go/blob/9e8ea567c838574a0f14538c0bbbd83c3215aa5=
5/src/runtime/tagptr_64bit.go#L47
> [2]
>=20
> To: Arnd Bergmann <arnd@arndb.de>
> To: Richard Henderson <richard.henderson@linaro.org>
> To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> To: Matt Turner <mattst88@gmail.com>
> To: Vineet Gupta <vgupta@kernel.org>
> To: Russell King <linux@armlinux.org.uk>
> To: Guo Ren <guoren@kernel.org>
> To: Huacai Chen <chenhuacai@kernel.org>
> To: WANG Xuerui <kernel@xen0n.name>
> To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> To: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
> To: Helge Deller <deller@gmx.de>
> To: Michael Ellerman <mpe@ellerman.id.au>
> To: Nicholas Piggin <npiggin@gmail.com>
> To: Christophe Leroy <christophe.leroy@csgroup.eu>
> To: Naveen N Rao <naveen@kernel.org>
> To: Alexander Gordeev <agordeev@linux.ibm.com>
> To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> To: Heiko Carstens <hca@linux.ibm.com>
> To: Vasily Gorbik <gor@linux.ibm.com>
> To: Christian Borntraeger <borntraeger@linux.ibm.com>
> To: Sven Schnelle <svens@linux.ibm.com>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> To: David S. Miller <davem@davemloft.net>
> To: Andreas Larsson <andreas@gaisler.com>
> To: Thomas Gleixner <tglx@linutronix.de>
> To: Ingo Molnar <mingo@redhat.com>
> To: Borislav Petkov <bp@alien8.de>
> To: Dave Hansen <dave.hansen@linux.intel.com>
> To: x86@kernel.org
> To: H. Peter Anvin <hpa@zytor.com>
> To: Andy Lutomirski <luto@kernel.org>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Muchun Song <muchun.song@linux.dev>
> To: Andrew Morton <akpm@linux-foundation.org>
> To: Liam R. Howlett <Liam.Howlett@oracle.com>
> To: Vlastimil Babka <vbabka@suse.cz>
> To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> To: Shuah Khan <shuah@kernel.org>
> To: Christoph Hellwig <hch@infradead.org>
> To: Michal Hocko <mhocko@suse.com>
> To: "Kirill A. Shutemov" <kirill@shutemov.name>
> To: Chris Torek <chris.torek@gmail.com>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-csky@vger.kernel.org
> Cc: loongarch@lists.linux.dev
> Cc: linux-mips@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-abi-devel@lists.sourceforge.net
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>=20
> Changes in v2:
> - Added much greater detail to cover letter
> - Removed all code that touched architecture specific code and was able
>   to factor this out into all generic functions, except for flags that
>   needed to be added to vm_unmapped_area_info
> - Made this an RFC since I have only tested it on riscv and x86
> - Link to v1: https://lore.kernel.org/r/20240827-patches-below_hint_mmap-=
v1-0-46ff2eb9022d@rivosinc.com
>=20
> Changes in v3:
> - Use a personality flag instead of an mmap flag
> - Link to v2: https://lore.kernel.org/r/20240829-patches-below_hint_mmap-=
v2-0-638a28d9eae0@rivosinc.com
>=20
> ---
> Charlie Jenkins (2):
>       mm: Add personality flag to limit address to 47 bits
>       selftests/mm: Create ADDR_LIMIT_47BIT test
>=20
>  include/uapi/linux/personality.h                   |  1 +
>  mm/mmap.c                                          |  3 ++
>  tools/testing/selftests/mm/.gitignore              |  1 +
>  tools/testing/selftests/mm/Makefile                |  1 +
>  tools/testing/selftests/mm/map_47bit_personality.c | 34 ++++++++++++++++=
++++++
>  5 files changed, 40 insertions(+)
> ---
> base-commit: 5be63fc19fcaa4c236b307420483578a56986a37
> change-id: 20240827-patches-below_hint_mmap-b13d79ae1c55

Wow, this issue has been plaguing SPARC users for years already as the arch=
itecture
uses a 52-bit virtual address space and Javascript engines such as the one =
in Firefox
or Webkit have been crashing ever since.

I should definitely give this series a try and see if that fixes Javascript=
 crashes
on SPARC.

Thanks a lot for addressing this nasty long-standing problem!

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

