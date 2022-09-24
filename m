Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65885E8F39
	for <lists+linux-arch@lfdr.de>; Sat, 24 Sep 2022 20:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbiIXSUf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 24 Sep 2022 14:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiIXSU2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 24 Sep 2022 14:20:28 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBE42F380;
        Sat, 24 Sep 2022 11:20:25 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 28OIJItS005682;
        Sun, 25 Sep 2022 03:19:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 28OIJItS005682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664043560;
        bh=6eCSbvyDGZd71EFmTW50BnBOpDQgEie3TI2OqyyCjqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FLcpNy0A9tY3rTzs1OoV+z8TlwqSD0G27zFC1UWOe9keYguq1S5pb+O2qSl0nKLeQ
         OWyT3axHVhTtnqbaEduSTyXj4R/WywK8Zl991AF+fWQWipEt6XsPsHkgQzVQyDJ4nd
         i/qEigNy+knI/3vRHh5h0cjKUSfkYSaJ3QifbA23eghxiYkmLvELrLEBfebLCiPmrk
         aE7rWx5wrZjHZiCswPpHY12algVGcCUkgq6WYCjcKutT5v3dqe1feXGj8AqZUA+Vy6
         VWB0KAvZOrLP0SidFVnxhTL4pH9j9HJTIVzyuuEi9Pfh07yw5PXk0Rqz1B2Oi7DaZe
         Vc9ACnyg+MdYw==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v3 2/7] kbuild: list sub-directories in ./Kbuild
Date:   Sun, 25 Sep 2022 03:19:10 +0900
Message-Id: <20220924181915.3251186-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220924181915.3251186-1-masahiroy@kernel.org>
References: <20220924181915.3251186-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use the ordinary obj-y syntax to list subdirectories.

