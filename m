Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D83670824A
	for <lists+linux-arch@lfdr.de>; Thu, 18 May 2023 15:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjERNMr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 May 2023 09:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjERNMn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 May 2023 09:12:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7485C9C;
        Thu, 18 May 2023 06:11:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C85FE64F46;
        Thu, 18 May 2023 13:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED15CC433A8;
        Thu, 18 May 2023 13:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684415456;
        bh=dIHdwvZEudsqHMu5s9YuHTx8NxWZy6Q3fEAityYqUho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V7oF99ZvljCZIOzFW51A3fZFEU+AZ0Ylc0WcebtlQ7dxxV8Oh6nbpdl/bkgV0Dgos
         oCFhvdVLPPTyO1uMdMJi9mkBVxmvcOLpvb9VQYOXhVFkXyp1awIdxcoz/ppzabcr/p
         0T4e5Y3rT3AERrBFx6E1aygYAtYx+Sz1h0RX0ZKx/d+7HcJ/rNC5vX9ZJuNtmoS2B+
         Xta9XLJ+NGZYwNuNtn8zCVY44jgWiE4qb8Yf1YXaKWTiZuk1feUWXlUSMBiLT0TACP
         ukDW7uSIp3pDraIeCJfqCy0S1fHKBd9bIB0vSJGd1jt0pvJR4fbQAndzBP3DgMk4T1
         /2zWXM6XUG9RA==
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
Subject: [RFC PATCH 01/22] riscv: vdso: Unify vdso32 & compat_vdso into vdso/Makefile
Date:   Thu, 18 May 2023 09:09:52 -0400
Message-Id: <20230518131013.3366406-2-guoren@kernel.org>
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

Linux kernel abi and vdso abi could be different, and current
vdso/Makefile force vdso use the same abi as the kernel. It isn't
suitable for the next s64ilp32 patch series because s64ilp32 uses
64ilp32 abi in the kernel but still uses 32ilp32 in the userspace. This
patch unifies vdso32 & compat_vdso into vdso/Makefile to solve this
problem, similar to Powerpc's vdso framework.

Before this:
 - vdso/
 - vdso/vdso.S
 - vdso/gen_vdso_offsets.sh
 - compat_vdso/compat_vdso.S
 - compat_vdso/gen_compat_vdso_offsets.sh
 - vdso.c

After this:
 - vdso/
 - vdso64.S
 - vdso/gen_vdso64_offsets.sh
 - vdso32.S
 - vdso/gen_vdso32_offsets.sh
 - vdso.c

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig                            |  11 ++
 arch/riscv/Makefile                           |  15 +-
 arch/riscv/include/asm/vdso.h                 |  34 +++-
 arch/riscv/include/asm/vdso/gettimeofday.h    |   7 +-
 arch/riscv/kernel/Makefile                    |   3 +-
 arch/riscv/kernel/compat_signal.c             |   2 +-
 arch/riscv/kernel/vdso.c                      |   4 +-
 arch/riscv/kernel/vdso/Makefile               | 179 ++++++++++++------
 ..._vdso_offsets.sh => gen_vdso32_offsets.sh} |   2 +-
 arch/riscv/kernel/vdso/gen_vdso64_offsets.sh  |   5 +
 arch/riscv/kernel/vdso32.S                    |   8 +
 arch/riscv/kernel/{vdso/vdso.S => vdso64.S}   |   8 +-
 12 files changed, 197 insertions(+), 81 deletions(-)
 rename arch/riscv/kernel/vdso/{gen_vdso_offsets.sh => gen_vdso32_offsets.sh} (78%)
 create mode 100755 arch/riscv/kernel/vdso/gen_vdso64_offsets.sh
 create mode 100644 arch/riscv/kernel/vdso32.S
 rename arch/riscv/kernel/{vdso/vdso.S => vdso64.S} (73%)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c58d74235363..643884620cd6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -5,9 +5,11 @@
 #
 
 config 64BIT
+	select VDSO64
 	bool
 
 config 32BIT
+	select VDSO32
 	bool
 
 config RISCV
@@ -248,6 +250,14 @@ config RISCV_DMA_NONCOHERENT
 config AS_HAS_INSN
 	def_bool $(as-instr,.insn r 51$(comma) 0$(comma) 0$(comma) t0$(comma) t0$(comma) zero)
 
