Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2247D332A20
	for <lists+linux-arch@lfdr.de>; Tue,  9 Mar 2021 16:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhCIPSx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Mar 2021 10:18:53 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:31189 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbhCIPS1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Mar 2021 10:18:27 -0500
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 129FHiTe030658;
        Wed, 10 Mar 2021 00:17:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 129FHiTe030658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1615303067;
        bh=t1rH5CQV4/w2W/P91RtzZaEcWAJILvh5olFvUiyIaB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BCk+KmW23Gh7ruHIKtv3ocufi5qFN6fn39v5JP2L4fffRoB7BOMIKwWQfUZZmnezf
         uY+igHElwuITCS3W8lTk8Q62y6Lok77xib98JOG2toC21FB29ILb8LHhhJ+X1GihZg
         qSPa5+LoQ85Q0ZSREc54Yn6zf89pQM+cv4zkICynyoOepcc+dXESBnf/9fNLUSJOXx
         8l83byF/3fpKYmZt2bnlGn4HguP8cJqALkk2R0E70wMnQ/i7rP5PR3qNLS5QvcSqhi
         tKc5XAXwkpv6iEpEvR3ZPqrj2UTvQ8nX7OLTP7++3DJdIxNdmF66zqRduUQsfNBZSr
         OPgmbRZtXS78A==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, Nicolas Pitre <nico@fluxnic.net>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 2/4] kbuild: separate out vmlinux.lds generation
Date:   Wed, 10 Mar 2021 00:17:35 +0900
Message-Id: <20210309151737.345722-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210309151737.345722-1-masahiroy@kernel.org>
References: <20210309151737.345722-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a preparation for the CONFIG_TRIM_UNUSED_KSYMS improvement.

In the new implementation of CONFIG_TRIM_UNUSED_KSYMS (next commit),
unused export symbols will be trimmed at the link stage. Kbuild will
need to traverse the tree to know which symbols are needed by modules.

The list of sections that need linking shall be generated after the
directory traverse, and included from vmlinux.lds.S and module.lds.S.

The build rule of module.lds is already separated as modules_prepare.

The build of vmlinux.lds must be delayed because such a list is not yet
available while Kbuild is visiting arch/$(SRCARCH)/kernel/Makefile.

Separate the build rule of vmlinux.lds, and invokes it from the top
Makefile.

I guarded the $(warning ) in scripts/Makefile.build, otherwise a false-
positive warning would be displayed, for example when building ARCH=ia64
with CONFIG_IA64_PALINFO=m. Ideally, vmlinux.lds.S could be moved to a
different directory, but I am just doing less-invasive changes for now.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

 Makefile                        | 8 ++++++--
 arch/alpha/kernel/Makefile      | 3 ++-
 arch/arc/kernel/Makefile        | 3 ++-
 arch/arm/kernel/Makefile        | 3 ++-
 arch/arm64/kernel/Makefile      | 3 ++-
 arch/csky/kernel/Makefile       | 3 ++-
 arch/h8300/kernel/Makefile      | 2 +-
 arch/hexagon/kernel/Makefile    | 3 ++-
 arch/ia64/kernel/Makefile       | 3 ++-
 arch/m68k/kernel/Makefile       | 2 +-
 arch/microblaze/kernel/Makefile | 3 ++-
 arch/mips/kernel/Makefile       | 3 ++-
 arch/nds32/kernel/Makefile      | 3 ++-
 arch/nios2/kernel/Makefile      | 2 +-
 arch/openrisc/kernel/Makefile   | 3 ++-
 arch/parisc/kernel/Makefile     | 3 ++-
 arch/powerpc/kernel/Makefile    | 2 +-
 arch/riscv/kernel/Makefile      | 2 +-
 arch/s390/kernel/Makefile       | 3 ++-
 arch/sh/kernel/Makefile         | 3 ++-
 arch/sparc/kernel/Makefile      | 2 +-
 arch/um/kernel/Makefile         | 2 +-
 arch/x86/kernel/Makefile        | 2 +-
 arch/xtensa/kernel/Makefile     | 3 ++-
 scripts/Makefile.build          | 2 ++
 25 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/Makefile b/Makefile
index 31dcdb3d61fa..89862b9f45d7 100644
--- a/Makefile
+++ b/Makefile
@@ -1186,6 +1186,9 @@ quiet_cmd_autoksyms_h = GEN     $@
 $(autoksyms_h):
 	$(call cmd,autoksyms_h)
 
+$(KBUILD_LDS): prepare FORCE
+	$(Q)$(MAKE) $(build)=$(patsubst %/,%,$(dir $@)) $@
+
 ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 
 # Final link of vmlinux with optional arch pass after final link
