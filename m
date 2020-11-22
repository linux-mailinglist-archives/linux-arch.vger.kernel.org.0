Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67E02BC575
	for <lists+linux-arch@lfdr.de>; Sun, 22 Nov 2020 12:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgKVLvo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 22 Nov 2020 06:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbgKVLvn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 22 Nov 2020 06:51:43 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64304C0613CF
        for <linux-arch@vger.kernel.org>; Sun, 22 Nov 2020 03:51:43 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p8so15637449wrx.5
        for <linux-arch@vger.kernel.org>; Sun, 22 Nov 2020 03:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=QKuA4ekOdaJDz2ZNBGMOghu/aSzBNJa42AJDcLk6jOQ=;
        b=JLXA+ro1f2pyGijb818SWjOikHzun2D9pSZJAUZpINS8K7zgz+m7JszJJQs55yurWT
         9t+EqoPX+MxO35oCTS7NZX59A2jMR3pJywt1RlwTgCD3oTIgAXpyeHfNngg84KtBzDD7
         E+38SOwvkHdp5SwUG/kvz4JkLvs2k7uQBxbFqqvocVtgo8tvIb8a2fHQGLAL42FNYBA7
         cBjWmCZhPQexEzUxT01Ag6FH/qDQ+E9yJcC1yfRBaewKl+lXRHi5UpyofKtAaq0aTeQV
         Vjjz1spnPClre/ExirNh0SSCAVKn8bZ0bxsXwSFZPMUfAHXLLXBDbus+hqJCbxMCE9g1
         nGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=QKuA4ekOdaJDz2ZNBGMOghu/aSzBNJa42AJDcLk6jOQ=;
        b=Ao84eR936YQx0R1CO05VTQqIvB7I4zRkBt4i/XBK4pPIE4D5sr3Rn9xICl8J6ygTa4
         FU/xqmhuYCh0zkCvewfGGH6+yAX+OrMxzHfXE3P6vKOtfJxZ9F6Ugf3xU7m0Z/jFJOoA
         zISeSSbSv5blgCGKZKLg5MW3oTjEgP/jK78Mi3Lx6PLLHddbj06sEEicW0iLZiqqK7zz
         ZfVpi3AWe/HTGoabaCYdtVtu4n01dxgmBKrLSgZWLWs+kaZoBag3bDt4p1gZ3TT9bYVG
         o5Y1Igl1ltTgPPuEdtFxh6GmfVzsCUNJI7vtnvQSRxlsddsH6MT8sBNG/uL4nxVs/qbF
         PF3g==
X-Gm-Message-State: AOAM531QrlUe76vz2sRAFfh5pDn3a42yYVV+wSmYAvoDi3ipPON4xDTB
        dJTicTopjEMS9QNK67sQRf+fyJdOHw==
X-Google-Smtp-Source: ABdhPJz+m3jlhX90gQlAUF42BIgXNnP7Vh6lwxA/UyDttKVK2dM4N/+gCW5fs60mcrZYPhqH2c7vNA==
X-Received: by 2002:a5d:52c1:: with SMTP id r1mr27040160wrv.255.1606045902201;
        Sun, 22 Nov 2020 03:51:42 -0800 (PST)
Received: from localhost.localdomain ([46.53.251.228])
        by smtp.gmail.com with ESMTPSA id k81sm48190115wma.2.2020.11.22.03.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 03:51:41 -0800 (PST)
Date:   Sun, 22 Nov 2020 14:51:39 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     arnd@arndb.de
Cc:     linux-arch@vger.kernel.org
Subject: [PATCH] asm-generic/io.h: terser readsb() and friends
Message-ID: <20201122115139.GA47348@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

	if (count) {
		do {
			...
		} while (--count);
	}

can be rewritten as

	while (count-- > 0) {
		...
	}

Drop useless variables while I'm at it.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/asm-generic/io.h |   68 ++++++++++++++++-------------------------------
 1 file changed, 24 insertions(+), 44 deletions(-)

