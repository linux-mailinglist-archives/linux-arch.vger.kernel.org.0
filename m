Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46A0A2FD3F
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2019 16:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfE3OQr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 May 2019 10:16:47 -0400
Received: from foss.arm.com ([217.140.101.70]:36950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbfE3OQr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 10:16:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E2FC169E;
        Thu, 30 May 2019 07:16:46 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 048BB3F59C;
        Thu, 30 May 2019 07:16:42 -0700 (PDT)
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
Subject: [PATCH v6 18/19] x86: Add support for generic vDSO
Date:   Thu, 30 May 2019 15:15:30 +0100
Message-Id: <20190530141531.43462-19-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530141531.43462-1-vincenzo.frascino@arm.com>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The x86 vDSO library requires some adaptations to take advantage of the
newly introduced generic vDSO library.

Introduce the following changes:
 - Modification of vdso.c to be compliant with the common vdso datapage
 - Use of lib/vdso for gettimeofday

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/x86/Kconfig                         |   3 +
 arch/x86/entry/vdso/Makefile             |   9 +
 arch/x86/entry/vdso/vclock_gettime.c     | 251 +++++------------------
 arch/x86/entry/vdso/vdso.lds.S           |   2 +
 arch/x86/entry/vdso/vdso32/vdso32.lds.S  |   2 +
 arch/x86/entry/vdso/vdsox32.lds.S        |   1 +
 arch/x86/entry/vsyscall/Makefile         |   2 -
 arch/x86/entry/vsyscall/vsyscall_gtod.c  |  83 --------
 arch/x86/include/asm/mshyperv-tsc.h      |  76 +++++++
 arch/x86/include/asm/mshyperv.h          |  70 +------
 arch/x86/include/asm/pvclock.h           |   2 +-
 arch/x86/include/asm/vdso/gettimeofday.h | 203 ++++++++++++++++++
 arch/x86/include/asm/vdso/vsyscall.h     |  44 ++++
 arch/x86/include/asm/vgtod.h             |  75 +------
 arch/x86/include/asm/vvar.h              |   7 +-
 arch/x86/kernel/pvclock.c                |   1 +
 16 files changed, 396 insertions(+), 435 deletions(-)
 delete mode 100644 arch/x86/entry/vsyscall/vsyscall_gtod.c
 create mode 100644 arch/x86/include/asm/mshyperv-tsc.h
 create mode 100644 arch/x86/include/asm/vdso/gettimeofday.h
 create mode 100644 arch/x86/include/asm/vdso/vsyscall.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2bbbd4d1ba31..51a98d6eae8e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -17,6 +17,7 @@ config X86_32
 	select HAVE_DEBUG_STACKOVERFLOW
 	select MODULES_USE_ELF_REL
 	select OLD_SIGACTION
+	select GENERIC_VDSO_32
 
 config X86_64
 	def_bool y
@@ -121,6 +122,7 @@ config X86
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_GETTIMEOFDAY
 	select HARDLOCKUP_CHECK_TIMESTAMP	if X86_64
 	select HAVE_ACPI_APEI			if ACPI
 	select HAVE_ACPI_APEI_NMI		if ACPI
@@ -202,6 +204,7 @@ config X86
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_USER_RETURN_NOTIFIER
+	select HAVE_GENERIC_VDSO
 	select HOTPLUG_SMT			if SMP
 	select IRQ_FORCED_THREADING
 	select NEED_SG_DMA_LENGTH
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 42fe42e82baf..39106111be86 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -3,6 +3,12 @@
 # Building vDSO images for x86.
 #
 
+# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
+# the inclusion of generic Makefile.
+ARCH_REL_TYPE_ABS := R_X86_64_JUMP_SLOT|R_X86_64_GLOB_DAT|R_X86_64_RELATIVE|
+ARCH_REL_TYPE_ABS += R_386_GLOB_DAT|R_386_JMP_SLOT|R_386_RELATIVE
+include $(srctree)/lib/vdso/Makefile
+
 KBUILD_CFLAGS += $(DISABLE_LTO)
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
@@ -51,6 +57,7 @@ VDSO_LDFLAGS_vdso.lds = -m elf_x86_64 -soname linux-vdso.so.1 --no-undefined \
 
 $(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
 	$(call if_changed,vdso)
+	$(call if_changed,vdso_check)
 
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include -I$(srctree)/include/uapi -I$(srctree)/arch/$(SUBARCH)/include/uapi
 hostprogs-y			+= vdso2c
@@ -121,6 +128,7 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 
 $(obj)/vdsox32.so.dbg: $(obj)/vdsox32.lds $(vobjx32s) FORCE
 	$(call if_changed,vdso)
+	$(call if_changed,vdso_check)
 
 CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
 VDSO_LDFLAGS_vdso32.lds = -m elf_i386 -soname linux-gate.so.1
@@ -160,6 +168,7 @@ $(obj)/vdso32.so.dbg: FORCE \
 		      $(obj)/vdso32/system_call.o \
 		      $(obj)/vdso32/sigreturn.o
 	$(call if_changed,vdso)
+	$(call if_changed,vdso_check)
 
 #
 # The DSO images are built using a special linker script.
diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index 98c7d12b945c..39268f941878 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -1,240 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2006 Andi Kleen, SUSE Labs.
- * Subject to the GNU Public License, v.2
- *
  * Fast user context implementation of clock_gettime, gettimeofday, and time.
  *
+ * Copyright 2019 ARM Limited
+ * Copyright 2006 Andi Kleen, SUSE Labs.
  * 32 Bit compat layer by Stefani Seibold <stefani@seibold.net>
  *  sponsored by Rohde & Schwarz GmbH & Co. KG Munich/Germany
- *
- * The code should have no internal unresolved relocations.
- * Check with readelf after changing.
  */
-
-#include <uapi/linux/time.h>
-#include <asm/vgtod.h>
-#include <asm/vvar.h>
-#include <asm/unistd.h>
-#include <asm/msr.h>
-#include <asm/pvclock.h>
-#include <asm/mshyperv.h>
-#include <linux/math64.h>
 #include <linux/time.h>
-#include <linux/kernel.h>
+#include <linux/types.h>
 
-#define gtod (&VVAR(vsyscall_gtod_data))
+#include "../../../../lib/vdso/gettimeofday.c"
 
-extern int __vdso_clock_gettime(clockid_t clock, struct timespec *ts);
-extern int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz);
+extern int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
 extern time_t __vdso_time(time_t *t);
 
-#ifdef CONFIG_PARAVIRT_CLOCK
-extern u8 pvclock_page[PAGE_SIZE]
-	__attribute__((visibility("hidden")));
-#endif
-
-#ifdef CONFIG_HYPERV_TSCPAGE
-extern u8 hvclock_page[PAGE_SIZE]
-	__attribute__((visibility("hidden")));
-#endif
-
-#ifndef BUILD_VDSO32
-
-notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
-{
-	long ret;
-	asm ("syscall" : "=a" (ret), "=m" (*ts) :
-	     "0" (__NR_clock_gettime), "D" (clock), "S" (ts) :
-	     "rcx", "r11");
-	return ret;
-}
-
-#else
-
-notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
+notrace int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
+				struct timezone *tz)
 {
-	long ret;
-
-	asm (
-		"mov %%ebx, %%edx \n"
-		"mov %[clock], %%ebx \n"
-		"call __kernel_vsyscall \n"
-		"mov %%edx, %%ebx \n"
-		: "=a" (ret), "=m" (*ts)
-		: "0" (__NR_clock_gettime), [clock] "g" (clock), "c" (ts)
-		: "edx");
-	return ret;
+	return __cvdso_gettimeofday(tv, tz);
 }
