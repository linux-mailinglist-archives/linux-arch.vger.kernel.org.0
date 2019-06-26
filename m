Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 715A156619
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2019 12:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfFZKCJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Jun 2019 06:02:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46631 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFZKCJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jun 2019 06:02:09 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hg4kc-0003Rp-HP; Wed, 26 Jun 2019 12:02:02 +0200
Date:   Wed, 26 Jun 2019 12:02:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
cc:     linux-arch@vger.kernel.org,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux@armlinux.org.uk,
        Ralf Baechle <ralf@linux-mips.org>, paul.burton@mips.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        salyzyn@android.com, pcc@google.com, shuah@kernel.org,
        0x7f454c46@gmail.com, linux@rasmusvillemoes.dk,
        huw@codeweavers.com, sthotton@marvell.com, andre.przywara@arm.com,
        Andy Lutomirski <luto@kernel.org>
Subject: lib/vdso: Make delta calculation work correctly
In-Reply-To: <4ff43de4-fe51-eed4-a155-31a05edf2f11@arm.com>
Message-ID: <alpine.DEB.2.21.1906261159230.32342@nanos.tec.linutronix.de>
References: <20190624133607.GI29497@fuggles.cambridge.arm.com> <20190625161804.38713-1-vincenzo.frascino@arm.com> <alpine.DEB.2.21.1906251851350.32342@nanos.tec.linutronix.de> <alpine.DEB.2.21.1906260832470.32342@nanos.tec.linutronix.de>
 <4ff43de4-fe51-eed4-a155-31a05edf2f11@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The x86 vdso implementation on which the generic vdso library is based on
has subtle (unfortunately undocumented) twists:

 1) The code assumes that the clocksource mask is U64_MAX which means that
    no bits are masked. Which is true for any valid x86 VDSO clocksource.
    Stupidly it still did the mask operation for no reason and at the wrong
    place right after reading the clocksource.

 2) It contains a sanity check to catch the case where slightly
    unsynchronized TSC values can be overserved which would cause the delta
    calculation to make a huge jump. It therefore checks whether the
    current TSC value is larger than the value on which the current
    conversion is based on. If it's not larger the base value is used to
    prevent time jumps.

#1 Is not only stupid for the X86 case because it does the masking for no
reason it is also completely wrong for clocksources with a smaller mask
which can legitimately wrap around during a conversion period. The core
timekeeping code does it correct by applying the mask after the delta
calculation:

	(now - base) & mask

#2 is equally broken for clocksources which have smaller masks and can wrap
around during a conversion period because there the now > base check is
just wrong and causes stale time stamps and time going backwards issues.

Unbreak it by:

  1) Removing the mask operation from the clocksource read which makes the
     fallback detection work for all clocksources

  2) Replacing the conditional delta calculation with a overrideable inline
     function.

#2 could reuse clocksource_delta() from the timekeeping code but that
results in a significant performance hit for the x86 VSDO. The timekeeping
core code must have the non optimized version as it has to operate
correctly with clocksources which have smaller masks as well to handle the
case where TSC is discarded as timekeeper clocksource and replaced by HPET
or pmtimer. For the VDSO there is no replacement clocksource. If TSC is
unusable the syscall is enforced which does the right thing.

To accomodate to the needs of various architectures provide an overrideable
inline function which defaults to the regular delta calculation with
masking:

	(now - base) & mask

Override it for x86 with the non-masking and checking version.

This unbreaks the ARM64 syscall fallback operation, allows to use
clocksources with arbitrary width and preserves the performance
optimization for x86.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/vdso/gettimeofday.h |   27 +++++++++++++++++++++++++++
 lib/vdso/gettimeofday.c                  |   19 +++++++++++++++----
 2 files changed, 42 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -229,6 +229,33 @@ static __always_inline const struct vdso
 	return __vdso_data;
 }
 
+/*
+ * x86 specific delta calculation.
+ *
+ * The regular implementation assumes that clocksource reads are globally
+ * monotonic. The TSC can be slightly off across sockets which can cause
+ * the regular delta calculation (@cycles - @last) to return a huge time
+ * jump.
+ *
+ * Therefore it needs to be verified that @cycles are greater than
+ * @last. If not then use @last, which is the base time of the current
+ * conversion period.
+ *
+ * This variant also removes the masking of the subtraction because the
+ * clocksource mask of all VDSO capable clocksources on x86 is U64_MAX
+ * which would result in a pointless operation. The compiler cannot
+ * optimize it away as the mask comes from the vdso data and is not compile
+ * time constant.
+ */
+static __always_inline
+u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
+{
+	if (cycles > last)
+		return (cycles - last) * mult;
+	return 0;
+}
+#define vdso_calc_delta vdso_calc_delta
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -26,6 +26,18 @@
 #include <asm/vdso/gettimeofday.h>
 #endif /* ENABLE_COMPAT_VDSO */
 
+#ifndef vdso_calc_delta
+/*
+ * Default implementation which works for all sane clocksources. That
+ * obviously excludes x86/TSC.
+ */
+static __always_inline
+u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
+{
+	return ((cyles - last) & mask) * mult;
+}
+#endif
+
 static int do_hres(const struct vdso_data *vd, clockid_t clk,
 		   struct __kernel_timespec *ts)
 {
@@ -35,14 +47,13 @@ static int do_hres(const struct vdso_dat
 
 	do {
 		seq = vdso_read_begin(vd);
-		cycles = __arch_get_hw_counter(vd->clock_mode) &
-			vd->mask;
+		cycles = __arch_get_hw_counter(vd->clock_mode);
 		ns = vdso_ts->nsec;
 		last = vd->cycle_last;
 		if (unlikely((s64)cycles < 0))
 			return clock_gettime_fallback(clk, ts);
-		if (cycles > last)
-			ns += (cycles - last) * vd->mult;
+
+		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
 		ns >>= vd->shift;
 		sec = vdso_ts->sec;
 	} while (unlikely(vdso_read_retry(vd, seq)));
