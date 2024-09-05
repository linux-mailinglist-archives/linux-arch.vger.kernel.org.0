Return-Path: <linux-arch+bounces-7077-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888D496DF24
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 18:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60FD1C22B6C
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 16:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FF619E7E3;
	Thu,  5 Sep 2024 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mfMITQ4I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hYkqe2ZO"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ABD4AEF5;
	Thu,  5 Sep 2024 16:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552429; cv=none; b=J5aqqDRfcJJjvjn1fqwuWlIi9aT7WVXWuUc7ojNeifLJ4dWMIQdQYbYHrQvC8CyEsxVsi4g1K8gxbigHbSSQl8qQh17U9Pq1nIqsM7/XIzzzuPyilxLPFH0FmghmvPtKrIsPwGaPkyO4RUILIi34xfsPp6FMhJsOS3amtb23j+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552429; c=relaxed/simple;
	bh=FKIUe6ROyuAZld3RYI0wuZyQp2WcS/MahutfvjYVD0E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WPJB8XuVFrHD4AaduOeINLn4RIJO9gszNy6GH5EMZp3AdjUybZ2yp6Xn2rkKxUB5MU2xYavYI/M25+F8GPvFwPpc9YEaGeE8iFzSjUegXQyl/N++HBJ3jdC0HVd381Rq29NBbVc5b8mcuWIK1ZuUCVt+XDXfLHsbEEmcs93GPlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mfMITQ4I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hYkqe2ZO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725552425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YuosW2xFF76k7znp1kriu5k7tuP1jiOYxwAXWSFhr/o=;
	b=mfMITQ4IBwTILBRT0F9TI/4949JTWFcoAs++N6lHvZRa2y/gU5HkEWz03DFLIEBbzdIgmJ
	Q9cbJriLyC4W38x9UPsDQWO12FYquHQecON4fMUFZjaFHq/sXj+7OQZeMD7UK7Msfg/McY
	2Pr29fJrCC2WYOjaOE3bBzuosArbnsFqHo9hxt8tyQkreAlXKzmhicIdt92akr1O33GChF
	PfJ1fPF+PXNFWhGyloAzVw9jgMiwgLeEJqqwhI5beflCgGth+Qa7aG1xLy5CNdNVg8JP6D
	oDoD/r7d3AcOro/guMDS4bsROAImXWAuyHZCkvhofxuIcH+qY6oEh+8QALSASw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725552425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YuosW2xFF76k7znp1kriu5k7tuP1jiOYxwAXWSFhr/o=;
	b=hYkqe2ZOxrmNgnVw7vGgRZCA8CkgeE+CwmAzDMNGqyDGVczKVSRC8AtALhBBefCt0PuLr4
	247bjHqKckJHfyDw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Andrew Morton <akpm@linuxfoundation.org>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>
Subject: Re: [PATCH 06/15] timers: Update function descriptions of
 sleep/delay related functions
In-Reply-To: <87frqe60xj.ffs@tglx>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
 <20240904-devel-anna-maria-b4-timers-flseep-v1-6-e98760256370@linutronix.de>
 <87frqe60xj.ffs@tglx>
