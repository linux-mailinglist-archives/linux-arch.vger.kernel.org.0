Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7CAE92290
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2019 13:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfHSLh3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Aug 2019 07:37:29 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:37881 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbfHSLh3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Aug 2019 07:37:29 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46BsNL3FQnz9txwK;
        Mon, 19 Aug 2019 13:37:22 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=IHsOl9a7; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id oFKXEToytF74; Mon, 19 Aug 2019 13:37:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46BsNL28mZz9txwM;
        Mon, 19 Aug 2019 13:37:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1566214642; bh=DGGXu4mqnMWHUmNbB5+ROy/HiaG54r+RC+Wcdt0Sf00=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IHsOl9a7CLa7RJmKZxXfhR0/DCYj2G73xIPYDA6WCxKuP54N2JAhOGPed5LoWBaTr
         xAGb92GOotvNXFzQSfGDwudvtj5Y3U/knm/8qpTZDycL0cX/rB8DbMAYW9xfoAPIEv
         zTjXzmGw+t910F9DYOhcG4BB3avOkYfcesFTWTsI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9E5778B7B3;
        Mon, 19 Aug 2019 13:37:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id equtsE-UlxDy; Mon, 19 Aug 2019 13:37:27 +0200 (CEST)
Received: from [172.25.230.101] (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 585EE8B7B1;
        Mon, 19 Aug 2019 13:37:27 +0200 (CEST)
Subject: Re: [PATCH 2/2] powerpc: support KASAN instrumentation of bitops
To:     Daniel Axtens <dja@axtens.net>, linux-s390@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     kasan-dev@googlegroups.com, Nicholas Piggin <npiggin@gmail.com>
References: <20190819062814.5315-1-dja@axtens.net>
 <20190819062814.5315-2-dja@axtens.net>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <a1932e9e-3697-b8a0-c936-098b390b817f@c-s.fr>
Date:   Mon, 19 Aug 2019 13:37:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819062814.5315-2-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 19/08/2019 à 08:28, Daniel Axtens a écrit :
> In KASAN development I noticed that the powerpc-specific bitops
> were not being picked up by the KASAN test suite.

I'm not sure anybody cares about who noticed the problem. This sentence 
could be rephrased as:

The powerpc-specific bitops are not being picked up by the KASAN test suite.

> 
> Instrumentation is done via the bitops/instrumented-{atomic,lock}.h
> headers. They require that arch-specific versions of bitop functions
> are renamed to arch_*. Do this renaming.
> 
> For clear_bit_unlock_is_negative_byte, the current implementation
> uses the PG_waiters constant. This works because it's a preprocessor
> macro - so it's only actually evaluated in contexts where PG_waiters
> is defined. With instrumentation however, it becomes a static inline
> function, and all of a sudden we need the actual value of PG_waiters.
> Because of the order of header includes, it's not available and we
> fail to compile. Instead, manually specify that we care about bit 7.
> This is still correct: bit 7 is the bit that would mark a negative
> byte.
> 
> Cc: Nicholas Piggin <npiggin@gmail.com> # clear_bit_unlock_negative_byte
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

Note that this patch might be an opportunity to replace all the 
'__inline__' by the standard 'inline' keyword.

Some () alignment to be fixes as well, see checkpatch warnings/checks at 
https://openpower.xyz/job/snowpatch/job/snowpatch-linux-checkpatch/8601//artifact/linux/checkpatch.log

> ---
>   arch/powerpc/include/asm/bitops.h | 31 +++++++++++++++++++------------
>   1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
> index 603aed229af7..8615b2bc35fe 100644
> --- a/arch/powerpc/include/asm/bitops.h
> +++ b/arch/powerpc/include/asm/bitops.h
> @@ -86,22 +86,22 @@ DEFINE_BITOP(clear_bits, andc, "")
>   DEFINE_BITOP(clear_bits_unlock, andc, PPC_RELEASE_BARRIER)
>   DEFINE_BITOP(change_bits, xor, "")
>   
> -static __inline__ void set_bit(int nr, volatile unsigned long *addr)
> +static __inline__ void arch_set_bit(int nr, volatile unsigned long *addr)
>   {
>   	set_bits(BIT_MASK(nr), addr + BIT_WORD(nr));
>   }
>   
> -static __inline__ void clear_bit(int nr, volatile unsigned long *addr)
> +static __inline__ void arch_clear_bit(int nr, volatile unsigned long *addr)
>   {
>   	clear_bits(BIT_MASK(nr), addr + BIT_WORD(nr));
>   }
>   
> -static __inline__ void clear_bit_unlock(int nr, volatile unsigned long *addr)
> +static __inline__ void arch_clear_bit_unlock(int nr, volatile unsigned long *addr)
>   {
>   	clear_bits_unlock(BIT_MASK(nr), addr + BIT_WORD(nr));
>   }
>   
> -static __inline__ void change_bit(int nr, volatile unsigned long *addr)
> +static __inline__ void arch_change_bit(int nr, volatile unsigned long *addr)
>   {
>   	change_bits(BIT_MASK(nr), addr + BIT_WORD(nr));
>   }
> @@ -138,26 +138,26 @@ DEFINE_TESTOP(test_and_clear_bits, andc, PPC_ATOMIC_ENTRY_BARRIER,
>   DEFINE_TESTOP(test_and_change_bits, xor, PPC_ATOMIC_ENTRY_BARRIER,
>   	      PPC_ATOMIC_EXIT_BARRIER, 0)
>   
> -static __inline__ int test_and_set_bit(unsigned long nr,
> +static __inline__ int arch_test_and_set_bit(unsigned long nr,
>   				       volatile unsigned long *addr)
>   {
>   	return test_and_set_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) != 0;
>   }
>   
> -static __inline__ int test_and_set_bit_lock(unsigned long nr,
> +static __inline__ int arch_test_and_set_bit_lock(unsigned long nr,
>   				       volatile unsigned long *addr)
>   {
>   	return test_and_set_bits_lock(BIT_MASK(nr),
>   				addr + BIT_WORD(nr)) != 0;
>   }
>   
> -static __inline__ int test_and_clear_bit(unsigned long nr,
> +static __inline__ int arch_test_and_clear_bit(unsigned long nr,
>   					 volatile unsigned long *addr)
>   {
>   	return test_and_clear_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) != 0;
>   }
>   
> -static __inline__ int test_and_change_bit(unsigned long nr,
> +static __inline__ int arch_test_and_change_bit(unsigned long nr,
>   					  volatile unsigned long *addr)
>   {
>   	return test_and_change_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) != 0;
> @@ -185,15 +185,18 @@ static __inline__ unsigned long clear_bit_unlock_return_word(int nr,
>   	return old;
>   }
>   
> -/* This is a special function for mm/filemap.c */
> -#define clear_bit_unlock_is_negative_byte(nr, addr)			\
> -	(clear_bit_unlock_return_word(nr, addr) & BIT_MASK(PG_waiters))
> +/*
> + * This is a special function for mm/filemap.c
> + * Bit 7 corresponds to PG_waiters.
> + */
> +#define arch_clear_bit_unlock_is_negative_byte(nr, addr)		\
> +	(clear_bit_unlock_return_word(nr, addr) & BIT_MASK(7))
>   
>   #endif /* CONFIG_PPC64 */
>   
>   #include <asm-generic/bitops/non-atomic.h>
>   
> -static __inline__ void __clear_bit_unlock(int nr, volatile unsigned long *addr)
> +static __inline__ void arch___clear_bit_unlock(int nr, volatile unsigned long *addr)
>   {
>   	__asm__ __volatile__(PPC_RELEASE_BARRIER "" ::: "memory");
>   	__clear_bit(nr, addr);
> @@ -239,6 +242,10 @@ unsigned long __arch_hweight64(__u64 w);
>   
>   #include <asm-generic/bitops/find.h>
>   
> +/* wrappers that deal with KASAN instrumentation */
> +#include <asm-generic/bitops/instrumented-atomic.h>
> +#include <asm-generic/bitops/instrumented-lock.h>
> +
>   /* Little-endian versions */
>   #include <asm-generic/bitops/le.h>
>   
> 
