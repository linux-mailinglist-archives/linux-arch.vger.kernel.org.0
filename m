Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531E46C7F96
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 15:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjCXONU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Mar 2023 10:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjCXONT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2023 10:13:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EEC930E4;
        Fri, 24 Mar 2023 07:13:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A1AF11FB;
        Fri, 24 Mar 2023 07:14:02 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.55.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 367B43F71E;
        Fri, 24 Mar 2023 07:13:16 -0700 (PDT)
Date:   Fri, 24 Mar 2023 14:13:13 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 01/10] locking/atomic: Add missing cast to try_cmpxchg()
 fallbacks
Message-ID: <ZB2v+avNt52ac/+w@FVFF77S0Q05N>
References: <20230305205628.27385-1-ubizjak@gmail.com>
 <20230305205628.27385-2-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230305205628.27385-2-ubizjak@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Mar 05, 2023 at 09:56:19PM +0100, Uros Bizjak wrote:
> Cast _oldp to the type of _ptr to avoid incompatible-pointer-types warning.

Can you give an example of where we are passing an incompatible pointer?

That sounds indicative of a bug in the caller, but maybe I'm missing some
reason this is necessary due to some indirection.

> Fixes: 29f006fdefe6 ("asm-generic/atomic: Add try_cmpxchg() fallbacks")

I'm not sure that this needs a fixes tag. Does anything go wrong today, or only
later in this series?

Thanks,
Mark.

> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---
>  include/linux/atomic/atomic-arch-fallback.h | 18 +++++++++---------
>  scripts/atomic/gen-atomic-fallback.sh       |  2 +-
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
> index 77bc5522e61c..19debd501ee7 100644
> --- a/include/linux/atomic/atomic-arch-fallback.h
> +++ b/include/linux/atomic/atomic-arch-fallback.h
> @@ -87,7 +87,7 @@
>  #ifndef arch_try_cmpxchg
>  #define arch_try_cmpxchg(_ptr, _oldp, _new) \
>  ({ \
> -	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
> +	typeof(*(_ptr)) *___op = (typeof(_ptr))(_oldp), ___o = *___op, ___r; \
>  	___r = arch_cmpxchg((_ptr), ___o, (_new)); \
>  	if (unlikely(___r != ___o)) \
>  		*___op = ___r; \
> @@ -98,7 +98,7 @@
>  #ifndef arch_try_cmpxchg_acquire
>  #define arch_try_cmpxchg_acquire(_ptr, _oldp, _new) \
>  ({ \
> -	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
> +	typeof(*(_ptr)) *___op = (typeof(_ptr))(_oldp), ___o = *___op, ___r; \
>  	___r = arch_cmpxchg_acquire((_ptr), ___o, (_new)); \
>  	if (unlikely(___r != ___o)) \
>  		*___op = ___r; \
> @@ -109,7 +109,7 @@
>  #ifndef arch_try_cmpxchg_release
>  #define arch_try_cmpxchg_release(_ptr, _oldp, _new) \
>  ({ \
> -	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
> +	typeof(*(_ptr)) *___op = (typeof(_ptr))(_oldp), ___o = *___op, ___r; \
>  	___r = arch_cmpxchg_release((_ptr), ___o, (_new)); \
>  	if (unlikely(___r != ___o)) \
>  		*___op = ___r; \
> @@ -120,7 +120,7 @@
>  #ifndef arch_try_cmpxchg_relaxed
>  #define arch_try_cmpxchg_relaxed(_ptr, _oldp, _new) \
>  ({ \
> -	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
> +	typeof(*(_ptr)) *___op = (typeof(_ptr))(_oldp), ___o = *___op, ___r; \
>  	___r = arch_cmpxchg_relaxed((_ptr), ___o, (_new)); \
>  	if (unlikely(___r != ___o)) \
>  		*___op = ___r; \
> @@ -157,7 +157,7 @@
>  #ifndef arch_try_cmpxchg64
>  #define arch_try_cmpxchg64(_ptr, _oldp, _new) \
>  ({ \
> -	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
> +	typeof(*(_ptr)) *___op = (typeof(_ptr))(_oldp), ___o = *___op, ___r; \
>  	___r = arch_cmpxchg64((_ptr), ___o, (_new)); \
>  	if (unlikely(___r != ___o)) \
>  		*___op = ___r; \
> @@ -168,7 +168,7 @@
>  #ifndef arch_try_cmpxchg64_acquire
>  #define arch_try_cmpxchg64_acquire(_ptr, _oldp, _new) \
>  ({ \
> -	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
> +	typeof(*(_ptr)) *___op = (typeof(_ptr))(_oldp), ___o = *___op, ___r; \
>  	___r = arch_cmpxchg64_acquire((_ptr), ___o, (_new)); \
>  	if (unlikely(___r != ___o)) \
>  		*___op = ___r; \
> @@ -179,7 +179,7 @@
>  #ifndef arch_try_cmpxchg64_release
>  #define arch_try_cmpxchg64_release(_ptr, _oldp, _new) \
>  ({ \
> -	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
> +	typeof(*(_ptr)) *___op = (typeof(_ptr))(_oldp), ___o = *___op, ___r; \
>  	___r = arch_cmpxchg64_release((_ptr), ___o, (_new)); \
>  	if (unlikely(___r != ___o)) \
>  		*___op = ___r; \
> @@ -190,7 +190,7 @@
>  #ifndef arch_try_cmpxchg64_relaxed
>  #define arch_try_cmpxchg64_relaxed(_ptr, _oldp, _new) \
>  ({ \
> -	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
> +	typeof(*(_ptr)) *___op = (typeof(_ptr))(_oldp), ___o = *___op, ___r; \
>  	___r = arch_cmpxchg64_relaxed((_ptr), ___o, (_new)); \
>  	if (unlikely(___r != ___o)) \
>  		*___op = ___r; \
> @@ -2456,4 +2456,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
>  #endif
>  
>  #endif /* _LINUX_ATOMIC_FALLBACK_H */
> -// b5e87bdd5ede61470c29f7a7e4de781af3770f09
> +// 1b4d4c82ae653389cd1538d5b07170267d9b3837
> diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
> index 3a07695e3c89..39f447161108 100755
> --- a/scripts/atomic/gen-atomic-fallback.sh
> +++ b/scripts/atomic/gen-atomic-fallback.sh
> @@ -171,7 +171,7 @@ cat <<EOF
>  #ifndef arch_try_${cmpxchg}${order}
>  #define arch_try_${cmpxchg}${order}(_ptr, _oldp, _new) \\
>  ({ \\
> -	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \\
> +	typeof(*(_ptr)) *___op = (typeof(_ptr))(_oldp), ___o = *___op, ___r; \\
>  	___r = arch_${cmpxchg}${order}((_ptr), ___o, (_new)); \\
>  	if (unlikely(___r != ___o)) \\
>  		*___op = ___r; \\
> -- 
> 2.39.2
> 
