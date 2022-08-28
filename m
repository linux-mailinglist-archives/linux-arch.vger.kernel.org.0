Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3D25A3B0A
	for <lists+linux-arch@lfdr.de>; Sun, 28 Aug 2022 04:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiH1Cny (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Aug 2022 22:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbiH1Cnk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Aug 2022 22:43:40 -0400
Received: from condef-10.nifty.com (condef-10.nifty.com [202.248.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC4E2A43A
        for <linux-arch@vger.kernel.org>; Sat, 27 Aug 2022 19:43:28 -0700 (PDT)
Received: from conuserg-11.nifty.com ([10.126.8.74])by condef-10.nifty.com with ESMTP id 27S2egmA025496
        for <linux-arch@vger.kernel.org>; Sun, 28 Aug 2022 11:40:42 +0900
Received: from localhost.localdomain (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 27S2e6Go030639;
        Sun, 28 Aug 2022 11:40:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 27S2e6Go030639
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661654410;
        bh=Ojdr7OFV9j1YbpIO3D6oC+XaFmz7/7hOYyO9OvHgWLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OtnOEL7NYfqPML6WGIODFpxvrHhE1Vb5thmq2pIjeo6n6TyyzterPeYzP8wcNWqjR
         2AxpqlcLBSkWH4k3WVPmjjlpu83dto74nipV1UdPm4QNRqsKQj0oaOItt3pMTeC69K
         a37QwTQgL72zcJvu1Jv7yfHAMDCXVqj2F+2izOIQS6TbzBniwlZB8DCXe6uKAAraoq
         eUuVPYIqI7adLqgh6TCo68V2lWLf+9CLZpr16Mzina2VSZk4XTCzFLX553SUT/+vXK
         oXHCIYssoBKDCqDK6WXi7K+qvYk2Uxp/PEJvNPAeodiln5aNZ7+/gQJAuE7VymDaAZ
         vVRUuWOhNGwCA==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 06/15] kbuild: generate include/generated/compile.h in top Makefile
Date:   Sun, 28 Aug 2022 11:39:54 +0900
Message-Id: <20220828024003.28873-7-masahiroy@kernel.org>
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

Now that UTS_VERSION was separated out, this header can be generated
much earlier, and probably the top Makefile is a better place to do it
than init/Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile      | 8 +++++++-
 init/Makefile | 8 +-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 54e481162608..d933c0acab12 100644
--- a/Makefile
+++ b/Makefile
@@ -1198,7 +1198,7 @@ PHONY += prepare archprepare
 
 archprepare: outputmakefile archheaders archscripts scripts include/config/kernel.release \
 	asm-generic $(version_h) $(autoksyms_h) include/generated/utsrelease.h \
-	include/generated/autoconf.h remove-stale-files
+	include/generated/compile.h include/generated/autoconf.h remove-stale-files
 
 prepare0: archprepare
 	$(Q)$(MAKE) $(build)=scripts/mod
@@ -1260,6 +1260,12 @@ $(version_h): FORCE
 include/generated/utsrelease.h: include/config/kernel.release FORCE
 	$(call filechk,utsrelease.h)
 
+filechk_compile.h = $(srctree)/scripts/mkcompile_h \
+	"$(UTS_MACHINE)" "$(CONFIG_CC_VERSION_TEXT)" "$(LD)"
+
+include/generated/compile.h: FORCE
+	$(call filechk,compile.h)
+
 PHONY += headerdep
 headerdep:
 	$(Q)find $(srctree)/include/ -name '*.h' | xargs --max-args 1 \
diff --git a/init/Makefile b/init/Makefile
index 63f53d210cad..31c17a8e314b 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -43,15 +43,9 @@ filechk_uts_version = \
 $(obj)/utsversion-tmp.h: FORCE
 	$(call filechk,uts_version)
 
-$(obj)/version.o: include/generated/compile.h $(obj)/utsversion-tmp.h
+$(obj)/version.o: $(obj)/utsversion-tmp.h
 CFLAGS_version.o := -include $(obj)/utsversion-tmp.h
 
-filechk_compile.h = $(srctree)/scripts/mkcompile_h \
-	"$(UTS_MACHINE)" "$(CONFIG_CC_VERSION_TEXT)" "$(LD)"
-
-include/generated/compile.h: FORCE
-	$(call filechk,compile.h)
-
 #
 # Build version-timestamp.c with final UTS_VERSION
 #
-- 
2.34.1

