Return-Path: <linux-arch+bounces-4220-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDC78BCF43
	for <lists+linux-arch@lfdr.de>; Mon,  6 May 2024 15:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785681F21214
	for <lists+linux-arch@lfdr.de>; Mon,  6 May 2024 13:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2707B86267;
	Mon,  6 May 2024 13:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBmws5/F"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF36D86268;
	Mon,  6 May 2024 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002589; cv=none; b=UE0tEIZoXpNzfCt/OmtDM5fXSSF6o3eiRpd6/6UNoectG3m7a6fzMYDly2Bx7DuctKsCQFOzmqy0/C97vCze0JiWK9ySjBx4DcYZErewwOTa5nLi5Y7zEggM8CBlEwbrr6P5tU5HGFfq/H2Adguy8k0MH3ZwgGSfjfi9RHnO23c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002589; c=relaxed/simple;
	bh=CfFp9hEAOPT0198pXbg/EJ6COlQrGk6vxz6F4gVUhA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HES1myswdR/kjCEeQstD7zunnmvk8qG6NLF3QZjAXywsV3qdliXIB2YmDCraa4gblTOX7oCXL5NR+i0/ewe1/ENG1hwUgaOVjpOY3/oRoIgrnMHeVC0gsP4Mj4AvwPCx0XzvUNzgIC0oEuIhP2MKFb5Gu9AX8lpwjOrUvKIkDOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBmws5/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B887BC4AF63;
	Mon,  6 May 2024 13:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715002588;
	bh=CfFp9hEAOPT0198pXbg/EJ6COlQrGk6vxz6F4gVUhA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QBmws5/Fu1QaGnFhdS0z+pL5Dxyn+pSNliEezIEa2TzN3g/q519ZQM2onPUHfoBMM
	 FvRdVOEra6XOf5+MjpxxJKwaoeSnwzZpIRg8H/BAuQRRVi3dqi936DY2/SqZF7SL2L
	 TfUfFqqI805KgSK4/6HxZUjvdqJX09/BShnZFObXUHUScwAUqTSoCe69BRDTlpOaSe
	 pKBsDoyQp/XTkjQ7sDdDFfercAPzNluWXBcpiKT2V71W8QB+12DFIuHocIe9yO3/LD
	 kUkgrm0AjFmjxRk4rTeiRx9cml2RDZ+NgcO8jo2lz7+fEUKs1h9OamVul9Rq/jmGjE
	 JwonlllCRrqJw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/3] Makefile: remove redundant tool coverage variables
Date: Mon,  6 May 2024 22:35:43 +0900
Message-Id: <20240506133544.2861555-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240506133544.2861555-1-masahiroy@kernel.org>
References: <20240506133544.2861555-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now Kbuild provides reasonable defaults for objtool, sanitizers, and
profilers.

Remove redundant variables.

Note:

The coverage for some objects will be changed:

  - include arch/mips/vdso/vdso-image.o into UBSAN, GCOV, KCOV
  - include arch/sparc/vdso/vdso-image-*.o into UBSAN
  - include arch/sparc/vdso/vma.o into UBSAN
  - include arch/x86/entry/vdso/extable.o into KASAN, KCSAN, UBSAN, GCOV, KCOV
  - include arch/x86/entry/vdso/vdso-image-*.o into KASAN, KCSAN, UBSAN, GCOV, KCOV
  - include arch/x86/entry/vdso/vdso32-setup.o into KASAN, KCSAN, UBSAN, GCOV, KCOV
  - include arch/x86/entry/vdso/vma.o into GCOV, KCOV
  - include arch/x86/um/vdso/vma.o into KASAN, GCOV, KCOV

