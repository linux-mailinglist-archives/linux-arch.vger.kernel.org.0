Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54AA3168DC
	for <lists+linux-arch@lfdr.de>; Wed, 10 Feb 2021 15:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhBJOOG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Feb 2021 09:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbhBJONT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Feb 2021 09:13:19 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722A1C061788
        for <linux-arch@vger.kernel.org>; Wed, 10 Feb 2021 06:11:46 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id TSBj2401F4C55Sk01SBjmq; Wed, 10 Feb 2021 15:11:44 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l9qDX-005Hsz-DM; Wed, 10 Feb 2021 15:11:43 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l9qDW-006Jqm-SB; Wed, 10 Feb 2021 15:11:42 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Russell King <linux@armlinux.org.uk>,
        Michal Simek <monstr@monstr.eu>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/4] asm-generic: div64: Remove always-true __div64_const32_is_OK()
Date:   Wed, 10 Feb 2021 15:11:39 +0100
Message-Id: <20210210141140.1506212-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210210141140.1506212-1-geert+renesas@glider.be>
References: <20210210141140.1506212-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since commit cafa0010cd51fb71 ("Raise the minimum required gcc version
to 4.6"), the kernel can no longer be compiled using gcc-3.
Hence __div64_const32_is_OK() is always true, and the corresponding
check can thus be removed.

While at it, remove the whitespace error that hurts my eyes, and add the
missing curly braces for the final else statement, as per coding style.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/asm-generic/div64.h | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/asm-generic/div64.h b/include/asm-generic/div64.h
index a3b98c86f077482d..10a8b1342fb0387b 100644
--- a/include/asm-generic/div64.h
+++ b/include/asm-generic/div64.h
@@ -55,17 +55,11 @@
 /*
  * If the divisor happens to be constant, we determine the appropriate
  * inverse at compile time to turn the division into a few inline
- * multiplications which ought to be much faster. And yet only if compiling
- * with a sufficiently recent gcc version to perform proper 64-bit constant
- * propagation.
+ * multiplications which ought to be much faster.
  *
  * (It is unfortunate that gcc doesn't perform all this internally.)
  */
 
-#ifndef __div64_const32_is_OK
-#define __div64_const32_is_OK (__GNUC__ >= 4)
-#endif
-
 #define __div64_const32(n, ___b)					\
 ({									\
 	/*								\
@@ -228,8 +222,7 @@ extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
 	    is_power_of_2(__base)) {			\
 		__rem = (n) & (__base - 1);		\
 		(n) >>= ilog2(__base);			\
-	} else if (__div64_const32_is_OK &&		\
-		   __builtin_constant_p(__base) &&	\
+	} else if (__builtin_constant_p(__base) &&	\
 		   __base != 0) {			\
 		uint32_t __res_lo, __n_lo = (n);	\
 		(n) = __div64_const32(n, __base);	\
@@ -239,8 +232,9 @@ extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
 	} else if (likely(((n) >> 32) == 0)) {		\
 		__rem = (uint32_t)(n) % __base;		\
 		(n) = (uint32_t)(n) / __base;		\
-	} else 						\
+	} else {					\
 		__rem = __div64_32(&(n), __base);	\
+	}						\
 	__rem;						\
  })
 
-- 
2.25.1

