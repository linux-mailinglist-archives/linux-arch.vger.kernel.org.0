Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF85546C67
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jun 2022 20:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346538AbiFJSdw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jun 2022 14:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346477AbiFJSdv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jun 2022 14:33:51 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ACD39141;
        Fri, 10 Jun 2022 11:33:48 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 25AIX5TP020882;
        Sat, 11 Jun 2022 03:33:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 25AIX5TP020882
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654885990;
        bh=ebV4+gRnFFeyUFcz5wz1eB/flTewuR25JCfy/TcRt2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lg+lHyyBfli8Rd6bqhWTKnNmE1mIhzuyPRYKkjtgHHTLnFwO0jzJL3wggaX8iu0t5
         rFhUYu9IfjG0mmDQl1SPIleRHAAAlqWiziwvhRg7GMGApx+DjsGNhOlJCcyYhrSdii
         5o9RJT7YK0E0Vp+BtKQ8ocHJYr8FXy8Q97zIin/xHK1CyF57hoEfJi5UmvBfZC0pI4
         CNyfwPAiV2dztxbYqq5ohhm79uIIZfGaA6JCLj/BLrgf7mWuOaB8Ey0F7COoVJd8gw
         6YdMudxvmCwisssEIbxpM/AjxfQpDnes5smSSKPZplDvlrIrO8up/gpJdl6H4PwN1r
         +WzkKXrVjBW9Q==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Nicolas Pitre <npitre@baylibre.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] ia64,export.h: replace EXPORT_DATA_SYMBOL* with EXPORT_SYMBOL*
Date:   Sat, 11 Jun 2022 03:32:33 +0900
Message-Id: <20220610183236.1272216-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220610183236.1272216-1-masahiroy@kernel.org>
References: <20220610183236.1272216-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With the previous refactoring, you no longer need to know whether the
exported symbol is a function or a data.

Replace two instances in ia64, then remove EXPORT_DATA_SYMBOL*.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/ia64/kernel/head.S      | 2 +-
 arch/ia64/kernel/ivt.S       | 2 +-
 include/asm-generic/export.h | 3 ---
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/ia64/kernel/head.S b/arch/ia64/kernel/head.S
index f22469f1c1fc..c096500590e9 100644
--- a/arch/ia64/kernel/head.S
+++ b/arch/ia64/kernel/head.S
@@ -170,7 +170,7 @@ RestRR:											\
 	__PAGE_ALIGNED_DATA
 
 	.global empty_zero_page
-EXPORT_DATA_SYMBOL_GPL(empty_zero_page)
+EXPORT_SYMBOL_GPL(empty_zero_page)
 empty_zero_page:
 	.skip PAGE_SIZE
 
diff --git a/arch/ia64/kernel/ivt.S b/arch/ia64/kernel/ivt.S
index d6d4229b28db..7a418e324d30 100644
--- a/arch/ia64/kernel/ivt.S
+++ b/arch/ia64/kernel/ivt.S
@@ -87,7 +87,7 @@
 
 	.align 32768	// align on 32KB boundary
 	.global ia64_ivt
-	EXPORT_DATA_SYMBOL(ia64_ivt)
+	EXPORT_SYMBOL(ia64_ivt)
 ia64_ivt:
 /////////////////////////////////////////////////////////////////////////////////////////
 // 0x0000 Entry 0 (size 64 bundles) VHPT Translation (8,20,47)
diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 0ae9f38a904c..570cd4da7210 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -8,7 +8,4 @@
  */
 #include <linux/export.h>
 
-#define EXPORT_DATA_SYMBOL(name)	EXPORT_SYMBOL(name)
-#define EXPORT_DATA_SYMBOL_GPL(name)	EXPORT_SYMBOL_GPL(name)
-
 #endif
-- 
2.32.0