Date: Thu, 05 Sep 2024 18:07:04 +0200
Message-ID: <8734me5bkn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 05 2024 at 08:59, Thomas Gleixner wrote:
> On Wed, Sep 04 2024 at 15:04, Anna-Maria Behnsen wrote:
> However, instead of proliferating this voodoo can we please convert it
> into something comprehensible?
>
> /*
>  * The microseconds delay multiplicator is used to convert a constant
>  * microseconds value to a <INSERT COHERENT EXPLANATION>.
>  */
> #define UDELAY_CONST_MULT  ((unsigned long)DIV_ROUND_UP(1ULL << 32, USEC_PER_SEC))
>
> /*
>  * The maximum constant udelay value picked out of thin air
>  * to avoid <INSERT COHERENT EXPLANATION>.
>  */
> #define UDELAY_CONST_MAX   20000
>
> /**
>  * udelay - .....
>  */
> static __always_inline void udelay(unsigned long usec)
> {
>         /*
> 	 * <INSERT COHERENT EXPLANATION> for this construct
>          */
> 	if (__builtin_constant_p(usec)) {
> 		if (usec >= UDELAY_CONST_MAX)
> 			__bad_udelay();
> 		else
> 			__const_udelay(usec * UDELAY_CONST_MULT);
> 	} else {
> 		__udelay(usec);

And of course a these magic numeric constants have been copied all over
the place. git grep '__const_udelay(' arch/ .... Just SH managed to use
0x10c6 instead of 0x10c7. 

ARM has it's own udelay implementation:

#define udelay(n)							\
	(__builtin_constant_p(n) ?					\
	  ((n) > (MAX_UDELAY_MS * 1000) ? __bad_udelay() :		\
			__const_udelay((n) * UDELAY_MULT)) :		\
	  __udelay(n))

Amazingly this uses the same comparison construct which was in the
generic udelay implementation... Same for arc, m68k and microblaze.

Plus the default implementation for mdelay() in linux/delay.h:

#define mdelay(n) (\
	(__builtin_constant_p(n) && (n)<=MAX_UDELAY_MS) ? udelay((n)*1000) : \
	({unsigned long __ms=(n); while (__ms--) udelay(1000);}))

Oh well....

What's truly amazing is that all __udelay() implementations, which
invoke __const_udelay() under the hood, do:

       __const_udelay(usec * 0x10c7);

So we have an arbitrary range limit for constants, which makes the build
fail. But the variable based udelays can hand in whatever they want and
__udelay() happily ignores it including the possible multiplication
overflow.

That's all really consistently copy and pasted voodoo. The other
architecture implementations are not much better in that regard.  The
main difference is their cutoff value for __const_udelay() and the
multiplication factors.

The below uncompiled and untested pile is an attempt to consolidate this
mess as far as it goes. There is probably more to mop up, but for a
start this makes already sense.

Thanks,

        tglx
---
 arch/Kconfig                        |    3 
 arch/arc/include/asm/delay.h        |   43 ------------
 arch/arm64/Kconfig                  |    1 
 arch/arm64/lib/delay.c              |   29 --------
 arch/csky/Kconfig                   |    1 
 arch/csky/lib/delay.c               |   22 ------
 arch/loongarch/Kconfig              |    1 
 arch/loongarch/include/asm/delay.h  |   16 ----
 arch/loongarch/lib/delay.c          |   23 ------
 arch/microblaze/Kconfig             |    1 
 arch/microblaze/include/asm/delay.h |   48 --------------
 arch/mips/Kconfig                   |    1 
 arch/mips/include/asm/delay.h       |   18 ++---
 arch/mips/lib/delay.c               |   29 +-------
 arch/nios2/Kconfig                  |    1 
 arch/nios2/lib/delay.c              |   22 ------
 arch/openrisc/Kconfig               |    1 
 arch/openrisc/lib/delay.c           |   22 ------
 arch/sh/Kconfig                     |    1 
 arch/sh/kernel/sh_ksyms_32.c        |    4 -
 arch/sh/lib/delay.c                 |   23 +-----
 arch/x86/Kconfig                    |    1 
 arch/x86/include/asm/delay.h        |    9 ++
 arch/x86/lib/delay.c                |   23 ------
 arch/x86/um/delay.c                 |   24 -------
 include/asm-generic/delay.h         |  120 +++++++++++++++++++++++++++---------
 26 files changed, 145 insertions(+), 342 deletions(-)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -55,6 +55,9 @@ config HOTPLUG_PARALLEL
 	bool
 	select HOTPLUG_SPLIT_STARTUP
 
+config GENERIC_DELAY
+	bool
+
 config GENERIC_ENTRY
 	bool
 
--- a/arch/arc/include/asm/delay.h
+++ b/arch/arc/include/asm/delay.h
@@ -14,11 +14,6 @@
 #ifndef __ASM_ARC_UDELAY_H
 #define __ASM_ARC_UDELAY_H
 
-#include <asm-generic/types.h>
-#include <asm/param.h>		/* HZ */
-
-extern unsigned long loops_per_jiffy;
-
 static inline void __delay(unsigned long loops)
 {
 	__asm__ __volatile__(
@@ -27,43 +22,11 @@ static inline void __delay(unsigned long
 	"	nop			\n"
 	"1:				\n"
 	:
-        : "r"(loops)
-        : "lp_count");
+	: "r"(loops)
+	: "lp_count");
 }
 
-extern void __bad_udelay(void);
-
-/*
- * Normal Math for computing loops in "N" usecs
- *  -we have precomputed @loops_per_jiffy
- *  -1 sec has HZ jiffies
- * loops per "N" usecs = ((loops_per_jiffy * HZ / 1000000) * N)
- *
- * Approximate Division by multiplication:
- *  -Mathematically if we multiply and divide a number by same value the
- *   result remains unchanged:  In this case, we use 2^32
- *  -> (loops_per_N_usec * 2^32 ) / 2^32
- *  -> (((loops_per_jiffy * HZ / 1000000) * N) * 2^32) / 2^32
- *  -> (loops_per_jiffy * HZ * N * 4295) / 2^32
- *
- *  -Divide by 2^32 is very simply right shift by 32
- *  -We simply need to ensure that the multiply per above eqn happens in
- *   64-bit precision (if CPU doesn't support it - gcc can emaulate it)
- */
-
-static inline void __udelay(unsigned long usecs)
-{
-	unsigned long loops;
-
-	/* (u64) cast ensures 64 bit MPY - real or emulated
-	 * HZ * 4295 is pre-evaluated by gcc - hence only 2 mpy ops
-	 */
-	loops = ((u64) usecs * 4295 * HZ * loops_per_jiffy) >> 32;
-
-	__delay(loops);
-}
+#include <asm-generic/delay.h>
 
-#define udelay(n) (__builtin_constant_p(n) ? ((n) > 20000 ? __bad_udelay() \
-				: __udelay(n)) : __udelay(n))
 
 #endif /* __ASM_ARC_UDELAY_H */
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -138,6 +138,7 @@ config ARM64
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CPU_VULNERABILITIES
+	select GENERIC_DELAY
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IOREMAP
--- a/arch/arm64/lib/delay.c
+++ b/arch/arm64/lib/delay.c
@@ -15,13 +15,8 @@
 
 #include <clocksource/arm_arch_timer.h>
 
