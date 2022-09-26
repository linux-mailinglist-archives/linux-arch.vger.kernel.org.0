Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803FF5EB23C
	for <lists+linux-arch@lfdr.de>; Mon, 26 Sep 2022 22:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiIZUht (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Sep 2022 16:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiIZUhs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Sep 2022 16:37:48 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B179E6A9;
        Mon, 26 Sep 2022 13:37:45 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 28QKaWu7018737;
        Tue, 27 Sep 2022 05:36:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 28QKaWu7018737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664224602;
        bh=0kYHR0v0Xht9beu6edv2Fg++Fw26ZI8vbsd8r5R7tlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JtuTJAYw4LhkBbOZKNuuCK0OsB2aQnt6l5TygroYmQVy79p0dKrKueoWQbcMJnZLv
         D0MnmqdTtTXyP/wGjcVfZGS9hC2h8mZIIykMi9u1GG5Xjrnhj522nScOt2GxPSIm/V
         Qh0R94FQpXzF3U9pyRn7bnU1Lq9i/noTvRST5kglQuNR+XLEIxF3RK+80n1AnzI71N
         K79gElcPnjMxl5q6nTNzzCcT+w0YdjtgqVo2PaTGPkpx/js8blvbcJ0pw8M2aKxb/X
         AhNPPTd/c4LAthtYl6BfU5c1I3xQ1lR8J3jPY72A7kjQsJfAL/IObEkRR/4KnhTS/l
         OH++ITvdYFP9Q==
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
Subject: [PATCH v2 7/7] kbuild: move modules.builtin(.modinfo) rules to Makefile.vmlinux_o
Date:   Tue, 27 Sep 2022 05:36:25 +0900
Message-Id: <20220926203625.1117261-8-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926203625.1117261-1-masahiroy@kernel.org>
References: <20220926203625.1117261-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Do not build modules.builtin(.modinfo) as a side-effect of vmlinux.

There are no good reason to rebuild them just because vmlinux's
prerequistes (vmlinux.lds, .vmlinux.export.c, etc.) have been updated.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - New patch

 scripts/Makefile.vmlinux_o | 26 +++++++++++++++++++++++++-
 scripts/link-vmlinux.sh    |  7 -------
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 68c22879bade..5e8f75d336af 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 PHONY := __default
-__default: vmlinux.o
+__default: vmlinux.o modules.builtin
 
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
index 9c3140d33ccd..5e7a12284b39 100755
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

