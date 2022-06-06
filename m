Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E4A53E61C
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jun 2022 19:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbiFFMpJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jun 2022 08:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237695AbiFFMpD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jun 2022 08:45:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D0E0A7E3D;
        Mon,  6 Jun 2022 05:45:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD3361042;
        Mon,  6 Jun 2022 05:45:01 -0700 (PDT)
Received: from FVFF77S0Q05N (FVFF77S0Q05N.cambridge.arm.com [10.1.36.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81E963F73B;
        Mon,  6 Jun 2022 05:44:58 -0700 (PDT)
Date:   Mon, 6 Jun 2022 13:44:52 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] bitops: always define asm-generic non-atomic bitops
Message-ID: <Yp32xDZ/qF8hM6p0@FVFF77S0Q05N>
References: <20220606114908.962562-1-alexandr.lobakin@intel.com>
 <20220606114908.962562-3-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606114908.962562-3-alexandr.lobakin@intel.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 06, 2022 at 01:49:03PM +0200, Alexander Lobakin wrote:
> Move generic non-atomic bitops from the asm-generic header which
> gets included only when there are no architecture-specific
> alternatives, to a separate independent file to make them always
> available.
> 
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> ---
>  .../asm-generic/bitops/generic-non-atomic.h   | 124 ++++++++++++++++++
>  include/asm-generic/bitops/non-atomic.h       | 109 ++-------------
>  2 files changed, 132 insertions(+), 101 deletions(-)
>  create mode 100644 include/asm-generic/bitops/generic-non-atomic.h
> 
> diff --git a/include/asm-generic/bitops/generic-non-atomic.h b/include/asm-generic/bitops/generic-non-atomic.h
> new file mode 100644
> index 000000000000..7a60adfa6e7d
> --- /dev/null
> +++ b/include/asm-generic/bitops/generic-non-atomic.h
> @@ -0,0 +1,124 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __ASM_GENERIC_BITOPS_GENERIC_NON_ATOMIC_H
> +#define __ASM_GENERIC_BITOPS_GENERIC_NON_ATOMIC_H
> +
> +#include <linux/bits.h>
> +
> +#ifndef _LINUX_BITOPS_H
> +#error only <linux/bitops.h> can be included directly
> +#endif
> +
> +/*
> + * Generic definitions for bit operations, should not be used in regular code
> + * directly.
> + */
> +
> +/**
> + * gen___set_bit - Set a bit in memory
> + * @nr: the bit to set
> + * @addr: the address to start counting from
> + *
> + * Unlike set_bit(), this function is non-atomic and may be reordered.
> + * If it's called on the same region of memory simultaneously, the effect
> + * may be that only one operation succeeds.
> + */
> +static __always_inline void
> +gen___set_bit(unsigned int nr, volatile unsigned long *addr)

Could we please use 'generic' rather than 'gen' as the prefix?

That'd match what we did for the generic atomic_*() and atomic64_*() functions
in commits

* f8b6455a9d381fc5 ("locking/atomic: atomic: support ARCH_ATOMIC")
* 1bdadf46eff6804a ("locking/atomic: atomic64: support ARCH_ATOMIC")

... and it avoids any potential confusion with 'gen' meaning 'generated' or
similar.

Thanks,
Mark.

> +{
> +	unsigned long mask = BIT_MASK(nr);
> +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> +
> +	*p  |= mask;
> +}
> +
> +static __always_inline void
> +gen___clear_bit(unsigned int nr, volatile unsigned long *addr)
> +{
> +	unsigned long mask = BIT_MASK(nr);
> +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> +
> +	*p &= ~mask;
> +}
> +
> +/**
> + * gen___change_bit - Toggle a bit in memory
> + * @nr: the bit to change
> + * @addr: the address to start counting from
> + *
> + * Unlike change_bit(), this function is non-atomic and may be reordered.
> + * If it's called on the same region of memory simultaneously, the effect
> + * may be that only one operation succeeds.
> + */
> +static __always_inline
> +void gen___change_bit(unsigned int nr, volatile unsigned long *addr)
> +{
> +	unsigned long mask = BIT_MASK(nr);
> +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> +
> +	*p ^= mask;
> +}
> +
> +/**
> + * gen___test_and_set_bit - Set a bit and return its old value
> + * @nr: Bit to set
> + * @addr: Address to count from
> + *
> + * This operation is non-atomic and can be reordered.
> + * If two examples of this operation race, one can appear to succeed
> + * but actually fail.  You must protect multiple accesses with a lock.
> + */
> +static __always_inline int
> +gen___test_and_set_bit(unsigned int nr, volatile unsigned long *addr)
> +{
> +	unsigned long mask = BIT_MASK(nr);
> +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> +	unsigned long old = *p;
> +
> +	*p = old | mask;
> +	return (old & mask) != 0;
> +}
> +
> +/**
> + * gen___test_and_clear_bit - Clear a bit and return its old value
> + * @nr: Bit to clear
> + * @addr: Address to count from
> + *
> + * This operation is non-atomic and can be reordered.
> + * If two examples of this operation race, one can appear to succeed
> + * but actually fail.  You must protect multiple accesses with a lock.
> + */
> +static __always_inline int
> +gen___test_and_clear_bit(unsigned int nr, volatile unsigned long *addr)
> +{
> +	unsigned long mask = BIT_MASK(nr);
> +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> +	unsigned long old = *p;
> +
> +	*p = old & ~mask;
> +	return (old & mask) != 0;
> +}
> +
> +/* WARNING: non atomic and it can be reordered! */
> +static __always_inline int
> +gen___test_and_change_bit(unsigned int nr, volatile unsigned long *addr)
> +{
> +	unsigned long mask = BIT_MASK(nr);
> +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> +	unsigned long old = *p;
> +
> +	*p = old ^ mask;
> +	return (old & mask) != 0;
> +}
> +
> +/**
> + * gen_test_bit - Determine whether a bit is set
> + * @nr: bit number to test
> + * @addr: Address to start counting from
> + */
> +static __always_inline int
> +gen_test_bit(unsigned int nr, const volatile unsigned long *addr)
> +{
> +	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
> +}
> +
> +#endif /* __ASM_GENERIC_BITOPS_GENERIC_NON_ATOMIC_H */
> diff --git a/include/asm-generic/bitops/non-atomic.h b/include/asm-generic/bitops/non-atomic.h
> index 078cc68be2f1..7ce0ed22fb5f 100644
> --- a/include/asm-generic/bitops/non-atomic.h
> +++ b/include/asm-generic/bitops/non-atomic.h
> @@ -2,121 +2,28 @@
>  #ifndef _ASM_GENERIC_BITOPS_NON_ATOMIC_H_
>  #define _ASM_GENERIC_BITOPS_NON_ATOMIC_H_
>  
> +#include <asm-generic/bitops/generic-non-atomic.h>
>  #include <asm/types.h>
>  
> -/**
> - * arch___set_bit - Set a bit in memory
> - * @nr: the bit to set
> - * @addr: the address to start counting from
> - *
> - * Unlike set_bit(), this function is non-atomic and may be reordered.
> - * If it's called on the same region of memory simultaneously, the effect
> - * may be that only one operation succeeds.
> - */
> -static __always_inline void
> -arch___set_bit(unsigned int nr, volatile unsigned long *addr)
> -{
> -	unsigned long mask = BIT_MASK(nr);
> -	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> -
> -	*p  |= mask;
> -}
> +#define arch___set_bit gen___set_bit
>  #define __set_bit arch___set_bit
>  
> -static __always_inline void
> -arch___clear_bit(unsigned int nr, volatile unsigned long *addr)
> -{
> -	unsigned long mask = BIT_MASK(nr);
> -	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> -
> -	*p &= ~mask;
> -}
> +#define arch___clear_bit gen___clear_bit
>  #define __clear_bit arch___clear_bit
>  
> -/**
> - * arch___change_bit - Toggle a bit in memory
> - * @nr: the bit to change
> - * @addr: the address to start counting from
> - *
> - * Unlike change_bit(), this function is non-atomic and may be reordered.
> - * If it's called on the same region of memory simultaneously, the effect
> - * may be that only one operation succeeds.
> - */
> -static __always_inline
> -void arch___change_bit(unsigned int nr, volatile unsigned long *addr)
> -{
> -	unsigned long mask = BIT_MASK(nr);
> -	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> -
> -	*p ^= mask;
> -}
> +#define arch___change_bit gen___change_bit
>  #define __change_bit arch___change_bit
>  
> -/**
> - * arch___test_and_set_bit - Set a bit and return its old value
> - * @nr: Bit to set
> - * @addr: Address to count from
> - *
> - * This operation is non-atomic and can be reordered.
> - * If two examples of this operation race, one can appear to succeed
> - * but actually fail.  You must protect multiple accesses with a lock.
> - */
> -static __always_inline int
> -arch___test_and_set_bit(unsigned int nr, volatile unsigned long *addr)
> -{
> -	unsigned long mask = BIT_MASK(nr);
> -	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> -	unsigned long old = *p;
> -
> -	*p = old | mask;
> -	return (old & mask) != 0;
> -}
> +#define arch___test_and_set_bit gen___test_and_set_bit
>  #define __test_and_set_bit arch___test_and_set_bit
>  
> -/**
> - * arch___test_and_clear_bit - Clear a bit and return its old value
> - * @nr: Bit to clear
> - * @addr: Address to count from
> - *
> - * This operation is non-atomic and can be reordered.
> - * If two examples of this operation race, one can appear to succeed
> - * but actually fail.  You must protect multiple accesses with a lock.
> - */
> -static __always_inline int
> -arch___test_and_clear_bit(unsigned int nr, volatile unsigned long *addr)
> -{
> -	unsigned long mask = BIT_MASK(nr);
> -	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> -	unsigned long old = *p;
> -
> -	*p = old & ~mask;
> -	return (old & mask) != 0;
> -}
> +#define arch___test_and_clear_bit gen___test_and_clear_bit
>  #define __test_and_clear_bit arch___test_and_clear_bit
>  
> -/* WARNING: non atomic and it can be reordered! */
> -static __always_inline int
> -arch___test_and_change_bit(unsigned int nr, volatile unsigned long *addr)
> -{
> -	unsigned long mask = BIT_MASK(nr);
> -	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> -	unsigned long old = *p;
> -
> -	*p = old ^ mask;
> -	return (old & mask) != 0;
> -}
> +#define arch___test_and_change_bit gen___test_and_change_bit
>  #define __test_and_change_bit arch___test_and_change_bit
>  
> -/**
> - * arch_test_bit - Determine whether a bit is set
> - * @nr: bit number to test
> - * @addr: Address to start counting from
> - */
> -static __always_inline int
> -arch_test_bit(unsigned int nr, const volatile unsigned long *addr)
> -{
> -	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
> -}
> +#define arch_test_bit gen_test_bit
>  #define test_bit arch_test_bit
>  
>  #endif /* _ASM_GENERIC_BITOPS_NON_ATOMIC_H_ */
> -- 
> 2.36.1
> 
