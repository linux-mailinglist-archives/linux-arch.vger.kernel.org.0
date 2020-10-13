Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5077128C61E
	for <lists+linux-arch@lfdr.de>; Tue, 13 Oct 2020 02:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgJMAd2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 20:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbgJMAcI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Oct 2020 20:32:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E10C0613D1
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 17:32:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l23so5742010ybl.23
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 17:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=cloCclz36A1w92k6Zbeecg4QRyayzvUWthNVuds2M9U=;
        b=Z96hT5ghe95A4l04B5UCnPDxXSIMybdadUy/cjvfyIfXj6wxTXzuWH2I8ouvwAYXQj
         LBOhLRSvRP2iNbCnrzvy9iCC1A1QBU/BWo5ItmOegPJ5Bxskm6xzbsvJCCQbvRaapvNT
         yKM6gqIiKsmifZbaWj0xem9mLLHq+XOv8S9d6pjnZp0Rwwtj1WnmshYxVOVxmOU9Xth6
         +86qF78YZLlLF1Ytnb3a4FYnrd6rvIkNRGsewv1ZIfz83z1DnjDHho2xRkKGjVHwheNz
         kFakYaKKt70pSbEcht4vngbZjDv3FXiG54n8U0UYJkrP1KqAwYwBFchuQ4Tz0rdhM3nl
         8nog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cloCclz36A1w92k6Zbeecg4QRyayzvUWthNVuds2M9U=;
        b=ZMT5xUjkKRx9r2qex2aBGM6hOFuQb9RtSOLvkEZmX5IVBz2e9TDJoqRdg2WXiWta+Y
         iqQYsOPLzUeVO3fRcvbU+JSl5aaTiBJcBWn+s37mjE6YURCuFp3w3BiUH6j2yJxw5/cX
         dQe3iIbEickhGyZCHMc44cGcUyxdVNXoMpimRls5azRVqAJnJ3WfmFDGjMcjUXQfj0Za
         eK08+IoH5NqbQfvN1o7/zxD/a0hadWa7zra+ItwNgPcFemPzwEx5gykS3zS02DoBK5gE
         clIghy63PaAIFiesv33aVWUwTdlX6UcoNKyA8UyvBXr0aP0qwyQuJcX6RTEHFEk/V3Ni
         DPsw==
X-Gm-Message-State: AOAM530MFC2K/I5kSfMLwf/6KXlTjneWAt/7ngudS9UqBniZ2jUUC4/V
        v471trMo9oX48ZlBpKaYVZKqXbJCGTVqYdZxcHI=
X-Google-Smtp-Source: ABdhPJwkNyv1MD6cWxznbV/DuOICSJnW/qGDGOQmA0l8Q53uBj4VWtQnElrVm3rGF6TBes7M9vMjukgDrEXb9mO7Mws=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:5403:: with SMTP id
 i3mr40522422ybb.43.1602549127241; Mon, 12 Oct 2020 17:32:07 -0700 (PDT)
Date:   Mon, 12 Oct 2020 17:31:39 -0700
In-Reply-To: <20201013003203.4168817-1-samitolvanen@google.com>
Message-Id: <20201013003203.4168817-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v6 01/25] kbuild: preprocess module linker script
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