I believe these are positive effects because all of them are kernel
space objects.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arm/boot/bootp/Makefile           |  1 -
 arch/arm/boot/compressed/Makefile      |  7 -------
 arch/arm/vdso/Makefile                 |  9 ---------
 arch/arm64/kernel/pi/Makefile          |  6 ------
 arch/arm64/kernel/vdso/Makefile        |  8 --------
 arch/arm64/kvm/hyp/nvhe/Makefile       | 13 -------------
 arch/csky/kernel/vdso/Makefile         |  4 ----
 arch/loongarch/vdso/Makefile           |  7 -------
 arch/mips/boot/compressed/Makefile     |  6 ------
 arch/mips/vdso/Makefile                |  7 -------
 arch/parisc/boot/compressed/Makefile   |  4 ----
 arch/powerpc/kernel/vdso/Makefile      |  8 --------
 arch/powerpc/purgatory/Makefile        |  3 ---
 arch/riscv/boot/Makefile               |  2 --
 arch/riscv/kernel/compat_vdso/Makefile |  6 ------
 arch/riscv/kernel/pi/Makefile          |  6 ------
 arch/riscv/kernel/vdso/Makefile        |  6 ------
 arch/riscv/purgatory/Makefile          |  8 --------
 arch/s390/boot/Makefile                |  2 ++
 arch/s390/kernel/vdso32/Makefile       |  8 --------
 arch/s390/kernel/vdso64/Makefile       |  8 --------
 arch/s390/purgatory/Makefile           |  8 --------
 arch/sh/boot/compressed/Makefile       |  3 ---
 arch/sparc/vdso/Makefile               |  2 --
 arch/x86/boot/Makefile                 | 15 ---------------
 arch/x86/boot/compressed/Makefile      | 11 -----------
 arch/x86/entry/vdso/Makefile           | 26 --------------------------
 arch/x86/purgatory/Makefile            |  9 ---------
 arch/x86/realmode/rm/Makefile          | 11 -----------
 arch/x86/um/vdso/Makefile              |  7 -------
 arch/xtensa/boot/lib/Makefile          |  5 -----
 drivers/firmware/efi/libstub/Makefile  | 11 -----------
 drivers/misc/lkdtm/Makefile            |  4 ----
 init/Makefile                          |  3 ---
 scripts/Makefile.vmlinux               |  3 ---
 scripts/mod/Makefile                   |  1 -
 36 files changed, 2 insertions(+), 246 deletions(-)

diff --git a/arch/arm/boot/bootp/Makefile b/arch/arm/boot/bootp/Makefile
index a2934e6fd89a..f3443f7d7b02 100644
--- a/arch/arm/boot/bootp/Makefile
+++ b/arch/arm/boot/bootp/Makefile
@@ -5,7 +5,6 @@
 # This file is included by the global makefile so that you can add your own
 # architecture-specific flags and dependencies.
 #
-GCOV_PROFILE	:= n
 
 ifdef PHYS_OFFSET
 add_hex = $(shell printf 0x%x $$(( $(1) + $(2) )) )
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 726ecabcef09..6bca03c0c7f0 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -22,13 +22,6 @@ ifeq ($(CONFIG_ARM_VIRT_EXT),y)
 OBJS		+= hyp-stub.o
 endif
 
-GCOV_PROFILE		:= n
-KASAN_SANITIZE		:= n
-
-# Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
-KCOV_INSTRUMENT		:= n
-UBSAN_SANITIZE		:= n
-
 #
 # Architecture dependencies
 #
diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index d761bd2e2f40..01067a2bc43b 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -33,15 +33,6 @@ else
 CFLAGS_vgettimeofday.o = -O2 -include $(c-gettimeofday-y)
 endif
 
-# Disable gcov profiling for VDSO code
-GCOV_PROFILE := n
-UBSAN_SANITIZE := n
-
-# Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
-KCOV_INSTRUMENT := n
-
-KASAN_SANITIZE := n
-
 # Force dependency
 $(obj)/vdso.o : $(obj)/vdso.so
 
diff --git a/arch/arm64/kernel/pi/Makefile b/arch/arm64/kernel/pi/Makefile
index 4393b41f0b71..4d11a8c29181 100644
--- a/arch/arm64/kernel/pi/Makefile
+++ b/arch/arm64/kernel/pi/Makefile
@@ -19,12 +19,6 @@ KBUILD_CFLAGS	:= $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
 # disable LTO
 KBUILD_CFLAGS	:= $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
 
