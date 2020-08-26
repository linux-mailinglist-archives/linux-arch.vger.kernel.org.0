Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E620253A90
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 01:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgHZXFA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 19:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgHZXE5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 19:04:57 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5D9C061574
        for <linux-arch@vger.kernel.org>; Wed, 26 Aug 2020 16:04:57 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id m8so1959337pfh.3
        for <linux-arch@vger.kernel.org>; Wed, 26 Aug 2020 16:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=UDBPswEp8dsJZvpDMzf+Lnp61jTLy0JiMIvkg5nGV7c=;
        b=kv35s8pKTBI23xLgCAsnllzYvNPlx33vVxi2a2BzSvdr1MB7mne1TIcU4a6cxG6BDP
         1nfbD7XtwHuG63CWpZBwlxS0kLcm4qPMTdpqC1vdG8/R6+4KdExuJTfSFIS0PkD0p4NB
         tZWHT/oLFpp7IQDmfaWv7e961Hg9SBH9lXhumew/TvZblgJwUuweM4XgSa0/N/ca1eaN
         nLu5EYWetjxiMPjBapE6+UKUy5WJq3ZSef/QQJ8bqPVoRdl4CsrOqbLDvEGNQk3CMs94
         EU0YZuM7r6caJ4lL/Igju1esqDtID+smTS55hS/19cORFvdDStKbNyl8jUiBLaXOv0qY
         AycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=UDBPswEp8dsJZvpDMzf+Lnp61jTLy0JiMIvkg5nGV7c=;
        b=bq/AQCyMIru/uuFKCLqFg+xwSLNrh9rr00PseEeVoGAPnaUlN4+hrzwyjmU1g1HXyu
         tUaUKFsBTy+hUxNZ9cSFm10NLH2a3WqhbmnfHCfxLfbDzB+kI0CY5mOBhq1zN64YT9mT
         WCIvnb2HT6WI5+N38op2PT71RRPhLAU020+YuK7QgMq1VBV6wwtr0vb822mALPG5vFmq
         l4//JM+KQXgzggVsTIwhJgjUiCq6TExLOKVi+z1oBrYaiGudSZ+SzCQ5yjFP3WsjxvLk
         OoezrFvNa+lV+dQB+xxqZBT6vxPHGPGko5/RgO10jMfN9W4SpRq0u//ihI14Qh9WjpPW
         srsA==
X-Gm-Message-State: AOAM530zS+ZttZIuyV5bQHlI2JDzl5TKJhHTvTCLeJ3k91F4ncHk567W
        kichWWAMLJwDN8j/dhfGGpykUpiDBxygKA==
X-Google-Smtp-Source: ABdhPJzBihMZtBeOoCyuSPhjS2tRl9yjA57nRHdBYq/tHLcC3uZ5AHYYynrONW+i3TjThuTzFXZTww==
X-Received: by 2002:a65:6286:: with SMTP id f6mr6825110pgv.0.1598483096992;
        Wed, 26 Aug 2020 16:04:56 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id x5sm248639pfj.1.2020.08.26.16.04.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 16:04:56 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     arnd@arndb.de
Cc:     linux-arch@vger.kernel.org
Subject: [PATCH 1/1] include/asm-generic/bug.h: add ASSERT_FAIL() and ASSERT_WARN() wrapper
Date:   Thu, 27 Aug 2020 07:04:53 +0800
Message-Id: <7d916ac76e7823efbf88828dc6c61737555434a1.1598481550.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <2a79d3f5feb628ab318fcebe004e398b8124ce46.1598481550.git.brookxu@tencent.com>
References: <2a79d3f5feb628ab318fcebe004e398b8124ce46.1598481550.git.brookxu@tencent.com>
In-Reply-To: <2a79d3f5feb628ab318fcebe004e398b8124ce46.1598481550.git.brookxu@tencent.com>
References: <2a79d3f5feb628ab318fcebe004e398b8124ce46.1598481550.git.brookxu@tencent.com>
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

