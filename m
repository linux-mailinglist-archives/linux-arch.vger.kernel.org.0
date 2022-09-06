Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2CE5ADF7D
	for <lists+linux-arch@lfdr.de>; Tue,  6 Sep 2022 08:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiIFGOO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Sep 2022 02:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbiIFGOJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Sep 2022 02:14:09 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0B56F277;
        Mon,  5 Sep 2022 23:14:06 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 2866DVI9023845;
        Tue, 6 Sep 2022 15:13:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 2866DVI9023845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662444813;
        bh=UjBwyRKQ+sMHIW/laWlK/4o3VWWE5pOimk6yZyootxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jujvUSKNt01rIN+WMvWWqz9Fu/F+b6LMHDTSEookeDo+voWKdyhRs9bPSG68u0RPG
         98fbPC+l6eid8jQ7vPUQ8zYebZBNDblIBTtCaU/HwkC43rpEDixebnwc+/qn9n0oaF
         g0XK1L7yZnGXjUd5tqfGuuMDoVhAb141EYdNIttGoJyTVAHMVBsdt9hOH3YM2/6Jkc
         Hy4GOmxWolvd21/jRf/tGQoNo66LdAXjVMDsgdYWNluAOYm/vbgGuytgC6ZpzNYv7Y
         bjT06K3ehoLU56JhX/AqrNoPoHwKDRSfOE4TbpG2Npd3aP1l4xyBKc0pvHVOVSKY0I
         djWJve9W8AeOg==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 3/8] kbuild: move core-y and drivers-y to ./Kbuild
Date:   Tue,  6 Sep 2022 15:13:08 +0900
Message-Id: <20220906061313.1445810-4-masahiroy@kernel.org>
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

Use the ordinary obj-y to list subdirectories.

Note1:
GNU Make seems to transform './.modules.order' to '.modules.order'
before matching it against the target pattern. Split ./.modules.order
to a dedicated rule to avoid "doesn't match the target pattern"
warning. [1]

Note2:
Previously, the link order of lib-y depended on CONFIG_MODULES; lib-y
was linked before drivers-y when CONFIG_MODULES=y, otherwise after
drivers-y. This was a bug of commit 7273ad2b08f8 ("kbuild: link lib-y
objects to vmlinux forcibly when CONFIG_MODULES=y"), but it was not a
big deal after all. Now, libs-y (all objects that come from lib/ and
arch/*/lib/) is linked last, irrespective of CONFIG_MODULES.

Note3:
Now, the single target build in arch/*/lib/ works correctly. There was
a bug report about this. [2]

  $ make ARCH=arm arch/arm/lib/findbit.o
    CALL    scripts/checksyscalls.sh
    AS      arch/arm/lib/findbit.o

[1]: https://lists.gnu.org/archive/html/bug-make/2022-08/msg00059.html
[2]: https://lore.kernel.org/linux-kbuild/YvUQOwL6lD4%2F5%2FU6@shell.armlinux.org.uk/

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Move all core-y and drivers-y
  - Fix single target build

 Kbuild               | 23 +++++++++++++++++++++++
 Makefile             | 29 +++++++++++++----------------
 scripts/Makefile.lib |  2 ++
 3 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/Kbuild b/Kbuild
index 0b9e8a16a621..8854e88e0619 100644
--- a/Kbuild
+++ b/Kbuild
@@ -72,3 +72,26 @@ $(atomic-checks): $(obj)/.checked-%: include/linux/atomic/%  FORCE
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
+obj-y			+= drivers/
+obj-y			+= sound/
+obj-$(CONFIG_SAMPLES)	+= samples/
+obj-$(CONFIG_NET)	+= net/
+obj-y			+= virt/
+obj-y			+= $(ARCH_DRIVERS)
diff --git a/Makefile b/Makefile
index 552ade93ca1d..ef0621d55ebb 100644
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
 
@@ -1101,23 +1098,20 @@ export MODORDER := $(extmod_prefix)modules.order
 export MODULES_NSDEPS := $(extmod_prefix)modules.nsdeps
 
 ifeq ($(KBUILD_EXTMOD),)
-core-y			+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/
-core-$(CONFIG_BLOCK)	+= block/
-core-$(CONFIG_IO_URING)	+= io_uring/
 
-vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, \
-		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
-		     $(libs-y) $(libs-m)))
+vmlinux-dirs	:= . $(patsubst %/,%,$(filter %/, $(libs-y) $(libs-m)))
 
-vmlinux-alldirs	:= $(sort $(vmlinux-dirs) Documentation . \
+vmlinux-alldirs	:= $(sort $(vmlinux-dirs) Documentation \
 		     $(patsubst %/,%,$(filter %/, $(core-) \
 			$(drivers-) $(libs-))))
 
 build-dirs	:= $(vmlinux-dirs)
 clean-dirs	:= $(vmlinux-alldirs)
 
+export ARCH_CORE	:= $(core-y)
+export ARCH_DRIVERS	:= $(drivers-y)
 # Externally visible symbols (used by link-vmlinux.sh)
-KBUILD_VMLINUX_OBJS := $(head-y) $(patsubst %/,%/built-in.a, $(core-y))
+KBUILD_VMLINUX_OBJS := $(head-y) ./built-in.a
 KBUILD_VMLINUX_OBJS += $(addsuffix built-in.a, $(filter %/, $(libs-y)))
 ifdef CONFIG_MODULES
 KBUILD_VMLINUX_OBJS += $(patsubst %/, %/lib.a, $(filter %/, $(libs-y)))
@@ -1125,7 +1119,6 @@ KBUILD_VMLINUX_LIBS := $(filter-out %/, $(libs-y))
 else
 KBUILD_VMLINUX_LIBS := $(patsubst %/,%/lib.a, $(libs-y))
 endif
-KBUILD_VMLINUX_OBJS += $(patsubst %/,%/built-in.a, $(drivers-y))
 
 export KBUILD_VMLINUX_OBJS KBUILD_VMLINUX_LIBS
 export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
@@ -1752,7 +1745,10 @@ ifdef CONFIG_MODULES
 
 subdir-modorder := $(addsuffix /.modules.order, $(build-dirs))
 
-$(sort $(subdir-modorder)): %/.modules.order: % ;
+# Split ./.modules.order into a dedicate target to avoid
+# "doesn't match the target pattern" warning
+./.modules.order: . ;
+$(sort $(filter-out ./.modules.order, $(subdir-modorder))): %/.modules.order: % ;
 
 cmd_modules_order = cat $(real-prereqs) > $@
 
@@ -1823,7 +1819,8 @@ single_modpost: $(single-no-ko) modules_prepare
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
 	$(Q)rm -f $(MODORDER)
 
-single-goals := $(addprefix $(extmod_prefix), $(single-no-ko))
+single-goals := $(foreach x, $(addprefix $(extmod_prefix), $(single-no-ko)), \
+		$(if $(filter $(addsuffix /%, $(build-dirs)), $x),,./)$x)
 
 # trim unrelated directories
 build-dirs := $(foreach d, $(build-dirs), \
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index b594705d571a..9bdc9ed37f49 100644
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