-GCOV_PROFILE	:= n
-KASAN_SANITIZE	:= n
-KCSAN_SANITIZE	:= n
-UBSAN_SANITIZE	:= n
-KCOV_INSTRUMENT	:= n
-
 hostprogs	:= relacheck
 
 quiet_cmd_piobjcopy = $(quiet_cmd_objcopy)
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 53e86d3bc159..d63930c82839 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -40,11 +40,6 @@ CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
 				$(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) \
 				$(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
 				-Wmissing-prototypes -Wmissing-declarations
-KASAN_SANITIZE			:= n
-KCSAN_SANITIZE			:= n
-UBSAN_SANITIZE			:= n
-OBJECT_FILES_NON_STANDARD	:= y
-KCOV_INSTRUMENT			:= n
 
 CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny -fasynchronous-unwind-tables
 
@@ -52,9 +47,6 @@ ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
 endif
 
-# Disable gcov profiling for VDSO code
-GCOV_PROFILE := n
-
 targets += vdso.lds
 CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
 
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 2250253a6429..50fa0ffb6b7e 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -97,16 +97,3 @@ KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_CFI)
 # causes a build failure. Remove profile optimization flags.
 KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%, $(KBUILD_CFLAGS))
 KBUILD_CFLAGS += -fno-asynchronous-unwind-tables -fno-unwind-tables
-
-# KVM nVHE code is run at a different exception code with a different map, so
-# compiler instrumentation that inserts callbacks or checks into the code may
-# cause crashes. Just disable it.
-GCOV_PROFILE	:= n
-KASAN_SANITIZE	:= n
-KCSAN_SANITIZE	:= n
-UBSAN_SANITIZE	:= n
-KCOV_INSTRUMENT	:= n
-
-# Skip objtool checking for this directory because nVHE code is compiled with
-# non-standard build rules.
-OBJECT_FILES_NON_STANDARD := y
diff --git a/arch/csky/kernel/vdso/Makefile b/arch/csky/kernel/vdso/Makefile
index e79a725f5075..bc2261f5a8d4 100644
--- a/arch/csky/kernel/vdso/Makefile
+++ b/arch/csky/kernel/vdso/Makefile
@@ -23,10 +23,6 @@ obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
 obj-y += vdso.o vdso-syms.o
 CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
 
-# Disable gcov profiling for VDSO code
-GCOV_PROFILE := n
-KCOV_INSTRUMENT := n
-
 # Force dependency
 $(obj)/vdso.o: $(obj)/vdso.so
 
diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index cdfc4c793e2c..d724d46b07c8 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -1,11 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Objects to go into the VDSO.
 
-KASAN_SANITIZE := n
-UBSAN_SANITIZE := n
-KCOV_INSTRUMENT := n
-OBJECT_FILES_NON_STANDARD := y
-
 # Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile
 
@@ -39,8 +34,6 @@ ldflags-y := -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
 	$(filter -E%,$(KBUILD_CFLAGS)) -nostdlib -shared \
 	--hash-style=sysv --build-id -T
 
-GCOV_PROFILE := n
-
 #
 # Shared build commands.
 #
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 6cc28173bee8..e0b8ec9a9516 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -34,12 +34,6 @@ KBUILD_AFLAGS := $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
 	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) \
 	-DKERNEL_ENTRY=$(VMLINUX_ENTRY_ADDRESS)
 
-# Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
-KCOV_INSTRUMENT		:= n
-GCOV_PROFILE := n
-UBSAN_SANITIZE := n
-KCSAN_SANITIZE			:= n
-
 # decompressor objects (linked with vmlinuz)
 vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/string.o $(obj)/bswapsi.o
 
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 40b839e91806..b289b2c1b294 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -1,9 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Objects to go into the VDSO.
 
-# Sanitizer runtimes are unavailable and cannot be linked here.
- KCSAN_SANITIZE			:= n
-
 # Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile
 
@@ -60,10 +57,6 @@ ldflags-y := -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
 
 CFLAGS_REMOVE_vdso.o = $(CC_FLAGS_FTRACE)
 
-GCOV_PROFILE := n
-UBSAN_SANITIZE := n
-KCOV_INSTRUMENT := n
-
 # Check that we don't have PIC 'jalr t9' calls left
 quiet_cmd_vdso_mips_check = VDSOCHK $@
       cmd_vdso_mips_check = if $(OBJDUMP) --disassemble $@ | grep -E -h "jalr.*t9" > /dev/null; \
diff --git a/arch/parisc/boot/compressed/Makefile b/arch/parisc/boot/compressed/Makefile
index a294a1b58ee7..92227fa813dc 100644
--- a/arch/parisc/boot/compressed/Makefile
+++ b/arch/parisc/boot/compressed/Makefile
@@ -5,10 +5,6 @@
 # create a compressed self-extracting vmlinux image from the original vmlinux
 #
 
