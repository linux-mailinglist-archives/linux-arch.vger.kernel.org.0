Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3864FB7C8
	for <lists+linux-arch@lfdr.de>; Mon, 11 Apr 2022 11:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344589AbiDKJkJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Apr 2022 05:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344599AbiDKJkI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Apr 2022 05:40:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E099240921;
        Mon, 11 Apr 2022 02:37:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA5AE143D;
        Mon, 11 Apr 2022 02:37:53 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.9.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68CBA3F73B;
        Mon, 11 Apr 2022 02:37:52 -0700 (PDT)
Date:   Mon, 11 Apr 2022 10:37:48 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, peterz@infradead.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] csky: cmpxchg: Optimize with acquire & release
Message-ID: <YlP27GT05DdyFjlY@FVFF77S0Q05N>
References: <20220406124056.684117-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406124056.684117-1-guoren@kernel.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Guo,

On Wed, Apr 06, 2022 at 08:40:56PM +0800, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Optimize arch_xchg|cmpxchg|cmpxchg_local with  ASM acquire|release
> instructions instead of previous C based.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/csky/include/asm/barrier.h |   8 +-
>  arch/csky/include/asm/cmpxchg.h | 173 ++++++++++++++++++++++++++++++--
>  2 files changed, 172 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/csky/include/asm/barrier.h b/arch/csky/include/asm/barrier.h
> index f4045dd53e17..a075f17d02dd 100644
> --- a/arch/csky/include/asm/barrier.h
> +++ b/arch/csky/include/asm/barrier.h
> @@ -37,6 +37,9 @@
>   * bar.brar
>   * bar.bwaw
>   */
> +#define ACQUIRE_FENCE		".long 0x8427c000\n"
> +#define RELEASE_FENCE		".long 0x842ec000\n"

[...]

> +#define __xchg(new, ptr, size)					\
> +({								\
> +	__typeof__(ptr) __ptr = (ptr);				\
> +	__typeof__(new) __new = (new);				\
> +	__typeof__(*(ptr)) __ret;				\
> +	unsigned long tmp;					\
> +	switch (size) {						\
> +	case 4:							\
> +		asm volatile (					\
> +		"1:	ldex.w		%0, (%3) \n"		\
> +		ACQUIRE_FENCE					\
> +		"	mov		%1, %2   \n"		\
> +		RELEASE_FENCE					\
> +		"	stex.w		%1, (%3) \n"		\
> +		"	bez		%1, 1b   \n"		\
> +			: "=&r" (__ret), "=&r" (tmp)		\
> +			: "r" (__new), "r"(__ptr)		\
> +			:);					\

As with the riscv case, I believe this suffers the problem described in:

  8e86f0b409a44193 ("arm64: atomics: fix use of acquire + release for full barrier semantics")

... and does not provide FULL ordering semantics.

[...]

> +#define __cmpxchg(ptr, old, new, size)				\
> +({								\
> +	__typeof__(ptr) __ptr = (ptr);				\
> +	__typeof__(new) __new = (new);				\
> +	__typeof__(new) __tmp;					\
> +	__typeof__(old) __old = (old);				\
> +	__typeof__(*(ptr)) __ret;				\
> +	switch (size) {						\
> +	case 4:							\
> +		asm volatile (					\
> +		"1:	ldex.w		%0, (%3) \n"		\
> +		ACQUIRE_FENCE					\
> +		"	cmpne		%0, %4   \n"		\
> +		"	bt		2f       \n"		\
> +		"	mov		%1, %2   \n"		\
> +		RELEASE_FENCE					\
> +		"	stex.w		%1, (%3) \n"		\
> +		"	bez		%1, 1b   \n"		\
> +		"2:				 \n"		\
> +			: "=&r" (__ret), "=&r" (__tmp)		\
> +			: "r" (__new), "r"(__ptr), "r"(__old)	\
> +			:);					\

Likewise.

Thanks,
Mark.