-#define USECS_TO_CYCLES(time_usecs)			\
-	xloops_to_cycles((time_usecs) * 0x10C7UL)
-
-static inline unsigned long xloops_to_cycles(unsigned long xloops)
-{
-	return (xloops * loops_per_jiffy * HZ) >> 32;
-}
+#define USECS_TO_CYCLES(time_usecs)				\
+	(usec * DELAY_MULT_LPJ * UDELAY_MULT) >> UDELAY_SHIFT)
 
 void __delay(unsigned long cycles)
 {
@@ -37,7 +32,7 @@ void __delay(unsigned long cycles)
 		wfit(end);
 		while ((get_cycles() - start) < cycles)
 			wfet(end);
-	} else 	if (arch_timer_evtstrm_available()) {
+	} else if (arch_timer_evtstrm_available()) {
 		const cycles_t timer_evt_period =
 			USECS_TO_CYCLES(ARCH_TIMER_EVT_STREAM_PERIOD_US);
 
@@ -49,21 +44,3 @@ void __delay(unsigned long cycles)
 		cpu_relax();
 }
 EXPORT_SYMBOL(__delay);
-
-inline void __const_udelay(unsigned long xloops)
-{
-	__delay(xloops_to_cycles(xloops));
-}
-EXPORT_SYMBOL(__const_udelay);
-
-void __udelay(unsigned long usecs)
-{
-	__const_udelay(usecs * 0x10C7UL); /* 2**32 / 1000000 (rounded up) */
-}
-EXPORT_SYMBOL(__udelay);
-
-void __ndelay(unsigned long nsecs)
-{
-	__const_udelay(nsecs * 0x5UL); /* 2**32 / 1000000000 (rounded up) */
-}
-EXPORT_SYMBOL(__ndelay);
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -48,6 +48,7 @@ config CSKY
 	select DMA_DIRECT_REMAP
 	select IRQ_DOMAIN
 	select DW_APB_TIMER_OF
+	select GENERIC_DELAY
 	select GENERIC_IOREMAP
 	select GENERIC_LIB_ASHLDI3
 	select GENERIC_LIB_ASHRDI3
--- a/arch/csky/lib/delay.c
+++ b/arch/csky/lib/delay.c
@@ -15,25 +15,3 @@ void __aligned(8) __delay(unsigned long
 		: "0"(loops));
 }
 EXPORT_SYMBOL(__delay);
