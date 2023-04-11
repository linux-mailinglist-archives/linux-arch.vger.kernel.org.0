Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D2A6DD8F5
	for <lists+linux-arch@lfdr.de>; Tue, 11 Apr 2023 13:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjDKLKf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Apr 2023 07:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjDKLKe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Apr 2023 07:10:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17042E62;
        Tue, 11 Apr 2023 04:10:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D18F3D75;
        Tue, 11 Apr 2023 04:11:15 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.20.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90C313F6C4;
        Tue, 11 Apr 2023 04:10:29 -0700 (PDT)
Date:   Tue, 11 Apr 2023 12:10:22 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v2 1/5] locking/atomic: Add generic
 try_cmpxchg{,64}_local support
Message-ID: <ZDVAHkkbxJOlKFzi@FVFF77S0Q05N>
References: <20230405141710.3551-1-ubizjak@gmail.com>
 <20230405141710.3551-2-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405141710.3551-2-ubizjak@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 05, 2023 at 04:17:06PM +0200, Uros Bizjak wrote:
> Add generic support for try_cmpxchg{,64}_local and their falbacks.
> 
> These provides the generic try_cmpxchg_local family of functions
> from the arch_ prefixed version, also adding explicit instrumentation.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  include/linux/atomic/atomic-arch-fallback.h | 24 ++++++++++++++++++++-
>  include/linux/atomic/atomic-instrumented.h  | 20 ++++++++++++++++-
>  scripts/atomic/gen-atomic-fallback.sh       |  4 ++++
>  scripts/atomic/gen-atomic-instrumented.sh   |  2 +-
>  4 files changed, 47 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
> index 77bc5522e61c..36c92851cdee 100644
> --- a/include/linux/atomic/atomic-arch-fallback.h
> +++ b/include/linux/atomic/atomic-arch-fallback.h
> @@ -217,6 +217,28 @@
>  
>  #endif /* arch_try_cmpxchg64_relaxed */
>  
> +#ifndef arch_try_cmpxchg_local
> +#define arch_try_cmpxchg_local(_ptr, _oldp, _new) \
> +({ \
> +	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
> +	___r = arch_cmpxchg_local((_ptr), ___o, (_new)); \
> +	if (unlikely(___r != ___o)) \
> +		*___op = ___r; \
> +	likely(___r == ___o); \
> +})
> +#endif /* arch_try_cmpxchg_local */
> +
> +#ifndef arch_try_cmpxchg64_local
> +#define arch_try_cmpxchg64_local(_ptr, _oldp, _new) \
> +({ \
> +	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
> +	___r = arch_cmpxchg64_local((_ptr), ___o, (_new)); \
> +	if (unlikely(___r != ___o)) \
> +		*___op = ___r; \
> +	likely(___r == ___o); \
> +})
> +#endif /* arch_try_cmpxchg64_local */
> +
>  #ifndef arch_atomic_read_acquire
>  static __always_inline int
>  arch_atomic_read_acquire(const atomic_t *v)
> @@ -2456,4 +2478,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
>  #endif
>  
>  #endif /* _LINUX_ATOMIC_FALLBACK_H */
> -// b5e87bdd5ede61470c29f7a7e4de781af3770f09
> +// 1f49bd4895a4b7a5383906649027205c52ec80ab
> diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
> index 7a139ec030b0..14a9212cc987 100644
> --- a/include/linux/atomic/atomic-instrumented.h
> +++ b/include/linux/atomic/atomic-instrumented.h
> @@ -2066,6 +2066,24 @@ atomic_long_dec_if_positive(atomic_long_t *v)
>  	arch_sync_cmpxchg(__ai_ptr, __VA_ARGS__); \
>  })
>  
> +#define try_cmpxchg_local(ptr, oldp, ...) \
> +({ \
> +	typeof(ptr) __ai_ptr = (ptr); \
> +	typeof(oldp) __ai_oldp = (oldp); \
> +	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
> +	arch_try_cmpxchg_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
> +})
> +
> +#define try_cmpxchg64_local(ptr, oldp, ...) \
> +({ \
> +	typeof(ptr) __ai_ptr = (ptr); \
> +	typeof(oldp) __ai_oldp = (oldp); \
> +	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
> +	arch_try_cmpxchg64_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
> +})
> +
>  #define cmpxchg_double(ptr, ...) \
>  ({ \
>  	typeof(ptr) __ai_ptr = (ptr); \
> @@ -2083,4 +2101,4 @@ atomic_long_dec_if_positive(atomic_long_t *v)
>  })
>  
>  #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
> -// 764f741eb77a7ad565dc8d99ce2837d5542e8aee
> +// 456e206c7e4e681126c482e4edcc6f46921ac731
> diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
> index 3a07695e3c89..6e853f0dad8d 100755
> --- a/scripts/atomic/gen-atomic-fallback.sh
> +++ b/scripts/atomic/gen-atomic-fallback.sh
> @@ -225,6 +225,10 @@ for cmpxchg in "cmpxchg" "cmpxchg64"; do
>  	gen_try_cmpxchg_fallbacks "${cmpxchg}"
>  done
>  
> +for cmpxchg in "cmpxchg_local" "cmpxchg64_local"; do
> +	gen_try_cmpxchg_fallback "${cmpxchg}" ""
> +done
> +
>  grep '^[a-z]' "$1" | while read name meta args; do
>  	gen_proto "${meta}" "${name}" "atomic" "int" ${args}
>  done
> diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
> index 77c06526a574..c8165e9431bf 100755
> --- a/scripts/atomic/gen-atomic-instrumented.sh
> +++ b/scripts/atomic/gen-atomic-instrumented.sh
> @@ -173,7 +173,7 @@ for xchg in "xchg" "cmpxchg" "cmpxchg64" "try_cmpxchg" "try_cmpxchg64"; do
>  	done
>  done
>  
> -for xchg in "cmpxchg_local" "cmpxchg64_local" "sync_cmpxchg"; do
> +for xchg in "cmpxchg_local" "cmpxchg64_local" "sync_cmpxchg" "try_cmpxchg_local" "try_cmpxchg64_local" ; do
>  	gen_xchg "${xchg}" "" ""
>  	printf "\n"
>  done
> -- 
> 2.39.2
> 
