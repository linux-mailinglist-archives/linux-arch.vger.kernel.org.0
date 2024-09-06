Return-Path: <linux-arch+bounces-7094-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E8396E9B8
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 08:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 285711C233B7
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 06:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C9813D8B5;
	Fri,  6 Sep 2024 06:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMW64gLm"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD1513D8B0;
	Fri,  6 Sep 2024 06:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725602934; cv=none; b=fWR2aUtJ4gQ8QMgnnP1W7Jhak1m+xOncKhlzlRfZQnQqzD1cyzKdAw3Lu77sgawas1HuA4QnfDthoFLBiuASK2byQKJ5S6X17pJ5GJfMFVpycayC2B0O4TeL7OeEcJLFdxv9/2B4TBXlifPG8rtIyorKgvv3LkLrWFHNDc2iCSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725602934; c=relaxed/simple;
	bh=imDUvx1Hii43SnkhK8GwTQs26eTyhJYRfhTDRAtZziQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n24zZP1eVQtTKpukt3kLfqiBUglWkPdqzmphBORnhBRihSvJ3n95J8+pk2JK361kDQ5MHNg0JyICmQVvw59Ifio1mPxLAPiOWtYUaAuS6d4mHzT25L45zSWvvs/ydYkFHt4wcny0iridBJ/u9HXeoPBEYBSk8fL+fYDF5ndGDEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMW64gLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D85FC4CEC6;
	Fri,  6 Sep 2024 06:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725602934;
	bh=imDUvx1Hii43SnkhK8GwTQs26eTyhJYRfhTDRAtZziQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mMW64gLmWYwNHxfzlvaoGMBLGF0ueWOxcjrWhSUrtIlP4vdUd7xae5JPy3JKqIExz
	 HFuiZx6oWJmovq63/cl+v1ZU19PDWFCuqMas6d7gV33rwhbsIjf/6jKgtDJi0CjkaM
	 nAyscQokSqYPIUNn+/TkhSXvtu24dJ3kiLF2CEDvIPyPBbHH7uk6zFOptSZYge3L0P
	 rhjznSkw4UEu9OgtKgG+WNoivArvnTJTCqu9mRUL1aD6wfECi7osbo4z5PCvKLIQRB
	 x3CsUjPvuNXAShUQV2Y5AaW8FjjBy+AWygG7+uu3f9QIpIxTL3VXFknAtoxQuKUuS7
	 CI+n8mob5I75g==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso233312466b.0;
        Thu, 05 Sep 2024 23:08:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDgR3GRppSdbJjs+uKQ9oTDjio5HDJjOI18GXnKDePyz/9+XnM7LWrKG7j3x08X0Yw4wgPjqM5Ega1bg==@vger.kernel.org, AJvYcCUqtYx/pve+NqgSLXShAxWwVEJG1X9Pdpi5bsIrZ2PaQOUuQLx031LsPdRCXiMalKypXl/QFeuOg9rTwN2TB6D+@vger.kernel.org, AJvYcCUtQ9PjntkEcxFoqp9Nhm1CPMjgbCnAmAJ/5dHVr7L1HY9Qbgt+pN16XagDYmhXJKFu+hjR7PJEhwFE1w==@vger.kernel.org, AJvYcCVwNeY9ebRFfOWi5Q8YU62dhedZyINEuhwK2rEayO59u8IlHVBOU8a4PTd71VawAqtOk8I+WJ03rFk1lg==@vger.kernel.org, AJvYcCWFqKV8Wre7shfr0R06AIviydlRs++ZgAKt71D7QF6mefrAB1Ksw0LCUT9DjMW5/DFCxCnfcY6k1ZOrnQoU@vger.kernel.org, AJvYcCX5OiAzg3p6RoGEryRjXIJYcUlUhuNXtwAV6MjR45sIdtsWwNgikzvgmhIMI43eEvywMcA5B7V8f7hn4w==@vger.kernel.org, AJvYcCXfd7RhpReORy7t5sXlwwEx34pthEyEOJevaZ2uHO0uyvCJkJ9gfUUU+BM/4Np9bbTMUdmOFqIl9sFo0Q==@vger.kernel.org, AJvYcCXh3x+WkGnFEOM/62v9L1hjfY2xhWsOz0QFeH2SoDewReazut/6RUgvyCXMSB5GkB0ilEiohZMXf8XozPnI@vger.kernel.org, AJvYcCXnAoGbQpUB8xaeLf7IAyAQSgCq2T68hZw6oEJJ/6vVyduItsryWAq8GDqWKULkCZyb/rmQ7Qb7RG8=@vger.kernel.org, AJvYcCXnGhGlrhma
 ckUXfRwIKpzrT19FldLHG/7ihRU6+f9IR2xQzw0l8mnGX19oYD17RF9Rw/veQ6jTqc10wQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMkoFhYnW22YuGqVNZciiY/g8e9Mt9GifmmwbRbS3juo8XOYm+
	hJpzx28+megWdz4ksE6KULvwkyr0exvIxFQW0ZLpT4G+qviSzZeLBpPtXhEb3pprmqJbDNm2znO
	QNVQEvuwAQLfyMAhdvWXbc3DSnks=
