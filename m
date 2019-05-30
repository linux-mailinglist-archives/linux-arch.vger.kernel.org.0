Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3DF92FD5E
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2019 16:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfE3OPx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 May 2019 10:15:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36400 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfE3OPw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 10:15:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12CF5165C;
        Thu, 30 May 2019 07:15:52 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB6263F59C;
        Thu, 30 May 2019 07:15:48 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
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
        Huw Davies <huw@codeweavers.com>
Subject: [PATCH v6 02/19] kernel: Define gettimeofday vdso common code
Date:   Thu, 30 May 2019 15:15:14 +0100
Message-Id: <20190530141531.43462-3-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530141531.43462-1-vincenzo.frascino@arm.com>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In the last few years we assisted to an explosion of vdso
implementations that mostly share similar code.

Try to unify the gettimeofday vdso implementation introducing
lib/vdso. The code contained in this library can ideally be
reused by all the architectures avoiding, where possible, code
duplication.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/linux/hrtimer.h      |  15 +--
 include/linux/hrtimer_defs.h |  25 ++++
 include/vdso/helpers.h       |  56 +++++++++
 lib/Kconfig                  |   5 +
 lib/vdso/Kconfig             |  36 ++++++
 lib/vdso/Makefile            |  22 ++++
 lib/vdso/gettimeofday.c      | 225 +++++++++++++++++++++++++++++++++++
 7 files changed, 370 insertions(+), 14 deletions(-)
 create mode 100644 include/linux/hrtimer_defs.h
 create mode 100644 include/vdso/helpers.h
 create mode 100644 lib/vdso/Kconfig
 create mode 100644 lib/vdso/Makefile
 create mode 100644 lib/vdso/gettimeofday.c

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 2e8957eac4d4..c922ce02e2e6 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -12,6 +12,7 @@
 #ifndef _LINUX_HRTIMER_H
 #define _LINUX_HRTIMER_H
 
+#include <linux/hrtimer_defs.h>
 #include <linux/rbtree.h>
 #include <linux/ktime.h>
 #include <linux/init.h>
@@ -298,26 +299,12 @@ struct clock_event_device;
 
 extern void hrtimer_interrupt(struct clock_event_device *dev);
 
-/*
- * The resolution of the clocks. The resolution value is returned in
- * the clock_getres() system call to give application programmers an
- * idea of the (in)accuracy of timers. Timer values are rounded up to
- * this resolution values.
- */
-# define HIGH_RES_NSEC		1
-# define KTIME_HIGH_RES		(HIGH_RES_NSEC)
-# define MONOTONIC_RES_NSEC	HIGH_RES_NSEC
-# define KTIME_MONOTONIC_RES	KTIME_HIGH_RES
-
 extern void clock_was_set_delayed(void);
 
 extern unsigned int hrtimer_resolution;
 
 #else
 
-# define MONOTONIC_RES_NSEC	LOW_RES_NSEC
-# define KTIME_MONOTONIC_RES	KTIME_LOW_RES
-
 #define hrtimer_resolution	(unsigned int)LOW_RES_NSEC
 
 static inline void clock_was_set_delayed(void) { }