+int gettimeofday(struct __kernel_old_timeval *, struct timezone *)
+	__attribute__((weak, alias("__vdso_gettimeofday")));
 
-#endif
-
-#ifdef CONFIG_PARAVIRT_CLOCK
-static notrace const struct pvclock_vsyscall_time_info *get_pvti0(void)
+notrace time_t __vdso_time(time_t *t)
 {
-	return (const struct pvclock_vsyscall_time_info *)&pvclock_page;
+	return __cvdso_time(t);
 }
+time_t time(time_t *t)
+	__attribute__((weak, alias("__vdso_time")));
 
-static notrace u64 vread_pvclock(void)
-{
-	const struct pvclock_vcpu_time_info *pvti = &get_pvti0()->pvti;
-	u32 version;
-	u64 ret;
-
-	/*
-	 * Note: The kernel and hypervisor must guarantee that cpu ID
-	 * number maps 1:1 to per-CPU pvclock time info.
-	 *
-	 * Because the hypervisor is entirely unaware of guest userspace
-	 * preemption, it cannot guarantee that per-CPU pvclock time
-	 * info is updated if the underlying CPU changes or that that
-	 * version is increased whenever underlying CPU changes.
-	 *
-	 * On KVM, we are guaranteed that pvti updates for any vCPU are
-	 * atomic as seen by *all* vCPUs.  This is an even stronger
-	 * guarantee than we get with a normal seqlock.
-	 *
-	 * On Xen, we don't appear to have that guarantee, but Xen still
-	 * supplies a valid seqlock using the version field.
-	 *
-	 * We only do pvclock vdso timing at all if
-	 * PVCLOCK_TSC_STABLE_BIT is set, and we interpret that bit to
-	 * mean that all vCPUs have matching pvti and that the TSC is
-	 * synced, so we can just look at vCPU 0's pvti.
-	 */
-
-	do {
-		version = pvclock_read_begin(pvti);
-
-		if (unlikely(!(pvti->flags & PVCLOCK_TSC_STABLE_BIT)))
-			return U64_MAX;
-
-		ret = __pvclock_read_cycles(pvti, rdtsc_ordered());
-	} while (pvclock_read_retry(pvti, version));
-
-	return ret;
-}
-#endif
-#ifdef CONFIG_HYPERV_TSCPAGE
-static notrace u64 vread_hvclock(void)
-{
-	const struct ms_hyperv_tsc_page *tsc_pg =
-		(const struct ms_hyperv_tsc_page *)&hvclock_page;
 
-	return hv_read_tsc_page(tsc_pg);
-}
-#endif
+#if defined(CONFIG_X86_64) && !defined(BUILD_VDSO32_64)
+/* both 64-bit and x32 use these */
+extern int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts);
+extern int __vdso_clock_getres(clockid_t clock, struct __kernel_timespec *res);
 
