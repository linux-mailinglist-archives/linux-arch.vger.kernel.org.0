Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D95936FE3C
	for <lists+linux-arch@lfdr.de>; Fri, 30 Apr 2021 18:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhD3QFQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Apr 2021 12:05:16 -0400
Received: from foss.arm.com ([217.140.110.172]:50190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhD3QFN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Apr 2021 12:05:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6173101E;
        Fri, 30 Apr 2021 09:04:24 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.5.252])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FD2C3F70D;
        Fri, 30 Apr 2021 09:04:23 -0700 (PDT)
Date:   Fri, 30 Apr 2021 17:04:20 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 1/2] locking/atomics: Fixup GENERIC_ATOMIC64 conflict
 with atomic-arch-fallback.h
Message-ID: <20210430160420.GB57205@C02TD0UTHF1T.local>
References: <1619009626-93453-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619009626-93453-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Guo,

I had a look at completing the treewide conversion to ARCH_ATOMIC, and
I've pushed the results to my atomics/arch-atomic branch on kernel.org:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=atomics/arch-atomic
  git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git atomics/arch-atomic

Once v5.13-rc1 is out I intend to rebase and post the series to LKML.
The Kbuild test robot has been attacked the series for the last few
days, and I think it's fairly robust now, but if you wanted to take an
early look at the riscv or csky bits that'd be much appreciated.

I've omitted the structural changes and optimizations you had prepared
for riscv, but I think those can be applied atop (or applied as a
preparatory step for the ARCH_ATOMIC conversion). I'd like to keep the
two steps separate to make bisection easier.

Thanks,
Mark.

