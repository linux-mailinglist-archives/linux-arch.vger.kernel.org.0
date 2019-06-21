Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4A64E508
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2019 11:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfFUJxg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jun 2019 05:53:36 -0400
Received: from foss.arm.com ([217.140.110.172]:55438 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbfFUJxg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Jun 2019 05:53:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22C031509;
        Fri, 21 Jun 2019 02:53:35 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B4993F246;
        Fri, 21 Jun 2019 02:53:32 -0700 (PDT)
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
        Huw Davies <huw@codeweavers.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v7 10/25] arm64: compat: Add vDSO
Date:   Fri, 21 Jun 2019 10:52:37 +0100
Message-Id: <20190621095252.32307-11-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190621095252.32307-1-vincenzo.frascino@arm.com>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Provide the arm64 compat (AArch32) vDSO in kernel/vdso32 in a similar
way to what happens in kernel/vdso.

The compat vDSO leverages on an adaptation of the arm architecture code
with few changes:
 - Use of lib/vdso for gettimeofday
 - Implementation of syscall based fallback
 - Introduction of clock_getres for the compat library
 - Implementation of trampolines
 - Implementation of elf note

To build the compat vDSO a 32 bit compiler is required and needs to be
specified via CONFIG_CROSS_COMPILE_COMPAT_VDSO.

The implementation of the configuration option will be contained in a
future patch.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Tested-by: Shijith Thotton <sthotton@marvell.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/include/asm/vdso/compat_barrier.h  |  51 +++++
 .../include/asm/vdso/compat_gettimeofday.h    | 110 +++++++++++
 arch/arm64/kernel/vdso32/.gitignore           |   2 +
 arch/arm64/kernel/vdso32/Makefile             | 186 ++++++++++++++++++
 arch/arm64/kernel/vdso32/note.c               |  15 ++
 arch/arm64/kernel/vdso32/sigreturn.S          |  62 ++++++
 arch/arm64/kernel/vdso32/vdso.S               |  19 ++
 arch/arm64/kernel/vdso32/vdso.lds.S           |  82 ++++++++
 arch/arm64/kernel/vdso32/vgettimeofday.c      |  59 ++++++
 9 files changed, 586 insertions(+)
 create mode 100644 arch/arm64/include/asm/vdso/compat_barrier.h
 create mode 100644 arch/arm64/include/asm/vdso/compat_gettimeofday.h
 create mode 100644 arch/arm64/kernel/vdso32/.gitignore
 create mode 100644 arch/arm64/kernel/vdso32/Makefile
 create mode 100644 arch/arm64/kernel/vdso32/note.c
 create mode 100644 arch/arm64/kernel/vdso32/sigreturn.S
 create mode 100644 arch/arm64/kernel/vdso32/vdso.S
 create mode 100644 arch/arm64/kernel/vdso32/vdso.lds.S
 create mode 100644 arch/arm64/kernel/vdso32/vgettimeofday.c