-
-void __const_udelay(unsigned long xloops)
-{
-	unsigned long long loops;
-
-	loops = (unsigned long long)xloops * loops_per_jiffy * HZ;
-
-	__delay(loops >> 32);
-}
-EXPORT_SYMBOL(__const_udelay);
-
-void __udelay(unsigned long usecs)
-{
-	__const_udelay(usecs * 0x10C7UL); /* 2**32 / 1000000 (rounded up) */
-}
-EXPORT_SYMBOL(__udelay);
-
-void __ndelay(unsigned long nsecs)
-{
-	__const_udelay(nsecs * 0x5UL); /* 2**32 / 1000000000 (rounded up) */
-}
-EXPORT_SYMBOL(__ndelay);
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -82,6 +82,7 @@ config LOONGARCH
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_DEVICES
+	select GENERIC_DELAY
 	select GENERIC_ENTRY
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_IOREMAP if !ARCH_IOREMAP
--- a/arch/loongarch/include/asm/delay.h
+++ b/arch/loongarch/include/asm/delay.h
@@ -7,20 +7,8 @@
 
 #include <linux/param.h>
 
-extern void __delay(unsigned long cycles);
-extern void __ndelay(unsigned long ns);
-extern void __udelay(unsigned long us);
+#define DELAY_LPJ_MULT	lpj_fine
 
-#define ndelay(ns) __ndelay(ns)
-#define udelay(us) __udelay(us)
-
-/* make sure "usecs *= ..." in udelay do not overflow. */
-#if HZ >= 1000
-#define MAX_UDELAY_MS	1
-#elif HZ <= 200
-#define MAX_UDELAY_MS	5
-#else
-#define MAX_UDELAY_MS	(1000 / HZ)
-#endif
+#include <asm-generic/delay.h>
 
 #endif /* _ASM_DELAY_H */
--- a/arch/loongarch/lib/delay.c
+++ b/arch/loongarch/lib/delay.c
@@ -17,26 +17,3 @@ void __delay(unsigned long cycles)
 		cpu_relax();
 }
 EXPORT_SYMBOL(__delay);
-
-/*
- * Division by multiplication: you don't have to worry about
- * loss of precision.
- *
- * Use only for very small delays ( < 1 msec).	Should probably use a
- * lookup table, really, as the multiplications take much too long with
- * short delays.  This is a "reasonable" implementation, though (and the
- * first constant multiplications gets optimized away if the delay is
- * a constant)
- */
-
-void __udelay(unsigned long us)
-{
-	__delay((us * 0x000010c7ull * HZ * lpj_fine) >> 32);
-}
-EXPORT_SYMBOL(__udelay);
-
-void __ndelay(unsigned long ns)
-{
-	__delay((ns * 0x00000005ull * HZ * lpj_fine) >> 32);
-}
-EXPORT_SYMBOL(__ndelay);
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -16,6 +16,7 @@ config MICROBLAZE
 	select DMA_DIRECT_REMAP
 	select GENERIC_ATOMIC64
 	select GENERIC_CPU_DEVICES