-notrace static inline u64 vgetcyc(int mode)
+notrace int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
 {
-	if (mode == VCLOCK_TSC)
-		return (u64)rdtsc_ordered();
-#ifdef CONFIG_PARAVIRT_CLOCK
-	else if (mode == VCLOCK_PVCLOCK)
-		return vread_pvclock();
-#endif
-#ifdef CONFIG_HYPERV_TSCPAGE
-	else if (mode == VCLOCK_HVCLOCK)
-		return vread_hvclock();
-#endif
-	return U64_MAX;
+	return __cvdso_clock_gettime(clock, ts);
 }
+int clock_gettime(clockid_t, struct __kernel_timespec *)
+	__attribute__((weak, alias("__vdso_clock_gettime")));
 
-notrace static int do_hres(clockid_t clk, struct timespec *ts)
+notrace int __vdso_clock_getres(clockid_t clock,
+				struct __kernel_timespec *res)
 {
-	struct vgtod_ts *base = &gtod->basetime[clk];
-	u64 cycles, last, sec, ns;
-	unsigned int seq;
-
-	do {
-		seq = gtod_read_begin(gtod);
-		cycles = vgetcyc(gtod->vclock_mode);
-		ns = base->nsec;
-		last = gtod->cycle_last;
-		if (unlikely((s64)cycles < 0))
-			return vdso_fallback_gettime(clk, ts);
-		if (cycles > last)
-			ns += (cycles - last) * gtod->mult;
-		ns >>= gtod->shift;
-		sec = base->sec;
-	} while (unlikely(gtod_read_retry(gtod, seq)));
-
-	/*
-	 * Do this outside the loop: a race inside the loop could result
-	 * in __iter_div_u64_rem() being extremely slow.
-	 */
-	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec = ns;
-
-	return 0;
+	return __cvdso_clock_getres(clock, res);
 }
+int clock_getres(clockid_t, struct __kernel_timespec *)
+	__attribute__((weak, alias("__vdso_clock_getres")));
 
-notrace static void do_coarse(clockid_t clk, struct timespec *ts)
-{
-	struct vgtod_ts *base = &gtod->basetime[clk];
-	unsigned int seq;
-
-	do {
-		seq = gtod_read_begin(gtod);
-		ts->tv_sec = base->sec;
-		ts->tv_nsec = base->nsec;
-	} while (unlikely(gtod_read_retry(gtod, seq)));
-}
+#else
+/* i386 only */
+extern int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts);
+extern int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts);
+extern int __vdso_clock_getres(clockid_t clock, struct old_timespec32 *res);
 
-notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
+notrace int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts)
 {
-	unsigned int msk;
-
-	/* Sort out negative (CPU/FD) and invalid clocks */
-	if (unlikely((unsigned int) clock >= MAX_CLOCKS))
-		return vdso_fallback_gettime(clock, ts);
-
-	/*
-	 * Convert the clockid to a bitmask and use it to check which
-	 * clocks are handled in the VDSO directly.
-	 */
-	msk = 1U << clock;
-	if (likely(msk & VGTOD_HRES)) {
-		return do_hres(clock, ts);
-	} else if (msk & VGTOD_COARSE) {
-		do_coarse(clock, ts);
-		return 0;
-	}
-	return vdso_fallback_gettime(clock, ts);
+	return __cvdso_clock_gettime32(clock, ts);
 }
-
-int clock_gettime(clockid_t, struct timespec *)
+int clock_gettime(clockid_t, struct old_timespec32 *)
 	__attribute__((weak, alias("__vdso_clock_gettime")));
 
-notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
+notrace int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts)
 {
-	if (likely(tv != NULL)) {
-		struct timespec *ts = (struct timespec *) tv;
-
-		do_hres(CLOCK_REALTIME, ts);
-		tv->tv_usec /= 1000;
-	}
-	if (unlikely(tz != NULL)) {
-		tz->tz_minuteswest = gtod->tz_minuteswest;
-		tz->tz_dsttime = gtod->tz_dsttime;
-	}
-
-	return 0;
+	return __cvdso_clock_gettime(clock, ts);
 }
-int gettimeofday(struct timeval *, struct timezone *)
-	__attribute__((weak, alias("__vdso_gettimeofday")));
+int clock_gettime64(clockid_t, struct __kernel_timespec *)
+	__attribute__((weak, alias("__vdso_clock_gettime64")));
 
-/*
- * This will break when the xtime seconds get inaccurate, but that is
- * unlikely
- */
-notrace time_t __vdso_time(time_t *t)
+notrace int __vdso_clock_getres(clockid_t clock,
+				struct old_timespec32 *res)
 {
-	/* This is atomic on x86 so we don't need any locks. */
-	time_t result = READ_ONCE(gtod->basetime[CLOCK_REALTIME].sec);
-
-	if (t)
-		*t = result;
-	return result;
+	return __cvdso_clock_getres_time32(clock, res);
 }
