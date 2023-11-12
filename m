Return-Path: <linux-arch+bounces-139-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CFC7E8E87
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 07:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E631F20F76
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E12440E;
	Sun, 12 Nov 2023 06:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6KmQ0AR"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF6D440A
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 06:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB45C433BA;
	Sun, 12 Nov 2023 06:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699769745;
	bh=UaIimKGmjnUGloTxOFJqXp6BBypHnPKUh6PUNXXTMXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F6KmQ0ARB15XFhwVM92q1sSvcWPHdHSLnGPo9uASPmW8Sria6bLRbQHM2cgYauygP
	 9J0kEy5PuGbYrhMbUxb6NtRYWgl37HZJsMW9qoZ2a9PDv+I+0wEaoazEKl1x37MVUU
	 2T/NJzoNRRy+scLjqOwig2UUCY7o4YVSVgNvXRj5Wwv75ehWyu2dev30VlnhuFLPwn
	 3M45DE7Bd9fwJq5nBDnQdILSd0zdlWxEBXZCiL3/+JVMOZwJNw3yo7UoOb6rs2vz4t
	 r2UznWm5UwhRgEyF29EVBtD1qiSV2wezQGOeE9ubeS+HvxJo6nvajz3pvtfMJPzDf1
	 e2t7yGi3ZVRVg==
From: guoren@kernel.org
To: arnd@arndb.de,
	guoren@kernel.org,
	palmer@rivosinc.com,
	tglx@linutronix.de,
	conor.dooley@microchip.com,
	heiko@sntech.de,
	apatel@ventanamicro.com,
	atishp@atishpatra.org,
	bjorn@kernel.org,
	paul.walmsley@sifive.com,
	anup@brainfault.org,
	jiawei@iscas.ac.cn,
	liweiwei@iscas.ac.cn,
	wefu@redhat.com,
	U2FsdGVkX1@gmail.com,
	wangjunqiang@iscas.ac.cn,
	kito.cheng@sifive.com,
	andy.chiu@sifive.com,
	vincent.chen@sifive.com,
	greentime.hu@sifive.com,
	wuwei2016@iscas.ac.cn,
	jrtc27@jrtc27.com,
	luto@kernel.org,
	fweimer@redhat.com,
	catalin.marinas@arm.com,
	hjl.tools@gmail.com
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH V2 03/38] riscv: u64ilp32: Add time-related vDSO common flow for vdso32
Date: Sun, 12 Nov 2023 01:14:39 -0500
Message-Id: <20231112061514.2306187-4-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231112061514.2306187-1-guoren@kernel.org>
References: <20231112061514.2306187-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

This patch adds time-related vDSO common flow for vdso32, and it's an
addition to commit: ad5d1122b82f ("riscv: use vDSO common flow to reduce
the latency of the time-related functions"). Then we could reduce the
latency of collecting clock information for u32ilp32 (native 32-bit
userspace ecosystem), just like what we've done for u64lp64.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig                         |  4 +-
 arch/riscv/include/asm/vdso/gettimeofday.h | 90 ++++++++++++++++++++++
 arch/riscv/include/uapi/asm/unistd.h       |  1 +
 arch/riscv/kernel/vdso/Makefile            | 42 +++++-----
 arch/riscv/kernel/vdso/vdso.lds.S          |  2 -
 arch/riscv/kernel/vdso/vgettimeofday.c     | 39 ++++++++--
 6 files changed, 145 insertions(+), 33 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4b91e2ba7815..24b1b6abf0a7 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -82,7 +82,7 @@ config RISCV
 	select GENERIC_PTDUMP if MMU
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
-	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
+	select GENERIC_TIME_VSYSCALL if MMU
 	select GENERIC_VDSO_TIME_NS if HAVE_GENERIC_VDSO
 	select HARDIRQS_SW_RESEND
 	select HAS_IOPORT if MMU
@@ -118,7 +118,7 @@ config RISCV
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_GCC_PLUGINS
-	select HAVE_GENERIC_VDSO if MMU && 64BIT
+	select HAVE_GENERIC_VDSO if MMU
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KPROBES if !XIP_KERNEL
 	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
diff --git a/arch/riscv/include/asm/vdso/gettimeofday.h b/arch/riscv/include/asm/vdso/gettimeofday.h
index a7ae8576797b..4c362bb9a16b 100644
--- a/arch/riscv/include/asm/vdso/gettimeofday.h
+++ b/arch/riscv/include/asm/vdso/gettimeofday.h
@@ -36,6 +36,7 @@ int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
 }
 #endif
 
