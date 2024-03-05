Return-Path: <linux-arch+bounces-2815-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D1E8726D1
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 19:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992C92891B2
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 18:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F0E86646;
	Tue,  5 Mar 2024 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVaHUYDP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFC345C12;
	Tue,  5 Mar 2024 18:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664051; cv=none; b=SDglrA2YYCXfNLGIVPekh107DUULF+9tQykoz37AwoLWmJSeZrpkCE7jS6M+6I5oR0xgIrauxGRjnAiZYCct+rrqrKEobhqdty7Bqj4+UZnMvbvLVBe4FUMJ2o0DhGu/UIT+Kw5hFtuyW7ttXMaeNkqczW5yq6kTybd/NnejwFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664051; c=relaxed/simple;
	bh=X+EByhPE4W4zgTIYfKqC/94xGrznhhdQhRd3bhi5ON0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dRNm/THGrNfcwm55akQjzoVdAYBtsl2cjOlz1fdKD87EURulbQNlnHAcGn1TWui3dY+EXdJX3sRW/5DJXsuamE/6gHhiQ7QTLh66aWSMGl95NtflXwGaRmW6fuPx34l/3ewyfr1A/T1IdMqmbM72x7Kxe6MYjCnxNDn3XxgsYCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVaHUYDP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc29f1956cso47409165ad.0;
        Tue, 05 Mar 2024 10:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709664049; x=1710268849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENga0JZ5rPZBACTN6wZjT+Dt35XTgUy/8PrYsu9aECA=;
        b=cVaHUYDPwJ+GuDNQelWkG3znwHvk5LSXUtWgam9zCh7C+EkctvvZUb54wOlhV/nzgP
         L+CHTLrZokuQbhrRnJFxC5qpOtP2B+swf5WgFW1fq2hnsoPDTi5U90Ap/THKhdyoZZsA
         7d05tpObIHZ+8E/sWIyGkmzoC5131+J+FJbH13URUhhhEC5yqGBrF1wEXhgkZbpMUE7Y
         h+v/UCW6rPFg31CK0/wqx2kcvH+oMNuLYU2bqNEQ4eVTt4VTe6RhIijkW+tHNShE/hqj
         8AUCeBzlKbO70M0+n/vQ+9Cdz4owwegNzABOn+nzueYEGBoiaC9MCaG6T+y0nkg2JmLS
         PC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709664049; x=1710268849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ENga0JZ5rPZBACTN6wZjT+Dt35XTgUy/8PrYsu9aECA=;
        b=NX7F8j6ltMCDvjuAtgPQdXi732UgKVlxPCBE8vE1BqmvbbOBbcA/hdsj8fQvLQl1RK
         7ZvECGKLpJm5RFv5WDohXj7fWtHDMYb+gKdnBuPgPntO2OgcwyXsPef7p0QkMQ6sL2Ak
         +gxnV3PlCQKMYhWSm5hV5v1HtFtoHfzKaJXRSY0//2Zt+pCVVvSWKTfKvPsGerN63JIN
         Y/657wH++itmchOqP2usXqZCvfhHdCSfyjvliuPGl4QlX9SjiAKpCDKmrDUBFY0xhRFD
         06BQHJFCZjNarp+m3ThNUJszlQISdl6JGwEN8jizz9PMIf68cf/iU4DZs18BogH0eIVy
         +nBw==
X-Forwarded-Encrypted: i=1; AJvYcCUrTBIe2boWdezfp5I3sWzVLwFizGfj5nsS5bNKxgevlIoRO4hQieJumAKPSV8pPQd5Cu01aEcHVCoVncr4i8ogQb09ZPR01sp1sLgdhpHONWxdDGyZFN83lpoo8Uiu1bDEG9cWQzEQOQ==
X-Gm-Message-State: AOJu0YwlichFJGMBnClG3LFsI4KZj8Z7V8/09aOz2OfHUvw+gvish3Bv
	8Wwv4HX090k2BiEkQDS5lD6XQ2JWr7eF2AaXn9jKCKAW+XIZ6MJWfw4lV879
X-Google-Smtp-Source: AGHT+IGaNADSHdFncEfR/LWfbyCwmjp0o5rxbAapZy8J6iNa5dKZ3vsRFEkgrPD+a1CNTYdARh80Yg==
X-Received: by 2002:a17:903:2406:b0:1db:a6b9:a311 with SMTP id e6-20020a170903240600b001dba6b9a311mr3070617plo.41.1709664048799;
        Tue, 05 Mar 2024 10:40:48 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902e75000b001dc6b99af70sm10896612plf.108.2024.03.05.10.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 10:40:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-kselftest@vger.kernel.org