-time_t time(time_t *t)
-	__attribute__((weak, alias("__vdso_time")));
+int clock_getres(clockid_t, struct old_timespec32 *)
+	__attribute__((weak, alias("__vdso_clock_getres")));
+#endif
diff --git a/arch/x86/entry/vdso/vdso.lds.S b/arch/x86/entry/vdso/vdso.lds.S
index d3a2dce4cfa9..36b644e16272 100644
--- a/arch/x86/entry/vdso/vdso.lds.S
+++ b/arch/x86/entry/vdso/vdso.lds.S
@@ -25,6 +25,8 @@ VERSION {
 		__vdso_getcpu;
 		time;
 		__vdso_time;
+		clock_getres;
+		__vdso_clock_getres;
 	local: *;
 	};
 }
diff --git a/arch/x86/entry/vdso/vdso32/vdso32.lds.S b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
index 422764a81d32..c7720995ab1a 100644
--- a/arch/x86/entry/vdso/vdso32/vdso32.lds.S
+++ b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
@@ -26,6 +26,8 @@ VERSION
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
 		__vdso_time;
+		__vdso_clock_getres;
+		__vdso_clock_gettime64;
 	};
 
 	LINUX_2.5 {
diff --git a/arch/x86/entry/vdso/vdsox32.lds.S b/arch/x86/entry/vdso/vdsox32.lds.S
index 05cd1c5c4a15..16a8050a4fb6 100644
--- a/arch/x86/entry/vdso/vdsox32.lds.S
+++ b/arch/x86/entry/vdso/vdsox32.lds.S
@@ -21,6 +21,7 @@ VERSION {
 		__vdso_gettimeofday;
 		__vdso_getcpu;
 		__vdso_time;
+		__vdso_clock_getres;
 	local: *;
 	};
 }
diff --git a/arch/x86/entry/vsyscall/Makefile b/arch/x86/entry/vsyscall/Makefile
index 1ac4dd116c26..93c1b3e949a7 100644
--- a/arch/x86/entry/vsyscall/Makefile
+++ b/arch/x86/entry/vsyscall/Makefile
@@ -2,7 +2,5 @@
 #
 # Makefile for the x86 low level vsyscall code
 #
-obj-y					:= vsyscall_gtod.o
-
 obj-$(CONFIG_X86_VSYSCALL_EMULATION)	+= vsyscall_64.o vsyscall_emu_64.o
 
