Return-Path: <linux-arch+bounces-140-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D41017E8E88
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 07:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736511F20FAA
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3744410;
	Sun, 12 Nov 2023 06:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lT4YE0Oj"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5FE440A
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 06:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC40C433CC;
	Sun, 12 Nov 2023 06:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699769751;
	bh=rxwIgp8hQp0Nt2lN35u6PopHm3HPAlKUrKzCrN0lOv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lT4YE0OjIKAEa87Flp9Iq31j+R93R3Y6ygJ9cjCzEtjj4rSQDfgZ+lCifue2vC7A0
	 DHpnccClCtCx2ad112n/ZAI3XB3aqPA7SW95BNGTWD9l2BvbvOREnjVUmWj0lDL54E
	 9vFY5BaSkBCkpJr/5gqMOvoyTRQum91KuUnkoIYQkuRf5+Y7BFXR3RhGei7fLGXRqi
	 fA9VE043VDoMeAFCs6tSNgK4rVPZrXOHWRfyFbZrV7fMRCJ7/elUvwLhOH2/vjHewT
	 efgUxa75Mi+zXxRLNT4VCW/0HFZxrFgMWjBHRKTfP5nojYXlW5cW1lAIqE1T58BI1d
	 gn6AEW/df+s8Q==
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
Subject: [RFC PATCH V2 04/38] riscv: u64ilp32: Introduce ILP32 vdso for UXL=64
Date: Sun, 12 Nov 2023 01:14:40 -0500
Message-Id: <20231112061514.2306187-5-guoren@kernel.org>
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

This is the first patch to introduce ILP32 abi for RV64. Here is the
diagram:

  +--------------------------------+------------+
  | +-------------------+--------+ | +--------+ |
  | |           (compat)|(compat)| | |        | |
  | |u64lp64    u64ilp32|u32ilp32| | |u32ilp32| | ABI
  | |           ^^^^^^^^|        | | |        | |
  | +-------------------+--------+ | +--------+ |
  | +-------------------+--------+ | +--------+ |
  | |       UXL=64      | UXL=32 | | | UXL=32 | | ISA
  | +-------------------+--------+ | +--------+ |
  +--------------------------------+------------+-------
  | +----------------------------+ | +--------+ |
  | |              64BIT         | | |   32BIT| | Kernel
  | |            s64lp64         | | |s32ilp32| | ABI
  | +----------------------------+ | +--------+ |
  | +----------------------------+ | +--------+ |
  | |             SXL=64         | | | SXL=32 | | ISA
  | +----------------------------+ | +--------+ |
  +--------------------------------+------------+

The 64ilp32 userspace needs another virtual dynamic shared object
independent from vdso32(32ilp32) and vdso64(64ilp32).

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig                            |  5 ++
 arch/riscv/Makefile                           |  4 ++
 arch/riscv/kernel/Makefile                    |  1 +
 arch/riscv/kernel/vdso/Makefile               | 59 +++++++++++++++++++
 .../kernel/vdso/gen_vdso64ilp32_offsets.sh    |  5 ++
 arch/riscv/kernel/vdso64ilp32.S               |  8 +++
 6 files changed, 82 insertions(+)
 create mode 100755 arch/riscv/kernel/vdso/gen_vdso64ilp32_offsets.sh
 create mode 100644 arch/riscv/kernel/vdso64ilp32.S

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 24b1b6abf0a7..5d770b8e2756 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -288,6 +288,10 @@ config VDSO64
 	bool
 	depends on MMU
 
+config VDSO64ILP32
+	bool
+	depends on MMU
+
 source "arch/riscv/Kconfig.socs"
 source "arch/riscv/Kconfig.errata"
 
@@ -707,6 +711,7 @@ config COMPAT
 	bool "Kernel support for 32-bit U-mode"
 	default 64BIT
 	select VDSO32