There was a request to preprocess the module linker script like we
do for the vmlinux one. (https://lkml.org/lkml/2020/8/21/512)

The difference between vmlinux.lds and module.lds is that the latter
is needed for external module builds, thus must be cleaned up by
'make mrproper' instead of 'make clean'. Also, it must be created
by 'make modules_prepare'.

You cannot put it in arch/$(SRCARCH)/kernel/, which is cleaned up by
'make clean'. I moved arch/$(SRCARCH)/kernel/module.lds to
arch/$(SRCARCH)/include/asm/module.lds.h, which is included from
scripts/module.lds.S.

scripts/module.lds is fine because 'make clean' keeps all the
build artifacts under scripts/.

You can add arch-specific sections in <asm/module.lds.h>.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Tested-by: Jessica Yu <jeyu@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Jessica Yu <jeyu@kernel.org>
---
 Makefile                                               | 10 ++++++----
 arch/arm/Makefile                                      |  4 ----
 .../{kernel/module.lds => include/asm/module.lds.h}    |  2 ++
 arch/arm64/Makefile                                    |  4 ----
 .../{kernel/module.lds => include/asm/module.lds.h}    |  2 ++
 arch/ia64/Makefile                                     |  1 -
 arch/ia64/{module.lds => include/asm/module.lds.h}     |  0
 arch/m68k/Makefile                                     |  1 -
 .../{kernel/module.lds => include/asm/module.lds.h}    |  0
 arch/powerpc/Makefile                                  |  1 -
 .../{kernel/module.lds => include/asm/module.lds.h}    |  0
 arch/riscv/Makefile                                    |  3 ---
 .../{kernel/module.lds => include/asm/module.lds.h}    |  3 ++-
 arch/um/include/asm/Kbuild                             |  1 +
 include/asm-generic/Kbuild                             |  1 +
 include/asm-generic/module.lds.h                       | 10 ++++++++++
 scripts/.gitignore                                     |  1 +
 scripts/Makefile                                       |  3 +++
 scripts/Makefile.modfinal                              |  5 ++---
 scripts/{module-common.lds => module.lds.S}            |  3 +++
 scripts/package/builddeb                               |  2 +-
 21 files changed, 34 insertions(+), 23 deletions(-)
 rename arch/arm/{kernel/module.lds => include/asm/module.lds.h} (72%)
 rename arch/arm64/{kernel/module.lds => include/asm/module.lds.h} (76%)
 rename arch/ia64/{module.lds => include/asm/module.lds.h} (100%)
 rename arch/m68k/{kernel/module.lds => include/asm/module.lds.h} (100%)
 rename arch/powerpc/{kernel/module.lds => include/asm/module.lds.h} (100%)
 rename arch/riscv/{kernel/module.lds => include/asm/module.lds.h} (84%)
 create mode 100644 include/asm-generic/module.lds.h
 rename scripts/{module-common.lds => module.lds.S} (93%)

diff --git a/Makefile b/Makefile
index 51540b291738..0dcf302fe2da 100644
--- a/Makefile
+++ b/Makefile
@@ -505,7 +505,6 @@ KBUILD_CFLAGS_KERNEL :=
 KBUILD_AFLAGS_MODULE  := -DMODULE
 KBUILD_CFLAGS_MODULE  := -DMODULE
 KBUILD_LDFLAGS_MODULE :=
-export KBUILD_LDS_MODULE := $(srctree)/scripts/module-common.lds
 KBUILD_LDFLAGS :=
 CLANG_FLAGS :=
 
@@ -1384,7 +1383,7 @@ endif
 # using awk while concatenating to the final file.
 
 PHONY += modules
-modules: $(if $(KBUILD_BUILTIN),vmlinux) modules_check
+modules: $(if $(KBUILD_BUILTIN),vmlinux) modules_check modules_prepare
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
 
 PHONY += modules_check
@@ -1401,6 +1400,7 @@ targets += modules.order
 # Target to prepare building external modules
 PHONY += modules_prepare
 modules_prepare: prepare
+	$(Q)$(MAKE) $(build)=scripts scripts/module.lds
 
 # Target to install modules
 PHONY += modules_install
@@ -1722,7 +1722,9 @@ help:
 	@echo  '  clean           - remove generated files in module directory only'
 	@echo  ''
 
-PHONY += prepare
+# no-op for external module builds
+PHONY += prepare modules_prepare
+
 endif # KBUILD_EXTMOD
 
 # Single targets
@@ -1755,7 +1757,7 @@ MODORDER := .modules.tmp
 endif
 
 PHONY += single_modpost
-single_modpost: $(single-no-ko)
+single_modpost: $(single-no-ko) modules_prepare
 	$(Q){ $(foreach m, $(single-ko), echo $(extmod-prefix)$m;) } > $(MODORDER)
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
 
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index e589da3c8949..9c4d19ae7d61 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -20,10 +20,6 @@ endif
 # linker. All sections should be explicitly named in the linker script.
 LDFLAGS_vmlinux += $(call ld-option, --orphan-handling=warn)
 
-ifeq ($(CONFIG_ARM_MODULE_PLTS),y)
-KBUILD_LDS_MODULE	+= $(srctree)/arch/arm/kernel/module.lds
-endif
-
 GZFLAGS		:=-9
 #KBUILD_CFLAGS	+=-pipe
 
diff --git a/arch/arm/kernel/module.lds b/arch/arm/include/asm/module.lds.h
similarity index 72%
rename from arch/arm/kernel/module.lds
rename to arch/arm/include/asm/module.lds.h
index 79cb6af565e5..0e7cb4e314b4 100644
--- a/arch/arm/kernel/module.lds
+++ b/arch/arm/include/asm/module.lds.h
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifdef CONFIG_ARM_MODULE_PLTS
 SECTIONS {
 	.plt : { BYTE(0) }
 	.init.plt : { BYTE(0) }
 }
+#endif
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index aff994473eb2..32d7e07b0acf 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -127,10 +127,6 @@ endif
 
 CHECKFLAGS	+= -D__aarch64__
 
-ifeq ($(CONFIG_ARM64_MODULE_PLTS),y)
-KBUILD_LDS_MODULE	+= $(srctree)/arch/arm64/kernel/module.lds
-endif
-
 ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_REGS),y)
   KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
   CC_FLAGS_FTRACE := -fpatchable-function-entry=2
