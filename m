Return-Path: <linux-arch+bounces-2816-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6F08726D4
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 19:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FAAB1C275BA
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 18:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D51312837C;
	Tue,  5 Mar 2024 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMRsMfof"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC80086657;
	Tue,  5 Mar 2024 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664053; cv=none; b=GIP+Ah348hFqGnxwFrHdh2a2Wjd32xzLdp9gJ9bII1CiVEYZizU5SF2uE+qY/0iuWp2BRH8WxiAt6l3HX76CPcK7YZsMSoa14Bb90SW/Ikjl6CnT2OU+d4Y2afhDqxzVdiaNpvVzk+AqFAfYpFyW8GDrQlzzkyiDIXXBpqEQUQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664053; c=relaxed/simple;
	bh=noyTquE0oeh4bMQGWb9TTkaxmt5wl0t40DilAAM+zUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T9l/81bRW/K/f7DEyIIx6+XJtbYF0TC2VCrWOAaCW7JhhoQf1gXcOcGhi+ySyvEYqQtie1R5VHXKlkAsNRxzSdlVjyB3X/gylt6nb/hKBwGUciW3vDdJfLaux+SEq4jhaeqi0B4+o4n9qe5Q+fDfC7PulKdhDJMHjdRYmdWCy6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMRsMfof; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e5d7f1f25fso2642904b3a.0;
        Tue, 05 Mar 2024 10:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709664051; x=1710268851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0gUmPSeCCdcwdwoiei/E0Jjh2VpvFQYRxx27Vw8kHc=;
        b=PMRsMfofxnZjQ1ufzMKFBDkoWmX7tK8N5DIcd0g8BMZFOrVUe3UtQdYTBA6isL1SyQ
         vPl481VPJYdET9kspk0YxUY97lJaVsgxcolimnfGCxcS1vUKqWM4STqvp2ueSpJSJpCp
         Jab0mZwzs8aYYl9sl4RCnFb1T4BD/E61CD8a/ZnSyO+xkQMeVtSllNdOvSaELU1Sbbod
         0G/0RVFc0/yspWIExHl7mdnV7KPkRpy2xz5vZVD61mBnpoIeEm2OPTvIs7RvHXKekYgH
         zOwDnGxwT0X4yYoo18Ge937b+Q38fMpzHHGYGcFmFb43X6kes0p5WJ7F1lBpqrfX99Qq
         M+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709664051; x=1710268851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X0gUmPSeCCdcwdwoiei/E0Jjh2VpvFQYRxx27Vw8kHc=;
        b=gy7tjKJlI77fZlrMzfrNWDMwBVDZRcuRWhFCIB3rbc4JsxazH5PWyVqhda1EK49bPr
         5ZHM7fO9jZCqadOri6dIwoEKtW+IE5JMogju5WB+44LdqIyP50XgtR67v9uuFZSsqmnv
         T9+qpYuTvWYucf0TCUARgJYL0xly1Q6ENV6Dew8J4z62CxGFZb7EmjVa/SB8SAalotJR
         +4YPIRnhjWxPynYSF3h/a4PsUhPA2EHh+XilAZweWx/PKQWs44NI0dmT70fOsGU9FHs7
         6p5KqCwsm7kMpI65IZT86YqAMOGNFL6czu8drjNn7amLbWjDHBuj5ZvRZF3se0ux0TQz
         b6PQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7TXW0ZpXWefkSjEir7ggGTZkUn6NK9sK9ubygQcOBuwrriNSpF9O6yzrzI0MfSOuq24Va2yLfrsaH/9vp6RCxK6BTT4PKtMPxY0RkMOmA7KUyapMBRurZQu5SIaxWuCVGB/TrKdcjUg==
X-Gm-Message-State: AOJu0Yxsn0SSYZsdKsHGxzMELOuUxMoCC3ORrBwQqtceKhyMLppbsAWe
	BARWIl9yc+VecDLjCRZC+aaooU8mM4aApWxbuSammPpgNFmUhThAKAlsLIZH