+	select VDSO64ILP32 if $(cc-option,-march=rv64g -mabi=ilp32)
 	depends on 64BIT && MMU
 	help
 	  This option enables support for a 32-bit U-mode running under a 64-bit
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 3b7d5ebf3c78..8605050bddd0 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -140,6 +140,8 @@ vdso_install:
 		$(build)=arch/riscv/kernel/vdso vdso32_install
 	$(if $(CONFIG_VDSO64),$(Q)$(MAKE) \
 		$(build)=arch/riscv/kernel/vdso vdso64_install
+	$(if $(CONFIG_VDSO64ILP32),$(Q)$(MAKE) \
+		$(build)=arch/riscv/kernel/vdso vdso64ilp32_install
 
 ifeq ($(KBUILD_EXTMOD),)
 ifeq ($(CONFIG_MMU),y)
@@ -149,6 +151,8 @@ vdso_prepare: prepare0
 		$(build)=arch/riscv/kernel/vdso include/generated/vdso32-offsets.h)
 	$(if $(CONFIG_VDSO64),$(Q)$(MAKE) \
 		$(build)=arch/riscv/kernel/vdso include/generated/vdso64-offsets.h)
+	$(if $(CONFIG_VDSO64ILP32),$(Q)$(MAKE) \
+		$(build)=arch/riscv/kernel/vdso include/generated/vdso64ilp32-offsets.h)
 endif
 endif
 
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 23032ac7f51d..a4583a29b28b 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -59,6 +59,7 @@ obj-y	+= probes/
 obj-$(CONFIG_MMU) += vdso.o vdso/
 obj-$(CONFIG_VDSO64)  += vdso64.o
 obj-$(CONFIG_VDSO32)  += vdso32.o
+obj-$(CONFIG_VDSO64ILP32)  += vdso64ilp32.o
 
 obj-$(CONFIG_RISCV_M_MODE)	+= traps_misaligned.o
 obj-$(CONFIG_FPU)		+= fpu.o
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index df8f68bb0937..629989b1ad05 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -148,3 +148,62 @@ vdso32.so: $(obj)/vdso32.so.dbg
 
 vdso32_install: vdso32.so
 endif
+
+ifdef CONFIG_VDSO64ILP32
+VDSO64ILP32_CC_FLAGS := -march=rv64g -mabi=ilp32
+VDSO64ILP32_LD_FLAGS := -melf32lriscv
+
+obj-as-vdso64ilp32  = $(patsubst %, %-64ilp32.o, $(vdso-as-syms)) note-64ilp32.o
+obj-as-vdso64ilp32 := $(addprefix $(obj)/, $(obj-as-vdso64ilp32))
+
+obj-cc-vdso64ilp32  = $(patsubst %, %-64ilp32.o, $(vdso-cc-syms))
+obj-cc-vdso64ilp32 := $(addprefix $(obj)/, $(obj-cc-vdso64ilp32))
+
+targets += $(obj-as-vdso64ilp32) $(obj-cc-vdso64ilp32) vdso64ilp32.so vdso64ilp32.so.dbg vdso64ilp32.lds
+
+$(obj)/vdso64ilp32.so.dbg: $(obj)/vdso.lds $(obj-as-vdso64ilp32) $(obj-cc-vdso64ilp32) FORCE
+	$(call if_changed,vdso64ilp32ld)
+LDFLAGS_vdso64ilp32.so.dbg = -shared -S -soname=linux-vdso64ilp32.so.1 \
+	--build-id=sha1 --hash-style=both --eh-frame-hdr
+
+# The DSO images are built using a special linker script
+# Make sure only to export the intended __vdso_xxx symbol offsets.
+quiet_cmd_vdso64ilp32ld = VDSO64ILP32LD  $@
+      cmd_vdso64ilp32ld = $(VDSO_LD) $(ld_flags) $(VDSO64ILP32_LD_FLAGS) -T $(filter-out FORCE,$^) -o $@.tmp && \
+                   $(OBJCOPY) $(patsubst %, -G __vdso_%, $(vdso-as-syms) $(vdso-cc-syms)) $@.tmp $@ && \
+                   rm $@.tmp
+
+# actual build commands
+quiet_cmd_vdso64ilp32as = VDSO64ILP32AS $@
+      cmd_vdso64ilp32as = $(VDSO_CC) $(a_flags) $(VDSO64ILP32_CC_FLAGS) -c -o $@ $<
+quiet_cmd_vdso64ilp32cc = VDSO64ILP32CC $@
+      cmd_vdso64ilp32cc = $(VDSO_CC) $(c_flags) $(VDSO64ILP32_CC_FLAGS) -c -o $@ $<
+
+# Force dependency
+$(obj)/vdso64ilp32.o: $(obj)/vdso64ilp32.so
+
+$(obj-as-vdso64ilp32): %-64ilp32.o: %.S FORCE
+	$(call if_changed_dep,vdso64ilp32as)
+$(obj-cc-vdso64ilp32): %-64ilp32.o: %.c FORCE
+	$(call if_changed_dep,vdso64ilp32cc)
+
+CFLAGS_hwprobe-64ilp32.o += -fPIC
+
+CFLAGS_vgettimeofday-64ilp32.o += -fPIC -include $(c-gettimeofday-y)
+# Disable -pg to prevent insert call site
+CFLAGS_REMOVE_vgettimeofday-64ilp32.o = $(CC_FLAGS_FTRACE)
+
+# Generate VDSO offsets using helper script
+gen-vdso64ilp32sym := $(srctree)/$(src)/gen_vdso64ilp32_offsets.sh
+quiet_cmd_vdso64ilp32sym = VDSO64ILP32SYM $@
+	cmd_vdso64ilp32sym = $(NM) $< | $(gen-vdso64ilp32sym) | LC_ALL=C sort > $@
+
+include/generated/vdso64ilp32-offsets.h: $(obj)/vdso64ilp32.so.dbg $(obj)/vdso64ilp32.so FORCE
+	$(call if_changed,vdso64ilp32sym)
+
+vdso64ilp32.so: $(obj)/vdso64ilp32.so.dbg
+	@mkdir -p $(MODLIB)/vdso
+	$(call cmd,vdso_install)
+
+vdso64ilp32_install: vdso64ilp32.so
+endif
diff --git a/arch/riscv/kernel/vdso/gen_vdso64ilp32_offsets.sh b/arch/riscv/kernel/vdso/gen_vdso64ilp32_offsets.sh
new file mode 100755
index 000000000000..6af2db7a26ad
--- /dev/null
+++ b/arch/riscv/kernel/vdso/gen_vdso64ilp32_offsets.sh
@@ -0,0 +1,5 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+LC_ALL=C
+sed -n -e 's/^[0]\+\(0[0-9a-fA-F]*\) . \(__vdso_[a-zA-Z0-9_]*\)$/\#define rv64ilp32\2_offset\t0x\1/p'
diff --git a/arch/riscv/kernel/vdso64ilp32.S b/arch/riscv/kernel/vdso64ilp32.S
new file mode 100644
index 000000000000..5b658da1eeef
--- /dev/null
+++ b/arch/riscv/kernel/vdso64ilp32.S
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#define	vdso64_start	vdso64ilp32_start
+#define	vdso64_end	vdso64ilp32_end
+
+#define	__VDSO_PATH	"arch/riscv/kernel/vdso/vdso64ilp32.so"
+
+#include "vdso64.S"
-- 
2.36.1


