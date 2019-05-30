Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7E102FD3B
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2019 16:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfE3OQo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 May 2019 10:16:44 -0400
Received: from foss.arm.com ([217.140.101.70]:36918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbfE3OQn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 10:16:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B85D3165C;
        Thu, 30 May 2019 07:16:42 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AE773F59C;
        Thu, 30 May 2019 07:16:39 -0700 (PDT)
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
Subject: [PATCH v6 17/19] mips: Add support for generic vDSO
Date:   Thu, 30 May 2019 15:15:29 +0100
Message-Id: <20190530141531.43462-18-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530141531.43462-1-vincenzo.frascino@arm.com>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The mips vDSO library requires some adaptations to take advantage of the
newly introduced generic vDSO library.

Introduce the following changes:
 - Modification of vdso.c to be compliant with the common vdso datapage
 - Use of lib/vdso for gettimeofday

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/mips/Kconfig                         |   2 +
 arch/mips/include/asm/vdso.h              |  78 +------
 arch/mips/include/asm/vdso/gettimeofday.h | 175 ++++++++++++++
 arch/mips/{ => include/asm}/vdso/vdso.h   |   6 +-
 arch/mips/include/asm/vdso/vsyscall.h     |  43 ++++
 arch/mips/kernel/vdso.c                   |  37 +--
 arch/mips/vdso/Makefile                   |  25 +-
 arch/mips/vdso/elf.S                      |   2 +-
 arch/mips/vdso/gettimeofday.c             | 273 ----------------------
 arch/mips/vdso/sigreturn.S                |   2 +-
 arch/mips/vdso/vdso.lds.S                 |   4 +
 arch/mips/vdso/vgettimeofday.c            |  57 +++++
 12 files changed, 316 insertions(+), 388 deletions(-)
 create mode 100644 arch/mips/include/asm/vdso/gettimeofday.h
 rename arch/mips/{ => include/asm}/vdso/vdso.h (90%)
 create mode 100644 arch/mips/include/asm/vdso/vsyscall.h
 delete mode 100644 arch/mips/vdso/gettimeofday.c
 create mode 100644 arch/mips/vdso/vgettimeofday.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 70d3200476bf..390c052cac9a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -34,6 +34,7 @@ config MIPS
 	select GENERIC_SCHED_CLOCK if !CAVIUM_OCTEON_SOC
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_GETTIMEOFDAY
 	select HANDLE_DOMAIN_IRQ
 	select HAVE_ARCH_COMPILER_H
 	select HAVE_ARCH_JUMP_LABEL
@@ -72,6 +73,7 @@ config MIPS
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN if 64BIT || !SMP
+	select HAVE_GENERIC_VDSO
 	select IRQ_FORCED_THREADING
 	select ISA if EISA
 	select MODULES_USE_ELF_RELA if MODULES && 64BIT
diff --git a/arch/mips/include/asm/vdso.h b/arch/mips/include/asm/vdso.h
index 91bf0c2c265c..285241da2284 100644
--- a/arch/mips/include/asm/vdso.h
+++ b/arch/mips/include/asm/vdso.h
@@ -12,6 +12,7 @@
 #define __ASM_VDSO_H
 
 #include <linux/mm_types.h>
+#include <vdso/datapage.h>
 
 #include <asm/barrier.h>
 
@@ -53,84 +54,9 @@ extern struct mips_vdso_image vdso_image_o32;
 extern struct mips_vdso_image vdso_image_n32;
 #endif
 
-/**
- * union mips_vdso_data - Data provided by the kernel for the VDSO.
- * @xtime_sec:		Current real time (seconds part).
- * @xtime_nsec:		Current real time (nanoseconds part, shifted).
- * @wall_to_mono_sec:	Wall-to-monotonic offset (seconds part).
- * @wall_to_mono_nsec:	Wall-to-monotonic offset (nanoseconds part).
- * @seq_count:		Counter to synchronise updates (odd = updating).
- * @cs_shift:		Clocksource shift value.
- * @clock_mode:		Clocksource to use for time functions.
- * @cs_mult:		Clocksource multiplier value.
- * @cs_cycle_last:	Clock cycle value at last update.
- * @cs_mask:		Clocksource mask value.
- * @tz_minuteswest:	Minutes west of Greenwich (from timezone).
- * @tz_dsttime:		Type of DST correction (from timezone).
- *
- * This structure contains data needed by functions within the VDSO. It is
- * populated by the kernel and mapped read-only into user memory. The time
- * fields are mirrors of internal data from the timekeeping infrastructure.
- *
- * Note: Care should be taken when modifying as the layout must remain the same
- * for both 64- and 32-bit (for 32-bit userland on 64-bit kernel).
- */
 union mips_vdso_data {
-	struct {
-		u64 xtime_sec;
-		u64 xtime_nsec;
-		u64 wall_to_mono_sec;
-		u64 wall_to_mono_nsec;
-		u32 seq_count;
-		u32 cs_shift;
-		u8 clock_mode;
-		u32 cs_mult;
-		u64 cs_cycle_last;
-		u64 cs_mask;
-		s32 tz_minuteswest;
-		s32 tz_dsttime;
-	};
-
+	struct vdso_data data[CS_BASES];
 	u8 page[PAGE_SIZE];
 };
 
-static inline u32 vdso_data_read_begin(const union mips_vdso_data *data)
-{
-	u32 seq;
-
-	while (true) {
-		seq = READ_ONCE(data->seq_count);
-		if (likely(!(seq & 1))) {
-			/* Paired with smp_wmb() in vdso_data_write_*(). */
-			smp_rmb();
-			return seq;
-		}
-
-		cpu_relax();
-	}
-}
-
-static inline bool vdso_data_read_retry(const union mips_vdso_data *data,
-					u32 start_seq)
-{
-	/* Paired with smp_wmb() in vdso_data_write_*(). */
-	smp_rmb();
-	return unlikely(data->seq_count != start_seq);
-}
-
-static inline void vdso_data_write_begin(union mips_vdso_data *data)
-{
-	++data->seq_count;
-
-	/* Ensure sequence update is written before other data page values. */
-	smp_wmb();
-}
-
-static inline void vdso_data_write_end(union mips_vdso_data *data)
-{
-	/* Ensure data values are written before updating sequence again. */
-	smp_wmb();
-	++data->seq_count;
-}
-
 #endif /* __ASM_VDSO_H */
diff --git a/arch/mips/include/asm/vdso/gettimeofday.h b/arch/mips/include/asm/vdso/gettimeofday.h
new file mode 100644
index 000000000000..a9fb871fb096
--- /dev/null
+++ b/arch/mips/include/asm/vdso/gettimeofday.h
@@ -0,0 +1,175 @@
+/*
+ * Copyright (C) 2018 ARM Limited
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Alex Smith <alex.smith@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef __ASM_VDSO_GETTIMEOFDAY_H
+#define __ASM_VDSO_GETTIMEOFDAY_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/compiler.h>
+#include <linux/time.h>
+
+#include <asm/vdso/vdso.h>
+#include <asm/clocksource.h>
+#include <asm/io.h>
+#include <asm/unistd.h>
+#include <asm/vdso.h>
+
+#ifdef CONFIG_MIPS_CLOCK_VSYSCALL
+
+static __always_inline notrace long gettimeofday_fallback(
+					struct __kernel_old_timeval *_tv,
+					struct timezone *_tz)
+{
+	register struct timezone *tz asm("a1") = _tz;
+	register struct __kernel_old_timeval *tv asm("a0") = _tv;
+	register long ret asm("v0");
+	register long nr asm("v0") = __NR_gettimeofday;
+	register long error asm("a3");
+
+	asm volatile(
+	"       syscall\n"
+	: "=r" (ret), "=r" (error)
+	: "r" (tv), "r" (tz), "r" (nr)
+	: "$1", "$3", "$8", "$9", "$10", "$11", "$12", "$13",
+	  "$14", "$15", "$24", "$25", "hi", "lo", "memory");
+
+	return error ? -ret : ret;
+}
+
+#else
+
+static __always_inline notrace long gettimeofday_fallback(
+					struct __kernel_old_timeval *_tv,
+					struct timezone *_tz)
+{
+	return -1;
+}
+
+#endif
+
+static __always_inline notrace long clock_gettime_fallback(
+						clockid_t _clkid,
+						struct __kernel_timespec *_ts)
+{
+	register struct __kernel_timespec *ts asm("a1") = _ts;
+	register clockid_t clkid asm("a0") = _clkid;
+	register long ret asm("v0");
+#if _MIPS_SIM == _MIPS_SIM_ABI64
+	register long nr asm("v0") = __NR_clock_gettime;
+#else
+	register long nr asm("v0") = __NR_clock_gettime64;
+#endif
+	register long error asm("a3");
+
+	asm volatile(
+	"       syscall\n"
+	: "=r" (ret), "=r" (error)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "$1", "$3", "$8", "$9", "$10", "$11", "$12", "$13",
+	  "$14", "$15", "$24", "$25", "hi", "lo", "memory");
+
+	return error ? -ret : ret;
+}
+
+static __always_inline notrace int clock_getres_fallback(
+						clockid_t _clkid,
+						struct __kernel_timespec *_ts)
+{
+	register struct __kernel_timespec *ts asm("a1") = _ts;
+	register clockid_t clkid asm("a0") = _clkid;
+	register long ret asm("v0");
+#if _MIPS_SIM == _MIPS_SIM_ABI64
+	register long nr asm("v0") = __NR_clock_getres;
+#else
+	register long nr asm("v0") = __NR_clock_getres_time64;
+#endif
+	register long error asm("a3");
+
+	asm volatile(
+	"       syscall\n"
+	: "=r" (ret), "=r" (error)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "$1", "$3", "$8", "$9", "$10", "$11", "$12", "$13",
+	  "$14", "$15", "$24", "$25", "hi", "lo", "memory");
+
+	return error ? -ret : ret;
+}
+
+#ifdef CONFIG_CSRC_R4K
+
+static __always_inline u64 read_r4k_count(void)
+{
+	unsigned int count;
+
+	__asm__ __volatile__(
+	"	.set push\n"
+	"	.set mips32r2\n"
+	"	rdhwr	%0, $2\n"
+	"	.set pop\n"
+	: "=r" (count));
+
+	return count;
+}
+
+#endif
+
+#ifdef CONFIG_CLKSRC_MIPS_GIC
+
+static __always_inline u64 read_gic_count(const struct vdso_data *data)
+{
+	void __iomem *gic = get_gic(data);
+	u32 hi, hi2, lo;
+
+	do {
+		hi = __raw_readl(gic + sizeof(lo));
+		lo = __raw_readl(gic);
+		hi2 = __raw_readl(gic + sizeof(lo));
+	} while (hi2 != hi);
+
+	return (((u64)hi) << 32) + lo;
+}
+
+#endif
+
+static __always_inline notrace u64 __arch_get_hw_counter(s32 clock_mode)
+{
+#ifdef CONFIG_CLKSRC_MIPS_GIC
+	const struct vdso_data *data = get_vdso_data();
+#endif
+	u64 cycle_now;
+
+	switch (clock_mode) {
+#ifdef CONFIG_CSRC_R4K
+	case VDSO_CLOCK_R4K:
+		cycle_now = read_r4k_count();
+		break;
+#endif
+#ifdef CONFIG_CLKSRC_MIPS_GIC
+	case VDSO_CLOCK_GIC:
+		cycle_now = read_gic_count(data);
+		break;
+#endif
+	default:
+		cycle_now = 0;
+		break;
+	}
+
+	return cycle_now;
+}
+
+static __always_inline notrace const struct vdso_data *__arch_get_vdso_data(void)
+{
+	return get_vdso_data();
+}
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/mips/vdso/vdso.h b/arch/mips/include/asm/vdso/vdso.h
similarity index 90%
rename from arch/mips/vdso/vdso.h
rename to arch/mips/include/asm/vdso/vdso.h
index cfb1be441dec..048d12fbb925 100644
--- a/arch/mips/vdso/vdso.h
+++ b/arch/mips/include/asm/vdso/vdso.h
@@ -72,14 +72,14 @@ static inline unsigned long get_vdso_base(void)
 	return addr;
 }
 
-static inline const union mips_vdso_data *get_vdso_data(void)
+static inline const struct vdso_data *get_vdso_data(void)
 {
-	return (const union mips_vdso_data *)(get_vdso_base() - PAGE_SIZE);
+	return (const struct vdso_data *)(get_vdso_base() - PAGE_SIZE);
 }
 
 #ifdef CONFIG_CLKSRC_MIPS_GIC
 
-static inline void __iomem *get_gic(const union mips_vdso_data *data)
+static inline void __iomem *get_gic(const struct vdso_data *data)
 {
 	return (void __iomem *)data - PAGE_SIZE;
 }
diff --git a/arch/mips/include/asm/vdso/vsyscall.h b/arch/mips/include/asm/vdso/vsyscall.h
new file mode 100644
index 000000000000..195314732233
--- /dev/null
+++ b/arch/mips/include/asm/vdso/vsyscall.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_VDSO_VSYSCALL_H
+#define __ASM_VDSO_VSYSCALL_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/timekeeper_internal.h>
+#include <vdso/datapage.h>
+
+extern struct vdso_data *vdso_data;
+
+/*
+ * Update the vDSO data page to keep in sync with kernel timekeeping.
+ */
+static __always_inline
+struct vdso_data *__mips_get_k_vdso_data(void)
+{
+	return vdso_data;
+}
+#define __arch_get_k_vdso_data __mips_get_k_vdso_data
+
+static __always_inline
+int __mips_get_clock_mode(struct timekeeper *tk)
+{
+	u32 clock_mode = tk->tkr_mono.clock->archdata.vdso_clock_mode;
+
+	return clock_mode;
+}
+#define __arch_get_clock_mode __mips_get_clock_mode
+
+static __always_inline
+int __mips_use_vsyscall(struct vdso_data *vdata)
+{
+	return (vdata[CS_HRES_COARSE].clock_mode != VDSO_CLOCK_NONE);
+}
+#define __arch_use_vsyscall __mips_use_vsyscall
+
+/* The asm-generic header needs to be included after the definitions above */
+#include <asm-generic/vdso/vsyscall.h>
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index 9df3ebdc7b0f..157ee8045035 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -24,9 +24,12 @@
 #include <asm/mips-cps.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
+#include <vdso/helpers.h>
+#include <vdso/vsyscall.h>
 
 /* Kernel-provided data used by the VDSO. */
-static union mips_vdso_data vdso_data __page_aligned_data;
+static union mips_vdso_data mips_vdso_data __page_aligned_data;
+struct vdso_data *vdso_data = mips_vdso_data.data;
 
 /*
  * Mapping for the VDSO data/GIC pages. The real pages are mapped manually, as
@@ -70,34 +73,6 @@ static int __init init_vdso(void)
 }
 subsys_initcall(init_vdso);
 
-void update_vsyscall(struct timekeeper *tk)
-{
-	vdso_data_write_begin(&vdso_data);
-
-	vdso_data.xtime_sec = tk->xtime_sec;
-	vdso_data.xtime_nsec = tk->tkr_mono.xtime_nsec;
-	vdso_data.wall_to_mono_sec = tk->wall_to_monotonic.tv_sec;
-	vdso_data.wall_to_mono_nsec = tk->wall_to_monotonic.tv_nsec;
-	vdso_data.cs_shift = tk->tkr_mono.shift;
-
-	vdso_data.clock_mode = tk->tkr_mono.clock->archdata.vdso_clock_mode;
-	if (vdso_data.clock_mode != VDSO_CLOCK_NONE) {
-		vdso_data.cs_mult = tk->tkr_mono.mult;
-		vdso_data.cs_cycle_last = tk->tkr_mono.cycle_last;
-		vdso_data.cs_mask = tk->tkr_mono.mask;
-	}
-
-	vdso_data_write_end(&vdso_data);
-}
-
-void update_vsyscall_tz(void)
-{
-	if (vdso_data.clock_mode != VDSO_CLOCK_NONE) {
-		vdso_data.tz_minuteswest = sys_tz.tz_minuteswest;
-		vdso_data.tz_dsttime = sys_tz.tz_dsttime;
-	}
-}
-
 static unsigned long vdso_base(void)
 {
 	unsigned long base;
@@ -167,7 +142,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	 */
 	if (cpu_has_dc_aliases) {
 		base = __ALIGN_MASK(base, shm_align_mask);
-		base += ((unsigned long)&vdso_data - gic_size) & shm_align_mask;
+		base += ((unsigned long)vdso_data - gic_size) & shm_align_mask;
 	}
 
 	data_addr = base + gic_size;
@@ -193,7 +168,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	/* Map data page. */
 	ret = remap_pfn_range(vma, data_addr,
-			      virt_to_phys(&vdso_data) >> PAGE_SHIFT,
+			      virt_to_phys(vdso_data) >> PAGE_SHIFT,
 			      PAGE_SIZE, PAGE_READONLY);
 	if (ret)
 		goto out;
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 7221df24cb23..96420357d5bf 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -1,6 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 # Objects to go into the VDSO.
-obj-vdso-y := elf.o gettimeofday.o sigreturn.o
+
+# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
+# the inclusion of generic Makefile.
+ARCH_REL_TYPE_ABS := R_MIPS_JUMP_SLOT|R_MIPS_GLOB_DAT
+include $(srctree)/lib/vdso/Makefile
+
+obj-vdso-y := elf.o vgettimeofday.o sigreturn.o
 
 # Common compiler flags between ABIs.
 ccflags-vdso := \
@@ -15,15 +21,23 @@ ifdef CONFIG_CC_IS_CLANG
 ccflags-vdso += $(filter --target=%,$(KBUILD_CFLAGS))
 endif
 
+#
+# The -fno-jump-tables flag only prevents the compiler from generating
+# jump tables but does not prevent the compiler from emitting absolute
+# offsets.
 cflags-vdso := $(ccflags-vdso) \
 	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
-	-O2 -g -fPIC -fno-strict-aliasing -fno-common -fno-builtin -G 0 \
-	-DDISABLE_BRANCH_PROFILING \
+	-O3 -g -fPIC -fno-strict-aliasing -fno-common -fno-builtin -G 0 \
+	-fno-stack-protector -fno-jump-tables -DDISABLE_BRANCH_PROFILING \
 	$(call cc-option, -fno-asynchronous-unwind-tables) \
 	$(call cc-option, -fno-stack-protector)
 aflags-vdso := $(ccflags-vdso) \
 	-D__ASSEMBLY__ -Wa,-gdwarf-2
 
+ifneq ($(c-gettimeofday-y),)
+CFLAGS_vgettimeofday.o = -include $(c-gettimeofday-y)
+endif
+
 #
 # For the pre-R6 code in arch/mips/vdso/vdso.h for locating
 # the base address of VDSO, the linker will emit a R_MIPS_PC32
@@ -48,6 +62,8 @@ VDSO_LDFLAGS := \
 	$(addprefix -Wl$(comma),$(filter -E%,$(KBUILD_CFLAGS))) \
 	-nostdlib -shared -Wl,--hash-style=sysv -Wl,--build-id
 
+CFLAGS_REMOVE_vdso.o = -pg
+
 GCOV_PROFILE := n
 UBSAN_SANITIZE := n
 
@@ -96,6 +112,7 @@ $(obj)/vdso.lds: KBUILD_CPPFLAGS := $(ccflags-vdso) $(native-abi)
 
 $(obj)/vdso.so.dbg.raw: $(obj)/vdso.lds $(obj-vdso) FORCE
 	$(call if_changed,vdsold)
+	$(call if_changed,vdso_check)
 
 $(obj)/vdso-image.c: $(obj)/vdso.so.dbg.raw $(obj)/vdso.so.raw \
                      $(obj)/genvdso FORCE
@@ -134,6 +151,7 @@ $(obj)/vdso-o32.lds: $(src)/vdso.lds.S FORCE
 
 $(obj)/vdso-o32.so.dbg.raw: $(obj)/vdso-o32.lds $(obj-vdso-o32) FORCE
 	$(call if_changed,vdsold)
+	$(call if_changed,vdso_check)
 
 $(obj)/vdso-o32-image.c: VDSO_NAME := o32
 $(obj)/vdso-o32-image.c: $(obj)/vdso-o32.so.dbg.raw $(obj)/vdso-o32.so.raw \
@@ -174,6 +192,7 @@ $(obj)/vdso-n32.lds: $(src)/vdso.lds.S FORCE
 
 $(obj)/vdso-n32.so.dbg.raw: $(obj)/vdso-n32.lds $(obj-vdso-n32) FORCE
 	$(call if_changed,vdsold)
+	$(call if_changed,vdso_check)
 
 $(obj)/vdso-n32-image.c: VDSO_NAME := n32
 $(obj)/vdso-n32-image.c: $(obj)/vdso-n32.so.dbg.raw $(obj)/vdso-n32.so.raw \
diff --git a/arch/mips/vdso/elf.S b/arch/mips/vdso/elf.S
index 428a1917afc6..c0c85d126094 100644
--- a/arch/mips/vdso/elf.S
+++ b/arch/mips/vdso/elf.S
@@ -8,7 +8,7 @@
  * option) any later version.
  */
 
