Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBB223CCD2
	for <lists+linux-arch@lfdr.de>; Wed,  5 Aug 2020 19:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgHERFP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Aug 2020 13:05:15 -0400
Received: from gate.crashing.org ([63.228.1.57]:52287 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728422AbgHERCf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 Aug 2020 13:02:35 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 075E392I022366;
        Wed, 5 Aug 2020 09:03:09 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 075E37YK022365;
        Wed, 5 Aug 2020 09:03:07 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 5 Aug 2020 09:03:07 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, nathanl@linux.ibm.com,
        anton@ozlabs.org, linux-arch@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        vincenzo.frascino@arm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v10 2/5] powerpc/vdso: Prepare for switching VDSO to generic C implementation.
Message-ID: <20200805140307.GO6753@gate.crashing.org>
References: <cover.1596611196.git.christophe.leroy@csgroup.eu> <348528c33cd4007f3fee7fe643ef160843d09a6c.1596611196.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <348528c33cd4007f3fee7fe643ef160843d09a6c.1596611196.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!

On Wed, Aug 05, 2020 at 07:09:23AM +0000, Christophe Leroy wrote:
> Provide vdso_shift_ns(), as the generic x >> s gives the following
> bad result:
> 
>   18:	35 25 ff e0 	addic.  r9,r5,-32
>   1c:	41 80 00 10 	blt     2c <shift+0x14>
>   20:	7c 64 4c 30 	srw     r4,r3,r9
>   24:	38 60 00 00 	li      r3,0
> ...
>   2c:	54 69 08 3c 	rlwinm  r9,r3,1,0,30
>   30:	21 45 00 1f 	subfic  r10,r5,31
>   34:	7c 84 2c 30 	srw     r4,r4,r5
>   38:	7d 29 50 30 	slw     r9,r9,r10
>   3c:	7c 63 2c 30 	srw     r3,r3,r5
>   40:	7d 24 23 78 	or      r4,r9,r4
> 
> In our case the shift is always <= 32. In addition,  the upper 32 bits
> of the result are likely nul. Lets GCC know it, it also optimises the
> following calculations.
> 
> With the patch, we get:
>    0:	21 25 00 20 	subfic  r9,r5,32
>    4:	7c 69 48 30 	slw     r9,r3,r9
>    8:	7c 84 2c 30 	srw     r4,r4,r5
>    c:	7d 24 23 78 	or      r4,r9,r4
>   10:	7c 63 2c 30 	srw     r3,r3,r5

See below.  Such code is valid on PowerPC for all shift < 64, and a
future version of GCC will do that (it is on various TODO lists, it is
bound to happen *some* day ;-), but it won't help you yet of course).


> +/*
> + * The macros sets two stack frames, one for the caller and one for the callee
> + * because there are no requirement for the caller to set a stack frame when
> + * calling VDSO so it may have omitted to set one, especially on PPC64
> + */

If the caller follows the ABI, there always is a stack frame.  So what
is going on?


> +/*
> + * powerpc specific delta calculation.
> + *
> + * This variant removes the masking of the subtraction because the
> + * clocksource mask of all VDSO capable clocksources on powerpc is U64_MAX
> + * which would result in a pointless operation. The compiler cannot
> + * optimize it away as the mask comes from the vdso data and is not compile
> + * time constant.
> + */

It cannot optimise it because it does not know shift < 32.  The code
below is incorrect for shift equal to 32, fwiw.

> +static __always_inline u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
> +{
> +	return (cycles - last) * mult;
> +}
> +#define vdso_calc_delta vdso_calc_delta
> +
> +#ifndef __powerpc64__
> +static __always_inline u64 vdso_shift_ns(u64 ns, unsigned long shift)
> +{
> +	u32 hi = ns >> 32;
> +	u32 lo = ns;
> +
> +	lo >>= shift;
> +	lo |= hi << (32 - shift);
> +	hi >>= shift;


> +	if (likely(hi == 0))
> +		return lo;

Removing these two lines shouldn't change generated object code?  Or not
make it worse, at least.

> +	return ((u64)hi << 32) | lo;
> +}


What does the compiler do for just

static __always_inline u64 vdso_shift_ns(u64 ns, unsigned long shift)
	return ns >> (shift & 31);
}

?


Segher
