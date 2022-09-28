Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848875ED516
	for <lists+linux-arch@lfdr.de>; Wed, 28 Sep 2022 08:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbiI1Gmg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Sep 2022 02:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiI1Glz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2022 02:41:55 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E91419283;
        Tue, 27 Sep 2022 23:41:21 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 28S6e0G3004120;
        Wed, 28 Sep 2022 15:40:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 28S6e0G3004120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664347203;
        bh=8dVjZPAC/oUXBXN0lJxXAzK00cHf6aabrRwUR04CF5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CwzSxsFEec7Lx0h0x63yNLoutZM2z7vFW5LqZSbglVoMVimWruYR1owxYQvQflU8W
         8pZpNgluw2X6zlFNQSzb/jhUxmQG3jU00MDdouy3equ/kiP0dsfbd84L1k5vg5BnAY
         My+BV6EWzOiQtSmzHmnBGvSt8nJ90/j/oO++5bDn5DNkkkchb966MPi8R3wi2HejUk
         yhDA4INYh+27idymKNVrfrUt527dJXQAoif5+DjnCHS/6vxrhAY81oZf0PLXzIVioS
         zT94aC084Oh6a8FBBNy87yWpx6Sv7wY7RqQDQQgbmSf2LVjyx9M3PWjpGxzJYzDidm
         RzSyu2BT1o9ww==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Pitre <npitre@baylibre.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v3 2/8] kbuild: rebuild .vmlinux.export.o when its prerequisite is updated
Date:   Wed, 28 Sep 2022 15:39:41 +0900
Message-Id: <20220928063947.299333-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928063947.299333-1-masahiroy@kernel.org>
References: <20220928063947.299333-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When include/linux/export-internal.h is updated, .vmlinux.export.o
must be rebuilt, but it does not happen because its rule is hidden
behind scripts/link-vmlinux.sh.

Move it out of the shell script, so that Make can see the dependency
between vmlinux and .vmlinux.export.o.

Move the vmlinux rule to scripts/Makefile.vmlinux.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v3:
  - New patch

 Makefile                 | 16 ++++------------
 scripts/Makefile.vmlinux | 21 ++++++++++++++++++++-
 scripts/link-vmlinux.sh  |  5 -----
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
index 83d8ff1d521a..79488f155fae 100644
--- a/Makefile
+++ b/Makefile
@@ -1160,17 +1160,9 @@ vmlinux_o: autoksyms_recursive vmlinux.a $(KBUILD_VMLINUX_LIBS)
 vmlinux.o modules.builtin.modinfo modules.builtin: vmlinux_o
 	@:
 
-ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
-
-# Final link of vmlinux with optional arch pass after final link
-cmd_link-vmlinux =                                                 \
-	$(CONFIG_SHELL) $< "$(LD)" "$(KBUILD_LDFLAGS)" "$(LDFLAGS_vmlinux)";    \
-	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
-
-vmlinux: scripts/link-vmlinux.sh vmlinux.o $(KBUILD_LDS) modpost FORCE
-	+$(call if_changed_dep,link-vmlinux)
-
-targets += vmlinux
+PHONY += vmlinux
+vmlinux: vmlinux.o $(KBUILD_LDS) modpost
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux
 
 # The actual objects are generated when descending,
 # make sure no implicit rule kicks in
@@ -1501,7 +1493,7 @@ endif # CONFIG_MODULES
 # Directories & files removed with 'make clean'
 CLEAN_FILES += include/ksym vmlinux.symvers modules-only.symvers \
 	       modules.builtin modules.builtin.modinfo modules.nsdeps \
-	       compile_commands.json .thinlto-cache .vmlinux.objs
+	       compile_commands.json .thinlto-cache .vmlinux.objs .vmlinux.export.c
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_FILES += include/config include/generated          \
diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index 7a63abf22399..49946cb96844 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -1,18 +1,37 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+PHONY := __default
+__default: vmlinux
+
 include include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
 
 # for c_flags
 include $(srctree)/scripts/Makefile.lib
 
+targets :=
+
 quiet_cmd_cc_o_c = CC      $@
       cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $<
 
 %.o: %.c FORCE
 	$(call if_changed_dep,cc_o_c)
 
-targets := $(MAKECMDGOALS)
+ifdef CONFIG_MODULES
+targets += .vmlinux.export.o
+vmlinux: .vmlinux.export.o
+endif
+
+ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
+
+# Final link of vmlinux with optional arch pass after final link
+cmd_link_vmlinux =							\
+	$< "$(LD)" "$(KBUILD_LDFLAGS)" "$(LDFLAGS_vmlinux)";		\
+	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
+
+targets += vmlinux
+vmlinux: scripts/link-vmlinux.sh vmlinux.o $(KBUILD_LDS) FORCE
+	+$(call if_changed_dep,link_vmlinux)
 
 # Add FORCE to the prequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index e3d42202e54c..918470d768e9 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -199,7 +199,6 @@ cleanup()
 	rm -f System.map
 	rm -f vmlinux
 	rm -f vmlinux.map
-	rm -f .vmlinux.export.c
 }
 
 # Use "make V=1" to debug this script
@@ -214,10 +213,6 @@ if [ "$1" = "clean" ]; then
 	exit 0
 fi
 
-if is_enabled CONFIG_MODULES; then
-	${MAKE} -f "${srctree}/scripts/Makefile.vmlinux" .vmlinux.export.o
-fi
-
 ${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init init/version-timestamp.o
 
 btf_vmlinux_bin_o=""
-- 
2.34.1

