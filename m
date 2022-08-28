Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98855A3B14
	for <lists+linux-arch@lfdr.de>; Sun, 28 Aug 2022 04:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiH1CqE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Aug 2022 22:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiH1CqA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Aug 2022 22:46:00 -0400
Received: from condef-08.nifty.com (condef-08.nifty.com [202.248.20.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AE72C657
        for <linux-arch@vger.kernel.org>; Sat, 27 Aug 2022 19:45:58 -0700 (PDT)
Received: from conuserg-11.nifty.com ([10.126.8.74])by condef-08.nifty.com with ESMTP id 27S2ek9a010402
        for <linux-arch@vger.kernel.org>; Sun, 28 Aug 2022 11:40:46 +0900
Received: from localhost.localdomain (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 27S2e6Gx030639;
        Sun, 28 Aug 2022 11:40:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 27S2e6Gx030639
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661654414;
        bh=EJuEUsvnLUK5pwpXzsPIse4yy9Ubav5beZtBE0mnRbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CUetq+ov6jTLmtJTAcyWq8rvsI6X0cowG49mt2xyG2gdbvvCrn96MtBEMBg+rwbRi
         VCu6j/VwYDTwpCmpWoKEKylcvL3B512ikL7AdUdnvMMlnX9rTvPy3Zj1QnKQ1Fi+CH
         YECmHZ97QgjQJh3JT9KFTQcNWPz3v+7UMTYK+PDAr2tNeBHz6Q7XRseIuNQjKKOXQC
         oAvjSHGrZSqPzBrM4hzcCEZb0Rtqep8N9cRfpeM5QX3LGIyXVTtkjTy9ZPx6VXnxUb
         OWqstP2bxvFnt8ix+lL8Y9WYOKAhO3H6WSxLSB2QBNGaZsr0Ot16U0PptQJUF+ie9m
         vuDf8Wj3NRoRQ==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 15/15] kbuild: remove head-y syntax
Date:   Sun, 28 Aug 2022 11:40:03 +0900
Message-Id: <20220828024003.28873-16-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220828024003.28873-1-masahiroy@kernel.org>
References: <20220828024003.28873-1-masahiroy@kernel.org>
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

Kbuild puts the objects listed in head-y at the head of vmlinux.
Conventionally, we do this for head*.S, which contains the kernel entry
point.

A counter approach is to control the section order in the linker script.
Actually, the code marked as __HEAD goes into the ".head.text" section,
which is placed before the normal ".text" section.

I do not know if both of them are needed. head-y is not mandatory.
If you can achieve the proper code placement by the linker script only,
it would be cleaner.

I collected the current head-y objects into head-object-list.txt. It is
a whitelist. My hope is it will be reduced in the long run.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Documentation/kbuild/makefiles.rst |  9 ++---
 Makefile                           |  4 +--
 arch/alpha/Makefile                |  2 --
 arch/arc/Makefile                  |  2 --
 arch/arm/Makefile                  |  3 --
 arch/arm64/Makefile                |  3 --
 arch/csky/Makefile                 |  2 --
 arch/hexagon/Makefile              |  2 --
 arch/ia64/Makefile                 |  1 -
 arch/loongarch/Makefile            |  2 --
 arch/m68k/Makefile                 |  9 -----
 arch/microblaze/Makefile           |  1 -
 arch/mips/Makefile                 |  2 --
 arch/nios2/Makefile                |  1 -
 arch/openrisc/Makefile             |  2 --
 arch/parisc/Makefile               |  2 --
 arch/powerpc/Makefile              | 12 -------
 arch/riscv/Makefile                |  2 --
 arch/s390/Makefile                 |  2 --
 arch/sh/Makefile                   |  2 --
 arch/sparc/Makefile                |  2 --
 arch/x86/Makefile                  |  5 ---
 arch/xtensa/Makefile               |  2 --
 scripts/head-object-list.txt       | 53 ++++++++++++++++++++++++++++++
 24 files changed, 60 insertions(+), 67 deletions(-)
 create mode 100644 scripts/head-object-list.txt

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 07c7e5a843c1..528c54d56c09 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -1065,8 +1065,7 @@ When kbuild executes, the following steps are followed (roughly):
    - The values of the above variables are expanded in arch/$(SRCARCH)/Makefile.
 5) All object files are then linked and the resulting file vmlinux is
    located at the root of the obj tree.
-   The very first objects linked are listed in head-y, assigned by
-   arch/$(SRCARCH)/Makefile.
+   The very first objects linked are listed in scripts/head-object-list.txt.
 6) Finally, the architecture-specific part does any required post processing
    and builds the final bootimage.
    - This includes building boot records
