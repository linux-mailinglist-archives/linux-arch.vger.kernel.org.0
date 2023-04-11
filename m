Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202726DD947
	for <lists+linux-arch@lfdr.de>; Tue, 11 Apr 2023 13:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjDKLV5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Apr 2023 07:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjDKLV4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Apr 2023 07:21:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 332D730DC;
        Tue, 11 Apr 2023 04:21:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 587DED75;
        Tue, 11 Apr 2023 04:14:10 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.20.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57B213F6C4;
        Tue, 11 Apr 2023 04:13:24 -0700 (PDT)
Date:   Tue, 11 Apr 2023 12:13:21 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/5] locking/generic: Wire up local{,64}_try_cmpxchg
Message-ID: <ZDVA0a6QHaONg8AL@FVFF77S0Q05N>
References: <20230405141710.3551-1-ubizjak@gmail.com>
 <20230405141710.3551-3-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405141710.3551-3-ubizjak@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 05, 2023 at 04:17:07PM +0200, Uros Bizjak wrote:
> Implement generic support for local{,64}_try_cmpxchg.
> 
> Redirect to the atomic_ family of functions when the target
> does not provide its own local.h definitions.
> 
> For 64-bit targets, implement local64_try_cmpxchg and
> local64_cmpxchg using typed C wrappers that call local_
> family of functions and provide additional checking
> of their input arguments.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  include/asm-generic/local.h   |  1 +
>  include/asm-generic/local64.h | 12 +++++++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/local.h b/include/asm-generic/local.h
> index fca7f1d84818..7f97018df66f 100644
> --- a/include/asm-generic/local.h
> +++ b/include/asm-generic/local.h
> @@ -42,6 +42,7 @@ typedef struct
>  #define local_inc_return(l) atomic_long_inc_return(&(l)->a)
>  
>  #define local_cmpxchg(l, o, n) atomic_long_cmpxchg((&(l)->a), (o), (n))
> +#define local_try_cmpxchg(l, po, n) atomic_long_try_cmpxchg((&(l)->a), (po), (n))
>  #define local_xchg(l, n) atomic_long_xchg((&(l)->a), (n))
>  #define local_add_unless(l, _a, u) atomic_long_add_unless((&(l)->a), (_a), (u))
>  #define local_inc_not_zero(l) atomic_long_inc_not_zero(&(l)->a)
> diff --git a/include/asm-generic/local64.h b/include/asm-generic/local64.h
> index 765be0b7d883..14963a7a6253 100644
> --- a/include/asm-generic/local64.h
> +++ b/include/asm-generic/local64.h
> @@ -42,7 +42,16 @@ typedef struct {
>  #define local64_sub_return(i, l) local_sub_return((i), (&(l)->a))
>  #define local64_inc_return(l)	local_inc_return(&(l)->a)
>  
> -#define local64_cmpxchg(l, o, n) local_cmpxchg((&(l)->a), (o), (n))
> +static inline s64 local64_cmpxchg(local64_t *l, s64 old, s64 new)
> +{
> +	return local_cmpxchg(&l->a, old, new);
> +}
> +
> +static inline bool local64_try_cmpxchg(local64_t *l, s64 *old, s64 new)
> +{
> +	return local_try_cmpxchg(&l->a, (long *)old, new);
> +}
> +
>  #define local64_xchg(l, n)	local_xchg((&(l)->a), (n))
>  #define local64_add_unless(l, _a, u) local_add_unless((&(l)->a), (_a), (u))
>  #define local64_inc_not_zero(l)	local_inc_not_zero(&(l)->a)
> @@ -81,6 +90,7 @@ typedef struct {
>  #define local64_inc_return(l)	atomic64_inc_return(&(l)->a)
>  
>  #define local64_cmpxchg(l, o, n) atomic64_cmpxchg((&(l)->a), (o), (n))
> +#define local64_try_cmpxchg(l, po, n) atomic64_try_cmpxchg((&(l)->a), (po), (n))
>  #define local64_xchg(l, n)	atomic64_xchg((&(l)->a), (n))
>  #define local64_add_unless(l, _a, u) atomic64_add_unless((&(l)->a), (_a), (u))
>  #define local64_inc_not_zero(l)	atomic64_inc_not_zero(&(l)->a)
> -- 
> 2.39.2
> 