diff --git a/arch/arm64/kernel/module.lds b/arch/arm64/include/asm/module.lds.h
similarity index 76%
rename from arch/arm64/kernel/module.lds
rename to arch/arm64/include/asm/module.lds.h
index 22e36a21c113..691f15af788e 100644
--- a/arch/arm64/kernel/module.lds
+++ b/arch/arm64/include/asm/module.lds.h
@@ -1,5 +1,7 @@
+#ifdef CONFIG_ARM64_MODULE_PLTS
 SECTIONS {
 	.plt (NOLOAD) : { BYTE(0) }
 	.init.plt (NOLOAD) : { BYTE(0) }
 	.text.ftrace_trampoline (NOLOAD) : { BYTE(0) }
 }
+#endif
diff --git a/arch/ia64/Makefile b/arch/ia64/Makefile
index 2876a7df1b0a..703b1c4f6d12 100644
--- a/arch/ia64/Makefile
+++ b/arch/ia64/Makefile
@@ -20,7 +20,6 @@ CHECKFLAGS	+= -D__ia64=1 -D__ia64__=1 -D_LP64 -D__LP64__
 
 OBJCOPYFLAGS	:= --strip-all
 LDFLAGS_vmlinux	:= -static
-KBUILD_LDS_MODULE += $(srctree)/arch/ia64/module.lds
 KBUILD_AFLAGS_KERNEL := -mconstant-gp
 EXTRA		:=
 
diff --git a/arch/ia64/module.lds b/arch/ia64/include/asm/module.lds.h
similarity index 100%
rename from arch/ia64/module.lds
rename to arch/ia64/include/asm/module.lds.h
diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
index 4438ffb4bbe1..ea14f2046fb4 100644
--- a/arch/m68k/Makefile
+++ b/arch/m68k/Makefile
@@ -75,7 +75,6 @@ KBUILD_CPPFLAGS += -D__uClinux__
 endif
 
 KBUILD_LDFLAGS := -m m68kelf
-KBUILD_LDS_MODULE += $(srctree)/arch/m68k/kernel/module.lds
 
 ifdef CONFIG_SUN3
 LDFLAGS_vmlinux = -N
diff --git a/arch/m68k/kernel/module.lds b/arch/m68k/include/asm/module.lds.h
similarity index 100%
rename from arch/m68k/kernel/module.lds
rename to arch/m68k/include/asm/module.lds.h
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 3e8da9cf2eb9..8935658fcd06 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -65,7 +65,6 @@ UTS_MACHINE := $(subst $(space),,$(machine-y))
 ifdef CONFIG_PPC32
 KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
 else
-KBUILD_LDS_MODULE += $(srctree)/arch/powerpc/kernel/module.lds
 ifeq ($(call ld-ifversion, -ge, 225000000, y),y)
 # Have the linker provide sfpr if possible.
 # There is a corresponding test in arch/powerpc/lib/Makefile
diff --git a/arch/powerpc/kernel/module.lds b/arch/powerpc/include/asm/module.lds.h
similarity index 100%
rename from arch/powerpc/kernel/module.lds
rename to arch/powerpc/include/asm/module.lds.h
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index fb6e37db836d..8edaa8bd86d6 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -53,9 +53,6 @@ endif
 ifeq ($(CONFIG_CMODEL_MEDANY),y)
 	KBUILD_CFLAGS += -mcmodel=medany
 endif
-ifeq ($(CONFIG_MODULE_SECTIONS),y)
-	KBUILD_LDS_MODULE += $(srctree)/arch/riscv/kernel/module.lds
-endif
 ifeq ($(CONFIG_PERF_EVENTS),y)
         KBUILD_CFLAGS += -fno-omit-frame-pointer
 endif
