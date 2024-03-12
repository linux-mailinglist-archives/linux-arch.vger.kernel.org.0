Return-Path: <linux-arch+bounces-2949-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F0F8799F7
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 18:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4680FB22522
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 17:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B496913C9C5;
	Tue, 12 Mar 2024 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Np815lRI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2551013B7AC;
	Tue, 12 Mar 2024 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263016; cv=none; b=pkG008AzJ/eJeeCWAzcNlbsRmGygHvKUgvTPKJqaXDKOvOahEA6DifQCwwxXiYurLja/eU1OWaDZs+cfgUIa7iPfweFkL2yjfil/5o1HSWrBIwCSHC+vkGkQrvWSipcJo7YM5Gmd8/kGGrtXInVx6+ua4+RH8VgozJd/xhub4Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263016; c=relaxed/simple;
	bh=g8p6Ru/ffP1jzehPrw/CRaeaF2IOojZZQLAZrCdrRdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sN7OOfe+JLG0KKU0aJnM919UFfiRXeRqc8B4yQiTZV2bMEyKsEFgGmRmfdaWa1UT2dm2hkcQGve3asUCHAuoh6O4DHB033V6NKhpf23JLdfFpFyT8QTxW5xA4EMyzJSqB6N8NjY1rD1ps6ovYYYE5kd+yF3/ZduQnObcyvw2UFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Np815lRI; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29c52a90417so23575a91.1;
        Tue, 12 Mar 2024 10:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710263014; x=1710867814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaoPploMqkrEWkpIzUU4wfevhj/fOj8xGNuIym5RM4g=;
        b=Np815lRIv1esVZLfF7hP0nDH6Cwtd5VcAjgowzj5Jv30VHdAekxLSUIsXSMRfRFvKt
         gWVWDUwcS7UhA7mM9/ZvDlgooL6Kn5CmINGyeMfZ3/0T2u4NeNxmAD1mtFNN0VpGmPpc
         Xr07xfdSqx/1XqyxQfyO+5g77e3uzHVqWsuHp1JcuJluLPWkF9zWAlusYSQEq2JGXhyh
         IopLjqGxVbeVbOFAm3fLuuriP2Y2dcKCopMmLafpNM5Juh5OBz7+KGlesk2f1TT8SOVt
         iP+BhyHwm60728bW1zA+J/cWl28i+taJJIqGhdgsDKew8Jbo9B2o/t9ky1huyzvftbxQ
         zwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710263014; x=1710867814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QaoPploMqkrEWkpIzUU4wfevhj/fOj8xGNuIym5RM4g=;
        b=XHgJujaC3uGnih7J8p3EcOgGjmwHhqOhqIgThJEIb/UDbOauZDtDDbcvVlj3qUDKFv
         GLFqysh1cHJwVBdgr3mBR+E7eFITHJWH+AC+3TSLWA5ahKiby0r8YKnZRt8MtNTy3Hgb
         Fk0unAjWWx2E5GTC7XtwZgInyGIMoxmYLrmm1k8tgiyQqzyStVH7EKriCWmb3z8J0qD3
         OLZNnxUnX2bqMvGj68Vs1U4vHdjjp6yTwmbCvfrZdlDoYDcBr11PfUmFqsSlZf4rUU6c
         2crlVG/g8ucoI2UJWQgrcFH25auPPx2B9BDt+cnUBgDio+fFdv2liQqPOu4NijWVCIE9
         caeg==
X-Forwarded-Encrypted: i=1; AJvYcCWPh/j2tekCpXybHW/stK4T8EJtk6113qrelBArYRUTyK+JG5sRwbzNh+lcFm5APeR7UgcEgtfMI0UMh2bvPpF+I/yvLPsCMQHbzpWjD+vD0HYR4bQLW5NN9xylM78OvVXtcLZy04ZCpPeBvQKm3zG8vpke6KJ1XHWKshgpoc1MoACns6fe2Q8/HFyKkdQtUA8Pg9rtTGzf+zo/ukS4kF2KJAIJEofppSho8QdnvTtvyglVa2CG6jnHEEZCSuq/fC1E+gSAO9FwNONEZK0XX61PobAoTtSjsA==
X-Gm-Message-State: AOJu0YyMQ/8JxbcpceUDuj21EAaFJKIF0cNDsS6NEfn1um5Q55kK5mqz
	ISfutY3YWfBhNQ4lllcPm16hDOts6ovMgqtQZQyJlGa5biVWopA3zBFgx5Sm
X-Google-Smtp-Source: AGHT+IGp1mJ0KTZ+LQYMSXPX4xCWLkAXoeTNJUTBRzyrNk3iCGaW03oMbFoz7IlCFWta+THFx92xXA==
X-Received: by 2002:a17:90a:e514:b0:29a:9dd1:d45b with SMTP id t20-20020a17090ae51400b0029a9dd1d45bmr194372pjy.3.1710263013769;
        Tue, 12 Mar 2024 10:03:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e11-20020a17090a77cb00b0029bf32b524esm4052208pjs.13.2024.03.12.10.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 10:03:32 -0700 (PDT)
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
	netdev@lists.linux.dev,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 09/14] loongarch: Add support for suppressing warning backtraces
Date: Tue, 12 Mar 2024 10:03:04 -0700
Message-Id: <20240312170309.2546362-10-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240312170309.2546362-1-linux@roeck-us.net>
References: <20240312170309.2546362-1-linux@roeck-us.net>
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


