Return-Path: <linux-arch+bounces-3163-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A333E88B534
	for <lists+linux-arch@lfdr.de>; Tue, 26 Mar 2024 00:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A6C4BA2D33
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 18:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D51A131747;
	Mon, 25 Mar 2024 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCgMpIAH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C20C12FF6D;
	Mon, 25 Mar 2024 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389190; cv=none; b=pXIn+atYAGDXLIMtxhO4gMp77NRxs6kQ9e7/ykSXtJibfWERYfWJLCd86fsMPB4SOwNokzdd8RDzzi/TACT64WDcic5+vNAYZ6V4JYxfxkvkemMfW0w5nvnY+7d0NJQI6UvxrXc3JmBXNegpf12hLA2wVRD8VdhgnUPkB7mNRZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389190; c=relaxed/simple;
	bh=Fj2UBHeslHbshTD9KUbCipe+qDm2mdE6OyhRYtHWfQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mdHvgo4BQT0DOk9HlWAQ6CH9XrbOaCQmteS4CPZriGv7wFrgEJoqYvaaB+X074twT3zmUXB2BOC8UaqPsBCqfE1pPMGA3ayCz+2azEy4FOw+pnk99KjSMyCU7sykHU09eLCJ3z8Jn50ThoyPJwmr+KqjQM2IAmDVYY88NeAniH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCgMpIAH; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so2493095a12.1;
        Mon, 25 Mar 2024 10:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711389188; x=1711993988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29uUGQwcrU/fnHD36qAwKUJZLrgVV8mBHbW4bk0/nVs=;
        b=lCgMpIAHdsOqhIZ9KlJMTqsBF6t6ZuvoiUoL0mPFWuS6A0zTxkxKUqSPtESPQIo3+8
         f0YB668MtLGmFgDAITf+2PAJNYUjhrByJaGcMAJpMZir/tqgN9KOLDt+/OVx0WqYWRcy
         kspZo8EWC+RRlRu+XTeD7legVGfy0wOlkcKOPMCL+NUvZUPchGOlqfyBvX5NFRa0fFz6
         /9WkdP+nPu3qaAv/BOFEQKQ2LLYrMG79cb7ibhCumthcujgJIfvfEoxMKEjv843s2V07
         FLulX8mvHrrjSCeqF/46G1AJnVf+9GEQdEuXA/0Qwf5sn1yZJhnY15SKY2lpq5lfUf/f
         PITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711389188; x=1711993988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=29uUGQwcrU/fnHD36qAwKUJZLrgVV8mBHbW4bk0/nVs=;
        b=Xl0HDK07L2IkfcZ1FNPlB4sZMPIUj5wn1rLvUV9PoT5zres2bVu9x6Y6KzmXJ2U7qW
         aptXgAx2dTgLjsskq9FhBckiv6gK9QnURiayX/w2vq42lhdAV9JuTkRH4I5ALWYobJim
         Oek7U7u/AeNn2FrjNF2bCeCQuWSFEZ8ZPo3skXGzTeD+1SToeqXa9XkxTrLurfygP9SI
         LSc9zkkImo297nGZ4/4DhXuNX/d2pzbdofRVHUG0Ib9lb5mpLybhqudA/MgG8vwPxQzU
         aN/Gyj2NqQyvAVrqH91JuwVYNLI+pgx+wLClHQT3+2tlAmLctMGTQSVUrc3AfNrbEVOK
         eCEw==
X-Forwarded-Encrypted: i=1; AJvYcCVyahhdoq+Gkne1R5WigcbYQMCnZID1thQKReAbC9YjIEZ7vOTjDvpEODPMXbgsNA7l9nDHSZZg67dj0505ZAl9MJ/pc03FtboiAlXp77hBXhnhITBCpVip5aFN0SX+O3MqAITsbAspGbtqmAIbjSDQwdia+ihRv8lmIa5Ec5hpQzmUKnAim+2bT6Z9TGd7ldq6cwJ1GqMezxSZvadQc8g+1oNwM+ojtzVA/XSaLMGIwKhTEhJ9VJEWykafGRbvOqIp/XbkxNm2cxviweZKk5WtsO2hfHNDv2zJkQS0czZQkrcHfyM+6YCS62mVHfYo+w==
X-Gm-Message-State: AOJu0YwskqacjEgB29oz0Y90VD0l+tq/w2Vss2+OuRoTKbFgx3jYE+HH
	TR0FiPi5Ht1pBL95E1FgMUSh4uG5uJj1fpmWh5JKWgeA5j0KKwqwBf1P87++
X-Google-Smtp-Source: AGHT+IE/thXvavJDDiOrkU/GUVbH11qVlMEIp4a5f7HZiiXWgBurXkKTZ7C3J9NAO13pjibm2KTwhQ==
X-Received: by 2002:a17:90a:4383:b0:2a0:3c2b:7f22 with SMTP id r3-20020a17090a438300b002a03c2b7f22mr5502580pjg.29.1711389188187;
        Mon, 25 Mar 2024 10:53:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ee15-20020a17090afc4f00b002a03defa1b4sm6076305pjb.14.2024.03.25.10.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:53:07 -0700 (PDT)
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
	kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	loongarch@lists.linux.dev,
	netdev@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH v2 08/14] arm64: Add support for suppressing warning backtraces
Date: Mon, 25 Mar 2024 10:52:42 -0700
Message-Id: <20240325175248.1499046-9-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325175248.1499046-1-linux@roeck-us.net>
References: <20240325175248.1499046-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add name of functions triggering warning backtraces to the __bug_table
object section to enable support for suppressing WARNING backtraces.

To limit image size impact, the pointer to the function name is only added
to the __bug_table section if both CONFIG_KUNIT_SUPPRESS_BACKTRACE and
CONFIG_DEBUG_BUGVERBOSE are enabled. Otherwise, the __func__ assembly
parameter is replaced with a (dummy) NULL parameter to avoid an image size
increase due to unused __func__ entries (this is necessary because __func__
is not a define but a virtual variable).

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
- Rebased to v6.9-rc1
- Added Tested-by:, Acked-by:, and Reviewed-by: tags
- Introduced KUNIT_SUPPRESS_BACKTRACE configuration option

 arch/arm64/include/asm/asm-bug.h | 29 +++++++++++++++++++----------
 arch/arm64/include/asm/bug.h     |  8 +++++++-
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/asm-bug.h b/arch/arm64/include/asm/asm-bug.h
index c762038ba400..c6d22e3cd840 100644
--- a/arch/arm64/include/asm/asm-bug.h
+++ b/arch/arm64/include/asm/asm-bug.h
@@ -8,36 +8,45 @@
 #include <asm/brk-imm.h>
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
-#define _BUGVERBOSE_LOCATION(file, line) __BUGVERBOSE_LOCATION(file, line)
-#define __BUGVERBOSE_LOCATION(file, line)			\
+
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
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


