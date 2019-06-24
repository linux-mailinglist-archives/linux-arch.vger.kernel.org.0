Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E02D50C1B
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2019 15:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbfFXNgN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jun 2019 09:36:13 -0400
Received: from foss.arm.com ([217.140.110.172]:50588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbfFXNgN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Jun 2019 09:36:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D0E0344;
        Mon, 24 Jun 2019 06:36:12 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 859783F71E;
        Mon, 24 Jun 2019 06:36:09 -0700 (PDT)
Date:   Mon, 24 Jun 2019 14:36:07 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v7 04/25] arm64: Substitute gettimeofday with C
 implementation
Message-ID: <20190624133607.GI29497@fuggles.cambridge.arm.com>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-5-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621095252.32307-5-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Vincenzo,

On Fri, Jun 21, 2019 at 10:52:31AM +0100, Vincenzo Frascino wrote:
> To take advantage of the commonly defined vdso interface for
> gettimeofday the architectural code requires an adaptation.
> 
> Re-implement the gettimeofday vdso in C in order to use lib/vdso.
> 
> With the new implementation arm64 gains support for CLOCK_BOOTTIME
> and CLOCK_TAI.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Tested-by: Shijith Thotton <sthotton@marvell.com>
> Tested-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/Kconfig                         |   2 +
>  arch/arm64/include/asm/vdso/gettimeofday.h |  86 ++++++
>  arch/arm64/include/asm/vdso/vsyscall.h     |  53 ++++
>  arch/arm64/include/asm/vdso_datapage.h     |  48 ---
>  arch/arm64/kernel/asm-offsets.c            |  33 +-
>  arch/arm64/kernel/vdso.c                   |  51 +---
>  arch/arm64/kernel/vdso/Makefile            |  34 ++-
>  arch/arm64/kernel/vdso/gettimeofday.S      | 334 ---------------------
>  arch/arm64/kernel/vdso/vgettimeofday.c     |  28 ++

I'm concerned about an apparent semantic change introduced by your patch:

> +static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
> +{
> +	u64 res;
> +
> +	asm volatile("mrs %0, cntvct_el0" : "=r" (res) :: "memory");
> +
> +	return res;
> +}

vs:

> -	.macro	get_clock_shifted_nsec res, cycle_last, mult
> -	/* Read the virtual counter. */
> -	isb
> -	mrs	x_tmp, cntvct_el0
> -	/* Calculate cycle delta and convert to ns. */
> -	sub	\res, x_tmp, \cycle_last
> -	/* We can only guarantee 56 bits of precision. */
> -	movn	x_tmp, #0xff00, lsl #48
> -	and	\res, x_tmp, \res
> -	mul	\res, \res, \mult
> -	/*
> -	 * Fake address dependency from the value computed from the counter
> -	 * register to subsequent data page accesses so that the sequence
> -	 * locking also orders the read of the counter.
> -	 */
> -	and	x_tmp, \res, xzr
> -	add	vdso_data, vdso_data, x_tmp
> -	.endm

It looks like you're dropping both the preceding ISB (allowing the counter
value to be speculated) and also the subsequent dependency (allowing the
seq lock to be speculated). If I've missed them, apologies, but I couldn't
spot them elsewhere in this patch.

__arch_get_hw_counter should probably be identical to __arch_counter_get_cntvct
to avoid these problems. I guess we don't need to care about the case where
the counter is unstable, since we'll just disable the vDSO altogether on
such systems?

Will