-KCOV_INSTRUMENT := n
-GCOV_PROFILE := n
-UBSAN_SANITIZE := n
-
 OBJECTS := head.o real2.o firmware.o misc.o piggy.o
 targets := vmlinux.lds vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2
 targets += vmlinux.bin.xz vmlinux.bin.lzma vmlinux.bin.lzo vmlinux.bin.lz4
diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
index 7d66b6e07993..1425b6edc66b 100644
--- a/arch/powerpc/kernel/vdso/Makefile
+++ b/arch/powerpc/kernel/vdso/Makefile
@@ -47,12 +47,6 @@ obj-vdso32 := $(addprefix $(obj)/, $(obj-vdso32))
 targets += $(obj-vdso64) vdso64.so.dbg vgettimeofday-64.o
 obj-vdso64 := $(addprefix $(obj)/, $(obj-vdso64))
 
-GCOV_PROFILE := n
-KCOV_INSTRUMENT := n
-UBSAN_SANITIZE := n
-KASAN_SANITIZE := n
-KCSAN_SANITIZE := n
-
 ccflags-y := -fno-common -fno-builtin
 ldflags-y := -Wl,--hash-style=both -nostdlib -shared -z noexecstack $(CLANG_FLAGS)
 ldflags-$(CONFIG_LD_IS_LLD) += $(call cc-option,--ld-path=$(LD),-fuse-ld=lld)
@@ -114,5 +108,3 @@ quiet_cmd_vdso64ld_and_check = VDSO64L $@
       cmd_vdso64ld_and_check = $(VDSOCC) $(ldflags-y) $(LD64FLAGS) -o $@ -Wl,-T$(filter %.lds,$^) $(filter %.o,$^); $(cmd_vdso_check)
 quiet_cmd_vdso64as = VDSO64A $@
       cmd_vdso64as = $(VDSOCC) $(a_flags) $(AS64FLAGS) -c -o $@ $<
-
-OBJECT_FILES_NON_STANDARD := y
diff --git a/arch/powerpc/purgatory/Makefile b/arch/powerpc/purgatory/Makefile
index 78473d69cd2b..e9890085953e 100644
--- a/arch/powerpc/purgatory/Makefile
+++ b/arch/powerpc/purgatory/Makefile
@@ -1,8 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-KASAN_SANITIZE := n
-KCSAN_SANITIZE := n
-
 targets += trampoline_$(BITS).o purgatory.ro
 
 # When profile-guided optimization is enabled, llvm emits two different
diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
index 8e7fc0edf21d..869c0345b908 100644
--- a/arch/riscv/boot/Makefile
+++ b/arch/riscv/boot/Makefile
@@ -14,8 +14,6 @@
 # Based on the ia64 and arm64 boot/Makefile.
 #
 
-KCOV_INSTRUMENT := n
-
 OBJCOPYFLAGS_Image :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
 OBJCOPYFLAGS_loader.bin :=-O binary
 OBJCOPYFLAGS_xipImage :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
diff --git a/arch/riscv/kernel/compat_vdso/Makefile b/arch/riscv/kernel/compat_vdso/Makefile
index 362208dfa7ee..24e37d1ef7ec 100644
--- a/arch/riscv/kernel/compat_vdso/Makefile
+++ b/arch/riscv/kernel/compat_vdso/Makefile
@@ -34,12 +34,6 @@ obj-compat_vdso := $(addprefix $(obj)/, $(obj-compat_vdso))
 obj-y += compat_vdso.o
 CPPFLAGS_compat_vdso.lds += -P -C -DCOMPAT_VDSO -U$(ARCH)
 
-# Disable profiling and instrumentation for VDSO code
-GCOV_PROFILE := n
-KCOV_INSTRUMENT := n
-KASAN_SANITIZE := n
-UBSAN_SANITIZE := n
-
 # Force dependency
 $(obj)/compat_vdso.o: $(obj)/compat_vdso.so
 
diff --git a/arch/riscv/kernel/pi/Makefile b/arch/riscv/kernel/pi/Makefile
index b75f150b923d..50bc5ef7dd2f 100644
--- a/arch/riscv/kernel/pi/Makefile
+++ b/arch/riscv/kernel/pi/Makefile
@@ -17,12 +17,6 @@ KBUILD_CFLAGS	+= -mcmodel=medany
 CFLAGS_cmdline_early.o += -D__NO_FORTIFY
 CFLAGS_lib-fdt_ro.o += -D__NO_FORTIFY
 
