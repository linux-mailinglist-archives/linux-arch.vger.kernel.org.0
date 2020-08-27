Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E280B254347
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 12:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgH0KOh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 06:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbgH0KOd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 06:14:33 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A504C061264;
        Thu, 27 Aug 2020 03:14:33 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i13so2378216pjv.0;
        Thu, 27 Aug 2020 03:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=UDBPswEp8dsJZvpDMzf+Lnp61jTLy0JiMIvkg5nGV7c=;
        b=IEc8i4WXG7VzIHAYfO/I4ZUn50a19U3Skre3p313rR/NTl63yFjB6KBTnjUJX8D6Kp
         BR/AzeOhZldZO4jcHkWxhaR/WCoL3L4YNFsEcaroVM+JdJMT9OuXTuLon+xix17RrdAY
         EqxRWxXWYai5vvLaOvq4jmZHj2FmjidTHZY0JmDstloOio8vKBui2/KJEpO19apFWSCH
         uWe4hMCsB4prBK8khu/ZyKAazifgaZR4n6+v1BsvgcIRYU+obtRqoEaJNHFl+ljXaRTU
         3z8b/5rqsX64BSNcz7iT8dXJDFstMTCaj3K/TyWxagcqLGPpjhuV8T5LeBKfbGXcFQQE
         gMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=UDBPswEp8dsJZvpDMzf+Lnp61jTLy0JiMIvkg5nGV7c=;
        b=HCX+LtM32D3yG/z1GppF6pQuY4ihgw2rn0oyrNrWXIvgdYAainWm7IFN7T81F8ieZ5
         FLRnfVqDe2ty/OS0LDfdFel0XdvKZQITcKZ3W77E6Iqn1C8tToDDZ22W+3/0F+d+oJ9F
         DTZgLftmAx+qnYwN9AjWbUzxeygGQ/InBEmInBXBa11IaSgkEn1t9PVDTAjTtV+ZB4Vq
         ZzT12N0frjVdYZrLwB1APnW8t74rzzDeczWA+8xx9jXW2Ts+TpoNN6r2S5378BiN5utU
         CZe3M61lI9R22c2LNCHtMQI1dXnNWL/OOOmajWHRyIhY36/Cy/EdKPizy562hi8/CKC+
         vECg==
X-Gm-Message-State: AOAM5308jJ+R3/pspIxBo//8ATOpcFZw/7U44Jb3r22i1bNQFhpa1ayj
        Ez5DbFYRe2LtUYl+hFoDPeA=
X-Google-Smtp-Source: ABdhPJzLg4CY2SoSbumHIwYY7nDV2bxZKmFGfhTZXxFbtqm1sRoM6+MiaEI011ZtxuYN9rfCzPOX2g==
X-Received: by 2002:a17:90a:a10c:: with SMTP id s12mr10079245pjp.32.1598523272672;
        Thu, 27 Aug 2020 03:14:32 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t10sm2333434pfq.52.2020.08.27.03.14.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:14:32 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     arnd@arndb.de
Cc:     rppt@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/23] include/asm-generic/bug.h: add ASSERT_FAIL() and ASSERT_WARN() wrapper
Date:   Thu, 27 Aug 2020 18:14:06 +0800
Message-Id: <7d916ac76e7823efbf88828dc6c61737555434a1.1598518912.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1598518912.git.brookxu@tencent.com>
References: <cover.1598518912.git.brookxu@tencent.com>
In-Reply-To: <cover.1598518912.git.brookxu@tencent.com>
References: <cover.1598518912.git.brookxu@tencent.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The kernel has not yet defined ASSERT(). Indeed, BUG() and WARN() are very
clear and can cover most application scenarios. However, some applications
require more debugging information and similar behavior to assert(), which
cannot be directly provided by BUG() and WARN().

Therefore, many modules independently implement ASSERT(), and most of them
are similar, but slightly different. This makes the code redundant and
inconvenient to troubleshoot the system. Therefore, perhaps we need to
define two wrappers for BUG() and WARN(), provide the implementation of
ASSERT(), simplify the code and facilitate problem analysis.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 include/asm-generic/bug.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 18b0f4e..28f8c27 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -174,6 +174,31 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 	unlikely(__ret_warn_once);				\
 })
 
+/*
+ * ASSERT_FAIL() and ASSERT_WARN() can be used to check whether some
+ * conditions have failed. We generally use ASSERT_FAIL() to check
+ * critical conditions, and other use ASSERT_WARN().
+ */
+#ifndef ASSERT_FAIL
+#define ASSERT_FAIL(condition) do {					\
+	if (unlikely(!(condition))) {					\
+		pr_emerg("Assertion failed: %s, file: %s, line: %d\n",	\
+			  #condition, __FILE__, __LINE__);		\
+		BUG();							\
+	}								\
+} while (0)
+#endif
+
+#ifndef ASSERT_WARN
+#define ASSERT_WARN(condition) do {					\
+	if (unlikely(!(condition))) {					\
+		pr_warn("Assertion failed: %s, file: %s, line: %d\n",	\
+			 #condition, __FILE__, __LINE__);		\
+		WARN_ON(1);						\
+	}								\
+} while (0)
+#endif
+
 #else /* !CONFIG_BUG */
 #ifndef HAVE_ARCH_BUG
 #define BUG() do {} while (1)
@@ -203,6 +228,14 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 #define WARN_TAINT(condition, taint, format...) WARN(condition, format)
 #define WARN_TAINT_ONCE(condition, taint, format...) WARN(condition, format)
 
+#ifndef ASSERT_FAIL
+#define ASSERT_FAIL(condition) do { } while (0)
+#endif
+
+#ifndef ASSERT_WARN
+#define ASSERT_WARN(condition) do { } while (0)
+#endif
+
 #endif
 
 /*
-- 
1.8.3.1