+#if __SIZEOF_POINTER__ == 8
 #ifdef __NR_clock_gettime
 static __always_inline
 long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
@@ -71,6 +72,84 @@ int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 	return ret;
 }
 #endif
+
+#elif __SIZEOF_POINTER__ == 4
+
+#define BUILD_VDSO32		1
+
+#ifdef __NR_clock_gettime64
+static __always_inline
+long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
+{
+	register clockid_t clkid asm("a0") = _clkid;
+	register struct __kernel_timespec *ts asm("a1") = _ts;
+	register long ret asm("a0");
+	register long nr asm("a7") = __NR_clock_gettime64;
+
+	asm volatile ("ecall\n"
+		      : "=r" (ret)
+		      : "r"(clkid), "r"(ts), "r"(nr)
+		      : "memory");
+
+	return ret;
+}
+#endif
+
+#ifdef __NR_clock_getres_time64
+static __always_inline
+int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
+{
+	register clockid_t clkid asm("a0") = _clkid;
+	register struct __kernel_timespec *ts asm("a1") = _ts;
+	register long ret asm("a0");
+	register long nr asm("a7") = __NR_clock_getres_time64;
+
+	asm volatile ("ecall\n"
+		      : "=r" (ret)
+		      : "r"(clkid), "r"(ts), "r"(nr)
+		      : "memory");
+
+	return ret;
+}
+#endif
+
+#ifdef __NR_clock_gettime
+static __always_inline
+int clock_gettime32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
+{
+	register clockid_t clkid asm("a0") = _clkid;
+	register struct old_timespec32 *ts asm("a1") = _ts;
+	register long ret asm("a0");
+	register long nr asm("a7") = __NR_clock_gettime;
+
+	asm volatile ("ecall\n"
+		      : "=r" (ret)
+		      : "r"(clkid), "r"(ts), "r"(nr)
+		      : "memory");
+
+	return ret;
+}
+#endif
+
+#ifdef __NR_clock_getres
+static __always_inline
+int clock_getres32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
+{
+	register clockid_t clkid asm("a0") = _clkid;
+	register struct old_timespec32 *ts asm("a1") = _ts;
+	register long ret asm("a0");
+	register long nr asm("a7") = __NR_clock_getres;
+
+	asm volatile ("ecall\n"
+		      : "=r" (ret)
+		      : "r"(clkid), "r"(ts), "r"(nr)
+		      : "memory");
+
+	return ret;
+}
+#endif
+
+#endif /* __SIZEOF_POINTER__ */
 #endif /* CONFIG_GENERIC_TIME_VSYSCALL */
 
 static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
@@ -81,7 +160,18 @@ static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
 	 * M-mode to obtain the value of CSR_TIME. Hence, unlike other
 	 * architecture, no fence instructions surround the csr_read()
 	 */
+#if __riscv_xlen == 64
 	return csr_read(CSR_TIME);
+#else
+	u32 hi, lo;
+
+	do {
+		hi = csr_read(CSR_TIMEH);
+		lo = csr_read(CSR_TIME);
+	} while (hi != csr_read(CSR_TIMEH));
+
+	return ((u64)hi << 32) | lo;
+#endif
 }
 
 static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
index 950ab3fd4409..0ee86ef907e4 100644
--- a/arch/riscv/include/uapi/asm/unistd.h
+++ b/arch/riscv/include/uapi/asm/unistd.h
@@ -22,6 +22,7 @@
 
 #define __ARCH_WANT_SYS_CLONE3
 #define __ARCH_WANT_MEMFD_SECRET
+#define __ARCH_WANT_TIME32_SYSCALLS
 
 #include <asm-generic/unistd.h>
 
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index a9720e816e1f..df8f68bb0937 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -16,9 +16,6 @@ ccflags-y := -fno-stack-protector
 ccflags-y += -DDISABLE_BRANCH_PROFILING
 
 CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