+	select GENERIC_DELAY
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
--- a/arch/microblaze/include/asm/delay.h
+++ b/arch/microblaze/include/asm/delay.h
@@ -33,53 +33,9 @@ static inline void __delay(unsigned long
  * (which corresponds to ~3800 bogomips at HZ = 100).
  * -- paulus
  */
-#define __MAX_UDELAY	(226050910UL/HZ)	/* maximum udelay argument */
-#define __MAX_NDELAY	(4294967295UL/HZ)	/* maximum ndelay argument */
 
-extern unsigned long loops_per_jiffy;
+#define UDELAY_ARCH_MULT	(19 * 226)
 
-static inline void __udelay(unsigned int x)
-{
-
-	unsigned long long tmp =
-		(unsigned long long)x * (unsigned long long)loops_per_jiffy \
-			* 226LL;
-	unsigned loops = tmp >> 32;
-
-/*
-	__asm__("mulxuu %0,%1,%2" : "=r" (loops) :
-		"r" (x), "r" (loops_per_jiffy * 226));
-*/
-	__delay(loops);
-}
-
-extern void __bad_udelay(void);		/* deliberately undefined */
-extern void __bad_ndelay(void);		/* deliberately undefined */
-
-#define udelay(n)						\
-	({							\
-		if (__builtin_constant_p(n)) {			\
-			if ((n) / __MAX_UDELAY >= 1)		\
-				__bad_udelay();			\
-			else					\
-				__udelay((n) * (19 * HZ));	\
-		} else {					\
-			__udelay((n) * (19 * HZ));		\
-		}						\
-	})
-
-#define ndelay(n)						\
-	({							\
-		if (__builtin_constant_p(n)) {			\
-			if ((n) / __MAX_NDELAY >= 1)		\
-				__bad_ndelay();			\
-			else					\
-				__udelay((n) * HZ);		\
-		} else {					\
-			__udelay((n) * HZ);			\
-		}						\
-	})
-
-#define muldiv(a, b, c)		(((a)*(b))/(c))
+#include <asm-generic/delay.h>
 
 #endif /* _ASM_MICROBLAZE_DELAY_H */
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -34,6 +34,7 @@ config MIPS
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
+	select GENERIC_DELAY if !CAVIUM_OCTEON_SOC
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_IOMAP
 	select GENERIC_IRQ_PROBE
--- a/arch/mips/include/asm/delay.h
+++ b/arch/mips/include/asm/delay.h
@@ -11,22 +11,22 @@
 #ifndef _ASM_DELAY_H
 #define _ASM_DELAY_H
 
-#include <linux/param.h>
+#ifdef CONFIG GENERIC_DELAY
+void __delay_loops(unsigned long long delay);
 
+#define __delay_loops		__delay_loops
+#define DELAY_MULT_LPJ		1
+#define UDELAY_ARCH_SHIFT	0
+
+#include <asm-generic/delay.h>
+
+#else
 extern void __delay(unsigned long loops);
 extern void __ndelay(unsigned long ns);
 extern void __udelay(unsigned long us);
 
 #define ndelay(ns) __ndelay(ns)
 #define udelay(us) __udelay(us)
-
-/* make sure "usecs *= ..." in udelay do not overflow. */
-#if HZ >= 1000
-#define MAX_UDELAY_MS	1
-#elif HZ <= 200
-#define MAX_UDELAY_MS	5
-#else
-#define MAX_UDELAY_MS	(1000 / HZ)
 #endif
 
 #endif /* _ASM_DELAY_H */
--- a/arch/mips/lib/delay.c
+++ b/arch/mips/lib/delay.c
@@ -38,31 +38,12 @@ void __delay(unsigned long loops)
 }
 EXPORT_SYMBOL(__delay);
 
-/*
- * Division by multiplication: you don't have to worry about
- * loss of precision.
- *
- * Use only for very small delays ( < 1 msec).	Should probably use a
- * lookup table, really, as the multiplications take much too long with
- * short delays.  This is a "reasonable" implementation, though (and the
- * first constant multiplications gets optimized away if the delay is
- * a constant)
- */
-
-void __udelay(unsigned long us)
-{
-	unsigned int lpj = raw_current_cpu_data.udelay_val;
-
-	__delay((us * 0x000010c7ull * HZ * lpj) >> 32);
-}
-EXPORT_SYMBOL(__udelay);
-
-void __ndelay(unsigned long ns)
+void __delay_loops(unsigned long long delay)
 {
-	unsigned int lpj = raw_current_cpu_data.udelay_val;
+	unsigned long lpj = raw_current_cpu_data.udelay_val;
+	unsigned long xloops = (delay * lpj) >> 32;
 
-	__delay((ns * 0x00000005ull * HZ * lpj) >> 32);
+	__delay(++xloops);
 }
-EXPORT_SYMBOL(__ndelay);
-
+EXPORT_SYMBOL(__delay_loops);
 #endif
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -12,6 +12,7 @@ config NIOS2
 	select TIMER_OF
 	select GENERIC_ATOMIC64
 	select GENERIC_CPU_DEVICES
+	select GENERIC_DELAY
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select HAVE_ARCH_TRACEHOOK
--- a/arch/nios2/lib/delay.c
+++ b/arch/nios2/lib/delay.c
@@ -16,25 +16,3 @@ void __delay(unsigned long cycles)
 		cpu_relax();
 }
 EXPORT_SYMBOL(__delay);