-GCOV_PROFILE	:= n
-KASAN_SANITIZE	:= n
-KCSAN_SANITIZE	:= n
-UBSAN_SANITIZE	:= n
-KCOV_INSTRUMENT	:= n
-
 $(obj)/%.pi.o: OBJCOPYFLAGS := --prefix-symbols=__pi_ \
 			       --remove-section=.note.gnu.property \
 			       --prefix-alloc-sections=.init.pi
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 25f0ee629971..f7ef8ad9b550 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -39,12 +39,6 @@ endif
 CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
 CFLAGS_REMOVE_hwprobe.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
 
-# Disable profiling and instrumentation for VDSO code
-GCOV_PROFILE := n
-KCOV_INSTRUMENT := n
-KASAN_SANITIZE := n
-UBSAN_SANITIZE := n
-
 # Force dependency
 $(obj)/vdso.o: $(obj)/vdso.so
 
diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index 280b0eb352b8..f11945ee2490 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-OBJECT_FILES_NON_STANDARD := y
 
 purgatory-y := purgatory.o sha256.o entry.o string.o ctype.o memcpy.o memset.o
 purgatory-y += strcmp.o strlen.o strncmp.o
@@ -47,13 +46,6 @@ LDFLAGS_purgatory.ro := -r $(PURGATORY_LDFLAGS)
 LDFLAGS_purgatory.chk := $(PURGATORY_LDFLAGS)
 targets += purgatory.ro purgatory.chk
 
-# Sanitizer, etc. runtimes are unavailable and cannot be linked here.
-GCOV_PROFILE	:= n
-KASAN_SANITIZE	:= n
-UBSAN_SANITIZE	:= n
-KCSAN_SANITIZE	:= n
-KCOV_INSTRUMENT := n
-
 # These are adjustments to the compiler flags used for objects that
 # make up the standalone purgatory.ro
 
diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
index 294f08a8811a..5a10c4fa4b24 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the linux s390-specific parts of the memory manager.
 #
 
+# These must be disabled explicitly because this Makefile uses obj-y
+# for bootloader objects.
 KCOV_INSTRUMENT := n
 GCOV_PROFILE := n
 UBSAN_SANITIZE := n
diff --git a/arch/s390/kernel/vdso32/Makefile b/arch/s390/kernel/vdso32/Makefile
index c263b91adfb1..df928fee26b5 100644
--- a/arch/s390/kernel/vdso32/Makefile
+++ b/arch/s390/kernel/vdso32/Makefile
@@ -1,8 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # List of files in the vdso
 
-KCOV_INSTRUMENT := n
-
 # Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile
 obj-vdso32 = vdso_user_wrapper-32.o note-32.o
@@ -32,12 +30,6 @@ obj-y += vdso32_wrapper.o
 targets += vdso32.lds
 CPPFLAGS_vdso32.lds += -P -C -U$(ARCH)
 
-# Disable gcov profiling, ubsan and kasan for VDSO code
-GCOV_PROFILE := n
-UBSAN_SANITIZE := n
-KASAN_SANITIZE := n
-KCSAN_SANITIZE := n
-
 # Force dependency (incbin is bad)
 $(obj)/vdso32_wrapper.o : $(obj)/vdso32.so
 
diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
index 9566bed7d5b2..6da1b9ad8ab0 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -1,8 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # List of files in the vdso
 
-KCOV_INSTRUMENT := n
-
 # Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile
 obj-vdso64 = vdso_user_wrapper.o note.o
@@ -37,12 +35,6 @@ obj-y += vdso64_wrapper.o
 targets += vdso64.lds
 CPPFLAGS_vdso64.lds += -P -C -U$(ARCH)
 
-# Disable gcov profiling, ubsan and kasan for VDSO code
-GCOV_PROFILE := n
-UBSAN_SANITIZE := n
-KASAN_SANITIZE := n
-KCSAN_SANITIZE := n
-
 # Force dependency (incbin is bad)
 $(obj)/vdso64_wrapper.o : $(obj)/vdso64.so
 
diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index 4e930f566878..24eccaa29337 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -1,7 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-OBJECT_FILES_NON_STANDARD := y
-
 purgatory-y := head.o purgatory.o string.o sha256.o mem.o
 
 targets += $(purgatory-y) purgatory.lds purgatory purgatory.chk purgatory.ro
