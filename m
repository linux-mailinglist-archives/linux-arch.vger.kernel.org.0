Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47F4709CBA
	for <lists+linux-arch@lfdr.de>; Fri, 19 May 2023 18:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjESQq3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 May 2023 12:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjESQqY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 12:46:24 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D735109;
        Fri, 19 May 2023 09:46:23 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id ED7661C23;
        Fri, 19 May 2023 16:46:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net ED7661C23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1684514781; bh=ZNWlLNsdSomgBztRTjC+ofbceWifFCA/vAFOs2WlHCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rPsDctuhmTCg0BIh4e5K/F/w56Ongswu/On9iWrqdPI3OOROTzZ4CRxTSH+ZIpOXH
         4e0wfTarhBIGZAJBoVQX9p6Fnurkti4KW46yM+gGcKLUNVfc7oZExwgwgIhH30d76B
         cySHXVaHprtCFqJ7ZyeOjGIoXRqpCJKMasxy7C+Pbh3y8Z828ZPqrMXHt0sPiCDk6Y
         t4hdxm9UAS6ypA28+RX8gp8VgQoiVs2Duwb2aRRUrWgB0ryC279wVkSVwwLjH6QlsI
         jeE+KL8Mw1Yw+JFtm2DjAxDnbWJoLqURh18bLHz1tRmlinQRaOkw4D4tD7jKOoDN40
         ugODp0420HArg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-crypto@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 5/7] crypto: update some Arm documentation references
Date:   Fri, 19 May 2023 10:46:05 -0600
Message-Id: <20230519164607.38845-6-corbet@lwn.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519164607.38845-1-corbet@lwn.net>
References: <20230519164607.38845-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The Arm documentation has moved to Documentation/arch/arm; update a
set of references under crypto/allwinner to match.

Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: linux-crypto@vger.kernel.org
Cc: linux-sunxi@lists.linux.dev
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c | 2 +-
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c   | 2 +-
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c   | 2 +-
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h        | 2 +-
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c | 2 +-
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c   | 2 +-
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c   | 2 +-
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c   | 2 +-
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c   | 2 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c | 2 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c   | 2 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c   | 2 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c   | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
index 10fe9f73a5fb..f2dd66706c10 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
@@ -8,7 +8,7 @@
  * keysize in CBC and ECB mode.
  * Add support also for DES and 3DES in CBC and ECB mode.
  *
- * You could find the datasheet in Documentation/arm/sunxi.rst
+ * You could find the datasheet in Documentation/arch/arm/sunxi.rst
  */
 #include "sun4i-ss.h"
 
diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c
index 006e40133c28..51a3a7b5b985 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c
@@ -6,7 +6,7 @@
  *
  * Core file which registers crypto algorithms supported by the SS.
  *
- * You could find a link for the datasheet in Documentation/arm/sunxi.rst
+ * You could find a link for the datasheet in Documentation/arch/arm/sunxi.rst
  */
 #include <linux/clk.h>
 #include <linux/crypto.h>
diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c
index d28292762b32..f7893e4ac59d 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-hash.c
@@ -6,7 +6,7 @@
  *
  * This file add support for MD5 and SHA1.
  *
- * You could find the datasheet in Documentation/arm/sunxi.rst
+ * You could find the datasheet in Documentation/arch/arm/sunxi.rst
  */
 #include "sun4i-ss.h"
 #include <asm/unaligned.h>
diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h
index ba59c7a48825..6c5d4aa6453c 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h
@@ -8,7 +8,7 @@
  * Support MD5 and SHA1 hash algorithms.
  * Support DES and 3DES
  *
- * You could find the datasheet in Documentation/arm/sunxi.rst
+ * You could find the datasheet in Documentation/arch/arm/sunxi.rst
  */
 
 #include <linux/clk.h>
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
index 74b4e910a38d..c13550090785 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
@@ -8,7 +8,7 @@
  * This file add support for AES cipher with 128,192,256 bits keysize in
  * CBC and ECB mode.
  *
- * You could find a link for the datasheet in Documentation/arm/sunxi.rst
+ * You could find a link for the datasheet in Documentation/arch/arm/sunxi.rst
  */
 
 #include <linux/bottom_half.h>
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index a6865ff4d400..07ea0cc82b16 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -7,7 +7,7 @@
  *
  * Core file which registers crypto algorithms supported by the CryptoEngine.
  *
- * You could find a link for the datasheet in Documentation/arm/sunxi.rst
+ * You could find a link for the datasheet in Documentation/arch/arm/sunxi.rst
  */
 #include <linux/clk.h>
 #include <linux/crypto.h>
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
index 8b5b9b9d04c3..930ad157004c 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
@@ -7,7 +7,7 @@
  *
  * This file add support for MD5 and SHA1/SHA224/SHA256/SHA384/SHA512.
  *
- * You could find the datasheet in Documentation/arm/sunxi.rst
+ * You could find the datasheet in Documentation/arch/arm/sunxi.rst
  */
 #include <linux/bottom_half.h>
 #include <linux/dma-mapping.h>
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c
index b3cc43ea6c8a..80815379f6fc 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c
@@ -7,7 +7,7 @@
  *
  * This file handle the PRNG
  *
- * You could find a link for the datasheet in Documentation/arm/sunxi.rst
+ * You could find a link for the datasheet in Documentation/arch/arm/sunxi.rst
  */
 #include "sun8i-ce.h"
 #include <linux/dma-mapping.h>
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c
index e2b9b9104694..9c35f2a83eda 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c
@@ -7,7 +7,7 @@
  *
  * This file handle the TRNG
  *
- * You could find a link for the datasheet in Documentation/arm/sunxi.rst
+ * You could find a link for the datasheet in Documentation/arch/arm/sunxi.rst
  */
 #include "sun8i-ce.h"
 #include <linux/dma-mapping.h>
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
index 16966cc94e24..381a90fbeaff 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
@@ -8,7 +8,7 @@
  * This file add support for AES cipher with 128,192,256 bits keysize in
  * CBC and ECB mode.
  *
- * You could find a link for the datasheet in Documentation/arm/sunxi.rst
+ * You could find a link for the datasheet in Documentation/arch/arm/sunxi.rst
  */
 
 #include <linux/bottom_half.h>
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
index c9dc06f97857..3dd844b40ff7 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
@@ -7,7 +7,7 @@
  *
  * Core file which registers crypto algorithms supported by the SecuritySystem
  *
- * You could find a link for the datasheet in Documentation/arm/sunxi.rst
+ * You could find a link for the datasheet in Documentation/arch/arm/sunxi.rst
  */
 #include <linux/clk.h>
 #include <linux/crypto.h>
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
index 577bf636f7fb..a4b67d130d11 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
@@ -7,7 +7,7 @@
  *
  * This file add support for MD5 and SHA1/SHA224/SHA256.
  *
- * You could find the datasheet in Documentation/arm/sunxi.rst
+ * You could find the datasheet in Documentation/arch/arm/sunxi.rst
  */
 #include <linux/bottom_half.h>
 #include <linux/dma-mapping.h>
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c
index 70c7b5d571b8..a923cfc6553f 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c
@@ -7,7 +7,7 @@
  *
  * This file handle the PRNG found in the SS
  *
- * You could find a link for the datasheet in Documentation/arm/sunxi.rst
+ * You could find a link for the datasheet in Documentation/arch/arm/sunxi.rst
  */
 #include "sun8i-ss.h"
 #include <linux/dma-mapping.h>
-- 
2.40.1

