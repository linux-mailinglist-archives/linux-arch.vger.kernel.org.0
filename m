Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AAD5A3B09
	for <lists+linux-arch@lfdr.de>; Sun, 28 Aug 2022 04:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiH1Cnx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Aug 2022 22:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiH1Cnj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Aug 2022 22:43:39 -0400
Received: from condef-08.nifty.com (condef-08.nifty.com [202.248.20.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9AD2983A
        for <linux-arch@vger.kernel.org>; Sat, 27 Aug 2022 19:43:26 -0700 (PDT)
Received: from conuserg-11.nifty.com ([10.126.8.74])by condef-08.nifty.com with ESMTP id 27S2ejr7010401
        for <linux-arch@vger.kernel.org>; Sun, 28 Aug 2022 11:40:45 +0900
Received: from localhost.localdomain (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 27S2e6Gs030639;
        Sun, 28 Aug 2022 11:40:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 27S2e6Gs030639
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661654412;
        bh=YoDXYuJyQEKSSPipp1AABHrm2l3TTVvkj1W/FZ+r+1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f3Hhe1f/JGKAXXcLN36k02+aDrB9yooKVZ0j8s48Bu4w+kg3yZZK3gj4zw5vA9xpv
         Y1GSMyarZfIbtazosGmzyZMdNGYV7zhzN/gG2kRjh+LJg28hqY6OaA+ppXAuRVkd3k
         zSI9ozagTGS0ODlqMhk9PDuqsfk61pg+HFJYjqHDdZLZz163GSKaN3l0Y+YdsFgIxe
         GZYS8v3z0Ye8rMnHKUvoi2uxQGScm8GJhU+ee0VR7ZrBhL29OAUv12x7+3IPUkHRIf
         10YyzsNS0wlxYo4soBfOBAk7FQgJFDubiqWkZMv/eMTnqdvNudJ3eQBzkVGku6x9vw
         qlF/UVt7gWLUA==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 10/15] kbuild: move core-y in top Makefile to ./Kbuild
Date:   Sun, 28 Aug 2022 11:39:58 +0900
Message-Id: <20220828024003.28873-11-masahiroy@kernel.org>
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

Use the ordinary obj-y to list subdirectories.

There are some core-y entries remaining in arch/*/Makefile.
They will be moved after io_uring/built-in.a.

Note:
GNU Make seems to transform './.modules.order' to '.modules.order'
before matching it against the target pattern. Split ./.modules.order
to a dedicated rule to avoid "doesn't match the target pattern"
warning. [1]

[1]: https://lists.gnu.org/archive/html/bug-make/2022-08/msg00059.html

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Kbuild                 | 16 ++++++++++++++++
 Makefile               | 10 +++++-----
 scripts/Makefile.build |  4 ++--
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/Kbuild b/Kbuild
index 0b9e8a16a621..c8661cfc49a3 100644
--- a/Kbuild
+++ b/Kbuild
@@ -72,3 +72,19 @@ $(atomic-checks): $(obj)/.checked-%: include/linux/atomic/%  FORCE
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
+obj-y			+= kernel/
+obj-y			+= certs/
+obj-y			+= mm/
+obj-y			+= fs/
+obj-y			+= ipc/
+obj-y			+= security/
+obj-y			+= crypto/
+obj-$(CONFIG_BLOCK)	+= block/
+obj-$(CONFIG_IO_URING)	+= io_uring/
diff --git a/Makefile b/Makefile
index 89aba2c69be8..1bc44bb4be1f 100644
--- a/Makefile
+++ b/Makefile
@@ -676,7 +676,7 @@ endif
 
 ifeq ($(KBUILD_EXTMOD),)
 # Objects we will link into vmlinux / subdirs we need to visit
-core-y		:= init/ usr/ arch/$(SRCARCH)/
+core-y		:= ./
 drivers-y	:= drivers/ sound/
 drivers-$(CONFIG_SAMPLES) += samples/
 drivers-$(CONFIG_NET) += net/
@@ -1101,9 +1101,6 @@ export MODORDER := $(extmod_prefix)modules.order
 export MODULES_NSDEPS := $(extmod_prefix)modules.nsdeps
 
 ifeq ($(KBUILD_EXTMOD),)
-core-y			+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/
-core-$(CONFIG_BLOCK)	+= block/
-core-$(CONFIG_IO_URING)	+= io_uring/
 
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
@@ -1752,7 +1749,10 @@ ifdef CONFIG_MODULES
 
 subdir-modorder := $(addsuffix /.modules.order, $(build-dirs))
 
-$(sort $(subdir-modorder)): %/.modules.order: % ;
+# Split ./.modules.order into a dedicate target to avoid
+# "doesn't match the target pattern" warning
+./.modules.order: . ;
+$(sort $(filter-out ./.modules.order, $(subdir-modorder))): %/.modules.order: % ;
 
 cmd_modules_order = cat $(real-prereqs) > $@
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index c96c3c0ab228..098c811667d3 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -464,8 +464,8 @@ PHONY += $(subdir-ym)
 $(subdir-ym):
 	$(Q)$(MAKE) $(build)=$@ \
 	$(if $(filter $@/, $(KBUILD_SINGLE_TARGETS)),single-build=) \
-	need-builtin=$(if $(filter $@/built-in.a, $(subdir-builtin)),1) \
-	need-modorder=$(if $(filter $@/.modules.order, $(subdir-modorder)),1)
+	need-builtin=$(if $(filter $@/built-in.a, $(subdir-builtin:./%=%)),1) \
+	need-modorder=$(if $(filter $@/.modules.order, $(subdir-modorder:./%=%)),1)
 
 # Add FORCE to the prequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
-- 
2.34.1