-
-void __const_udelay(unsigned long xloops)
-{
-	u64 loops;
-
-	loops = (u64)xloops * loops_per_jiffy * HZ;
-
-	__delay(loops >> 32);
-}
-EXPORT_SYMBOL(__const_udelay);
-
-void __udelay(unsigned long usecs)
-{
-	__const_udelay(usecs * 0x10C7UL); /* 2**32 / 1000000 (rounded up) */
-}
-EXPORT_SYMBOL(__udelay);
-
-void __ndelay(unsigned long nsecs)
-{
-	__const_udelay(nsecs * 0x5UL); /* 2**32 / 1000000000 (rounded up) */
-}
-EXPORT_SYMBOL(__ndelay);
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -17,6 +17,7 @@ config OPENRISC
 	select GPIOLIB
 	select HAVE_ARCH_TRACEHOOK
 	select SPARSE_IRQ
+	select GENERIC_DELAY
 	select GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
--- a/arch/openrisc/lib/delay.c
+++ b/arch/openrisc/lib/delay.c
@@ -35,25 +35,3 @@ void __delay(unsigned long cycles)
 		cpu_relax();
 }
 EXPORT_SYMBOL(__delay);
-
-inline void __const_udelay(unsigned long xloops)
-{
-	unsigned long long loops;
-
-	loops = (unsigned long long)xloops * loops_per_jiffy * HZ;
-
-	__delay(loops >> 32);
-}
-EXPORT_SYMBOL(__const_udelay);
-
-void __udelay(unsigned long usecs)
-{
-	__const_udelay(usecs * 0x10C7UL); /* 2**32 / 1000000 (rounded up) */
-}
-EXPORT_SYMBOL(__udelay);
-
-void __ndelay(unsigned long nsecs)
-{
-	__const_udelay(nsecs * 0x5UL); /* 2**32 / 1000000000 (rounded up) */
-}
-EXPORT_SYMBOL(__ndelay);
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -18,6 +18,7 @@ config SUPERH
 	select DMA_DECLARE_COHERENT
 	select GENERIC_ATOMIC64
 	select GENERIC_CMOS_UPDATE if SH_SH03 || SH_DREAMCAST
+	select GENERIC_DELAY
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IRQ_SHOW
 	select GENERIC_LIB_ASHLDI3
--- a/arch/sh/kernel/sh_ksyms_32.c
+++ b/arch/sh/kernel/sh_ksyms_32.c
@@ -12,9 +12,7 @@ EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(__copy_user);
-EXPORT_SYMBOL(__udelay);
-EXPORT_SYMBOL(__ndelay);
-EXPORT_SYMBOL(__const_udelay);
+EXPORT_SYMBOL(__delay_loops);
 EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(csum_partial);
 EXPORT_SYMBOL(csum_partial_copy_generic);
--- a/arch/sh/lib/delay.c
+++ b/arch/sh/lib/delay.c
@@ -30,25 +30,10 @@ void __delay(unsigned long loops)
 		: "t");
 }
 
-inline void __const_udelay(unsigned long xloops)
+void __delay_loops(unsigned long long delay)
 {
-	xloops *= 4;
-	__asm__("dmulu.l	%0, %2\n\t"
-		"sts	mach, %0"
-		: "=r" (xloops)
-		: "0" (xloops),
-		  "r" (cpu_data[raw_smp_processor_id()].loops_per_jiffy * (HZ/4))
-		: "macl", "mach");
-	__delay(++xloops);
-}
-
-void __udelay(unsigned long usecs)
-{
-	__const_udelay(usecs * 0x000010c6);  /* 2**32 / 1000000 */
-}
+	unsigned long lpj = cpu_data[raw_smp_processor_id()].loops_per_jiffy;
+	unsigned long xloops = (delay * lpj) >> 32;
 
-void __ndelay(unsigned long nsecs)
-{
-	__const_udelay(nsecs * 0x00000005);
+	__delay(++xloops);
 }
-
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -156,6 +156,7 @@ config X86
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CPU_VULNERABILITIES
+	select GENERIC_DELAY
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_ENTRY
 	select GENERIC_IOMAP
--- a/arch/x86/include/asm/delay.h
+++ b/arch/x86/include/asm/delay.h
@@ -2,9 +2,16 @@
 #ifndef _ASM_X86_DELAY_H
 #define _ASM_X86_DELAY_H
 
-#include <asm-generic/delay.h>
 #include <linux/init.h>
 
