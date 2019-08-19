Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02BD5921E3
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2019 13:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfHSLOB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Aug 2019 07:14:01 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:58343 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbfHSLOB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Aug 2019 07:14:01 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46BrsD6rhDz9v0Tw;
        Mon, 19 Aug 2019 13:13:52 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=ramJ5RU9; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id iYxzepr8e_KW; Mon, 19 Aug 2019 13:13:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46BrsD5jwmz9v0Tv;
        Mon, 19 Aug 2019 13:13:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1566213232; bh=Qa36/ZV23YLoxH5dypntYvzfFhXm/LNaj9kJFgYe0Og=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ramJ5RU99VFVPBDpX5N9JJWY0oyN/onw1jrjfCKhvg15yq8SYilExOvm9u1e0XwjU
         J1j8lUduEIw/an3GIYpwaQdz7qzfeyUBNpk7ap7nevhBNzLZnNrnFJLi8sDVpP81ms
         PDiyU35r7mwD34Io0WrjSn7ojybFhWgesZyV1M3o=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 218458B7B1;
        Mon, 19 Aug 2019 13:13:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xonJeIpIn123; Mon, 19 Aug 2019 13:13:58 +0200 (CEST)
Received: from [172.25.230.101] (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DD5F48B778;
        Mon, 19 Aug 2019 13:13:57 +0200 (CEST)
Subject: Re: [PATCH 1/2] kasan: support instrumented bitops combined with
 generic bitops
To:     Daniel Axtens <dja@axtens.net>, linux-s390@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     kasan-dev@googlegroups.com
References: <20190819062814.5315-1-dja@axtens.net>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <c3231cb1-a705-579e-cb27-183320f708af@c-s.fr>
Date:   Mon, 19 Aug 2019 13:13:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819062814.5315-1-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 19/08/2019 à 08:28, Daniel Axtens a écrit :
> Currently bitops-instrumented.h assumes that the architecture provides
> atomic, non-atomic and locking bitops (e.g. both set_bit and __set_bit).
> This is true on x86 and s390, but is not always true: there is a
> generic bitops/non-atomic.h header that provides generic non-atomic
> operations, and also a generic bitops/lock.h for locking operations.
> 
> powerpc uses the generic non-atomic version, so it does not have it's
> own e.g. __set_bit that could be renamed arch___set_bit.
> 
> Split up bitops-instrumented.h to mirror the atomic/non-atomic/lock
> split. This allows arches to only include the headers where they
> have arch-specific versions to rename. Update x86 and s390.
> 
> (The generic operations are automatically instrumented because they're
> written in C, not asm.)
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   Documentation/core-api/kernel-api.rst         |  17 +-
>   arch/s390/include/asm/bitops.h                |   4 +-
>   arch/x86/include/asm/bitops.h                 |   4 +-
>   include/asm-generic/bitops-instrumented.h     | 263 ------------------
>   .../asm-generic/bitops/instrumented-atomic.h  | 100 +++++++
>   .../asm-generic/bitops/instrumented-lock.h    |  81 ++++++
>   .../bitops/instrumented-non-atomic.h          | 114 ++++++++
>   7 files changed, 317 insertions(+), 266 deletions(-)
>   delete mode 100644 include/asm-generic/bitops-instrumented.h
>   create mode 100644 include/asm-generic/bitops/instrumented-atomic.h
>   create mode 100644 include/asm-generic/bitops/instrumented-lock.h
>   create mode 100644 include/asm-generic/bitops/instrumented-non-atomic.h
> 
> diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
> index 08af5caf036d..2e21248277e3 100644
> --- a/Documentation/core-api/kernel-api.rst
> +++ b/Documentation/core-api/kernel-api.rst
> @@ -54,7 +54,22 @@ The Linux kernel provides more basic utility functions.
>   Bit Operations
>   --------------
>   
> -.. kernel-doc:: include/asm-generic/bitops-instrumented.h
> +Atomic Operations
> +~~~~~~~~~~~~~~~~~
> +
> +.. kernel-doc:: include/asm-generic/bitops/instrumented-atomic.h
> +   :internal:
> +
> +Non-atomic Operations
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +.. kernel-doc:: include/asm-generic/bitops/instrumented-non-atomic.h
> +   :internal:
> +
> +Locking Operations
> +~~~~~~~~~~~~~~~~~~
> +
> +.. kernel-doc:: include/asm-generic/bitops/instrumented-lock.h
>      :internal:
>   
>   Bitmap Operations
> diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
> index b8833ac983fa..0ceb12593a68 100644
> --- a/arch/s390/include/asm/bitops.h
> +++ b/arch/s390/include/asm/bitops.h
> @@ -241,7 +241,9 @@ static inline void arch___clear_bit_unlock(unsigned long nr,
>   	arch___clear_bit(nr, ptr);
>   }
>   
> -#include <asm-generic/bitops-instrumented.h>
> +#include <asm-generic/bitops/instrumented-atomic.h>
> +#include <asm-generic/bitops/instrumented-non-atomic.h>
> +#include <asm-generic/bitops/instrumented-lock.h>
>   
>   /*
>    * Functions which use MSB0 bit numbering.
> diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
> index ba15d53c1ca7..4a2e2432238f 100644
> --- a/arch/x86/include/asm/bitops.h
> +++ b/arch/x86/include/asm/bitops.h
> @@ -389,7 +389,9 @@ static __always_inline int fls64(__u64 x)
>   
>   #include <asm-generic/bitops/const_hweight.h>
>   
> -#include <asm-generic/bitops-instrumented.h>
> +#include <asm-generic/bitops/instrumented-atomic.h>
> +#include <asm-generic/bitops/instrumented-non-atomic.h>
> +#include <asm-generic/bitops/instrumented-lock.h>
>   
>   #include <asm-generic/bitops/le.h>
>   
> diff --git a/include/asm-generic/bitops-instrumented.h b/include/asm-generic/bitops-instrumented.h
> deleted file mode 100644
> index ddd1c6d9d8db..000000000000
> --- a/include/asm-generic/bitops-instrumented.h
> +++ /dev/null
> @@ -1,263 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -
> -/*
> - * This file provides wrappers with sanitizer instrumentation for bit
> - * operations.
> - *
> - * To use this functionality, an arch's bitops.h file needs to define each of
> - * the below bit operations with an arch_ prefix (e.g. arch_set_bit(),
> - * arch___set_bit(), etc.).
> - */
> -#ifndef _ASM_GENERIC_BITOPS_INSTRUMENTED_H
> -#define _ASM_GENERIC_BITOPS_INSTRUMENTED_H
> -
> -#include <linux/kasan-checks.h>
> -
> -/**
> - * set_bit - Atomically set a bit in memory
> - * @nr: the bit to set
> - * @addr: the address to start counting from
> - *
> - * This is a relaxed atomic operation (no implied memory barriers).
> - *
> - * Note that @nr may be almost arbitrarily large; this function is not
> - * restricted to acting on a single-word quantity.
> - */
> -static inline void set_bit(long nr, volatile unsigned long *addr)
> -{
> -	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> -	arch_set_bit(nr, addr);
> -}
> -
> -/**
> - * __set_bit - Set a bit in memory
> - * @nr: the bit to set
> - * @addr: the address to start counting from
> - *
> - * Unlike set_bit(), this function is non-atomic. If it is called on the same
> - * region of memory concurrently, the effect may be that only one operation
> - * succeeds.
> - */
> -static inline void __set_bit(long nr, volatile unsigned long *addr)
> -{
> -	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> -	arch___set_bit(nr, addr);
> -}
> -
> -/**
> - * clear_bit - Clears a bit in memory
> - * @nr: Bit to clear
> - * @addr: Address to start counting from
> - *
> - * This is a relaxed atomic operation (no implied memory barriers).
> - */
> -static inline void clear_bit(long nr, volatile unsigned long *addr)
> -{
> -	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> -	arch_clear_bit(nr, addr);
> -}
> -
> -/**
> - * __clear_bit - Clears a bit in memory
> - * @nr: the bit to clear
> - * @addr: the address to start counting from
> - *
> - * Unlike clear_bit(), this function is non-atomic. If it is called on the same
> - * region of memory concurrently, the effect may be that only one operation
> - * succeeds.
> - */
> -static inline void __clear_bit(long nr, volatile unsigned long *addr)
> -{
> -	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> -	arch___clear_bit(nr, addr);
> -}
> -
> -/**
> - * clear_bit_unlock - Clear a bit in memory, for unlock
> - * @nr: the bit to set
> - * @addr: the address to start counting from
> - *
> - * This operation is atomic and provides release barrier semantics.
> - */
> -static inline void clear_bit_unlock(long nr, volatile unsigned long *addr)
> -{
> -	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> -	arch_clear_bit_unlock(nr, addr);
> -}
> -
> -/**
> - * __clear_bit_unlock - Clears a bit in memory
> - * @nr: Bit to clear
> - * @addr: Address to start counting from
> - *
> - * This is a non-atomic operation but implies a release barrier before the
> - * memory operation. It can be used for an unlock if no other CPUs can
> - * concurrently modify other bits in the word.
> - */
> -static inline void __clear_bit_unlock(long nr, volatile unsigned long *addr)
> -{
> -	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> -	arch___clear_bit_unlock(nr, addr);
> -}
> -
> -/**
> - * change_bit - Toggle a bit in memory
> - * @nr: Bit to change
> - * @addr: Address to start counting from
> - *
> - * This is a relaxed atomic operation (no implied memory barriers).
> - *
> - * Note that @nr may be almost arbitrarily large; this function is not
> - * restricted to acting on a single-word quantity.
> - */
> -static inline void change_bit(long nr, volatile unsigned long *addr)
> -{
> -	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> -	arch_change_bit(nr, addr);
> -}
> -
> -/**
> - * __change_bit - Toggle a bit in memory
> - * @nr: the bit to change
> - * @addr: the address to start counting from
> - *
> - * Unlike change_bit(), this function is non-atomic. If it is called on the same
> - * region of memory concurrently, the effect may be that only one operation
> - * succeeds.
> - */
> -static inline void __change_bit(long nr, volatile unsigned long *addr)
> -{
> -	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> -	arch___change_bit(nr, addr);
> -}
> -
> -/**
> - * test_and_set_bit - Set a bit and return its old value
> - * @nr: Bit to set
> - * @addr: Address to count from
> - *
> - * This is an atomic fully-ordered operation (implied full memory barrier).
> - */
> -static inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
> -{
> -	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> -	return arch_test_and_set_bit(nr, addr);
> -}
> -
> -/**
> - * __test_and_set_bit - Set a bit and return its old value
> - * @nr: Bit to set
> - * @addr: Address to count from
> - *
> - * This operation is non-atomic. If two instances of this operation race, one
> - * can appear to succeed but actually fail.
> - */
> -static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
> -{
> -	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> -	return arch___test_and_set_bit(nr, addr);
> -}
> -
> -/**
> - * test_and_set_bit_lock - Set a bit and return its old value, for lock
> - * @nr: Bit to set
> - * @addr: Address to count from
> - *
> - * This operation is atomic and provides acquire barrier semantics if
> - * the returned value is 0.
> - * It can be used to implement bit locks.
> - */
> -static inline bool test_and_set_bit_lock(long nr, volatile unsigned long *addr)
> -{
> -	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> -	return arch_test_and_set_bit_lock(nr, addr);
> -}
> -
> -/**
> - * test_and_clear_bit - Clear a bit and return its old value
> - * @nr: Bit to clear
> - * @addr: Address to count from
> - *
> - * This is an atomic fully-ordered operation (implied full memory barrier).
> - */
> -static inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
> -{
> -	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> -	return arch_test_and_clear_bit(nr, addr);
> -}
> -
> -/**
> - * __test_and_clear_bit - Clear a bit and return its old value
> - * @nr: Bit to clear
> - * @addr: Address to count from
> - *
> - * This operation is non-atomic. If two instances of this operation race, one
> - * can appear to succeed but actually fail.
> - */
> -static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
> -{
> -	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> -	return arch___test_and_clear_bit(nr, addr);
> -}
> -
> -/**
> - * test_and_change_bit - Change a bit and return its old value
> - * @nr: Bit to change
> - * @addr: Address to count from
> - *
> - * This is an atomic fully-ordered operation (implied full memory barrier).
> - */
> -static inline bool test_and_change_bit(long nr, volatile unsigned long *addr)
> -{
> -	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> -	return arch_test_and_change_bit(nr, addr);
> -}
> -
> -/**
> - * __test_and_change_bit - Change a bit and return its old value
> - * @nr: Bit to change
> - * @addr: Address to count from
> - *
> - * This operation is non-atomic. If two instances of this operation race, one
> - * can appear to succeed but actually fail.
> - */
> -static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
> -{
> -	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> -	return arch___test_and_change_bit(nr, addr);
> -}
> -
> -/**
> - * test_bit - Determine whether a bit is set
> - * @nr: bit number to test
> - * @addr: Address to start counting from
> - */
> -static inline bool test_bit(long nr, const volatile unsigned long *addr)
> -{
> -	kasan_check_read(addr + BIT_WORD(nr), sizeof(long));
> -	return arch_test_bit(nr, addr);
> -}
> -
> -#if defined(arch_clear_bit_unlock_is_negative_byte)
> -/**
> - * clear_bit_unlock_is_negative_byte - Clear a bit in memory and test if bottom
> - *                                     byte is negative, for unlock.
> - * @nr: the bit to clear
> - * @addr: the address to start counting from
> - *
> - * This operation is atomic and provides release barrier semantics.
> - *
> - * This is a bit of a one-trick-pony for the filemap code, which clears
> - * PG_locked and tests PG_waiters,
> - */
> -static inline bool
> -clear_bit_unlock_is_negative_byte(long nr, volatile unsigned long *addr)
> -{
> -	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> -	return arch_clear_bit_unlock_is_negative_byte(nr, addr);
> -}
> -/* Let everybody know we have it. */
> -#define clear_bit_unlock_is_negative_byte clear_bit_unlock_is_negative_byte
> -#endif
> -
> -#endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_H */
> diff --git a/include/asm-generic/bitops/instrumented-atomic.h b/include/asm-generic/bitops/instrumented-atomic.h
> new file mode 100644
> index 000000000000..18ce3c9e8eec
> --- /dev/null
> +++ b/include/asm-generic/bitops/instrumented-atomic.h
> @@ -0,0 +1,100 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * This file provides wrappers with sanitizer instrumentation for atomic bit
> + * operations.
> + *
> + * To use this functionality, an arch's bitops.h file needs to define each of
> + * the below bit operations with an arch_ prefix (e.g. arch_set_bit(),
> + * arch___set_bit(), etc.).
> + */
> +#ifndef _ASM_GENERIC_BITOPS_INSTRUMENTED_ATOMIC_H
> +#define _ASM_GENERIC_BITOPS_INSTRUMENTED_ATOMIC_H
> +
> +#include <linux/kasan-checks.h>
> +
> +/**
> + * set_bit - Atomically set a bit in memory
> + * @nr: the bit to set
> + * @addr: the address to start counting from
> + *
> + * This is a relaxed atomic operation (no implied memory barriers).
> + *
> + * Note that @nr may be almost arbitrarily large; this function is not
> + * restricted to acting on a single-word quantity.
> + */
> +static inline void set_bit(long nr, volatile unsigned long *addr)
> +{
> +	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> +	arch_set_bit(nr, addr);
> +}
> +
> +/**
> + * clear_bit - Clears a bit in memory
> + * @nr: Bit to clear
> + * @addr: Address to start counting from
> + *
> + * This is a relaxed atomic operation (no implied memory barriers).
> + */
> +static inline void clear_bit(long nr, volatile unsigned long *addr)
> +{
> +	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> +	arch_clear_bit(nr, addr);
> +}
> +
> +/**
> + * change_bit - Toggle a bit in memory
> + * @nr: Bit to change
> + * @addr: Address to start counting from
> + *
> + * This is a relaxed atomic operation (no implied memory barriers).
> + *
> + * Note that @nr may be almost arbitrarily large; this function is not
> + * restricted to acting on a single-word quantity.
> + */
> +static inline void change_bit(long nr, volatile unsigned long *addr)
> +{
> +	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> +	arch_change_bit(nr, addr);
> +}
> +
> +/**
> + * test_and_set_bit - Set a bit and return its old value
> + * @nr: Bit to set
> + * @addr: Address to count from
> + *
> + * This is an atomic fully-ordered operation (implied full memory barrier).
> + */
> +static inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
> +{
> +	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> +	return arch_test_and_set_bit(nr, addr);
> +}
> +
> +/**
> + * test_and_clear_bit - Clear a bit and return its old value
> + * @nr: Bit to clear
> + * @addr: Address to count from
> + *
> + * This is an atomic fully-ordered operation (implied full memory barrier).
> + */
> +static inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
> +{
> +	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> +	return arch_test_and_clear_bit(nr, addr);
> +}
> +
> +/**
> + * test_and_change_bit - Change a bit and return its old value
> + * @nr: Bit to change
> + * @addr: Address to count from
> + *
> + * This is an atomic fully-ordered operation (implied full memory barrier).
> + */
> +static inline bool test_and_change_bit(long nr, volatile unsigned long *addr)
> +{
> +	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> +	return arch_test_and_change_bit(nr, addr);
> +}
> +
> +#endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H */
> diff --git a/include/asm-generic/bitops/instrumented-lock.h b/include/asm-generic/bitops/instrumented-lock.h
> new file mode 100644
> index 000000000000..ec53fdeea9ec
> --- /dev/null
> +++ b/include/asm-generic/bitops/instrumented-lock.h
> @@ -0,0 +1,81 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * This file provides wrappers with sanitizer instrumentation for bit
> + * locking operations.
> + *
> + * To use this functionality, an arch's bitops.h file needs to define each of
> + * the below bit operations with an arch_ prefix (e.g. arch_set_bit(),
> + * arch___set_bit(), etc.).
> + */
> +#ifndef _ASM_GENERIC_BITOPS_INSTRUMENTED_LOCK_H
> +#define _ASM_GENERIC_BITOPS_INSTRUMENTED_LOCK_H
> +
> +#include <linux/kasan-checks.h>
> +
> +/**
> + * clear_bit_unlock - Clear a bit in memory, for unlock
> + * @nr: the bit to set
> + * @addr: the address to start counting from
> + *
> + * This operation is atomic and provides release barrier semantics.
> + */
> +static inline void clear_bit_unlock(long nr, volatile unsigned long *addr)
> +{
> +	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> +	arch_clear_bit_unlock(nr, addr);
> +}
> +
> +/**
> + * __clear_bit_unlock - Clears a bit in memory
> + * @nr: Bit to clear
> + * @addr: Address to start counting from
> + *
> + * This is a non-atomic operation but implies a release barrier before the
> + * memory operation. It can be used for an unlock if no other CPUs can
> + * concurrently modify other bits in the word.
> + */
> +static inline void __clear_bit_unlock(long nr, volatile unsigned long *addr)
> +{
> +	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> +	arch___clear_bit_unlock(nr, addr);
> +}
> +
> +/**
> + * test_and_set_bit_lock - Set a bit and return its old value, for lock
> + * @nr: Bit to set
> + * @addr: Address to count from
> + *
> + * This operation is atomic and provides acquire barrier semantics if
> + * the returned value is 0.
> + * It can be used to implement bit locks.
> + */
> +static inline bool test_and_set_bit_lock(long nr, volatile unsigned long *addr)
> +{
> +	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> +	return arch_test_and_set_bit_lock(nr, addr);
> +}
> +
> +#if defined(arch_clear_bit_unlock_is_negative_byte)
> +/**
> + * clear_bit_unlock_is_negative_byte - Clear a bit in memory and test if bottom
> + *                                     byte is negative, for unlock.
> + * @nr: the bit to clear
> + * @addr: the address to start counting from
> + *
> + * This operation is atomic and provides release barrier semantics.
> + *
> + * This is a bit of a one-trick-pony for the filemap code, which clears
> + * PG_locked and tests PG_waiters,
> + */
> +static inline bool
> +clear_bit_unlock_is_negative_byte(long nr, volatile unsigned long *addr)
> +{
> +	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> +	return arch_clear_bit_unlock_is_negative_byte(nr, addr);
> +}
> +/* Let everybody know we have it. */
> +#define clear_bit_unlock_is_negative_byte clear_bit_unlock_is_negative_byte
> +#endif
> +
> +#endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_LOCK_H */
> diff --git a/include/asm-generic/bitops/instrumented-non-atomic.h b/include/asm-generic/bitops/instrumented-non-atomic.h
> new file mode 100644
> index 000000000000..95ff28d128a1
> --- /dev/null
> +++ b/include/asm-generic/bitops/instrumented-non-atomic.h
> @@ -0,0 +1,114 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * This file provides wrappers with sanitizer instrumentation for non-atomic
> + * bit operations.
> + *
> + * To use this functionality, an arch's bitops.h file needs to define each of
> + * the below bit operations with an arch_ prefix (e.g. arch_set_bit(),
> + * arch___set_bit(), etc.).
> + */
> +#ifndef _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H
> +#define _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H
> +
> +#include <linux/kasan-checks.h>
> +
> +/**
> + * __set_bit - Set a bit in memory
> + * @nr: the bit to set
> + * @addr: the address to start counting from
> + *
> + * Unlike set_bit(), this function is non-atomic. If it is called on the same
> + * region of memory concurrently, the effect may be that only one operation
> + * succeeds.
> + */
> +static inline void __set_bit(long nr, volatile unsigned long *addr)
> +{
> +	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> +	arch___set_bit(nr, addr);
> +}
> +
> +/**
> + * __clear_bit - Clears a bit in memory
> + * @nr: the bit to clear
> + * @addr: the address to start counting from
> + *
> + * Unlike clear_bit(), this function is non-atomic. If it is called on the same
> + * region of memory concurrently, the effect may be that only one operation
> + * succeeds.
> + */
> +static inline void __clear_bit(long nr, volatile unsigned long *addr)
> +{
> +	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> +	arch___clear_bit(nr, addr);
> +}
> +
> +/**
> + * __change_bit - Toggle a bit in memory
> + * @nr: the bit to change
> + * @addr: the address to start counting from
> + *
> + * Unlike change_bit(), this function is non-atomic. If it is called on the same
> + * region of memory concurrently, the effect may be that only one operation
> + * succeeds.
> + */
> +static inline void __change_bit(long nr, volatile unsigned long *addr)
> +{
> +	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> +	arch___change_bit(nr, addr);
> +}
> +
> +/**
> + * __test_and_set_bit - Set a bit and return its old value
> + * @nr: Bit to set
> + * @addr: Address to count from
> + *
> + * This operation is non-atomic. If two instances of this operation race, one
> + * can appear to succeed but actually fail.
> + */
> +static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
> +{
> +	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> +	return arch___test_and_set_bit(nr, addr);
> +}
> +
> +/**
> + * __test_and_clear_bit - Clear a bit and return its old value
> + * @nr: Bit to clear
> + * @addr: Address to count from
> + *
> + * This operation is non-atomic. If two instances of this operation race, one
> + * can appear to succeed but actually fail.
> + */
> +static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
> +{
> +	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> +	return arch___test_and_clear_bit(nr, addr);
> +}
> +
> +/**
> + * __test_and_change_bit - Change a bit and return its old value
> + * @nr: Bit to change
> + * @addr: Address to count from
> + *
> + * This operation is non-atomic. If two instances of this operation race, one
> + * can appear to succeed but actually fail.
> + */
> +static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
> +{
> +	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> +	return arch___test_and_change_bit(nr, addr);
> +}
> +
> +/**
> + * test_bit - Determine whether a bit is set
> + * @nr: bit number to test
> + * @addr: Address to start counting from
> + */
> +static inline bool test_bit(long nr, const volatile unsigned long *addr)
> +{
> +	kasan_check_read(addr + BIT_WORD(nr), sizeof(long));
> +	return arch_test_bit(nr, addr);
> +}
> +
> +#endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H */
> 
