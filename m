Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9505ADF87
	for <lists+linux-arch@lfdr.de>; Tue,  6 Sep 2022 08:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238450AbiIFGOT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Sep 2022 02:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbiIFGOM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Sep 2022 02:14:12 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5E36F567;
        Mon,  5 Sep 2022 23:14:07 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 2866DVID023845;
        Tue, 6 Sep 2022 15:13:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 2866DVID023845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662444815;
        bh=dVD8i2huG3IfH6xwP49FjtQmXdc+r1W96ITL/lfQIRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FEWgngLkDXMJuXf0Ewa6voM91+P8ZIFTWvGYTcDhJYgq9PtNcJifZTuSlGHjBVcNA
         olxZ8yri1DlQjaq07a0ZaMZOKJmAN8v2K/zjyekONtaCSRvv8Xh25L3jEvk86Ke/Re
         B+pusoqjhVpRfJK2ePDoTico4JQQ3dXp4fBFwhSdh/7Ni9ejrwBEkwm/xZNJLyD+1m
         p5M5DB5nF07WnPTPMOdbBAj8799O6oNj53ucMKAy9UDwr8VORlkBR28wox+LM3mDqa
         zJjXFvCKzSZ+7AYQw8u3R2zEIeCl6Tkt8HGNWkL4PvoV+wFude9MpouK020BOTnmBV
         f9OWPcJwRsFKg==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 7/8] kbuild: use obj-y instead extra-y for objects placed at the head
Date:   Tue,  6 Sep 2022 15:13:12 +0900
Message-Id: <20220906061313.1445810-8-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906061313.1445810-1-masahiroy@kernel.org>
References: <20220906061313.1445810-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The objects placed at the head of vmlinux need special treatments:

 - arch/$(SRCARCH)/Makefile adds them to head-y in order to place
   them before other archives in the linker command line.

 - arch/$(SRCARCH)/kernel/Makefile adds them to extra-y instead of
   obj-y to avoid them going into built-in.a.

This commit gets rid of the latter.

Create vmlinux.a to collect all the objects that are unconditionally
linked to vmlinux. The objects listed in head-y are moved to the head
of vmlinux.a by using 'ar m'.

With this, arch/$(SRCARCH)/kernel/Makefile can consistently use obj-y
for builtin objects.

There is no *.o that is directly linked to vmlinux. Drop unneeded code
in scripts/clang-tools/gen_compile_commands.py.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

 Documentation/kbuild/makefiles.rst          | 18 +----------------
 Makefile                                    | 18 +++++++++++++----
 arch/alpha/kernel/Makefile                  |  4 ++--
 arch/arc/kernel/Makefile                    |  4 ++--
 arch/arm/kernel/Makefile                    |  4 ++--
 arch/arm64/kernel/Makefile                  |  4 ++--
 arch/csky/kernel/Makefile                   |  4 ++--
 arch/hexagon/kernel/Makefile                |  3 ++-
 arch/ia64/kernel/Makefile                   |  4 ++--
 arch/loongarch/kernel/Makefile              |  4 ++--
 arch/m68k/68000/Makefile                    |  2 +-
 arch/m68k/coldfire/Makefile                 |  2 +-
 arch/m68k/kernel/Makefile                   | 21 ++++++++++----------
 arch/microblaze/kernel/Makefile             |  4 ++--
 arch/mips/kernel/Makefile                   |  4 ++--
 arch/nios2/kernel/Makefile                  |  2 +-
 arch/openrisc/kernel/Makefile               |  4 ++--
 arch/parisc/kernel/Makefile                 |  4 ++--
 arch/powerpc/kernel/Makefile                | 22 ++++++++++-----------
 arch/riscv/kernel/Makefile                  |  2 +-
 arch/s390/kernel/Makefile                   |  4 ++--
 arch/sh/kernel/Makefile                     |  4 ++--
 arch/sparc/kernel/Makefile                  |  3 +--
 arch/x86/kernel/Makefile                    | 10 +++++-----
 arch/xtensa/kernel/Makefile                 |  4 ++--
 scripts/Makefile.modpost                    |  5 ++---
 scripts/Makefile.vmlinux_o                  |  6 +++---
 scripts/clang-tools/gen_compile_commands.py | 19 +-----------------
 scripts/link-vmlinux.sh                     | 10 ++++------
 29 files changed, 87 insertions(+), 112 deletions(-)

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 11a296e52d68..07c7e5a843c1 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -340,19 +340,7 @@ more details, with real examples.
 
 	Examples are:
 