--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -317,13 +317,10 @@ static inline void writeq_relaxed(u64 value, volatile void __iomem *addr)
 static inline void readsb(const volatile void __iomem *addr, void *buffer,
 			  unsigned int count)
 {
-	if (count) {
-		u8 *buf = buffer;
+	u8 *buf = buffer;
 
-		do {
-			u8 x = __raw_readb(addr);
-			*buf++ = x;
-		} while (--count);
+	while (count-- > 0) {
+		*buf++ = __raw_readb(addr);
 	}
 }
 #endif
@@ -333,13 +330,10 @@ static inline void readsb(const volatile void __iomem *addr, void *buffer,
 static inline void readsw(const volatile void __iomem *addr, void *buffer,
 			  unsigned int count)
 {
-	if (count) {
-		u16 *buf = buffer;
+	u16 *buf = buffer;
 
-		do {
-			u16 x = __raw_readw(addr);
-			*buf++ = x;
-		} while (--count);
+	while (count-- > 0) {
+		*buf++ = __raw_readw(addr);
 	}
 }
 #endif
@@ -349,13 +343,10 @@ static inline void readsw(const volatile void __iomem *addr, void *buffer,
 static inline void readsl(const volatile void __iomem *addr, void *buffer,
 			  unsigned int count)
 {
-	if (count) {
-		u32 *buf = buffer;
+	u32 *buf = buffer;
 
-		do {
-			u32 x = __raw_readl(addr);
-			*buf++ = x;
-		} while (--count);
+	while (count-- > 0) {
+		*buf++ = __raw_readl(addr);
 	}
 }
 #endif
@@ -366,13 +357,10 @@ static inline void readsl(const volatile void __iomem *addr, void *buffer,
 static inline void readsq(const volatile void __iomem *addr, void *buffer,
 			  unsigned int count)
 {
-	if (count) {
-		u64 *buf = buffer;
+	u64 *buf = buffer;
 
-		do {
-			u64 x = __raw_readq(addr);
-			*buf++ = x;
-		} while (--count);
+	while (count-- > 0) {
+		*buf++ = __raw_readq(addr);
 	}
 }
 #endif
@@ -383,12 +371,10 @@ static inline void readsq(const volatile void __iomem *addr, void *buffer,
 static inline void writesb(volatile void __iomem *addr, const void *buffer,
 			   unsigned int count)
 {
-	if (count) {
-		const u8 *buf = buffer;
+	const u8 *buf = buffer;
 
-		do {
-			__raw_writeb(*buf++, addr);
-		} while (--count);
+	while (count-- > 0) {
+		__raw_writeb(*buf++, addr);
 	}
 }
 #endif
@@ -398,12 +384,10 @@ static inline void writesb(volatile void __iomem *addr, const void *buffer,
 static inline void writesw(volatile void __iomem *addr, const void *buffer,
 			   unsigned int count)
 {
-	if (count) {
-		const u16 *buf = buffer;
+	const u16 *buf = buffer;
 
-		do {
-			__raw_writew(*buf++, addr);
-		} while (--count);
+	while (count-- > 0) {
+		__raw_writew(*buf++, addr);
 	}
 }
 #endif
@@ -413,12 +397,10 @@ static inline void writesw(volatile void __iomem *addr, const void *buffer,
 static inline void writesl(volatile void __iomem *addr, const void *buffer,
 			   unsigned int count)
 {
-	if (count) {
-		const u32 *buf = buffer;
+	const u32 *buf = buffer;
 
-		do {
-			__raw_writel(*buf++, addr);
-		} while (--count);
+	while (count-- > 0) {
+		__raw_writel(*buf++, addr);
 	}
 }
 #endif
@@ -429,12 +411,10 @@ static inline void writesl(volatile void __iomem *addr, const void *buffer,
 static inline void writesq(volatile void __iomem *addr, const void *buffer,
 			   unsigned int count)
 {
-	if (count) {
-		const u64 *buf = buffer;
+	const u64 *buf = buffer;
 
-		do {
-			__raw_writeq(*buf++, addr);
-		} while (--count);
+	while (count-- > 0) {
+		__raw_writeq(*buf++, addr);
 	}
 }
 #endif