@@ -1214,6 +1213,9 @@ When kbuild executes, the following steps are followed (roughly):
 	All object files for vmlinux. They are linked to vmlinux in the same
 	order as listed in KBUILD_VMLINUX_OBJS.
 
+	The objects listed in scripts/head-object-list.txt are exceptions;
+	they are placed before the other objects.
+
     KBUILD_VMLINUX_LIBS
 
 	All .a "lib" files for vmlinux. KBUILD_VMLINUX_OBJS and
@@ -1257,8 +1259,7 @@ When kbuild executes, the following steps are followed (roughly):
 	machinery is all architecture-independent.
 
 
-	head-y, core-y, libs-y, drivers-y
-	    $(head-y) lists objects to be linked first in vmlinux.
+	core-y, libs-y, drivers-y
 
 	    $(libs-y) lists directories where a lib.a archive can be located.
 
diff --git a/Makefile b/Makefile
index d74aa4552d35..08e69448caf4 100644
--- a/Makefile
+++ b/Makefile
@@ -1159,10 +1159,10 @@ quiet_cmd_ar_vmlinux.a = AR      $@
       cmd_ar_vmlinux.a = \
 	rm -f $@; \
 	$(AR) cDPrST $@ $(KBUILD_VMLINUX_OBJS); \
-	$(AR) mPi $$($(AR) t $@| head -n1) $@ $(head-y)
+	$(AR) mPi $$($(AR) t $@| head -n1) $@ $$($(AR) t $@ | grep -F --file=$(srctree)/scripts/head-object-list.txt)
 
 targets += vmlinux.a
-vmlinux.a: $(KBUILD_VMLINUX_OBJS) FORCE
+vmlinux.a: $(KBUILD_VMLINUX_OBJS) scripts/head-object-list.txt FORCE
 	$(call if_changed,ar_vmlinux.a)
 
 targets += vmlinux.o
diff --git a/arch/alpha/Makefile b/arch/alpha/Makefile
index 881cb913e23a..45158024085e 100644
--- a/arch/alpha/Makefile
+++ b/arch/alpha/Makefile
@@ -36,8 +36,6 @@ cflags-y				+= $(cpuflags-y)
 # BWX is most important, but we don't really want any emulation ever.
 KBUILD_CFLAGS += $(cflags-y) -Wa,-mev6
 
-head-y := arch/alpha/kernel/head.o
-
 libs-y				+= arch/alpha/lib/
 
 # export what is needed by arch/alpha/boot/Makefile
diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index efc54f3e35e0..329400a1c355 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -82,8 +82,6 @@ KBUILD_CFLAGS	+= $(cflags-y)
 KBUILD_AFLAGS	+= $(KBUILD_CFLAGS)
 KBUILD_LDFLAGS	+= $(ldflags-y)
 
-head-y		:= arch/arc/kernel/head.o
-
 # w/o this dtb won't embed into kernel binary
 core-y		+= arch/arc/boot/dts/
 
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 56f655deebb1..29d15c9a433e 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -134,9 +134,6 @@ KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/uni
 
 CHECKFLAGS	+= -D__arm__
 
-#Default value
-head-y		:= arch/arm/kernel/head$(MMUEXT).o
-
 # Text offset. This list is sorted numerically by address in order to
 # provide a means to avoid/resolve conflicts in multi-arch kernels.
 # Note: the 32kB below this value is reserved for use by the kernel
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 6d9d4a58b898..6e03f15bb041 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -133,9 +133,6 @@ ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_REGS),y)
   CC_FLAGS_FTRACE := -fpatchable-function-entry=2
 endif
 