+void __delay_loops(unsigned long long delay);
+
+#define __delay_loops		__delay_loops
+#define DELAY_MULT_LPJ		1
+#define UDELAY_ARCH_SHIFT	0
+
+#include <asm-generic/delay.h>
+
 void __init use_tsc_delay(void);
 void __init use_tpause_delay(void);
 void use_mwaitx_delay(void);
--- a/arch/x86/lib/delay.c
+++ b/arch/x86/lib/delay.c
@@ -204,28 +204,11 @@ void __delay(unsigned long loops)
 }
 EXPORT_SYMBOL(__delay);
 
-noinline void __const_udelay(unsigned long xloops)
+void __delay_loops(unsigned long long delay)
 {
 	unsigned long lpj = this_cpu_read(cpu_info.loops_per_jiffy) ? : loops_per_jiffy;
-	int d0;
-
-	xloops *= 4;
-	asm("mull %%edx"
-		:"=d" (xloops), "=&a" (d0)
-		:"1" (xloops), "0" (lpj * (HZ / 4)));
+	unsigned long xloops = (delay * lpj) >> 32;
 
 	__delay(++xloops);
 }
-EXPORT_SYMBOL(__const_udelay);
-
-void __udelay(unsigned long usecs)
-{
-	__const_udelay(usecs * 0x000010c7); /* 2**32 / 1000000 (rounded up) */
-}
-EXPORT_SYMBOL(__udelay);
-
-void __ndelay(unsigned long nsecs)
-{
-	__const_udelay(nsecs * 0x00005); /* 2**32 / 1000000000 (rounded up) */
-}
-EXPORT_SYMBOL(__ndelay);
+EXPORT_SYMBOL(__delay_loops);
--- a/arch/x86/um/delay.c
+++ b/arch/x86/um/delay.c
@@ -30,28 +30,10 @@ void __delay(unsigned long loops)
 }
 EXPORT_SYMBOL(__delay);
 
-inline void __const_udelay(unsigned long xloops)
+void __delay_loops(unsigned long long delay)
 {
-	int d0;
-
-	xloops *= 4;
-	asm("mull %%edx"
-		: "=d" (xloops), "=&a" (d0)
-		: "1" (xloops), "0"
-		(loops_per_jiffy * (HZ/4)));
+	unsigned long xloops = (delay * loops_per_jiffy) >> 32;
 
 	__delay(++xloops);
 }
-EXPORT_SYMBOL(__const_udelay);
-
-void __udelay(unsigned long usecs)
-{
-	__const_udelay(usecs * 0x000010c7); /* 2**32 / 1000000 (rounded up) */
-}
-EXPORT_SYMBOL(__udelay);
-
-void __ndelay(unsigned long nsecs)
-{
-	__const_udelay(nsecs * 0x00005); /* 2**32 / 1000000000 (rounded up) */
-}
-EXPORT_SYMBOL(__ndelay);
+EXPORT_SYMBOL(__delay_loops);
--- a/include/asm-generic/delay.h
+++ b/include/asm-generic/delay.h
@@ -2,44 +2,104 @@
 #ifndef __ASM_GENERIC_DELAY_H
 #define __ASM_GENERIC_DELAY_H
 
+#include <vdso/time64.h>
+
 /* Undefined functions to get compile-time errors */
 extern void __bad_udelay(void);
 extern void __bad_ndelay(void);
 
-extern void __udelay(unsigned long usecs);
-extern void __ndelay(unsigned long nsecs);
-extern void __const_udelay(unsigned long xloops);
 extern void __delay(unsigned long loops);
 
+#ifdef CONFIG_GENERIC_UDELAY
+#ifndef UDELAY_ARCH_MULT
+# define UDELAY_ARCH_MULT	1ULL
+#endif
+
+#ifdef UDELAY_ARCH_SHIFT
+# define UDELAY_SHIFT		UDELAY_ARCH_SHIFT
+#else
+# define UDELAY_SHIFT		32
+#endif
+
+#define __UDELAY_MULT	((unsigned long long)UDELAY_ARCH_MULT * HZ)
+#define UDELAY_MULT	((unsigned long)DIV_ROUND_UP(__UDELAY_MULT << 32, USEC_PER_SEC))
+#define NDELAY_MULT	DIV_ROUND_UP(UDELAY_MULT, NSEC_PER_USEC)
+
 /*
- * The weird n/20000 thing suppresses a "comparison is always false due to
- * limited range of data type" warning with non-const 8-bit arguments.
+ * Generous upper bound for loops per jiffy assuming a maximal CPU
+ * frequency of 8GHz and 1 cycle per loop.
  */