@@ -15,12 +13,6 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
 $(obj)/mem.o: $(srctree)/arch/s390/lib/mem.S FORCE
 	$(call if_changed_rule,as_o_S)
 
-KCOV_INSTRUMENT := n
-GCOV_PROFILE := n
-UBSAN_SANITIZE := n
-KASAN_SANITIZE := n
-KCSAN_SANITIZE := n
-
 KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes
 KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
 KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
index 6c6c791a1d06..3a46b871463d 100644
--- a/arch/sh/boot/compressed/Makefile
+++ b/arch/sh/boot/compressed/Makefile
@@ -11,9 +11,6 @@ OBJECTS := head_32.o misc.o cache.o piggy.o \
 targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 \
            vmlinux.bin.lzma vmlinux.bin.xz vmlinux.bin.lzo $(OBJECTS)
 
-GCOV_PROFILE := n
-UBSAN_SANITIZE := n
-
 #
 # IMAGE_OFFSET is the load offset of the compression loader
 #
diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index 0fe134abbcf1..243dbfc4609d 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -2,7 +2,6 @@
 #
 # Building vDSO images for sparc.
 #
-UBSAN_SANITIZE := n
 
 # files to link into the vdso
 vobjs-y := vdso-note.o vclock_gettime.o
@@ -106,4 +105,3 @@ quiet_cmd_vdso = VDSO    $@
 		sh $(src)/checkundef.sh '$(OBJDUMP)' '$@'
 
 VDSO_LDFLAGS = -shared --hash-style=both --build-id=sha1 -Bsymbolic
-GCOV_PROFILE := n
diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 29cda98c65f8..1cf24ff6acac 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -9,19 +9,6 @@
 # Changed by many, many contributors over the years.
 #
 
-# Sanitizer runtimes are unavailable and cannot be linked for early boot code.
-KASAN_SANITIZE			:= n
-KCSAN_SANITIZE			:= n
-KMSAN_SANITIZE			:= n
-OBJECT_FILES_NON_STANDARD	:= y
-
-# Kernel does not boot with kcov instrumentation here.
-# One of the problems observed was insertion of __sanitizer_cov_trace_pc()
-# callback into middle of per-cpu data enabling code. Thus the callback observed
-# inconsistent state and crashed. We are interested mostly in syscall coverage,
-# so boot code is not interesting anyway.
-KCOV_INSTRUMENT		:= n
-
 # If you want to preset the SVGA mode, uncomment the next line and
 # set SVGA_MODE to whatever number you want.
 # Set it to -DSVGA_MODE=NORMAL_VGA if you just want the EGA/VGA mode.
@@ -69,8 +56,6 @@ KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP
 KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
 KBUILD_CFLAGS	+= $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
-GCOV_PROFILE := n
-UBSAN_SANITIZE := n
 
 $(obj)/bzImage: asflags-y  := $(SVGA_MODE)
 
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index e9522c6893be..243ee86cb1b1 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -17,15 +17,6 @@
 #	(see scripts/Makefile.lib size_append)
 #	compressed vmlinux.bin.all + u32 size of vmlinux.bin.all
 
-# Sanitizer runtimes are unavailable and cannot be linked for early boot code.
-KASAN_SANITIZE			:= n
-KCSAN_SANITIZE			:= n
-KMSAN_SANITIZE			:= n
-OBJECT_FILES_NON_STANDARD	:= y
-
-# Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
-KCOV_INSTRUMENT		:= n
-
 targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
 	vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4 vmlinux.bin.zst
 
@@ -59,8 +50,6 @@ KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
 CFLAGS_sev.o += -I$(objtree)/arch/x86/lib/
 
 KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
-GCOV_PROFILE := n
-UBSAN_SANITIZE :=n
 
 KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
 KBUILD_LDFLAGS += $(call ld-option,--no-ld-generated-unwind-info)
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index c003452dba8c..215a1b202a91 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -6,20 +6,6 @@
 # Include the generic Makefile to check the built vDSO:
 include $(srctree)/lib/vdso/Makefile
 