-# Default value
-head-y		:= arch/arm64/kernel/head.o
-
 ifeq ($(CONFIG_KASAN_SW_TAGS), y)
 KASAN_SHADOW_SCALE_SHIFT := 4
 else ifeq ($(CONFIG_KASAN_GENERIC), y)
diff --git a/arch/csky/Makefile b/arch/csky/Makefile
index 4e1d619fd5c6..0e4237e55758 100644
--- a/arch/csky/Makefile
+++ b/arch/csky/Makefile
@@ -59,8 +59,6 @@ LDFLAGS += -EL
 
 KBUILD_AFLAGS += $(KBUILD_CFLAGS)
 
-head-y := arch/csky/kernel/head.o
-
 core-y += arch/csky/$(CSKYABI)/
 
 libs-y += arch/csky/lib/ \
diff --git a/arch/hexagon/Makefile b/arch/hexagon/Makefile
index 44312bc147d8..92d005958dfb 100644
--- a/arch/hexagon/Makefile
+++ b/arch/hexagon/Makefile
@@ -32,5 +32,3 @@ KBUILD_LDFLAGS += $(ldflags-y)
 TIR_NAME := r19
 KBUILD_CFLAGS += -ffixed-$(TIR_NAME) -DTHREADINFO_REG=$(TIR_NAME) -D__linux__
 KBUILD_AFLAGS += -DTHREADINFO_REG=$(TIR_NAME)
-
-head-y := arch/hexagon/kernel/head.o
diff --git a/arch/ia64/Makefile b/arch/ia64/Makefile
index e55c2f138656..56c4bb276b6e 100644
--- a/arch/ia64/Makefile
+++ b/arch/ia64/Makefile
@@ -44,7 +44,6 @@ quiet_cmd_objcopy = OBJCOPY $@
 cmd_objcopy = $(OBJCOPY) $(OBJCOPYFLAGS) $(OBJCOPYFLAGS_$(@F)) $< $@
 
 KBUILD_CFLAGS += $(cflags-y)
-head-y := arch/ia64/kernel/head.o
 
 libs-y				+= arch/ia64/lib/
 
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index ec3de6191276..131fc210c2bf 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -72,8 +72,6 @@ CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
 	sed -e "s/^\#define /-D'/" -e "s/ /'='/" -e "s/$$/'/" -e 's/\$$/&&/g')
 endif
 
-head-y := arch/loongarch/kernel/head.o
-
 libs-y += arch/loongarch/lib/
 
 ifeq ($(KBUILD_EXTMOD),)
diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
index e358605b70ba..43e39040d3ac 100644
--- a/arch/m68k/Makefile
+++ b/arch/m68k/Makefile
@@ -86,15 +86,6 @@ ifdef CONFIG_KGDB
 KBUILD_CFLAGS := $(subst -fomit-frame-pointer,,$(KBUILD_CFLAGS)) -g
 endif
 
-#
-# Select the assembler head startup code. Order is important. The default
-# head code is first, processor specific selections can override it after.
-#
-head-y				:= arch/m68k/kernel/head.o
-head-$(CONFIG_SUN3)		:= arch/m68k/kernel/sun3-head.o
-head-$(CONFIG_M68000)		:= arch/m68k/68000/head.o
-head-$(CONFIG_COLDFIRE)		:= arch/m68k/coldfire/head.o
-
 libs-y				+= arch/m68k/lib/
 
 
diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
index 1826d9ce4459..3f8a86c4336a 100644
--- a/arch/microblaze/Makefile
+++ b/arch/microblaze/Makefile
@@ -48,7 +48,6 @@ CPUFLAGS-1 += $(call cc-option,-mcpu=v$(CPU_VER))
 # r31 holds current when in kernel mode
 KBUILD_CFLAGS += -ffixed-r31 $(CPUFLAGS-y) $(CPUFLAGS-1) $(CPUFLAGS-2)
 
-head-y := arch/microblaze/kernel/head.o
 libs-y += arch/microblaze/lib/
 
 boot := arch/microblaze/boot
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 4d2a3e73fc45..b296e33f8e33 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -324,8 +324,6 @@ endif
 
 OBJCOPYFLAGS		+= --remove-section=.reginfo
 
