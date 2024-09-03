Return-Path: <linux-arch+bounces-6966-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5061A96A54E
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 19:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0942B2859CF
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 17:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF1B18DF77;
	Tue,  3 Sep 2024 17:18:37 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191E51420DD;
	Tue,  3 Sep 2024 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725383917; cv=none; b=q85UdUcYglCvJ1EiQaBXdE4juMKTXCUABEZzVNrxs1J/sT5PsOrGLxX3GxF7LOryIvGHqzGTSosI3bax96v7zxrSzox+SoJu0mqGdHiAzPzW0fVL9LHUOUxHwd1m/evW8gxlJSXo0wddTMQ7iiTWKHwjzCtprqbkqF8CMnoIXKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725383917; c=relaxed/simple;
	bh=rAT/16lEXiR/FQGCf8mH61WrxLJvKpfnUCw3JXbOKlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMYZvRwPzKbHvQjy+LnWLJRw7iHRHbfsE5FzHqr9nQsWPh1U6xRR1yoeeI/3q4uyx3Hua+1CdN5JNDqVSewh5TbiqTgXWzIAC4Ke4bK9goeW2rxnvPQOqpFw50ctPwt/5ER6bui/RRLjIGlStf2NoV4yn2enL9hmm63EBN1Qn4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wyslp6shpz9sSC;
	Tue,  3 Sep 2024 19:18:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hEi4N-oS1BVW; Tue,  3 Sep 2024 19:18:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wysln4fbCz9sSH;
	Tue,  3 Sep 2024 19:18:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7E91E8B779;
	Tue,  3 Sep 2024 19:18:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id pxEcRzUEidZI; Tue,  3 Sep 2024 19:18:29 +0200 (CEST)
Received: from [192.168.234.228] (unknown [192.168.234.228])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3CEB98B774;
	Tue,  3 Sep 2024 19:18:27 +0200 (CEST)
Message-ID: <6b07c48d-656f-4e42-bfa7-0ecead72a7b8@csgroup.eu>
Date: Tue, 3 Sep 2024 19:18:26 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 2/4] mm: Add hint and mmap_flags to struct
 vm_unmapped_area_info
To: Charlie Jenkins <charlie@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
References: <20240829-patches-below_hint_mmap-v2-0-638a28d9eae0@rivosinc.com>
 <20240829-patches-below_hint_mmap-v2-2-638a28d9eae0@rivosinc.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240829-patches-below_hint_mmap-v2-2-638a28d9eae0@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Charlie,

Le 29/08/2024 à 09:15, Charlie Jenkins a écrit :
> The hint address and mmap_flags are necessary to determine if
> MAP_BELOW_HINT requirements are satisfied.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>   arch/alpha/kernel/osf_sys.c      | 2 ++
>   arch/arc/mm/mmap.c               | 3 +++
>   arch/arm/mm/mmap.c               | 7 +++++++
>   arch/csky/abiv1/mmap.c           | 3 +++
>   arch/loongarch/mm/mmap.c         | 3 +++
>   arch/mips/mm/mmap.c              | 3 +++
>   arch/parisc/kernel/sys_parisc.c  | 3 +++
>   arch/powerpc/mm/book3s64/slice.c | 7 +++++++
>   arch/s390/mm/hugetlbpage.c       | 4 ++++
>   arch/s390/mm/mmap.c              | 6 ++++++
>   arch/sh/mm/mmap.c                | 6 ++++++
>   arch/sparc/kernel/sys_sparc_32.c | 3 +++
>   arch/sparc/kernel/sys_sparc_64.c | 6 ++++++
>   arch/sparc/mm/hugetlbpage.c      | 4 ++++
>   arch/x86/kernel/sys_x86_64.c     | 6 ++++++
>   arch/x86/mm/hugetlbpage.c        | 4 ++++
>   fs/hugetlbfs/inode.c             | 4 ++++
>   include/linux/mm.h               | 2 ++
>   mm/mmap.c                        | 6 ++++++
>   19 files changed, 82 insertions(+)
> 

>   
> diff --git a/arch/powerpc/mm/book3s64/slice.c b/arch/powerpc/mm/book3s64/slice.c
> index ef3ce37f1bb3..f0e2550af6d0 100644
> --- a/arch/powerpc/mm/book3s64/slice.c
> +++ b/arch/powerpc/mm/book3s64/slice.c
> @@ -286,6 +286,10 @@ static unsigned long slice_find_area_bottomup(struct mm_struct *mm,
>   		.length = len,
>   		.align_mask = PAGE_MASK & ((1ul << pshift) - 1),
>   	};
> +
> +	info.hint = addr;
> +	info.mmap_flags = flags;
> +
>   	/*
>   	 * Check till the allow max value for this mmap request
>   	 */
> @@ -331,6 +335,9 @@ static unsigned long slice_find_area_topdown(struct mm_struct *mm,
>   	};
>   	unsigned long min_addr = max(PAGE_SIZE, mmap_min_addr);
>   
> +	info.hint = addr;
> +	info.mmap_flags = flags;
> +
>   	/*
>   	 * If we are trying to allocate above DEFAULT_MAP_WINDOW
>   	 * Add the different to the mmap_base.

ppc64_defconfig:

   CC      arch/powerpc/mm/book3s64/slice.o
arch/powerpc/mm/book3s64/slice.c: In function 'slice_find_area_bottomup':
arch/powerpc/mm/book3s64/slice.c:291:27: error: 'flags' undeclared 
(first use in this function)
   291 |         info.mmap_flags = flags;
       |                           ^~~~~
arch/powerpc/mm/book3s64/slice.c:291:27: note: each undeclared 
identifier is reported only once for each function it appears in
arch/powerpc/mm/book3s64/slice.c: In function 'slice_find_area_topdown':
arch/powerpc/mm/book3s64/slice.c:339:27: error: 'flags' undeclared 
(first use in this function)
   339 |         info.mmap_flags = flags;
       |                           ^~~~~
make[5]: *** [scripts/Makefile.build:244: 
arch/powerpc/mm/book3s64/slice.o] Error 1