-	1) head objects
-
-	    Some objects must be placed at the head of vmlinux. They are
-	    directly linked to vmlinux without going through built-in.a
-	    A typical use-case is an object that contains the entry point.
-
-	    arch/$(SRCARCH)/Makefile should specify such objects as head-y.
-
-	    Discussion:
-	      Given that we can control the section order in the linker script,
-	      why do we need head-y?
-
-	2) vmlinux linker script
+	1) vmlinux linker script
 
 	    The linker script for vmlinux is located at
 	    arch/$(SRCARCH)/kernel/vmlinux.lds
@@ -360,10 +348,6 @@ more details, with real examples.
 	Example::
 
 		# arch/x86/kernel/Makefile
-		extra-y	:= head_$(BITS).o
-		extra-y	+= head$(BITS).o
-		extra-y	+= ebda.o
-		extra-y	+= platform-quirks.o
 		extra-y	+= vmlinux.lds
 
 	$(extra-y) should only contain targets needed for vmlinux.
diff --git a/Makefile b/Makefile
index f9ee16bd212d..f2d06aaaefd3 100644
--- a/Makefile
+++ b/Makefile
@@ -1113,7 +1113,7 @@ clean-dirs	:= $(vmlinux-alldirs)
 export ARCH_CORE	:= $(core-y)
 export ARCH_DRIVERS	:= $(drivers-y)
 # Externally visible symbols (used by link-vmlinux.sh)
-KBUILD_VMLINUX_OBJS := $(head-y) ./built-in.a
+KBUILD_VMLINUX_OBJS := ./built-in.a
 KBUILD_VMLINUX_OBJS += $(addsuffix built-in.a, $(filter %/, $(libs-y)))
 ifdef CONFIG_MODULES
 KBUILD_VMLINUX_OBJS += $(patsubst %/, %/lib.a, $(filter %/, $(libs-y)))
@@ -1122,7 +1122,7 @@ else
 KBUILD_VMLINUX_LIBS := $(patsubst %/,%/lib.a, $(libs-y))
 endif
 
-export KBUILD_VMLINUX_OBJS KBUILD_VMLINUX_LIBS
+export KBUILD_VMLINUX_LIBS
 export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
 # used by scripts/Makefile.package
 export KBUILD_ALLDIRS := $(sort $(filter-out arch/%,$(vmlinux-alldirs)) LICENSES arch include scripts tools)
@@ -1151,8 +1151,18 @@ quiet_cmd_autoksyms_h = GEN     $@
 $(autoksyms_h):
 	$(call cmd,autoksyms_h)
 
+quiet_cmd_ar_vmlinux.a = AR      $@
+      cmd_ar_vmlinux.a = \
+	rm -f $@; \
+	$(AR) cDPrST $@ $(KBUILD_VMLINUX_OBJS); \
+	$(AR) mPi $$($(AR) t $@ | head -n1) $@ $(head-y)
+
+targets += vmlinux.a
+vmlinux.a: $(KBUILD_VMLINUX_OBJS) FORCE
+	$(call if_changed,ar_vmlinux.a)
+
 targets += vmlinux.o
-vmlinux.o: autoksyms_recursive $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS) FORCE
+vmlinux.o: autoksyms_recursive vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux_o
 
 ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
@@ -1909,7 +1919,7 @@ quiet_cmd_gen_compile_commands = GEN     $@
       cmd_gen_compile_commands = $(PYTHON3) $< -a $(AR) -o $@ $(filter-out $<, $(real-prereqs))
 
 $(extmod_prefix)compile_commands.json: scripts/clang-tools/gen_compile_commands.py \
-	$(if $(KBUILD_EXTMOD),,$(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS)) \
+	$(if $(KBUILD_EXTMOD),, vmlinux.a $(KBUILD_VMLINUX_LIBS)) \
 	$(if $(CONFIG_MODULES), $(MODORDER)) FORCE
 	$(call if_changed,gen_compile_commands)
 