+#define LPJ_MAX			((8ULL * NSEC_PER_SEC) / HZ)
 
-/* 0x10c7 is 2**32 / 1000000 (rounded up) */
-#define udelay(n)							\
-	({								\
-		if (__builtin_constant_p(n)) {				\
-			if ((n) / 20000 >= 1)				\
-				 __bad_udelay();			\
-			else						\
-				__const_udelay((n) * 0x10c7ul);		\
-		} else {						\
-			__udelay(n);					\
-		}							\
-	})
-
-/* 0x5 is 2**32 / 1000000000 (rounded up) */
-#define ndelay(n)							\
-	({								\
-		if (__builtin_constant_p(n)) {				\
-			if ((n) / 20000 >= 1)				\
-				__bad_ndelay();				\
-			else						\
-				__const_udelay((n) * 5ul);		\
-		} else {						\
-			__ndelay(n);					\
-		}							\
-	})
+/*
+ * The maximum usec value depends on the multiplication factor and the
+ * maximum upper bound for loops_per_jiffy to guarantee that there is
+ * no multiplication overflow when __delay_loops() multiplies the
+ * argument with the actual loops_per_jiffy value.
+ */
+#define UDELAY_CONST_MAX	(unsigned long)(U64_MAX / (LPJ_MAX * UDELAY_MULT))
+#define NDELAY_CONST_MAX	(UDELAY_CONST_MAX * NSEC_PER_USEC)
+
+#ifndef DELAY_MULT_LPJ
+#define DELAY_MULT_LPJ		loops_per_jiffy
+#endif
+
+#ifndef __delay_loops
+#define __delay_loops(x)	__delay(x)
+#endif
+
+static __always_inline void __udelay(unsigned long usec)
+{
+	/* FIXME: Add a debug sanity check for usec > UDELAY_CONST_MAX */
+	__delay_loops((usec * DELAY_MULT_LPJ * UDELAY_MULT) >> UDELAY_SHIFT);
+}
+
+static __always_inline void __ndelay(unsigned long nsec)
+{
+	/* FIXME: Add a debug sanity check for usec > NDELAY_CONST_MAX */
+	__delay_loops((nsec * DELAY_MULT_LPJ * NDELAY_MULT) >> UDELAY_SHIFT);
+}
+
+#define __const_udelay_wrapper(usec, mult)	__udelay(usec)
+#define __const_ndelay_wrapper(usec, mult)	__ndelay(usec)
+
+#else
+/* Does any of this make sense? No. */
+#define UDELAY_CONST_MULT	((unsigned long)DIV_ROUND_UP((1ULL << 32), USEC_PER_SEC))
+#define NDELAY_CONST_MULT	(UDELAY_CONST_MULT / NSEC_PER_USEC)
+#define UDELAY_CONST_MAX	20000
+#define NDELAY_CONST_MAX	20000
+extern void __const_udelay(unsigned long xloops);
+extern void __udelay(unsigned long usecs);
+extern void __ndelay(unsigned long nsecs);
+#define __const_udelay_wrapper(usec)	__const_udelay(usec * UDELAY_CONST_MULT)
+#define __const_ndelay_wrapper(nsec)	__const_udelay(nsec * NDELAY_CONST_MULT)
+#endif
+
+static __always_inline void _udelay(unsigned long usec)
+{
+	if (__builtin_constant_p(usec)) {
+		if (usec >= UDELAY_CONST_MAX)
+			__bad_udelay();
+		else
+			__const_udelay_wrapper(usec);
+	} else {
+		__udelay(usec);
+	}
+}
+#define udelay(x) _udelay(x)
+
+static __always_inline void _ndelay(unsigned long usec)
+{
+	if (__builtin_constant_p(usec)) {
+		if (usec >= NDELAY_CONST_MAX)
+			__bad_ndelay();
+		else
+			__const_ndelay_wrapper(usec);
+	} else {
+		__ndelay(usec);
+	}
+}
+#define ndelay(x) _ndelay(x)
 
 #endif /* __ASM_GENERIC_DELAY_H */






