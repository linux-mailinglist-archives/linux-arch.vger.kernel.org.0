Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEC75ADF7E
	for <lists+linux-arch@lfdr.de>; Tue,  6 Sep 2022 08:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237816AbiIFGOO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Sep 2022 02:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbiIFGOL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Sep 2022 02:14:11 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB2F6E880;
        Mon,  5 Sep 2022 23:14:05 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 2866DVI8023845;
        Tue, 6 Sep 2022 15:13:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 2866DVI8023845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662444813;
        bh=Q6tKdN5irBVYCfWtxPbhHksZcsrNyOTL6s6D6NFZUm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zxK0n61HCunTpmNeHW00A/ONGP17vLDxnjEousaPHFibOWy0FGBMmJPU99fmPW2lD
         b3AIY0cMa5FtPWoqEAqFqjRfOb6RhRHTYPRH5hayxR3m7azXdupRxMyfGPdMkBuuRA
         TOVq9428Jgt3wxV3EUwLudLNFcn2gkcDCctZvVtUJZrJ8wbpCVJQ4UdJpukJUnpK9M
         39FIj0JFciVQ2jdAhb0Z0+ilM5erqbccpLu3BRhmtn44LKwTYkjG/VL61DWv/dJtMh
         QPhdKSbqzyXLIdPfZqEC3MmEghyCs5BDigbYRUnwBSOclgfHtGbSthXgqmJgqPo3ns
         5sfYfEvWqajnQ==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 2/8] kbuild: rename modules.order in sub-directories to .modules.order
Date:   Tue,  6 Sep 2022 15:13:07 +0900
Message-Id: <20220906061313.1445810-3-masahiroy@kernel.org>
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

The next commit will move core-y from the top Makefile to ./Kbuild to
use obj-y to list sub-directories.

With that, both ./Makefile and ./Kbuild would create modules.order in
the top directory.

To avoid the conflict, rename the per-directory modules.order to
.modules.order.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

 Makefile               | 27 +++++++++++++--------------
 scripts/Makefile.build | 18 +++++++++---------
 scripts/Makefile.lib   |  8 ++++----
 3 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/Makefile b/Makefile
index 373cd2f0f49e..552ade93ca1d 100644
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
 
@@ -1859,7 +1858,7 @@ clean: $(clean-dirs)
 		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \
 		-o -name '*.lex.c' -o -name '*.tab.[ch]' \
 		-o -name '*.asn1.[ch]' \
-		-o -name '*.symtypes' -o -name 'modules.order' \
+		-o -name '*.symtypes' -o -name '*modules.order' \
 		-o -name '.tmp_*' \
 		-o -name '*.c.[012]*.*' \
 		-o -name '*.ll' \
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 91d2e5461a3e..da3dc4f5456e 100644
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
@@ -439,7 +439,7 @@ PHONY += $(subdir-ym)
 $(subdir-ym):
 	$(Q)$(MAKE) $(build)=$@ \
 	need-builtin=$(if $(filter $@/built-in.a, $(subdir-builtin)),1) \
-	need-modorder=$(if $(filter $@/modules.order, $(subdir-modorder)),1) \
+	need-modorder=$(if $(filter $@/.modules.order, $(subdir-modorder)),1) \
 	$(filter $@/%, $(single-subdir-goals))
 
 # Add FORCE to the prequisites of a target to force it to be always rebuilt.
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