diff --git a/arch/alpha/kernel/Makefile b/arch/alpha/kernel/Makefile
index 5a74581bf0ee..5a5b0a8b7c6a 100644
--- a/arch/alpha/kernel/Makefile
+++ b/arch/alpha/kernel/Makefile
@@ -3,11 +3,11 @@
 # Makefile for the linux kernel.
 #
 
-extra-y		:= head.o vmlinux.lds
+extra-y		:= vmlinux.lds
 asflags-y	:= $(KBUILD_CFLAGS)
 ccflags-y	:= -Wno-sign-compare
 
-obj-y    := entry.o traps.o process.o osf_sys.o irq.o \
+obj-y    := head.o entry.o traps.o process.o osf_sys.o irq.o \
 	    irq_alpha.o signal.o setup.o ptrace.o time.o \
 	    systbls.o err_common.o io.o bugs.o
 
diff --git a/arch/arc/kernel/Makefile b/arch/arc/kernel/Makefile
index 8c4fc4b54c14..0723d888ac44 100644
--- a/arch/arc/kernel/Makefile
+++ b/arch/arc/kernel/Makefile
@@ -3,7 +3,7 @@
 # Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
 #
 
-obj-y	:= arcksyms.o setup.o irq.o reset.o ptrace.o process.o devtree.o
+obj-y	:= head.o arcksyms.o setup.o irq.o reset.o ptrace.o process.o devtree.o
 obj-y	+= signal.o traps.o sys.o troubleshoot.o stacktrace.o disasm.o
 obj-$(CONFIG_ISA_ARCOMPACT)		+= entry-compact.o intc-compact.o
 obj-$(CONFIG_ISA_ARCV2)			+= entry-arcv2.o intc-arcv2.o
@@ -31,4 +31,4 @@ else
 obj-y += ctx_sw_asm.o
 endif
 
-extra-y := vmlinux.lds head.o
+extra-y := vmlinux.lds
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 553866751e1a..8feaa3217ec5 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -89,7 +89,7 @@ obj-$(CONFIG_VDSO)		+= vdso.o
 obj-$(CONFIG_EFI)		+= efi.o
 obj-$(CONFIG_PARAVIRT)	+= paravirt.o
 
-head-y			:= head$(MMUEXT).o
+obj-y			+= head$(MMUEXT).o
 obj-$(CONFIG_DEBUG_LL)	+= debug.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_ARM_PATCH_PHYS_VIRT)	+= phys2virt.o
@@ -109,4 +109,4 @@ obj-$(CONFIG_HAVE_ARM_SMCCC)	+= smccc-call.o
 
 obj-$(CONFIG_GENERIC_CPU_VULNERABILITIES) += spectre.o
 
-extra-y := $(head-y) vmlinux.lds
+extra-y := vmlinux.lds
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 1add7b01efa7..b619ff207a57 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -85,8 +85,8 @@ $(obj)/vdso-wrap.o: $(obj)/vdso/vdso.so
 $(obj)/vdso32-wrap.o: $(obj)/vdso32/vdso.so
 
 obj-y					+= probes/
-head-y					:= head.o
-extra-y					+= $(head-y) vmlinux.lds
+obj-y					+= head.o
+extra-y					+= vmlinux.lds
 
 ifeq ($(CONFIG_DEBUG_EFI),y)
 AFLAGS_head.o += -DVMLINUX_PATH="\"$(realpath $(objtree)/vmlinux)\""
diff --git a/arch/csky/kernel/Makefile b/arch/csky/kernel/Makefile
index 6f14c924b20d..8a868316b912 100644
--- a/arch/csky/kernel/Makefile
+++ b/arch/csky/kernel/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
-extra-y := head.o vmlinux.lds
+extra-y := vmlinux.lds
 
-obj-y += entry.o atomic.o signal.o traps.o irq.o time.o vdso.o vdso/
+obj-y += head.o entry.o atomic.o signal.o traps.o irq.o time.o vdso.o vdso/
 obj-y += power.o syscall.o syscall_table.o setup.o io.o
 obj-y += process.o cpu-probe.o ptrace.o stacktrace.o
 obj-y += probes/