diff --git a/arch/x86/entry/vsyscall/vsyscall_gtod.c b/arch/x86/entry/vsyscall/vsyscall_gtod.c
deleted file mode 100644
index cfcdba082feb..000000000000
--- a/arch/x86/entry/vsyscall/vsyscall_gtod.c
+++ /dev/null
@@ -1,83 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *  Copyright (C) 2001 Andrea Arcangeli <andrea@suse.de> SuSE
- *  Copyright 2003 Andi Kleen, SuSE Labs.
- *
- *  Modified for x86 32 bit architecture by
- *  Stefani Seibold <stefani@seibold.net>
- *  sponsored by Rohde & Schwarz GmbH & Co. KG Munich/Germany
- *
- *  Thanks to hpa@transmeta.com for some useful hint.
- *  Special thanks to Ingo Molnar for his early experience with
- *  a different vsyscall implementation for Linux/IA32 and for the name.
- *
- */
-
-#include <linux/timekeeper_internal.h>
-#include <asm/vgtod.h>
-#include <asm/vvar.h>
-
-int vclocks_used __read_mostly;
-
-DEFINE_VVAR(struct vsyscall_gtod_data, vsyscall_gtod_data);
-
-void update_vsyscall_tz(void)
-{
-	vsyscall_gtod_data.tz_minuteswest = sys_tz.tz_minuteswest;
-	vsyscall_gtod_data.tz_dsttime = sys_tz.tz_dsttime;
-}
-
-void update_vsyscall(struct timekeeper *tk)
-{
-	int vclock_mode = tk->tkr_mono.clock->archdata.vclock_mode;
-	struct vsyscall_gtod_data *vdata = &vsyscall_gtod_data;
-	struct vgtod_ts *base;
-	u64 nsec;
-
-	/* Mark the new vclock used. */
-	BUILD_BUG_ON(VCLOCK_MAX >= 32);
-	WRITE_ONCE(vclocks_used, READ_ONCE(vclocks_used) | (1 << vclock_mode));
-
-	gtod_write_begin(vdata);
-
-	/* copy vsyscall data */
-	vdata->vclock_mode	= vclock_mode;
-	vdata->cycle_last	= tk->tkr_mono.cycle_last;
-	vdata->mask		= tk->tkr_mono.mask;
-	vdata->mult		= tk->tkr_mono.mult;
-	vdata->shift		= tk->tkr_mono.shift;
-
-	base = &vdata->basetime[CLOCK_REALTIME];
-	base->sec = tk->xtime_sec;
-	base->nsec = tk->tkr_mono.xtime_nsec;
-
-	base = &vdata->basetime[CLOCK_TAI];
-	base->sec = tk->xtime_sec + (s64)tk->tai_offset;
-	base->nsec = tk->tkr_mono.xtime_nsec;
-
-	base = &vdata->basetime[CLOCK_MONOTONIC];
-	base->sec = tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
-	nsec = tk->tkr_mono.xtime_nsec;
-	nsec +=	((u64)tk->wall_to_monotonic.tv_nsec << tk->tkr_mono.shift);
-	while (nsec >= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
-		nsec -= ((u64)NSEC_PER_SEC) << tk->tkr_mono.shift;
-		base->sec++;
-	}
-	base->nsec = nsec;
-
-	base = &vdata->basetime[CLOCK_REALTIME_COARSE];
-	base->sec = tk->xtime_sec;
-	base->nsec = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
-
-	base = &vdata->basetime[CLOCK_MONOTONIC_COARSE];
-	base->sec = tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
-	nsec = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
-	nsec += tk->wall_to_monotonic.tv_nsec;
-	while (nsec >= NSEC_PER_SEC) {
-		nsec -= NSEC_PER_SEC;
-		base->sec++;
-	}
-	base->nsec = nsec;
-
-	gtod_write_end(vdata);
-}
diff --git a/arch/x86/include/asm/mshyperv-tsc.h b/arch/x86/include/asm/mshyperv-tsc.h
new file mode 100644
index 000000000000..99c98ccea0bf
--- /dev/null
+++ b/arch/x86/include/asm/mshyperv-tsc.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_MSHYPER_TSCPAGE_H
+#define _ASM_X86_MSHYPER_TSCPAGE_H
+
+#include <asm/hyperv-tlfs.h>
+
+#ifdef CONFIG_HYPERV_TSCPAGE
+struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
+static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
+				       u64 *cur_tsc)
+{
+	u64 scale, offset;
+	u32 sequence;
+
+	/*
+	 * The protocol for reading Hyper-V TSC page is specified in Hypervisor
+	 * Top-Level Functional Specification ver. 3.0 and above. To get the
+	 * reference time we must do the following:
+	 * - READ ReferenceTscSequence
+	 *   A special '0' value indicates the time source is unreliable and we
+	 *   need to use something else. The currently published specification
+	 *   versions (up to 4.0b) contain a mistake and wrongly claim '-1'
+	 *   instead of '0' as the special value, see commit c35b82ef0294.
+	 * - ReferenceTime =
+	 *        ((RDTSC() * ReferenceTscScale) >> 64) + ReferenceTscOffset
+	 * - READ ReferenceTscSequence again. In case its value has changed
+	 *   since our first reading we need to discard ReferenceTime and repeat
+	 *   the whole sequence as the hypervisor was updating the page in
+	 *   between.
+	 */
+	do {
+		sequence = READ_ONCE(tsc_pg->tsc_sequence);
+		if (!sequence)
+			return U64_MAX;
+		/*
+		 * Make sure we read sequence before we read other values from
+		 * TSC page.
+		 */
+		smp_rmb();
+
+		scale = READ_ONCE(tsc_pg->tsc_scale);
+		offset = READ_ONCE(tsc_pg->tsc_offset);
+		*cur_tsc = rdtsc_ordered();
+
+		/*
+		 * Make sure we read sequence after we read all other values
+		 * from TSC page.
+		 */
+		smp_rmb();
+
+	} while (READ_ONCE(tsc_pg->tsc_sequence) != sequence);
+
+	return mul_u64_u64_shr(*cur_tsc, scale, 64) + offset;
+}
+
+static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg)
+{
+	u64 cur_tsc;
+
+	return hv_read_tsc_page_tsc(tsc_pg, &cur_tsc);
+}
+
+#else
+static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
+{
+	return NULL;
+}
+
+static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
+				       u64 *cur_tsc)
+{
+	BUG();
+	return U64_MAX;
+}
+#endif
+#endif
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index cc60e617931c..db095a992f3e 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -7,6 +7,7 @@
 #include <linux/nmi.h>
 #include <asm/io.h>
 #include <asm/hyperv-tlfs.h>
+#include <asm/mshyperv-tsc.h>
 #include <asm/nospec-branch.h>
 
 #define VP_INVAL	U32_MAX
@@ -387,73 +388,4 @@ static inline int hyperv_flush_guest_mapping_range(u64 as,
 }
 #endif /* CONFIG_HYPERV */
 
