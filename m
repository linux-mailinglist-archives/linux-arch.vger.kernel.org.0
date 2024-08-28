Return-Path: <linux-arch+bounces-6702-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEE7961FDB
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 08:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F71A1F235B6
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 06:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100D3156230;
	Wed, 28 Aug 2024 06:34:59 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B9D13210D;
	Wed, 28 Aug 2024 06:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724826899; cv=none; b=GxShJE0DlYwNLtwmFodxP4HSxE+3RTibgg2l2NtlFaHuNI7TX76LRk1OLQsxeOuyEQQ/Tq+NBXa7yNzOJQEOe14QXeXrZBkPKxnxHYlnvGS91IS/aL2w/29A7629Lq0zx2G+NWWPiu3vqgzBZntz2azuY8c8FoiFc4rn7swH08E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724826899; c=relaxed/simple;
	bh=aWGAxpMZHWrJ/BUyhvBfXZeExfTSMuVVk0d9vk2wP/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ADFHgNZFK9yvNiLr7CqHjh65k0u00I7bX5+0MLQ3kgYXkjGu8CNr86RXS3B69R+ECbcEf9yoAn79JzJhvExL70RjRIZbqF6BEnLvBLdKQ5pcpQ+2wNbvGpXUe57S+YDz5Q7fR3bI1Bf5x1Zzyt8FQ+N/2JByum13B1D86c+UCt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wtvlv5gSRz9sRs;
	Wed, 28 Aug 2024 08:34:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6jPb3ZkzpTtP; Wed, 28 Aug 2024 08:34:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wtvlt44Xsz9sRy;
	Wed, 28 Aug 2024 08:34:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 72A688B77E;
	Wed, 28 Aug 2024 08:34:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id vzIG7P3XR8ze; Wed, 28 Aug 2024 08:34:50 +0200 (CEST)
Received: from [172.25.230.108] (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C02CD8B764;
	Wed, 28 Aug 2024 08:34:49 +0200 (CEST)
Message-ID: <a43c52c6-c1ac-4ef3-b511-08f0459bddad@csgroup.eu>
Date: Wed, 28 Aug 2024 08:34:49 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] powerpc: mm: Support MAP_BELOW_HINT
To: Charlie Jenkins <charlie@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Russell King <linux@armlinux.org.uk>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Shuah Khan <shuah@kernel.org>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
 <20240827-patches-below_hint_mmap-v1-7-46ff2eb9022d@rivosinc.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240827-patches-below_hint_mmap-v1-7-46ff2eb9022d@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Charlie,

Le 28/08/2024 à 07:49, Charlie Jenkins a écrit :
> Add support for MAP_BELOW_HINT to arch_get_mmap_base() and
> arch_get_mmap_end().
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>   arch/powerpc/include/asm/task_size_64.h | 36 +++++++++++++++++++++++++++------
>   1 file changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/task_size_64.h b/arch/powerpc/include/asm/task_size_64.h
> index 239b363841aa..a37a5a81365d 100644
> --- a/arch/powerpc/include/asm/task_size_64.h
> +++ b/arch/powerpc/include/asm/task_size_64.h
> @@ -72,12 +72,36 @@
>   #define STACK_TOP_MAX TASK_SIZE_USER64
>   #define STACK_TOP (is_32bit_task() ? STACK_TOP_USER32 : STACK_TOP_USER64)
>   
> -#define arch_get_mmap_base(addr, len, base, flags) \
> -	(((addr) > DEFAULT_MAP_WINDOW) ? (base) + TASK_SIZE - DEFAULT_MAP_WINDOW : (base))
> +#define arch_get_mmap_base(addr, len, base, flags)					\

This macro looks quite big for a macro, can it be a static inline 
function instead ? Same for the other macro below.

> +({											\
> +	unsigned long mmap_base;							\
> +	typeof(flags) _flags = (flags);							\
> +	typeof(addr) _addr = (addr);							\
> +	typeof(base) _base = (base);							\
> +	typeof(len) _len = (len);							\
> +	unsigned long rnd_gap = DEFAULT_MAP_WINDOW - (_base);				\
> +	if (_flags & MAP_BELOW_HINT && _addr != 0 && ((_addr + _len) > BIT(VA_BITS - 1)))\
> +		mmap_base = (_addr + _len) - rnd_gap;					\
> +	else										\
> +		mmap_end = ((_addr > DEFAULT_MAP_WINDOW) ?				\
> +				_base + TASK_SIZE - DEFAULT_MAP_WINDOW :		\
> +				_base);							\
> +	mmap_end;									\

mmap_end doesn't exist, did you mean mmap_base ?

> +})
>   
> -#define arch_get_mmap_end(addr, len, flags) \
> -	(((addr) > DEFAULT_MAP_WINDOW) || \
> -	 (((flags) & MAP_FIXED) && ((addr) + (len) > DEFAULT_MAP_WINDOW)) ? TASK_SIZE : \
> -									    DEFAULT_MAP_WINDOW)
> +#define arch_get_mmap_end(addr, len, flags)							\
> +({												\
> +	unsigned long mmap_end;									\
> +	typeof(flags) _flags = (flags);								\
> +	typeof(addr) _addr = (addr);								\
> +	typeof(len) _len = (len);								\
> +	if (_flags & MAP_BELOW_HINT && _addr != 0 && ((_addr + _len) > BIT(VA_BITS - 1)))	\
> +		mmap_end = (_addr + _len);							\
> +	else											\
> +		mmap_end = (((_addr) > DEFAULT_MAP_WINDOW) ||					\
> +				(((_flags) & MAP_FIXED) && ((_addr) + (_len) > DEFAULT_MAP_WINDOW))\
> +				? TASK_SIZE : DEFAULT_MAP_WINDOW)				\
> +	mmap_end;										\
> +})
>   
>   #endif /* _ASM_POWERPC_TASK_SIZE_64_H */
> 