diff --git a/arch/arm64/include/asm/vdso/compat_barrier.h b/arch/arm64/include/asm/vdso/compat_barrier.h
new file mode 100644
index 000000000000..ea24ea856b07
--- /dev/null
+++ b/arch/arm64/include/asm/vdso/compat_barrier.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 ARM Limited
+ */
+#ifndef __COMPAT_BARRIER_H
+#define __COMPAT_BARRIER_H
+
+#ifndef __ASSEMBLY__
+/*
+ * Warning: This code is meant to be used with
+ * ENABLE_COMPAT_VDSO only.
+ */
+#ifndef ENABLE_COMPAT_VDSO
+#error This header is meant to be used with ENABLE_COMPAT_VDSO only
+#endif
+
+#ifdef dmb
+#undef dmb
+#endif
+
+#if __LINUX_ARM_ARCH__ >= 7
+#define dmb(option) __asm__ __volatile__ ("dmb " #option : : : "memory")
+#elif __LINUX_ARM_ARCH__ == 6
+#define dmb(x) __asm__ __volatile__ ("mcr p15, 0, %0, c7, c10, 5" \
+				    : : "r" (0) : "memory")
+#else
+#define dmb(x) __asm__ __volatile__ ("" : : : "memory")
+#endif
+
+#if __LINUX_ARM_ARCH__ >= 8
+#define aarch32_smp_mb()	dmb(ish)
+#define aarch32_smp_rmb()	dmb(ishld)
+#define aarch32_smp_wmb()	dmb(ishst)
+#else
+#define aarch32_smp_mb()	dmb(ish)
+#define aarch32_smp_rmb()	aarch32_smp_mb()
+#define aarch32_smp_wmb()	dmb(ishst)
+#endif
+
+
+#undef smp_mb
+#undef smp_rmb
+#undef smp_wmb
+
+#define smp_mb()	aarch32_smp_mb()
+#define smp_rmb()	aarch32_smp_rmb()
+#define smp_wmb()	aarch32_smp_wmb()
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __COMPAT_BARRIER_H */
diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
new file mode 100644
index 000000000000..7a39c8340936
--- /dev/null
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 ARM Limited
+ */
+#ifndef __ASM_VDSO_GETTIMEOFDAY_H
+#define __ASM_VDSO_GETTIMEOFDAY_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/unistd.h>
+#include <uapi/linux/time.h>
+
+#include <asm/vdso/compat_barrier.h>
+
+#define VDSO_HAS_CLOCK_GETRES		1
+
+static __always_inline int gettimeofday_fallback(
+				struct __kernel_old_timeval *_tv,
+				struct timezone *_tz)
+{
+	register struct timezone *tz asm("r1") = _tz;
+	register struct __kernel_old_timeval *tv asm("r0") = _tv;
+	register long ret asm ("r0");
+	register long nr asm("r7") = __NR_compat_gettimeofday;
+
+	asm volatile(
+	"	swi #0\n"
+	: "=r" (ret)
+	: "r" (tv), "r" (tz), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+static __always_inline long clock_gettime_fallback(
+				clockid_t _clkid,
+				struct __kernel_timespec *_ts)
+{
+	register struct __kernel_timespec *ts asm("r1") = _ts;
+	register clockid_t clkid asm("r0") = _clkid;
+	register long ret asm ("r0");
+	register long nr asm("r7") = __NR_compat_clock_gettime64;
+
+	asm volatile(
+	"	swi #0\n"
+	: "=r" (ret)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+static __always_inline int clock_getres_fallback(
+				clockid_t _clkid,
+				struct __kernel_timespec *_ts)
+{
+	register struct __kernel_timespec *ts asm("r1") = _ts;
+	register clockid_t clkid asm("r0") = _clkid;
+	register long ret asm ("r0");
+	register long nr asm("r7") = __NR_compat_clock_getres_time64;
+
+	/* The checks below are required for ABI consistency with arm */
+	if ((_clkid >= MAX_CLOCKS) && (_ts == NULL))
+		return -EINVAL;
+
+	asm volatile(
+	"       swi #0\n"
+	: "=r" (ret)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
+{
+	u64 res;
+
+	isb();
+	asm volatile("mrrc p15, 1, %Q0, %R0, c14" : "=r" (res));
+
+	return res;
+}
+
+static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
+{
+	const struct vdso_data *ret;
+
+	/*
+	 * This simply puts &_vdso_data into ret. The reason why we don't use
+	 * `ret = _vdso_data` is that the compiler tends to optimise this in a
+	 * very suboptimal way: instead of keeping &_vdso_data in a register,
+	 * it goes through a relocation almost every time _vdso_data must be
+	 * accessed (even in subfunctions). This is both time and space
+	 * consuming: each relocation uses a word in the code section, and it
+	 * has to be loaded at runtime.
+	 *
+	 * This trick hides the assignment from the compiler. Since it cannot
+	 * track where the pointer comes from, it will only use one relocation
+	 * where __arch_get_vdso_data() is called, and then keep the result in
+	 * a register.
+	 */
+	asm volatile("mov %0, %1" : "=r"(ret) : "r"(_vdso_data));
+
+	return ret;
+}
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/arm64/kernel/vdso32/.gitignore b/arch/arm64/kernel/vdso32/.gitignore
new file mode 100644
index 000000000000..4fea950fa5ed
--- /dev/null
+++ b/arch/arm64/kernel/vdso32/.gitignore
@@ -0,0 +1,2 @@
+vdso.lds
+vdso.so.raw
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
new file mode 100644
index 000000000000..288c14d30b45
--- /dev/null
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -0,0 +1,186 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for vdso32
+#
+
+# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
+# the inclusion of generic Makefile.
+ARCH_REL_TYPE_ABS := R_ARM_JUMP_SLOT|R_ARM_GLOB_DAT|R_ARM_ABS32
+include $(srctree)/lib/vdso/Makefile
+
+COMPATCC := $(CROSS_COMPILE_COMPAT)gcc
+
+# Same as cc-*option, but using COMPATCC instead of CC
+cc32-option = $(call try-run,\
+        $(COMPATCC) $(1) -c -x c /dev/null -o "$$TMP",$(1),$(2))
+cc32-disable-warning = $(call try-run,\
+	$(COMPATCC) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
+cc32-ldoption = $(call try-run,\
+        $(COMPATCC) $(1) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
+
+# We cannot use the global flags to compile the vDSO files, the main reason
+# being that the 32-bit compiler may be older than the main (64-bit) compiler
+# and therefore may not understand flags set using $(cc-option ...). Besides,
+# arch-specific options should be taken from the arm Makefile instead of the
+# arm64 one.
+# As a result we set our own flags here.
+
+# From top-level Makefile
+# NOSTDINC_FLAGS
+VDSO_CPPFLAGS := -nostdinc -isystem $(shell $(COMPATCC) -print-file-name=include)
+VDSO_CPPFLAGS += $(LINUXINCLUDE)
+VDSO_CPPFLAGS += $(KBUILD_CPPFLAGS)
+
+# Common C and assembly flags
+# From top-level Makefile
+VDSO_CAFLAGS := $(VDSO_CPPFLAGS)
+VDSO_CAFLAGS += $(call cc32-option,-fno-PIE)
+ifdef CONFIG_DEBUG_INFO
+VDSO_CAFLAGS += -g
+endif
+ifeq ($(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(COMPATCC)), y)
+VDSO_CAFLAGS += -DCC_HAVE_ASM_GOTO
+endif
+
+# From arm Makefile
+VDSO_CAFLAGS += $(call cc32-option,-fno-dwarf2-cfi-asm)
+VDSO_CAFLAGS += -mabi=aapcs-linux -mfloat-abi=soft
+ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
+VDSO_CAFLAGS += -mbig-endian
+else
+VDSO_CAFLAGS += -mlittle-endian
+endif
+
+# From arm vDSO Makefile
+VDSO_CAFLAGS += -fPIC -fno-builtin -fno-stack-protector
+VDSO_CAFLAGS += -DDISABLE_BRANCH_PROFILING
+
+# Try to compile for ARMv8. If the compiler is too old and doesn't support it,
+# fall back to v7. There is no easy way to check for what architecture the code
+# is being compiled, so define a macro specifying that (see arch/arm/Makefile).
+VDSO_CAFLAGS += $(call cc32-option,-march=armv8-a -D__LINUX_ARM_ARCH__=8,\
+                                   -march=armv7-a -D__LINUX_ARM_ARCH__=7)
+
+VDSO_CFLAGS := $(VDSO_CAFLAGS)
+VDSO_CFLAGS += -DENABLE_COMPAT_VDSO=1
+# KBUILD_CFLAGS from top-level Makefile
+VDSO_CFLAGS += -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
+               -fno-strict-aliasing -fno-common \
+               -Werror-implicit-function-declaration \
+               -Wno-format-security \
+               -std=gnu89
+VDSO_CFLAGS  += -O2
+# Some useful compiler-dependent flags from top-level Makefile
+VDSO_CFLAGS += $(call cc32-option,-Wdeclaration-after-statement,)
+VDSO_CFLAGS += $(call cc32-option,-Wno-pointer-sign)
+VDSO_CFLAGS += $(call cc32-option,-fno-strict-overflow)
+VDSO_CFLAGS += $(call cc32-option,-Werror=strict-prototypes)
+VDSO_CFLAGS += $(call cc32-option,-Werror=date-time)
+VDSO_CFLAGS += $(call cc32-option,-Werror=incompatible-pointer-types)
+
+# The 32-bit compiler does not provide 128-bit integers, which are used in
+# some headers that are indirectly included from the vDSO code.
+# This hack makes the compiler happy and should trigger a warning/error if
+# variables of such type are referenced.
+VDSO_CFLAGS += -D__uint128_t='void*'
+# Silence some warnings coming from headers that operate on long's
+# (on GCC 4.8 or older, there is unfortunately no way to silence this warning)
+VDSO_CFLAGS += $(call cc32-disable-warning,shift-count-overflow)
+VDSO_CFLAGS += -Wno-int-to-pointer-cast
+
+VDSO_AFLAGS := $(VDSO_CAFLAGS)
+VDSO_AFLAGS += -D__ASSEMBLY__
+
+VDSO_LDFLAGS := $(VDSO_CPPFLAGS)
+# From arm vDSO Makefile
+VDSO_LDFLAGS += -Wl,-Bsymbolic -Wl,--no-undefined -Wl,-soname=linux-vdso.so.1
+VDSO_LDFLAGS += -Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096
+VDSO_LDFLAGS += -nostdlib -shared -mfloat-abi=soft
+VDSO_LDFLAGS += $(call cc32-ldoption,-Wl$(comma)--hash-style=sysv)
+VDSO_LDFLAGS += $(call cc32-ldoption,-Wl$(comma)--build-id)
+VDSO_LDFLAGS += $(call cc32-ldoption,-fuse-ld=bfd)
+
+
+# Borrow vdsomunge.c from the arm vDSO
+# We have to use a relative path because scripts/Makefile.host prefixes
+# $(hostprogs-y) with $(obj)
+munge := ../../../arm/vdso/vdsomunge
+hostprogs-y := $(munge)
+
+c-obj-vdso := note.o
+c-obj-vdso-gettimeofday := vgettimeofday.o
+asm-obj-vdso := sigreturn.o
+
+ifneq ($(c-gettimeofday-y),)
+VDSO_CFLAGS_gettimeofday_o += -include $(c-gettimeofday-y)
+endif
+
+VDSO_CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os
+
+# Build rules
+targets := $(c-obj-vdso) $(c-obj-vdso-gettimeofday) $(asm-obj-vdso) vdso.so vdso.so.dbg vdso.so.raw
+c-obj-vdso := $(addprefix $(obj)/, $(c-obj-vdso))
+c-obj-vdso-gettimeofday := $(addprefix $(obj)/, $(c-obj-vdso-gettimeofday))
+asm-obj-vdso := $(addprefix $(obj)/, $(asm-obj-vdso))
+obj-vdso := $(c-obj-vdso) $(c-obj-vdso-gettimeofday) $(asm-obj-vdso)
+
+obj-y += vdso.o
+extra-y += vdso.lds
+CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
+
+# Force dependency (vdso.s includes vdso.so through incbin)
+$(obj)/vdso.o: $(obj)/vdso.so
+
+include/generated/vdso32-offsets.h: $(obj)/vdso.so.dbg FORCE
+	$(call if_changed,vdsosym)
+
+# Strip rule for vdso.so
+$(obj)/vdso.so: OBJCOPYFLAGS := -S
+$(obj)/vdso.so: $(obj)/vdso.so.dbg FORCE
+	$(call if_changed,objcopy)
+
+$(obj)/vdso.so.dbg: $(obj)/vdso.so.raw $(obj)/$(munge) FORCE
+	$(call if_changed,vdsomunge)
+
+# Link rule for the .so file, .lds has to be first
+$(obj)/vdso.so.raw: $(src)/vdso.lds $(obj-vdso) FORCE
+	$(call if_changed,vdsold)
+	$(call if_changed,vdso_check)
+
+# Compilation rules for the vDSO sources
+$(c-obj-vdso): %.o: %.c FORCE
+	$(call if_changed_dep,vdsocc)
+$(c-obj-vdso-gettimeofday): %.o: %.c FORCE
+	$(call if_changed_dep,vdsocc_gettimeofday)
+$(asm-obj-vdso): %.o: %.S FORCE
+	$(call if_changed_dep,vdsoas)
+
+# Actual build commands
+quiet_cmd_vdsold = VDSOL   $@
+      cmd_vdsold = $(COMPATCC) -Wp,-MD,$(depfile) $(VDSO_LDFLAGS) \
+                   -Wl,-T $(filter %.lds,$^) $(filter %.o,$^) -o $@
+quiet_cmd_vdsocc = VDSOC   $@
+      cmd_vdsocc = $(COMPATCC) -Wp,-MD,$(depfile) $(VDSO_CFLAGS) -c -o $@ $<
+quiet_cmd_vdsocc_gettimeofday = VDSOC_GTD   $@
+      cmd_vdsocc_gettimeofday = $(COMPATCC) -Wp,-MD,$(depfile) $(VDSO_CFLAGS) $(VDSO_CFLAGS_gettimeofday_o) -c -o $@ $<
+quiet_cmd_vdsoas = VDSOA   $@
+      cmd_vdsoas = $(COMPATCC) -Wp,-MD,$(depfile) $(VDSO_AFLAGS) -c -o $@ $<
+
+quiet_cmd_vdsomunge = MUNGE   $@
+      cmd_vdsomunge = $(obj)/$(munge) $< $@
+
+# Generate vDSO offsets using helper script (borrowed from the 64-bit vDSO)
+gen-vdsosym := $(srctree)/$(src)/../vdso/gen_vdso_offsets.sh
+quiet_cmd_vdsosym = VDSOSYM $@
+# The AArch64 nm should be able to read an AArch32 binary
+      cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
+
+# Install commands for the unstripped file
+quiet_cmd_vdso_install = INSTALL $@
+      cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/vdso32.so
+
+vdso.so: $(obj)/vdso.so.dbg
+	@mkdir -p $(MODLIB)/vdso
+	$(call cmd,vdso_install)
+
+vdso_install: vdso.so
diff --git a/arch/arm64/kernel/vdso32/note.c b/arch/arm64/kernel/vdso32/note.c
new file mode 100644
index 000000000000..eff5bf9efb8b
--- /dev/null
+++ b/arch/arm64/kernel/vdso32/note.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2012-2018 ARM Limited
+ *
+ * This supplies .note.* sections to go into the PT_NOTE inside the vDSO text.
+ * Here we can supply some information useful to userland.
+ */
+
+#include <linux/uts.h>
+#include <linux/version.h>
+#include <linux/elfnote.h>
+#include <linux/build-salt.h>
+
+ELFNOTE32("Linux", 0, LINUX_VERSION_CODE);
+BUILD_SALT;
diff --git a/arch/arm64/kernel/vdso32/sigreturn.S b/arch/arm64/kernel/vdso32/sigreturn.S
new file mode 100644
index 000000000000..1a81277c2d09
--- /dev/null
+++ b/arch/arm64/kernel/vdso32/sigreturn.S
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This file provides both A32 and T32 versions, in accordance with the
+ * arm sigreturn code.
+ *
+ * Copyright (C) 2018 ARM Limited
+ */
+
+#include <linux/linkage.h>
+#include <asm/asm-offsets.h>
+#include <asm/unistd.h>
+
+#define ARM_ENTRY(name)		\
+	ENTRY(name)
+
+#define ARM_ENDPROC(name)	\
+	.type name, %function;	\
+	END(name)
+
+	.text
+
+	.arm
+	.fnstart
+	.save {r0-r15}
+	.pad #COMPAT_SIGFRAME_REGS_OFFSET
+	nop
+ARM_ENTRY(__kernel_sigreturn_arm)
+	mov r7, #__NR_compat_sigreturn
+	svc #0
+	.fnend
+ARM_ENDPROC(__kernel_sigreturn_arm)
+
+	.fnstart
+	.save {r0-r15}
+	.pad #COMPAT_RT_SIGFRAME_REGS_OFFSET
+	nop
+ARM_ENTRY(__kernel_rt_sigreturn_arm)
+	mov r7, #__NR_compat_rt_sigreturn
+	svc #0
+	.fnend
+ARM_ENDPROC(__kernel_rt_sigreturn_arm)
+
+	.thumb
+	.fnstart
+	.save {r0-r15}
+	.pad #COMPAT_SIGFRAME_REGS_OFFSET
+	nop
+ARM_ENTRY(__kernel_sigreturn_thumb)
+	mov r7, #__NR_compat_sigreturn
+	svc #0
+	.fnend
+ARM_ENDPROC(__kernel_sigreturn_thumb)
+
+	.fnstart
+	.save {r0-r15}
+	.pad #COMPAT_RT_SIGFRAME_REGS_OFFSET
+	nop
+ARM_ENTRY(__kernel_rt_sigreturn_thumb)
+	mov r7, #__NR_compat_rt_sigreturn
+	svc #0
+	.fnend
+ARM_ENDPROC(__kernel_rt_sigreturn_thumb)
diff --git a/arch/arm64/kernel/vdso32/vdso.S b/arch/arm64/kernel/vdso32/vdso.S
new file mode 100644
index 000000000000..e72ac7bc4c04
--- /dev/null
+++ b/arch/arm64/kernel/vdso32/vdso.S
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2012 ARM Limited
+ */
+
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/const.h>
+#include <asm/page.h>
+
+	.globl vdso32_start, vdso32_end
+	.section .rodata
+	.balign PAGE_SIZE
+vdso32_start:
+	.incbin "arch/arm64/kernel/vdso32/vdso.so"
+	.balign PAGE_SIZE
+vdso32_end:
+
+	.previous
diff --git a/arch/arm64/kernel/vdso32/vdso.lds.S b/arch/arm64/kernel/vdso32/vdso.lds.S
new file mode 100644
index 000000000000..a3944927eaeb
--- /dev/null
+++ b/arch/arm64/kernel/vdso32/vdso.lds.S
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Adapted from arm64 version.
+ *
+ * GNU linker script for the VDSO library.
+ * Heavily based on the vDSO linker scripts for other archs.
+ *
+ * Copyright (C) 2012-2018 ARM Limited
+ */
+
+#include <linux/const.h>
+#include <asm/page.h>
+#include <asm/vdso.h>
+
+OUTPUT_FORMAT("elf32-littlearm", "elf32-bigarm", "elf32-littlearm")
+OUTPUT_ARCH(arm)
+
+SECTIONS
+{
+	PROVIDE_HIDDEN(_vdso_data = . - PAGE_SIZE);
+	. = VDSO_LBASE + SIZEOF_HEADERS;
+
+	.hash		: { *(.hash) }			:text
+	.gnu.hash	: { *(.gnu.hash) }
+	.dynsym		: { *(.dynsym) }
+	.dynstr		: { *(.dynstr) }
+	.gnu.version	: { *(.gnu.version) }
+	.gnu.version_d	: { *(.gnu.version_d) }
+	.gnu.version_r	: { *(.gnu.version_r) }
+
+	.note		: { *(.note.*) }		:text	:note
+
+	.dynamic	: { *(.dynamic) }		:text	:dynamic
+
+	.rodata		: { *(.rodata*) }		:text
+
+	.text		: { *(.text*) }			:text	=0xe7f001f2
+
+	.got		: { *(.got) }
+	.rel.plt	: { *(.rel.plt) }
+
+	/DISCARD/	: {
+		*(.note.GNU-stack)
+		*(.data .data.* .gnu.linkonce.d.* .sdata*)
+		*(.bss .sbss .dynbss .dynsbss)
+	}
+}
+
+/*
+ * We must supply the ELF program headers explicitly to get just one
+ * PT_LOAD segment, and set the flags explicitly to make segments read-only.
+ */
+PHDRS
+{
+	text		PT_LOAD		FLAGS(5) FILEHDR PHDRS; /* PF_R|PF_X */
+	dynamic		PT_DYNAMIC	FLAGS(4);		/* PF_R */
+	note		PT_NOTE		FLAGS(4);		/* PF_R */
+}
+
+VERSION
+{
+	LINUX_2.6 {
+	global:
+		__vdso_clock_gettime;
+		__vdso_gettimeofday;
+		__vdso_clock_getres;
+		__kernel_sigreturn_arm;
+		__kernel_sigreturn_thumb;
+		__kernel_rt_sigreturn_arm;
+		__kernel_rt_sigreturn_thumb;
+		__vdso_clock_gettime64;
+	local: *;
+	};
+}
+
+/*
+ * Make the sigreturn code visible to the kernel.
+ */
+VDSO_compat_sigreturn_arm	= __kernel_sigreturn_arm;
+VDSO_compat_sigreturn_thumb	= __kernel_sigreturn_thumb;
+VDSO_compat_rt_sigreturn_arm	= __kernel_rt_sigreturn_arm;
+VDSO_compat_rt_sigreturn_thumb	= __kernel_rt_sigreturn_thumb;
diff --git a/arch/arm64/kernel/vdso32/vgettimeofday.c b/arch/arm64/kernel/vdso32/vgettimeofday.c
new file mode 100644
index 000000000000..54fc1c2ce93f
--- /dev/null
+++ b/arch/arm64/kernel/vdso32/vgettimeofday.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM64 compat userspace implementations of gettimeofday() and similar.
+ *
+ * Copyright (C) 2018 ARM Limited
+ *
+ */
+#include <linux/time.h>
+#include <linux/types.h>
+
+int __vdso_clock_gettime(clockid_t clock,
+			 struct old_timespec32 *ts)
+{
+	/* The checks below are required for ABI consistency with arm */
+	if ((u32)ts >= TASK_SIZE_32)
+		return -EFAULT;
+
+	return __cvdso_clock_gettime32(clock, ts);
+}
+
+int __vdso_clock_gettime64(clockid_t clock,
+			   struct __kernel_timespec *ts)
+{
+	/* The checks below are required for ABI consistency with arm */
+	if ((u32)ts >= TASK_SIZE_32)
+		return -EFAULT;
+
+	return __cvdso_clock_gettime(clock, ts);
+}
+
+int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
+			struct timezone *tz)
+{
+	return __cvdso_gettimeofday(tv, tz);
+}
+
+int __vdso_clock_getres(clockid_t clock_id,
+			struct old_timespec32 *res)
+{
+	/* The checks below are required for ABI consistency with arm */
+	if ((u32)res >= TASK_SIZE_32)
+		return -EFAULT;
+
+	return __cvdso_clock_getres_time32(clock_id, res);
+}
+
+/* Avoid unresolved references emitted by GCC */
+
+void __aeabi_unwind_cpp_pr0(void)
+{
+}
+
+void __aeabi_unwind_cpp_pr1(void)
+{
+}
+
+void __aeabi_unwind_cpp_pr2(void)
+{
+}
-- 
2.21.0

