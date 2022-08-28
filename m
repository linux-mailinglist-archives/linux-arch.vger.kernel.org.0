Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32735A3B10
	for <lists+linux-arch@lfdr.de>; Sun, 28 Aug 2022 04:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiH1CpX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Aug 2022 22:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiH1CpW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Aug 2022 22:45:22 -0400
Received: from condef-09.nifty.com (condef-09.nifty.com [202.248.20.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B62426542
        for <linux-arch@vger.kernel.org>; Sat, 27 Aug 2022 19:45:21 -0700 (PDT)
Received: from conuserg-11.nifty.com ([10.126.8.74])by condef-09.nifty.com with ESMTP id 27S2ejY3007326
        for <linux-arch@vger.kernel.org>; Sun, 28 Aug 2022 11:40:45 +0900
Received: from localhost.localdomain (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 27S2e6Gr030639;
        Sun, 28 Aug 2022 11:40:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 27S2e6Gr030639
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661654411;
        bh=4G1Mu07321fm2z01H8+kEda+iEOQov2qO2fvcpQnyz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S4zzK74VlVTiLeCWtjNYG1zKCrJZPjcQQQPE3UtKw1dZLver+EIP94VcV+gVMVX5s
         Y8RQg1U+tgs64m66Uefw+bWA6NKjv8GQho5lq6UEOa3OVAckEmYAGg5liaHcxQusku
         ero8cjvJ1ySCZveVHsrv7UxwAn8FPwNfLok4j1T2Yf5BfhqwcR6wxv5Yn1dKesYA18
         FfjOUVJVRfKTLM3xoCdYtLOGzqvn2awl2QChfOKb2+3h7V11n8BB1/T90t2ioVOwGz
         Cj2aoPF0UhDTPPR/Hry8wUZLpgNqBxJoF5yJOYlmRpREOhr0hCTj85xvLYZGnNvkXx
         Qmk8LkAw9GM3A==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 09/15] kbuild: rename modules.order in sub-directories to .modules.order
Date:   Sun, 28 Aug 2022 11:39:57 +0900
Message-Id: <20220828024003.28873-10-masahiroy@kernel.org>
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

The next commit will move core-y from the top Makefile to ./Kbuild to
use obj-y to list sub-directories.

With that, both ./Makefile and ./Kbuild would create modules.order in
the top directory.

To avoid the conflict, rename the per-directory modules.order to
.modules.order.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile               | 27 +++++++++++++--------------
 scripts/Makefile.build | 18 +++++++++---------
 scripts/Makefile.lib   |  8 ++++----
 3 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/Makefile b/Makefile
index d933c0acab12..89aba2c69be8 100644
--- a/Makefile
+++ b/Makefile
@@ -1116,8 +1116,6 @@ vmlinux-alldirs	:= $(sort $(vmlinux-dirs) Documentation . \
 build-dirs	:= $(vmlinux-dirs)
 clean-dirs	:= $(vmlinux-alldirs)
 
-subdir-modorder := $(addsuffix /modules.order, $(build-dirs))
-
 # Externally visible symbols (used by link-vmlinux.sh)
 KBUILD_VMLINUX_OBJS := $(head-y) $(patsubst %/,%/built-in.a, $(core-y))
 KBUILD_VMLINUX_OBJS += $(addsuffix built-in.a, $(filter %/, $(libs-y)))
@@ -1172,7 +1170,7 @@ targets := vmlinux
 
 # The actual objects are generated when descending,
 # make sure no implicit rule kicks in
-$(sort $(vmlinux-deps) $(subdir-modorder)): descend ;
+$(sort $(vmlinux-deps)): descend ;
 
 filechk_kernel.release = \
 	echo "$(KERNELVERSION)$$($(CONFIG_SHELL) $(srctree)/scripts/setlocalversion $(srctree))"
@@ -1444,13 +1442,6 @@ endif
 
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
@@ -1722,8 +1713,6 @@ KBUILD_BUILTIN :=
 KBUILD_MODULES := 1
 
 build-dirs := $(KBUILD_EXTMOD)
-$(MODORDER): descend
-	@:
 
 compile_commands.json: $(extmod_prefix)compile_commands.json
 PHONY += compile_commands.json
@@ -1755,12 +1744,22 @@ help:
 endif # KBUILD_EXTMOD
 
 # ---------------------------------------------------------------------------
-# Modules
+# Modules (common for in-tree modules and external modules)
 
 PHONY += modules modules_install modules_prepare
 
 ifdef CONFIG_MODULES
 
+subdir-modorder := $(addsuffix /.modules.order, $(build-dirs))
+
+$(sort $(subdir-modorder)): %/.modules.order: % ;
+
+cmd_modules_order = cat $(real-prereqs) > $@
+
+targets += $(MODORDER)
+$(MODORDER): $(subdir-modorder) FORCE
+	$(call if_changed,modules_order)
+
 modules: modules_check
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
 
@@ -1860,7 +1859,7 @@ clean: $(clean-dirs)
 		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \
 		-o -name '*.lex.c' -o -name '*.tab.[ch]' \
 		-o -name '*.asn1.[ch]' \
-		-o -name '*.symtypes' -o -name 'modules.order' \
+		-o -name '*.symtypes' -o -name '*modules.order' \
 		-o -name '.tmp_*' \
 		-o -name '*.c.[012]*.*' \
 		-o -name '*.ll' \
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 0df488d0bbb0..c96c3c0ab228 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -73,7 +73,7 @@ endif
 
 # subdir-builtin and subdir-modorder may contain duplications. Use $(sort ...)
 subdir-builtin := $(sort $(filter %/built-in.a, $(real-obj-y)))
-subdir-modorder := $(sort $(filter %/modules.order, $(obj-m)))
+subdir-modorder := $(sort $(filter %/.modules.order, $(obj-m)))
 
 targets-for-builtin := $(extra-y)
 
@@ -89,7 +89,7 @@ targets-for-modules := $(foreach x, o mod $(if $(CONFIG_TRIM_UNUSED_KSYMS), usym
 				$(patsubst %.o, %.$x, $(filter %.o, $(obj-m))))
 
 ifdef need-modorder
-targets-for-modules += $(obj)/modules.order
+targets-for-modules += $(obj)/.modules.order
 endif
 
 targets += $(targets-for-builtin) $(targets-for-modules)
@@ -348,7 +348,7 @@ $(obj)/%.asn1.c $(obj)/%.asn1.h: $(src)/%.asn1 $(objtree)/scripts/asn1_compiler
 
 # To build objects in subdirs, we need to descend into the directories
 $(subdir-builtin): $(obj)/%/built-in.a: $(obj)/% ;
-$(subdir-modorder): $(obj)/%/modules.order: $(obj)/% ;
+$(subdir-modorder): $(obj)/%/.modules.order: $(obj)/% ;
 
 #
 # Rule to compile a set of .o files into one .a file (without symbol table)
@@ -365,18 +365,18 @@ $(obj)/built-in.a: $(real-obj-y) FORCE
 	$(call if_changed,ar_builtin)
 
 #
-# Rule to create modules.order file
+# Rule to create .modules.order file
 #
-# Create commands to either record .ko file or cat modules.order from
+# Create commands to either record .ko file or cat .modules.order from
 # a subdirectory
 # Add $(obj-m) as the prerequisite to avoid updating the timestamp of
-# modules.order unless contained modules are updated.
+# .modules.order unless contained modules are updated.
 
 cmd_modules_order = { $(foreach m, $(real-prereqs), \
-	$(if $(filter %/modules.order, $m), cat $m, echo $(patsubst %.o,%.ko,$m));) :; } \
+	$(if $(filter %/.modules.order, $m), cat $m, echo $(patsubst %.o,%.ko,$m));) :; } \
 	> $@
 
-$(obj)/modules.order: $(obj-m) FORCE
+$(obj)/.modules.order: $(obj-m) FORCE
 	$(call if_changed,modules_order)
 
 #
@@ -465,7 +465,7 @@ $(subdir-ym):
 	$(Q)$(MAKE) $(build)=$@ \
 	$(if $(filter $@/, $(KBUILD_SINGLE_TARGETS)),single-build=) \
 	need-builtin=$(if $(filter $@/built-in.a, $(subdir-builtin)),1) \
-	need-modorder=$(if $(filter $@/modules.order, $(subdir-modorder)),1)
+	need-modorder=$(if $(filter $@/.modules.order, $(subdir-modorder)),1)
 
 # Add FORCE to the prequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 3fb6a99e78c4..b594705d571a 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -26,14 +26,14 @@ subdir-ym := $(sort $(subdir-y) $(subdir-m) \
 
 # Handle objects in subdirs:
 # - If we encounter foo/ in $(obj-y), replace it by foo/built-in.a and
-#   foo/modules.order
-# - If we encounter foo/ in $(obj-m), replace it by foo/modules.order
+#   foo/.modules.order
+# - If we encounter foo/ in $(obj-m), replace it by foo/.modules.order
 #
-# Generate modules.order to determine modorder. Unfortunately, we don't have
+# Generate .modules.order to determine modorder. Unfortunately, we don't have
 # information about ordering between -y and -m subdirs. Just put -y's first.
 
 ifdef need-modorder
-obj-m := $(patsubst %/,%/modules.order, $(filter %/, $(obj-y)) $(obj-m))
+obj-m := $(patsubst %/,%/.modules.order, $(filter %/, $(obj-y)) $(obj-m))
 else
 obj-m := $(filter-out %/, $(obj-m))
 endif
-- 
2.34.1

