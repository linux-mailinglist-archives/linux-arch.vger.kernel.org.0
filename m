Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856B025F2D8
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 07:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgIGF6l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Sep 2020 01:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgIGF6i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Sep 2020 01:58:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F8CC061755;
        Sun,  6 Sep 2020 22:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jVjIwAEyeRXAFqYL1XhTmsgyUXaAG2pDm/oDzB7l/mc=; b=BweuExr6Mn6Bjt0U+etjmSfSDo
        MBPlq+Qj6ZDf9ugPVq7/ek+ceu+bAhJi9DSIRZ4gueYWIuekuyCmTUZ00gUdgV7qhvITSX1Ej7/At
        YN0g1P9Lo7EI9o4Y+eZPV9SMPZmYvTuXlgYVwiSkX/MsWy4JudvDKsZEVgCYdi+qczDrkvOR2RYur
        robgMEv4cdglow0f5basy6vPaZUbGIew8DAtBGx1RAPi6eaNtMNG8RXZhF7vvFdXHzt8R3/ZlD4PW
        ZoERGf/jPmRIEvzE4qHCpirNYQuedVSUv58VYv7O+mr/QN3/q08UXaiM9yraR8Uoyrlxwunu8kHE1
        A0jfHVnA==;
Received: from [2001:4bb8:184:af1:e178:97b2:ac6b:4e16] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFAAf-000354-B2; Mon, 07 Sep 2020 05:58:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 2/8] asm-generic: improve the nommu {get,put}_user handling
Date:   Mon,  7 Sep 2020 07:58:19 +0200
Message-Id: <20200907055825.1917151-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907055825.1917151-1-hch@lst.de>
References: <20200907055825.1917151-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Instead of reusing raw_{copy,to}_from_user implement separate handlers
using {get,put}_unaligned.  This ensures unaligned access is handled
correctly, and avoid the need for the small constant size optimization
in raw_{copy,to}_from_user.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/asm-generic/uaccess.h | 91 ++++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 40 deletions(-)

diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index ba68ee4dabfaa7..6de5f524e9e631 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -10,28 +10,60 @@
 #include <linux/string.h>
 
 #ifdef CONFIG_UACCESS_MEMCPY
-static inline __must_check unsigned long
-raw_copy_from_user(void *to, const void __user * from, unsigned long n)
+#include <asm/unaligned.h>
+
+static inline int __get_user_fn(size_t size, const void __user *from, void *to)
 {
-	if (__builtin_constant_p(n)) {
-		switch(n) {
-		case 1:
-			*(u8 *)to = *(u8 __force *)from;
-			return 0;
-		case 2:
-			*(u16 *)to = *(u16 __force *)from;
-			return 0;
-		case 4:
-			*(u32 *)to = *(u32 __force *)from;
-			return 0;
-#ifdef CONFIG_64BIT
-		case 8:
-			*(u64 *)to = *(u64 __force *)from;
-			return 0;
-#endif
-		}
+	BUILD_BUG_ON(!__builtin_constant_p(size));
+
+	switch (size) {
+	case 1:
+		*(u8 *)to = get_unaligned((u8 __force *)from);
+		return 0;
+	case 2:
+		*(u16 *)to = get_unaligned((u16 __force *)from);
+		return 0;
+	case 4:
+		*(u32 *)to = get_unaligned((u32 __force *)from);
+		return 0;
+	case 8:
+		*(u64 *)to = get_unaligned((u64 __force *)from);
+		return 0;
+	default:
+		BUILD_BUG();
+		return 0;
+	}
+
+}
+#define __get_user_fn(sz, u, k)	__get_user_fn(sz, u, k)
+
+static inline int __put_user_fn(size_t size, void __user *to, void *from)
+{
+	BUILD_BUG_ON(!__builtin_constant_p(size));
+
+	switch (size) {
+	case 1:
+		put_unaligned(*(u8 *)from, (u8 __force *)to);
+		return 0;
+	case 2:
+		put_unaligned(*(u16 *)from, (u16 __force *)to);
+		return 0;
+	case 4:
+		put_unaligned(*(u32 *)from, (u32 __force *)to);
+		return 0;
+	case 8:
+		put_unaligned(*(u64 *)from, (u64 __force *)to);
+		return 0;
+	default:
+		BUILD_BUG();
+		return 0;
 	}
+}
+#define __put_user_fn(sz, u, k)	__put_user_fn(sz, u, k)
 
+static inline __must_check unsigned long
+raw_copy_from_user(void *to, const void __user * from, unsigned long n)
+{
 	memcpy(to, (const void __force *)from, n);
 	return 0;
 }
@@ -39,27 +71,6 @@ raw_copy_from_user(void *to, const void __user * from, unsigned long n)
 static inline __must_check unsigned long
 raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-	if (__builtin_constant_p(n)) {
-		switch(n) {
-		case 1:
-			*(u8 __force *)to = *(u8 *)from;
-			return 0;
-		case 2:
-			*(u16 __force *)to = *(u16 *)from;
-			return 0;
-		case 4:
-			*(u32 __force *)to = *(u32 *)from;
-			return 0;
-#ifdef CONFIG_64BIT
-		case 8:
-			*(u64 __force *)to = *(u64 *)from;
-			return 0;
-#endif
-		default:
-			break;
-		}
-	}
-
 	memcpy((void __force *)to, from, n);
 	return 0;
 }
-- 
2.28.0