-#ifdef CONFIG_HYPERV_TSCPAGE
-struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
-static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
-				       u64 *cur_tsc)
-{
-	u64 scale, offset;
-	u32 sequence;
-
-	/*
-	 * The protocol for reading Hyper-V TSC page is specified in Hypervisor
-	 * Top-Level Functional Specification ver. 3.0 and above. To get the
-	 * reference time we must do the following:
-	 * - READ ReferenceTscSequence
-	 *   A special '0' value indicates the time source is unreliable and we
-	 *   need to use something else. The currently published specification
-	 *   versions (up to 4.0b) contain a mistake and wrongly claim '-1'
-	 *   instead of '0' as the special value, see commit c35b82ef0294.
-	 * - ReferenceTime =
-	 *        ((RDTSC() * ReferenceTscScale) >> 64) + ReferenceTscOffset
-	 * - READ ReferenceTscSequence again. In case its value has changed
-	 *   since our first reading we need to discard ReferenceTime and repeat
-	 *   the whole sequence as the hypervisor was updating the page in
-	 *   between.
-	 */
-	do {
-		sequence = READ_ONCE(tsc_pg->tsc_sequence);
-		if (!sequence)
-			return U64_MAX;
-		/*
-		 * Make sure we read sequence before we read other values from
-		 * TSC page.
-		 */
-		smp_rmb();
-
-		scale = READ_ONCE(tsc_pg->tsc_scale);
-		offset = READ_ONCE(tsc_pg->tsc_offset);
-		*cur_tsc = rdtsc_ordered();
-
-		/*
-		 * Make sure we read sequence after we read all other values
-		 * from TSC page.
-		 */
-		smp_rmb();
-
-	} while (READ_ONCE(tsc_pg->tsc_sequence) != sequence);
-
-	return mul_u64_u64_shr(*cur_tsc, scale, 64) + offset;
-}
-
-static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg)
-{
-	u64 cur_tsc;
-
-	return hv_read_tsc_page_tsc(tsc_pg, &cur_tsc);
-}
-
-#else
-static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
-{
-	return NULL;
-}
-
-static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
-				       u64 *cur_tsc)
-{
-	BUG();
-	return U64_MAX;
-}
-#endif
 #endif
diff --git a/arch/x86/include/asm/pvclock.h b/arch/x86/include/asm/pvclock.h
index b6033680d458..19b695ff2c68 100644
--- a/arch/x86/include/asm/pvclock.h
+++ b/arch/x86/include/asm/pvclock.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_PVCLOCK_H
 #define _ASM_X86_PVCLOCK_H
 