diff --git a/arch/hexagon/kernel/Makefile b/arch/hexagon/kernel/Makefile
index fae3dce32fde..e73cb321630e 100644
--- a/arch/hexagon/kernel/Makefile
+++ b/arch/hexagon/kernel/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
-extra-y := head.o vmlinux.lds
+extra-y := vmlinux.lds
 
+obj-y += head.o
 obj-$(CONFIG_SMP) += smp.o
 
 obj-y += setup.o irq_cpu.o traps.o syscalltab.o signal.o time.o
diff --git a/arch/ia64/kernel/Makefile b/arch/ia64/kernel/Makefile
index 08d4a2ba0652..4a1fcb121dda 100644
--- a/arch/ia64/kernel/Makefile
+++ b/arch/ia64/kernel/Makefile
@@ -7,9 +7,9 @@ ifdef CONFIG_DYNAMIC_FTRACE
 CFLAGS_REMOVE_ftrace.o = -pg
 endif
 
-extra-y	:= head.o vmlinux.lds
+extra-y	:= vmlinux.lds
 
-obj-y := entry.o efi.o efi_stub.o gate-data.o fsys.o irq.o irq_ia64.o	\
+obj-y := head.o entry.o efi.o efi_stub.o gate-data.o fsys.o irq.o irq_ia64.o	\
 	 irq_lsapic.o ivt.o pal.o patch.o process.o ptrace.o sal.o		\
 	 salinfo.o setup.o signal.o sys_ia64.o time.o traps.o unaligned.o \
 	 unwind.o mca.o mca_asm.o topology.o dma-mapping.o iosapic.o acpi.o \
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index e5be17009fe8..6c33b5c45573 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -3,9 +3,9 @@
 # Makefile for the Linux/LoongArch kernel.
 #
 
-extra-y		:= head.o vmlinux.lds
+extra-y		:= vmlinux.lds
 
-obj-y		+= cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
+obj-y		+= head.o cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
 		   traps.o irq.o idle.o process.o dma.o mem.o io.o reset.o switch.o \
 		   elf.o syscall.o signal.o time.o topology.o inst.o ptrace.o vdso.o
 
diff --git a/arch/m68k/68000/Makefile b/arch/m68k/68000/Makefile
index 674541fdf5b8..279560add577 100644
--- a/arch/m68k/68000/Makefile
+++ b/arch/m68k/68000/Makefile
@@ -17,4 +17,4 @@ obj-$(CONFIG_DRAGEN2)	+= dragen2.o
 obj-$(CONFIG_UCSIMM)	+= ucsimm.o
 obj-$(CONFIG_UCDIMM)	+= ucsimm.o
 
-extra-y 		:= head.o
+obj-y			+= head.o
diff --git a/arch/m68k/coldfire/Makefile b/arch/m68k/coldfire/Makefile
index 9419a6c1f036..c56bc0dc7f2e 100644
--- a/arch/m68k/coldfire/Makefile
+++ b/arch/m68k/coldfire/Makefile
@@ -45,4 +45,4 @@ obj-$(CONFIG_STMARK2)	+= stmark2.o
 obj-$(CONFIG_PCI)	+= pci.o
 
 obj-y			+= gpio.o
-extra-y := head.o
+obj-y			+= head.o
diff --git a/arch/m68k/kernel/Makefile b/arch/m68k/kernel/Makefile
index c0833da6a2ca..1755e6cd309f 100644
--- a/arch/m68k/kernel/Makefile
+++ b/arch/m68k/kernel/Makefile
@@ -3,18 +3,19 @@
 # Makefile for the linux kernel.
 #
 
-extra-$(CONFIG_AMIGA)	:= head.o
-extra-$(CONFIG_ATARI)	:= head.o
-extra-$(CONFIG_MAC)	:= head.o
-extra-$(CONFIG_APOLLO)	:= head.o
-extra-$(CONFIG_VME)	:= head.o
-extra-$(CONFIG_HP300)	:= head.o
-extra-$(CONFIG_Q40)	:= head.o
-extra-$(CONFIG_SUN3X)	:= head.o
-extra-$(CONFIG_VIRT)	:= head.o
-extra-$(CONFIG_SUN3)	:= sun3-head.o
 extra-y			+= vmlinux.lds
 
