Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB2F55378
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2019 17:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfFYPdn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jun 2019 11:33:43 -0400
Received: from foss.arm.com ([217.140.110.172]:44174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbfFYPdn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Jun 2019 11:33:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AF882B;
        Tue, 25 Jun 2019 08:33:42 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 738EB3F718;
        Tue, 25 Jun 2019 08:33:39 -0700 (PDT)
Date:   Tue, 25 Jun 2019 16:33:37 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Huw Davies <huw@codeweavers.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Paul Burton <paul.burton@mips.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shijith Thotton <sthotton@marvell.com>,
        Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH v7 04/25] arm64: Substitute gettimeofday with C
 implementation
Message-ID: <20190625153336.GZ2790@e103592.cambridge.arm.com>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-5-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621095252.32307-5-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

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

[...]

> diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
> new file mode 100644
> index 000000000000..bc3cb6738051
> --- /dev/null
> +++ b/arch/arm64/include/asm/vdso/gettimeofday.h
> @@ -0,0 +1,86 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018 ARM Limited
> + */
> +#ifndef __ASM_VDSO_GETTIMEOFDAY_H
> +#define __ASM_VDSO_GETTIMEOFDAY_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <asm/unistd.h>
> +#include <uapi/linux/time.h>
> +
> +#define VDSO_HAS_CLOCK_GETRES		1
> +
> +static __always_inline int gettimeofday_fallback(
> +					struct __kernel_old_timeval *_tv,
> +					struct timezone *_tz)

Out of interest, does this need to be __always_inline?

> +{
> +	register struct timezone *tz asm("x1") = _tz;
> +	register struct __kernel_old_timeval *tv asm("x0") = _tv;
> +	register long ret asm ("x0");
> +	register long nr asm("x8") = __NR_gettimeofday;
> +
> +	asm volatile(
> +	"       svc #0\n"

Can inlining of this function result in non-trivial expressions being
substituted for _tz or _tv?

A function call can clobber register asm vars that are assigned to the
caller-save registers or that the PCS uses for function arguments, and
the situations where this can happen are poorly defined AFAICT.  There's
also no reliable way to detect at build time whether the compiler has
done this, and no robust way to stop if happening.

(IMHO the compiler is wrong to do this, but it's been that way for ever,
and I think I saw GCC 9 show this behaviour recently when I was
investigating something related.)


To be safe, it's better to put this out of line, or remove the reg asm()
specifiers, mark x0-x18 and lr as clobbered here (so that the compiler
doesn't map arguments to them), and put movs in the asm to move things
into the right registers.  The syscall number can be passed with an "i"
constraint.  (And yes, this sucks.)

If the code this is inlined in is simple enough though, we can be fairly
confident of getting away with it.

[...]

Cheers
---Dave