-ifneq ($(filter vgettimeofday, $(vdso-cc-syms)),)
-	CPPFLAGS_vdso.lds += -DHAS_VGETTIMEOFDAY
-endif
 
 # strip rule for the .so file
 $(obj)/%.so: OBJCOPYFLAGS := -S
@@ -29,20 +26,20 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 quiet_cmd_vdso_install = INSTALL $@
       cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
 
-# Symbols present in the vdso
-ifdef CONFIG_VDSO64
-vdso64-as-syms  = rt_sigreturn
-vdso64-as-syms += getcpu
-vdso64-as-syms += flush_icache
-vdso64-as-syms += sys_hwprobe
+vdso-as-syms  = rt_sigreturn
+vdso-as-syms += getcpu
+vdso-as-syms += flush_icache
+vdso-as-syms += sys_hwprobe
 
-vdso64-cc-syms  = vgettimeofday
-vdso64-cc-syms += hwprobe
+vdso-cc-syms  = vgettimeofday
+vdso-cc-syms += hwprobe
 
-obj-as-vdso64  = $(patsubst %, %-64.o, $(vdso64-as-syms)) note-64.o
+# Symbols present in the vdso
+ifdef CONFIG_VDSO64
+obj-as-vdso64  = $(patsubst %, %-64.o, $(vdso-as-syms)) note-64.o
 obj-as-vdso64 := $(addprefix $(obj)/, $(obj-as-vdso64))
 
-obj-cc-vdso64  = $(patsubst %, %-64.o, $(vdso64-cc-syms))
+obj-cc-vdso64  = $(patsubst %, %-64.o, $(vdso-cc-syms))
 obj-cc-vdso64 := $(addprefix $(obj)/, $(obj-cc-vdso64))
 
 targets += $(obj-as-vdso64) $(obj-cc-vdso64) vdso64.so vdso64.so.dbg vdso64.lds
@@ -55,7 +52,7 @@ LDFLAGS_vdso64.so.dbg = -shared -S -soname=linux-vdso64.so.1 \
 # Make sure only to export the intended __vdso_xxx symbol offsets.
 quiet_cmd_vdso64ld = VDSO64LD  $@
       cmd_vdso64ld = $(VDSO_LD) $(ld_flags) $(VDSO64_LD_FLAGS) -T $(filter-out FORCE,$^) -o $@.tmp && \
-                   $(OBJCOPY) $(patsubst %, -G __vdso_%, $(vdso64-as-syms) $(vdso64-cc-syms)) $@.tmp $@ && \
+                   $(OBJCOPY) $(patsubst %, -G __vdso_%, $(vdso-as-syms) $(vdso-cc-syms)) $@.tmp $@ && \
                    rm $@.tmp
 
 # actual build commands
@@ -94,20 +91,13 @@ vdso64_install: vdso64.so
 endif
 
 ifdef CONFIG_VDSO32
-vdso32-as-syms  = rt_sigreturn
-vdso32-as-syms += getcpu
-vdso32-as-syms += flush_icache
-vdso32-as-syms += sys_hwprobe
-
-vdso32-cc-syms += hwprobe
-
 VDSO32_CC_FLAGS := -march=rv32g -mabi=ilp32
 VDSO32_LD_FLAGS := -melf32lriscv
 
-obj-as-vdso32  = $(patsubst %, %-32.o, $(vdso32-as-syms)) note-32.o
+obj-as-vdso32  = $(patsubst %, %-32.o, $(vdso-as-syms)) note-32.o
 obj-as-vdso32 := $(addprefix $(obj)/, $(obj-as-vdso32))
 
-obj-cc-vdso32  = $(patsubst %, %-32.o, $(vdso32-cc-syms))
+obj-cc-vdso32  = $(patsubst %, %-32.o, $(vdso-cc-syms))
 obj-cc-vdso32 := $(addprefix $(obj)/, $(obj-cc-vdso32))
 
 targets += $(obj-as-vdso32) $(obj-cc-vdso32) vdso32.so vdso32.so.dbg vdso32.lds
