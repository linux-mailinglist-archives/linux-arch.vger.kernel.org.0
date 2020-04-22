Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1021B3BC0
	for <lists+linux-arch@lfdr.de>; Wed, 22 Apr 2020 11:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgDVJv3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Apr 2020 05:51:29 -0400
Received: from foss.arm.com ([217.140.110.172]:45304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgDVJv3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Apr 2020 05:51:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B09B31B;
        Wed, 22 Apr 2020 02:51:28 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 486313F68F;
        Wed, 22 Apr 2020 02:51:26 -0700 (PDT)
Date:   Wed, 22 Apr 2020 10:51:24 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@android.com, Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v4 06/11] READ_ONCE: Simplify implementations of
 {READ,WRITE}_ONCE()
Message-ID: <20200422095123.GB54428@lakrids.cambridge.arm.com>
References: <20200421151537.19241-1-will@kernel.org>
 <20200421151537.19241-7-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421151537.19241-7-will@kernel.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 21, 2020 at 04:15:32PM +0100, Will Deacon wrote:
> The implementations of {READ,WRITE}_ONCE() suffer from a significant
> amount of indirection and complexity due to a historic GCC bug:
> 
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
> 
> which was originally worked around by 230fa253df63 ("kernel: Provide
> READ_ONCE and ASSIGN_ONCE").
> 
> Since GCC 4.8 is fairly vintage at this point and we emit a warning if
> we detect it during the build, return {READ,WRITE}_ONCE() to their former
> glory with an implementation that is easier to understand and, crucially,
> more amenable to optimisation. A side effect of this simplification is
> that WRITE_ONCE() no longer returns a value, but nobody seems to be
> relying on that and the new behaviour is aligned with smp_store_release().
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Will Deacon <will@kernel.org>

The nocheck bits look fine to me now, so FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  include/linux/compiler.h | 118 +++++++++++++--------------------------
>  1 file changed, 39 insertions(+), 79 deletions(-)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 034b0a644efc..338111a448d0 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -177,60 +177,6 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  # define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __LINE__)
>  #endif
>  
> -#include <uapi/linux/types.h>
> -
> -#define __READ_ONCE_SIZE						\
> -({									\
> -	switch (size) {							\
> -	case 1: *(__u8 *)res = *(volatile __u8 *)p; break;		\
> -	case 2: *(__u16 *)res = *(volatile __u16 *)p; break;		\
> -	case 4: *(__u32 *)res = *(volatile __u32 *)p; break;		\
> -	case 8: *(__u64 *)res = *(volatile __u64 *)p; break;		\
> -	default:							\
> -		barrier();						\
> -		__builtin_memcpy((void *)res, (const void *)p, size);	\
> -		barrier();						\
> -	}								\
> -})
> -
> -static __always_inline
> -void __read_once_size(const volatile void *p, void *res, int size)
> -{
> -	__READ_ONCE_SIZE;
> -}
> -
> -#ifdef CONFIG_KASAN
> -/*
> - * We can't declare function 'inline' because __no_sanitize_address confilcts
> - * with inlining. Attempt to inline it may cause a build failure.
> - * 	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
> - * '__maybe_unused' allows us to avoid defined-but-not-used warnings.
> - */
> -# define __no_kasan_or_inline __no_sanitize_address notrace __maybe_unused
> -#else
> -# define __no_kasan_or_inline __always_inline
> -#endif
> -
> -static __no_kasan_or_inline
> -void __read_once_size_nocheck(const volatile void *p, void *res, int size)
> -{
> -	__READ_ONCE_SIZE;
> -}
> -
> -static __always_inline void __write_once_size(volatile void *p, void *res, int size)
> -{
> -	switch (size) {
> -	case 1: *(volatile __u8 *)p = *(__u8 *)res; break;
> -	case 2: *(volatile __u16 *)p = *(__u16 *)res; break;
> -	case 4: *(volatile __u32 *)p = *(__u32 *)res; break;
> -	case 8: *(volatile __u64 *)p = *(__u64 *)res; break;
> -	default:
> -		barrier();
> -		__builtin_memcpy((void *)p, (const void *)res, size);
> -		barrier();
> -	}
> -}
> -
>  /*
>   * Prevent the compiler from merging or refetching reads or writes. The
>   * compiler is also forbidden from reordering successive instances of
> @@ -240,11 +186,7 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
>   * statements.
>   *
>   * These two macros will also work on aggregate data types like structs or
> - * unions. If the size of the accessed data type exceeds the word size of
> - * the machine (e.g., 32 bits or 64 bits) READ_ONCE() and WRITE_ONCE() will
> - * fall back to memcpy(). There's at least two memcpy()s: one for the
> - * __builtin_memcpy() and then one for the macro doing the copy of variable
> - * - '__u' allocated on the stack.
> + * unions.
>   *
>   * Their two major use cases are: (1) Mediating communication between
>   * process-level code and irq/NMI handlers, all running on the same CPU,
> @@ -256,23 +198,49 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
>  #include <asm/barrier.h>
>  #include <linux/kasan-checks.h>
>  
> -#define __READ_ONCE(x, check)						\
> +#define __READ_ONCE(x)	(*(volatile typeof(x) *)&(x))
> +
> +#define READ_ONCE(x)							\
>  ({									\
> -	union { typeof(x) __val; char __c[1]; } __u;			\
> -	if (check)							\
> -		__read_once_size(&(x), __u.__c, sizeof(x));		\
> -	else								\
> -		__read_once_size_nocheck(&(x), __u.__c, sizeof(x));	\
> -	smp_read_barrier_depends(); /* Enforce dependency ordering from x */ \
> -	__u.__val;							\
> +	typeof(x) __x = __READ_ONCE(x);					\
> +	smp_read_barrier_depends();					\
> +	__x;								\
>  })
> -#define READ_ONCE(x) __READ_ONCE(x, 1)
> +
> +#define WRITE_ONCE(x, val)				\
> +do {							\
> +	*(volatile typeof(x) *)&(x) = (val);		\
> +} while (0)
> +
> +#ifdef CONFIG_KASAN
> +/*
> + * We can't declare function 'inline' because __no_sanitize_address conflicts
> + * with inlining. Attempt to inline it may cause a build failure.
> + *     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
> + * '__maybe_unused' allows us to avoid defined-but-not-used warnings.
> + */
> +# define __no_kasan_or_inline __no_sanitize_address notrace __maybe_unused
> +#else
> +# define __no_kasan_or_inline __always_inline
> +#endif
> +
> +static __no_kasan_or_inline
> +unsigned long __read_once_word_nocheck(const void *addr)
> +{
> +	return __READ_ONCE(*(unsigned long *)addr);
> +}
>  
>  /*
> - * Use READ_ONCE_NOCHECK() instead of READ_ONCE() if you need
> - * to hide memory access from KASAN.
> + * Use READ_ONCE_NOCHECK() instead of READ_ONCE() if you need to load a
> + * word from memory atomically but without telling KASAN. This is usually
> + * used by unwinding code when walking the stack of a running process.
>   */
> -#define READ_ONCE_NOCHECK(x) __READ_ONCE(x, 0)
> +#define READ_ONCE_NOCHECK(x)						\
> +({									\
> +	unsigned long __x = __read_once_word_nocheck(&(x));		\
> +	smp_read_barrier_depends();					\
> +	__x;								\
> +})
>  
>  static __no_kasan_or_inline
>  unsigned long read_word_at_a_time(const void *addr)
> @@ -281,14 +249,6 @@ unsigned long read_word_at_a_time(const void *addr)
>  	return *(unsigned long *)addr;
>  }
>  
> -#define WRITE_ONCE(x, val) \
> -({							\
> -	union { typeof(x) __val; char __c[1]; } __u =	\
> -		{ .__val = (__force typeof(x)) (val) }; \
> -	__write_once_size(&(x), __u.__c, sizeof(x));	\
> -	__u.__val;					\
> -})
> -
>  #endif /* __KERNEL__ */
>  
>  /*
> -- 
> 2.26.1.301.g55bc3eb7cb9-goog
> 