+obj-$(CONFIG_AMIGA)	:= head.o
+obj-$(CONFIG_ATARI)	:= head.o
+obj-$(CONFIG_MAC)	:= head.o
+obj-$(CONFIG_APOLLO)	:= head.o
+obj-$(CONFIG_VME)	:= head.o
+obj-$(CONFIG_HP300)	:= head.o
+obj-$(CONFIG_Q40)	:= head.o
+obj-$(CONFIG_SUN3X)	:= head.o
+obj-$(CONFIG_VIRT)	:= head.o
+obj-$(CONFIG_SUN3)	:= sun3-head.o
+
 obj-y	:= entry.o irq.o module.o process.o ptrace.o
 obj-y	+= setup.o signal.o sys_m68k.o syscalltable.o time.o traps.o
 
diff --git a/arch/microblaze/kernel/Makefile b/arch/microblaze/kernel/Makefile
index 15a20eb814ce..4393bee64eaf 100644
--- a/arch/microblaze/kernel/Makefile
+++ b/arch/microblaze/kernel/Makefile
@@ -12,9 +12,9 @@ CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_process.o = -pg
 endif
 
-extra-y := head.o vmlinux.lds
+extra-y := vmlinux.lds
 
-obj-y += dma.o exceptions.o \
+obj-y += head.o dma.o exceptions.o \
 	hw_exception_handler.o irq.o \
 	process.o prom.o ptrace.o \
 	reset.o setup.o signal.o sys_microblaze.o timer.o traps.o unwind.o
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 7c96282bff2e..5d1addac5e28 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -3,9 +3,9 @@
 # Makefile for the Linux/MIPS kernel.
 #
 
-extra-y		:= head.o vmlinux.lds
+extra-y		:= vmlinux.lds
 
-obj-y		+= branch.o cmpxchg.o elf.o entry.o genex.o idle.o irq.o \
+obj-y		+= head.o branch.o cmpxchg.o elf.o entry.o genex.o idle.o irq.o \
 		   process.o prom.o ptrace.o reset.o setup.o signal.o \
 		   syscall.o time.o topology.o traps.o unaligned.o watch.o \
 		   vdso.o cacheinfo.o
diff --git a/arch/nios2/kernel/Makefile b/arch/nios2/kernel/Makefile
index 0b645e1e3158..78a913181fa1 100644
--- a/arch/nios2/kernel/Makefile
+++ b/arch/nios2/kernel/Makefile
@@ -3,9 +3,9 @@
 # Makefile for the nios2 linux kernel.
 #
 
-extra-y	+= head.o
 extra-y	+= vmlinux.lds
 
+obj-y	+= head.o
 obj-y	+= cpuinfo.o
 obj-y	+= entry.o
 obj-y	+= insnemu.o
diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makefile
index 2d172e79f58d..79129161f3e0 100644
--- a/arch/openrisc/kernel/Makefile
+++ b/arch/openrisc/kernel/Makefile
@@ -3,9 +3,9 @@
 # Makefile for the linux kernel.
 #
 
-extra-y	:= head.o vmlinux.lds
+extra-y	:= vmlinux.lds
 
-obj-y	:= setup.o or32_ksyms.o process.o dma.o \
+obj-y	:= head.o setup.o or32_ksyms.o process.o dma.o \
 	   traps.o time.o irq.o entry.o ptrace.o signal.o \
 	   sys_call_table.o unwinder.o
 
diff --git a/arch/parisc/kernel/Makefile b/arch/parisc/kernel/Makefile
index d0bfac89a842..3d138c9cf9ce 100644
--- a/arch/parisc/kernel/Makefile
+++ b/arch/parisc/kernel/Makefile
@@ -3,9 +3,9 @@
 # Makefile for arch/parisc/kernel
 #
 
-extra-y			:= head.o vmlinux.lds
+extra-y		:= vmlinux.lds
 
-obj-y	     	:= cache.o pacache.o setup.o pdt.o traps.o time.o irq.o \
+obj-y		:= head.o cache.o pacache.o setup.o pdt.o traps.o time.o irq.o \
 		   pa7300lc.o syscall.o entry.o sys_parisc.o firmware.o \
 		   ptrace.o hardware.o inventory.o drivers.o alternative.o \
 		   signal.o hpmc.o real2.o parisc_ksyms.o unaligned.o \
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 06d2d1f78f71..f264d9b2cb63 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -118,12 +118,12 @@ obj-$(CONFIG_PPC_FSL_BOOK3E)	+= cpu_setup_fsl_booke.o
 obj-$(CONFIG_PPC_DOORBELL)	+= dbell.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 
