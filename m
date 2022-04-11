Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEBC4FB78F
	for <lists+linux-arch@lfdr.de>; Mon, 11 Apr 2022 11:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiDKJhT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Apr 2022 05:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237419AbiDKJhR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Apr 2022 05:37:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7050B12AB0;
        Mon, 11 Apr 2022 02:35:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 083BEED1;
        Mon, 11 Apr 2022 02:35:02 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.9.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A11483F793;
        Mon, 11 Apr 2022 02:35:00 -0700 (PDT)
Date:   Mon, 11 Apr 2022 10:34:52 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     guoren@kernel.org
Cc:     palmer@rivosinc.com, arnd@arndb.de, peterz@infradead.org,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH] riscv: Optimize AMO acquire/release usage
Message-ID: <YlP2PIPrUS89LuFR@FVFF77S0Q05N>
References: <20220406120405.660354-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220406120405.660354-1-guoren@kernel.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Guo,

On Wed, Apr 06, 2022 at 08:04:05PM +0800, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Using RISCV_ACQUIRE/RELEASE_BARRIER is over expensive for
> xchg/cmpxchg_acquire/release than nature instructions' .aq/rl.
> The patch fixed these issues under RISC-V Instruction Set Manual,
> Volume I: RISC-V User-Level ISA “A” Standard Extension for Atomic
> Instructions, Version 2.1.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> ---
>  arch/riscv/include/asm/atomic.h  | 70 ++++++++++++++++++++++++++++++--
>  arch/riscv/include/asm/cmpxchg.h | 30 +++++---------
>  2 files changed, 76 insertions(+), 24 deletions(-)

I'll leave the bulk of this to Palmer, but I spotted something below which
doesn't look right.

> @@ -315,12 +379,11 @@ static __always_inline int arch_atomic_sub_if_positive(atomic_t *v, int offset)
>         int prev, rc;
>  
>  	__asm__ __volatile__ (
> -		"0:	lr.w     %[p],  %[c]\n"
> +		"0:	lr.w.aq  %[p],  %[c]\n"
>  		"	sub      %[rc], %[p], %[o]\n"
>  		"	bltz     %[rc], 1f\n"
>  		"	sc.w.rl  %[rc], %[rc], %[c]\n"
>  		"	bnez     %[rc], 0b\n"
> -		"	fence    rw, rw\n"
>  		"1:\n"
>  		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
>  		: [o]"r" (offset)

I believe in this case the existing code here is correct, and this optimization
is broken.

I believe the existing code is using RELEASE + FULL-BARRIER to ensure full
ordering, since separate ACQUIRE+RELEASE cannot. For a description of the
problem, see the commit message for:

  8e86f0b409a44193 ("arm64: atomics: fix use of acquire + release for full barrier semantics")

The gist is that HW can re-order:

	ACCESS-A
	ACQUIRE
	RELEASE
	ACCESS-B

... to:

	ACQUIRE
	ACCESS-B
	ACCESS-A
	RELEASE

... violating FULL ordering semantics.

This will apply for *any* operation where FULL orderingis required, which I
suspect applies to some more cases below.

> @@ -337,12 +400,11 @@ static __always_inline s64 arch_atomic64_sub_if_positive(atomic64_t *v, s64 offs
>         long rc;
>  
>  	__asm__ __volatile__ (
> -		"0:	lr.d     %[p],  %[c]\n"
> +		"0:	lr.d.aq  %[p],  %[c]\n"
>  		"	sub      %[rc], %[p], %[o]\n"
>  		"	bltz     %[rc], 1f\n"
>  		"	sc.d.rl  %[rc], %[rc], %[c]\n"
>  		"	bnez     %[rc], 0b\n"
> -		"	fence    rw, rw\n"
>  		"1:\n"
>  		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
>  		: [o]"r" (offset)

My comment for arch_atomic_sub_if_positive() applies here too.


[...]

> @@ -309,11 +301,10 @@
>  	switch (size) {							\
>  	case 4:								\
>  		__asm__ __volatile__ (					\
> -			"0:	lr.w %0, %2\n"				\
> +			"0:	lr.w.aq %0, %2\n"			\
>  			"	bne  %0, %z3, 1f\n"			\
>  			"	sc.w.rl %1, %z4, %2\n"			\
>  			"	bnez %1, 0b\n"				\
> -			"	fence rw, rw\n"				\
>  			"1:\n"						\
>  			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
>  			: "rJ" ((long)__old), "rJ" (__new)		\
> @@ -321,11 +312,10 @@
>  		break;							\
>  	case 8:								\
>  		__asm__ __volatile__ (					\
> -			"0:	lr.d %0, %2\n"				\
> +			"0:	lr.d.aq %0, %2\n"			\
>  			"	bne %0, %z3, 1f\n"			\
>  			"	sc.d.rl %1, %z4, %2\n"			\
>  			"	bnez %1, 0b\n"				\
> -			"	fence rw, rw\n"				\
>  			"1:\n"						\
>  			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
>  			: "rJ" (__old), "rJ" (__new)			\

I don't have enough context to say for sure, but I suspect these are expecting
FULL ordering too, and would be broken, as above.

Thanks,
Mark.