Cc: David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 4/5] arm64: Add support for suppressing warning tracebacks
Date: Tue,  5 Mar 2024 10:40:32 -0800
Message-Id: <20240305184033.425294-5-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305184033.425294-1-linux@roeck-us.net>
References: <20240305184033.425294-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for selectively suppressing WARNING tracebacks to arm64.
This requires adding the function triggering tracebacks to the __bug_table
object section.

To limit image size impact, the pointer to the function name is only added
to the __bug_table section if both CONFIG_KUNIT and CONFIG_DEBUG_BUGVERBOSE
are enabled. Otherwise, the __func__ assembly parameter is replaced with a
(dummy) NULL parameter to avoid an image size increase due to unused
__func__ entries (this is necessary because __func__ is not a define but a
virtual variable).

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm64/include/asm/asm-bug.h | 29 +++++++++++++++++++----------
 arch/arm64/include/asm/bug.h     |  8 +++++++-
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/asm-bug.h b/arch/arm64/include/asm/asm-bug.h
index c762038ba400..6884089a7191 100644
--- a/arch/arm64/include/asm/asm-bug.h
+++ b/arch/arm64/include/asm/asm-bug.h
@@ -8,36 +8,45 @@
 #include <asm/brk-imm.h>
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
-#define _BUGVERBOSE_LOCATION(file, line) __BUGVERBOSE_LOCATION(file, line)
-#define __BUGVERBOSE_LOCATION(file, line)			\
+
+#if IS_ENABLED(CONFIG_KUNIT)
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR(func)	.long func - .;
+#else
+# define __BUG_FUNC_PTR(func)
+#endif
+
+#define _BUGVERBOSE_LOCATION(file, func, line) __BUGVERBOSE_LOCATION(file, func, line)
+#define __BUGVERBOSE_LOCATION(file, func, line)		\
 		.pushsection .rodata.str,"aMS",@progbits,1;	\
 	14472:	.string file;					\
 		.popsection;					\
 								\
 		.long 14472b - .;				\
+		__BUG_FUNC_PTR(func)				\
 		.short line;
 #else
-#define _BUGVERBOSE_LOCATION(file, line)
+#define _BUGVERBOSE_LOCATION(file, func, line)
 #endif
 
 #ifdef CONFIG_GENERIC_BUG
 
-#define __BUG_ENTRY(flags) 				\
+#define __BUG_ENTRY(flags, func)			\
 		.pushsection __bug_table,"aw";		\
 		.align 2;				\
 	14470:	.long 14471f - .;			\
-_BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
-		.short flags; 				\
+_BUGVERBOSE_LOCATION(__FILE__, func, __LINE__)		\
+		.short flags;				\
 		.popsection;				\
 	14471:
 #else
-#define __BUG_ENTRY(flags)
+#define __BUG_ENTRY(flags, func)
 #endif
 
-#define ASM_BUG_FLAGS(flags)				\
-	__BUG_ENTRY(flags)				\
+#define ASM_BUG_FLAGS(flags, func)			\
+	__BUG_ENTRY(flags, func)			\
 	brk	BUG_BRK_IMM
 
-#define ASM_BUG()	ASM_BUG_FLAGS(0)
+#define ASM_BUG()	ASM_BUG_FLAGS(0, .)
 
 #endif /* __ASM_ASM_BUG_H */
diff --git a/arch/arm64/include/asm/bug.h b/arch/arm64/include/asm/bug.h
index 28be048db3f6..044c5e24a17d 100644
--- a/arch/arm64/include/asm/bug.h
+++ b/arch/arm64/include/asm/bug.h
@@ -11,8 +11,14 @@
 
 #include <asm/asm-bug.h>
 
+#ifdef HAVE_BUG_FUNCTION
+# define __BUG_FUNC	__func__
+#else
+# define __BUG_FUNC	NULL
+#endif
+
 #define __BUG_FLAGS(flags)				\
-	asm volatile (__stringify(ASM_BUG_FLAGS(flags)));
+	asm volatile (__stringify(ASM_BUG_FLAGS(flags, %c0)) : : "i" (__BUG_FUNC));
 
 #define BUG() do {					\
 	__BUG_FLAGS(0);					\
-- 
2.39.2


