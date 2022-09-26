Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A345EB236
	for <lists+linux-arch@lfdr.de>; Mon, 26 Sep 2022 22:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiIZUhZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Sep 2022 16:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiIZUhV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Sep 2022 16:37:21 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FD3A1D1D;
        Mon, 26 Sep 2022 13:37:18 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 28QKaWu2018737;
        Tue, 27 Sep 2022 05:36:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 28QKaWu2018737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664224596;
        bh=mbThpvrninpaCK/CTWbzGhqDF8eGttC+bocdQ0Ww/r4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lFnesgtsmjAQwbTE5KKkdDfIOBZ8mHhG6E3Quzirelhg8syO6B1g9hYQ5Ch8Vw6Qg
         /Kv2nfpcst5RadJWrNBxiSiuNvzV9+ZZPdAfjjt26bJv+88ZSCtImDSxXLNDKgwRMp
         uunhaM7AnHC6F4B7iDsBIGM/jZZo0U8FNx8vjV7OKgryDKf5IUa9r+w7fKmWcwEPdy
         PKOJEaQwPnfaZpcrvgyV9gKgc4cXvikLiMBH/p9Jg0GrwToMh9vJb3sMTEJdMqAjqk
         hmPySWCTWV7OyNImIwroDMC6UAEoaTYnCppiR3DM7PxjPiMwTP8xKrhU4BLsgkCbW/
         3mT0of71F6kEw==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Pitre <npitre@baylibre.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 2/7] ia64,export.h: replace EXPORT_DATA_SYMBOL* with EXPORT_SYMBOL*
Date:   Tue, 27 Sep 2022 05:36:20 +0900
Message-Id: <20220926203625.1117261-3-masahiroy@kernel.org>
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