-#include "vdso.h"
+#include <asm/vdso/vdso.h>
 
 #include <asm/isa-rev.h>
 
diff --git a/arch/mips/vdso/gettimeofday.c b/arch/mips/vdso/gettimeofday.c
deleted file mode 100644
index e22b422f282c..000000000000
--- a/arch/mips/vdso/gettimeofday.c
+++ /dev/null
@@ -1,273 +0,0 @@
-/*
- * Copyright (C) 2015 Imagination Technologies
- * Author: Alex Smith <alex.smith@imgtec.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include "vdso.h"
-
-#include <linux/compiler.h>
-#include <linux/time.h>
-
-#include <asm/clocksource.h>
-#include <asm/io.h>
-#include <asm/unistd.h>
-#include <asm/vdso.h>
-
-#ifdef CONFIG_MIPS_CLOCK_VSYSCALL
-
-static __always_inline long gettimeofday_fallback(struct timeval *_tv,
-					  struct timezone *_tz)
-{
-	register struct timezone *tz asm("a1") = _tz;
-	register struct timeval *tv asm("a0") = _tv;
-	register long ret asm("v0");
-	register long nr asm("v0") = __NR_gettimeofday;
-	register long error asm("a3");
-
-	asm volatile(
-	"       syscall\n"
-	: "=r" (ret), "=r" (error)
-	: "r" (tv), "r" (tz), "r" (nr)
-	: "$1", "$3", "$8", "$9", "$10", "$11", "$12", "$13",
-	  "$14", "$15", "$24", "$25", "hi", "lo", "memory");
-
-	return error ? -ret : ret;
-}
-
-#endif
-
-static __always_inline long clock_gettime_fallback(clockid_t _clkid,
-					   struct timespec *_ts)
-{
-	register struct timespec *ts asm("a1") = _ts;
-	register clockid_t clkid asm("a0") = _clkid;
-	register long ret asm("v0");
-	register long nr asm("v0") = __NR_clock_gettime;
-	register long error asm("a3");
-
-	asm volatile(
-	"       syscall\n"
-	: "=r" (ret), "=r" (error)
-	: "r" (clkid), "r" (ts), "r" (nr)
-	: "$1", "$3", "$8", "$9", "$10", "$11", "$12", "$13",
-	  "$14", "$15", "$24", "$25", "hi", "lo", "memory");
-
-	return error ? -ret : ret;
-}
-
-static __always_inline int do_realtime_coarse(struct timespec *ts,
-					      const union mips_vdso_data *data)
-{
-	u32 start_seq;
-
-	do {
-		start_seq = vdso_data_read_begin(data);
-
-		ts->tv_sec = data->xtime_sec;
-		ts->tv_nsec = data->xtime_nsec >> data->cs_shift;
-	} while (vdso_data_read_retry(data, start_seq));
-
-	return 0;
-}
-
-static __always_inline int do_monotonic_coarse(struct timespec *ts,
-					       const union mips_vdso_data *data)
-{
-	u32 start_seq;
-	u64 to_mono_sec;
-	u64 to_mono_nsec;
-
-	do {
-		start_seq = vdso_data_read_begin(data);
-
-		ts->tv_sec = data->xtime_sec;
-		ts->tv_nsec = data->xtime_nsec >> data->cs_shift;
-
-		to_mono_sec = data->wall_to_mono_sec;
-		to_mono_nsec = data->wall_to_mono_nsec;
-	} while (vdso_data_read_retry(data, start_seq));
-
-	ts->tv_sec += to_mono_sec;
-	timespec_add_ns(ts, to_mono_nsec);
-
-	return 0;
-}
-
-#ifdef CONFIG_CSRC_R4K
-
-static __always_inline u64 read_r4k_count(void)
-{
-	unsigned int count;
-
-	__asm__ __volatile__(
-	"	.set push\n"
-	"	.set mips32r2\n"
-	"	rdhwr	%0, $2\n"
-	"	.set pop\n"
-	: "=r" (count));
-
-	return count;
-}
-
-#endif
-
-#ifdef CONFIG_CLKSRC_MIPS_GIC
-
-static __always_inline u64 read_gic_count(const union mips_vdso_data *data)
-{
-	void __iomem *gic = get_gic(data);
-	u32 hi, hi2, lo;
-
-	do {
-		hi = __raw_readl(gic + sizeof(lo));
-		lo = __raw_readl(gic);
-		hi2 = __raw_readl(gic + sizeof(lo));
-	} while (hi2 != hi);
-
-	return (((u64)hi) << 32) + lo;
-}
-
-#endif
-
-static __always_inline u64 get_ns(const union mips_vdso_data *data)
-{
-	u64 cycle_now, delta, nsec;
-
-	switch (data->clock_mode) {
-#ifdef CONFIG_CSRC_R4K
-	case VDSO_CLOCK_R4K:
-		cycle_now = read_r4k_count();
-		break;
-#endif
-#ifdef CONFIG_CLKSRC_MIPS_GIC
-	case VDSO_CLOCK_GIC:
-		cycle_now = read_gic_count(data);
-		break;
-#endif
-	default:
-		return 0;
-	}
-
-	delta = (cycle_now - data->cs_cycle_last) & data->cs_mask;
-
-	nsec = (delta * data->cs_mult) + data->xtime_nsec;
-	nsec >>= data->cs_shift;
-
-	return nsec;
-}
-
-static __always_inline int do_realtime(struct timespec *ts,
-				       const union mips_vdso_data *data)
-{
-	u32 start_seq;
-	u64 ns;
-
-	do {
-		start_seq = vdso_data_read_begin(data);
-
-		if (data->clock_mode == VDSO_CLOCK_NONE)
-			return -ENOSYS;
-
-		ts->tv_sec = data->xtime_sec;
-		ns = get_ns(data);
-	} while (vdso_data_read_retry(data, start_seq));
-
-	ts->tv_nsec = 0;
-	timespec_add_ns(ts, ns);
-
-	return 0;
-}
-
-static __always_inline int do_monotonic(struct timespec *ts,
-					const union mips_vdso_data *data)
-{
-	u32 start_seq;
-	u64 ns;
-	u64 to_mono_sec;
-	u64 to_mono_nsec;
-
-	do {
-		start_seq = vdso_data_read_begin(data);
-
-		if (data->clock_mode == VDSO_CLOCK_NONE)
-			return -ENOSYS;
-
-		ts->tv_sec = data->xtime_sec;
-		ns = get_ns(data);
-
-		to_mono_sec = data->wall_to_mono_sec;
-		to_mono_nsec = data->wall_to_mono_nsec;
-	} while (vdso_data_read_retry(data, start_seq));
-
-	ts->tv_sec += to_mono_sec;
-	ts->tv_nsec = 0;
-	timespec_add_ns(ts, ns + to_mono_nsec);
-
-	return 0;
-}
-
-#ifdef CONFIG_MIPS_CLOCK_VSYSCALL
-
-/*
- * This is behind the ifdef so that we don't provide the symbol when there's no
- * possibility of there being a usable clocksource, because there's nothing we
- * can do without it. When libc fails the symbol lookup it should fall back on
- * the standard syscall path.
- */
-int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
-{
-	const union mips_vdso_data *data = get_vdso_data();
-	struct timespec ts;
-	int ret;
-
-	ret = do_realtime(&ts, data);
-	if (ret)
-		return gettimeofday_fallback(tv, tz);
-
-	if (tv) {
-		tv->tv_sec = ts.tv_sec;
-		tv->tv_usec = ts.tv_nsec / 1000;
-	}
-
-	if (tz) {
-		tz->tz_minuteswest = data->tz_minuteswest;
-		tz->tz_dsttime = data->tz_dsttime;
-	}
-
-	return 0;
-}
-
-#endif /* CONFIG_MIPS_CLOCK_VSYSCALL */
-
-int __vdso_clock_gettime(clockid_t clkid, struct timespec *ts)
-{
-	const union mips_vdso_data *data = get_vdso_data();
-	int ret = -1;
-
-	switch (clkid) {
-	case CLOCK_REALTIME_COARSE:
-		ret = do_realtime_coarse(ts, data);
-		break;
-	case CLOCK_MONOTONIC_COARSE:
-		ret = do_monotonic_coarse(ts, data);
-		break;
-	case CLOCK_REALTIME:
-		ret = do_realtime(ts, data);
-		break;
-	case CLOCK_MONOTONIC:
-		ret = do_monotonic(ts, data);
-		break;
-	default:
-		break;
-	}
-
-	if (ret)
-		ret = clock_gettime_fallback(clkid, ts);
-
-	return ret;
-}
diff --git a/arch/mips/vdso/sigreturn.S b/arch/mips/vdso/sigreturn.S
index 30c6219912ac..c2b05956e4cb 100644
--- a/arch/mips/vdso/sigreturn.S
+++ b/arch/mips/vdso/sigreturn.S
@@ -8,7 +8,7 @@
  * option) any later version.
  */
 