On Wed, Apr 21, 2021 at 12:53:45PM +0000, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Current GENERIC_ATOMIC64 in atomic-arch-fallback.h is broken. When a 32-bit
> arch use atomic-arch-fallback.h will cause compile error.
> 
> In file included from include/linux/atomic.h:81,
>                     from include/linux/rcupdate.h:25,
>                     from include/linux/rculist.h:11,
>                     from include/linux/pid.h:5,
>                     from include/linux/sched.h:14,
>                     from arch/riscv/kernel/asm-offsets.c:10:
>    include/linux/atomic-arch-fallback.h: In function 'arch_atomic64_inc':
> >> include/linux/atomic-arch-fallback.h:1447:2: error: implicit declaration of function 'arch_atomic64_add'; did you mean 'arch_atomic_add'? [-Werror=implicit-function-declaration]
>     1447 |  arch_atomic64_add(1, v);
>          |  ^~~~~~~~~~~~~~~~~
>          |  arch_atomic_add
> 
> The atomic-arch-fallback.h & atomic-fallback.h &
> atomic-instrumented.h are generated by gen-atomic-fallback.sh &
> gen-atomic-instrumented.sh, so just take care the bash files.
> 
> Remove the dependency of atomic-*-fallback.h in atomic64.h.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/asm-generic/atomic-instrumented.h | 264 +++++++++++++++---------------
>  include/asm-generic/atomic64.h            |  89 ++++++++++
>  include/linux/atomic-arch-fallback.h      |   5 +-
>  include/linux/atomic-fallback.h           |   5 +-
>  scripts/atomic/gen-atomic-fallback.sh     |   3 +-
>  scripts/atomic/gen-atomic-instrumented.sh |  23 ++-
>  6 files changed, 251 insertions(+), 138 deletions(-)
> 
> diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
> index 888b6cf..c9e69c6 100644
> --- a/include/asm-generic/atomic-instrumented.h
> +++ b/include/asm-generic/atomic-instrumented.h
> @@ -831,6 +831,137 @@ atomic_dec_if_positive(atomic_t *v)
>  #define atomic_dec_if_positive atomic_dec_if_positive
>  #endif
>  
> +#if !defined(arch_xchg_relaxed) || defined(arch_xchg)
> +#define xchg(ptr, ...) \
> +({ \
> +	typeof(ptr) __ai_ptr = (ptr); \
> +	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +	arch_xchg(__ai_ptr, __VA_ARGS__); \
> +})
> +#endif
> +
> +#if defined(arch_xchg_acquire)
> +#define xchg_acquire(ptr, ...) \
> +({ \
> +	typeof(ptr) __ai_ptr = (ptr); \
> +	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +	arch_xchg_acquire(__ai_ptr, __VA_ARGS__); \
> +})
> +#endif
> +
> +#if defined(arch_xchg_release)
> +#define xchg_release(ptr, ...) \
> +({ \
> +	typeof(ptr) __ai_ptr = (ptr); \
> +	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +	arch_xchg_release(__ai_ptr, __VA_ARGS__); \
> +})
> +#endif
> +
> +#if defined(arch_xchg_relaxed)
> +#define xchg_relaxed(ptr, ...) \
> +({ \
> +	typeof(ptr) __ai_ptr = (ptr); \
> +	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +	arch_xchg_relaxed(__ai_ptr, __VA_ARGS__); \
> +})
> +#endif
> +
> +#if !defined(arch_cmpxchg_relaxed) || defined(arch_cmpxchg)
> +#define cmpxchg(ptr, ...) \
> +({ \
> +	typeof(ptr) __ai_ptr = (ptr); \
> +	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +	arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
> +})
> +#endif
> +
> +#if defined(arch_cmpxchg_acquire)
> +#define cmpxchg_acquire(ptr, ...) \
> +({ \
> +	typeof(ptr) __ai_ptr = (ptr); \
> +	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +	arch_cmpxchg_acquire(__ai_ptr, __VA_ARGS__); \
> +})
> +#endif
> +
> +#if defined(arch_cmpxchg_release)
> +#define cmpxchg_release(ptr, ...) \
> +({ \
> +	typeof(ptr) __ai_ptr = (ptr); \
> +	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +	arch_cmpxchg_release(__ai_ptr, __VA_ARGS__); \
> +})
> +#endif
> +
> +#if defined(arch_cmpxchg_relaxed)
> +#define cmpxchg_relaxed(ptr, ...) \
> +({ \
> +	typeof(ptr) __ai_ptr = (ptr); \
> +	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +	arch_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
> +})
> +#endif
> +
> +#if !defined(arch_try_cmpxchg_relaxed) || defined(arch_try_cmpxchg)
> +#define try_cmpxchg(ptr, oldp, ...) \
> +({ \
> +	typeof(ptr) __ai_ptr = (ptr); \
> +	typeof(oldp) __ai_oldp = (oldp); \
> +	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
> +	arch_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
> +})
> +#endif
> +
> +#if defined(arch_try_cmpxchg_acquire)
> +#define try_cmpxchg_acquire(ptr, oldp, ...) \
> +({ \
> +	typeof(ptr) __ai_ptr = (ptr); \
> +	typeof(oldp) __ai_oldp = (oldp); \
> +	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
> +	arch_try_cmpxchg_acquire(__ai_ptr, __ai_oldp, __VA_ARGS__); \
> +})
> +#endif
> +
> +#if defined(arch_try_cmpxchg_release)
> +#define try_cmpxchg_release(ptr, oldp, ...) \
> +({ \
> +	typeof(ptr) __ai_ptr = (ptr); \
> +	typeof(oldp) __ai_oldp = (oldp); \
> +	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
> +	arch_try_cmpxchg_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
> +})
> +#endif
> +
> +#if defined(arch_try_cmpxchg_relaxed)
> +#define try_cmpxchg_relaxed(ptr, oldp, ...) \
> +({ \
> +	typeof(ptr) __ai_ptr = (ptr); \
> +	typeof(oldp) __ai_oldp = (oldp); \
> +	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
> +	arch_try_cmpxchg_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
> +})
> +#endif
> +
> +#define cmpxchg_local(ptr, ...) \
> +({ \
> +	typeof(ptr) __ai_ptr = (ptr); \
> +	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +	arch_cmpxchg_local(__ai_ptr, __VA_ARGS__); \
> +})
> +
> +#define sync_cmpxchg(ptr, ...) \
> +({ \
> +	typeof(ptr) __ai_ptr = (ptr); \
> +	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +	arch_sync_cmpxchg(__ai_ptr, __VA_ARGS__); \
> +})
> +
> +#ifndef CONFIG_GENERIC_ATOMIC64
>  static __always_inline s64
>  atomic64_read(const atomic64_t *v)
>  {
> @@ -1641,78 +1772,6 @@ atomic64_dec_if_positive(atomic64_t *v)
>  #define atomic64_dec_if_positive atomic64_dec_if_positive
>  #endif
>  
> -#if !defined(arch_xchg_relaxed) || defined(arch_xchg)
> -#define xchg(ptr, ...) \
> -({ \
> -	typeof(ptr) __ai_ptr = (ptr); \
> -	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> -	arch_xchg(__ai_ptr, __VA_ARGS__); \
> -})
> -#endif
> -
> -#if defined(arch_xchg_acquire)
> -#define xchg_acquire(ptr, ...) \
> -({ \
> -	typeof(ptr) __ai_ptr = (ptr); \
> -	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> -	arch_xchg_acquire(__ai_ptr, __VA_ARGS__); \
> -})
> -#endif
> -
> -#if defined(arch_xchg_release)
> -#define xchg_release(ptr, ...) \
> -({ \
> -	typeof(ptr) __ai_ptr = (ptr); \
> -	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> -	arch_xchg_release(__ai_ptr, __VA_ARGS__); \
> -})
> -#endif
> -
> -#if defined(arch_xchg_relaxed)
> -#define xchg_relaxed(ptr, ...) \
> -({ \
> -	typeof(ptr) __ai_ptr = (ptr); \
> -	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> -	arch_xchg_relaxed(__ai_ptr, __VA_ARGS__); \
> -})
> -#endif
> -
> -#if !defined(arch_cmpxchg_relaxed) || defined(arch_cmpxchg)
> -#define cmpxchg(ptr, ...) \
> -({ \
> -	typeof(ptr) __ai_ptr = (ptr); \
> -	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> -	arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
> -})
> -#endif
> -
> -#if defined(arch_cmpxchg_acquire)
> -#define cmpxchg_acquire(ptr, ...) \
> -({ \
> -	typeof(ptr) __ai_ptr = (ptr); \
> -	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> -	arch_cmpxchg_acquire(__ai_ptr, __VA_ARGS__); \
> -})
> -#endif
> -
> -#if defined(arch_cmpxchg_release)
> -#define cmpxchg_release(ptr, ...) \
> -({ \
> -	typeof(ptr) __ai_ptr = (ptr); \
> -	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> -	arch_cmpxchg_release(__ai_ptr, __VA_ARGS__); \
> -})
> -#endif
> -
> -#if defined(arch_cmpxchg_relaxed)
> -#define cmpxchg_relaxed(ptr, ...) \
> -({ \
> -	typeof(ptr) __ai_ptr = (ptr); \
> -	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> -	arch_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
> -})
> -#endif
> -
>  #if !defined(arch_cmpxchg64_relaxed) || defined(arch_cmpxchg64)
>  #define cmpxchg64(ptr, ...) \
>  ({ \
> @@ -1749,57 +1808,6 @@ atomic64_dec_if_positive(atomic64_t *v)
>  })
>  #endif
>  
> -#if !defined(arch_try_cmpxchg_relaxed) || defined(arch_try_cmpxchg)
> -#define try_cmpxchg(ptr, oldp, ...) \
> -({ \
> -	typeof(ptr) __ai_ptr = (ptr); \
> -	typeof(oldp) __ai_oldp = (oldp); \
> -	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> -	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
> -	arch_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
> -})
> -#endif
> -
> -#if defined(arch_try_cmpxchg_acquire)
> -#define try_cmpxchg_acquire(ptr, oldp, ...) \
> -({ \
> -	typeof(ptr) __ai_ptr = (ptr); \
> -	typeof(oldp) __ai_oldp = (oldp); \
> -	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> -	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
> -	arch_try_cmpxchg_acquire(__ai_ptr, __ai_oldp, __VA_ARGS__); \
> -})
> -#endif
> -
> -#if defined(arch_try_cmpxchg_release)
> -#define try_cmpxchg_release(ptr, oldp, ...) \
> -({ \
> -	typeof(ptr) __ai_ptr = (ptr); \
> -	typeof(oldp) __ai_oldp = (oldp); \
> -	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> -	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
> -	arch_try_cmpxchg_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
> -})
> -#endif
> -
> -#if defined(arch_try_cmpxchg_relaxed)
> -#define try_cmpxchg_relaxed(ptr, oldp, ...) \
> -({ \
> -	typeof(ptr) __ai_ptr = (ptr); \
> -	typeof(oldp) __ai_oldp = (oldp); \
> -	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> -	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
> -	arch_try_cmpxchg_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
> -})
> -#endif
> -
> -#define cmpxchg_local(ptr, ...) \
> -({ \
> -	typeof(ptr) __ai_ptr = (ptr); \
> -	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> -	arch_cmpxchg_local(__ai_ptr, __VA_ARGS__); \
> -})
> -
>  #define cmpxchg64_local(ptr, ...) \
>  ({ \
>  	typeof(ptr) __ai_ptr = (ptr); \
> @@ -1807,13 +1815,7 @@ atomic64_dec_if_positive(atomic64_t *v)
>  	arch_cmpxchg64_local(__ai_ptr, __VA_ARGS__); \
>  })
>  
> -#define sync_cmpxchg(ptr, ...) \
> -({ \
> -	typeof(ptr) __ai_ptr = (ptr); \
> -	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> -	arch_sync_cmpxchg(__ai_ptr, __VA_ARGS__); \
> -})
> -
> +#endif
>  #define cmpxchg_double(ptr, ...) \
>  ({ \
>  	typeof(ptr) __ai_ptr = (ptr); \
> @@ -1830,4 +1832,4 @@ atomic64_dec_if_positive(atomic64_t *v)
>  })
>  
>  #endif /* _ASM_GENERIC_ATOMIC_INSTRUMENTED_H */
> -// 4bec382e44520f4d8267e42620054db26a659ea3
> +// 21c7f7e074cb2cb7e2f593fe7c8f6dec6ab9e7ea
> diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
> index 370f01d..bb5cf1e 100644
> --- a/include/asm-generic/atomic64.h
> +++ b/include/asm-generic/atomic64.h
> @@ -34,6 +34,18 @@ extern s64 atomic64_fetch_##op(s64 a, atomic64_t *v);
>  ATOMIC64_OPS(add)
>  ATOMIC64_OPS(sub)
>  
> +#define atomic64_add_relaxed atomic64_add
> +#define atomic64_add_acquire atomic64_add
> +#define atomic64_add_release atomic64_add
> +
> +#define atomic64_add_return_relaxed atomic64_add_return
> +#define atomic64_add_return_acquire atomic64_add_return
> +#define atomic64_add_return_release atomic64_add_return
> +
> +#define atomic64_fetch_add_relaxed atomic64_fetch_add
> +#define atomic64_fetch_add_acquire atomic64_fetch_add
> +#define atomic64_fetch_add_release atomic64_fetch_add
> +
>  #undef ATOMIC64_OPS
>  #define ATOMIC64_OPS(op)	ATOMIC64_OP(op) ATOMIC64_FETCH_OP(op)
>  
> @@ -49,8 +61,85 @@ ATOMIC64_OPS(xor)
>  extern s64 atomic64_dec_if_positive(atomic64_t *v);
>  #define atomic64_dec_if_positive atomic64_dec_if_positive
>  extern s64 atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n);
> +#define atomic64_cmpxchg_relaxed atomic64_cmpxchg
> +#define atomic64_cmpxchg_acquire atomic64_cmpxchg
> +#define atomic64_cmpxchg_release atomic64_cmpxchg
>  extern s64 atomic64_xchg(atomic64_t *v, s64 new);
> +#define atomic64_xchg_relaxed atomic64_xchg
> +#define atomic64_xchg_acquire atomic64_xchg
> +#define atomic64_xchg_release atomic64_xchg
>  extern s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u);
>  #define atomic64_fetch_add_unless atomic64_fetch_add_unless
>  
> +static __always_inline void
> +atomic64_inc(atomic64_t *v)
> +{
> +	atomic64_add(1, v);
> +}
> +
> +static __always_inline s64
> +atomic64_inc_return(atomic64_t *v)
> +{
> +	return atomic64_add_return(1, v);
> +}
> +
> +static __always_inline s64
> +atomic64_fetch_inc(atomic64_t *v)
> +{
> +	return atomic64_fetch_add(1, v);
> +}
> +
> +static __always_inline void
> +atomic64_dec(atomic64_t *v)
> +{
> +	atomic64_sub(1, v);
> +}
> +
> +static __always_inline s64
> +atomic64_dec_return(atomic64_t *v)
> +{
> +	return atomic64_sub_return(1, v);
> +}
> +
> +static __always_inline s64
> +atomic64_fetch_dec(atomic64_t *v)
> +{
> +	return atomic64_fetch_sub(1, v);
> +}
> +
> +static __always_inline void
> +atomic64_andnot(s64 i, atomic64_t *v)
> +{
> +	atomic64_and(~i, v);
> +}
> +
> +static __always_inline s64
> +atomic64_fetch_andnot(s64 i, atomic64_t *v)
> +{
> +	return atomic64_fetch_and(~i, v);
> +}
> +
> +static __always_inline bool
> +atomic64_sub_and_test(int i, atomic64_t *v)
> +{
> +	return atomic64_sub_return(i, v) == 0;
> +}
> +
> +static __always_inline bool
> +atomic64_dec_and_test(atomic64_t *v)
> +{
> +	return atomic64_dec_return(v) == 0;
> +}
> +
> +static __always_inline bool
> +atomic64_inc_and_test(atomic64_t *v)
> +{
> +	return atomic64_inc_return(v) == 0;
> +}
> +
> +static __always_inline bool
> +atomic64_add_negative(s64 i, atomic64_t *v)
> +{
> +	return atomic64_add_return(i, v) < 0;
> +}
>  #endif  /*  _ASM_GENERIC_ATOMIC64_H  */
> diff --git a/include/linux/atomic-arch-fallback.h b/include/linux/atomic-arch-fallback.h
> index a3dba31..2f1db6a 100644
> --- a/include/linux/atomic-arch-fallback.h
> +++ b/include/linux/atomic-arch-fallback.h
> @@ -1252,7 +1252,7 @@ arch_atomic_dec_if_positive(atomic_t *v)
>  
>  #ifdef CONFIG_GENERIC_ATOMIC64
>  #include <asm-generic/atomic64.h>
> -#endif
> +#else
>  
>  #ifndef arch_atomic64_read_acquire
>  static __always_inline s64
> @@ -2357,5 +2357,6 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
>  #define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
>  #endif
>  
> +#endif /* CONFIG_GENERIC_ATOMIC64 */
>  #endif /* _LINUX_ATOMIC_FALLBACK_H */
> -// cca554917d7ea73d5e3e7397dd70c484cad9b2c4
> +// ae31a21075855e67a9b2927f8241dedddafda046
> diff --git a/include/linux/atomic-fallback.h b/include/linux/atomic-fallback.h
> index 2a3f55d..7dda483 100644
> --- a/include/linux/atomic-fallback.h
> +++ b/include/linux/atomic-fallback.h
> @@ -1369,7 +1369,7 @@ atomic_dec_if_positive(atomic_t *v)
>  
>  #ifdef CONFIG_GENERIC_ATOMIC64
>  #include <asm-generic/atomic64.h>
> -#endif
> +#else
>  
>  #define arch_atomic64_read atomic64_read
>  #define arch_atomic64_read_acquire atomic64_read_acquire
> @@ -2591,5 +2591,6 @@ atomic64_dec_if_positive(atomic64_t *v)
>  #define atomic64_dec_if_positive atomic64_dec_if_positive
>  #endif
>  
> +#endif /* CONFIG_GENERIC_ATOMIC64 */
>  #endif /* _LINUX_ATOMIC_FALLBACK_H */
> -// d78e6c293c661c15188f0ec05bce45188c8d5892
> +// b809c8e3c88910826f765bdba4a74f21c527029d
> diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
> index 317a6ce..8b7a685 100755
> --- a/scripts/atomic/gen-atomic-fallback.sh
> +++ b/scripts/atomic/gen-atomic-fallback.sh
> @@ -247,7 +247,7 @@ done
>  cat <<EOF
>  #ifdef CONFIG_GENERIC_ATOMIC64
>  #include <asm-generic/atomic64.h>
> -#endif
> +#else
>  
>  EOF
>  
> @@ -256,5 +256,6 @@ grep '^[a-z]' "$1" | while read name meta args; do
>  done
>  
>  cat <<EOF
> +#endif /* CONFIG_GENERIC_ATOMIC64 */
>  #endif /* _LINUX_ATOMIC_FALLBACK_H */
>  EOF
> diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
> index 5766ffc..1f2a58b 100755
> --- a/scripts/atomic/gen-atomic-instrumented.sh
> +++ b/scripts/atomic/gen-atomic-instrumented.sh
> @@ -182,21 +182,40 @@ grep '^[a-z]' "$1" | while read name meta args; do
>  	gen_proto "${meta}" "${name}" "atomic" "int" ${args}
>  done
>  
> +for xchg in "xchg" "cmpxchg" "try_cmpxchg"; do
> +	for order in "" "_acquire" "_release" "_relaxed"; do
> +		gen_optional_xchg "${xchg}" "${order}"
> +	done
> +done
> +
> +for xchg in "cmpxchg_local" "sync_cmpxchg"; do
> +	gen_xchg "${xchg}" ""
> +	printf "\n"
> +done
> +
> +cat <<EOF
> +#ifndef CONFIG_GENERIC_ATOMIC64
> +EOF
> +
>  grep '^[a-z]' "$1" | while read name meta args; do
>  	gen_proto "${meta}" "${name}" "atomic64" "s64" ${args}
>  done
>  
> -for xchg in "xchg" "cmpxchg" "cmpxchg64" "try_cmpxchg"; do
> +for xchg in "cmpxchg64"; do
>  	for order in "" "_acquire" "_release" "_relaxed"; do
>  		gen_optional_xchg "${xchg}" "${order}"
>  	done
>  done
>  
> -for xchg in "cmpxchg_local" "cmpxchg64_local" "sync_cmpxchg"; do
> +for xchg in "cmpxchg64_local"; do
>  	gen_xchg "${xchg}" ""
>  	printf "\n"
>  done
>  
> +cat <<EOF
> +#endif
> +EOF
> +
>  gen_xchg "cmpxchg_double" "2 * "
>  
>  printf "\n\n"
> -- 
> 2.7.4
> 
