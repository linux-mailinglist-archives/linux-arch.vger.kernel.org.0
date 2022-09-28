Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24445ED51A
	for <lists+linux-arch@lfdr.de>; Wed, 28 Sep 2022 08:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbiI1Gmi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Sep 2022 02:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiI1Glz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2022 02:41:55 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7C736789;
        Tue, 27 Sep 2022 23:41:18 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 28S6e0G2004120;
        Wed, 28 Sep 2022 15:40:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 28S6e0G2004120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664347202;
        bh=cvsLCNDwjBFU5nq7DjNhdSJyG++SPqw0M0fKpYcoIIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XfO0Pp0oPAMch+QY5Ic0JiViCsExdy9FJDvDhjzoNXddtErOYu5MZqzCHH0cEEE0R
         PObhfwksw/Es9GK3aFShbhKE0TlijtJWel/zD3tTbTODcZGNB+qcV2UNW8xAaOLap2
         neqZChGRFbyweblO0Q3xtvjsjEUJ4o8dHNle/Vt7Cs/l/7LyZ6AxQMCjI9gtaG1Ou1
         xCqvzBCFtyCtWxXxIyEM54ua77jBDIvr2jzCkCE0gUtGhwpCjAfIlqclXWhY98BJ/+
         /wufui0A2GPNiMQP8VNnhRHorTeAhwaYspnovnnOf5u9inup5nf8bR+ClvAqC295gl
         a4Yo2F8ycHSgg==
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
Subject: [PATCH v3 1/8] kbuild: move modules.builtin(.modinfo) rules to Makefile.vmlinux_o
Date:   Wed, 28 Sep 2022 15:39:40 +0900
Message-Id: <20220928063947.299333-2-masahiroy@kernel.org>
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

Do not build modules.builtin(.modinfo) as a side-effect of vmlinux.

There are no good reason to rebuild them just because any of vmlinux's
prerequistes (vmlinux.lds, .vmlinux.export.c, etc.) has been updated.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v3:
  - Move to the head of the series

Changes in v2:
  - New patch

 Makefile                   |  6 +++++-
 scripts/Makefile.vmlinux_o | 26 +++++++++++++++++++++++++-
 scripts/link-vmlinux.sh    |  7 -------
 3 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 2b4980490ecb..83d8ff1d521a 100644
--- a/Makefile
+++ b/Makefile
@@ -1153,9 +1153,13 @@ targets += vmlinux.a
 vmlinux.a: $(KBUILD_VMLINUX_OBJS) scripts/head-object-list.txt FORCE
 	$(call if_changed,ar_vmlinux.a)
 
-vmlinux.o: autoksyms_recursive vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
+PHONY += vmlinux_o
+vmlinux_o: autoksyms_recursive vmlinux.a $(KBUILD_VMLINUX_LIBS)
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux_o
 
+vmlinux.o modules.builtin.modinfo modules.builtin: vmlinux_o
+	@:
+
 ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 
 # Final link of vmlinux with optional arch pass after final link
diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 68c22879bade..0edfdb40364b 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 PHONY := __default
-__default: vmlinux.o
+__default: vmlinux.o modules.builtin.modinfo modules.builtin
 
 include include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
@@ -62,6 +62,30 @@ vmlinux.o: $(initcalls-lds) vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
 
 targets += vmlinux.o
 
+# module.builtin.modinfo
+# ---------------------------------------------------------------------------
+
+OBJCOPYFLAGS_modules.builtin.modinfo := -j .modinfo -O binary
+
+targets += modules.builtin.modinfo
+modules.builtin.modinfo: vmlinux.o FORCE
+	$(call if_changed,objcopy)
+
+# module.builtin
+# ---------------------------------------------------------------------------
+
+# The second line aids cases where multiple modules share the same object.
+
+quiet_cmd_modules_builtin = GEN     $@
+      cmd_modules_builtin = \
+	tr '\0' '\n' < $< | \
+	sed -n 's/^[[:alnum:]:_]*\.file=//p' | \
+	tr ' ' '\n' | uniq | sed -e 's:^:kernel/:' -e 's/$$/.ko/' > $@
+
+targets += modules.builtin
+modules.builtin: modules.builtin.modinfo FORCE
+	$(call if_changed,modules_builtin)
+
 # Add FORCE to the prequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
 
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 2782c5d1518b..e3d42202e54c 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -214,13 +214,6 @@ if [ "$1" = "clean" ]; then
 	exit 0
 fi
 
-info MODINFO modules.builtin.modinfo
-${OBJCOPY} -j .modinfo -O binary vmlinux.o modules.builtin.modinfo
-info GEN modules.builtin
-# The second line aids cases where multiple modules share the same object.
-tr '\0' '\n' < modules.builtin.modinfo | sed -n 's/^[[:alnum:]:_]*\.file=//p' |
-	tr ' ' '\n' | uniq | sed -e 's:^:kernel/:' -e 's/$/.ko/' > modules.builtin
-
 if is_enabled CONFIG_MODULES; then
 	${MAKE} -f "${srctree}/scripts/Makefile.vmlinux" .vmlinux.export.o
 fi
-- 
2.34.1