-# Sanitizer runtimes are unavailable and cannot be linked here.
-KASAN_SANITIZE			:= n
-KMSAN_SANITIZE_vclock_gettime.o := n
-KMSAN_SANITIZE_vdso32/vclock_gettime.o	:= n
-KMSAN_SANITIZE_vgetcpu.o	:= n
-KMSAN_SANITIZE_vdso32/vgetcpu.o	:= n
-
-UBSAN_SANITIZE			:= n
-KCSAN_SANITIZE			:= n
-OBJECT_FILES_NON_STANDARD	:= y
-
-# Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
-KCOV_INSTRUMENT		:= n
-
 # Files to link into the vDSO:
 vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
 vobjs32-y := vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
@@ -28,23 +14,12 @@ vobjs-$(CONFIG_X86_SGX)	+= vsgx.o
 
 # Files to link into the kernel:
 obj-y						+= vma.o extable.o
-KASAN_SANITIZE_vma.o				:= y
-UBSAN_SANITIZE_vma.o				:= y
-KCSAN_SANITIZE_vma.o				:= y
-
-OBJECT_FILES_NON_STANDARD_vma.o			:= n
-OBJECT_FILES_NON_STANDARD_extable.o		:= n
 
 # vDSO images to build:
 obj-$(CONFIG_X86_64)				+= vdso-image-64.o
 obj-$(CONFIG_X86_X32_ABI)			+= vdso-image-x32.o
 obj-$(CONFIG_COMPAT_32)				+= vdso-image-32.o vdso32-setup.o
 
-OBJECT_FILES_NON_STANDARD_vdso-image-32.o	:= n
-OBJECT_FILES_NON_STANDARD_vdso-image-x32.o	:= n
-OBJECT_FILES_NON_STANDARD_vdso-image-64.o	:= n
-OBJECT_FILES_NON_STANDARD_vdso32-setup.o	:= n
-
 vobjs := $(addprefix $(obj)/, $(vobjs-y))
 vobjs32 := $(addprefix $(obj)/, $(vobjs32-y))
 
@@ -180,7 +155,6 @@ quiet_cmd_vdso = VDSO    $@
 
 VDSO_LDFLAGS = -shared --hash-style=both --build-id=sha1 \
 	$(call ld-option, --eh-frame-hdr) -Bsymbolic -z noexecstack
-GCOV_PROFILE := n
 
 quiet_cmd_vdso_and_check = VDSO    $@
       cmd_vdso_and_check = $(cmd_vdso); $(cmd_vdso_check)
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index bc31863c5ee6..0a16f1373cf5 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-OBJECT_FILES_NON_STANDARD := y
 
 purgatory-y := purgatory.o stack.o setup-x86_$(BITS).o sha256.o entry64.o string.o
 
@@ -30,14 +29,6 @@ LDFLAGS_purgatory.ro := -r $(PURGATORY_LDFLAGS)
 LDFLAGS_purgatory.chk := $(PURGATORY_LDFLAGS)
 targets += purgatory.ro purgatory.chk
 
-# Sanitizer, etc. runtimes are unavailable and cannot be linked here.
-GCOV_PROFILE	:= n
-KASAN_SANITIZE	:= n
-UBSAN_SANITIZE	:= n
-KCSAN_SANITIZE	:= n
-KMSAN_SANITIZE	:= n
-KCOV_INSTRUMENT := n
-
 # These are adjustments to the compiler flags used for objects that
 # make up the standalone purgatory.ro
 
diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
index f614009d3e4e..a0fb39abc5c8 100644
--- a/arch/x86/realmode/rm/Makefile
+++ b/arch/x86/realmode/rm/Makefile
@@ -7,15 +7,6 @@
 #
 #
 
-# Sanitizer runtimes are unavailable and cannot be linked here.
-KASAN_SANITIZE			:= n
-KCSAN_SANITIZE			:= n
-KMSAN_SANITIZE			:= n
-OBJECT_FILES_NON_STANDARD	:= y
-
-# Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
-KCOV_INSTRUMENT		:= n
-
 always-y := realmode.bin realmode.relocs
 
 wakeup-objs	:= wakeup_asm.o wakemain.o video-mode.o
@@ -76,5 +67,3 @@ KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP -D_WAKEUP \
 		   -I$(srctree)/arch/x86/boot
 KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
-GCOV_PROFILE := n
-UBSAN_SANITIZE := n
diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 2303fa59971c..6a77ea6434ff 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -3,12 +3,6 @@
 # Building vDSO images for x86.
 #
 