diff --git a/include/linux/hrtimer_defs.h b/include/linux/hrtimer_defs.h
new file mode 100644
index 000000000000..7179bfc04115
--- /dev/null
+++ b/include/linux/hrtimer_defs.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_HRTIMER_DEFS_H
+#define _LINUX_HRTIMER_DEFS_H
+
+#ifdef CONFIG_HIGH_RES_TIMERS
+
+/*
+ * The resolution of the clocks. The resolution value is returned in
+ * the clock_getres() system call to give application programmers an
+ * idea of the (in)accuracy of timers. Timer values are rounded up to
+ * this resolution values.
+ */
+# define HIGH_RES_NSEC		1
+# define KTIME_HIGH_RES		(HIGH_RES_NSEC)
+# define MONOTONIC_RES_NSEC	HIGH_RES_NSEC
+# define KTIME_MONOTONIC_RES	KTIME_HIGH_RES
+
+#else
+
+# define MONOTONIC_RES_NSEC	LOW_RES_NSEC
+# define KTIME_MONOTONIC_RES	KTIME_LOW_RES
+
+#endif
+
+#endif
diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
new file mode 100644
index 000000000000..4d66f4ffa1a2
--- /dev/null
+++ b/include/vdso/helpers.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_HELPERS_H
+#define __VDSO_HELPERS_H
+
+#ifndef __ASSEMBLY__
+
+#include <vdso/datapage.h>
+
+static __always_inline notrace u32 vdso_read_begin(const struct vdso_data *vd)
+{
+	u32 seq;
+
+	while ((seq = READ_ONCE(vd->seq)) & 1)
+		cpu_relax();
+
+	smp_rmb();
+	return seq;
+}
+
+static __always_inline notrace u32 vdso_read_retry(const struct vdso_data *vd,
+						   u32 start)
+{
+	u32 seq;
+
+	smp_rmb();
+	seq = READ_ONCE(vd->seq);
+	return seq != start;
+}
+
+static __always_inline notrace void vdso_write_begin(struct vdso_data *vd)
+{
+	/*
+	 * WRITE_ONCE it is required otherwise the compiler can validly tear
+	 * updates to vd[x].seq and it is possible that the value seen by the
+	 * reader it is inconsistent.
+	 */
+	WRITE_ONCE(vd[CS_HRES_COARSE].seq, vd[CS_HRES_COARSE].seq + 1);
+	WRITE_ONCE(vd[CS_RAW].seq, vd[CS_RAW].seq + 1);
+	smp_wmb();
+}
+
+static __always_inline notrace void vdso_write_end(struct vdso_data *vd)
+{
+	smp_wmb();
+	/*
+	 * WRITE_ONCE it is required otherwise the compiler can validly tear
+	 * updates to vd[x].seq and it is possible that the value seen by the
+	 * reader it is inconsistent.
+	 */
+	WRITE_ONCE(vd[CS_HRES_COARSE].seq, vd[CS_HRES_COARSE].seq + 1);
+	WRITE_ONCE(vd[CS_RAW].seq, vd[CS_RAW].seq + 1);
+}
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __VDSO_HELPERS_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index 90623a0e1942..8c8eefc5e54c 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -576,6 +576,11 @@ config OID_REGISTRY
 config UCS2_STRING
         tristate
 