diff --git a/arch/riscv/kernel/module.lds b/arch/riscv/include/asm/module.lds.h
similarity index 84%
rename from arch/riscv/kernel/module.lds
rename to arch/riscv/include/asm/module.lds.h
index 295ecfb341a2..4254ff2ff049 100644
--- a/arch/riscv/kernel/module.lds
+++ b/arch/riscv/include/asm/module.lds.h
@@ -1,8 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2017 Andes Technology Corporation */
-
+#ifdef CONFIG_MODULE_SECTIONS
 SECTIONS {
 	.plt (NOLOAD) : { BYTE(0) }
 	.got (NOLOAD) : { BYTE(0) }
 	.got.plt (NOLOAD) : { BYTE(0) }
 }
+#endif
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 8d435f8a6dec..1c63b260ecc4 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -16,6 +16,7 @@ generic-y += kdebug.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
 generic-y += mmiowb.h
+generic-y += module.lds.h
 generic-y += param.h
 generic-y += pci.h
 generic-y += percpu.h
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 74b0612601dd..7cd4e627e00e 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -40,6 +40,7 @@ mandatory-y += mmiowb.h
 mandatory-y += mmu.h
 mandatory-y += mmu_context.h
 mandatory-y += module.h
+mandatory-y += module.lds.h
 mandatory-y += msi.h
 mandatory-y += pci.h
 mandatory-y += percpu.h
diff --git a/include/asm-generic/module.lds.h b/include/asm-generic/module.lds.h
new file mode 100644
index 000000000000..f210d5c1b78b
--- /dev/null
+++ b/include/asm-generic/module.lds.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_GENERIC_MODULE_LDS_H
+#define __ASM_GENERIC_MODULE_LDS_H
+
+/*
+ * <asm/module.lds.h> can specify arch-specific sections for linking modules.
+ * Empty for the asm-generic header.
+ */
+
+#endif /* __ASM_GENERIC_MODULE_LDS_H */
diff --git a/scripts/.gitignore b/scripts/.gitignore
index 0d1c8e217cd7..a6c11316c969 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -8,3 +8,4 @@ asn1_compiler
 extract-cert
 sign-file
 insert-sys-cert
+/module.lds
diff --git a/scripts/Makefile b/scripts/Makefile
index bc018e4b733e..b5418ec587fb 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -29,6 +29,9 @@ endif
 # The following programs are only built on demand
 hostprogs += unifdef
 
+# The module linker script is preprocessed on demand
+targets += module.lds
+
 subdir-$(CONFIG_GCC_PLUGINS) += gcc-plugins
 subdir-$(CONFIG_MODVERSIONS) += genksyms
 subdir-$(CONFIG_SECURITY_SELINUX) += selinux
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 411c1e600e7d..ae01baf96f4e 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -33,11 +33,10 @@ quiet_cmd_ld_ko_o = LD [M]  $@
       cmd_ld_ko_o =                                                     \
 	$(LD) -r $(KBUILD_LDFLAGS)					\
 		$(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)		\
-		$(addprefix -T , $(KBUILD_LDS_MODULE))			\
-		-o $@ $(filter %.o, $^);				\
+		-T scripts/module.lds -o $@ $(filter %.o, $^);		\
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 
-$(modules): %.ko: %.o %.mod.o $(KBUILD_LDS_MODULE) FORCE
+$(modules): %.ko: %.o %.mod.o scripts/module.lds FORCE
 	+$(call if_changed,ld_ko_o)
 
 targets += $(modules) $(modules:.ko=.mod.o)
diff --git a/scripts/module-common.lds b/scripts/module.lds.S
similarity index 93%
rename from scripts/module-common.lds
rename to scripts/module.lds.S
index d61b9e8678e8..69b9b71a6a47 100644
--- a/scripts/module-common.lds
+++ b/scripts/module.lds.S
@@ -24,3 +24,6 @@ SECTIONS {
 
 	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
 }
+
+/* bring in arch-specific sections */
+#include <asm/module.lds.h>
diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 6df3c9f8b2da..44f212e37935 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -55,7 +55,7 @@ deploy_kernel_headers () {
 		cd $srctree
 		find . arch/$SRCARCH -maxdepth 1 -name Makefile\*
 		find include scripts -type f -o -type l
-		find arch/$SRCARCH -name module.lds -o -name Kbuild.platforms -o -name Platform
+		find arch/$SRCARCH -name Kbuild.platforms -o -name Platform
 		find $(find arch/$SRCARCH -name include -o -name scripts -type d) -type f
 	) > debian/hdrsrcfiles
 
-- 
2.28.0.1011.ga647a8990f-goog

