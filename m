Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476AE5ED50A
	for <lists+linux-arch@lfdr.de>; Wed, 28 Sep 2022 08:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbiI1GmI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Sep 2022 02:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbiI1Glp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2022 02:41:45 -0400
X-Greylist: delayed 122606 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Sep 2022 23:40:44 PDT
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FAF1F1EBD;
        Tue, 27 Sep 2022 23:40:44 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 28S6e0G5004120;
        Wed, 28 Sep 2022 15:40:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 28S6e0G5004120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664347205;
        bh=mbThpvrninpaCK/CTWbzGhqDF8eGttC+bocdQ0Ww/r4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a5KVFzadmJLoVQ3EoHPPAvO1dQebgfZ3ZPSK5pObwncMHmumMrx14iWM1X6acvn2T
         fi5jXigzaWXsrDQGkyPdXUrz4V1HgNErU2iswaWQ0WWI5iryEKt2EXSVKfurBL/vBa
         93cFDr88Tf7585+MH/w2/dxI+X1mWTTzwFPLfTjv6aiPTTAaMM9fUIdRzaakoRhRom
         +EJXKVgjWrTNsjvRfX4BMi4NOx+eQJixFIxu1PUDzxNBjwQQNwfL3eUvVIgbguvvAe
         lB7OgYMMqL8rrWClQxY2AqjBlXCYWpP7nPOW+TobvbpFr9cWcU5yMIj5FlUdZc06d/
         jswcKjaQtC7HA==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Pitre <npitre@baylibre.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 4/8] ia64,export.h: replace EXPORT_DATA_SYMBOL* with EXPORT_SYMBOL*
Date:   Wed, 28 Sep 2022 15:39:43 +0900
Message-Id: <20220928063947.299333-5-masahiroy@kernel.org>
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

With the previous refactoring, you can always use EXPORT_SYMBOL*.

Replace two instances in ia64, then remove EXPORT_DATA_SYMBOL*.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

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
2.34.1