-head-y := arch/mips/kernel/head.o
-
 libs-y			+= arch/mips/lib/
 libs-$(CONFIG_MIPS_FP_SUPPORT) += arch/mips/math-emu/
 
diff --git a/arch/nios2/Makefile b/arch/nios2/Makefile
index 3f34e6831863..f1ff4ce0f1a2 100644
--- a/arch/nios2/Makefile
+++ b/arch/nios2/Makefile
@@ -37,7 +37,6 @@ KBUILD_CFLAGS += -DUTS_SYSNAME=\"$(UTS_SYSNAME)\"
 KBUILD_CFLAGS += -fno-builtin
 KBUILD_CFLAGS += -G 0
 
-head-y		:= arch/nios2/kernel/head.o
 libs-y		+= arch/nios2/lib/ $(LIBGCC)
 
 INSTALL_PATH ?= /tftpboot
diff --git a/arch/openrisc/Makefile b/arch/openrisc/Makefile
index b446510173cd..68249521db5a 100644
--- a/arch/openrisc/Makefile
+++ b/arch/openrisc/Makefile
@@ -55,8 +55,6 @@ ifeq ($(CONFIG_OPENRISC_HAVE_INST_SEXT),y)
 	KBUILD_CFLAGS += $(call cc-option,-msext)
 endif
 
-head-y 		:= arch/openrisc/kernel/head.o
-
 libs-y		+= $(LIBGCC)
 
 PHONY += vmlinux.bin
diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index e38d993d87f2..a2d8600521f9 100644
--- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -113,8 +113,6 @@ cflags-$(CONFIG_PA7100LC)	+= -march=1.1 -mschedule=7100LC
 cflags-$(CONFIG_PA7300LC)	+= -march=1.1 -mschedule=7300
 cflags-$(CONFIG_PA8X00)		+= -march=2.0 -mschedule=8000
 
-head-y			:= arch/parisc/kernel/head.o 
-
 KBUILD_CFLAGS	+= $(cflags-y)
 LIBGCC		:= $(shell $(CC) -print-libgcc-file-name)
 export LIBGCC
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index fb607758eeca..491cdeed9a72 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -220,18 +220,6 @@ KBUILD_CFLAGS += $(cpu-as-y)
 KBUILD_AFLAGS += $(aflags-y)
 KBUILD_CFLAGS += $(cflags-y)
 
-head-$(CONFIG_PPC64)		:= arch/powerpc/kernel/head_64.o
-head-$(CONFIG_PPC_BOOK3S_32)	:= arch/powerpc/kernel/head_book3s_32.o
-head-$(CONFIG_PPC_8xx)		:= arch/powerpc/kernel/head_8xx.o
-head-$(CONFIG_40x)		:= arch/powerpc/kernel/head_40x.o
-head-$(CONFIG_44x)		:= arch/powerpc/kernel/head_44x.o
-head-$(CONFIG_FSL_BOOKE)	:= arch/powerpc/kernel/head_fsl_booke.o
-
-head-$(CONFIG_PPC64)		+= arch/powerpc/kernel/entry_64.o
-head-$(CONFIG_PPC_FPU)		+= arch/powerpc/kernel/fpu.o
-head-$(CONFIG_ALTIVEC)		+= arch/powerpc/kernel/vector.o
-head-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE)  += arch/powerpc/kernel/prom_init.o
-
 # Default to zImage, override when needed
 all: zImage
 
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 3fa8ef336822..e013df8e7b8b 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -110,8 +110,6 @@ else
 KBUILD_IMAGE	:= $(boot)/Image.gz
 endif
 
-head-y := arch/riscv/kernel/head.o
-
 libs-y += arch/riscv/lib/
 libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 4cb5d17e7ead..de6d8b2ea4d8 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -119,8 +119,6 @@ export KBUILD_CFLAGS_DECOMPRESSOR
 
 OBJCOPYFLAGS	:= -O binary
 
-head-y		:= arch/s390/kernel/head64.o
-
 libs-y		+= arch/s390/lib/
 drivers-y	+= drivers/s390/
 
diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index b39412bf91fb..5c8776482530 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -114,8 +114,6 @@ endif
 
 export ld-bfd
 
-head-y	:= arch/sh/kernel/head_32.o
-
 # Mach groups
 machdir-$(CONFIG_SOLUTION_ENGINE)		+= mach-se
 machdir-$(CONFIG_SH_HP6XX)			+= mach-hp6xx
diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index fe58a410b4ce..a4ea5b05f288 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -56,8 +56,6 @@ endif
 
 endif
 
-head-y                 := arch/sparc/kernel/head_$(BITS).o
-
 libs-y                 += arch/sparc/prom/
 libs-y                 += arch/sparc/lib/
 
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index bafbd905e6e7..9afd323c6916 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -234,11 +234,6 @@ archheaders:
 ###
 # Kernel objects
 
-head-y := arch/x86/kernel/head_$(BITS).o
-head-y += arch/x86/kernel/head$(BITS).o
-head-y += arch/x86/kernel/ebda.o
-head-y += arch/x86/kernel/platform-quirks.o
-
 libs-y  += arch/x86/lib/
 
 # drivers-y are linked after core-y
diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
index 5097caa7bf0c..bfd8e433ed62 100644
--- a/arch/xtensa/Makefile
+++ b/arch/xtensa/Makefile
@@ -55,8 +55,6 @@ KBUILD_CPPFLAGS += $(patsubst %,-I$(srctree)/%include,$(vardirs) $(plfdirs))
 
 KBUILD_DEFCONFIG := iss_defconfig
 
-head-y		:= arch/xtensa/kernel/head.o
-
 libs-y		+= arch/xtensa/lib/
 
 boot		:= arch/xtensa/boot
diff --git a/scripts/head-object-list.txt b/scripts/head-object-list.txt
new file mode 100644
index 000000000000..6610e19d0247
--- /dev/null
+++ b/scripts/head-object-list.txt
@@ -0,0 +1,53 @@
+# Head objects
+#
+# The objects listed here are placed at the head of vmlinux. A typical use-case
+# is an object that contains the entry point. This is kept for compatibility
+# with head-y, Kbuild used to support.
+#
+# A counter approach is to control the section placement in the linker script.
+# The code marked as __HEAD goes into the ".head.text" section, which is placed
+# before the normal ".text" section.
+#
+# If you can achieve the correct code ordering by linker script, please delete
+# the entry from this file.
+#
+arch/alpha/kernel/head.o
+arch/arc/kernel/head.o
+arch/arm/kernel/head-nommu.o
+arch/arm/kernel/head.o
+arch/arm64/kernel/head.o
+arch/csky/kernel/head.o
+arch/hexagon/kernel/head.o
+arch/ia64/kernel/head.o
+arch/loongarch/kernel/head.o
+arch/m68k/68000/head.o
+arch/m68k/coldfire/head.o
+arch/m68k/kernel/head.o
+arch/m68k/kernel/sun3-head.o
+arch/microblaze/kernel/head.o
+arch/mips/kernel/head.o
+arch/nios2/kernel/head.o
+arch/openrisc/kernel/head.o
+arch/parisc/kernel/head.o
+arch/powerpc/kernel/head_40x.o
+arch/powerpc/kernel/head_44x.o
+arch/powerpc/kernel/head_64.o
+arch/powerpc/kernel/head_8xx.o
+arch/powerpc/kernel/head_book3s_32.o
+arch/powerpc/kernel/head_fsl_booke.o
+arch/powerpc/kernel/entry_64.o
+arch/powerpc/kernel/fpu.o
+arch/powerpc/kernel/vector.o
+arch/powerpc/kernel/prom_init.o
+arch/riscv/kernel/head.o
+arch/s390/kernel/head64.o
+arch/sh/kernel/head_32.o
+arch/sparc/kernel/head_32.o
+arch/sparc/kernel/head_64.o
+arch/x86/kernel/head_32.o
+arch/x86/kernel/head_64.o
+arch/x86/kernel/head32.o
+arch/x86/kernel/head64.o
+arch/x86/kernel/ebda.o
+arch/x86/kernel/platform-quirks.o
+arch/xtensa/kernel/head.o
-- 
2.34.1