@@ -1193,14 +1196,15 @@ cmd_link-vmlinux =                                                 \
 	$(CONFIG_SHELL) $< "$(LD)" "$(KBUILD_LDFLAGS)" "$(LDFLAGS_vmlinux)";    \
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 
-vmlinux: scripts/link-vmlinux.sh autoksyms_recursive $(vmlinux-deps) FORCE
+vmlinux: scripts/link-vmlinux.sh autoksyms_recursive $(KBUILD_LDS) \
+			$(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS) FORCE
 	+$(call if_changed,link-vmlinux)
 
 targets := vmlinux
 
 # The actual objects are generated when descending,
 # make sure no implicit rule kicks in
-$(sort $(vmlinux-deps) $(subdir-modorder)): descend ;
+$(sort $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS) $(subdir-modorder)): descend ;
 
 filechk_kernel.release = \
 	echo "$(KERNELVERSION)$$($(CONFIG_SHELL) $(srctree)/scripts/setlocalversion $(srctree))"
diff --git a/arch/alpha/kernel/Makefile b/arch/alpha/kernel/Makefile
index 5a74581bf0ee..6e2baaebdee3 100644
--- a/arch/alpha/kernel/Makefile
+++ b/arch/alpha/kernel/Makefile
@@ -3,7 +3,8 @@
 # Makefile for the linux kernel.
 #
 
-extra-y		:= head.o vmlinux.lds
+extra-y		:= head.o
+targets		+= vmlinux.lds
 asflags-y	:= $(KBUILD_CFLAGS)
 ccflags-y	:= -Wno-sign-compare
 
diff --git a/arch/arc/kernel/Makefile b/arch/arc/kernel/Makefile
index 8c4fc4b54c14..0a06c018f0cd 100644
--- a/arch/arc/kernel/Makefile
+++ b/arch/arc/kernel/Makefile
@@ -31,4 +31,5 @@ else
 obj-y += ctx_sw_asm.o
 endif
 
-extra-y := vmlinux.lds head.o
+targets += vmlinux.lds
+extra-y := head.o
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index ae295a3bcfef..7483916c034d 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -106,4 +106,5 @@ endif
 
 obj-$(CONFIG_HAVE_ARM_SMCCC)	+= smccc-call.o
 
-extra-y := $(head-y) vmlinux.lds
+extra-y := $(head-y)
+targets += vmlinux.lds
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index ed65576ce710..32e530c22cba 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -64,7 +64,8 @@ obj-$(CONFIG_COMPAT_VDSO)		+= vdso32-wrap.o
 
 obj-y					+= probes/
 head-y					:= head.o
-extra-y					+= $(head-y) vmlinux.lds
+extra-y					+= $(head-y)
+targets					+= vmlinux.lds
 
 ifeq ($(CONFIG_DEBUG_EFI),y)
 AFLAGS_head.o += -DVMLINUX_PATH="\"$(realpath $(objtree)/vmlinux)\""
diff --git a/arch/csky/kernel/Makefile b/arch/csky/kernel/Makefile
index 6c0f36010ed0..06acc85a2640 100644
--- a/arch/csky/kernel/Makefile
+++ b/arch/csky/kernel/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
-extra-y := head.o vmlinux.lds
+extra-y := head.o
+targets += vmlinux.lds
 
 obj-y += entry.o atomic.o signal.o traps.o irq.o time.o vdso.o vdso/
 obj-y += power.o syscall.o syscall_table.o setup.o
diff --git a/arch/h8300/kernel/Makefile b/arch/h8300/kernel/Makefile
index 307aa51576dd..7ef912ee576f 100644
--- a/arch/h8300/kernel/Makefile
+++ b/arch/h8300/kernel/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y := vmlinux.lds
+targets += vmlinux.lds
 
 obj-y := process.o traps.o ptrace.o \
 	 signal.o setup.o syscalls.o \
diff --git a/arch/hexagon/kernel/Makefile b/arch/hexagon/kernel/Makefile
index fae3dce32fde..9765301d2672 100644
--- a/arch/hexagon/kernel/Makefile
+++ b/arch/hexagon/kernel/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-extra-y := head.o vmlinux.lds
+extra-y := head.o
+targets += vmlinux.lds
 
 obj-$(CONFIG_SMP) += smp.o
 
diff --git a/arch/ia64/kernel/Makefile b/arch/ia64/kernel/Makefile
index 78717819131c..02575e838e7a 100644
--- a/arch/ia64/kernel/Makefile
+++ b/arch/ia64/kernel/Makefile
@@ -7,7 +7,8 @@ ifdef CONFIG_DYNAMIC_FTRACE
 CFLAGS_REMOVE_ftrace.o = -pg
 endif
 
