Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E2E5A3B16
	for <lists+linux-arch@lfdr.de>; Sun, 28 Aug 2022 04:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiH1CqZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Aug 2022 22:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiH1CqU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Aug 2022 22:46:20 -0400
Received: from condef-01.nifty.com (condef-01.nifty.com [202.248.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2F62CDD1
        for <linux-arch@vger.kernel.org>; Sat, 27 Aug 2022 19:46:19 -0700 (PDT)
Received: from conuserg-11.nifty.com ([10.126.8.74])by condef-01.nifty.com with ESMTP id 27S2enH9015361
        for <linux-arch@vger.kernel.org>; Sun, 28 Aug 2022 11:40:49 +0900
Received: from localhost.localdomain (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 27S2e6Gk030639;
        Sun, 28 Aug 2022 11:40:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 27S2e6Gk030639
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661654408;
        bh=4CXgD6J2sGYGkI4a6Qbuk/WA0nBqfddOH+RIg6LYLPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aco7HsG21juUhVCgTkK8JTONguRPkeqX2Y5Kx5TTv79lflwr0pJpmtYWNLT4R2gDb
         Chx/yk01xM/UPTSxzazlz3GL1fLZyYFT69VGJd+c2MqFy2wNjvlLLCHOXGHvrFGZ3O
         rPjSOAr+/iiSf/Q772QlEANOi9rPoyNSIlCp9fxjRB3Jz+vS6sd7C0Ez+iencIdxD/
         cVdQ5o3bDUhC7VzVA6gt6LUQPvFwDR2ttRJU/1EmjCQ4BjKUF98f8g79YIXA48ekSs
         jEtjCch8hJezLHXFcymWdFP+altXIfEcoaLsF5Z1pD22Ct+xY+ii+Vg35rBNg9acW/
         ayUBbUe9+qOKg==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 02/15] kbuild: refactor single builds of *.ko
Date:   Sun, 28 Aug 2022 11:39:50 +0900
Message-Id: <20220828024003.28873-3-masahiroy@kernel.org>
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

Remove the potentially invalid modules.order instead of using
the temporary file.

Also, KBUILD_MODULES is don't care for single builds. No need to
cancel it.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index f04126181885..badd318c5524 100644
--- a/Makefile
+++ b/Makefile
@@ -1787,6 +1787,8 @@ modules modules_install:
 	@echo >&2 '***'
 	@exit 1
 
+KBUILD_MODULES :=
+
 endif # CONFIG_MODULES
 
 # Single targets
@@ -1813,18 +1815,12 @@ $(single-ko): single_modpost
 $(single-no-ko): descend
 	@:
 
-ifeq ($(KBUILD_EXTMOD),)
-# For the single build of in-tree modules, use a temporary file to avoid
-# the situation of modules_install installing an invalid modules.order.
-MODORDER := .modules.tmp
-endif
-
+# Remove MODORDER when done because it is not the real one.
 PHONY += single_modpost
 single_modpost: $(single-no-ko) modules_prepare
 	$(Q){ $(foreach m, $(single-ko), echo $(extmod_prefix)$m;) } > $(MODORDER)
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
-
-KBUILD_MODULES := 1
+	$(Q)rm -f $(MODORDER)
 
 export KBUILD_SINGLE_TARGETS := $(addprefix $(extmod_prefix), $(single-no-ko))
 
@@ -1834,10 +1830,6 @@ build-dirs := $(foreach d, $(build-dirs), \
 
 endif
 
-ifndef CONFIG_MODULES
-KBUILD_MODULES :=
-endif
-
 # Handle descending into subdirectories listed in $(build-dirs)
 # Preset locale variables to speed up the build process. Limit locale
 # tweaks to this spot to avoid wrong language settings when running
-- 
2.34.1