-extra-$(CONFIG_PPC64)		:= head_64.o
-extra-$(CONFIG_PPC_BOOK3S_32)	:= head_book3s_32.o
-extra-$(CONFIG_40x)		:= head_40x.o
-extra-$(CONFIG_44x)		:= head_44x.o
-extra-$(CONFIG_FSL_BOOKE)	:= head_fsl_booke.o
-extra-$(CONFIG_PPC_8xx)		:= head_8xx.o
+obj-$(CONFIG_PPC64)		+= head_64.o
+obj-$(CONFIG_PPC_BOOK3S_32)	+= head_book3s_32.o
+obj-$(CONFIG_40x)		+= head_40x.o
+obj-$(CONFIG_44x)		+= head_44x.o
+obj-$(CONFIG_FSL_BOOKE)		+= head_fsl_booke.o
+obj-$(CONFIG_PPC_8xx)		+= head_8xx.o
 extra-y				+= vmlinux.lds
 
 obj-$(CONFIG_RELOCATABLE)	+= reloc_$(BITS).o
@@ -198,12 +198,12 @@ KCOV_INSTRUMENT_paca.o := n
 CFLAGS_setup_64.o		+= -fno-stack-protector
 CFLAGS_paca.o			+= -fno-stack-protector
 
-extra-$(CONFIG_PPC_FPU)		+= fpu.o
-extra-$(CONFIG_ALTIVEC)		+= vector.o
-extra-$(CONFIG_PPC64)		+= entry_64.o
-extra-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE)	+= prom_init.o
+obj-$(CONFIG_PPC_FPU)		+= fpu.o
+obj-$(CONFIG_ALTIVEC)		+= vector.o
+obj-$(CONFIG_PPC64)		+= entry_64.o
+obj-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE)	+= prom_init.o
 
-extra-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE)	+= prom_init_check
+obj-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE)	+= prom_init_check
 
 quiet_cmd_prom_init_check = PROMCHK $@
       cmd_prom_init_check = $(CONFIG_SHELL) $< "$(NM)" $(obj)/prom_init.o; touch $@
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 33bb60a354cd..db6e4b1294ba 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -28,9 +28,9 @@ KASAN_SANITIZE_cpufeature.o := n
 endif
 endif
 
-extra-y += head.o
 extra-y += vmlinux.lds
 
+obj-y	+= head.o
 obj-y	+= soc.o
 obj-$(CONFIG_RISCV_ALTERNATIVE) += alternative.o
 obj-y	+= cpu.o
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 3cbfa9fddd9a..7ce00816b8df 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -33,7 +33,7 @@ CFLAGS_stacktrace.o	+= -fno-optimize-sibling-calls
 CFLAGS_dumpstack.o	+= -fno-optimize-sibling-calls
 CFLAGS_unwind_bc.o	+= -fno-optimize-sibling-calls
 
-obj-y	:= traps.o time.o process.o earlypgm.o early.o setup.o idle.o vtime.o
+obj-y	:= head64.o traps.o time.o process.o earlypgm.o early.o setup.o idle.o vtime.o
 obj-y	+= processor.o syscall.o ptrace.o signal.o cpcmd.o ebcdic.o nmi.o
 obj-y	+= debug.o irq.o ipl.o dis.o diag.o vdso.o cpufeature.o
 obj-y	+= sysinfo.o lgr.o os_info.o machine_kexec.o
@@ -42,7 +42,7 @@ obj-y	+= entry.o reipl.o relocate_kernel.o kdebugfs.o alternative.o
 obj-y	+= nospec-branch.o ipl_vmparm.o machine_kexec_reloc.o unwind_bc.o
 obj-y	+= smp.o text_amode31.o stacktrace.o
 
-extra-y				+= head64.o vmlinux.lds
+extra-y				+= vmlinux.lds
 
 obj-$(CONFIG_SYSFS)		+= nospec-sysfs.o
 CFLAGS_REMOVE_nospec-branch.o	+= $(CC_FLAGS_EXPOLINE)
diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
index aa0fbc9202b1..69cd9ac4b2ab 100644
--- a/arch/sh/kernel/Makefile
+++ b/arch/sh/kernel/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the Linux/SuperH kernel.
 #
 
-extra-y	:= head_32.o vmlinux.lds
+extra-y	:= vmlinux.lds
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not profile debug and lowlevel utilities
@@ -12,7 +12,7 @@ endif
 
 CFLAGS_REMOVE_return_address.o = -pg
 
-obj-y	:= debugtraps.o dumpstack.o 		\
+obj-y	:= head_32.o debugtraps.o dumpstack.o				\
 	   idle.o io.o irq.o irq_32.o kdebugfs.o			\
 	   machvec.o nmi_debug.o process.o				\
 	   process_32.o ptrace.o ptrace_32.o				\
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index d3a0e072ebe8..b328e4a0bd57 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -7,8 +7,6 @@
 asflags-y := -ansi
 ccflags-y := -Werror
 
-extra-y     := head_$(BITS).o
-
 # Undefine sparc when processing vmlinux.lds - it is used
 # And teach CPP we are doing $(BITS) builds (for this case)
 CPPFLAGS_vmlinux.lds := -Usparc -m$(BITS)
@@ -22,6 +20,7 @@ CFLAGS_REMOVE_perf_event.o := -pg
 CFLAGS_REMOVE_pcr.o := -pg
 endif
 
+obj-y                   := head_$(BITS).o
 obj-$(CONFIG_SPARC64)   += urtt_fill.o
 obj-$(CONFIG_SPARC32)   += entry.o wof.o wuf.o
 obj-$(CONFIG_SPARC32)   += etrap_32.o
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index a20a5ebfacd7..956e50ca06e0 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -3,10 +3,6 @@
 # Makefile for the linux kernel.
 #
 
-extra-y	:= head_$(BITS).o
-extra-y	+= head$(BITS).o
-extra-y	+= ebda.o
-extra-y	+= platform-quirks.o
 extra-y	+= vmlinux.lds
 
 CPPFLAGS_vmlinux.lds += -U$(UTS_MACHINE)
@@ -42,7 +38,11 @@ KCOV_INSTRUMENT		:= n
 
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
-obj-y			:= process_$(BITS).o signal.o
+obj-y			+= head_$(BITS).o
+obj-y			+= head$(BITS).o
+obj-y			+= ebda.o
+obj-y			+= platform-quirks.o
+obj-y			+= process_$(BITS).o signal.o
 obj-$(CONFIG_COMPAT)	+= signal_compat.o
 obj-y			+= traps.o idt.o irq.o irq_$(BITS).o dumpstack_$(BITS).o
 obj-y			+= time.o ioport.o dumpstack.o nmi.o
diff --git a/arch/xtensa/kernel/Makefile b/arch/xtensa/kernel/Makefile
index 897c1c741058..f28b8e3d717e 100644
--- a/arch/xtensa/kernel/Makefile
+++ b/arch/xtensa/kernel/Makefile
@@ -3,9 +3,9 @@
 # Makefile for the Linux/Xtensa kernel.
 #
 
-extra-y := head.o vmlinux.lds
+extra-y := vmlinux.lds
 
-obj-y := align.o coprocessor.o entry.o irq.o platform.o process.o \
+obj-y := head.o align.o coprocessor.o entry.o irq.o platform.o process.o \
 	 ptrace.o setup.o signal.o stacktrace.o syscall.o time.o traps.o \
 	 vectors.o
 
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index d7d3138c5ecc..4f74370ad1ee 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -70,13 +70,12 @@ quiet_cmd_vmlinux_objs = GEN     $@
 	for f in $(real-prereqs); do	\
 		case $${f} in		\
 		*libgcc.a) ;;		\
-		*.a) $(AR) t $${f} ;;	\
-		*) echo $${f} ;;	\
+		*) $(AR) t $${f} ;;	\
 		esac			\
 	done > $@
 
 targets += .vmlinux.objs
-.vmlinux.objs: $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS) FORCE
+.vmlinux.objs: vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
 	$(call if_changed,vmlinux_objs)
 
 vmlinux.o-if-present := $(wildcard vmlinux.o)
diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 84019814f33f..81a4e0484457 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -18,7 +18,7 @@ quiet_cmd_gen_initcalls_lds = GEN     $@
 	$(PERL) $(real-prereqs) > $@
 
 .tmp_initcalls.lds: $(srctree)/scripts/generate_initcall_order.pl \
-		$(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS) FORCE
+		vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
 	$(call if_changed,gen_initcalls_lds)
 
 targets := .tmp_initcalls.lds
@@ -55,7 +55,7 @@ quiet_cmd_ld_vmlinux.o = LD      $@
       cmd_ld_vmlinux.o = \
 	$(LD) ${KBUILD_LDFLAGS} -r -o $@ \
 	$(addprefix -T , $(initcalls-lds)) \
-	--whole-archive $(KBUILD_VMLINUX_OBJS) --no-whole-archive \
+	--whole-archive vmlinux.a --no-whole-archive \
 	--start-group $(KBUILD_VMLINUX_LIBS) --end-group \
 	$(cmd_objtool)
 
@@ -64,7 +64,7 @@ define rule_ld_vmlinux.o
 	$(call cmd,gen_objtooldep)
 endef
 
-vmlinux.o: $(initcalls-lds) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS) FORCE
+vmlinux.o: $(initcalls-lds) vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
 	$(call if_changed_rule,ld_vmlinux.o)
 
 targets += vmlinux.o
diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
index 47da25b3ba7d..d800b2c0af97 100755
--- a/scripts/clang-tools/gen_compile_commands.py
+++ b/scripts/clang-tools/gen_compile_commands.py
@@ -109,20 +109,6 @@ def to_cmdfile(path):
     return os.path.join(dir, '.' + base + '.cmd')
 
 
-def cmdfiles_for_o(obj):
-    """Generate the iterator of .cmd files associated with the object
-
-    Yield the .cmd file used to build the given object
-
-    Args:
-        obj: The object path
-
-    Yields:
-        The path to .cmd file
-    """
-    yield to_cmdfile(obj)
-
-
 def cmdfiles_for_a(archive, ar):
     """Generate the iterator of .cmd files associated with the archive.
 
@@ -211,13 +197,10 @@ def main():
     for path in paths:
         # If 'path' is a directory, handle all .cmd files under it.
         # Otherwise, handle .cmd files associated with the file.
-        # Most of built-in objects are linked via archives (built-in.a or lib.a)
-        # but some objects are linked to vmlinux directly.
+        # built-in objects are linked via vmlinux.a
         # Modules are listed in modules.order.
         if os.path.isdir(path):
             cmdfiles = cmdfiles_in_dir(path)
-        elif path.endswith('.o'):
-            cmdfiles = cmdfiles_for_o(path)
         elif path.endswith('.a'):
             cmdfiles = cmdfiles_for_a(path, ar)
         elif path.endswith('modules.order'):
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 6a197d8a88ac..23ac13fd9d89 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -3,17 +3,15 @@
 #
 # link vmlinux
 #
-# vmlinux is linked from the objects selected by $(KBUILD_VMLINUX_OBJS) and
-# $(KBUILD_VMLINUX_LIBS). Most are built-in.a files from top-level directories
-# in the kernel tree, others are specified in arch/$(ARCH)/Makefile.
+# vmlinux is linked from the objects in vmlinux.a and $(KBUILD_VMLINUX_LIBS).
+# vmlinux.a contains objects that are linked unconditionally.
 # $(KBUILD_VMLINUX_LIBS) are archives which are linked conditionally
 # (not within --whole-archive), and do not require symbol indexes added.
 #
 # vmlinux
 #   ^
 #   |
-#   +--< $(KBUILD_VMLINUX_OBJS)
-#   |    +--< init/built-in.a drivers/built-in.a mm/built-in.a + more
+#   +--< vmlinux.a
 #   |
 #   +--< $(KBUILD_VMLINUX_LIBS)
 #   |    +--< lib/lib.a + more
@@ -67,7 +65,7 @@ vmlinux_link()
 		objs=vmlinux.o
 		libs=
 	else
-		objs="${KBUILD_VMLINUX_OBJS}"
+		objs=vmlinux.a
 		libs="${KBUILD_VMLINUX_LIBS}"
 	fi
 
-- 
2.34.1