-extra-y	:= head.o vmlinux.lds
+extra-y	:= head.o
+targets	+= vmlinux.lds
 
 obj-y := entry.o efi.o efi_stub.o gate-data.o fsys.o ia64_ksyms.o irq.o irq_ia64.o	\
 	 irq_lsapic.o ivt.o pal.o patch.o process.o ptrace.o sal.o		\
diff --git a/arch/m68k/kernel/Makefile b/arch/m68k/kernel/Makefile
index dbac7f8743fc..b054f4198e63 100644
--- a/arch/m68k/kernel/Makefile
+++ b/arch/m68k/kernel/Makefile
@@ -12,7 +12,7 @@ extra-$(CONFIG_HP300)	:= head.o
 extra-$(CONFIG_Q40)	:= head.o
 extra-$(CONFIG_SUN3X)	:= head.o
 extra-$(CONFIG_SUN3)	:= sun3-head.o
-extra-y			+= vmlinux.lds
+targets			+= vmlinux.lds
 
 obj-y	:= entry.o irq.o module.o process.o ptrace.o
 obj-y	+= setup.o signal.o sys_m68k.o syscalltable.o time.o traps.o
diff --git a/arch/microblaze/kernel/Makefile b/arch/microblaze/kernel/Makefile
index 15a20eb814ce..cdf98cbfcce9 100644
--- a/arch/microblaze/kernel/Makefile
+++ b/arch/microblaze/kernel/Makefile
@@ -12,7 +12,8 @@ CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_process.o = -pg
 endif
 
-extra-y := head.o vmlinux.lds
+extra-y := head.o
+targets += vmlinux.lds
 
 obj-y += dma.o exceptions.o \
 	hw_exception_handler.o irq.o \
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index b4a57f1de772..f2e82faa06c4 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -3,7 +3,8 @@
 # Makefile for the Linux/MIPS kernel.
 #
 
-extra-y		:= head.o vmlinux.lds
+extra-y		:= head.o
+targets		+= vmlinux.lds
 
 obj-y		+= branch.o cmpxchg.o elf.o entry.o genex.o idle.o irq.o \
 		   process.o prom.o ptrace.o reset.o setup.o signal.o \
diff --git a/arch/nds32/kernel/Makefile b/arch/nds32/kernel/Makefile
index 394df3f6442c..ec061f18f00f 100644
--- a/arch/nds32/kernel/Makefile
+++ b/arch/nds32/kernel/Makefile
@@ -19,7 +19,8 @@ obj-$(CONFIG_OF)		+= devtree.o
 obj-$(CONFIG_CACHE_L2)		+= atl2c.o
 obj-$(CONFIG_PERF_EVENTS) += perf_event_cpu.o
 obj-$(CONFIG_PM)		+= pm.o sleep.o
-extra-y := head.o vmlinux.lds
+extra-y := head.o
+targets += vmlinux.lds
 
 CFLAGS_fpu.o += -mext-fpu-sp -mext-fpu-dp
 
diff --git a/arch/nios2/kernel/Makefile b/arch/nios2/kernel/Makefile
index 0b645e1e3158..1ec4be68462e 100644
--- a/arch/nios2/kernel/Makefile
+++ b/arch/nios2/kernel/Makefile
@@ -4,7 +4,7 @@
 #
 
 extra-y	+= head.o
-extra-y	+= vmlinux.lds
+targets	+= vmlinux.lds
 
 obj-y	+= cpuinfo.o
 obj-y	+= entry.o
diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makefile
index 2d172e79f58d..6be5c65ea3e9 100644
--- a/arch/openrisc/kernel/Makefile
+++ b/arch/openrisc/kernel/Makefile
@@ -3,7 +3,8 @@
 # Makefile for the linux kernel.
 #
 
-extra-y	:= head.o vmlinux.lds
+extra-y	:= head.o
+targets	+= vmlinux.lds
 
 obj-y	:= setup.o or32_ksyms.o process.o dma.o \
 	   traps.o time.o irq.o entry.o ptrace.o signal.o \
diff --git a/arch/parisc/kernel/Makefile b/arch/parisc/kernel/Makefile
index 068d90950d93..31e5109251aa 100644
--- a/arch/parisc/kernel/Makefile
+++ b/arch/parisc/kernel/Makefile
@@ -3,7 +3,8 @@
 # Makefile for arch/parisc/kernel
 #
 