+#
+# generic vdso
+#
+source "lib/vdso/Kconfig"
+
 source "lib/fonts/Kconfig"
 
 config SG_SPLIT
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
new file mode 100644
index 000000000000..cc00364bd2c2
--- /dev/null
+++ b/lib/vdso/Kconfig
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config HAVE_GENERIC_VDSO
+	bool
+
+if HAVE_GENERIC_VDSO
+
+config GENERIC_GETTIMEOFDAY
+	bool
+	help
+	  This is a generic implementation of gettimeofday vdso.
+	  Each architecture that enables this feature has to
+	  provide the fallback implementation.
+
+config GENERIC_VDSO_32
+	bool
+	depends on GENERIC_GETTIMEOFDAY && !64BIT
+	help
+	  This config option helps to avoid possible performance issues
+	  in 32 bit only architectures.
+
+config GENERIC_COMPAT_VDSO
+	bool
+	help
+	  This config option enables the compat VDSO layer.
+
+config CROSS_COMPILE_COMPAT_VDSO
+	string "32 bit Toolchain prefix for compat vDSO"
+	default ""
+	depends on GENERIC_COMPAT_VDSO
+	help
+	  Defines the cross-compiler prefix for compiling compat vDSO.
+	  If a 64 bit compiler (i.e. x86_64) can compile the VDSO for
+	  32 bit, it does not need to define this parameter.
+
+endif
diff --git a/lib/vdso/Makefile b/lib/vdso/Makefile
new file mode 100644
index 000000000000..c415a685d61b
--- /dev/null
+++ b/lib/vdso/Makefile
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0
+
+GENERIC_VDSO_MK_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
+GENERIC_VDSO_DIR := $(dir $(GENERIC_VDSO_MK_PATH))
+
+c-gettimeofday-$(CONFIG_GENERIC_GETTIMEOFDAY) := $(addprefix $(GENERIC_VDSO_DIR), gettimeofday.c)
+
+# This cmd checks that the vdso library does not contain absolute relocation
+# It has to be called after the linking of the vdso library and requires it
+# as a parameter.
+#
+# $(ARCH_REL_TYPE_ABS) is defined in the arch specific makefile and corresponds
+# to the absolute relocation types printed by "objdump -R" and accepted by the
+# dynamic linker.
+ifndef ARCH_REL_TYPE_ABS
+$(error ARCH_REL_TYPE_ABS is not set)
+endif
+
+quiet_cmd_vdso_check = VDSOCHK $@
+      cmd_vdso_check = if $(OBJDUMP) -R $@ | egrep -h "$(ARCH_REL_TYPE_ABS)"; \
+		       then (echo >&2 "$@: dynamic relocations are not supported"; \
+			     rm -f $@; /bin/false); fi
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
new file mode 100644
index 000000000000..a226675731f4
--- /dev/null
+++ b/lib/vdso/gettimeofday.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic userspace implementations of gettimeofday() and similar.
+ */
+#include <linux/compiler.h>
+#include <linux/math64.h>
+#include <linux/time.h>
+#include <linux/kernel.h>
+#include <linux/ktime.h>
+#include <linux/hrtimer_defs.h>
+#include <vdso/datapage.h>
+#include <vdso/helpers.h>
+
+/*
+ * The generic vDSO implementation requires that gettimeofday.h
+ * provides:
+ * - __arch_get_vdso_data(): to get the vdso datapage.
+ * - __arch_get_hw_counter(): to get the hw counter based on the
+ *   clock_mode.
+ * - gettimeofday_fallback(): fallback for gettimeofday.
+ * - clock_gettime_fallback(): fallback for clock_gettime.
+ * - clock_getres_fallback(): fallback for clock_getres.
+ */
+#include <asm/vdso/gettimeofday.h>
+
+static notrace int do_hres(const struct vdso_data *vd,
+			   clockid_t clk,
+			   struct __kernel_timespec *ts)
+{
+	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
+	u64 cycles, last, sec, ns;
+	u32 seq;
+
+	do {
+		seq = vdso_read_begin(vd);
+		cycles = __arch_get_hw_counter(vd->clock_mode) &
+			vd->mask;
+		ns = vdso_ts->nsec;
+		last = vd->cycle_last;
+		if (unlikely((s64)cycles < 0))
+			return clock_gettime_fallback(clk, ts);
+		if (cycles > last)
+			ns += (cycles - last) * vd->mult;
+		ns >>= vd->shift;
+		sec = vdso_ts->sec;
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	/*
+	 * Do this outside the loop: a race inside the loop could result
+	 * in __iter_div_u64_rem() being extremely slow.
+	 */
+	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
+
+	return 0;
+}
+
+static notrace void do_coarse(const struct vdso_data *vd,
+			      clockid_t clk,
+			      struct __kernel_timespec *ts)
+{
+	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
+	u32 seq;
+
+	do {
+		seq = vdso_read_begin(vd);
+		ts->tv_sec = vdso_ts->sec;
+		ts->tv_nsec = vdso_ts->nsec;
+	} while (unlikely(vdso_read_retry(vd, seq)));
+}
+
+static notrace __maybe_unused int
+__cvdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
+{
+	const struct vdso_data *vd = __arch_get_vdso_data();
+	u32 msk;
+
+	/* Check for negative values or invalid clocks */
+	if (unlikely((u32) clock >= MAX_CLOCKS))
+		goto fallback;
+
+	/*
+	 * Convert the clockid to a bitmask and use it to check which
+	 * clocks are handled in the VDSO directly.
+	 */
+	msk = 1U << clock;
+	if (likely(msk & VDSO_HRES)) {
+		return do_hres(&vd[CS_HRES_COARSE], clock, ts);
+	} else if (msk & VDSO_COARSE) {
+		do_coarse(&vd[CS_HRES_COARSE], clock, ts);
+		return 0;
+	} else if (msk & VDSO_RAW) {
+		return do_hres(&vd[CS_RAW], clock, ts);
+	}
+
+fallback:
+	return clock_gettime_fallback(clock, ts);
+}
+
+static notrace __maybe_unused int
+__cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
+{
+	struct __kernel_timespec ts;
+	int ret;
+
+	if (res == NULL)
+		goto fallback;
+
+	ret = __cvdso_clock_gettime(clock, &ts);
+
+	if (ret == 0) {
+		res->tv_sec = ts.tv_sec;
+		res->tv_nsec = ts.tv_nsec;
+	}
+
+	return ret;
+
+fallback:
+	return clock_gettime_fallback(clock, (struct __kernel_timespec *)res);
+}
+
+static notrace __maybe_unused int
+__cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
+{
+	const struct vdso_data *vd = __arch_get_vdso_data();
+
+	if (likely(tv != NULL)) {
+		struct __kernel_timespec ts;
+
+		if (do_hres(&vd[CS_HRES_COARSE], CLOCK_REALTIME, &ts))
+			return gettimeofday_fallback(tv, tz);
+
+		tv->tv_sec = ts.tv_sec;
+		tv->tv_usec = (u32)ts.tv_nsec / NSEC_PER_USEC;
+	}
+
+	if (unlikely(tz != NULL)) {
+		tz->tz_minuteswest = vd[CS_HRES_COARSE].tz_minuteswest;
+		tz->tz_dsttime = vd[CS_HRES_COARSE].tz_dsttime;
+	}
+
+	return 0;
+}
+
+#ifdef VDSO_HAS_TIME
+static notrace __maybe_unused time_t __cvdso_time(time_t *time)
+{
+	const struct vdso_data *vd = __arch_get_vdso_data();
+	time_t t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
+
+	if (time)
+		*time = t;
+
+	return t;
+}
+#endif /* VDSO_HAS_TIME */
+
+static notrace __maybe_unused
+int __cvdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
+{
+	const struct vdso_data *vd = __arch_get_vdso_data();
+	u64 ns;
+	u32 msk;
+	u64 hrtimer_res = READ_ONCE(vd[CS_HRES_COARSE].hrtimer_res);
+
+	/* Check for negative values or invalid clocks */
+	if (unlikely((u32) clock >= MAX_CLOCKS))
+		goto fallback;
+
+	/*
+	 * Convert the clockid to a bitmask and use it to check which
+	 * clocks are handled in the VDSO directly.
+	 */
+	msk = 1U << clock;
+	if (msk & VDSO_HRES) {
+		/*
+		 * Preserves the behaviour of posix_get_hrtimer_res().
+		 */
+		ns = hrtimer_res;
+	} else if (msk & VDSO_COARSE) {
+		/*
+		 * Preserves the behaviour of posix_get_coarse_res().
+		 */
+		ns = LOW_RES_NSEC;
+	} else if (msk & VDSO_RAW) {
+		/*
+		 * Preserves the behaviour of posix_get_hrtimer_res().
+		 */
+		ns = hrtimer_res;
+	} else {
+		goto fallback;
+	}
+
+	if (res) {
+		res->tv_sec = 0;
+		res->tv_nsec = ns;
+	}
+
+	return 0;
+
+fallback:
+	return clock_getres_fallback(clock, res);
+}
+
+static notrace __maybe_unused int
+__cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
+{
+	struct __kernel_timespec ts;
+	int ret;
+
+	if (res == NULL)
+		goto fallback;
+
+	ret = __cvdso_clock_getres(clock, &ts);
+
+	if (ret == 0) {
+		res->tv_sec = ts.tv_sec;
+		res->tv_nsec = ts.tv_nsec;
+	}
+
+	return ret;
+
+fallback:
+	return clock_getres_fallback(clock, (struct __kernel_timespec *)res);
+}
-- 
2.21.0

