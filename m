Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAE277295D
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 17:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjHGPhC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 11:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjHGPhB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 11:37:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB87C10DC;
        Mon,  7 Aug 2023 08:37:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6922861E31;
        Mon,  7 Aug 2023 15:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB52C433C8;
        Mon,  7 Aug 2023 15:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691422619;
        bh=Rm2bAUsRPFrHQrBfNXP+Gimchvv0P1P9SUNLosCJSXw=;
        h=From:To:Cc:Subject:Date:From;
        b=mc0XgWHtFZpAPWBP2MrmMTcXwrE0x5Qk8z/49KcFfDEFBbTbOA3I/3+vF+P3dQjqO
         6ziLRfMWP2QETN3FU+hltqu/8FOaL+CDibSouQjNcup/FMt2sn6xcMV8w5HgG/D2ih
         EMDGK8285L6wF3G1l3yYYWTXBr2tw1ym/7tWXNixxbmusi8g5QgGdFNtEXUm/wlzJ7
         mk1whT9pPEa8d4jsfnYyeDa5tBYFxRfPrhfLjOPZgFl2+7ILG8k4at/EdLpS+hwCbo
         UJNYqqWoFlGikzAs/yuXQyKkx2p4nD6BfBW29LrG7x4WfuTwbNCdYTs0bjI0V62Oh6
         S6/VXl5xjgnQg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/2] m68k: replace #include <asm/export.h> with #include <linux/export.h>
Date:   Tue,  8 Aug 2023 00:36:53 +0900
Message-Id: <20230807153654.997091-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")
deprecated <asm/export.h>, which is now a wrapper of <linux/export.h>.

Replace #include <asm/export.h> with #include <linux/export.h>.

After all the <asm/export.h> lines are converted, <asm/export.h> and
<asm-generic/export.h> will be removed.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/m68k/lib/divsi3.S  | 2 +-
 arch/m68k/lib/modsi3.S  | 2 +-
 arch/m68k/lib/mulsi3.S  | 2 +-
 arch/m68k/lib/udivsi3.S | 2 +-
 arch/m68k/lib/umodsi3.S | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/m68k/lib/divsi3.S b/arch/m68k/lib/divsi3.S
index 3a2143f51631..62787b4333e7 100644
--- a/arch/m68k/lib/divsi3.S
+++ b/arch/m68k/lib/divsi3.S
@@ -33,7 +33,7 @@ General Public License for more details. */
    D. V. Henkel-Wallace (gumby@cygnus.com) Fete Bastille, 1992
 */
 
-#include <asm/export.h>
+#include <linux/export.h>
 
 /* These are predefined by new versions of GNU cpp.  */
 
diff --git a/arch/m68k/lib/modsi3.S b/arch/m68k/lib/modsi3.S
index 1c967649a4e0..1bcb742d0b76 100644
--- a/arch/m68k/lib/modsi3.S
+++ b/arch/m68k/lib/modsi3.S
@@ -33,7 +33,7 @@ General Public License for more details. */
    D. V. Henkel-Wallace (gumby@cygnus.com) Fete Bastille, 1992
 */
 
-#include <asm/export.h>
+#include <linux/export.h>
 
 /* These are predefined by new versions of GNU cpp.  */
 
diff --git a/arch/m68k/lib/mulsi3.S b/arch/m68k/lib/mulsi3.S
index 855675e69a8a..c2853248249e 100644
--- a/arch/m68k/lib/mulsi3.S
+++ b/arch/m68k/lib/mulsi3.S
@@ -32,7 +32,7 @@ General Public License for more details. */
    Some of this code comes from MINIX, via the folks at ericsson.
    D. V. Henkel-Wallace (gumby@cygnus.com) Fete Bastille, 1992
 */
-#include <asm/export.h>
+#include <linux/export.h>
 /* These are predefined by new versions of GNU cpp.  */
 
 #ifndef __USER_LABEL_PREFIX__
diff --git a/arch/m68k/lib/udivsi3.S b/arch/m68k/lib/udivsi3.S
index 78440ae513bf..39ad70596293 100644
--- a/arch/m68k/lib/udivsi3.S
+++ b/arch/m68k/lib/udivsi3.S
@@ -32,7 +32,7 @@ General Public License for more details. */
    Some of this code comes from MINIX, via the folks at ericsson.
    D. V. Henkel-Wallace (gumby@cygnus.com) Fete Bastille, 1992
 */
-#include <asm/export.h>
+#include <linux/export.h>
 /* These are predefined by new versions of GNU cpp.  */
 
 #ifndef __USER_LABEL_PREFIX__
diff --git a/arch/m68k/lib/umodsi3.S b/arch/m68k/lib/umodsi3.S
index b6fd11f58948..6640eaa9eb03 100644
--- a/arch/m68k/lib/umodsi3.S
+++ b/arch/m68k/lib/umodsi3.S
@@ -32,7 +32,7 @@ General Public License for more details. */
    Some of this code comes from MINIX, via the folks at ericsson.
    D. V. Henkel-Wallace (gumby@cygnus.com) Fete Bastille, 1992
 */
-#include <asm/export.h>
+#include <linux/export.h>
 /* These are predefined by new versions of GNU cpp.  */
 
 #ifndef __USER_LABEL_PREFIX__
-- 
2.39.2

