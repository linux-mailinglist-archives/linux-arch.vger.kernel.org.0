Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2AA689FB8
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 17:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbjBCQzg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 11:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjBCQzb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 11:55:31 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 285DE45F47;
        Fri,  3 Feb 2023 08:55:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EFDDC14;
        Fri,  3 Feb 2023 08:56:11 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.90.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 921893F71E;
        Fri,  3 Feb 2023 08:55:23 -0800 (PST)
Date:   Fri, 3 Feb 2023 16:55:20 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
        boqun.feng@gmail.com, catalin.marinas@arm.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 04/10] instrumentation: Wire up cmpxchg128()
Message-ID: <Y908eEiQI5plfGWc@FVFF77S0Q05N>
References: <20230202145030.223740842@infradead.org>
 <20230202152655.433050731@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202152655.433050731@infradead.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 02, 2023 at 03:50:34PM +0100, Peter Zijlstra wrote:
> Wire up the cmpxchg128 familty in the atomic wrappery scripts.

s/familty/family/ (and s/wrappery/wrapper/ ?)

> 
> These provide the generic cmpxchg128 family of functions from the
> arch_ prefixed version, adding explicit instrumentation where needed.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  include/linux/atomic/atomic-arch-fallback.h |   95 +++++++++++++++++++++++++++-
>  include/linux/atomic/atomic-instrumented.h  |   77 ++++++++++++++++++++++
>  scripts/atomic/gen-atomic-fallback.sh       |    4 -
>  scripts/atomic/gen-atomic-instrumented.sh   |    4 -
>  4 files changed, 174 insertions(+), 6 deletions(-)
> 
> --- a/include/linux/atomic/atomic-arch-fallback.h
> +++ b/include/linux/atomic/atomic-arch-fallback.h
> @@ -77,6 +77,29 @@
>  
>  #endif /* arch_cmpxchg64_relaxed */
>  
> +#ifndef arch_cmpxchg128_relaxed
> +#define arch_cmpxchg128_acquire arch_cmpxchg128
> +#define arch_cmpxchg128_release arch_cmpxchg128
> +#define arch_cmpxchg128_relaxed arch_cmpxchg128
> +#else /* arch_cmpxchg128_relaxed */
> +
> +#ifndef arch_cmpxchg128_acquire
> +#define arch_cmpxchg128_acquire(...) \
> +	__atomic_op_acquire(arch_cmpxchg128, __VA_ARGS__)
> +#endif
> +
> +#ifndef arch_cmpxchg128_release
> +#define arch_cmpxchg128_release(...) \
> +	__atomic_op_release(arch_cmpxchg128, __VA_ARGS__)
> +#endif
> +
> +#ifndef arch_cmpxchg128
> +#define arch_cmpxchg128(...) \
> +	__atomic_op_fence(arch_cmpxchg128, __VA_ARGS__)
> +#endif
> +
> +#endif /* arch_cmpxchg128_relaxed */
> +
>  #ifndef arch_try_cmpxchg_relaxed
>  #ifdef arch_try_cmpxchg
>  #define arch_try_cmpxchg_acquire arch_try_cmpxchg
> @@ -217,6 +240,76 @@
>  
>  #endif /* arch_try_cmpxchg64_relaxed */
>  
> +#ifndef arch_try_cmpxchg128_relaxed
> +#ifdef arch_try_cmpxchg128
> +#define arch_try_cmpxchg128_acquire arch_try_cmpxchg128
> +#define arch_try_cmpxchg128_release arch_try_cmpxchg128
> +#define arch_try_cmpxchg128_relaxed arch_try_cmpxchg128
> +#endif /* arch_try_cmpxchg128 */
> +
> +#ifndef arch_try_cmpxchg128
> +#define arch_try_cmpxchg128(_ptr, _oldp, _new) \
> +({ \
> +	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
> +	___r = arch_cmpxchg128((_ptr), ___o, (_new)); \
> +	if (unlikely(___r != ___o)) \
> +		*___op = ___r; \
> +	likely(___r == ___o); \
> +})
> +#endif /* arch_try_cmpxchg128 */
> +
> +#ifndef arch_try_cmpxchg128_acquire
> +#define arch_try_cmpxchg128_acquire(_ptr, _oldp, _new) \
> +({ \
> +	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
> +	___r = arch_cmpxchg128_acquire((_ptr), ___o, (_new)); \
> +	if (unlikely(___r != ___o)) \
> +		*___op = ___r; \
> +	likely(___r == ___o); \
> +})
> +#endif /* arch_try_cmpxchg128_acquire */
> +
> +#ifndef arch_try_cmpxchg128_release
> +#define arch_try_cmpxchg128_release(_ptr, _oldp, _new) \
> +({ \
> +	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
> +	___r = arch_cmpxchg128_release((_ptr), ___o, (_new)); \
> +	if (unlikely(___r != ___o)) \
> +		*___op = ___r; \
> +	likely(___r == ___o); \
> +})
> +#endif /* arch_try_cmpxchg128_release */
> +
> +#ifndef arch_try_cmpxchg128_relaxed
> +#define arch_try_cmpxchg128_relaxed(_ptr, _oldp, _new) \
> +({ \
> +	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
> +	___r = arch_cmpxchg128_relaxed((_ptr), ___o, (_new)); \
> +	if (unlikely(___r != ___o)) \
> +		*___op = ___r; \
> +	likely(___r == ___o); \
> +})
> +#endif /* arch_try_cmpxchg128_relaxed */
> +
> +#else /* arch_try_cmpxchg128_relaxed */
> +
> +#ifndef arch_try_cmpxchg128_acquire
> +#define arch_try_cmpxchg128_acquire(...) \
> +	__atomic_op_acquire(arch_try_cmpxchg128, __VA_ARGS__)
> +#endif
> +
> +#ifndef arch_try_cmpxchg128_release
> +#define arch_try_cmpxchg128_release(...) \
> +	__atomic_op_release(arch_try_cmpxchg128, __VA_ARGS__)
> +#endif
> +
> +#ifndef arch_try_cmpxchg128
> +#define arch_try_cmpxchg128(...) \
> +	__atomic_op_fence(arch_try_cmpxchg128, __VA_ARGS__)
> +#endif
> +
> +#endif /* arch_try_cmpxchg128_relaxed */
> +
>  #ifndef arch_atomic_read_acquire
>  static __always_inline int
>  arch_atomic_read_acquire(const atomic_t *v)
> @@ -2456,4 +2549,4 @@ arch_atomic64_dec_if_positive(atomic64_t
>  #endif
>  
>  #endif /* _LINUX_ATOMIC_FALLBACK_H */
> -// b5e87bdd5ede61470c29f7a7e4de781af3770f09
> +// 46357a526de89c762d30fb238f35a7d5950a670b
> --- a/include/linux/atomic/atomic-instrumented.h
> +++ b/include/linux/atomic/atomic-instrumented.h
> @@ -1968,6 +1968,36 @@ atomic_long_dec_if_positive(atomic_long_
>  	arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__); \
>  })
>  
> +#define cmpxchg128(ptr, ...) \
> +({ \
> +	typeof(ptr) __ai_ptr = (ptr); \
> +	kcsan_mb(); \
> +	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +	arch_cmpxchg128(__ai_ptr, __VA_ARGS__); \
> +})
> +
> +#define cmpxchg128_acquire(ptr, ...) \
> +({ \
> +	typeof(ptr) __ai_ptr = (ptr); \
> +	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +	arch_cmpxchg128_acquire(__ai_ptr, __VA_ARGS__); \
> +})
> +
> +#define cmpxchg128_release(ptr, ...) \
> +({ \
> +	typeof(ptr) __ai_ptr = (ptr); \
> +	kcsan_release(); \
> +	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +	arch_cmpxchg128_release(__ai_ptr, __VA_ARGS__); \
> +})
> +
> +#define cmpxchg128_relaxed(ptr, ...) \
> +({ \
> +	typeof(ptr) __ai_ptr = (ptr); \
> +	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +	arch_cmpxchg128_relaxed(__ai_ptr, __VA_ARGS__); \
> +})
> +
>  #define try_cmpxchg(ptr, oldp, ...) \
>  ({ \
>  	typeof(ptr) __ai_ptr = (ptr); \
> @@ -2044,6 +2074,44 @@ atomic_long_dec_if_positive(atomic_long_
>  	arch_try_cmpxchg64_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>  })
>  
> +#define try_cmpxchg128(ptr, oldp, ...) \
> +({ \
> +	typeof(ptr) __ai_ptr = (ptr); \
> +	typeof(oldp) __ai_oldp = (oldp); \
> +	kcsan_mb(); \
> +	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
> +	arch_try_cmpxchg128(__ai_ptr, __ai_oldp, __VA_ARGS__); \
> +})
> +
> +#define try_cmpxchg128_acquire(ptr, oldp, ...) \
> +({ \
> +	typeof(ptr) __ai_ptr = (ptr); \
> +	typeof(oldp) __ai_oldp = (oldp); \
> +	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
> +	arch_try_cmpxchg128_acquire(__ai_ptr, __ai_oldp, __VA_ARGS__); \
> +})
> +
> +#define try_cmpxchg128_release(ptr, oldp, ...) \
> +({ \
> +	typeof(ptr) __ai_ptr = (ptr); \
> +	typeof(oldp) __ai_oldp = (oldp); \
> +	kcsan_release(); \
> +	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
> +	arch_try_cmpxchg128_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
> +})
> +
> +#define try_cmpxchg128_relaxed(ptr, oldp, ...) \
> +({ \
> +	typeof(ptr) __ai_ptr = (ptr); \
> +	typeof(oldp) __ai_oldp = (oldp); \
> +	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
> +	arch_try_cmpxchg128_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
> +})
> +
>  #define cmpxchg_local(ptr, ...) \
>  ({ \
>  	typeof(ptr) __ai_ptr = (ptr); \
> @@ -2058,6 +2126,13 @@ atomic_long_dec_if_positive(atomic_long_
>  	arch_cmpxchg64_local(__ai_ptr, __VA_ARGS__); \
>  })
>  
> +#define cmpxchg128_local(ptr, ...) \
> +({ \
> +	typeof(ptr) __ai_ptr = (ptr); \
> +	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +	arch_cmpxchg128_local(__ai_ptr, __VA_ARGS__); \
> +})
> +
>  #define sync_cmpxchg(ptr, ...) \
>  ({ \
>  	typeof(ptr) __ai_ptr = (ptr); \
> @@ -2083,4 +2158,4 @@ atomic_long_dec_if_positive(atomic_long_
>  })
>  
>  #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
> -// 764f741eb77a7ad565dc8d99ce2837d5542e8aee
> +// 27320c1ec2bf2878ecb9df3ea4816a7bc0c57a52
> --- a/scripts/atomic/gen-atomic-fallback.sh
> +++ b/scripts/atomic/gen-atomic-fallback.sh
> @@ -217,11 +217,11 @@ cat << EOF
>  
>  EOF
>  
> -for xchg in "arch_xchg" "arch_cmpxchg" "arch_cmpxchg64"; do
> +for xchg in "arch_xchg" "arch_cmpxchg" "arch_cmpxchg64" "arch_cmpxchg128"; do
>  	gen_xchg_fallbacks "${xchg}"
>  done
>  
> -for cmpxchg in "cmpxchg" "cmpxchg64"; do
> +for cmpxchg in "cmpxchg" "cmpxchg64" "cmpxchg128"; do
>  	gen_try_cmpxchg_fallbacks "${cmpxchg}"
>  done
>  
> --- a/scripts/atomic/gen-atomic-instrumented.sh
> +++ b/scripts/atomic/gen-atomic-instrumented.sh
> @@ -166,14 +166,14 @@ grep '^[a-z]' "$1" | while read name met
>  done
>  
>  
> -for xchg in "xchg" "cmpxchg" "cmpxchg64" "try_cmpxchg" "try_cmpxchg64"; do
> +for xchg in "xchg" "cmpxchg" "cmpxchg64" "cmpxchg128" "try_cmpxchg" "try_cmpxchg64" "try_cmpxchg128"; do
>  	for order in "" "_acquire" "_release" "_relaxed"; do
>  		gen_xchg "${xchg}" "${order}" ""
>  		printf "\n"
>  	done
>  done
>  
> -for xchg in "cmpxchg_local" "cmpxchg64_local" "sync_cmpxchg"; do
> +for xchg in "cmpxchg_local" "cmpxchg64_local" "cmpxchg128_local" "sync_cmpxchg"; do
>  	gen_xchg "${xchg}" "" ""
>  	printf "\n"
>  done
> 
> 