-#include <linux/clocksource.h>
+#include <asm/clocksource.h>
 #include <asm/pvclock-abi.h>
 
 /* some helper functions for xen and kvm pv clock sources */
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
new file mode 100644
index 000000000000..45608b1d6ff8
--- /dev/null
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -0,0 +1,203 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Fast user context implementation of clock_gettime, gettimeofday, and time.
+ *
+ * Copyright (C) 2019 ARM Limited.
+ * Copyright 2006 Andi Kleen, SUSE Labs.
+ * 32 Bit compat layer by Stefani Seibold <stefani@seibold.net>
+ *  sponsored by Rohde & Schwarz GmbH & Co. KG Munich/Germany
+ */
+#ifndef __ASM_VDSO_GETTIMEOFDAY_H
+#define __ASM_VDSO_GETTIMEOFDAY_H
+
+#ifndef __ASSEMBLY__
+
+#include <uapi/linux/time.h>
+#include <asm/vgtod.h>
+#include <asm/vvar.h>
+#include <asm/unistd.h>
+#include <asm/msr.h>
+#include <asm/pvclock.h>
+#include <asm/mshyperv-tsc.h>
+
+#define __vdso_data (VVAR(_vdso_data))
+
+#define VDSO_HAS_TIME 1
+
+#ifdef CONFIG_PARAVIRT_CLOCK
+extern u8 pvclock_page[PAGE_SIZE]
+	__attribute__((visibility("hidden")));
+#endif
+
+#ifdef CONFIG_HYPERV_TSCPAGE
+extern u8 hvclock_page[PAGE_SIZE]
+	__attribute__((visibility("hidden")));
+#endif
+
+#ifndef BUILD_VDSO32
+
+static __always_inline notrace long clock_gettime_fallback(
+						clockid_t _clkid,
+						struct __kernel_timespec *_ts)
+{
+	long ret;
+	asm ("syscall" : "=a" (ret), "=m" (*_ts) :
+	     "0" (__NR_clock_gettime), "D" (_clkid), "S" (_ts) :
+	     "rcx", "r11");
+	return ret;
+}
+
+static __always_inline notrace long gettimeofday_fallback(
+						struct __kernel_old_timeval *_tv,
+						struct timezone *_tz)
+{
+	long ret;
+	asm("syscall" : "=a" (ret) :
+	    "0" (__NR_gettimeofday), "D" (_tv), "S" (_tz) : "memory");
+	return ret;
+}
+
+static __always_inline notrace long clock_getres_fallback(
+						clockid_t _clkid,
+						struct __kernel_timespec *_ts)
+{
+	long ret;
+	asm ("syscall" : "=a" (ret), "=m" (*_ts) :
+	     "0" (__NR_clock_getres), "D" (_clkid), "S" (_ts) :
+	     "rcx", "r11");
+	return ret;
+}
+
+#else
+
+static __always_inline notrace long clock_gettime_fallback(
+						clockid_t _clkid,
+						struct __kernel_timespec *_ts)
+{
+	long ret;
+
+	asm (
+		"mov %%ebx, %%edx \n"
+		"mov %[clock], %%ebx \n"
+		"call __kernel_vsyscall \n"
+		"mov %%edx, %%ebx \n"
+		: "=a" (ret), "=m" (*_ts)
+		: "0" (__NR_clock_gettime64), [clock] "g" (_clkid), "c" (_ts)
+		: "edx");
+	return ret;
+}
+
+static __always_inline notrace long gettimeofday_fallback(
+						struct __kernel_old_timeval *_tv,
+						struct timezone *_tz)
+{
+	long ret;
+	asm(
+		"mov %%ebx, %%edx \n"
+		"mov %2, %%ebx \n"
+		"call __kernel_vsyscall \n"
+		"mov %%edx, %%ebx \n"
+		: "=a" (ret)
+		: "0" (__NR_gettimeofday), "g" (_tv), "c" (_tz)
+		: "memory", "edx");
+	return ret;
+}
+
+static __always_inline notrace long clock_getres_fallback(
+						clockid_t _clkid,
+						struct __kernel_timespec *_ts)
+{
+	long ret;
+
+	asm (
+		"mov %%ebx, %%edx \n"
+		"mov %[clock], %%ebx \n"
+		"call __kernel_vsyscall \n"
+		"mov %%edx, %%ebx \n"
+		: "=a" (ret), "=m" (*_ts)
+		: "0" (__NR_clock_getres_time64), [clock] "g" (_clkid), "c" (_ts)
+		: "edx");
+	return ret;
+}
+
+#endif
+
+#ifdef CONFIG_PARAVIRT_CLOCK
+static notrace const struct pvclock_vsyscall_time_info *get_pvti0(void)
+{
+	return (const struct pvclock_vsyscall_time_info *)&pvclock_page;
+}
+
+static notrace u64 vread_pvclock(void)
+{
+	const struct pvclock_vcpu_time_info *pvti = &get_pvti0()->pvti;
+	u32 version;
+	u64 ret;
+
+	/*
+	 * Note: The kernel and hypervisor must guarantee that cpu ID
+	 * number maps 1:1 to per-CPU pvclock time info.
+	 *
+	 * Because the hypervisor is entirely unaware of guest userspace
+	 * preemption, it cannot guarantee that per-CPU pvclock time
+	 * info is updated if the underlying CPU changes or that that
+	 * version is increased whenever underlying CPU changes.
+	 *
+	 * On KVM, we are guaranteed that pvti updates for any vCPU are
+	 * atomic as seen by *all* vCPUs.  This is an even stronger
+	 * guarantee than we get with a normal seqlock.
+	 *
+	 * On Xen, we don't appear to have that guarantee, but Xen still
+	 * supplies a valid seqlock using the version field.
+	 *
+	 * We only do pvclock vdso timing at all if
+	 * PVCLOCK_TSC_STABLE_BIT is set, and we interpret that bit to
+	 * mean that all vCPUs have matching pvti and that the TSC is
+	 * synced, so we can just look at vCPU 0's pvti.
+	 */
+
+	do {
+		version = pvclock_read_begin(pvti);
+
+		if (unlikely(!(pvti->flags & PVCLOCK_TSC_STABLE_BIT)))
+			return U64_MAX;
+
+		ret = __pvclock_read_cycles(pvti, rdtsc_ordered());
+	} while (pvclock_read_retry(pvti, version));
+
+	return ret;
+}
+#endif
+#ifdef CONFIG_HYPERV_TSCPAGE
+static notrace u64 vread_hvclock(void)
+{
+	const struct ms_hyperv_tsc_page *tsc_pg =
+		(const struct ms_hyperv_tsc_page *)&hvclock_page;
+
+	return hv_read_tsc_page(tsc_pg);
+}
+#endif
+
+notrace static inline u64 __arch_get_hw_counter(s32 clock_mode)
+{
+	if (clock_mode == VCLOCK_TSC)
+		return (u64)rdtsc_ordered();
+#ifdef CONFIG_PARAVIRT_CLOCK
+	else if (clock_mode == VCLOCK_PVCLOCK)
+		return vread_pvclock();
+#endif
+#ifdef CONFIG_HYPERV_TSCPAGE
+	else if (clock_mode == VCLOCK_HVCLOCK)
+		return vread_hvclock();
+#endif
+	return U64_MAX;
+}
+
+static __always_inline notrace const struct vdso_data *__arch_get_vdso_data(void)
+{
+	return __vdso_data;
+}
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso/vsyscall.h
new file mode 100644
index 000000000000..0026ab2123ce
--- /dev/null
+++ b/arch/x86/include/asm/vdso/vsyscall.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_VDSO_VSYSCALL_H
+#define __ASM_VDSO_VSYSCALL_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/hrtimer.h>
+#include <linux/timekeeper_internal.h>
+#include <vdso/datapage.h>
+#include <asm/vgtod.h>
+#include <asm/vvar.h>
+
+int vclocks_used __read_mostly;
+
+DEFINE_VVAR(struct vdso_data, _vdso_data);
+/*
+ * Update the vDSO data page to keep in sync with kernel timekeeping.
+ */
+static __always_inline
+struct vdso_data *__x86_get_k_vdso_data(void)
+{
+	return _vdso_data;
+}
+#define __arch_get_k_vdso_data __x86_get_k_vdso_data
+
+static __always_inline
+int __x86_get_clock_mode(struct timekeeper *tk)
+{
+	int vclock_mode = tk->tkr_mono.clock->archdata.vclock_mode;
+
+	/* Mark the new vclock used. */
+	BUILD_BUG_ON(VCLOCK_MAX >= 32);
+	WRITE_ONCE(vclocks_used, READ_ONCE(vclocks_used) | (1 << vclock_mode));
+
+	return vclock_mode;
+}
+#define __arch_get_clock_mode __x86_get_clock_mode
+
+/* The asm-generic header needs to be included after the definitions above */
+#include <asm-generic/vdso/vsyscall.h>
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index 913a133f8e6f..a2638c6124ed 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -3,7 +3,9 @@
 #define _ASM_X86_VGTOD_H
 
 #include <linux/compiler.h>