Note1:
Previously, the link order of lib-y depended on CONFIG_MODULES; lib-y
was linked before drivers-y when CONFIG_MODULES=y, otherwise after
drivers-y. This was a bug of commit 7273ad2b08f8 ("kbuild: link lib-y
objects to vmlinux forcibly when CONFIG_MODULES=y"), but it was not a
big deal after all. Now, all objects listed in lib-y are linked last,
irrespective of CONFIG_MODULES.

Note2:
Finally, the single target build in arch/*/lib/ works correctly. There was
a bug report about this. [1]

  $ make ARCH=arm arch/arm/lib/findbit.o
    CALL    scripts/checksyscalls.sh
    AS      arch/arm/lib/findbit.o

[1]: https://lore.kernel.org/linux-kbuild/YvUQOwL6lD4%2F5%2FU6@shell.armlinux.org.uk/

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v3:
  - Also move libs-y to fix the bug reported by:
     https://lore.kernel.org/linux-kbuild/20220921043946.GA1355561@roeck-us.net/

 Kbuild               | 24 ++++++++++++++++
 Makefile             | 65 ++++++++++++++------------------------------
 scripts/Makefile.lib |  2 ++
 3 files changed, 46 insertions(+), 45 deletions(-)

diff --git a/Kbuild b/Kbuild
index 0b9e8a16a621..8a37584d1fd6 100644
--- a/Kbuild
+++ b/Kbuild
@@ -72,3 +72,27 @@ $(atomic-checks): $(obj)/.checked-%: include/linux/atomic/%  FORCE
 PHONY += prepare
 prepare: $(offsets-file) missing-syscalls $(atomic-checks)
 	@:
+
+# Ordinary directory descending
+# ---------------------------------------------------------------------------
+
+obj-y			+= init/
+obj-y			+= usr/
+obj-y			+= arch/$(SRCARCH)/
+obj-y			+= $(ARCH_CORE)
+obj-y			+= kernel/
+obj-y			+= certs/
+obj-y			+= mm/
+obj-y			+= fs/
+obj-y			+= ipc/
+obj-y			+= security/
+obj-y			+= crypto/
+obj-$(CONFIG_BLOCK)	+= block/
+obj-$(CONFIG_IO_URING)	+= io_uring/
+obj-y			+= $(ARCH_LIB)
+obj-y			+= drivers/
+obj-y			+= sound/
+obj-$(CONFIG_SAMPLES)	+= samples/
+obj-$(CONFIG_NET)	+= net/
+obj-y			+= virt/
+obj-y			+= $(ARCH_DRIVERS)
diff --git a/Makefile b/Makefile
index eb4bbbc898d0..f793c3b1eaec 100644
--- a/Makefile
+++ b/Makefile
@@ -676,11 +676,8 @@ endif
 
 ifeq ($(KBUILD_EXTMOD),)
 # Objects we will link into vmlinux / subdirs we need to visit
-core-y		:= init/ usr/ arch/$(SRCARCH)/
-drivers-y	:= drivers/ sound/
-drivers-$(CONFIG_SAMPLES) += samples/
-drivers-$(CONFIG_NET) += net/
-drivers-y	+= virt/
+core-y		:=
+drivers-y	:=
 libs-y		:= lib/
 endif # KBUILD_EXTMOD
 
@@ -1099,33 +1096,24 @@ export MODORDER := $(extmod_prefix)modules.order
 export MODULES_NSDEPS := $(extmod_prefix)modules.nsdeps
 
 ifeq ($(KBUILD_EXTMOD),)
-core-y			+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/
-core-$(CONFIG_BLOCK)	+= block/
-core-$(CONFIG_IO_URING)	+= io_uring/
 
-vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, \
-		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
-		     $(libs-y) $(libs-m)))
-
-vmlinux-alldirs	:= $(sort $(vmlinux-dirs) Documentation . \
+build-dir	:= .
+clean-dirs	:= $(sort . Documentation \
 		     $(patsubst %/,%,$(filter %/, $(core-) \
 			$(drivers-) $(libs-))))
 
-build-dirs	:= $(vmlinux-dirs)
-clean-dirs	:= $(vmlinux-alldirs)
-
-subdir-modorder := $(addsuffix /modules.order, $(build-dirs))
-
+export ARCH_CORE	:= $(core-y)
+export ARCH_LIB		:= $(filter %/, $(libs-y))
+export ARCH_DRIVERS	:= $(drivers-y) $(drivers-m)
 # Externally visible symbols (used by link-vmlinux.sh)
-KBUILD_VMLINUX_OBJS := $(head-y) $(patsubst %/,%/built-in.a, $(core-y))
-KBUILD_VMLINUX_OBJS += $(addsuffix built-in.a, $(filter %/, $(libs-y)))
+
+KBUILD_VMLINUX_OBJS := $(head-y) ./built-in.a
 ifdef CONFIG_MODULES
 KBUILD_VMLINUX_OBJS += $(patsubst %/, %/lib.a, $(filter %/, $(libs-y)))
 KBUILD_VMLINUX_LIBS := $(filter-out %/, $(libs-y))
 else
 KBUILD_VMLINUX_LIBS := $(patsubst %/,%/lib.a, $(libs-y))
 endif
-KBUILD_VMLINUX_OBJS += $(patsubst %/,%/built-in.a, $(drivers-y))
 
 export KBUILD_VMLINUX_OBJS KBUILD_VMLINUX_LIBS
 export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
@@ -1140,7 +1128,7 @@ ifdef CONFIG_TRIM_UNUSED_KSYMS
 # (this can be evaluated only once include/config/auto.conf has been included)
 KBUILD_MODULES := 1
 
-autoksyms_recursive: descend modules.order
+autoksyms_recursive: $(build-dir) modules.order
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/adjust_autoksyms.sh \
 	  "$(MAKE) -f $(srctree)/Makefile autoksyms_recursive"
 endif
@@ -1168,7 +1156,7 @@ targets := vmlinux
 
 # The actual objects are generated when descending,
 # make sure no implicit rule kicks in
-$(sort $(vmlinux-deps) $(subdir-modorder)): descend ;
+$(sort $(vmlinux-deps)): $(build-dir) ;
 
 filechk_kernel.release = \
 	echo "$(KERNELVERSION)$$($(CONFIG_SHELL) $(srctree)/scripts/setlocalversion $(srctree))"
@@ -1439,13 +1427,6 @@ endif
 
 modules: $(if $(KBUILD_BUILTIN),vmlinux) modules_prepare
 
-cmd_modules_order = cat $(real-prereqs) > $@
-
-modules.order: $(subdir-modorder) FORCE
-	$(call if_changed,modules_order)
-
-targets += modules.order
-
 # Target to prepare building external modules
 modules_prepare: prepare
 	$(Q)$(MAKE) $(build)=scripts scripts/module.lds
@@ -1716,9 +1697,7 @@ else # KBUILD_EXTMOD
 KBUILD_BUILTIN :=
 KBUILD_MODULES := 1
 
-build-dirs := $(KBUILD_EXTMOD)
-$(MODORDER): descend
-	@:
+build-dir := $(KBUILD_EXTMOD)
 
 compile_commands.json: $(extmod_prefix)compile_commands.json
 PHONY += compile_commands.json
@@ -1756,6 +1735,9 @@ PHONY += modules modules_install modules_prepare
 
 ifdef CONFIG_MODULES
 
+$(MODORDER): $(build-dir)
+	@:
+
 modules: modules_check
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
 
@@ -1809,7 +1791,7 @@ single-no-ko := $(filter-out $(single-ko), $(MAKECMDGOALS)) \
 
 $(single-ko): single_modpost
 	@:
-$(single-no-ko): descend
+$(single-no-ko): $(build-dir)
 	@:
 
 # Remove MODORDER when done because it is not the real one.
@@ -1819,24 +1801,17 @@ single_modpost: $(single-no-ko) modules_prepare
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
 	$(Q)rm -f $(MODORDER)
 
-single-goals := $(addprefix $(extmod_prefix), $(single-no-ko))
-
-# trim unrelated directories
-build-dirs := $(foreach d, $(build-dirs), \
-			$(if $(filter $d/%, $(single-goals)), $d))
+single-goals := $(addprefix $(build-dir)/, $(single-no-ko))
 
 endif
 
-# Handle descending into subdirectories listed in $(build-dirs)
 # Preset locale variables to speed up the build process. Limit locale
 # tweaks to this spot to avoid wrong language settings when running
 # make menuconfig etc.
 # Error messages still appears in the original language
-PHONY += descend $(build-dirs)
-descend: $(build-dirs)
-$(build-dirs): prepare
-	$(Q)$(MAKE) $(build)=$@ need-builtin=1 need-modorder=1 \
-	$(filter $@/%, $(single-goals))
+PHONY += $(build-dir)
+$(build-dir): prepare
+	$(Q)$(MAKE) $(build)=$@ need-builtin=1 need-modorder=1 $(single-goals)
 
 clean-dirs := $(addprefix _clean_, $(clean-dirs))
 PHONY += $(clean-dirs) clean
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 3fb6a99e78c4..140dcc3c57bd 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -89,6 +89,7 @@ always-y			+= $(dtb-y)
 
 # Add subdir path
 
+ifneq ($(obj),.)
 extra-y		:= $(addprefix $(obj)/,$(extra-y))
 always-y	:= $(addprefix $(obj)/,$(always-y))
 targets		:= $(addprefix $(obj)/,$(targets))
@@ -100,6 +101,7 @@ multi-obj-m	:= $(addprefix $(obj)/, $(multi-obj-m))
 multi-dtb-y	:= $(addprefix $(obj)/, $(multi-dtb-y))
 real-dtb-y	:= $(addprefix $(obj)/, $(real-dtb-y))
 subdir-ym	:= $(addprefix $(obj)/,$(subdir-ym))
+endif
 
 # Finds the multi-part object the current object will be linked into.
 # If the object belongs to two or more multi-part objects, list them all.
-- 
2.34.1