@@ -121,7 +111,7 @@ LDFLAGS_vdso32.so.dbg = -shared -S -soname=linux-vdso32.so.1 \
 # Make sure only to export the intended __vdso_xxx symbol offsets.
 quiet_cmd_vdso32ld = VDSO32LD  $@
       cmd_vdso32ld = $(VDSO_LD) $(ld_flags) $(VDSO32_LD_FLAGS) -T $(filter-out FORCE,$^) -o $@.tmp && \
-                   $(OBJCOPY) $(patsubst %, -G __vdso_%, $(vdso32-as-syms) $(vdso32-cc-syms)) $@.tmp $@ && \
+                   $(OBJCOPY) $(patsubst %, -G __vdso_%, $(vdso-as-syms) $(vdso-cc-syms)) $@.tmp $@ && \
                    rm $@.tmp
 
 # actual build commands
@@ -140,6 +130,10 @@ $(obj-cc-vdso32): %-32.o: %.c FORCE
 
 CFLAGS_hwprobe-32.o += -fPIC
 
+CFLAGS_vgettimeofday-32.o += -fPIC -include $(c-gettimeofday-y)
+# Disable -pg to prevent insert call site
+CFLAGS_REMOVE_vgettimeofday-32.o = $(CC_FLAGS_FTRACE)
+
 # Generate VDSO offsets using helper script
 gen-vdso32sym := $(srctree)/$(src)/gen_vdso32_offsets.sh
 quiet_cmd_vdso32sym = VDSO32SYM $@
diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
index 82ce64900f3d..d28202283b72 100644
--- a/arch/riscv/kernel/vdso/vdso.lds.S
+++ b/arch/riscv/kernel/vdso/vdso.lds.S
@@ -75,11 +75,9 @@ VERSION
 	LINUX_4.15 {
 	global:
 		__vdso_rt_sigreturn;
-#ifdef HAS_VGETTIMEOFDAY
 		__vdso_gettimeofday;
 		__vdso_clock_gettime;
 		__vdso_clock_getres;
-#endif
 		__vdso_getcpu;
 		__vdso_flush_icache;
 #ifndef COMPAT_VDSO
diff --git a/arch/riscv/kernel/vdso/vgettimeofday.c b/arch/riscv/kernel/vdso/vgettimeofday.c
index cc0d80699c31..056b465eb161 100644
--- a/arch/riscv/kernel/vdso/vgettimeofday.c
+++ b/arch/riscv/kernel/vdso/vgettimeofday.c
@@ -9,6 +9,14 @@
 #include <linux/time.h>
 #include <linux/types.h>
 
+extern
+int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
+int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
+{
+	return __cvdso_gettimeofday(tv, tz);
+}
+
+#if __SIZEOF_POINTER__ == 8
 extern
 int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts);
 int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
@@ -17,15 +25,36 @@ int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
 }
 
 extern
-int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
-int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
+int __vdso_clock_getres(clockid_t clock_id, struct __kernel_timespec *res);
+int __vdso_clock_getres(clockid_t clock_id, struct __kernel_timespec *res)
 {
-	return __cvdso_gettimeofday(tv, tz);
+	return __cvdso_clock_getres(clock_id, res);
+}
+#elif __SIZEOF_POINTER__ == 4
+extern
+int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts);
+int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts)
+{
+	return __cvdso_clock_gettime32(clock, ts);
+}
+
+int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts);
+int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_gettime(clock, ts);
 }
 
 extern
-int __vdso_clock_getres(clockid_t clock_id, struct __kernel_timespec *res);
-int __vdso_clock_getres(clockid_t clock_id, struct __kernel_timespec *res)
+int __vdso_clock_getres(clockid_t clock_id, struct old_timespec32 *res);
+int __vdso_clock_getres(clockid_t clock_id, struct old_timespec32 *res)
+{
+	return __cvdso_clock_getres_time32(clock_id, res);
+}
+
+extern
+int __vdso_clock_getres64(clockid_t clock_id, struct __kernel_timespec *res);
+int __vdso_clock_getres64(clockid_t clock_id, struct __kernel_timespec *res)
 {
 	return __cvdso_clock_getres(clock_id, res);
 }
+#endif
-- 
2.36.1