-# do not instrument on vdso because KASAN is not compatible with user mode
-KASAN_SANITIZE			:= n
-
-# Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
-KCOV_INSTRUMENT                := n
-
 VDSO64-y		:= y
 
 vdso-install-$(VDSO64-y)	+= vdso.so
@@ -66,4 +60,3 @@ quiet_cmd_vdso = VDSO    $@
 		 sh $(src)/checkundef.sh '$(NM)' '$@'
 
 VDSO_LDFLAGS = -fPIC -shared -Wl,--hash-style=sysv -z noexecstack
-GCOV_PROFILE := n
diff --git a/arch/xtensa/boot/lib/Makefile b/arch/xtensa/boot/lib/Makefile
index 0378a22a08e3..39e1ef0f9d15 100644
--- a/arch/xtensa/boot/lib/Makefile
+++ b/arch/xtensa/boot/lib/Makefile
@@ -15,11 +15,6 @@ CFLAGS_REMOVE_inftrees.o = -pg
 CFLAGS_REMOVE_inffast.o = -pg
 endif
 
-KASAN_SANITIZE := n
-KCSAN_SANITIZE := n
-KCOV_INSTRUMENT := n
-GCOV_PROFILE := n
-
 CFLAGS_REMOVE_inflate.o += -fstack-protector -fstack-protector-strong
 CFLAGS_REMOVE_zmem.o += -fstack-protector -fstack-protector-strong
 CFLAGS_REMOVE_inftrees.o += -fstack-protector -fstack-protector-strong
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 31eb1e287ce1..06f0428a723c 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -56,17 +56,6 @@ KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_CFI), $(KBUILD_CFLAGS))
 # disable LTO
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
 
-GCOV_PROFILE			:= n
-# Sanitizer runtimes are unavailable and cannot be linked here.
-KASAN_SANITIZE			:= n
-KCSAN_SANITIZE			:= n
-KMSAN_SANITIZE			:= n
-UBSAN_SANITIZE			:= n
-OBJECT_FILES_NON_STANDARD	:= y
-
-# Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
-KCOV_INSTRUMENT			:= n
-
 lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
 				   file.o mem.o random.o randomalloc.o pci.o \
 				   skip_spaces.o lib-cmdline.o lib-ctype.o \
diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index 95ef971b5e1c..33fe61152a15 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -15,10 +15,6 @@ lkdtm-$(CONFIG_PPC_64S_HASH_MMU)	+= powerpc.o
 
 KASAN_SANITIZE_stackleak.o	:= n
 
-KASAN_SANITIZE_rodata.o			:= n
-KCSAN_SANITIZE_rodata.o			:= n
-KCOV_INSTRUMENT_rodata.o		:= n
-OBJECT_FILES_NON_STANDARD_rodata.o	:= y
 CFLAGS_REMOVE_rodata.o			+= $(CC_FLAGS_LTO) $(RETHUNK_CFLAGS)
 
 OBJCOPYFLAGS :=
diff --git a/init/Makefile b/init/Makefile
index 3c48d97538c1..ab71cedc5fd6 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -59,6 +59,3 @@ include/generated/utsversion.h: FORCE
 
 $(obj)/version-timestamp.o: include/generated/utsversion.h
 CFLAGS_version-timestamp.o := -include include/generated/utsversion.h
-KASAN_SANITIZE_version-timestamp.o := n
-KCSAN_SANITIZE_version-timestamp.o := n
-GCOV_PROFILE_version-timestamp.o := n
diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index c9f3e03124d7..49946cb96844 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -18,9 +18,6 @@ quiet_cmd_cc_o_c = CC      $@
 	$(call if_changed_dep,cc_o_c)
 
 ifdef CONFIG_MODULES
-KASAN_SANITIZE_.vmlinux.export.o := n
-KCSAN_SANITIZE_.vmlinux.export.o := n
-GCOV_PROFILE_.vmlinux.export.o := n
 targets += .vmlinux.export.o
 vmlinux: .vmlinux.export.o
 endif
diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
index 3c54125eb373..c729bc936bae 100644
--- a/scripts/mod/Makefile
+++ b/scripts/mod/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-OBJECT_FILES_NON_STANDARD := y
 CFLAGS_REMOVE_empty.o += $(CC_FLAGS_LTO)
 
 hostprogs-always-y	+= modpost mk_elfconfig
-- 
2.40.1