-#include "vdso.h"
+#include <asm/vdso/vdso.h>
 
 #include <uapi/asm/unistd.h>
 
diff --git a/arch/mips/vdso/vdso.lds.S b/arch/mips/vdso/vdso.lds.S
index 8df7dd53e8e0..659fe0c3750a 100644
--- a/arch/mips/vdso/vdso.lds.S
+++ b/arch/mips/vdso/vdso.lds.S
@@ -99,6 +99,10 @@ VERSION
 	global:
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
+		__vdso_clock_getres;
+#if _MIPS_SIM != _MIPS_SIM_ABI64
+		__vdso_clock_gettime64;
+#endif
 #endif
 	local: *;
 	};
diff --git a/arch/mips/vdso/vgettimeofday.c b/arch/mips/vdso/vgettimeofday.c
new file mode 100644
index 000000000000..41b6a21cd1d1
--- /dev/null
+++ b/arch/mips/vdso/vgettimeofday.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MIPS64 and compat userspace implementations of gettimeofday()
+ * and similar.
+ *
+ * Copyright (C) 2018 ARM Limited
+ *
+ */
+#include <linux/time.h>
+#include <linux/types.h>
+
+#if _MIPS_SIM != _MIPS_SIM_ABI64
+notrace int __vdso_clock_gettime(clockid_t clock,
+				 struct old_timespec32 *ts)
+{
+	return __cvdso_clock_gettime32(clock, ts);
+}
+
+notrace int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
+				struct timezone *tz)
+{
+	return __cvdso_gettimeofday(tv, tz);
+}
+
+notrace int __vdso_clock_getres(clockid_t clock_id,
+				struct old_timespec32 *res)
+{
+	return __cvdso_clock_getres_time32(clock_id, res);
+}
+
+notrace int __vdso_clock_gettime_time64(clockid_t clock,
+				 struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_gettime(clock, ts);
+}
+
+#else
+
+notrace int __vdso_clock_gettime(clockid_t clock,
+				 struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_gettime(clock, ts);
+}
+
+notrace int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
+				struct timezone *tz)
+{
+	return __cvdso_gettimeofday(tv, tz);
+}
+
+notrace int __vdso_clock_getres(clockid_t clock_id,
+				struct __kernel_timespec *res)
+{
+	return __cvdso_clock_getres(clock_id, res);
+}
+
+#endif
-- 
2.21.0