-#include <linux/clocksource.h>
+#include <asm/clocksource.h>
+#include <vdso/datapage.h>
+#include <vdso/helpers.h>
 
 #include <uapi/linux/time.h>
 
@@ -13,81 +15,10 @@ typedef u64 gtod_long_t;
 typedef unsigned long gtod_long_t;
 #endif
 
-/*
- * There is one of these objects in the vvar page for each
- * vDSO-accelerated clockid.  For high-resolution clocks, this encodes
- * the time corresponding to vsyscall_gtod_data.cycle_last.  For coarse
- * clocks, this encodes the actual time.
- *
- * To confuse the reader, for high-resolution clocks, nsec is left-shifted
- * by vsyscall_gtod_data.shift.
- */
-struct vgtod_ts {
-	u64		sec;
-	u64		nsec;
-};
-
-#define VGTOD_BASES	(CLOCK_TAI + 1)
-#define VGTOD_HRES	(BIT(CLOCK_REALTIME) | BIT(CLOCK_MONOTONIC) | BIT(CLOCK_TAI))
-#define VGTOD_COARSE	(BIT(CLOCK_REALTIME_COARSE) | BIT(CLOCK_MONOTONIC_COARSE))
-
-/*
- * vsyscall_gtod_data will be accessed by 32 and 64 bit code at the same time
- * so be carefull by modifying this structure.
- */
-struct vsyscall_gtod_data {
-	unsigned int	seq;
-
-	int		vclock_mode;
-	u64		cycle_last;
-	u64		mask;
-	u32		mult;
-	u32		shift;
-
-	struct vgtod_ts	basetime[VGTOD_BASES];
-
-	int		tz_minuteswest;
-	int		tz_dsttime;
-};
-extern struct vsyscall_gtod_data vsyscall_gtod_data;
-
 extern int vclocks_used;
 static inline bool vclock_was_used(int vclock)
 {
 	return READ_ONCE(vclocks_used) & (1 << vclock);
 }
 
-static inline unsigned int gtod_read_begin(const struct vsyscall_gtod_data *s)
-{
-	unsigned int ret;
-
-repeat:
-	ret = READ_ONCE(s->seq);
-	if (unlikely(ret & 1)) {
-		cpu_relax();
-		goto repeat;
-	}
-	smp_rmb();
-	return ret;
-}
-
-static inline int gtod_read_retry(const struct vsyscall_gtod_data *s,
-				  unsigned int start)
-{
-	smp_rmb();
-	return unlikely(s->seq != start);
-}
-
-static inline void gtod_write_begin(struct vsyscall_gtod_data *s)
-{
-	++s->seq;
-	smp_wmb();
-}
-
-static inline void gtod_write_end(struct vsyscall_gtod_data *s)
-{
-	smp_wmb();
-	++s->seq;
-}
-
 #endif /* _ASM_X86_VGTOD_H */
diff --git a/arch/x86/include/asm/vvar.h b/arch/x86/include/asm/vvar.h
index 3f32dfc2ab73..2dbde48f27a9 100644
--- a/arch/x86/include/asm/vvar.h
+++ b/arch/x86/include/asm/vvar.h
@@ -32,19 +32,20 @@
 extern char __vvar_page;
 
 #define DECLARE_VVAR(offset, type, name)				\
-	extern type vvar_ ## name __attribute__((visibility("hidden")));
+	extern type vvar_ ## name[CS_BASES]				\
+	__attribute__((visibility("hidden")));
 
 #define VVAR(name) (vvar_ ## name)
 
 #define DEFINE_VVAR(type, name)						\
-	type name							\
+	type name[CS_BASES]						\
 	__attribute__((section(".vvar_" #name), aligned(16))) __visible
 
 #endif
 
 /* DECLARE_VVAR(offset, type, name) */
 
-DECLARE_VVAR(128, struct vsyscall_gtod_data, vsyscall_gtod_data)
+DECLARE_VVAR(128, struct vdso_data, _vdso_data)
 
 #undef DECLARE_VVAR
 
diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
index 0ff3e294d0e5..10125358b9c4 100644
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -3,6 +3,7 @@
 
 */
 
+#include <linux/clocksource.h>
 #include <linux/kernel.h>
 #include <linux/percpu.h>
 #include <linux/notifier.h>
-- 
2.21.0

