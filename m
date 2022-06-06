Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E2A53EA2D
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jun 2022 19:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241801AbiFFQZX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jun 2022 12:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241771AbiFFQZW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jun 2022 12:25:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 669A73893;
        Mon,  6 Jun 2022 09:25:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24F7F15DB;
        Mon,  6 Jun 2022 09:25:20 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.37.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4A2E3F73B;
        Mon,  6 Jun 2022 09:25:16 -0700 (PDT)
Date:   Mon, 6 Jun 2022 17:25:13 +0100
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
Subject: Re: [PATCH 4/6] bitops: unify non-atomic bitops prototypes across
 architectures
Message-ID: <Yp4qaRMNtSFSUNZz@FVFF77S0Q05N.cambridge.arm.com>
References: <20220606114908.962562-1-alexandr.lobakin@intel.com>
 <20220606114908.962562-5-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606114908.962562-5-alexandr.lobakin@intel.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 06, 2022 at 01:49:05PM +0200, Alexander Lobakin wrote:
> Currently, there is a mess with the prototypes of the non-atomic
> bitops across the different architectures:
> 
> ret	bool, int, unsigned long
> nr	int, long, unsigned int, unsigned long
> addr	volatile unsigned long *, volatile void *
> 
> Thankfully, it doesn't provoke any bugs, but can sometimes make
> the compiler angry when it's not handy at all.
> Adjust all the prototypes to the following standard:
> 
> ret	bool				retval can be only 0 or 1
> nr	unsigned long			native; signed makes no sense
> addr	volatile unsigned long *	bitmaps are arrays of ulongs
> 
> Finally, add some static assertions in order to prevent people from
> making a mess in this room again.

This looks like a nice cleanup!

Using `bool` makes the semantic clearer from the prototype.

> I also used the %__always_inline attribute consistently they always
> get resolved to the actual operations.

Since these will get wrapped in the next patch (and architectures may want to
use these in noinstr code), this makes sense to me.

> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>

FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/alpha/include/asm/bitops.h               | 28 +++++------
>  arch/hexagon/include/asm/bitops.h             | 23 +++++----
>  arch/ia64/include/asm/bitops.h                | 28 +++++------
>  arch/m68k/include/asm/bitops.h                | 47 +++++++++++++------
>  arch/sh/include/asm/bitops-op32.h             | 24 ++++++----
>  .../asm-generic/bitops/generic-non-atomic.h   | 24 +++++-----
>  .../bitops/instrumented-non-atomic.h          | 21 ++++++---
>  include/linux/bitops.h                        | 13 +++++
>  tools/include/asm-generic/bitops/non-atomic.h | 24 ++++++----
>  9 files changed, 146 insertions(+), 86 deletions(-)
> 
> diff --git a/arch/alpha/include/asm/bitops.h b/arch/alpha/include/asm/bitops.h
> index e1d8483a45f2..381ad2eae4b4 100644
> --- a/arch/alpha/include/asm/bitops.h
> +++ b/arch/alpha/include/asm/bitops.h
> @@ -46,8 +46,8 @@ set_bit(unsigned long nr, volatile void * addr)
>  /*
>   * WARNING: non atomic version.
>   */
> -static inline void
> -__set_bit(unsigned long nr, volatile void * addr)
> +static __always_inline void
> +__set_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	int *m = ((int *) addr) + (nr >> 5);
>  
> @@ -82,8 +82,8 @@ clear_bit_unlock(unsigned long nr, volatile void * addr)
>  /*
>   * WARNING: non atomic version.
>   */
> -static __inline__ void
> -__clear_bit(unsigned long nr, volatile void * addr)
> +static __always_inline void
> +__clear_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	int *m = ((int *) addr) + (nr >> 5);
>  
> @@ -118,8 +118,8 @@ change_bit(unsigned long nr, volatile void * addr)
>  /*
>   * WARNING: non atomic version.
>   */
> -static __inline__ void
> -__change_bit(unsigned long nr, volatile void * addr)
> +static __always_inline void
> +__change_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	int *m = ((int *) addr) + (nr >> 5);
>  
> @@ -186,8 +186,8 @@ test_and_set_bit_lock(unsigned long nr, volatile void *addr)
>  /*
>   * WARNING: non atomic version.
>   */
> -static inline int
> -__test_and_set_bit(unsigned long nr, volatile void * addr)
> +static __always_inline bool
> +__test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = 1 << (nr & 0x1f);
>  	int *m = ((int *) addr) + (nr >> 5);
> @@ -230,8 +230,8 @@ test_and_clear_bit(unsigned long nr, volatile void * addr)
>  /*
>   * WARNING: non atomic version.
>   */
> -static inline int
> -__test_and_clear_bit(unsigned long nr, volatile void * addr)
> +static __always_inline bool
> +__test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = 1 << (nr & 0x1f);
>  	int *m = ((int *) addr) + (nr >> 5);
> @@ -272,8 +272,8 @@ test_and_change_bit(unsigned long nr, volatile void * addr)
>  /*
>   * WARNING: non atomic version.
>   */
> -static __inline__ int
> -__test_and_change_bit(unsigned long nr, volatile void * addr)
> +static __always_inline bool
> +__test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = 1 << (nr & 0x1f);
>  	int *m = ((int *) addr) + (nr >> 5);
> @@ -283,8 +283,8 @@ __test_and_change_bit(unsigned long nr, volatile void * addr)
>  	return (old & mask) != 0;
>  }
>  
> -static inline int
> -test_bit(int nr, const volatile void * addr)
> +static __always_inline bool
> +test_bit(unsigned long nr, const volatile unsigned long *addr)
>  {
>  	return (1UL & (((const int *) addr)[nr >> 5] >> (nr & 31))) != 0UL;
>  }
> diff --git a/arch/hexagon/include/asm/bitops.h b/arch/hexagon/include/asm/bitops.h
> index 75d6ba3643b8..a3bfe3a8d4b7 100644
> --- a/arch/hexagon/include/asm/bitops.h
> +++ b/arch/hexagon/include/asm/bitops.h
> @@ -127,38 +127,45 @@ static inline void change_bit(int nr, volatile void *addr)
>   * be atomic, particularly for things like slab_lock and slab_unlock.
>   *
>   */
> -static inline void __clear_bit(int nr, volatile unsigned long *addr)
> +static __always_inline void
> +__clear_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	test_and_clear_bit(nr, addr);
>  }
>  
> -static inline void __set_bit(int nr, volatile unsigned long *addr)
> +static __always_inline void
> +__set_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	test_and_set_bit(nr, addr);
>  }
>  
> -static inline void __change_bit(int nr, volatile unsigned long *addr)
> +static __always_inline void
> +__change_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	test_and_change_bit(nr, addr);
>  }
>  
>  /*  Apparently, at least some of these are allowed to be non-atomic  */
> -static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
> +static __always_inline bool
> +__test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	return test_and_clear_bit(nr, addr);
>  }
>  
> -static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
> +static __always_inline bool
> +__test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	return test_and_set_bit(nr, addr);
>  }
>  
> -static inline int __test_and_change_bit(int nr, volatile unsigned long *addr)
> +static __always_inline bool
> +__test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	return test_and_change_bit(nr, addr);
>  }
>  
> -static inline int __test_bit(int nr, const volatile unsigned long *addr)
> +static __always_inline bool
> +test_bit(unsigned long nr, const volatile unsigned long *addr)
>  {
>  	int retval;
>  
> @@ -172,7 +179,7 @@ static inline int __test_bit(int nr, const volatile unsigned long *addr)
>  	return retval;
>  }
>  
> -#define test_bit(nr, addr) __test_bit(nr, addr)
> +#define __test_bit(nr, addr) test_bit(nr, addr)
>  
>  /*
>   * ffz - find first zero in word.
> diff --git a/arch/ia64/include/asm/bitops.h b/arch/ia64/include/asm/bitops.h
> index 577be93c0818..4267a217a503 100644
> --- a/arch/ia64/include/asm/bitops.h
> +++ b/arch/ia64/include/asm/bitops.h
> @@ -61,8 +61,8 @@ set_bit (int nr, volatile void *addr)
>   * If it's called on the same region of memory simultaneously, the effect
>   * may be that only one operation succeeds.
>   */
> -static __inline__ void
> -__set_bit (int nr, volatile void *addr)
> +static __always_inline void
> +__set_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	*((__u32 *) addr + (nr >> 5)) |= (1 << (nr & 31));
>  }
> @@ -143,8 +143,8 @@ __clear_bit_unlock(int nr, void *addr)
>   * If it's called on the same region of memory simultaneously, the effect
>   * may be that only one operation succeeds.
>   */
> -static __inline__ void
> -__clear_bit (int nr, volatile void *addr)
> +static __always_inline void
> +__clear_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	*((__u32 *) addr + (nr >> 5)) &= ~(1 << (nr & 31));
>  }
> @@ -183,8 +183,8 @@ change_bit (int nr, volatile void *addr)
>   * If it's called on the same region of memory simultaneously, the effect
>   * may be that only one operation succeeds.
>   */
> -static __inline__ void
> -__change_bit (int nr, volatile void *addr)
> +static __always_inline void
> +__change_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	*((__u32 *) addr + (nr >> 5)) ^= (1 << (nr & 31));
>  }
> @@ -232,8 +232,8 @@ test_and_set_bit (int nr, volatile void *addr)
>   * If two examples of this operation race, one can appear to succeed
>   * but actually fail.  You must protect multiple accesses with a lock.
>   */
> -static __inline__ int
> -__test_and_set_bit (int nr, volatile void *addr)
> +static __always_inline bool
> +__test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	__u32 *p = (__u32 *) addr + (nr >> 5);
>  	__u32 m = 1 << (nr & 31);
> @@ -277,8 +277,8 @@ test_and_clear_bit (int nr, volatile void *addr)
>   * If two examples of this operation race, one can appear to succeed
>   * but actually fail.  You must protect multiple accesses with a lock.
>   */
> -static __inline__ int
> -__test_and_clear_bit(int nr, volatile void * addr)
> +static __always_inline bool
> +__test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	__u32 *p = (__u32 *) addr + (nr >> 5);
>  	__u32 m = 1 << (nr & 31);
> @@ -320,8 +320,8 @@ test_and_change_bit (int nr, volatile void *addr)
>   *
>   * This operation is non-atomic and can be reordered.
>   */
> -static __inline__ int
> -__test_and_change_bit (int nr, void *addr)
> +static __always_inline bool
> +__test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	__u32 old, bit = (1 << (nr & 31));
>  	__u32 *m = (__u32 *) addr + (nr >> 5);
> @@ -331,8 +331,8 @@ __test_and_change_bit (int nr, void *addr)
>  	return (old & bit) != 0;
>  }
>  
> -static __inline__ int
> -test_bit (int nr, const volatile void *addr)
> +static __always_inline bool
> +test_bit(unsigned long nr, const volatile unsigned long *addr)
>  {
>  	return 1 & (((const volatile __u32 *) addr)[nr >> 5] >> (nr & 31));
>  }
> diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
> index 51283db53667..9d44bd4713cb 100644
> --- a/arch/m68k/include/asm/bitops.h
> +++ b/arch/m68k/include/asm/bitops.h
> @@ -65,8 +65,11 @@ static inline void bfset_mem_set_bit(int nr, volatile unsigned long *vaddr)
>  				bfset_mem_set_bit(nr, vaddr))
>  #endif
>  
> -#define __set_bit(nr, vaddr)	set_bit(nr, vaddr)
> -
> +static __always_inline void
> +__set_bit(unsigned long nr, volatile unsigned long *addr)
> +{
> +	set_bit(nr, addr);
> +}
>  
>  static inline void bclr_reg_clear_bit(int nr, volatile unsigned long *vaddr)
>  {
> @@ -105,8 +108,11 @@ static inline void bfclr_mem_clear_bit(int nr, volatile unsigned long *vaddr)
>  				bfclr_mem_clear_bit(nr, vaddr))
>  #endif
>  
> -#define __clear_bit(nr, vaddr)	clear_bit(nr, vaddr)
> -
> +static __always_inline void
> +__clear_bit(unsigned long nr, volatile unsigned long *addr)
> +{
> +	clear_bit(nr, addr);
> +}
>  
>  static inline void bchg_reg_change_bit(int nr, volatile unsigned long *vaddr)
>  {
> @@ -145,12 +151,16 @@ static inline void bfchg_mem_change_bit(int nr, volatile unsigned long *vaddr)
>  				bfchg_mem_change_bit(nr, vaddr))
>  #endif
>  
> -#define __change_bit(nr, vaddr)	change_bit(nr, vaddr)
> -
> +static __always_inline void
> +__change_bit(unsigned long nr, volatile unsigned long *addr)
> +{
> +	change_bit(nr, addr);
> +}
>  
> -static inline int test_bit(int nr, const volatile unsigned long *vaddr)
> +static __always_inline bool
> +test_bit(unsigned long nr, const volatile unsigned long *addr)
>  {
> -	return (vaddr[nr >> 5] & (1UL << (nr & 31))) != 0;
> +	return (addr[nr >> 5] & (1UL << (nr & 31))) != 0;
>  }
>  
>  
> @@ -201,8 +211,11 @@ static inline int bfset_mem_test_and_set_bit(int nr,
>  					bfset_mem_test_and_set_bit(nr, vaddr))
>  #endif
>  
> -#define __test_and_set_bit(nr, vaddr)	test_and_set_bit(nr, vaddr)
> -
> +static __always_inline bool
> +__test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
> +{
> +	return test_and_set_bit(nr, addr);
> +}
>  
>  static inline int bclr_reg_test_and_clear_bit(int nr,
>  					      volatile unsigned long *vaddr)
> @@ -251,8 +264,11 @@ static inline int bfclr_mem_test_and_clear_bit(int nr,
>  					bfclr_mem_test_and_clear_bit(nr, vaddr))
>  #endif
>  
> -#define __test_and_clear_bit(nr, vaddr)	test_and_clear_bit(nr, vaddr)
> -
> +static __always_inline bool
> +__test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
> +{
> +	return test_and_clear_bit(nr, addr);
> +}
>  
>  static inline int bchg_reg_test_and_change_bit(int nr,
>  					       volatile unsigned long *vaddr)
> @@ -301,8 +317,11 @@ static inline int bfchg_mem_test_and_change_bit(int nr,
>  					bfchg_mem_test_and_change_bit(nr, vaddr))
>  #endif
>  
> -#define __test_and_change_bit(nr, vaddr) test_and_change_bit(nr, vaddr)
> -
> +static __always_inline bool
> +__test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
> +{
> +	return test_and_change_bit(nr, addr);
> +}
>  
>  /*
>   *	The true 68020 and more advanced processors support the "bfffo"
> diff --git a/arch/sh/include/asm/bitops-op32.h b/arch/sh/include/asm/bitops-op32.h
> index cfe5465acce7..dcd85866a394 100644
> --- a/arch/sh/include/asm/bitops-op32.h
> +++ b/arch/sh/include/asm/bitops-op32.h
> @@ -2,6 +2,8 @@
>  #ifndef __ASM_SH_BITOPS_OP32_H
>  #define __ASM_SH_BITOPS_OP32_H
>  
> +#include <linux/bits.h>
> +
>  /*
>   * The bit modifying instructions on SH-2A are only capable of working
>   * with a 3-bit immediate, which signifies the shift position for the bit
> @@ -16,7 +18,8 @@
>  #define BYTE_OFFSET(nr)		((nr) % BITS_PER_BYTE)
>  #endif
>  
> -static inline void __set_bit(int nr, volatile unsigned long *addr)
> +static __always_inline void
> +__set_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	if (__builtin_constant_p(nr)) {
>  		__asm__ __volatile__ (
> @@ -33,7 +36,8 @@ static inline void __set_bit(int nr, volatile unsigned long *addr)
>  	}
>  }
>  
> -static inline void __clear_bit(int nr, volatile unsigned long *addr)
> +static __always_inline void
> +__clear_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	if (__builtin_constant_p(nr)) {
>  		__asm__ __volatile__ (
> @@ -60,7 +64,8 @@ static inline void __clear_bit(int nr, volatile unsigned long *addr)
>   * If it's called on the same region of memory simultaneously, the effect
>   * may be that only one operation succeeds.
>   */
> -static inline void __change_bit(int nr, volatile unsigned long *addr)
> +static __always_inline void
> +__change_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	if (__builtin_constant_p(nr)) {
>  		__asm__ __volatile__ (
> @@ -87,7 +92,8 @@ static inline void __change_bit(int nr, volatile unsigned long *addr)
>   * If two examples of this operation race, one can appear to succeed
>   * but actually fail.  You must protect multiple accesses with a lock.
>   */
> -static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
> +static __always_inline bool
> +__test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = BIT_MASK(nr);
>  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> @@ -106,7 +112,8 @@ static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
>   * If two examples of this operation race, one can appear to succeed
>   * but actually fail.  You must protect multiple accesses with a lock.
>   */
> -static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
> +static __always_inline bool
> +__test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = BIT_MASK(nr);
>  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> @@ -117,8 +124,8 @@ static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
>  }
>  
>  /* WARNING: non atomic and it can be reordered! */
> -static inline int __test_and_change_bit(int nr,
> -					    volatile unsigned long *addr)
> +static __always_inline bool
> +__test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = BIT_MASK(nr);
>  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> @@ -133,7 +140,8 @@ static inline int __test_and_change_bit(int nr,
>   * @nr: bit number to test
>   * @addr: Address to start counting from
>   */
> -static inline int test_bit(int nr, const volatile unsigned long *addr)
> +static __always_inline bool
> +test_bit(unsigned long nr, const volatile unsigned long *addr)
>  {
>  	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
>  }
> diff --git a/include/asm-generic/bitops/generic-non-atomic.h b/include/asm-generic/bitops/generic-non-atomic.h
> index 202d8a3b40e1..249b2a91c174 100644
> --- a/include/asm-generic/bitops/generic-non-atomic.h
> +++ b/include/asm-generic/bitops/generic-non-atomic.h
> @@ -23,7 +23,7 @@
>   * may be that only one operation succeeds.
>   */
>  static __always_inline void
> -gen___set_bit(unsigned int nr, volatile unsigned long *addr)
> +gen___set_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = BIT_MASK(nr);
>  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> @@ -32,7 +32,7 @@ gen___set_bit(unsigned int nr, volatile unsigned long *addr)
>  }
>  
>  static __always_inline void
> -gen___clear_bit(unsigned int nr, volatile unsigned long *addr)
> +gen___clear_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = BIT_MASK(nr);
>  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> @@ -49,8 +49,8 @@ gen___clear_bit(unsigned int nr, volatile unsigned long *addr)
>   * If it's called on the same region of memory simultaneously, the effect
>   * may be that only one operation succeeds.
>   */
> -static __always_inline
> -void gen___change_bit(unsigned int nr, volatile unsigned long *addr)
> +static __always_inline void
> +gen___change_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = BIT_MASK(nr);
>  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> @@ -67,8 +67,8 @@ void gen___change_bit(unsigned int nr, volatile unsigned long *addr)
>   * If two examples of this operation race, one can appear to succeed
>   * but actually fail.  You must protect multiple accesses with a lock.
>   */
> -static __always_inline int
> -gen___test_and_set_bit(unsigned int nr, volatile unsigned long *addr)
> +static __always_inline bool
> +gen___test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = BIT_MASK(nr);
>  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> @@ -87,8 +87,8 @@ gen___test_and_set_bit(unsigned int nr, volatile unsigned long *addr)
>   * If two examples of this operation race, one can appear to succeed
>   * but actually fail.  You must protect multiple accesses with a lock.
>   */
> -static __always_inline int
> -gen___test_and_clear_bit(unsigned int nr, volatile unsigned long *addr)
> +static __always_inline bool
> +gen___test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = BIT_MASK(nr);
>  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> @@ -99,8 +99,8 @@ gen___test_and_clear_bit(unsigned int nr, volatile unsigned long *addr)
>  }
>  
>  /* WARNING: non atomic and it can be reordered! */
> -static __always_inline int
> -gen___test_and_change_bit(unsigned int nr, volatile unsigned long *addr)
> +static __always_inline bool
> +gen___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = BIT_MASK(nr);
>  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> @@ -115,8 +115,8 @@ gen___test_and_change_bit(unsigned int nr, volatile unsigned long *addr)
>   * @nr: bit number to test
>   * @addr: Address to start counting from
>   */
> -static __always_inline int
> -gen_test_bit(unsigned int nr, const volatile unsigned long *addr)
> +static __always_inline bool
> +gen_test_bit(unsigned long nr, const volatile unsigned long *addr)
>  {
>  	const unsigned long *p = (const unsigned long *)addr + BIT_WORD(nr);
>  	unsigned long mask = BIT_MASK(nr);
> diff --git a/include/asm-generic/bitops/instrumented-non-atomic.h b/include/asm-generic/bitops/instrumented-non-atomic.h
> index 7ab1ecc37782..b019f77ef21c 100644
> --- a/include/asm-generic/bitops/instrumented-non-atomic.h
> +++ b/include/asm-generic/bitops/instrumented-non-atomic.h
> @@ -22,7 +22,8 @@
>   * region of memory concurrently, the effect may be that only one operation
>   * succeeds.
>   */
> -static __always_inline void __set_bit(long nr, volatile unsigned long *addr)
> +static __always_inline void
> +__set_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	instrument_write(addr + BIT_WORD(nr), sizeof(long));
>  	arch___set_bit(nr, addr);
> @@ -37,7 +38,8 @@ static __always_inline void __set_bit(long nr, volatile unsigned long *addr)
>   * region of memory concurrently, the effect may be that only one operation
>   * succeeds.
>   */
> -static __always_inline void __clear_bit(long nr, volatile unsigned long *addr)
> +static __always_inline void
> +__clear_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	instrument_write(addr + BIT_WORD(nr), sizeof(long));
>  	arch___clear_bit(nr, addr);
> @@ -52,7 +54,8 @@ static __always_inline void __clear_bit(long nr, volatile unsigned long *addr)
>   * region of memory concurrently, the effect may be that only one operation
>   * succeeds.
>   */
> -static __always_inline void __change_bit(long nr, volatile unsigned long *addr)
> +static __always_inline void
> +__change_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	instrument_write(addr + BIT_WORD(nr), sizeof(long));
>  	arch___change_bit(nr, addr);
> @@ -90,7 +93,8 @@ static __always_inline void __instrument_read_write_bitop(long nr, volatile unsi
>   * This operation is non-atomic. If two instances of this operation race, one
>   * can appear to succeed but actually fail.
>   */
> -static __always_inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
> +static __always_inline bool
> +__test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	__instrument_read_write_bitop(nr, addr);
>  	return arch___test_and_set_bit(nr, addr);
> @@ -104,7 +108,8 @@ static __always_inline bool __test_and_set_bit(long nr, volatile unsigned long *
>   * This operation is non-atomic. If two instances of this operation race, one
>   * can appear to succeed but actually fail.
>   */
> -static __always_inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
> +static __always_inline bool
> +__test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	__instrument_read_write_bitop(nr, addr);
>  	return arch___test_and_clear_bit(nr, addr);
> @@ -118,7 +123,8 @@ static __always_inline bool __test_and_clear_bit(long nr, volatile unsigned long
>   * This operation is non-atomic. If two instances of this operation race, one
>   * can appear to succeed but actually fail.
>   */
> -static __always_inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
> +static __always_inline bool
> +__test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	__instrument_read_write_bitop(nr, addr);
>  	return arch___test_and_change_bit(nr, addr);
> @@ -129,7 +135,8 @@ static __always_inline bool __test_and_change_bit(long nr, volatile unsigned lon
>   * @nr: bit number to test
>   * @addr: Address to start counting from
>   */
> -static __always_inline bool test_bit(long nr, const volatile unsigned long *addr)
> +static __always_inline bool
> +test_bit(unsigned long nr, const volatile unsigned long *addr)
>  {
>  	instrument_atomic_read(addr + BIT_WORD(nr), sizeof(long));
>  	return arch_test_bit(nr, addr);
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 7aaed501f768..5520ac9b1c24 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -26,12 +26,25 @@ extern unsigned int __sw_hweight16(unsigned int w);
>  extern unsigned int __sw_hweight32(unsigned int w);
>  extern unsigned long __sw_hweight64(__u64 w);
>  
> +#include <asm-generic/bitops/generic-non-atomic.h>
> +
>  /*
>   * Include this here because some architectures need generic_ffs/fls in
>   * scope
>   */
>  #include <asm/bitops.h>
>  
> +/* Check that the bitops prototypes are sane */
> +#define __check_bitop_pr(name)	static_assert(__same_type(name, gen_##name))
> +__check_bitop_pr(__set_bit);
> +__check_bitop_pr(__clear_bit);
> +__check_bitop_pr(__change_bit);
> +__check_bitop_pr(__test_and_set_bit);
> +__check_bitop_pr(__test_and_clear_bit);
> +__check_bitop_pr(__test_and_change_bit);
> +__check_bitop_pr(test_bit);
> +#undef __check_bitop_pr
> +
>  static inline int get_bitmask_order(unsigned int count)
>  {
>  	int order;
> diff --git a/tools/include/asm-generic/bitops/non-atomic.h b/tools/include/asm-generic/bitops/non-atomic.h
> index 7e10c4b50c5d..e5e78e42e57b 100644
> --- a/tools/include/asm-generic/bitops/non-atomic.h
> +++ b/tools/include/asm-generic/bitops/non-atomic.h
> @@ -2,7 +2,7 @@
>  #ifndef _ASM_GENERIC_BITOPS_NON_ATOMIC_H_
>  #define _ASM_GENERIC_BITOPS_NON_ATOMIC_H_
>  
> -#include <asm/types.h>
> +#include <linux/bits.h>
>  
>  /**
>   * __set_bit - Set a bit in memory
> @@ -13,7 +13,8 @@
>   * If it's called on the same region of memory simultaneously, the effect
>   * may be that only one operation succeeds.
>   */
> -static inline void __set_bit(int nr, volatile unsigned long *addr)
> +static __always_inline void
> +__set_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = BIT_MASK(nr);
>  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> @@ -21,7 +22,8 @@ static inline void __set_bit(int nr, volatile unsigned long *addr)
>  	*p  |= mask;
>  }
>  
> -static inline void __clear_bit(int nr, volatile unsigned long *addr)
> +static __always_inline void
> +__clear_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = BIT_MASK(nr);
>  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> @@ -38,7 +40,8 @@ static inline void __clear_bit(int nr, volatile unsigned long *addr)
>   * If it's called on the same region of memory simultaneously, the effect
>   * may be that only one operation succeeds.
>   */
> -static inline void __change_bit(int nr, volatile unsigned long *addr)
> +static __always_inline void
> +__change_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = BIT_MASK(nr);
>  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> @@ -55,7 +58,8 @@ static inline void __change_bit(int nr, volatile unsigned long *addr)
>   * If two examples of this operation race, one can appear to succeed
>   * but actually fail.  You must protect multiple accesses with a lock.
>   */
> -static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
> +static __always_inline bool
> +__test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = BIT_MASK(nr);
>  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> @@ -74,7 +78,8 @@ static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
>   * If two examples of this operation race, one can appear to succeed
>   * but actually fail.  You must protect multiple accesses with a lock.
>   */
> -static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
> +static __always_inline bool
> +__test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = BIT_MASK(nr);
>  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> @@ -85,8 +90,8 @@ static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
>  }
>  
>  /* WARNING: non atomic and it can be reordered! */
> -static inline int __test_and_change_bit(int nr,
> -					    volatile unsigned long *addr)
> +static __always_inline bool
> +__test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
>  {
>  	unsigned long mask = BIT_MASK(nr);
>  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> @@ -101,7 +106,8 @@ static inline int __test_and_change_bit(int nr,
>   * @nr: bit number to test
>   * @addr: Address to start counting from
>   */
> -static inline int test_bit(int nr, const volatile unsigned long *addr)
> +static __always_inline bool
> +test_bit(unsigned long nr, const volatile unsigned long *addr)
>  {
>  	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
>  }
> -- 
> 2.36.1
> 