X-Google-Smtp-Source: AGHT+IEh5cNC1e3ALin9EYEqP1JMKTTzvFIxop5uA7PitJpNaz0+Cvy9gmZD//Z/el6YtUoATah/OA==
X-Received: by 2002:a05:6a21:3403:b0:1a0:e089:e25e with SMTP id yn3-20020a056a21340300b001a0e089e25emr2819250pzb.46.1709664050630;
        Tue, 05 Mar 2024 10:40:50 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p2-20020aa78602000000b006e24991dd5bsm9538237pfn.98.2024.03.05.10.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 10:40:49 -0800 (PST)
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
Subject: [RFC PATCH 5/5] loongarch: Add support for suppressing warning tracebacks
Date: Tue,  5 Mar 2024 10:40:33 -0800
Message-Id: <20240305184033.425294-6-linux@roeck-us.net>
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

Add support for selectively suppressing WARNING tracebacks to loongarch.
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
 arch/loongarch/include/asm/bug.h | 38 +++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/loongarch/include/asm/bug.h b/arch/loongarch/include/asm/bug.h
index d4ca3ba25418..25f2b5ae7702 100644
--- a/arch/loongarch/include/asm/bug.h
+++ b/arch/loongarch/include/asm/bug.h
@@ -3,47 +3,63 @@
 #define __ASM_BUG_H
 
 #include <asm/break.h>
+#include <kunit/bug.h>
 #include <linux/stringify.h>
 
 #ifndef CONFIG_DEBUG_BUGVERBOSE
-#define _BUGVERBOSE_LOCATION(file, line)
+#define _BUGVERBOSE_LOCATION(file, func, line)
 #else
-#define __BUGVERBOSE_LOCATION(file, line)			\
+#if IS_ENABLED(CONFIG_KUNIT)
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR(func)  .long func - .;
+#else
+# define __BUG_FUNC_PTR(func)
+#endif
+
+#define __BUGVERBOSE_LOCATION(file, func, line)			\
 		.pushsection .rodata.str, "aMS", @progbits, 1;	\
 	10002:	.string file;					\
 		.popsection;					\
 								\
 		.long 10002b - .;				\
+		__BUG_FUNC_PTR(func)				\
 		.short line;
-#define _BUGVERBOSE_LOCATION(file, line) __BUGVERBOSE_LOCATION(file, line)
+#define _BUGVERBOSE_LOCATION(file, func, line) __BUGVERBOSE_LOCATION(file, func, line)
 #endif
 
 #ifndef CONFIG_GENERIC_BUG
-#define __BUG_ENTRY(flags)
+#define __BUG_ENTRY(flags, func)
 #else
-#define __BUG_ENTRY(flags) 					\
+#define __BUG_ENTRY(flags, func)				\
 		.pushsection __bug_table, "aw";			\
 		.align 2;					\
 	10000:	.long 10001f - .;				\
-		_BUGVERBOSE_LOCATION(__FILE__, __LINE__)	\
+		_BUGVERBOSE_LOCATION(__FILE__, func, __LINE__)	\
 		.short flags; 					\
 		.popsection;					\
 	10001:
 #endif
 
-#define ASM_BUG_FLAGS(flags)					\
-	__BUG_ENTRY(flags)					\
+#define ASM_BUG_FLAGS(flags, func)				\
+	__BUG_ENTRY(flags, func)				\
 	break		BRK_BUG
 
-#define ASM_BUG()	ASM_BUG_FLAGS(0)
+#define ASM_BUG()	ASM_BUG_FLAGS(0, .)
+
+#ifdef HAVE_BUG_FUNCTION
+# define __BUG_FUNC    __func__
+#else
+# define __BUG_FUNC    NULL
+#endif
 
 #define __BUG_FLAGS(flags)					\
-	asm_inline volatile (__stringify(ASM_BUG_FLAGS(flags)));
+	asm_inline volatile (__stringify(ASM_BUG_FLAGS(flags, %0)) : : "i" (__BUG_FUNC));
 
 #define __WARN_FLAGS(flags)					\
 do {								\
 	instrumentation_begin();				\
-	__BUG_FLAGS(BUGFLAG_WARNING|(flags));			\
+	if (!IS_SUPPRESSED_WARNING(__func__))			\
+		__BUG_FLAGS(BUGFLAG_WARNING|(flags));		\
 	instrumentation_end();					\
 } while (0)
 
-- 
2.39.2


