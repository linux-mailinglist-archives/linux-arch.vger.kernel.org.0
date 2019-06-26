Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11E5956E7A
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2019 18:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfFZQOW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Jun 2019 12:14:22 -0400
Received: from foss.arm.com ([217.140.110.172]:36380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfFZQOW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Jun 2019 12:14:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6476C2B;
        Wed, 26 Jun 2019 09:14:21 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B27B73F706;
        Wed, 26 Jun 2019 09:14:18 -0700 (PDT)
Date:   Wed, 26 Jun 2019 17:14:16 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, Shijith Thotton <sthotton@marvell.com>,
        Peter Collingbourne <pcc@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Huw Davies <huw@codeweavers.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 04/25] arm64: Substitute gettimeofday with C
 implementation
Message-ID: <20190626161413.GA2790@e103592.cambridge.arm.com>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-5-vincenzo.frascino@arm.com>
 <20190625153336.GZ2790@e103592.cambridge.arm.com>
 <f5ac379a-731d-0662-2f5b-bd046e3bd1c5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5ac379a-731d-0662-2f5b-bd046e3bd1c5@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 26, 2019 at 02:27:59PM +0100, Vincenzo Frascino wrote:
> Hi Dave,
> 
> On 25/06/2019 16:33, Dave Martin wrote:
> > On Fri, Jun 21, 2019 at 10:52:31AM +0100, Vincenzo Frascino wrote:
> >> To take advantage of the commonly defined vdso interface for
> >> gettimeofday the architectural code requires an adaptation.
> >>
> >> Re-implement the gettimeofday vdso in C in order to use lib/vdso.
> >>
> >> With the new implementation arm64 gains support for CLOCK_BOOTTIME
> >> and CLOCK_TAI.
> >>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will.deacon@arm.com>
> >> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> >> Tested-by: Shijith Thotton <sthotton@marvell.com>
> >> Tested-by: Andre Przywara <andre.przywara@arm.com>
> > 
> > [...]
> > 
> >> diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
> >> new file mode 100644
> >> index 000000000000..bc3cb6738051
> >> --- /dev/null
> >> +++ b/arch/arm64/include/asm/vdso/gettimeofday.h
> >> @@ -0,0 +1,86 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * Copyright (C) 2018 ARM Limited
> >> + */
> >> +#ifndef __ASM_VDSO_GETTIMEOFDAY_H
> >> +#define __ASM_VDSO_GETTIMEOFDAY_H
> >> +
> >> +#ifndef __ASSEMBLY__
> >> +
> >> +#include <asm/unistd.h>
> >> +#include <uapi/linux/time.h>
> >> +
> >> +#define VDSO_HAS_CLOCK_GETRES		1
> >> +
> >> +static __always_inline int gettimeofday_fallback(
> >> +					struct __kernel_old_timeval *_tv,
> >> +					struct timezone *_tz)
> > 
> > Out of interest, does this need to be __always_inline?
> > 
> 
> It is a design choice. Philosophically, I prefer to control and reduce the scope
> of the decisions the compiler has to make in order to not have surprises.
> 
> >> +{
> >> +	register struct timezone *tz asm("x1") = _tz;
> >> +	register struct __kernel_old_timeval *tv asm("x0") = _tv;
> >> +	register long ret asm ("x0");
> >> +	register long nr asm("x8") = __NR_gettimeofday;
> >> +
> >> +	asm volatile(
> >> +	"       svc #0\n"
> > 
> > Can inlining of this function result in non-trivial expressions being
> > substituted for _tz or _tv?
> > 
> > A function call can clobber register asm vars that are assigned to the
> > caller-save registers or that the PCS uses for function arguments, and
> > the situations where this can happen are poorly defined AFAICT.  There's
> > also no reliable way to detect at build time whether the compiler has
> > done this, and no robust way to stop if happening.
> > 
> > (IMHO the compiler is wrong to do this, but it's been that way for ever,
> > and I think I saw GCC 9 show this behaviour recently when I was
> > investigating something related.)
> > 
> > 
> > To be safe, it's better to put this out of line, or remove the reg asm()
> > specifiers, mark x0-x18 and lr as clobbered here (so that the compiler
> > doesn't map arguments to them), and put movs in the asm to move things
> > into the right registers.  The syscall number can be passed with an "i"
> > constraint.  (And yes, this sucks.)
> > 
> > If the code this is inlined in is simple enough though, we can be fairly
> > confident of getting away with it.
> >
> 
> I took very seriously what you are mentioning here because I think
> that robustness of the code comes before than everything especially
> in the kernel and I carried on some experiments to try to verify if
> in this case is safe to assume that the compiler is doing the right
> thing.
> 
> Based on my investigation and on previous observations of the
> generation of the vDSO library, I can conclude that the approach
> seems safe due to the fact that the usage of this code is very
> limited, the code itself is simple enough and that gcc would inline
> this code anyway based on the current compilation options.

I'd caution about "seems safe".  A lot of subtly wrong code not only
seems safe, but _is_ safe in its original context, in practice.  Add
some code to the vdso over time though, or tweak the compilation options
at some point in the future, or use a different compiler, and things
could still go wrong.

(Further comments below.)

> The experiment that I did was to define some self-contained code that
> tries to mimic what you are describing and compile it with 3
> different versions of gcc (6.4, 8.1 and 8.3) and in all the tree
> cases the behavior seems correct.
> 
> Code:
> =====
> 
> typedef int ssize_t;
> typedef int size_t;
> 
> static int my_strlen(const char *s)
> {
> 	int i = 0;
> 
> 	while (s[i] == '\0')
> 		i++;
> 
> 	return i;
> }
> 
> static inline ssize_t my_syscall(int fd, const void *buf, size_t count)
> {
> 	register ssize_t arg1 asm ("x0") = fd;
> 	register const void *arg2 asm ("x1") = buf;
> 	register size_t arg3 asm ("x2") = count;
> 
> 	__asm__ volatile (
> 		"mov x8, #64\n"
> 		"svc #0\n"
> 		: "=&r" (arg1)
> 		: "r" (arg2), "r" (arg3)
> 		: "x8"
>         );
> 
>         return arg1;
> }
> 
> void sys_caller(const char *s)
> {
> 	my_syscall(1, s, my_strlen(s));
> }
> 
> 
> GCC 8.3.0:
> ==========
> 
> main.8.3.0.o:     file format elf64-littleaarch64
> 
> 
> Disassembly of section .text:
> 
> 0000000000000000 <sys_caller>:
>    0:	39400001 	ldrb	w1, [x0]
>    4:	35000161 	cbnz	w1, 30 <sys_caller+0x30>
>    8:	d2800023 	mov	x3, #0x1                   	// #1
>    c:	d1000404 	sub	x4, x0, #0x1
>   10:	2a0303e2 	mov	w2, w3
>   14:	91000463 	add	x3, x3, #0x1
>   18:	38636881 	ldrb	w1, [x4, x3]
>   1c:	34ffffa1 	cbz	w1, 10 <sys_caller+0x10>
>   20:	aa0003e1 	mov	x1, x0
>   24:	d2800808 	mov	x8, #0x40                  	// #64
>   28:	d4000001 	svc	#0x0
>   2c:	d65f03c0 	ret
>   30:	52800002 	mov	w2, #0x0                   	// #0
>   34:	17fffffb 	b	20 <sys_caller+0x20>
> 
> 
> GCC 8.1.0:
> ==========
> 
> main.8.1.0.o:     file format elf64-littleaarch64
> 
> 
> Disassembly of section .text:
> 
> 0000000000000000 <sys_caller>:
>    0:	39400001 	ldrb	w1, [x0]
>    4:	35000161 	cbnz	w1, 30 <sys_caller+0x30>
>    8:	d2800023 	mov	x3, #0x1                   	// #1
>    c:	d1000404 	sub	x4, x0, #0x1
>   10:	2a0303e2 	mov	w2, w3
>   14:	91000463 	add	x3, x3, #0x1
>   18:	38636881 	ldrb	w1, [x4, x3]
>   1c:	34ffffa1 	cbz	w1, 10 <sys_caller+0x10>
>   20:	aa0003e1 	mov	x1, x0
>   24:	d2800808 	mov	x8, #0x40                  	// #64
>   28:	d4000001 	svc	#0x0
>   2c:	d65f03c0 	ret
>   30:	52800002 	mov	w2, #0x0                   	// #0
>   34:	17fffffb 	b	20 <sys_caller+0x20>
> 
> 
> 
> GCC 6.4.0:
> ==========
> 
> main.6.4.0.o:     file format elf64-littleaarch64
> 
> 
> Disassembly of section .text:
> 
> 0000000000000000 <sys_caller>:
>    0:	39400001 	ldrb	w1, [x0]
>    4:	35000161 	cbnz	w1, 30 <sys_caller+0x30>
>    8:	d2800023 	mov	x3, #0x1                   	// #1
>    c:	d1000404 	sub	x4, x0, #0x1
>   10:	2a0303e2 	mov	w2, w3
>   14:	91000463 	add	x3, x3, #0x1
>   18:	38636881 	ldrb	w1, [x4, x3]
>   1c:	34ffffa1 	cbz	w1, 10 <sys_caller+0x10>
>   20:	aa0003e1 	mov	x1, x0
>   24:	d2800808 	mov	x8, #0x40                  	// #64
>   28:	d4000001 	svc	#0x0
>   2c:	d65f03c0 	ret
>   30:	52800002 	mov	w2, #0x0                   	// #0
>   34:	17fffffb 	b	20 <sys_caller+0x20>

Thanks for having a go at this.  If the compiler can show the
problematic behaviour, it looks like your could could probably trigger
it, and as you observe, it doesn't trigger.

I am sure I have seen it in the past, but today I am struggling
to tickle the compiler in the right way.  My original reproducer may
have involved LTO, but either way I don't still have it :(


The classic example of this (triggered directly and not due to inlining)
would be something like:

int bar(int, int);

void foo(int x, int y)
{
	register int x_ asm("r0") = x;
	register int y_ asm("r1") = bar(x, y);

	asm volatile (
		"svc	#0"
		:: "r" (x_), "r" (y_)
		: "memory"
	);
}

->

0000000000000000 <foo>:
   0:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
   4:   910003fd        mov     x29, sp
   8:   94000000        bl      0 <bar>
   c:   2a0003e1        mov     w1, w0
  10:   d4000001        svc     #0x0
  14:   a8c17bfd        ldp     x29, x30, [sp], #16
  18:   d65f03c0        ret


The gcc documentation is vague and ambiguous about precisely whan this
can happen and about how to avoid it.

The case where this behaviour is triggered by inlining an expression
that involves a (possibly implicit) function call seems hard to
reproduce.


However, the workaround is cheap, and to avoid the chance of subtle
intermittent code gen bugs it may be worth it:

void foo(int x, int y)
{
	asm volatile (
		"mov	x0, %0\n\t"
		"mov	x1, %1\n\t"
		"svc	#0"
		:: "r" (x), "r" (bar(x, y))
		: "r0", "r1", "memory"
	);
}

->

0000000000000000 <foo>:
   0:   a9be7bfd        stp     x29, x30, [sp, #-32]!
   4:   910003fd        mov     x29, sp
   8:   f9000bf3        str     x19, [sp, #16]
   c:   2a0003f3        mov     w19, w0
  10:   94000000        bl      0 <bar>
  14:   2a0003e2        mov     w2, w0
  18:   aa1303e0        mov     x0, x19
  1c:   aa0203e1        mov     x1, x2
  20:   d4000001        svc     #0x0
  24:   f9400bf3        ldr     x19, [sp, #16]
  28:   a8c27bfd        ldp     x29, x30, [sp], #32
  2c:   d65f03c0        ret


What do you think?

Cheers
---Dave