-extra-y			:= head.o vmlinux.lds
+extra-y		:= head.o
+targets		+= vmlinux.lds
 
 obj-y	     	:= cache.o pacache.o setup.o pdt.o traps.o time.o irq.o \
 		   pa7300lc.o syscall.o entry.o sys_parisc.o firmware.o \
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 6084fa499aa3..c7576957f05a 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -101,7 +101,7 @@ extra-$(CONFIG_40x)		:= head_40x.o
 extra-$(CONFIG_44x)		:= head_44x.o
 extra-$(CONFIG_FSL_BOOKE)	:= head_fsl_booke.o
 extra-$(CONFIG_PPC_8xx)		:= head_8xx.o
-extra-y				+= vmlinux.lds
+targets				+= vmlinux.lds
 
 obj-$(CONFIG_RELOCATABLE)	+= reloc_$(BITS).o
 
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 3dc0abde988a..c74c495d4f56 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -10,7 +10,7 @@ CFLAGS_REMOVE_sbi.o	= $(CC_FLAGS_FTRACE)
 endif
 
 extra-y += head.o
-extra-y += vmlinux.lds
+targets += vmlinux.lds
 
 obj-y	+= soc.o
 obj-y	+= cpu.o
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index c97818a382f3..15d3ee771f22 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -42,7 +42,8 @@ obj-y	+= entry.o reipl.o relocate_kernel.o kdebugfs.o alternative.o
 obj-y	+= nospec-branch.o ipl_vmparm.o machine_kexec_reloc.o unwind_bc.o
 obj-y	+= smp.o
 
-extra-y				+= head64.o vmlinux.lds
+extra-y				+= head64.o
+targets				+= vmlinux.lds
 
 obj-$(CONFIG_SYSFS)		+= nospec-sysfs.o
 CFLAGS_REMOVE_nospec-branch.o	+= $(CC_FLAGS_EXPOLINE)
diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
index aa0fbc9202b1..e8384889f5f0 100644
--- a/arch/sh/kernel/Makefile
+++ b/arch/sh/kernel/Makefile
@@ -3,7 +3,8 @@
 # Makefile for the Linux/SuperH kernel.
 #
 
-extra-y	:= head_32.o vmlinux.lds
+extra-y	:= head_32.o
+targets	+= vmlinux.lds
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not profile debug and lowlevel utilities
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index d3a0e072ebe8..685669edb9f8 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -12,7 +12,7 @@ extra-y     := head_$(BITS).o
 # Undefine sparc when processing vmlinux.lds - it is used
 # And teach CPP we are doing $(BITS) builds (for this case)
 CPPFLAGS_vmlinux.lds := -Usparc -m$(BITS)
-extra-y              += vmlinux.lds
+targets              += vmlinux.lds
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not profile debug and lowlevel utilities
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 5aa882011e04..76eea4cc00f0 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -12,7 +12,7 @@ CPPFLAGS_vmlinux.lds := -DSTART=$(LDS_START)		\
                         -DELF_ARCH=$(LDS_ELF_ARCH)	\
                         -DELF_FORMAT=$(LDS_ELF_FORMAT)	\
 			$(LDS_EXTRA)
-extra-y := vmlinux.lds
+targets += vmlinux.lds
 
 obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
 	physmem.o process.o ptrace.o reboot.o sigio.o \
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 2ddf08351f0b..7d6fce044f97 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -7,7 +7,7 @@ extra-y	:= head_$(BITS).o
 extra-y	+= head$(BITS).o
 extra-y	+= ebda.o
 extra-y	+= platform-quirks.o
-extra-y	+= vmlinux.lds
+targets	+= vmlinux.lds
 
 CPPFLAGS_vmlinux.lds += -U$(UTS_MACHINE)
 
diff --git a/arch/xtensa/kernel/Makefile b/arch/xtensa/kernel/Makefile
index d4082c6a121b..79be7bfdf989 100644
--- a/arch/xtensa/kernel/Makefile
+++ b/arch/xtensa/kernel/Makefile
@@ -3,7 +3,8 @@
 # Makefile for the Linux/Xtensa kernel.
 #
 
-extra-y := head.o vmlinux.lds
+extra-y := head.o
+targets += vmlinux.lds
 
 obj-y := align.o coprocessor.o entry.o irq.o platform.o process.o \
 	 ptrace.o setup.o signal.o stacktrace.o syscall.o time.o traps.o \
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 1b6094a13034..7df96bfe694e 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -62,12 +62,14 @@ ifndef obj
 $(warning kbuild: Makefile.build is included improperly)
 endif
 
+ifeq ($(filter-out %.mod, $(MAKECMDGOALS)),)
 ifeq ($(need-modorder),)
 ifneq ($(obj-m),)
 $(warning $(patsubst %.o,'%.ko',$(obj-m)) will not be built even though obj-m is specified.)
 $(warning You cannot use subdir-y/m to visit a module Makefile. Use obj-y/m instead.)
 endif
 endif
+endif
 
 # ===========================================================================
 
-- 
2.27.0