+config VDSO32
+	bool
+	depends on MMU
+
+config VDSO64
+	bool
+	depends on MMU
+
 source "arch/riscv/Kconfig.socs"
 source "arch/riscv/Kconfig.errata"
 
@@ -594,6 +604,7 @@ config CRASH_DUMP
 config COMPAT
 	bool "Kernel support for 32-bit U-mode"
 	default 64BIT
+	select VDSO32
 	depends on 64BIT && MMU
 	help
 	  This option enables support for a 32-bit U-mode running under a 64-bit
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index e859e1721a8f..dafe958c4217 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -122,18 +122,19 @@ libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
 PHONY += vdso_install
 vdso_install:
-	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso $@
-	$(if $(CONFIG_COMPAT),$(Q)$(MAKE) \
-		$(build)=arch/riscv/kernel/compat_vdso compat_$@)
+	$(if $(CONFIG_VDSO32),$(Q)$(MAKE) \
+		$(build)=arch/riscv/kernel/vdso vdso32_install
+	$(if $(CONFIG_VDSO64),$(Q)$(MAKE) \
+		$(build)=arch/riscv/kernel/vdso vdso64_install
 
 ifeq ($(KBUILD_EXTMOD),)
 ifeq ($(CONFIG_MMU),y)
 prepare: vdso_prepare
 vdso_prepare: prepare0
-	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso include/generated/vdso-offsets.h
-	$(if $(CONFIG_COMPAT),$(Q)$(MAKE) \
-		$(build)=arch/riscv/kernel/compat_vdso include/generated/compat_vdso-offsets.h)
-
+	$(if $(CONFIG_VDSO32),$(Q)$(MAKE) \
+		$(build)=arch/riscv/kernel/vdso include/generated/vdso32-offsets.h)
+	$(if $(CONFIG_VDSO64),$(Q)$(MAKE) \
+		$(build)=arch/riscv/kernel/vdso include/generated/vdso64-offsets.h)
 endif
 endif
 
diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
index f891478829a5..305ddc6de21c 100644
--- a/arch/riscv/include/asm/vdso.h
+++ b/arch/riscv/include/asm/vdso.h
@@ -17,22 +17,36 @@
 #define __VVAR_PAGES    2
 
 #ifndef __ASSEMBLY__
-#include <generated/vdso-offsets.h>
 
-#define VDSO_SYMBOL(base, name)							\
-	(void __user *)((unsigned long)(base) + __vdso_##name##_offset)
+#ifdef CONFIG_VDSO64
+#include <generated/vdso64-offsets.h>
 
-#ifdef CONFIG_COMPAT
-#include <generated/compat_vdso-offsets.h>
+#define VDSO64_SYMBOL(base, name)					\
+	(void __user *)((unsigned long)(base) + rv64__vdso_##name##_offset)
 
-#define COMPAT_VDSO_SYMBOL(base, name)						\
-	(void __user *)((unsigned long)(base) + compat__vdso_##name##_offset)
+extern char vdso64_start[], vdso64_end[];
 
-extern char compat_vdso_start[], compat_vdso_end[];
+#endif /* CONFIG_VDSO64 */
 
-#endif /* CONFIG_COMPAT */
+#ifdef CONFIG_VDSO32
+#include <generated/vdso32-offsets.h>
 
-extern char vdso_start[], vdso_end[];
+#define VDSO32_SYMBOL(base, name)					\
+	(void __user *)((unsigned long)(base) + rv32__vdso_##name##_offset)
+
+extern char vdso32_start[], vdso32_end[];
+
+#endif /* CONFIG_VDSO32 */
+
+#ifdef CONFIG_64BIT
+#define vdso_start	vdso64_start
+#define vdso_end	vdso64_end
+#define VDSO_SYMBOL	VDSO64_SYMBOL
+#else /* CONFIG_64BIT */
+#define vdso_start	vdso32_start
+#define vdso_end	vdso32_end
+#define VDSO_SYMBOL	VDSO32_SYMBOL
+#endif /* CONFIG_64BIT */
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/riscv/include/asm/vdso/gettimeofday.h b/arch/riscv/include/asm/vdso/gettimeofday.h
index ba3283cf7acc..a7ae8576797b 100644
--- a/arch/riscv/include/asm/vdso/gettimeofday.h
+++ b/arch/riscv/include/asm/vdso/gettimeofday.h
@@ -17,6 +17,7 @@
 
 #define VDSO_HAS_CLOCK_GETRES	1
 
+#ifdef __NR_gettimeofday
 static __always_inline
 int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
 			  struct timezone *_tz)
@@ -33,7 +34,9 @@ int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
 
 	return ret;
 }
+#endif
 
+#ifdef __NR_clock_gettime
 static __always_inline
 long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 {
@@ -49,7 +52,9 @@ long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 
 	return ret;
 }
+#endif
 
+#ifdef __NR_clock_getres
 static __always_inline
 int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 {
@@ -65,7 +70,7 @@ int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 
 	return ret;
 }
-
+#endif
 #endif /* CONFIG_GENERIC_TIME_VSYSCALL */
 
 static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 392fa6e35d4a..93de624f7fcd 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -52,6 +52,8 @@ obj-y	+= cacheinfo.o
 obj-y	+= patch.o
 obj-y	+= probes/
 obj-$(CONFIG_MMU) += vdso.o vdso/
+obj-$(CONFIG_VDSO64)  += vdso64.o
+obj-$(CONFIG_VDSO32)  += vdso32.o
 
 obj-$(CONFIG_RISCV_M_MODE)	+= traps_misaligned.o
 obj-$(CONFIG_FPU)		+= fpu.o
@@ -86,4 +88,3 @@ obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 obj-$(CONFIG_EFI)		+= efi.o
 obj-$(CONFIG_COMPAT)		+= compat_syscall_table.o
 obj-$(CONFIG_COMPAT)		+= compat_signal.o
-obj-$(CONFIG_COMPAT)		+= compat_vdso/
diff --git a/arch/riscv/kernel/compat_signal.c b/arch/riscv/kernel/compat_signal.c
index 6ec4e34255a9..8dea2012836e 100644
--- a/arch/riscv/kernel/compat_signal.c
+++ b/arch/riscv/kernel/compat_signal.c
@@ -217,7 +217,7 @@ int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 	if (err)
 		return -EFAULT;
 
-	regs->ra = (unsigned long)COMPAT_VDSO_SYMBOL(
+	regs->ra = (unsigned long)VDSO32_SYMBOL(
 			current->mm->context.vdso, rt_sigreturn);
 
 	/*
diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 9a68e7eaae4d..497cde87dc69 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -193,8 +193,8 @@ static struct vm_special_mapping rv_compat_vdso_maps[] __ro_after_init = {
 
 static struct __vdso_info compat_vdso_info __ro_after_init = {
 	.name = "compat_vdso",
-	.vdso_code_start = compat_vdso_start,
-	.vdso_code_end = compat_vdso_end,
+	.vdso_code_start = vdso32_start,
+	.vdso_code_end = vdso32_end,
 	.dm = &rv_compat_vdso_maps[RV_VDSO_MAP_VVAR],
 	.cm = &rv_compat_vdso_maps[RV_VDSO_MAP_VDSO],
 };
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 022258426050..e3c3bf669c7b 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -1,87 +1,158 @@
 # SPDX-License-Identifier: GPL-2.0-only
-# Copied from arch/tile/kernel/vdso/Makefile
 
 # Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
 # the inclusion of generic Makefile.
 ARCH_REL_TYPE_ABS := R_RISCV_32|R_RISCV_64|R_RISCV_JUMP_SLOT
 include $(srctree)/lib/vdso/Makefile
-# Symbols present in the vdso
-vdso-syms  = rt_sigreturn
-ifdef CONFIG_64BIT
-vdso-syms += vgettimeofday
-endif
-vdso-syms += getcpu
-vdso-syms += flush_icache
-vdso-syms += hwprobe
-vdso-syms += sys_hwprobe
 
-# Files to link into the vdso
-obj-vdso = $(patsubst %, %.o, $(vdso-syms)) note.o
+VDSO_CC := $(CC)
+VDSO_LD := $(LD)
+
+# Disable profiling and instrumentation for VDSO code
+GCOV_PROFILE := n
+KCOV_INSTRUMENT := n
+KASAN_SANITIZE := n
+UBSAN_SANITIZE := n
 
 ccflags-y := -fno-stack-protector
 ccflags-y += -DDISABLE_BRANCH_PROFILING
 
-ifneq ($(c-gettimeofday-y),)
-  CFLAGS_vgettimeofday.o += -fPIC -include $(c-gettimeofday-y)
+CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
+ifneq ($(filter vgettimeofday, $(vdso-cc-syms)),)
+	CPPFLAGS_vdso.lds += -DHAS_VGETTIMEOFDAY
 endif
 
-CFLAGS_hwprobe.o += -fPIC
+# strip rule for the .so file
+$(obj)/%.so: OBJCOPYFLAGS := -S
+$(obj)/%.so: $(obj)/%.so.dbg FORCE
+	$(call if_changed,objcopy)
 
-# Build rules
-targets := $(obj-vdso) vdso.so vdso.so.dbg vdso.lds
-obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
+# install commands for the unstripped file
+quiet_cmd_vdso_install = INSTALL $@
+      cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
 
-obj-y += vdso.o
-CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
-ifneq ($(filter vgettimeofday, $(vdso-syms)),)
-CPPFLAGS_vdso.lds += -DHAS_VGETTIMEOFDAY
-endif
+# Symbols present in the vdso
+ifdef CONFIG_VDSO64
+vdso64-as-syms  = rt_sigreturn
+vdso64-as-syms += getcpu
+vdso64-as-syms += flush_icache
+vdso64-as-syms += sys_hwprobe
 
-# Disable -pg to prevent insert call site
-CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE)
+vdso64-cc-syms  = vgettimeofday
+vdso64-cc-syms += hwprobe
 
-# Disable profiling and instrumentation for VDSO code
-GCOV_PROFILE := n
-KCOV_INSTRUMENT := n
-KASAN_SANITIZE := n
-UBSAN_SANITIZE := n
+obj-as-vdso64  = $(patsubst %, %-64.o, $(vdso64-as-syms)) note-64.o
+obj-as-vdso64 := $(addprefix $(obj)/, $(obj-as-vdso64))
 
-# Force dependency
-$(obj)/vdso.o: $(obj)/vdso.so
+obj-cc-vdso64  = $(patsubst %, %-64.o, $(vdso64-cc-syms))
+obj-cc-vdso64 := $(addprefix $(obj)/, $(obj-cc-vdso64))
 
-# link rule for the .so file, .lds has to be first
-$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
-	$(call if_changed,vdsold)
-LDFLAGS_vdso.so.dbg = -shared -S -soname=linux-vdso.so.1 \
+targets += $(obj-as-vdso64) $(obj-cc-vdso64) vdso64.so vdso64.so.dbg vdso64.lds
+
+$(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(obj-as-vdso64) $(obj-cc-vdso64) FORCE
+	$(call if_changed,vdso64ld)
+LDFLAGS_vdso64.so.dbg = -shared -S -soname=linux-vdso64.so.1 \
 	--build-id=sha1 --hash-style=both --eh-frame-hdr
+# The DSO images are built using a special linker script
+# Make sure only to export the intended __vdso_xxx symbol offsets.
+quiet_cmd_vdso64ld = VDSO64LD  $@
+      cmd_vdso64ld = $(VDSO_LD) $(ld_flags) $(VDSO64_LD_FLAGS) -T $(filter-out FORCE,$^) -o $@.tmp && \
+                   $(OBJCOPY) $(patsubst %, -G __vdso_%, $(vdso64-as-syms) $(vdso64-cc-syms)) $@.tmp $@ && \
+                   rm $@.tmp
 
-# strip rule for the .so file
-$(obj)/%.so: OBJCOPYFLAGS := -S
-$(obj)/%.so: $(obj)/%.so.dbg FORCE
-	$(call if_changed,objcopy)
+# actual build commands
+quiet_cmd_vdso64as = VDSO64AS $@
+      cmd_vdso64as = $(VDSO_CC) $(a_flags) $(VDSO64_CC_FLAGS) -c -o $@ $<
+quiet_cmd_vdso64cc = VDSO64CC $@
+      cmd_vdso64cc = $(VDSO_CC) $(c_flags) $(VDSO64_CC_FLAGS) -c -o $@ $<
+
+# Force dependency
+$(obj)/vdso64.o: $(obj)/vdso64.so
+
+$(obj-as-vdso64): %-64.o: %.S FORCE
+	$(call if_changed_dep,vdso64as)
+$(obj-cc-vdso64): %-64.o: %.c FORCE
+	$(call if_changed_dep,vdso64cc)
+
+CFLAGS_vgettimeofday-64.o += -fPIC -include $(c-gettimeofday-y)
+# Disable -pg to prevent insert call site
+CFLAGS_REMOVE_vgettimeofday-64.o = $(CC_FLAGS_FTRACE)
+
+CFLAGS_hwprobe-64.o += -fPIC
 
 # Generate VDSO offsets using helper script
-gen-vdsosym := $(srctree)/$(src)/gen_vdso_offsets.sh
-quiet_cmd_vdsosym = VDSOSYM $@
-	cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
+gen-vdso64sym := $(srctree)/$(src)/gen_vdso64_offsets.sh
+quiet_cmd_vdso64sym = VDSO64SYM $@
+	cmd_vdso64sym = $(NM) $< | $(gen-vdso64sym) | LC_ALL=C sort > $@
 
-include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
-	$(call if_changed,vdsosym)
+include/generated/vdso64-offsets.h: $(obj)/vdso64.so.dbg $(obj)/vdso64.so FORCE
+	$(call if_changed,vdso64sym)
+
+vdso64.so: $(obj)/vdso64.so.dbg
+	@mkdir -p $(MODLIB)/vdso
+	$(call cmd,vdso_install)
+
+vdso64_install: vdso64.so
+endif
+
+ifdef CONFIG_VDSO32
+vdso32-as-syms  = rt_sigreturn
+vdso32-as-syms += getcpu
+vdso32-as-syms += flush_icache
+vdso32-as-syms += sys_hwprobe
+
+vdso32-cc-syms += hwprobe
+
+VDSO32_CC_FLAGS := -march=rv32g -mabi=ilp32
+VDSO32_LD_FLAGS := -melf32lriscv
+
+obj-as-vdso32  = $(patsubst %, %-32.o, $(vdso32-as-syms)) note-32.o
+obj-as-vdso32 := $(addprefix $(obj)/, $(obj-as-vdso32))
+
+obj-cc-vdso32  = $(patsubst %, %-32.o, $(vdso32-cc-syms))
+obj-cc-vdso32 := $(addprefix $(obj)/, $(obj-cc-vdso32))
+
+targets += $(obj-as-vdso32) $(obj-cc-vdso32) vdso32.so vdso32.so.dbg vdso32.lds
+
+$(obj)/vdso32.so.dbg: $(obj)/vdso.lds $(obj-as-vdso32) $(obj-cc-vdso32) FORCE
+	$(call if_changed,vdso32ld)
+LDFLAGS_vdso32.so.dbg = -shared -S -soname=linux-vdso32.so.1 \
+	--build-id=sha1 --hash-style=both --eh-frame-hdr
 
-# actual build commands
 # The DSO images are built using a special linker script
 # Make sure only to export the intended __vdso_xxx symbol offsets.
-quiet_cmd_vdsold = VDSOLD  $@
-      cmd_vdsold = $(LD) $(ld_flags) -T $(filter-out FORCE,$^) -o $@.tmp && \
-                   $(OBJCOPY) $(patsubst %, -G __vdso_%, $(vdso-syms)) $@.tmp $@ && \
+quiet_cmd_vdso32ld = VDSO32LD  $@
+      cmd_vdso32ld = $(VDSO_LD) $(ld_flags) $(VDSO32_LD_FLAGS) -T $(filter-out FORCE,$^) -o $@.tmp && \
+                   $(OBJCOPY) $(patsubst %, -G __vdso_%, $(vdso32-as-syms) $(vdso32-cc-syms)) $@.tmp $@ && \
                    rm $@.tmp
 
-# install commands for the unstripped file
-quiet_cmd_vdso_install = INSTALL $@
-      cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
+# actual build commands
+quiet_cmd_vdso32as = VDSO32AS $@
+      cmd_vdso32as = $(VDSO_CC) $(a_flags) $(VDSO32_CC_FLAGS) -c -o $@ $<
+quiet_cmd_vdso32cc = VDSO32CC $@
+      cmd_vdso32cc = $(VDSO_CC) $(c_flags) $(VDSO32_CC_FLAGS) -c -o $@ $<
 
-vdso.so: $(obj)/vdso.so.dbg
+# Force dependency
+$(obj)/vdso32.o: $(obj)/vdso32.so
+
+$(obj-as-vdso32): %-32.o: %.S FORCE
+	$(call if_changed_dep,vdso32as)
+$(obj-cc-vdso32): %-32.o: %.c FORCE
+	$(call if_changed_dep,vdso32cc)
+
+CFLAGS_hwprobe-32.o += -fPIC
+
+# Generate VDSO offsets using helper script
+gen-vdso32sym := $(srctree)/$(src)/gen_vdso32_offsets.sh
+quiet_cmd_vdso32sym = VDSO32SYM $@
+	cmd_vdso32sym = $(NM) $< | $(gen-vdso32sym) | LC_ALL=C sort > $@
+
+include/generated/vdso32-offsets.h: $(obj)/vdso32.so.dbg $(obj)/vdso32.so FORCE
+	$(call if_changed,vdso32sym)
+
+vdso32.so: $(obj)/vdso32.so.dbg
 	@mkdir -p $(MODLIB)/vdso
 	$(call cmd,vdso_install)
 
-vdso_install: vdso.so
+vdso32_install: vdso32.so
+endif
diff --git a/arch/riscv/kernel/vdso/gen_vdso_offsets.sh b/arch/riscv/kernel/vdso/gen_vdso32_offsets.sh
similarity index 78%
rename from arch/riscv/kernel/vdso/gen_vdso_offsets.sh
rename to arch/riscv/kernel/vdso/gen_vdso32_offsets.sh
index c2e5613f3495..c0dee7361530 100755
--- a/arch/riscv/kernel/vdso/gen_vdso_offsets.sh
+++ b/arch/riscv/kernel/vdso/gen_vdso32_offsets.sh
@@ -2,4 +2,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 LC_ALL=C
-sed -n -e 's/^[0]\+\(0[0-9a-fA-F]*\) . \(__vdso_[a-zA-Z0-9_]*\)$/\#define \2_offset\t0x\1/p'
+sed -n -e 's/^[0]\+\(0[0-9a-fA-F]*\) . \(__vdso_[a-zA-Z0-9_]*\)$/\#define rv32\2_offset\t0x\1/p'
diff --git a/arch/riscv/kernel/vdso/gen_vdso64_offsets.sh b/arch/riscv/kernel/vdso/gen_vdso64_offsets.sh
new file mode 100755
index 000000000000..ac265ed49eaf
--- /dev/null
+++ b/arch/riscv/kernel/vdso/gen_vdso64_offsets.sh
@@ -0,0 +1,5 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+LC_ALL=C
+sed -n -e 's/^[0]\+\(0[0-9a-fA-F]*\) . \(__vdso_[a-zA-Z0-9_]*\)$/\#define rv64\2_offset\t0x\1/p'
diff --git a/arch/riscv/kernel/vdso32.S b/arch/riscv/kernel/vdso32.S
new file mode 100644
index 000000000000..9bdf3cb20ccb
--- /dev/null
+++ b/arch/riscv/kernel/vdso32.S
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#define	vdso64_start	vdso32_start
+#define	vdso64_end	vdso32_end
+
+#define	__VDSO_PATH	"arch/riscv/kernel/vdso/vdso32.so"
+
+#include "vdso64.S"
diff --git a/arch/riscv/kernel/vdso/vdso.S b/arch/riscv/kernel/vdso64.S
similarity index 73%
rename from arch/riscv/kernel/vdso/vdso.S
rename to arch/riscv/kernel/vdso64.S
index 83f1c899e8d8..498b73da0dbf 100644
--- a/arch/riscv/kernel/vdso/vdso.S
+++ b/arch/riscv/kernel/vdso64.S
@@ -8,16 +8,16 @@
 #include <asm/page.h>
 
 #ifndef __VDSO_PATH
-#define __VDSO_PATH "arch/riscv/kernel/vdso/vdso.so"
+#define __VDSO_PATH "arch/riscv/kernel/vdso/vdso64.so"
 #endif
 
 	__PAGE_ALIGNED_DATA
 
-	.globl vdso_start, vdso_end
+	.globl vdso64_start, vdso64_end
 	.balign PAGE_SIZE
-vdso_start:
+vdso64_start:
 	.incbin __VDSO_PATH
 	.balign PAGE_SIZE
-vdso_end:
+vdso64_end:
 
 	.previous
-- 
2.36.1

