Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA7D708251
	for <lists+linux-arch@lfdr.de>; Thu, 18 May 2023 15:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjERNND (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 May 2023 09:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjERNM4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 May 2023 09:12:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10521BDA;
        Thu, 18 May 2023 06:12:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4438364F49;
        Thu, 18 May 2023 13:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436E2C433EF;
        Thu, 18 May 2023 13:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684415481;
        bh=MPy7nYgZxGVT5ozD/0/9eH3LbzI1BGzOCOHyLrnUh3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MuOlaXfZwhnukyDoq8GFeTAa/Drq3uqSxKCmo+vgN7FEIdhD/9XLJW/G24yUkcpd/
         cvzKGq8WgMHHnzE7/Y8348Pvjt0lPgN1OJUjeNjZRZpbERpdWTr0Ru1qK7+o2o6Ziz
         VWJC4noxp9Oa81Bj1I4n+gsuVBXZtOTtqy83weKpsBFAPA8bCpj3Cibl5a2vdElEQw
         U/PLYLPmHTXZSH/nFPhiNPhUdaJ0LUBHkYB357y5CJggKxqzQD2m9Wl8Vz46sPtJOX
         JpjtdOhFXSMopTAS3/vbpe0rzIb1Zu41gtDTl/hggT7rW+UC/YXh84U7M5agBYEftg
         tXl/hvkRSQEhQ==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, bjorn@kernel.org,
        paul.walmsley@sifive.com, catalin.marinas@arm.com, will@kernel.org,
        rppt@kernel.org, anup@brainfault.org, shihua@iscas.ac.cn,
        jiawei@iscas.ac.cn, liweiwei@iscas.ac.cn, luxufan@iscas.ac.cn,
        chunyu@iscas.ac.cn, tsu.yubo@gmail.com, wefu@redhat.com,
        wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
        andy.chiu@sifive.com, vincent.chen@sifive.com,
        greentime.hu@sifive.com, corbet@lwn.net, wuwei2016@iscas.ac.cn,
        jrtc27@jrtc27.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH 03/22] riscv: vdso: Add time-related vDSO common flow for vdso32
Date:   Thu, 18 May 2023 09:09:54 -0400
Message-Id: <20230518131013.3366406-4-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230518131013.3366406-1-guoren@kernel.org>
References: <20230518131013.3366406-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

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
 arch/riscv/include/asm/vdso/gettimeofday.h | 79 ++++++++++++++++++++++
 arch/riscv/include/uapi/asm/unistd.h       |  1 +
 arch/riscv/kernel/vdso/Makefile            | 39 +++++------
 arch/riscv/kernel/vdso/vgettimeofday.c     | 39 +++++++++--
 5 files changed, 134 insertions(+), 28 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 643884620cd6..4d4fac81390f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -75,7 +75,7 @@ config RISCV
 	select GENERIC_PTDUMP if MMU
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
-	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
+	select GENERIC_TIME_VSYSCALL if MMU
 	select GENERIC_VDSO_TIME_NS if HAVE_GENERIC_VDSO
 	select HARDIRQS_SW_RESEND
 	select HAVE_ARCH_AUDITSYSCALL
@@ -103,7 +103,7 @@ config RISCV
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_GCC_PLUGINS
-	select HAVE_GENERIC_VDSO if MMU && 64BIT
+	select HAVE_GENERIC_VDSO if MMU
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KPROBES if !XIP_KERNEL
 	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
diff --git a/arch/riscv/include/asm/vdso/gettimeofday.h b/arch/riscv/include/asm/vdso/gettimeofday.h
index a7ae8576797b..0dcb6c5c4111 100644
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
index e3c3bf669c7b..42338a2c26a7 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -31,20 +31,20 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
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
@@ -57,7 +57,7 @@ LDFLAGS_vdso64.so.dbg = -shared -S -soname=linux-vdso64.so.1 \
 # Make sure only to export the intended __vdso_xxx symbol offsets.
 quiet_cmd_vdso64ld = VDSO64LD  $@
       cmd_vdso64ld = $(VDSO_LD) $(ld_flags) $(VDSO64_LD_FLAGS) -T $(filter-out FORCE,$^) -o $@.tmp && \
-                   $(OBJCOPY) $(patsubst %, -G __vdso_%, $(vdso64-as-syms) $(vdso64-cc-syms)) $@.tmp $@ && \
+                   $(OBJCOPY) $(patsubst %, -G __vdso_%, $(vdso-as-syms) $(vdso-cc-syms)) $@.tmp $@ && \
                    rm $@.tmp
 
 # actual build commands
@@ -96,20 +96,13 @@ vdso64_install: vdso64.so
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
@@ -123,7 +116,7 @@ LDFLAGS_vdso32.so.dbg = -shared -S -soname=linux-vdso32.so.1 \
 # Make sure only to export the intended __vdso_xxx symbol offsets.
 quiet_cmd_vdso32ld = VDSO32LD  $@
       cmd_vdso32ld = $(VDSO_LD) $(ld_flags) $(VDSO32_LD_FLAGS) -T $(filter-out FORCE,$^) -o $@.tmp && \
-                   $(OBJCOPY) $(patsubst %, -G __vdso_%, $(vdso32-as-syms) $(vdso32-cc-syms)) $@.tmp $@ && \
+                   $(OBJCOPY) $(patsubst %, -G __vdso_%, $(vdso-as-syms) $(vdso-cc-syms)) $@.tmp $@ && \
                    rm $@.tmp
 
 # actual build commands
@@ -142,6 +135,10 @@ $(obj-cc-vdso32): %-32.o: %.c FORCE
 
 CFLAGS_hwprobe-32.o += -fPIC
 
+CFLAGS_vgettimeofday-32.o += -fPIC -include $(c-gettimeofday-y)
+# Disable -pg to prevent insert call site
+CFLAGS_REMOVE_vgettimeofday-32.o = $(CC_FLAGS_FTRACE)
+
 # Generate VDSO offsets using helper script
 gen-vdso32sym := $(srctree)/$(src)/gen_vdso32_offsets.sh
 quiet_cmd_vdso32sym = VDSO32SYM $@
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