X-Google-Smtp-Source: AGHT+IHmDTwta2M/ptJ8I+HJGlz0i22zQ861L/VtKZzzihvpyO7sN1xzTAGALtM9rjMcOlsIyxzfNUzFUkdZe9E/qYg=
X-Received: by 2002:a17:907:7d94:b0:a86:beb2:1d6d with SMTP id
 a640c23a62f3a-a8a431c7214mr876305366b.26.1725602932791; Thu, 05 Sep 2024
 23:08:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com>
In-Reply-To: <20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 6 Sep 2024 14:08:40 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS4=8dMypnWe2dpuQfdfV3+XLq5fZeGbJWZPDN_ypfuvQ@mail.gmail.com>
Message-ID: <CAJF2gTS4=8dMypnWe2dpuQfdfV3+XLq5fZeGbJWZPDN_ypfuvQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 0/2] mm: Introduce ADDR_LIMIT_47BIT personality flag
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	"Kirill A. Shutemov" <kirill@shutemov.name>, Chris Torek <chris.torek@gmail.com>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-abi-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 5:16=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.co=
m> wrote:
>
> Some applications rely on placing data in free bits addresses allocated
> by mmap. Various architectures (eg. x86, arm64, powerpc) restrict the
> address returned by mmap to be less than the 48-bit address space,
> unless the hint address uses more than 47 bits (the 48th bit is reserved
> for the kernel address space).
>
> The riscv architecture needs a way to similarly restrict the virtual
> address space. On the riscv port of OpenJDK an error is thrown if
> attempted to run on the 57-bit address space, called sv57 [1].  golang
> has a comment that sv57 support is not complete, but there are some
> workarounds to get it to mostly work [2].
>
> These applications work on x86 because x86 does an implicit 47-bit
> restriction of mmap() address that contain a hint address that is less
> than 48 bits.
>
> Instead of implicitly restricting the address space on riscv (or any
> current/future architecture), provide a flag to the personality syscall
> that can be used to ensure an application works in any arbitrary VA
> space. A similar feature has already been implemented by the personality
> syscall in ADDR_LIMIT_32BIT.
>
> This flag will also allow seemless compatibility between all
> architectures, so applications like Go and OpenJDK that use bits in a
> virtual address can request the exact number of bits they need in a
> generic way. The flag can be checked inside of vm_unmapped_area() so
> that this flag does not have to be handled individually by each
> architecture.
Acked-by: Guo Ren <guoren@kernel.org>

Sv57's pain finds its cure in this antidote.

>
> Link:
> https://github.com/openjdk/jdk/blob/f080b4bb8a75284db1b6037f8c00ef3b1ef1a=
dd1/src/hotspot/cpu/riscv/vm_version_riscv.cpp#L79
> [1]
> Link:
> https://github.com/golang/go/blob/9e8ea567c838574a0f14538c0bbbd83c3215aa5=
5/src/runtime/tagptr_64bit.go#L47
> [2]
>
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
>
> Changes in v2:
> - Added much greater detail to cover letter
> - Removed all code that touched architecture specific code and was able
>   to factor this out into all generic functions, except for flags that
>   needed to be added to vm_unmapped_area_info
> - Made this an RFC since I have only tested it on riscv and x86
> - Link to v1: https://lore.kernel.org/r/20240827-patches-below_hint_mmap-=
v1-0-46ff2eb9022d@rivosinc.com
>
> Changes in v3:
> - Use a personality flag instead of an mmap flag
> - Link to v2: https://lore.kernel.org/r/20240829-patches-below_hint_mmap-=
v2-0-638a28d9eae0@rivosinc.com
>
> ---
> Charlie Jenkins (2):
>       mm: Add personality flag to limit address to 47 bits
>       selftests/mm: Create ADDR_LIMIT_47BIT test
>
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
> --
> - Charlie
>


--=20
Best Regards
 Guo Ren

